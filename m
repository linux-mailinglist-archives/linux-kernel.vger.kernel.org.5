Return-Path: <linux-kernel+bounces-50416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FF8478B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C7C1C25685
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E841522F9;
	Fri,  2 Feb 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEaUxEog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003E1522E8;
	Fri,  2 Feb 2024 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899311; cv=none; b=XWWGL6Q0noKtn6LET65CN3nPTbhMN0keR3OtWCK09ZgJh5utnOxzQ8waiLKpxuWv3Sv/6Z99Xb7STaGVc5AEK+i7ZepKbXD8jypmDXKeBBRylq3pFuIYJC3m67QCElfz7zNcQugHr59HO4WzwMJWBxAsPqDXbVffS9A0FWIUXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899311; c=relaxed/simple;
	bh=xzu1Hql6j8wvA8ZUmWm2D3Z0V3Eg2w/MEwiQZZdwUhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqYU7IlmL47BQwFywUqrRJDIjpjJPLWi7xlvHTlqZwhts4Aqwy9UcmLqaU5rFrvFDnFv2yByro4BQah6wJ6gRPdzujzCXFEFAt7hKcfmvnRxpnjpb0iIxDLTQB6Zlk51saSga/3wUogIdGn/yXih5n857qOYIidUU9EwtFpIdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEaUxEog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9822BC433C7;
	Fri,  2 Feb 2024 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899310;
	bh=xzu1Hql6j8wvA8ZUmWm2D3Z0V3Eg2w/MEwiQZZdwUhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEaUxEogEFbCBeKhirRsB5fyTcm9uC9tPcxihvQZkcDBBgjDlM4DINxBN2ir6HVix
	 rfvqh2KKCMGJfrq4Y0qMjVBkQv0YpE+CcZ4mNmxnPovLGSEXLh1WzdMewvyC8Jz/+x
	 2HWFGkpAKAcpCqVhKvP72eaLE0nKB1OkJn2r+fbklxEW1Nf8KANu2sYCFg8TJQt9rR
	 NS9+Cl1xxHyMiKV6yIeyTAbObL24wzifwfZtTLm32uhB0NLpLsmfVB7IYAngHG25Sj
	 c8uuA0MZrzR34BUza6zMNYUzZmtsWX2tg88sG/cR/pUE8gZsswNKcbqOK3/efdRySW
	 JMiP8UzXzJQUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huang Pei <huangpei@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	bhelgaas@google.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/11] MIPS: reserve exception vector space ONLY ONCE
Date: Fri,  2 Feb 2024 13:41:24 -0500
Message-ID: <20240202184130.541736-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Huang Pei <huangpei@loongson.cn>

[ Upstream commit abcabb9e30a1f9a69c76776f8abffc31c377b542 ]

"cpu_probe" is called both by BP and APs, but reserving exception vector
(like 0x0-0x1000) called by "cpu_probe" need once and calling on APs is
too late since memblock is unavailable at that time.

So, reserve exception vector ONLY by BP.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index afb2c955d99e..5c01a21a216b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2001,7 +2001,13 @@ unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
 {
-	memblock_reserve(addr, size);
+	/*
+	 * reserve exception space on CPUs other than CPU0
+	 * is too late, since memblock is unavailable when APs
+	 * up
+	 */
+	if (smp_processor_id() == 0)
+		memblock_reserve(addr, size);
 }
 
 void __init *set_except_vector(int n, void *addr)
-- 
2.43.0


