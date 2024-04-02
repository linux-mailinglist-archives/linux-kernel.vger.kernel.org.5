Return-Path: <linux-kernel+bounces-128380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61E895A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EA8282295
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211515CD70;
	Tue,  2 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqdpib5w"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB415B99F;
	Tue,  2 Apr 2024 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076400; cv=none; b=l8Vl20QnxhNX+gpkOtujbv76TIgtFUYNsoBjzpOfN05cwj83sTJGxUScsaaPUBx24YOoq1XRh87iJm36lBWUq4PSYMptGpvsFG+IwwtHTN6cntJZa/ZrqGQJg+AedknGxP416/jZPq5a0DNJZO0mc3FLtyAadpUq5ua1+3xWGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076400; c=relaxed/simple;
	bh=DphCl8m5iMRy4TNbnjwO9AocW9KQB5yOchWW/vfAauA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om2lT8m1PVv64nInnILg/KjA1PexICgw/nqHLy9zSFrNvdgM20O2r24/eIFIKgMOBRtcx2SptVipRi/NEWwcKDZ9ZIeLGE2IEP1x21xSM4J44oBze2fzS6JGqzwnarMm+L1vcPMhhdBcochb93JNNUkj8deRtr3JdojhZyatbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqdpib5w; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d715638540so58528411fa.3;
        Tue, 02 Apr 2024 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076397; x=1712681197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGKmb072VuhOk8t3ivynzmGpdf2Xmh6dgLSBJ5vtnzc=;
        b=Cqdpib5wYZx1Ohl3hPG6R4r9L1PKunu0M8MbFzwBC1GqzWypnQEltYShPXLDDmZv0i
         kDTrCjx6PaMuFnwGoGLtmBe4kMX7z6uzXy+IE8dMdnKLioI6BysBI8HV48eJvmeZ+OMy
         83MoxVKR+DyY8pUIjgq4Yho3rPDaFNkWEsq9aCNS8TLyPRURHJYLiz9gVqm4dAkqvXx+
         m32UflZ6y/Kyiw1lokDEX2XJxoJAzyhoVw/KjHi075QDDotPkMPHwzhQylrpnEzTRD3e
         m/eGX/QVc6T/ztZBaX1n8rqmf3iGqcPo9OZ63rMAXuRh8zS2bILzXK6f8qK/CRPBVR1M
         0hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076397; x=1712681197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGKmb072VuhOk8t3ivynzmGpdf2Xmh6dgLSBJ5vtnzc=;
        b=jdItE8pSctKf8dpqRduvIBYyD2xd5jdm/rGbOhmYPFEIiOPpN2S9XVXkJOeKRifpQ/
         AYuM6IZvMetMmzpjqqCC9j6x4TCKuiTh17q25qQ+GAVcdwucvMkR9Z5+MBaJtaauxtLh
         B2AreAN2ea4xqcd7pJVxAhgRR3vAGkQgF28XW19j//x8sQtsecCwsDGNZB/bVgJXtZ1e
         qy2rppmMqOuLIC2YxeCa/ctISuw5BPxZBlCHgBSk/iAksZMOuAnFrfzf/yBINI9a5oW8
         PeIkYCPpuGJY1uGYdOdxdVMW8Q9kaqkKAXkbMBCzO5q32woTEcHUU+Zzu1UMg+djsaP5
         SxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVacgiX372a1o5c7AadS7yCkAWB80ebE647e9asmT3vpcAUk6rUQa0XmgrdiNF2FrUok7uo6uNYCmy2EXmrVsSKjYWePNCGOR8ndLym
X-Gm-Message-State: AOJu0YyhyLSltKbJlUzeW3HxwNN3mc9glz8MMviBbniS81Xlzq9eh3wg
	gUCgc0WxBgaUjVQYrUG9v39vs++bu4rQcONia0+MiqCC0gPsVosk//Q8hSK7SU1KYA==
X-Google-Smtp-Source: AGHT+IHkwtvWZMMTBpemdzFlZJQOYkDr7ZxfD2fu40jQrYGtTwcWtqaewcmMCEEOugp+PgoSvbMbEg==
X-Received: by 2002:a19:2d5c:0:b0:512:be8e:79da with SMTP id t28-20020a192d5c000000b00512be8e79damr8870947lft.8.1712076396817;
        Tue, 02 Apr 2024 09:46:36 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512239600b00515e6bcfdcdsm1072145lfv.49.2024.04.02.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:35 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 14/20] media: i2c: ov4689: Implement manual color balance controls
Date: Tue,  2 Apr 2024 19:45:45 +0300
Message-ID: <20240402164552.19171-15-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OV4689 sensor has separate red and blue gain settings (up to 4x).
Implement appropriate controls in the driver. Default gain values
are not modified.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index d6be0856afe1..28470627ec45 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -56,6 +56,13 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
+#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
+#define OV4689_WB_GAIN_MIN		1
+#define OV4689_WB_GAIN_MAX		0xfff
+#define OV4689_WB_GAIN_STEP		1
+#define OV4689_WB_GAIN_DEFAULT		0x400
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -632,6 +639,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_DIGITAL_GAIN:
 		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
 		break;
+	case V4L2_CID_RED_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_RED, ctrl->val, &ret);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -662,7 +675,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 13);
+	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
 
@@ -709,6 +722,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
 			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.44.0


