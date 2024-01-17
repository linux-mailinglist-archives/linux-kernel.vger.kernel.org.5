Return-Path: <linux-kernel+bounces-28412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B782FE42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5BE1C2566B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1510A19;
	Wed, 17 Jan 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a0Z2lvui"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7F17D9;
	Wed, 17 Jan 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453809; cv=none; b=O8KsZhPzw69oVqzzWhJ5Dn0oRYwYs12iARQ6o6FFlSKUSc0JSHA54I6WKMMJP0Gz7mdtVx6oLILyuxLPQanNovBy5ouimp0xzMVksn85SajZi/ik7j4tad8/S7GEuvGaJy0xfC6F6NF6KPhJyv5Sv1LWxauQX6cywYLgKbkzFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453809; c=relaxed/simple;
	bh=j6+RY7q13Y+Hd0Y8k8ykBta7KjT/Cne7jir5J+hsisM=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=tkzPFCaj+JAHIlC+wRCJgxWnCdAtJqP0HCBphn+UII25JZPKe88OmVSHEH04lC2HBeLehAhB/8pxd0bz5CON/hdWvi4ZXa8i3X0/R7G+cqkILL6h4kK4pEtp3RqGC/sIgMCVGUh60JtNKIP8BoKEtKfUWJjD3JngZ4yDAe5hNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a0Z2lvui; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=sGF6uJaEvsCufyOMbTpUXxplWqfaxnjoJpE5oP5VF1w=; b=a0Z2lvuiJXK7spdORx6yo8UPiY
	S6VfPLuqkrMN1Rmy13cKrcTA9DQzC1NzIR0UCgmxeBtvg04Bw4MDskW4H5ehtawyqAWki0S4gk357
	eGBfayq7HlV+RdUjQLa+uPqpi3lGP/r4dG9ASjuNUC1COkKNFD9SWP2TFNO4DpUfiJC3jieNojyA/
	1TQy4S2RfrhwEACzbiuoyESQf4Habeh2SVi8uXxVvZvam441loTEbTNEtKtx5nnkijVXQOkcVwVuD
	zvXOVqKfeJAN57bGmg4Ag+ZSIXGGWe+h5Ms73zTTge0Rq0MUvk+cQ2ToEGfZ22h7pAraFqV5JKGPg
	JVkVIdxg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRT-00E6zu-28;
	Wed, 17 Jan 2024 01:10:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <paul@pwsan.com>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 07/13] ARM: OMAP2+: hwmod: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:09:55 -0800
Message-ID: <20240117011004.22669-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct function name in a kernel-doc comment.
Use the correct function parameter names in kernel-doc comments.
These changes prevent the following warnings:

omap_hwmod.c:910: warning: expecting prototype for _init_opt_clk(). Prototype was for _init_opt_clks() instead
omap_hwmod.c:2311: warning: Excess function parameter 'n' description in '_init'
omap_hwmod.c:2510: warning: Excess function parameter 'n' description in '_setup'
omap_hwmod.c:3387: warning: Excess function parameter 'clockdomain' description in 'omap_hwmod_allocate_module'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -- a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -900,7 +900,7 @@ static int _init_interface_clks(struct o
 }
 
 /**
- * _init_opt_clk - get a struct clk * for the hwmod's optional clocks
+ * _init_opt_clks - get a struct clk * for the hwmod's optional clocks
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh omap_hwmod_opt_clk
@@ -2297,7 +2297,7 @@ static void __init parse_module_flags(st
 /**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
- * @n: (unused)
+ * @data: (unused)
  *
  * Look up the clocks and the address space used by the MPU to access
  * registers belonging to the hwmod @oh.  @oh must already be
@@ -2493,7 +2493,7 @@ static void _setup_postsetup(struct omap
 /**
  * _setup - prepare IP block hardware for use
  * @oh: struct omap_hwmod *
- * @n: (unused, pass NULL)
+ * @data: (unused, pass NULL)
  *
  * Configure the IP block represented by @oh.  This may include
  * enabling the IP block, resetting it, and placing it into a
@@ -3367,8 +3367,9 @@ static int omap_hwmod_check_module(struc
  * omap_hwmod_allocate_module - allocate new module
  * @dev: struct device
  * @oh: module
+ * @data: module data
  * @sysc_fields: sysc register bits
- * @clockdomain: clockdomain
+ * @clkdm: clockdomain
  * @rev_offs: revision register offset
  * @sysc_offs: sysconfig register offset
  * @syss_offs: sysstatus register offset

