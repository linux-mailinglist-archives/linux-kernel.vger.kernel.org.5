Return-Path: <linux-kernel+bounces-106836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAF87F44B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66EE1F236AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCC5FDB2;
	Mon, 18 Mar 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRUlpozA"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E245FB88
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806136; cv=none; b=Di/SKy/drqvs/So3K0sM/+4sVnCNBgRilqmfvceM1KcK0yKuOBI68slegTCkVuOfKEsry61ajpux3DbXBhLiJEUG+KU8GW3gWU7iC27M4wf0OnU4F7XDAgk+Xnp3diuGz3SqO3SfmX75FTNPJ3N96BUAGNBBzZmL7p2/CDaWFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806136; c=relaxed/simple;
	bh=zBECVF9sz72SkafC2kf8Npmyir5v2S+2KXe7owaPEq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPH9PizPZMmhP1sqew2ugWfJ5uytWc42eb/VyuSWxT20lR4R7tTFig/frNmj0lyhj4bh2rjl8tEWh0MKMzn4qjmff5BVQVOAjELZs95UZ1gztuS/nKHviAgS/r7Q1YjzEJtyEkD5IOlhDdJ2ON8wjkpOYUfBeV9LoPNQ2SKTBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dRUlpozA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789e70d7c07so213203385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806133; x=1711410933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7pU/Vvhg3ZPRZ+PwIWA3KmscAs2Y8vnY/vfNGY6VG8=;
        b=dRUlpozAU9t4TdVJVAgq5f0VYUP23f2G4umZCzBUQ7N9bGHA4ftYaYud1ssD7U2BoJ
         EZCGLcMfau5yBXzk2o9njOpZt5nnbjI6eK/Tf8enD1U+S6I15Z4Jzy4FPQUS2hlm5oot
         H0BCFJrJnHVFCF884Vn5yNWXImN7oizO8xuaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806133; x=1711410933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7pU/Vvhg3ZPRZ+PwIWA3KmscAs2Y8vnY/vfNGY6VG8=;
        b=axzpvFGLGRFnot2eG17x4PpUDqhb1I+dL0PBsBt1jvrmfu3RRI2JeZXhLOgSqRoRsj
         ZPcxqbSQXPR2J63BEu5Gqoou9wcXSLKYZyPfPvWbeG5ClgmYZbOrovsJxZi7S5FGdahM
         z0fyyFnXD7gzjpSNS4hJlbxFVzd+ByeG/ANVpwhT2QlvoTVoWmJmNboHm+GJWxmTdhdf
         ZqHcsjKgwGdE/Y2aBX3QMXn51nFCgaVfWqDhbSGB7ahte9NPJz2CfG4epUj+nD9j1m5j
         /JDilKlMVA5sblWVhbgYJhx+bsfLl0CvXUeSlJquZqtljJyhe82NWAD5PzzHMBHd3fs+
         ojDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXVja7fHXfPGRKF9igj6wTQquMth8n/GuMhIAsoRuq3UlzLtrukz2JFlxSQmU9wbOEAT+UymtKhjn7ikUbANlA4RgsjPb6/bjVuNZO
X-Gm-Message-State: AOJu0YyjlnN5pxBSpNNF/VK5yWrDmZ40gw1r5GZaMpT3bVE9hRMBNULs
	2zYV19vJwnm7ogJ0ank+nFqUl6yRtUdjBynxu/7mVEg1fymgM6MKEfIUTy70UtGgRKo1QTtNsvJ
	/iQ==
X-Google-Smtp-Source: AGHT+IFjPCdhiePVVPLNrBIQ/vTLljDrOjwCXunGHDBXceN2AmMeQKPx2eOYrD0GrMNGPL7a3KIZ5g==
X-Received: by 2002:a05:620a:47aa:b0:788:264a:73c2 with SMTP id dt42-20020a05620a47aa00b00788264a73c2mr16845115qkb.39.1710806133219;
        Mon, 18 Mar 2024 16:55:33 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4991690qkg.70.2024.03.18.16.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:55:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Mar 2024 23:55:24 +0000
Subject: [PATCH 2/5] media: uvcvideo: Refactor Power Line Frequency limit
 selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-billion-v1-2-2f7bc0ee2030@chromium.org>
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
In-Reply-To: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Move the PLF mapping logic to its own function. This patch does not
introduce any new functionality to the logic, it is just a preparation
patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 93 ++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3e939b4fbaaaf..67522143c6c85 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -459,6 +459,56 @@ static void uvc_ctrl_set_rel_speed(struct uvc_control_mapping *mapping,
 	data[first+1] = min_t(int, abs(value), 0xff);
 }
 
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
+};
+
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+};
+
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+};
+
+static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
+	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping);
+
+static int uvc_ctrl_add_plf_mapping(struct uvc_video_chain *chain,
+	struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
+{
+	if (chain->dev->uvc_version < 0x150)
+		return __uvc_ctrl_add_mapping(chain, ctrl,
+					      &uvc_ctrl_power_line_mapping_uvc11);
+
+	return __uvc_ctrl_add_mapping(chain, ctrl,
+				      &uvc_ctrl_power_line_mapping_uvc15);
+}
+
 static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	{
 		.id		= V4L2_CID_BRIGHTNESS,
@@ -748,51 +798,18 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
 		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
 	},
-};
-
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
-				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
-};
-
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
-				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+	{
+		.entity		= UVC_GUID_UVC_PROCESSING,
+		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+		.add_mapping	= uvc_ctrl_add_plf_mapping,
+	},
 };
 
 static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
-	&uvc_ctrl_power_line_mapping_uvc11,
 	NULL, /* Sentinel */
 };
 
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
-				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
-};
-
 static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
-	&uvc_ctrl_power_line_mapping_uvc15,
 	NULL, /* Sentinel */
 };
 

-- 
2.44.0.291.gc1ea87d7ee-goog


