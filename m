Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C787BDD6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376803AbjJINKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376710AbjJINKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C92B6;
        Mon,  9 Oct 2023 06:10:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9nCW055525;
        Mon, 9 Oct 2023 08:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856989;
        bh=bGpb3GLN/T4dyh3nBcjV+qVV/RdD272uzDzrTHNjjwE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dl/Ioopdtg9WMkVDWs+Cfy4PUT16w9RnRKTCWRdhfPIt/XRS6iie1BXDF1Q6NC6Fu
         7eCYQ1DF9lPQZpfHoaREY93giMqR/8MjcHeFiB/qrQZKX/wPkXaibjITWwCsNOKEUf
         5hCYyjmqgIQyUH+/Syt0mrqj+aDfyHRKN7mBWz88=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9nat014508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:49 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9mho117965;
        Mon, 9 Oct 2023 08:09:48 -0500
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
Subject: [PATCH v10 05/13] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
Date:   Mon, 9 Oct 2023 18:39:31 +0530
Message-ID: <20231009-upstream_csi-v10-5-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=5t1qq9VUbX4/94lsj2wyTmgoRSNIADX7Km2mBA5J5xg=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/sp4pcyzfDa11JqnxFJADGerfjALIggwbqdU
 GYowoyIBVWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7KQAKCRBD3pH5JJpx
 RbxbEACDhnX++uR9OkD5TCEHwglqAdls0JD6287seW81r1yg78Zi91aFAO3lUkhlMNE0XK52EL9
 yvPF1dg0urNMKhfN9of+K+EGoPx1+5n85Nm4fNxSk1VPK1lHk3NQgYrlT3hf+hMVwHcOs/FgtQ0
 dE5IUedCvxOpx6huEn5WTQNi5cd/qlyq+JYlOj3EXJmZuuL8dkTE9jl/lzSXkOnguBBU2SHYhKG
 AUd0SaGoD4IDz9y0eja6NFO1lH8VlYXBAvuZHi+FfggjRg8mgJcIJ8kjuNO6seXLbnE+WOY4Cd5
 SEZLVqS2slJ9CznjN6eXEsTzLwLBaoSY/yJjM+BhQNyp2iDPRiIsXajdEtYgJdRlbG3grW8CLND
 GdGRpqTpcxzsiHJ61RxIWytuk+Q/585znCjyb60m8LqPCqXSSy+48sRLkdzofHELWiM6Jh202Gn
 +guJhHSDTl4tCEZpbJ3iZBFg+OUJS5VbusUMZj5eticHYTOywYAkR2fCxverRJveoUeh3xAOAge
 fegneLujgKSOAJ+gFeMjHKw1Jvhk4a4SUEaNSJb9qsUsPYjIwGlojf3TpDoowacjox4JrkhyJJm
 24qYQGIyOImTt+jibY/e5YfuVoJCjzbB231t9Fot8M2iKGrJ9IBe+jUMnQRKVs9d0WrTpu/iKK+
 LGU5zhxi85yEdQQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Co-developed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v10:
- Remove redundant checks in set_fmt() as we ensure pad is SINK

 drivers/media/platform/cadence/cdns-csi2rx.c | 96 +++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 399b2f800dc4..f9b41451f4a4 100644
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
@@ -303,12 +334,68 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
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
+	*fmt = format->format;
+
+	/* Propagate to source formats */
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		fmt = v4l2_subdev_get_pad_format(subdev, state, i);
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
@@ -532,9 +619,13 @@ static int csi2rx_probe(struct platform_device *pdev)
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
@@ -544,6 +635,8 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_state:
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -560,6 +653,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
 	kfree(csi2rx);
 }

-- 
2.42.0
