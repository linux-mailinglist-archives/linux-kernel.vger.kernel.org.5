Return-Path: <linux-kernel+bounces-138008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284989EB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D028705F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7088122064;
	Wed, 10 Apr 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Iq1/6OHu"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F3383AE;
	Wed, 10 Apr 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731267; cv=none; b=pkObeI7OpZDCV/UyUYgOxvEuF1u1MpoRpvhCmWsUOtXBQ8zYpxrembQ1Ew7QK+CETPOyzwDYaXM48kKZ0Z480LmqLgi3PYWLhOrqYeVwSyXKtWkZNHWe+G9Ha3wxvnuErzboZSOruvQ+FKnXpj/ABlw+EwarD5uwxy8jjn2LZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731267; c=relaxed/simple;
	bh=0nz944gsPunaEY0WbXrcZZChPstAF/Sym3EL2KX9RZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jI1IPE69e0ef5GQuKm/fjaD962NbplYrGKJhi77Ox5FIeeYsZiioUvygwJegFOZkS4/b1BWHwPwwDI0mkDcHNs5/q3MWLRhUDYVn2aEwZgvIOpnEMMurM9/Yc8B5LNIursQ8PXOHEW+l8JGB+AUEjqxC9E00qTYYt8zppzUFvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Iq1/6OHu; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 1F1806034B;
	Wed, 10 Apr 2024 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712731265;
	bh=0nz944gsPunaEY0WbXrcZZChPstAF/Sym3EL2KX9RZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iq1/6OHu4/+HyEuowU+W+/qcXh13w2bFxc8NgZQcu3Sy4AK7lv8z3aYx76S1QFNno
	 1AB0TwYB3p+GzEmGRqqJQOV+jCnVLaLCIgYxyy7l6ce2nid54n/iV3MS+EPvodBFCl
	 nLx9awSUFIKNhGYvEVgivFqwzA2l2qTh79Rgw0PIQyje5h6fe/BqNrNJPat60SFql0
	 IVx93JS0T+L8hbQQppa0GYMBH6XeyAY+PHpUQginN2i0l01PZpXv4lu/eNziZpZNB+
	 ZnAu1yyQOF7tTpnftruyiFPZi1EoZ8DaB5J/rKj+4dDtydhs92ZykkzVQEkKsuDsog
	 xFEQA9vxC8KrA==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] bus: ti-sysc: Drop legacy quirk handling for uarts
Date: Wed, 10 Apr 2024 09:40:07 +0300
Message-ID: <20240410064010.57142-4-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410064010.57142-1-tony@atomide.com>
References: <20240410064010.57142-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the 8250_omap and omap-serial drivers no longer relying on the use
of pm_runtime_irq_safe(), we can finally drop the related legacy quirk
handling for uarts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1540,19 +1540,6 @@ struct sysc_revision_quirk {
 	}
 
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
-	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
-	/* Uarts on omap4 and later */
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
-
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
 		   SYSC_QUIRK_EXT_OPT_CLOCK | SYSC_QUIRK_NO_RESET_ON_INIT |
@@ -1610,6 +1597,17 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("sata", 0, 0xfc, 0x1100, -ENODEV, 0x5e412000, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT),
+	/* Uarts on omap4 and later */
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, -ENODEV, 0x50700101, 0xffffffff,
-- 
2.44.0

