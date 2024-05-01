Return-Path: <linux-kernel+bounces-165481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B48B8D0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FD5B22B02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C6130A6A;
	Wed,  1 May 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="BDxd7ika"
Received: from mail-108-mta57.mxroute.com (mail-108-mta57.mxroute.com [136.175.108.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84812FF91
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577448; cv=none; b=U0udo/R+xJUNuF3lUWisLnA5QfECf4wQBe+5Sfgr0fjB62PsmdLlF1xFzKKaFFMV4Zry3zY3W8moDLNkyfiP/+V+F2WO+MV+5nReuf8L1oplXHaKL+g0Z+G0cGWjxAjp3dY6DpffFNTitRGw900cV3uIqm/wZtvQI2LSqmM3EI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577448; c=relaxed/simple;
	bh=vmDWxnFYVlMeX8mv6XV77VsSX93jJDH21Yu7+jdTofM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqtLQrJvI1JYdiJaqIA7gTAqnWxax6TW0wLI2luyiZYHXRWnxm/rYBZQ17JYqHR+rQXH7lwuYn9k3Tk5cGi48ddvoYY3Kx0IT7e4OyhUHDMblxEJ8cyf53KrooroONyt3lyr1E5roC7UmSgOVbn2oJE2wWEbw+Niu2fYNCoxHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=BDxd7ika; arc=none smtp.client-ip=136.175.108.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta57.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c25ad70008ca2.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:03 +0000
X-Zone-Loop: 04dcbc96861e0e041cb007e78d4eb794c6c055f49982
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jxe1gPtYFCmEVv9eTkE7KcDWNvKsfj2RH86DpQggAUU=; b=BDxd7ika8enjRFJcq9RWv1dZE0
	LSNlyejDnXgbZX9hmXqu0aJ3C3GtGuoWKk+1Ph58L/E3QndC3h/vOhM14EE2+Jl/0c2I5kazKVx0h
	mzjdCJuWjcqfhf5DfxPAKPQTt33HzULSNGRQFqc8sCASHDmrAfFchc9HQ/R7tllLniaiixoqedhrr
	N0BhBRNSTI8gBXo4lR5noGNe3lGoJBp3jjL0YMwEePThpkwELljYbdiSBR//IywksSWPScbxpJXQo
	9JQ7/7xNV8gv/OWXVDvs3DmPTHEezEcAc5oOs4cfjjQuAnrFH+GDvB+zfk9171CR0M6U+sMM6qOnN
	NBwo49qQ==;
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
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v5 06/25] media: i2c: imx258: Make V4L2_CID_VBLANK configurable.
Date: Wed,  1 May 2024 09:24:23 -0600
Message-ID: <20240501152442.1072627-7-git@luigi311.com>
In-Reply-To: <20240501152442.1072627-1-git@luigi311.com>
References: <20240501152442.1072627-1-git@luigi311.com>
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
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
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
2.44.0


