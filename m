Return-Path: <linux-kernel+bounces-50404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F06D84788B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B1D1C23842
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CBA154C11;
	Fri,  2 Feb 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTKVD9OZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6614E9B3;
	Fri,  2 Feb 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899284; cv=none; b=uO4IVptRXJIE27w/NeMVnlAR8+hD/5eU94c5rA/j1Vt8P6dRS/l9giIemGWbuVwNKtp5mjDPs9ycpWD+bWLxJqbD1YzYzVYB82IkI5+Afxc+xbd5Sih2yqXJiMBhmuqngIUcAV2EZ7MAffG9BacshzCzh2hd+aot4OKZacQH0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899284; c=relaxed/simple;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1msz6j1E9dO5ibXotzF2EtxUViTkcqs4TITc0kUNDo1lcOZGbxPB8OISb3c2zhxCpByj8io4JGXWfnEScQwNXzTvJVlpD2K5O33Xe8KCzh1wnY+UMb4eKugxwMEgb4HW+hI3ad+HE4nWCunbKaCeX46zVcPH9JR2biojjFeCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTKVD9OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBBC43399;
	Fri,  2 Feb 2024 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899283;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTKVD9OZNE7kNzo65pxxCgRL+chsVLJyXIejxpTJ63+n9HcE2/KArrmX1KcLSq8q6
	 4SvKR7q7IToZeEKtiCiNcKUfm5f68EfYDd5gS/VAwHbAg6oCrS+ncWQrGEsZ2YyJnS
	 6LFmmpGHHibY3TmCv4ENFtQnpflvRcpkGBkUdYpkUmJFvNPJxy9gkeHe98KwLRVqHi
	 779984euvdYRTyJwDHBoLDjt75M5FkBhb2NoBFDb/5DNs0Zrk1kpT/h/Ye9Ed6pF8n
	 rStStr5Awjc6A50kaFV0YJrZ+aSmN0OeuOteKaPoaFQFfxKodwJdvkfx763rj+Z/Gc
	 07LDHlgFRB9RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huang Pei <huangpei@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	jiaxun.yang@flygoat.com,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/15] MIPS: reserve exception vector space ONLY ONCE
Date: Fri,  2 Feb 2024 13:40:51 -0500
Message-ID: <20240202184057.541411-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
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
index 246c6a6b0261..5b778995d448 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2007,7 +2007,13 @@ unsigned long vi_handlers[64];
 
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


