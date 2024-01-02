Return-Path: <linux-kernel+bounces-14522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB1F821E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2680283DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405514F6A;
	Tue,  2 Jan 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WaTnIwQo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B914A9C;
	Tue,  2 Jan 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4029fW3Z029874;
	Tue, 2 Jan 2024 08:57:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=w
	V54aLCafCqPFkfP1HXduuwoFpHJPYhvba9jOLf4nBI=; b=WaTnIwQoKiFd8jS9F
	BiwUsHA7xT9lyGjhVrolWlrQmi8olx1hpmno9tXJkXDgUwvYaLqM9xkXRVSMvkUO
	Wj8k0bidYuPBaetoPZk0nYeu67J+4HoRgFKsAr4ciMOHyL8hQBlybiAqkPS5yKHT
	Wfe8RITDuqfsMY8GfuXhL4btTSsdURSQ4Lhe4tE+1tlCdbcOA18b96ljOU+IFoHu
	kuEiwV4/GTMoe7p3sK02AFdOr0zN4o0nDQ8r/aTowyrsynZ5g4FQ01t6pYAIxqW+
	szo+aUraiUVv6HBmGWNxkrNCWVLyT2ldLj08BniEhbhckBqbJuUNSivL/Arltv0Z
	5Dd5g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vahg2b9t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 08:57:35 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 14:57:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 2 Jan 2024 14:57:33 +0000
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6907A46B;
	Tue,  2 Jan 2024 14:57:32 +0000 (UTC)
From: James Ogletree <jogletre@opensource.cirrus.com>
To: 
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Jeff LaBundy
	<jeff@labundy.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/2] Input: support pre-stored effects
Date: Tue, 2 Jan 2024 14:56:12 +0000
Message-ID: <20240102145614.127736-1-jogletre@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mJkb45CEN7JXr_gPI6I5WKL9bsgKZ5SL
X-Proofpoint-ORIG-GUID: mJkb45CEN7JXr_gPI6I5WKL9bsgKZ5SL
X-Proofpoint-Spam-Reason: safe

At present, the best way to define effects that pre-exist in device
memory is by utilizing the custom_data field of ff_periodic_effect,
which it was not intended for, and which requires extra processing
by the driver.

Provide simpler option for interacting with pre-stored effects in
device memory.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
---
 include/uapi/linux/input.h | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2557eb7b0561..689e5fa10647 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -428,17 +428,27 @@ struct ff_rumble_effect {
 	__u16 weak_magnitude;
 };
 
+/**
+ * struct ff_prestored_effect - defines parameters of a pre-stored force-feedback effect
+ * @index: index of effect
+ * @bank: memory bank of effect
+ */
+struct ff_prestored_effect {
+	__u16 index;
+	__u16 bank;
+};
+
 /**
  * struct ff_effect - defines force feedback effect
  * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
- *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, or FF_CUSTOM)
+ *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, FF_PRESTORED, or FF_CUSTOM)
  * @id: an unique id assigned to an effect
  * @direction: direction of the effect
  * @trigger: trigger conditions (struct ff_trigger)
  * @replay: scheduling of the effect (struct ff_replay)
  * @u: effect-specific structure (one of ff_constant_effect, ff_ramp_effect,
- *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect) further
- *	defining effect parameters
+ *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect, ff_prestored_effect)
+ *	further defining effect parameters
  *
  * This structure is sent through ioctl from the application to the driver.
  * To create a new effect application should set its @id to -1; the kernel
@@ -464,6 +474,7 @@ struct ff_effect {
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_prestored_effect prestored;
 	} u;
 };
 
@@ -479,20 +490,21 @@ struct ff_effect {
 #define FF_DAMPER	0x55
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
+#define FF_PRESTORED	0x58
 
 #define FF_EFFECT_MIN	FF_RUMBLE
-#define FF_EFFECT_MAX	FF_RAMP
+#define FF_EFFECT_MAX	FF_PRESTORED
 
 /*
  * Force feedback periodic effect types
  */
 
-#define FF_SQUARE	0x58
-#define FF_TRIANGLE	0x59
-#define FF_SINE		0x5a
-#define FF_SAW_UP	0x5b
-#define FF_SAW_DOWN	0x5c
-#define FF_CUSTOM	0x5d
+#define FF_SQUARE	0x59
+#define FF_TRIANGLE	0x5a
+#define FF_SINE		0x5b
+#define FF_SAW_UP	0x5c
+#define FF_SAW_DOWN	0x5d
+#define FF_CUSTOM	0x5e
 
 #define FF_WAVEFORM_MIN	FF_SQUARE
 #define FF_WAVEFORM_MAX	FF_CUSTOM
-- 
2.25.1


