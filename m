Return-Path: <linux-kernel+bounces-138009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649289EB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B882B1C228D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E672A8D0;
	Wed, 10 Apr 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="jvGhVEDR"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863139FF7;
	Wed, 10 Apr 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731278; cv=none; b=eH75i2Gdr/ZuTLh2slTgR1NHpYwY76jt4/mWa6LFXUDp6hIMPTigwYYwqyu3b5MDnk9bN+imSZyS5Egw5dFbRD1smjXookAK9j5bSKXjPWoTc3raRc2k9vxUhoswLYAEkHPinupjg/nkFM1Su2ZLGrUKGca3E8rjP2S+9pIkFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731278; c=relaxed/simple;
	bh=YjYH50vrqQM3j2i9OBrQHvAxKdE+aBtGBhlx9HJrVR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sovUwSAKVnld+DU8vqMtvTAtcqiSeYk6UGTgJnsTVEJRxtLLBS5EQE4F6NPCKZwoviZaWqwpQMWwhjDK4A7tEOJu/PjHBop9OKZLrUlr71rnKLqS9Bxe3VUo6rTH6BlBwSde0mjoPhpEEriy8uvMjvmp/JMBpUFoTwGhNh4k/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=jvGhVEDR; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 950956034B;
	Wed, 10 Apr 2024 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712731276;
	bh=YjYH50vrqQM3j2i9OBrQHvAxKdE+aBtGBhlx9HJrVR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvGhVEDRIUhrafCSJrDR2Dsmc3/6Erbss1LBdNhG4tpqGyknPVVfeA40Df81qLawJ
	 ZHomXeTm9Uj5oH01KxF30WVzF4IVY4E6HeYrrYllwnEdI0w5wG4UPM9Hydrr6j5Cmd
	 7CIwbYxX8L8MyAXAuhfo53s5Xs/f3ZzVbtnQhxBwr570TuCQ/CP9SLUTJaBrkP1k8G
	 TJAF6jIb4sEsBRJlQApci0p1QKIRD/WH6tSP1ZPMyqzC7NJZPEmhNwdbyIQvLBdCaJ
	 j4d61+MscavKh009kGHyGuBt50ojrm2ZYdZkWwgwJJ0ktZF3sx8gGUuKVpMA2Jbcbh
	 71bvF49yAJPqg==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] bus: ti-sysc: Drop legacy quirk handling for smartreflex
Date: Wed, 10 Apr 2024 09:40:08 +0300
Message-ID: <20240410064010.57142-5-tony@atomide.com>
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

With the smartreflex driver no longer relying on the use of
pm_runtime_irq_safe(), we can finally drop the related legacy quirk
handling.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2869,8 +2869,7 @@ static const struct sysc_capabilities sysc_34xx_sr = {
 	.type = TI_SYSC_OMAP34XX_SR,
 	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY,
 	.regbits = &sysc_regbits_omap34xx_sr,
-	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED |
-		      SYSC_QUIRK_LEGACY_IDLE,
+	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED,
 };
 
 /*
@@ -2891,13 +2890,12 @@ static const struct sysc_capabilities sysc_36xx_sr = {
 	.type = TI_SYSC_OMAP36XX_SR,
 	.sysc_mask = SYSC_OMAP3_SR_ENAWAKEUP,
 	.regbits = &sysc_regbits_omap36xx_sr,
-	.mod_quirks = SYSC_QUIRK_UNCACHED | SYSC_QUIRK_LEGACY_IDLE,
+	.mod_quirks = SYSC_QUIRK_UNCACHED,
 };
 
 static const struct sysc_capabilities sysc_omap4_sr = {
 	.type = TI_SYSC_OMAP4_SR,
 	.regbits = &sysc_regbits_omap36xx_sr,
-	.mod_quirks = SYSC_QUIRK_LEGACY_IDLE,
 };
 
 /*
-- 
2.44.0

