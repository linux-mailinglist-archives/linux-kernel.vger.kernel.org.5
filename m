Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF16769024
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGaIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjGaI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F19F3;
        Mon, 31 Jul 2023 01:29:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Th1c054928;
        Mon, 31 Jul 2023 03:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792183;
        bh=f11LvrUHHrhSxqoyWhzGOI4P5iMX9ShOjPmVP2XMkJg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d+n44sdDHEbv3dhvHaw3F7UMfNo9TpOt7q4YJhr/5bsT8pAE1ugAcKCFQGAkcP9Mj
         KUr5sVzg/WwwuzNmAgOzPvTJSbv09kErbOiZVXPx2sCRb+tR3PgT1UvOJJuwtrlXnh
         D188rsYgk/0M4FhxV4MvDgGpzCrkG9MYALoV3lsg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8Th44087130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8Tg2K041912;
        Mon, 31 Jul 2023 03:29:42 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 07/16] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
Date:   Mon, 31 Jul 2023 13:59:25 +0530
Message-ID: <20230731-upstream_csi-v8-7-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5126; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Zg+yj72vrkFlduO50TkQvqyoIx4FRlQhTc0ybjxRTzc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xp0qSs22B4I6NBza5yQFAQ+Wc/fVM658Mny
 tRO1h59kASJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsaQAKCRBD3pH5JJpx
 RZP+EADBMXQKMA8KV31PtDzH+q9reKoY/zYDOo59f8eqmBMVFJdOjN+/8uspCm0M1+7hE7r1QNd
 L75+/V+yDwAXPjrU5h01v9adfOLqGAm05xyziyxa/AolRlhyo3YSZiudc8yW6EQWqHHUXsCa0LN
 J/pHOQh3l95GVZQSNEjVL7ZeowL13OjVheQiJNmqc/RM9pgYJ8zN4FaoKeq4eSs6wsrMBFcbvvc
 g/ma4LxKwJL77U/px/ksvEIN8REE9zY76wSD8Xe0vzsKBHaS79pnkcd0l9eszOBTym9R12xqTqe
 wwIKnHKZb2MFQNrEzCm6kJoDmJqbz+ayM/XRxZSaocRsksOeyUJEF0/gD14ktaCWq9Fx2e206/Q
 w65s3rBib8RQGQzzyfjcyOGd+zgxepWb/ZJtyGPhuhkomN+WMGJmhU7c5eKlyI9bjZncfERnpc+
 1uAJBLUZ7TW3Pzrape+B0nKtQE1KcpzpZSJM5IQ1ZBT7vvQHe0VqBSY/ud4VWcbwZ0mAliUzSEk
 IfeBirZ5iuiJ5oMKymEZOSf56SYrSgRbFnlC+JsCxLkRDdM+zH1eZCN9ThC/kJlby8vsBYfgQQh
 pI1NXRkvk3h3M5+7g2lOfjUwle190J+ub/IStmJTtxhFoVg/t0WUbnMtcssBHbZzSrk1+Fm6lZD
 ql7qNSmtlZGKbyQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
v7->v8:
- Use active subdev state to use v4l2_subdev_get_fmt
- Propagate formats from sink to source pads
- Drop Laurent's R-by because of the above changes

 drivers/media/platform/cadence/cdns-csi2rx.c | 107 ++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 83d1fadd592b..4f9654366485 100644
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
@@ -95,6 +100,36 @@ struct csi2rx_priv {
 	int				source_pad;
 };
 
+static const struct csi2rx_fmt formats[] = {
+	{
+		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.bpp	= 16,
+	},
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
@@ -303,12 +338,75 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
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
+		.which = state ? V4L2_SUBDEV_FORMAT_TRY
+			: V4L2_SUBDEV_FORMAT_ACTIVE,
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
@@ -532,9 +630,13 @@ static int csi2rx_probe(struct platform_device *pdev)
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
@@ -544,6 +646,8 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_state:
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -560,6 +664,7 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
+	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
 	kfree(csi2rx);
 }

-- 
2.41.0
