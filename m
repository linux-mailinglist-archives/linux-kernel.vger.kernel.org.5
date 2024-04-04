Return-Path: <linux-kernel+bounces-131491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE35898893
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6A31C217B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037F126F3A;
	Thu,  4 Apr 2024 13:11:06 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE9839F8;
	Thu,  4 Apr 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236266; cv=none; b=q9oPbB3is95L6Q4JNV0OyKv+MebK4E5LUBJaNgreeWfdbktI2ptcf1Ojb+yGv+t9XQTqvgxoO+uB/zL98/b94GKCsvYnyvX8UOOZFEd20YEyXGuPhy3siFwqa/WqgoD2NGYbQnI2RDE79rC5EpEYp4ulIq0NqEhmiSue54ELdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236266; c=relaxed/simple;
	bh=AoOwgkD5hk0hf+LezO69kCUFVCm9HgHFOxezAZesH/E=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=J9SByiLabI2gRFmCi7yCdVHd+GTj7dmGU9fH9UesFJXXHTdXmG2xv85kbxqr/Pb++hTb7w2X8deWxC1Zo+hpbnOQpyyBJaXaEp6Mp1U5DcJsK2yepLV+L/sBWArC7j5+ga7IVnUSSJb74xvikmhDl1YgXQHc1VMBcOv2jLhb/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006EA00.00000000660EA6E6.00259308; Thu, 04 Apr 2024 15:11:01 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v3] platform/x86: ideapad-laptop: switch platform profiles using thermal management key
Date: Thu,  4 Apr 2024 15:10:59 +0200
Message-ID: <7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu>
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
(Fn + Q). They report KEY_PROG4.

If supported, cycle platform profiles instead.

Tested on Yoga7 14ARB7.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes in v3:
 - add dytc_profile_cycle function
Changes in v2:
 - only switch platform profiles if supported, otherwise keep the 
   behavior.

[2]: https://lore.kernel.org/all/797884d8cab030d3a2b656dba67f3c423cc58be7.1712174794.git.soyer@irl.hu/
[1]: https://lore.kernel.org/all/85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu/
---
 drivers/platform/x86/ideapad-laptop.c | 31 +++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 901849810ce2..c7ea3ed14aba 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -858,6 +858,30 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
 	}
 }
 
+static void dytc_profile_cycle(struct ideapad_private *priv)
+{
+	switch (priv->dytc->current_profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		dytc_profile_set(&priv->dytc->pprof,
+				 PLATFORM_PROFILE_BALANCED);
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		dytc_profile_set(&priv->dytc->pprof,
+				 PLATFORM_PROFILE_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		dytc_profile_set(&priv->dytc->pprof,
+				 PLATFORM_PROFILE_LOW_POWER);
+		break;
+	default:
+		dev_warn(&priv->platform_device->dev,
+			 "Unexpected platform profile %d",
+			 priv->dytc->current_profile);
+	}
+	/* Notify user space the profile changed */
+	platform_profile_notify();
+}
+
 static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
 	{
 		/* Ideapad 5 Pro 16ACH6 */
@@ -1181,8 +1205,11 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
 		switch (bit) {
 		case 6:	/* Z570 */
 		case 0:	/* Z580 */
-			/* Thermal Management button */
-			ideapad_input_report(priv, 65);
+			/* Thermal Management / Performance Mode button */
+			if (priv->dytc)
+				dytc_profile_cycle(priv);
+			else
+				ideapad_input_report(priv, 65);
 			break;
 		case 1:
 			/* OneKey Theater button */

base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


