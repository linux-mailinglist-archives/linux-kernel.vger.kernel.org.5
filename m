Return-Path: <linux-kernel+bounces-122087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C7B88F1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842211C2CDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EFA153837;
	Wed, 27 Mar 2024 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="wkfO23G8"
Received: from mail-108-mta109.mxroute.com (mail-108-mta109.mxroute.com [136.175.108.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077914E2D1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578084; cv=none; b=Zi549n68v47rGnJ5toKEyEj9iFKmLFOIHn5v7y2VUyWTn6bO4nS/eSOfNq8JYIMF/sixIlvo1b767Jr5HAhoTQdtRdGWzAHoxSLZwyM0VWBqXQLIHdxUPS2dstOBFvy4Uu1+rq5PHuRnHMWG1hmC8P8OV1RFEuDhxFVj5W4Kdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578084; c=relaxed/simple;
	bh=l/d1KTSxrdSi8t1Av6GsBX7faXE7YS03/s1Y6XmUM9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk5wnL7szr1LtlVWM7ugu2aZDH0H5hPxgE6yBO4ONrEgXtW7HKB7ohRu7jmUqzWBFl9F68DVwgzllzvTFCT83iLwqMPr8xzeMpujI3RoU4nvC/4yuQproPfCL8jKKPJtvmSCUjSrFPWOjMpkTETbz98iHbgm6bfdJJvMB5mEC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=wkfO23G8; arc=none smtp.client-ip=136.175.108.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta109.mxroute.com (ZoneMTA) with ESMTPSA id 18e8200a9520003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 22:21:05 +0000
X-Zone-Loop: 68ce8d984520cdde10326635c43e3d834e55519162e3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wfd3IM9yvSlmOOZPNTkn/UcYNYLQj3XQ9wKwbMSeFFA=; b=wkfO23G8d0f1UmDKwI19ALxOur
	Whk3/ewONqmq7ThLU38LoZaX7TeVQZ/ZlWhkVCY1Nv72S47KuKoOsoZPYF5APnEL11iLUJPqE40ZQ
	UeGs1Py8YqIIcqYkUDRvFcF0XycPaaersLvz1IDyI+8ExNFLwf07T/bgSeB7rBV0Z4Vg7tGKdc00f
	ZF9VlALEMgUZEvkk0Zgljww5smZWqUoEtjXB5t1CEVSvVFQs/jziUp1nED2tsJ2wrD1WCqUZWR7h6
	RnGE5Ifiy+US2qVPFxjNTNMtSDYZPm/Vw46Bz4FodRkj0K2tNnbv/VrZ+uiMiRmOqJA0ZWmFMFMF6
	+HODCqiA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	x@xnux.eu
Subject: [PATCH 10/23] media: i2c: imx258: Follow normal V4L2 behaviours for clipping exposure
Date: Wed, 27 Mar 2024 16:20:22 -0600
Message-ID: <20240327222035.47208-11-git@luigi311.com>
In-Reply-To: <20240327222035.47208-1-git@luigi311.com>
References: <20240327222035.47208-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

V4L2 sensor drivers are expected are expected to clip the supported
exposure range based on the VBLANK configured.
IMX258 wasn't doing that as register 0x350 (FRM_LENGTH_CTL)
switches it to a mode where frame length tracks coarse exposure time.

Disable this mode and clip the range for V4L2_CID_EXPOSURE appropriately
based on V4L2_CID_VBLANK.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/i2c/imx258.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index c65b9aad3b0a..1f5fb980cfbe 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -37,10 +37,11 @@
 
 /* Exposure control */
 #define IMX258_REG_EXPOSURE		0x0202
+#define IMX258_EXPOSURE_OFFSET		10
 #define IMX258_EXPOSURE_MIN		4
 #define IMX258_EXPOSURE_STEP		1
 #define IMX258_EXPOSURE_DEFAULT		0x640
-#define IMX258_EXPOSURE_MAX		65535
+#define IMX258_EXPOSURE_MAX		(IMX258_VTS_MAX - IMX258_EXPOSURE_OFFSET)
 
 /* Analog gain control */
 #define IMX258_REG_ANALOG_GAIN		0x0204
@@ -371,7 +372,7 @@ static const struct imx258_reg mode_common_regs[] = {
 	{ 0x303A, 0x00 },
 	{ 0x303B, 0x10 },
 	{ 0x300D, 0x00 },
-	{ 0x0350, 0x01 },
+	{ 0x0350, 0x00 },
 	{ 0x0204, 0x00 },
 	{ 0x0205, 0x00 },
 	{ 0x020E, 0x01 },
@@ -741,6 +742,19 @@ static int imx258_update_digital_gain(struct imx258 *imx258, u32 len, u32 val)
 	return 0;
 }
 
+static void imx258_adjust_exposure_range(struct imx258 *imx258)
+{
+	int exposure_max, exposure_def;
+
+	/* Honour the VBLANK limits when setting exposure. */
+	exposure_max = imx258->cur_mode->height + imx258->vblank->val -
+		       IMX258_EXPOSURE_OFFSET;
+	exposure_def = min(exposure_max, imx258->exposure->val);
+	__v4l2_ctrl_modify_range(imx258->exposure, imx258->exposure->minimum,
+				 exposure_max, imx258->exposure->step,
+				 exposure_def);
+}
+
 static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct imx258 *imx258 =
@@ -748,6 +762,13 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
 	int ret = 0;
 
+	/*
+	 * The VBLANK control may change the limits of usable exposure, so check
+	 * and adjust if necessary.
+	 */
+	if (ctrl->id == V4L2_CID_VBLANK)
+		imx258_adjust_exposure_range(imx258);
+
 	/*
 	 * Applying V4L2 control value only happens
 	 * when power is up for streaming
-- 
2.42.0


