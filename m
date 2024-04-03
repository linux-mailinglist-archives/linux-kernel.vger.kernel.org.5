Return-Path: <linux-kernel+bounces-129785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E6896FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12241C25E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EE148304;
	Wed,  3 Apr 2024 13:09:18 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107E147C90;
	Wed,  3 Apr 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149758; cv=none; b=NYnom+Aw0rOcLaGq8YQwC8BTOxb7lLNx04HsQp6xKZ4F7BAUd3XAAIeHlLy8Cc/5Yx6YyE1REzHu2xDeBFZQM/O0Ks/Xy/g4Qurw3CsP1285o+Ta9xkiWq5Jw4ccqMOczQXvhtyKSA+vXnI1l/8p1F+SEwVYcmE1T53QOUxdUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149758; c=relaxed/simple;
	bh=j/2Sfnuuaf/D6GVHHD0zV3RKWfEs3vbqzQqRmEe9Kj0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=N8ODRMHo7XlE+GUqv2pJF/tmVr1WvuUNVVueQPcIUkIqC3naf59+xvajo2+rFMGsUqd0WYNYOqCukq6jzCvNSVPoclQeG2DcU20adXzUMvm785IBI+uRRwG7K1Z+oyjH1xe2Vk2qgp3xtxK6aOtBuQ8P2etJeMwJPdPi2/nRdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006C9F3.00000000660D54FA.00255DE5; Wed, 03 Apr 2024 15:09:14 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] platform/x86: ideapad-laptop: switch platform profiles using thermal management key
Date: Wed,  3 Apr 2024 15:09:07 +0200
Message-ID: <85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Ideapad laptops have thermal management or performance mode switch key
(Fn + Q). Now it sends KEY_PROG4.

Switch platform profiles instead, like the ThinkPad ACPI driver.

Tested on Yoga7 14ARB7.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/ideapad-laptop.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 901849810ce2..6310011cc1b3 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1071,7 +1071,6 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,  16, { KEY_PROG1 } },
 	{ KE_KEY,  17, { KEY_PROG2 } },
 	{ KE_KEY,  64, { KEY_PROG3 } },
-	{ KE_KEY,  65, { KEY_PROG4 } },
 	{ KE_KEY,  66, { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY,  67, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 128, { KEY_ESC } },
@@ -1181,8 +1180,27 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 		switch (bit) {
 		case 6:	/* Z570 */
 		case 0:	/* Z580 */
-			/* Thermal Management button */
-			ideapad_input_report(priv, 65);
+			/* Thermal Management / Performance Mode button */
+			switch (priv->dytc->current_profile) {
+			case PLATFORM_PROFILE_LOW_POWER:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_BALANCED);
+				break;
+			case PLATFORM_PROFILE_BALANCED:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_PERFORMANCE);
+				break;
+			case PLATFORM_PROFILE_PERFORMANCE:
+				dytc_profile_set(&priv->dytc->pprof,
+						 PLATFORM_PROFILE_LOW_POWER);
+				break;
+			default:
+				dev_warn(&priv->platform_device->dev,
+					 "Unexpected platform profile %d",
+					 priv->dytc->current_profile);
+			}
+			/* Notify user space the profile changed */
+			platform_profile_notify();
 			break;
 		case 1:
 			/* OneKey Theater button */

base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


