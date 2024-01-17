Return-Path: <linux-kernel+bounces-28415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F182FE43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40FF1C25651
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4A10A2C;
	Wed, 17 Jan 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ub7fms35"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F464439;
	Wed, 17 Jan 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453810; cv=none; b=Oz4z4KgDA3Ul96S4C6j6tIPPJuZRhdGbo+w3QfTZk1DMRUK87mUrfeAmmdU0P3CDCoB41MHPBuoD2iOqVhg945faaZLjvuN7zaJxh7jhCQzeIPCqbSmR6XnitBFt5Q6dcKyqPklKfSzb0/DOOxsO6KZmOFk/iSGsJ3VkHWgFRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453810; c=relaxed/simple;
	bh=BL5aX056bFvjCHUcg1YEdagctUIsMeId5BQPF5YJ4yk=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=inGGmQQkFqo9dI8L+TWk1EyHXDlsnd4YkNGWr5rxnjs34yVtmc1SsQwTBGWCLAQuezlmh+8+B9IIohvmiilSqfmHRi3iALn/LMsmdKy7MMa2YOpyc28Lr3izui8doGXyOcJ4+xiVN1ahlMmrh9HmjSvJ4dsAUtTXY0rNtKfez1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ub7fms35; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D/gE019ZmSvllJYQDA3FYN3rYxglmvvmTrq1Zs40Zjg=; b=Ub7fms35Rr/W6I8goOAVJ/n37j
	93C1RMl31TxjlgXAzSRAoUug9b1v+9mpr93BhuQBPb5XZ+aEQQ3eSj8epa1n0d/lJt5aiy+DwIHgY
	olICA6Z3j9WCx/36EY48o+bMg85VkHC7xnwNLrFaDRLaxDQbT+rf4PzzBK5cvtdT0F1m6+SzmFREt
	lui6vzNfq8FC/3xrMbJhFUgG3SISwCtEtGl5yJI9H14+iZRu6c9SCWwRXqiESh3LJ7KDWrBJOV2Nr
	sWKOsXCL1DQro1d+2jsVKfjFg3i1o4tylfEqH0LyJJ6eCKKTQfmPeGzbobPbLEHgDpPgzitt/rrW7
	ahNq5Q7Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRU-00E6zu-0o;
	Wed, 17 Jan 2024 01:10:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <paul@pwsan.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 09/13] ARM: OMAP2+: prm44xx: fix a kernel-doc warning
Date: Tue, 16 Jan 2024 17:09:57 -0800
Message-ID: <20240117011004.22669-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in a kernel-doc comment to prevent a
warning:

prm44xx.c:421: warning: expecting prototype for omap44xx_prm_clear_context_lost_flags_old(). Prototype was for omap44xx_prm_clear_context_loss_flags_old() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -407,7 +407,7 @@ static bool omap44xx_prm_was_any_context
 }
 
 /**
- * omap44xx_prm_clear_context_lost_flags_old - clear context loss flags
+ * omap44xx_prm_clear_context_loss_flags_old - clear context loss flags
  * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
  * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
  * @idx: CONTEXT register offset

