Return-Path: <linux-kernel+bounces-120515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FFA88D896
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257941C23465
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC92D622;
	Wed, 27 Mar 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Pipq6E1T"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31A364A4;
	Wed, 27 Mar 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527374; cv=none; b=hs5GWrGnlhWJICR0LPO87bov3boacs1KHVDWoI/JZugq0Wf7oDP/wEHTY2TaoiwKeNSlPybx7ErdiJgL0hpfk0PHDHrcTFx+iYeSHImj2I/WmW6vvB6VSu/AQMG9Kg91DAarmPcrDi/RQUjoD4FfW2+tiDD4X5PUK/7+6v+ooNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527374; c=relaxed/simple;
	bh=5Wp3EbqRXlFnAzFR7aYGK9sB8fobkQcw7EykZ9pAxZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=logYofRW5lWR0wImpla7VOhp/p1s1dmQ4D7By1ndEd9NedBBNhb2+64LUk9PP74OhHUbG95FjrdW8/2fxQA0k8idSQ6OoychUh9TAX2h91PgNrZvyhkywRWSEBnLX0RXMrdFuNnoU4GY79S02Hg/8CeOMIpm+poWqQmLkijUA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Pipq6E1T; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 76EE6604C8;
	Wed, 27 Mar 2024 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527372;
	bh=5Wp3EbqRXlFnAzFR7aYGK9sB8fobkQcw7EykZ9pAxZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pipq6E1Taj3JFwD0ptrhSh0Dg57lxe13t+XBTDF/xyvsHhfMiSuK4iHKxNcHVtgfJ
	 UcudmnOwuZRjm3d2ZbfOc7mJTTrjrL1Nyh15v7bVHxZwFW8wodkO2xUpGFOZkYQZfL
	 WvE1i1hEXEVx0qacC8YIUJwQj3UHEGdaeXAXu5PlFBBdbkImSvFqTuCxJQajGVlV78
	 rFuYaV8QkPJl/OnQexZEFKF73GCl8/WoLmrEU9j0puHEBGlNjlJPqqb/a3M5KJTJhH
	 EeqAwmZRUFfABFbDlU+SsBBcbfbX6+9h/RvVzrXvsqoYgZDsUs2FIiH+TBjKR0UdVi
	 ogP1QJu/mM3Ug==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] bus: ti-sysc: Drop legacy quirk handling for smartreflex
Date: Wed, 27 Mar 2024 10:15:07 +0200
Message-ID: <20240327081508.36747-5-tony@atomide.com>
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

With the smartreflex driver no longer relying on the use of
pm_runtime_irq_safe(), we can finally drop the related legacy quirk
handling.

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

