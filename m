Return-Path: <linux-kernel+bounces-28410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2F82FE39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522821F26A32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FE8BF9;
	Wed, 17 Jan 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zFi3WSi9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B3138E;
	Wed, 17 Jan 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453809; cv=none; b=GokiWLXH5WFmalUiV7s0039wSz7OF6CMqokJ3oY5hzLxYVCT6wNoFzqVyzmkjK9Iiii5I/lMJn5yJp+0K4tF9JVA3HIXkifpSPaXhItPwjZgsBsxCMe1Q2oHZe5v+MKy+UR7Ej0a8lVHNoRMO7umjnpq0GHuPa8NqhK9siydq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453809; c=relaxed/simple;
	bh=aM8ocPmHg0OMLJEWtIxrWWZhPAw14wJ+RT4fBx1Haho=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=uZVdMK7JtTXuZHqtO6ZNcCtybP5a4c498LwvE1VaCzEvrYUT+BYzX111kSG+EIOIAsnRI1EY47yvIcOn6RIzAt92esHFp70oHgGt9t1GQ4FQOHQNziQLXHrgiLDtIPOVMsg+CWBFwNej+1404OY9D0ZUi16aJ9a88UQHYuR2ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zFi3WSi9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rcWb9ODcVk+PBPlVDZ/HAVR0kff6gEP/cAU5smz8ywA=; b=zFi3WSi96ypWdkqc2v0GH5xW7F
	eZ/SaBqk+vsXK5QzVZhfENB+bbzBp7ZnUEXHr9Uc2UIA9umORYCJdj0mjZf75oxiLnSMLKMlVvjkr
	VcbPST2oFBfJM9JSG63i7Vy1zdeVDlBCUPumK/YXswWSYKXYpE/+uqc3YFNQCZI1Vft4XidnPLKhg
	/XXvCVKUC+iTEklTGnHWcSFdg2tOkHO7fCyRY9wYe9k6CTaxKRQPEFRLT/yAhmE9qkxmOTrf51E+/
	7JfRIUB5X69Gx6xInfh/EqjPdzpblHcMv9GSqifPDr8D/LgUHCOUWHFPwg2UBpM/vyBGJh9kWZfqs
	ge5aniGQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRS-00E6zu-1X;
	Wed, 17 Jan 2024 01:10:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 03/13] ARM: OMAP2+: clock: fix a function name in kernel-doc
Date: Tue, 16 Jan 2024 17:09:51 -0800
Message-ID: <20240117011004.22669-4-rdunlap@infradead.org>
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
kernel-doc warning:

clkt2xxx_virt_prcm_set.c:173: warning: expecting prototype for omap2xxx_clkt_vps_check_bootloader_rate(). Prototype was for omap2xxx_clkt_vps_check_bootloader_rates() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -162,7 +162,7 @@ static int omap2_select_table_rate(struc
 }
 
 /**
- * omap2xxx_clkt_vps_check_bootloader_rate - determine which of the rate
+ * omap2xxx_clkt_vps_check_bootloader_rates - determine which of the rate
  * table sets matches the current CORE DPLL hardware rate
  *
  * Check the MPU rate set by bootloader.  Sets the 'curr_prcm_set'

