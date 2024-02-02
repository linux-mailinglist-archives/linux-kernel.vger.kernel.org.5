Return-Path: <linux-kernel+bounces-50367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86525847815
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90EC1C2457F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432512C7ED;
	Fri,  2 Feb 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2RADGBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD59129665;
	Fri,  2 Feb 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899206; cv=none; b=uiaQjk/kk0DWd7NidMsocHvlNbwyNaV2P98XiQuV5CY+8m84augHUK4LX+J/XjUfGyVddFBkG9UylTTLy2Wh70jtNx/x+8Ec7MVKOk/mTGKieINWZvyGwhwQsmO56fo+i/Y5L5/VhlfipVlflDnkXMwBbnfr8keBDhT8NoaZdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899206; c=relaxed/simple;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcjgx8/Z9YOPDo0VCpjPSUG41sY4ceSr7fwvn8P7W908tu3uOyGjXTgUsGCBlncITF13kR2Iej+nQ5dY+fNV5y++aU2toGGcpDgMogafCARdrwjlVKqlBGI6Z2mLsoqJXvAGGKPC6anOgjyG/Ca5yWdWO5DLy3wRRI4kSLikXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2RADGBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60487C433C7;
	Fri,  2 Feb 2024 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899206;
	bh=YBoPwJM6qtI/5Knk07kvYlOrcnQuA9SJRJCav45K3Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2RADGBA1CTwbflqSaKY4e0BsVaJfgw/yVR5iyfjB4mA+m+xjb6hGFktFNJbzbQpb
	 rSTHcvUV2vtkh4G18AH1ueR/Yyac1DlFoTsba0j0HCCoanC/mf25cLeo6G48euOinQ
	 8FI46YAIXgDXWYUTPkneoURZvN5j3xZa+W+lUhlG8B6af748ps31H2Ez+LGujXKrfS
	 P7Jp0oJXodaEKTA3F3+K/ErY6qSlrCehtbS9rLwKZXGDF9d6tg256TwmVxDASTL6UB
	 HuFMs9LPF1BEDL9BAK5l7I3tojY9RGUSEuXoq4C0E+GCKxEWKJJ4jMAbwmxM4C/Pqm
	 JZ3hxCVWgL0qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huang Pei <huangpei@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 22/23] MIPS: reserve exception vector space ONLY ONCE
Date: Fri,  2 Feb 2024 13:39:18 -0500
Message-ID: <20240202183926.540467-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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


