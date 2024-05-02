Return-Path: <linux-kernel+bounces-166636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D628B9D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EEE28AE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F515B54A;
	Thu,  2 May 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CZOG+Pyu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEA15D5D1;
	Thu,  2 May 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663453; cv=none; b=B0cmcrHaExEEKQEovR1A5+Fp21JnLGdQVGP+2VKk+03Xrw+wdnIUztmBxq2QejLTdzummO8HRQ66dZCjzMBdNAGWFtUt0bOPbYn5fAF9SM0wmNxenNn70HtJceZzisevJ2hWyldfzJV9Gezlmkt9VDPzahFQ59U9U1bGScGmC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663453; c=relaxed/simple;
	bh=oBppk7OXqlSQTowafkZUwJfA2Z3z/e+P4k2kkFVQDR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUNPQE/3xLxHqz5EbGmbSbF5z6Y23djHb3bL1/eWukx6UEuoaXnBtLpbsXYzVdoC6p3vyKgiudHfN6nY1SZwcuMrINp0tunAP3MeFssJWuE7MDkmKyMNXiG0MhwoRr7MbBAONVG4HvNgAOaaQdxf+qaBDg90vko9dboKLh18w8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CZOG+Pyu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714663448;
	bh=oBppk7OXqlSQTowafkZUwJfA2Z3z/e+P4k2kkFVQDR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CZOG+Pyu7T+l5srEOOZsfUkE329TSFmpPUAHEEhKWG1gYfo3Y//n7xaa+EibLYDkp
	 oCE8OLxoV1npEVA9s6AYsfFOkmfARIFZGENOchVOEnuHCqAm5ti4UPbsTp0AABTF4Z
	 6VfEi4hkwtRWaLBLb6U4mJSXiOnNOk0jd5S06/I8bdlyAmaYzfzhAQZrtWZprLTLvB
	 DScbNN4RZO5LTdZPyLnVNPahA5OC7UcTGpVsxmR/iZsViJ3gOiOOkh6WIfpRdI6Cps
	 pJLzVvkpcibhwiWtzWI5YPk/vajCFgU4ut6HxqUPIV8Sdt9389iIbtyUeYSCFUHHr6
	 Lttb7eS9z97bg==
Received: from apertis.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0FF03782117;
	Thu,  2 May 2024 15:24:04 +0000 (UTC)
From: Julien Massot <julien.massot@collabora.com>
Date: Thu, 02 May 2024 17:22:22 +0200
Subject: [PATCH 2/2] media: convert all drivers to use
 v4l2_async_nf_unregister_cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-master-v1-2-8bd109c6a3ba@collabora.com>
References: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
In-Reply-To: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Dan Scally <djrscally@gmail.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Ripard <mripard@kernel.org>, Rui Miguel Silva <rmfrfs@gmail.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Dafna Hirschfeld <dafna@fastmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Deng <yong.deng@magewell.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Benoit Parrot <bparrot@ti.com>, Jai Luthra <j-luthra@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Michal Simek <michal.simek@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org, 
 Julien Massot <julien.massot@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

Now that we have a function to unregister and cleanup a notifier,
use it!

This patch has been generated using the following Coccinelle script:
---------8<------------
@@
expression E1;

@@
- v4l2_async_nf_unregister(E1);
- v4l2_async_nf_cleanup(E1);
+ v4l2_async_nf_unregister_cleanup(E1);
---------8<------------

Manually removed helper functions doing the same
in various driver.

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 drivers/media/i2c/ds90ub913.c                                  | 10 ++--------
 drivers/media/i2c/ds90ub953.c                                  | 10 ++--------
 drivers/media/i2c/ds90ub960.c                                  | 10 ++--------
 drivers/media/i2c/max9286.c                                    |  3 +--
 drivers/media/i2c/st-mipid02.c                                 |  6 ++----
 drivers/media/i2c/tc358746.c                                   |  3 +--
 drivers/media/pci/intel/ipu3/ipu3-cio2.c                       |  6 ++----
 drivers/media/pci/intel/ipu6/ipu6-isys.c                       |  8 +-------
 drivers/media/pci/intel/ivsc/mei_csi.c                         |  6 ++----
 drivers/media/platform/atmel/atmel-isi.c                       |  3 +--
 drivers/media/platform/cadence/cdns-csi2rx.c                   |  6 ++----
 drivers/media/platform/intel/pxa_camera.c                      |  3 +--
 drivers/media/platform/marvell/mcam-core.c                     |  6 ++----
 drivers/media/platform/microchip/microchip-csi2dc.c            |  3 +--
 drivers/media/platform/microchip/microchip-isc-base.c          |  6 ++----
 drivers/media/platform/nxp/imx-mipi-csis.c                     |  6 ++----
 drivers/media/platform/nxp/imx7-media-csi.c                    |  3 +--
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c            |  3 +--
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c                  |  6 ++----
 drivers/media/platform/qcom/camss/camss.c                      |  3 +--
 drivers/media/platform/renesas/rcar-csi2.c                     |  6 ++----
 drivers/media/platform/renesas/rcar-isp.c                      |  6 ++----
 drivers/media/platform/renesas/rcar-vin/rcar-core.c            |  9 +++------
 drivers/media/platform/renesas/rcar_drif.c                     |  3 +--
 drivers/media/platform/renesas/renesas-ceu.c                   |  4 +---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c          |  3 +--
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c          |  6 ++----
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c            |  3 +--
 drivers/media/platform/samsung/exynos4-is/media-dev.c          |  3 +--
 drivers/media/platform/st/stm32/stm32-dcmi.c                   |  3 +--
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c     |  3 +--
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c             |  3 +--
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c      |  3 +--
 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c |  3 +--
 .../platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c |  3 +--
 drivers/media/platform/ti/am437x/am437x-vpfe.c                 |  3 +--
 drivers/media/platform/ti/cal/cal.c                            |  8 +-------
 drivers/media/platform/ti/davinci/vpif_capture.c               |  3 +--
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c          | 10 ++--------
 drivers/media/platform/ti/omap3isp/isp.c                       |  3 +--
 drivers/media/platform/video-mux.c                             |  3 +--
 drivers/media/platform/xilinx/xilinx-vipp.c                    |  3 +--
 drivers/staging/media/deprecated/atmel/atmel-isc-base.c        |  6 ++----
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c         |  3 +--
 drivers/staging/media/tegra-video/vi.c                         |  3 +--
 45 files changed, 63 insertions(+), 153 deletions(-)

diff --git a/drivers/media/i2c/ds90ub913.c b/drivers/media/i2c/ds90ub913.c
index ca9bb29dab89..01afe34c0002 100644
--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -595,12 +595,6 @@ static int ub913_v4l2_notifier_register(struct ub913_data *priv)
 	return 0;
 }
 
-static void ub913_v4l2_nf_unregister(struct ub913_data *priv)
-{
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
-}
-
 static int ub913_register_clkout(struct ub913_data *priv)
 {
 	struct device *dev = &priv->client->dev;
@@ -779,7 +773,7 @@ static int ub913_subdev_init(struct ub913_data *priv)
 	return 0;
 
 err_unreg_notif:
-	ub913_v4l2_nf_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 err_subdev_cleanup:
 	v4l2_subdev_cleanup(&priv->sd);
 err_entity_cleanup:
@@ -791,7 +785,7 @@ static int ub913_subdev_init(struct ub913_data *priv)
 static void ub913_subdev_uninit(struct ub913_data *priv)
 {
 	v4l2_async_unregister_subdev(&priv->sd);
-	ub913_v4l2_nf_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 	v4l2_subdev_cleanup(&priv->sd);
 	fwnode_handle_put(priv->sd.fwnode);
 	media_entity_cleanup(&priv->sd.entity);
diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 16f88db14981..3c861dfdad49 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -811,12 +811,6 @@ static int ub953_v4l2_notifier_register(struct ub953_data *priv)
 	return 0;
 }
 
-static void ub953_v4l2_notifier_unregister(struct ub953_data *priv)
-{
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
-}
-
 /*
  * Probing
  */
@@ -1277,7 +1271,7 @@ static int ub953_subdev_init(struct ub953_data *priv)
 	return 0;
 
 err_unreg_notif:
-	ub953_v4l2_notifier_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 err_free_state:
 	v4l2_subdev_cleanup(&priv->sd);
 err_entity_cleanup:
@@ -1289,7 +1283,7 @@ static int ub953_subdev_init(struct ub953_data *priv)
 static void ub953_subdev_uninit(struct ub953_data *priv)
 {
 	v4l2_async_unregister_subdev(&priv->sd);
-	ub953_v4l2_notifier_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 	v4l2_subdev_cleanup(&priv->sd);
 	fwnode_handle_put(priv->sd.fwnode);
 	media_entity_cleanup(&priv->sd.entity);
diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index ffe5f25f8647..bdd9987d268b 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -3639,12 +3639,6 @@ static int ub960_v4l2_notifier_register(struct ub960_data *priv)
 	return 0;
 }
 
-static void ub960_v4l2_notifier_unregister(struct ub960_data *priv)
-{
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
-}
-
 static int ub960_create_subdev(struct ub960_data *priv)
 {
 	struct device *dev = &priv->client->dev;
@@ -3705,7 +3699,7 @@ static int ub960_create_subdev(struct ub960_data *priv)
 	return 0;
 
 err_unreg_notif:
-	ub960_v4l2_notifier_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 err_subdev_cleanup:
 	v4l2_subdev_cleanup(&priv->sd);
 err_entity_cleanup:
@@ -3718,7 +3712,7 @@ static int ub960_create_subdev(struct ub960_data *priv)
 
 static void ub960_destroy_subdev(struct ub960_data *priv)
 {
-	ub960_v4l2_notifier_unregister(priv);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 	v4l2_async_unregister_subdev(&priv->sd);
 
 	v4l2_subdev_cleanup(&priv->sd);
diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index d685d445cf23..3731163ee13b 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -781,8 +781,7 @@ static void max9286_v4l2_notifier_unregister(struct max9286_priv *priv)
 	if (!priv->nsources)
 		return;
 
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 }
 
 static int max9286_s_stream(struct v4l2_subdev *sd, int enable)
diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f250640729ca..2aa1bded70d9 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -909,8 +909,7 @@ static int mipid02_probe(struct i2c_client *client)
 	return 0;
 
 unregister_notifier:
-	v4l2_async_nf_unregister(&bridge->notifier);
-	v4l2_async_nf_cleanup(&bridge->notifier);
+	v4l2_async_nf_unregister_cleanup(&bridge->notifier);
 power_off:
 	mipid02_set_power_off(bridge);
 entity_cleanup:
@@ -924,8 +923,7 @@ static void mipid02_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
 
-	v4l2_async_nf_unregister(&bridge->notifier);
-	v4l2_async_nf_cleanup(&bridge->notifier);
+	v4l2_async_nf_unregister_cleanup(&bridge->notifier);
 	v4l2_async_unregister_subdev(&bridge->sd);
 	mipid02_set_power_off(bridge);
 	media_entity_cleanup(&bridge->sd.entity);
diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index d676adc4401b..ca375b6ccf86 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -1607,8 +1607,7 @@ static void tc358746_remove(struct i2c_client *client)
 	v4l2_subdev_cleanup(sd);
 	v4l2_ctrl_handler_free(&tc358746->ctrl_hdl);
 	v4l2_fwnode_endpoint_free(&tc358746->csi_vep);
-	v4l2_async_nf_unregister(&tc358746->notifier);
-	v4l2_async_nf_cleanup(&tc358746->notifier);
+	v4l2_async_nf_unregister_cleanup(&tc358746->notifier);
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
 
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 81ec8630453b..b110eb958a98 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1770,8 +1770,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	return 0;
 
 fail_clean_notifier:
-	v4l2_async_nf_unregister(&cio2->notifier);
-	v4l2_async_nf_cleanup(&cio2->notifier);
+	v4l2_async_nf_unregister_cleanup(&cio2->notifier);
 	cio2_queues_exit(cio2);
 fail_v4l2_device_unregister:
 	v4l2_device_unregister(&cio2->v4l2_dev);
@@ -1790,8 +1789,7 @@ static void cio2_pci_remove(struct pci_dev *pci_dev)
 	struct cio2_device *cio2 = pci_get_drvdata(pci_dev);
 
 	media_device_unregister(&cio2->media_dev);
-	v4l2_async_nf_unregister(&cio2->notifier);
-	v4l2_async_nf_cleanup(&cio2->notifier);
+	v4l2_async_nf_unregister_cleanup(&cio2->notifier);
 	cio2_queues_exit(cio2);
 	cio2_fbpt_exit_dummy(cio2);
 	v4l2_device_unregister(&cio2->v4l2_dev);
diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys.c b/drivers/media/pci/intel/ipu6/ipu6-isys.c
index 5992138c7290..1e76df39e010 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys.c
@@ -767,12 +767,6 @@ static int isys_notifier_init(struct ipu6_isys *isys)
 	return ret;
 }
 
-static void isys_notifier_cleanup(struct ipu6_isys *isys)
-{
-	v4l2_async_nf_unregister(&isys->notifier);
-	v4l2_async_nf_cleanup(&isys->notifier);
-}
-
 static int isys_register_devices(struct ipu6_isys *isys)
 {
 	struct device *dev = &isys->adev->auxdev.dev;
@@ -942,7 +936,7 @@ static void isys_remove(struct auxiliary_device *auxdev)
 			       fwmsg, fwmsg->dma_addr, 0);
 
 	isys_unregister_devices(isys);
-	isys_notifier_cleanup(isys);
+	v4l2_async_nf_unregister_cleanup(&isys->notifier);
 
 	cpu_latency_qos_remove_request(&isys->pm_qos);
 
diff --git a/drivers/media/pci/intel/ivsc/mei_csi.c b/drivers/media/pci/intel/ivsc/mei_csi.c
index 89b582a221ab..ae9fe6f63544 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -752,8 +752,7 @@ static int mei_csi_probe(struct mei_cl_device *cldev,
 
 err_ctrl_handler:
 	v4l2_ctrl_handler_free(&csi->ctrl_handler);
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 
 err_disable:
 	mei_cldev_disable(cldev);
@@ -768,8 +767,7 @@ static void mei_csi_remove(struct mei_cl_device *cldev)
 {
 	struct mei_csi *csi = mei_cldev_get_drvdata(cldev);
 
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 	v4l2_ctrl_handler_free(&csi->ctrl_handler);
 	v4l2_async_unregister_subdev(&csi->subdev);
 	v4l2_subdev_cleanup(&csi->subdev);
diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index c1108df72dd5..9753c5823b62 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1327,8 +1327,7 @@ static void atmel_isi_remove(struct platform_device *pdev)
 			isi->p_fb_descriptors,
 			isi->fb_descriptors_phys);
 	pm_runtime_disable(&pdev->dev);
-	v4l2_async_nf_unregister(&isi->notifier);
-	v4l2_async_nf_cleanup(&isi->notifier);
+	v4l2_async_nf_unregister_cleanup(&isi->notifier);
 	v4l2_device_unregister(&isi->v4l2_dev);
 }
 
diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 6f7d27a48eff..8d9147edbb83 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -722,8 +722,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 err_free_state:
 	v4l2_subdev_cleanup(&csi2rx->subdev);
 err_cleanup:
-	v4l2_async_nf_unregister(&csi2rx->notifier);
-	v4l2_async_nf_cleanup(&csi2rx->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi2rx->notifier);
 	media_entity_cleanup(&csi2rx->subdev.entity);
 err_free_priv:
 	kfree(csi2rx);
@@ -734,8 +733,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&csi2rx->notifier);
-	v4l2_async_nf_cleanup(&csi2rx->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
diff --git a/drivers/media/platform/intel/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
index d904952bf00e..4e4150b4ee83 100644
--- a/drivers/media/platform/intel/pxa_camera.c
+++ b/drivers/media/platform/intel/pxa_camera.c
@@ -2433,8 +2433,7 @@ static void pxa_camera_remove(struct platform_device *pdev)
 	dma_release_channel(pcdev->dma_chans[1]);
 	dma_release_channel(pcdev->dma_chans[2]);
 
-	v4l2_async_nf_unregister(&pcdev->notifier);
-	v4l2_async_nf_cleanup(&pcdev->notifier);
+	v4l2_async_nf_unregister_cleanup(&pcdev->notifier);
 
 	v4l2_device_unregister(&pcdev->v4l2_dev);
 
diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index 66688b4aece5..5f3296ec981a 100644
--- a/drivers/media/platform/marvell/mcam-core.c
+++ b/drivers/media/platform/marvell/mcam-core.c
@@ -1907,8 +1907,7 @@ int mccic_register(struct mcam_camera *cam)
 	return 0;
 
 out:
-	v4l2_async_nf_unregister(&cam->notifier);
-	v4l2_async_nf_cleanup(&cam->notifier);
+	v4l2_async_nf_unregister_cleanup(&cam->notifier);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mccic_register);
@@ -1928,8 +1927,7 @@ void mccic_shutdown(struct mcam_camera *cam)
 	if (cam->buffer_mode == B_vmalloc)
 		mcam_free_dma_bufs(cam);
 	v4l2_ctrl_handler_free(&cam->ctrl_handler);
-	v4l2_async_nf_unregister(&cam->notifier);
-	v4l2_async_nf_cleanup(&cam->notifier);
+	v4l2_async_nf_unregister_cleanup(&cam->notifier);
 }
 EXPORT_SYMBOL_GPL(mccic_shutdown);
 
diff --git a/drivers/media/platform/microchip/microchip-csi2dc.c b/drivers/media/platform/microchip/microchip-csi2dc.c
index fee73260bb1e..8a1087e1415f 100644
--- a/drivers/media/platform/microchip/microchip-csi2dc.c
+++ b/drivers/media/platform/microchip/microchip-csi2dc.c
@@ -750,8 +750,7 @@ static void csi2dc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	v4l2_async_unregister_subdev(&csi2dc->csi2dc_sd);
-	v4l2_async_nf_unregister(&csi2dc->notifier);
-	v4l2_async_nf_cleanup(&csi2dc->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi2dc->notifier);
 	media_entity_cleanup(&csi2dc->csi2dc_sd.entity);
 }
 
diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index f3a5cbacadbe..ed7511b8ace7 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1856,10 +1856,8 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
 {
 	struct isc_subdev_entity *subdev_entity;
 
-	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
-		v4l2_async_nf_unregister(&subdev_entity->notifier);
-		v4l2_async_nf_cleanup(&subdev_entity->notifier);
-	}
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		v4l2_async_nf_unregister_cleanup(&subdev_entity->notifier);
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 }
diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index f49b06978f14..fa02a4443b79 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -1513,8 +1513,7 @@ static int mipi_csis_probe(struct platform_device *pdev)
 err_cleanup:
 	v4l2_subdev_cleanup(&csis->sd);
 	media_entity_cleanup(&csis->sd.entity);
-	v4l2_async_nf_unregister(&csis->notifier);
-	v4l2_async_nf_cleanup(&csis->notifier);
+	v4l2_async_nf_unregister_cleanup(&csis->notifier);
 	v4l2_async_unregister_subdev(&csis->sd);
 
 	return ret;
@@ -1526,8 +1525,7 @@ static void mipi_csis_remove(struct platform_device *pdev)
 	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
 
 	mipi_csis_debugfs_exit(csis);
-	v4l2_async_nf_unregister(&csis->notifier);
-	v4l2_async_nf_cleanup(&csis->notifier);
+	v4l2_async_nf_unregister_cleanup(&csis->notifier);
 	v4l2_async_unregister_subdev(&csis->sd);
 
 	if (!pm_runtime_enabled(&pdev->dev))
diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 9566ff738818..23819a8da9bf 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -2266,8 +2266,7 @@ static void imx7_csi_remove(struct platform_device *pdev)
 
 	imx7_csi_media_cleanup(csi);
 
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 	v4l2_async_unregister_subdev(&csi->sd);
 }
 
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index c2013995049c..af0f6c105573 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -223,8 +223,7 @@ static void mxc_isi_v4l2_cleanup(struct mxc_isi_dev *isi)
 {
 	unsigned int i;
 
-	v4l2_async_nf_unregister(&isi->notifier);
-	v4l2_async_nf_cleanup(&isi->notifier);
+	v4l2_async_nf_unregister_cleanup(&isi->notifier);
 
 	v4l2_device_unregister(&isi->v4l2_dev);
 	media_device_unregister(&isi->media_dev);
diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
index ba2e81f24965..70c857f62ce3 100644
--- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
+++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
@@ -917,8 +917,7 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
 
 	media_entity_cleanup(&state->sd.entity);
 	v4l2_subdev_cleanup(&state->sd);
-	v4l2_async_nf_unregister(&state->notifier);
-	v4l2_async_nf_cleanup(&state->notifier);
+	v4l2_async_nf_unregister_cleanup(&state->notifier);
 	v4l2_async_unregister_subdev(&state->sd);
 icc:
 	imx8mq_mipi_csi_release_icc(pdev);
@@ -933,8 +932,7 @@ static void imx8mq_mipi_csi_remove(struct platform_device *pdev)
 	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
 
-	v4l2_async_nf_unregister(&state->notifier);
-	v4l2_async_nf_cleanup(&state->notifier);
+	v4l2_async_nf_unregister_cleanup(&state->notifier);
 	v4l2_async_unregister_subdev(&state->sd);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1923615f0eea..ed82fb2adbd2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2052,8 +2052,7 @@ static void camss_remove(struct platform_device *pdev)
 {
 	struct camss *camss = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&camss->notifier);
-	v4l2_async_nf_cleanup(&camss->notifier);
+	v4l2_async_nf_unregister_cleanup(&camss->notifier);
 	camss_unregister_entities(camss);
 
 	if (atomic_read(&camss->ref_count) == 0)
diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/platform/renesas/rcar-csi2.c
index 582d5e35db0e..a1a956d065c0 100644
--- a/drivers/media/platform/renesas/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-csi2.c
@@ -1921,8 +1921,7 @@ static int rcsi2_probe(struct platform_device *pdev)
 	return 0;
 
 error_async:
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 error_mutex:
 	mutex_destroy(&priv->lock);
 
@@ -1933,8 +1932,7 @@ static void rcsi2_remove(struct platform_device *pdev)
 {
 	struct rcar_csi2 *priv = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&priv->notifier);
-	v4l2_async_nf_cleanup(&priv->notifier);
+	v4l2_async_nf_unregister_cleanup(&priv->notifier);
 	v4l2_async_unregister_subdev(&priv->subdev);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/media/platform/renesas/rcar-isp.c b/drivers/media/platform/renesas/rcar-isp.c
index 4512ac338ca5..b79097e80147 100644
--- a/drivers/media/platform/renesas/rcar-isp.c
+++ b/drivers/media/platform/renesas/rcar-isp.c
@@ -491,8 +491,7 @@ static int risp_probe(struct platform_device *pdev)
 
 	return 0;
 error_notifier:
-	v4l2_async_nf_unregister(&isp->notifier);
-	v4l2_async_nf_cleanup(&isp->notifier);
+	v4l2_async_nf_unregister_cleanup(&isp->notifier);
 error_pm:
 	pm_runtime_disable(&pdev->dev);
 error_mutex:
@@ -505,8 +504,7 @@ static void risp_remove(struct platform_device *pdev)
 {
 	struct rcar_isp *isp = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&isp->notifier);
-	v4l2_async_nf_cleanup(&isp->notifier);
+	v4l2_async_nf_unregister_cleanup(&isp->notifier);
 
 	v4l2_async_unregister_subdev(&isp->subdev);
 
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-core.c b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
index 809c3a38cc4a..c1b11a47affe 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
@@ -345,10 +345,8 @@ static int rvin_group_parse_of(struct rvin_dev *vin, unsigned int port,
 
 static void rvin_group_notifier_cleanup(struct rvin_dev *vin)
 {
-	if (&vin->v4l2_dev == vin->group->notifier.v4l2_dev) {
-		v4l2_async_nf_unregister(&vin->group->notifier);
-		v4l2_async_nf_cleanup(&vin->group->notifier);
-	}
+	if (&vin->v4l2_dev == vin->group->notifier.v4l2_dev)
+		v4l2_async_nf_unregister_cleanup(&vin->group->notifier);
 }
 
 static int rvin_group_notifier_init(struct rvin_dev *vin, unsigned int port,
@@ -704,8 +702,7 @@ static int rvin_parallel_parse_of(struct rvin_dev *vin)
 
 static void rvin_parallel_cleanup(struct rvin_dev *vin)
 {
-	v4l2_async_nf_unregister(&vin->notifier);
-	v4l2_async_nf_cleanup(&vin->notifier);
+	v4l2_async_nf_unregister_cleanup(&vin->notifier);
 }
 
 static int rvin_parallel_init(struct rvin_dev *vin)
diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index f21d05054341..4564d29aa091 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -1361,8 +1361,7 @@ static int rcar_drif_sdr_probe(struct rcar_drif_sdr *sdr)
 /* V4L2 SDR device remove */
 static void rcar_drif_sdr_remove(struct rcar_drif_sdr *sdr)
 {
-	v4l2_async_nf_unregister(&sdr->notifier);
-	v4l2_async_nf_cleanup(&sdr->notifier);
+	v4l2_async_nf_unregister_cleanup(&sdr->notifier);
 	v4l2_device_unregister(&sdr->v4l2_dev);
 }
 
diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
index 167760276796..3a300cc25bf3 100644
--- a/drivers/media/platform/renesas/renesas-ceu.c
+++ b/drivers/media/platform/renesas/renesas-ceu.c
@@ -1701,9 +1701,7 @@ static void ceu_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(ceudev->dev);
 
-	v4l2_async_nf_unregister(&ceudev->notifier);
-
-	v4l2_async_nf_cleanup(&ceudev->notifier);
+	v4l2_async_nf_unregister_cleanup(&ceudev->notifier);
 
 	v4l2_device_unregister(&ceudev->v4l2_dev);
 
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 280efd2a8185..85ab03029353 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -303,8 +303,7 @@ static void rzg2l_cru_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	v4l2_async_nf_unregister(&cru->notifier);
-	v4l2_async_nf_cleanup(&cru->notifier);
+	v4l2_async_nf_unregister_cleanup(&cru->notifier);
 
 	rzg2l_cru_video_unregister(cru);
 	media_device_cleanup(&cru->mdev);
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e68fcdaea207..822ad5dc46c3 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -819,8 +819,7 @@ static int rzg2l_csi2_probe(struct platform_device *pdev)
 error_subdev:
 	v4l2_subdev_cleanup(&csi2->subdev);
 error_async:
-	v4l2_async_nf_unregister(&csi2->notifier);
-	v4l2_async_nf_cleanup(&csi2->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi2->notifier);
 	media_entity_cleanup(&csi2->subdev.entity);
 error_pm:
 	pm_runtime_disable(&pdev->dev);
@@ -832,8 +831,7 @@ static void rzg2l_csi2_remove(struct platform_device *pdev)
 {
 	struct rzg2l_csi2 *csi2 = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&csi2->notifier);
-	v4l2_async_nf_cleanup(&csi2->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi2->notifier);
 	v4l2_async_unregister_subdev(&csi2->subdev);
 	v4l2_subdev_cleanup(&csi2->subdev);
 	media_entity_cleanup(&csi2->subdev.entity);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index bb0202386c70..da40d5a49cdb 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -720,8 +720,7 @@ static void rkisp1_remove(struct platform_device *pdev)
 {
 	struct rkisp1_device *rkisp1 = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&rkisp1->notifier);
-	v4l2_async_nf_cleanup(&rkisp1->notifier);
+	v4l2_async_nf_unregister_cleanup(&rkisp1->notifier);
 
 	rkisp1_entities_unregister(rkisp1);
 	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index 5f10bb4eb4f7..97d6ed03b935 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1538,8 +1538,7 @@ static void fimc_md_remove(struct platform_device *pdev)
 		return;
 
 	fimc_md_unregister_clk_provider(fmd);
-	v4l2_async_nf_unregister(&fmd->subdev_notifier);
-	v4l2_async_nf_cleanup(&fmd->subdev_notifier);
+	v4l2_async_nf_unregister_cleanup(&fmd->subdev_notifier);
 
 	v4l2_device_unregister(&fmd->v4l2_dev);
 	device_remove_file(&pdev->dev, &dev_attr_subdev_conf_mode);
diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index ff3331af9406..9c3d20cef6c2 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -2089,8 +2089,7 @@ static void dcmi_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	v4l2_async_nf_unregister(&dcmi->notifier);
-	v4l2_async_nf_cleanup(&dcmi->notifier);
+	v4l2_async_nf_unregister_cleanup(&dcmi->notifier);
 	media_entity_cleanup(&dcmi->vdev->entity);
 	v4l2_device_unregister(&dcmi->v4l2_dev);
 	media_device_cleanup(&dcmi->mdev);
diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index bce821eb71ce..7602fc02978f 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -524,8 +524,7 @@ static void dcmipp_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	v4l2_async_nf_unregister(&dcmipp->notifier);
-	v4l2_async_nf_cleanup(&dcmipp->notifier);
+	v4l2_async_nf_unregister_cleanup(&dcmipp->notifier);
 
 	for (i = 0; i < dcmipp->pipe_cfg->num_ents; i++)
 		dcmipp->pipe_cfg->ents[i].release(dcmipp->entity[i]);
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index 097a3a08ef7d..ae2584eb07ca 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -265,8 +265,7 @@ static void sun4i_csi_remove(struct platform_device *pdev)
 	struct sun4i_csi *csi = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 	vb2_video_unregister_device(&csi->vdev);
 	media_device_unregister(&csi->mdev);
 	sun4i_csi_dma_unregister(csi);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index d006d9dd0170..f2412e663d2a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -863,8 +863,7 @@ void sun6i_csi_bridge_cleanup(struct sun6i_csi_device *csi_dev)
 	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
 	struct v4l2_async_notifier *notifier = &csi_dev->bridge.notifier;
 
-	v4l2_async_nf_unregister(notifier);
-	v4l2_async_nf_cleanup(notifier);
+	v4l2_async_nf_unregister_cleanup(notifier);
 
 	v4l2_device_unregister_subdev(subdev);
 
diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index f9d4dc45b490..74540146181f 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -577,8 +577,7 @@ sun6i_mipi_csi2_bridge_cleanup(struct sun6i_mipi_csi2_device *csi2_dev)
 	struct v4l2_async_notifier *notifier = &csi2_dev->bridge.notifier;
 
 	v4l2_async_unregister_subdev(subdev);
-	v4l2_async_nf_unregister(notifier);
-	v4l2_async_nf_cleanup(notifier);
+	v4l2_async_nf_unregister_cleanup(notifier);
 	media_entity_cleanup(&subdev->entity);
 }
 
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
index 4a5698eb12b7..13c640192d0a 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
@@ -615,8 +615,7 @@ sun8i_a83t_mipi_csi2_bridge_cleanup(struct sun8i_a83t_mipi_csi2_device *csi2_dev
 	struct v4l2_async_notifier *notifier = &csi2_dev->bridge.notifier;
 
 	v4l2_async_unregister_subdev(subdev);
-	v4l2_async_nf_unregister(notifier);
-	v4l2_async_nf_cleanup(notifier);
+	v4l2_async_nf_unregister_cleanup(notifier);
 	media_entity_cleanup(&subdev->entity);
 }
 
diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index 77e12457d149..bdaf52d77b24 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -2485,8 +2485,7 @@ static void vpfe_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	v4l2_async_nf_unregister(&vpfe->notifier);
-	v4l2_async_nf_cleanup(&vpfe->notifier);
+	v4l2_async_nf_unregister_cleanup(&vpfe->notifier);
 	video_unregister_device(&vpfe->video_dev);
 	v4l2_device_unregister(&vpfe->v4l2_dev);
 }
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 528909ae4bd6..65f812197dc1 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -902,12 +902,6 @@ static int cal_async_notifier_register(struct cal_dev *cal)
 	return ret;
 }
 
-static void cal_async_notifier_unregister(struct cal_dev *cal)
-{
-	v4l2_async_nf_unregister(&cal->notifier);
-	v4l2_async_nf_cleanup(&cal->notifier);
-}
-
 /* ------------------------------------------------------------------
  *	Media and V4L2 device handling
  * ------------------------------------------------------------------
@@ -952,7 +946,7 @@ static void cal_media_unregister(struct cal_dev *cal)
 	for (i = 0; i < cal->num_contexts; i++)
 		cal_ctx_v4l2_unregister(cal->ctx[i]);
 
-	cal_async_notifier_unregister(cal);
+	v4l2_async_nf_unregister_cleanup(&cal->notifier);
 	media_device_unregister(&cal->mdev);
 }
 
diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index c28794b6677b..3bcd5f305d8f 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1720,8 +1720,7 @@ static void vpif_remove(struct platform_device *device)
 	struct channel_obj *ch;
 	int i;
 
-	v4l2_async_nf_unregister(&vpif_obj.notifier);
-	v4l2_async_nf_cleanup(&vpif_obj.notifier);
+	v4l2_async_nf_unregister_cleanup(&vpif_obj.notifier);
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
 
 	kfree(vpif_obj.sd);
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 22442fce7607..75498d18a692 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1074,12 +1074,6 @@ static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
 	media_device_cleanup(&csi->mdev);
 }
 
-static void ti_csi2rx_cleanup_subdev(struct ti_csi2rx_dev *csi)
-{
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
-}
-
 static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx_dev *csi)
 {
 	vb2_queue_release(&csi->vidq);
@@ -1129,7 +1123,7 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	return 0;
 
 err_subdev:
-	ti_csi2rx_cleanup_subdev(csi);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 err_vb2q:
 	ti_csi2rx_cleanup_vb2q(csi);
 err_v4l2:
@@ -1148,7 +1142,7 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
 	video_unregister_device(&csi->vdev);
 
 	ti_csi2rx_cleanup_vb2q(csi);
-	ti_csi2rx_cleanup_subdev(csi);
+	v4l2_async_nf_unregister_cleanup(&csi->notifier);
 	ti_csi2rx_cleanup_v4l2(csi);
 	ti_csi2rx_cleanup_dma(csi);
 
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 1cda23244c7b..4d3ae5832d37 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -2001,8 +2001,7 @@ static void isp_remove(struct platform_device *pdev)
 {
 	struct isp_device *isp = platform_get_drvdata(pdev);
 
-	v4l2_async_nf_unregister(&isp->notifier);
-	v4l2_async_nf_cleanup(&isp->notifier);
+	v4l2_async_nf_unregister_cleanup(&isp->notifier);
 	isp_unregister_entities(isp);
 	isp_cleanup_modules(isp);
 	isp_xclk_cleanup(isp);
diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 31e9e92e723e..d46379a4cd76 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -471,8 +471,7 @@ static void video_mux_remove(struct platform_device *pdev)
 	struct video_mux *vmux = platform_get_drvdata(pdev);
 	struct v4l2_subdev *sd = &vmux->subdev;
 
-	v4l2_async_nf_unregister(&vmux->notifier);
-	v4l2_async_nf_cleanup(&vmux->notifier);
+	v4l2_async_nf_unregister_cleanup(&vmux->notifier);
 	v4l2_async_unregister_subdev(sd);
 	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
index 996684a73038..52bd0946c314 100644
--- a/drivers/media/platform/xilinx/xilinx-vipp.c
+++ b/drivers/media/platform/xilinx/xilinx-vipp.c
@@ -481,8 +481,7 @@ static void xvip_graph_cleanup(struct xvip_composite_device *xdev)
 	struct xvip_dma *dmap;
 	struct xvip_dma *dma;
 
-	v4l2_async_nf_unregister(&xdev->notifier);
-	v4l2_async_nf_cleanup(&xdev->notifier);
+	v4l2_async_nf_unregister_cleanup(&xdev->notifier);
 
 	list_for_each_entry_safe(dma, dmap, &xdev->dmas, list) {
 		xvip_dma_cleanup(dma);
diff --git a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
index 305b103153d7..d01f03c326fd 100644
--- a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
@@ -1944,10 +1944,8 @@ void atmel_isc_subdev_cleanup(struct isc_device *isc)
 {
 	struct isc_subdev_entity *subdev_entity;
 
-	list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
-		v4l2_async_nf_unregister(&subdev_entity->notifier);
-		v4l2_async_nf_cleanup(&subdev_entity->notifier);
-	}
+	list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
+		v4l2_async_nf_unregister_cleanup(&subdev_entity->notifier);
 
 	INIT_LIST_HEAD(&isc->subdev_entities);
 }
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
index 46a334b602f1..1064c0839fdf 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
@@ -573,8 +573,7 @@ void sun6i_isp_proc_cleanup(struct sun6i_isp_device *isp_dev)
 	struct v4l2_async_notifier *notifier = &isp_dev->proc.notifier;
 	struct v4l2_subdev *subdev = &isp_dev->proc.subdev;
 
-	v4l2_async_nf_unregister(notifier);
-	v4l2_async_nf_cleanup(notifier);
+	v4l2_async_nf_unregister_cleanup(notifier);
 
 	v4l2_device_unregister_subdev(subdev);
 	media_entity_cleanup(&subdev->entity);
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 57a856a21e90..7e23d494ef85 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1802,8 +1802,7 @@ static void tegra_vi_graph_cleanup(struct tegra_vi *vi)
 
 	list_for_each_entry(chan, &vi->vi_chans, list) {
 		vb2_video_unregister_device(&chan->video);
-		v4l2_async_nf_unregister(&chan->notifier);
-		v4l2_async_nf_cleanup(&chan->notifier);
+		v4l2_async_nf_unregister_cleanup(&chan->notifier);
 	}
 }
 

-- 
2.44.0


