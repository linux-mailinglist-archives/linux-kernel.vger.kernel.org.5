Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78872778C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjHKKuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbjHKKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:49:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B314205;
        Fri, 11 Aug 2023 03:48:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAllmc014075;
        Fri, 11 Aug 2023 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750867;
        bh=1xn4wutdB9S+ICnH8G05JEjGofF52yx59UZMdla8FCA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VLJpDQ6+hB1yk1Gdi+a+9d4h2hhrdTeGjWQaDWgCubzdwat0eGEc5w4VQ2EBSBZpq
         WvrZ1ZsXALWacSrltDeHDklp9L/R8AEjG6OQazHDYtfuslrUIL7vYEKTvqGD/OZPaO
         1nJTYNelh6UsMWLR0BlydMMH1Nf06G1AwneCsAew=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAllH7041916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:47 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlkFm008242;
        Fri, 11 Aug 2023 05:47:46 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v9 05/13] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
Date:   Fri, 11 Aug 2023 16:17:27 +0530
Message-ID: <20230811-upstream_csi-v9-5-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5528; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=ULXrkEcqZ3hcqZkXWi6TKiPgYFb11EjzxQzYYL4EzUA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g78IG8xdGah5DhT53qlpSSx1uFXoYka0gMEx
 9zj4zn9enmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO/AAKCRBD3pH5JJpx
 RZfcD/9BxYxqFRffL0HxMaU/wIYd1cof60j2YJyxk8pyB2GOiH/tUTl+HtMjIvcOdNchnzEg+sX
 Qg9eOFMkMc9v2STqFV31a9XQwCDohM0ZXMdWm/9TJT900HYjmLzxkXm1x+PLeepkDUlmguPQGo5
 DgiiQ6WQb2NdGP4xJ8wbcGJw9RLzqTgZKClQnfyXWhiWrgUsviEXGhoATvwY3EtirwQFzwiNcPU
 djexoz/pxOXmhxlWvIF5gtqJqDkUpfOgQ2SOII3QAun72TUvg+Zs2+g7megyV+fYjnc+f9/iVJW
 eZ4nAHQTzkUj9ApIixW2T2S10s2iqeSG2jhL/YPxxanRqUIwIGbq5Rtbwp96c1SYgW64G2L+bmZ
 On+cb1Ey36mJkyQ0ZeG8WvmXDgO8kJH+ngDiM8jru7r0UhxOXax20jGPpXr4yY43/srg1Sf5Tr7
 u8cvayy7Oi9wCO+hmaCD99z8/JBF/P/ejxHkGhiRqgy08IQOxyqUAHx+00XdKSprA3thC5xcIGE
 44DNOmHmfK8uJY3lrPn3OkpySFVGUCUTXZqGyzRwUYqBpKhaCRDqmpg/5OLBa7hx8MwLc/M/GUP
 hO17NAO21yk1oaRcIM97thCTSwAxRzmPYZPX57vkWk2cUGEolkN/sHE14xSVGJAv/iZXcPyqZMx
 vcZIKew2lA/S38A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The format is needed to calculate the link speed for the external DPHY
configuration. It is not right to query the format from the source
subdev. Add get_fmt and set_fmt pad operations so that the format can be
configured and correct bpp be selected.

Initialize and use the v4l2 subdev active state to keep track of the
active formats. Also propagate the new format from the sink pad to all
the source pads.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Co-authored-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes from v8:
    - Squash the patch adding RAW8 and RAW10 formats within this one
    - Single line struct entries in formats[] array
    - Skip specifiying redundant format.which entry in init_cfg()

 drivers/media/platform/cadence/cdns-csi2rx.c | 101 ++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 9de3240e261c..047e74ee2443 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -61,6 +61,11 @@ enum csi2rx_pads {
 	CSI2RX_PAD_MAX,
 };
 
+struct csi2rx_fmt {
+	u32				code;
+	u8				bpp;
+};
+
 struct csi2rx_priv {
 	struct device			*dev;
 	unsigned int			count;
@@ -95,6 +100,32 @@ struct csi2rx_priv {
 	int				source_pad;
 };
 
+static const struct csi2rx_fmt formats[] = {
+	{ .code	= MEDIA_BUS_FMT_YUYV8_1X16, .bpp = 16, },
+	{ .code	= MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16, },
+	{ .code	= MEDIA_BUS_FMT_YVYU8_1X16, .bpp = 16, },
+	{ .code	= MEDIA_BUS_FMT_VYUY8_1X16, .bpp = 16, },
+	{ .code	= MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8, },
+	{ .code	= MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8, },
+	{ .code	= MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8, },
+	{ .code	= MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8, },
+	{ .code	= MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10, },
+	{ .code	= MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10, },
+	{ .code	= MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10, },
+	{ .code	= MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10, },
+};
+
+static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++)
+		if (formats[i].code == code)
+			return &formats[i];
+
+	return NULL;
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -303,12 +334,73 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	return ret;
 }
 
+static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *format)
+{
+	struct v4l2_mbus_framefmt *fmt;
+	unsigned int i;
+
+	/* No transcoding, source and sink formats must match. */
+	if (format->pad != CSI2RX_PAD_SINK)
+		return v4l2_subdev_get_fmt(subdev, state, format);
+
+	if (!csi2rx_get_fmt_by_code(format->format.code))
+		format->format.code = formats[0].code;
+
+	format->format.field = V4L2_FIELD_NONE;
+
+	/* Set sink format */
+	fmt = v4l2_subdev_get_pad_format(subdev, state, format->pad);
+	if (!fmt)
+		return -EINVAL;
+
+	*fmt = format->format;
+
+	/* Propagate to source formats */
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		fmt = v4l2_subdev_get_pad_format(subdev, state, i);
+		if (!fmt)
+			return -EINVAL;
+		*fmt = format->format;
+	}
+
+	return 0;
+}
+
+static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
+			   struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_format format = {
+		.pad = CSI2RX_PAD_SINK,
+		.format = {
+			.width = 640,
+			.height = 480,
+			.code = MEDIA_BUS_FMT_UYVY8_1X16,
+			.field = V4L2_FIELD_NONE,
+			.colorspace = V4L2_COLORSPACE_SRGB,
+			.ycbcr_enc = V4L2_YCBCR_ENC_601,
+			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+			.xfer_func = V4L2_XFER_FUNC_SRGB,
+		},
+	};
+
+	return csi2rx_set_fmt(subdev, state, &format);
+}
+
+static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
+	.get_fmt	= v4l2_subdev_get_fmt,
+	.set_fmt	= csi2rx_set_fmt,
+	.init_cfg	= csi2rx_init_cfg,
+};
+
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
 	.s_stream	= csi2rx_s_stream,
 };
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.video		= &csi2rx_video_ops,
+	.pad		= &csi2rx_pad_ops,
 };
 
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
@@ -532,9 +624,13 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	ret = v4l2_subdev_init_finalize(&csi2rx->subdev);
+	if (ret)
+		goto err_cleanup;
+
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_free_state;
 
 	dev_info(&pdev->dev,
 		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
@@ -544,6 +640,8 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_state:
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -560,6 +658,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
 	kfree(csi2rx);
 }

-- 
2.41.0
