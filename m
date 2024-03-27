Return-Path: <linux-kernel+bounces-120514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A454088D895
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB829F357
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F32D047;
	Wed, 27 Mar 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Hh0iaQEP"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78F3612C;
	Wed, 27 Mar 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527365; cv=none; b=q5wzF3JXsAyRfRYrfLThgmzaXEnH7kooZTvGWNtI9Wq5I3jDw/tSZWG5ih5DoNBX/YRyuxvCkw6uM+NNMlPiN8nNsVpujCAcwU2LdKW8HTyX9JQT2kW60t66BmDdbxxCursBe/5lHq0jD+3EKUuhRZJe9iTPi+ih4EAhg35sbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527365; c=relaxed/simple;
	bh=0nz944gsPunaEY0WbXrcZZChPstAF/Sym3EL2KX9RZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnbkysYHZ2b1nXnWZV59MBLN/CBWbBo5c0JDiXJXe308Ahh8k8pBdBtPMYri86Zvj6Cn3NCMH+ouflraL7NMmaxj+g8rm1mZZmZqWQKa5o01TlgKccF9eEWkLicIQvftw/KxDGwFfU0h8l61scc9NX67/+KONPG5dhWP969Tyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Hh0iaQEP; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 03ED360462;
	Wed, 27 Mar 2024 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527361;
	bh=0nz944gsPunaEY0WbXrcZZChPstAF/Sym3EL2KX9RZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hh0iaQEPeJKjflBIEm2EgHUEbLyvx3SC4u+27CnmOTrtDYpSUell35SqtXd3ZbV6A
	 6vGZeKRdR4LM0qpFCR8e39oG+0bS3fr+B375m3ocK1Ac7SARH41sW1oHyaUyaBX9qa
	 H7s6cK/ISczWH5FUws04CsMa9cL/LKLgEck/jIhGaeRBJwP3CIFK3DLvMWm+Ox6Mx/
	 /hVsuP0d4kTpcEB6mCn2ZXpNajRpzXxRShnJTiPY5EJxwfiAi6VDI0WOB273vgyZyc
	 HFwoTnjQ7w0Y4JLOTEPuQj87B+EydXJ7HHAXLMxbhiEYbwb6JOxXM1I9HNm+262LNc
	 ObLshS7RFXUkw==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] bus: ti-sysc: Drop legacy quirk handling for uarts
Date: Wed, 27 Mar 2024 10:15:06 +0200
Message-ID: <20240327081508.36747-4-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327081508.36747-1-tony@atomide.com>
References: <20240327081508.36747-1-tony@atomide.com>
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

