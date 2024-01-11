Return-Path: <linux-kernel+bounces-23515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5D82ADDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563CC289606
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F94156FC;
	Thu, 11 Jan 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z1cqkIHf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6A15EB0;
	Thu, 11 Jan 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD1BC3DEE;
	Thu, 11 Jan 2024 12:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704973699;
	bh=5ZPbRJ9kHgFWIlMZiMuKCf+qLu+qB2DLgZCl7DZfSqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1cqkIHfMLZYmRW/lTIEwCbpG7nQRqV3mlk83UpZBKZWAFfSMNH25ceZMjASgAzav
	 4QdVRS3Ly526fbnazL8dOru7G597ZvpsGB33mSis344ma29O/xh/xTzUTsHHOHmdiK
	 MCzujBuiEceHM+tDAmDnPYFU6okD/bvmhtu0DMWY=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Paul Elder <paul.elder@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/11] media: rkisp1: Add match data for i.MX8MP ISP
Date: Thu, 11 Jan 2024 20:48:26 +0900
Message-Id: <20240111114831.656736-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111114831.656736-1-paul.elder@ideasonboard.com>
References: <20240111114831.656736-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add match data to the rkisp1 driver to match the i.MX8MP ISP.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-dev.c     | 23 +++++++++++++++++++
 include/uapi/linux/rkisp1-config.h            |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 2e40c376cab5..e4aac0234178 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -532,6 +532,25 @@ static const struct rkisp1_info rk3399_isp_info = {
 		  | RKISP1_FEATURE_DUAL_CROP,
 };
 
+static const char * const imx8mp_isp_clks[] = {
+	"isp",
+	"hclk",
+	"aclk",
+};
+
+static const struct rkisp1_isr_data imx8mp_isp_isrs[] = {
+	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) },
+};
+
+static const struct rkisp1_info imx8mp_isp_info = {
+	.clks = imx8mp_isp_clks,
+	.clk_size = ARRAY_SIZE(imx8mp_isp_clks),
+	.isrs = imx8mp_isp_isrs,
+	.isr_size = ARRAY_SIZE(imx8mp_isp_isrs),
+	.isp_ver = IMX8MP_V10,
+	.features = RKISP1_FEATURE_MAIN_STRIDE,
+};
+
 static const struct of_device_id rkisp1_of_match[] = {
 	{
 		.compatible = "rockchip,px30-cif-isp",
@@ -541,6 +560,10 @@ static const struct of_device_id rkisp1_of_match[] = {
 		.compatible = "rockchip,rk3399-cif-isp",
 		.data = &rk3399_isp_info,
 	},
+	{
+		.compatible = "fsl,imx8mp-isp",
+		.data = &imx8mp_isp_info,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rkisp1_of_match);
diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 730673ecc63d..f602442c2018 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -179,12 +179,14 @@
  * @RKISP1_V11: declared in the original vendor code, but not used
  * @RKISP1_V12: used at least in rk3326 and px30
  * @RKISP1_V13: used at least in rk1808
+ * @IMX8MP_V10: used in at least imx8mp
  */
 enum rkisp1_cif_isp_version {
 	RKISP1_V10 = 10,
 	RKISP1_V11,
 	RKISP1_V12,
 	RKISP1_V13,
+	IMX8MP_V10,
 };
 
 enum rkisp1_cif_isp_histogram_mode {
-- 
2.39.2


