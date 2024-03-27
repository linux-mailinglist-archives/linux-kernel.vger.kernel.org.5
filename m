Return-Path: <linux-kernel+bounces-122170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83CC88F305
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA89F1C2E5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296945B04F;
	Wed, 27 Mar 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="pc/+BPko"
Received: from mail-108-mta45.mxroute.com (mail-108-mta45.mxroute.com [136.175.108.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEB1552FC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581782; cv=none; b=soraT2ZUFvBreVR3CzIi0kLGmX4BeUW4/+xpDONtUQBF0KkSDt9DDZQkMoKmmZB85apqAlIOvTD9YsQNB1FQPqaH3Ipw8EID5ZvmfoKHgqvXBJqbMR9DyuI1eGbwSXe/CynF9Bbg1jIPCPZw9ll2Uyk9/1BqI7n/spftLU5OYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581782; c=relaxed/simple;
	bh=sWAfFhAGvw4CqbUg4tIVjRY+a1yJUW3dKOY9ml8HHIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1I9N7f1HCeXp4Zkn0L8Ap6qlJBps0DBTWRBBHiD/aCR71RglFL+E2pD5Qg9ID25Sq5t2iPXEMbOTBpLbSJyrPHMWxY0P7d5lIwYpad4HQHS2d3qBaqI20V7C76T2vf+o/cpmU+/dkJGBgPmb8QReZBeeUdGZq63e0Ipq6Y5slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=pc/+BPko; arc=none smtp.client-ip=136.175.108.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta45.mxroute.com (ZoneMTA) with ESMTPSA id 18e82344cff0003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:29 +0000
X-Zone-Loop: 4f4169322fab887509999649e14dbe16bad90f1df869
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XYmNM0zbv3+O+YfnDH4hEcGfkU7Y/smW11E/sBjJxo8=; b=pc/+BPkonW5guBkaLMYnqc+UZj
	3qDQacC3Wjy7gocq2iX0HFpZqURNpocPIyOXrrSlcy4Cvhh5+D287Ln+Bk+PTGBC4n2vuFevW2I62
	lQ4OsB5+9XrSyPjNsdIIpxw+NxfJUWMgaGhSKTI12grVagEIRSMBaGj7FfXL4sLeY5GMOFvWNtwdt
	Hif1pptKXWK5b2xBtfuhfyuXZ39hUo0SKM/Bm2dbWvVFVBtN1ZG9n5VKcVDluKLY/EiXxROhq5YQG
	4yKb61/9xE8z2/QNeVeHGRhfw1ET2ufflRwC4glFUNx5kcn+EkVQe2xdxHqH3xzblVMLWtxqzNQ3l
	9VHqt3dA==;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/23] media: i2c: imx258: Make V4L2_CID_VBLANK configurable.
Date: Wed, 27 Mar 2024 17:16:52 -0600
Message-ID: <20240327231710.53188-7-git@luigi311.com>
In-Reply-To: <20240327231710.53188-1-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The values and ranges of V4L2_CID_VBLANK are all computed,
so there is no reason for it to be a read only control.
Remove the register values from the mode lists, add the
handler, and remove the read only flag.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx258.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 495eaada2945..321b504c6a48 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -30,6 +30,8 @@
 #define IMX258_VTS_30FPS_VGA		0x034c
 #define IMX258_VTS_MAX			0xffff
 
+#define IMX258_REG_VTS			0x0340
+
 /* HBLANK control - read only */
 #define IMX258_PPL_DEFAULT		5352
 
@@ -202,8 +204,6 @@ static const struct imx258_reg mode_4208x3120_regs[] = {
 	{ 0x0114, 0x03 },
 	{ 0x0342, 0x14 },
 	{ 0x0343, 0xE8 },
-	{ 0x0340, 0x0C },
-	{ 0x0341, 0x50 },
 	{ 0x0344, 0x00 },
 	{ 0x0345, 0x00 },
 	{ 0x0346, 0x00 },
@@ -319,8 +319,6 @@ static const struct imx258_reg mode_2104_1560_regs[] = {
 	{ 0x0114, 0x03 },
 	{ 0x0342, 0x14 },
 	{ 0x0343, 0xE8 },
-	{ 0x0340, 0x06 },
-	{ 0x0341, 0x38 },
 	{ 0x0344, 0x00 },
 	{ 0x0345, 0x00 },
 	{ 0x0346, 0x00 },
@@ -436,8 +434,6 @@ static const struct imx258_reg mode_1048_780_regs[] = {
 	{ 0x0114, 0x03 },
 	{ 0x0342, 0x14 },
 	{ 0x0343, 0xE8 },
-	{ 0x0340, 0x03 },
-	{ 0x0341, 0x4C },
 	{ 0x0344, 0x00 },
 	{ 0x0345, 0x00 },
 	{ 0x0346, 0x00 },
@@ -800,6 +796,11 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
 					       BIT(IMX258_HDR_RATIO_MAX));
 		}
 		break;
+	case V4L2_CID_VBLANK:
+		ret = imx258_write_reg(imx258, IMX258_REG_VTS,
+				       IMX258_REG_VALUE_16BIT,
+				       imx258->cur_mode->height + ctrl->val);
+		break;
 	default:
 		dev_info(&client->dev,
 			 "ctrl(id:0x%x,val:0x%x) is not handled\n",
@@ -1174,9 +1175,6 @@ static int imx258_init_controls(struct imx258 *imx258)
 				IMX258_VTS_MAX - imx258->cur_mode->height, 1,
 				vblank_def);
 
-	if (imx258->vblank)
-		imx258->vblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-
 	imx258->hblank = v4l2_ctrl_new_std(
 				ctrl_hdlr, &imx258_ctrl_ops, V4L2_CID_HBLANK,
 				IMX258_PPL_DEFAULT - imx258->cur_mode->width,
-- 
2.42.0


