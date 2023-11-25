Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2A7F8D12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKYSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKYSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:23:26 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3FBD3;
        Sat, 25 Nov 2023 10:23:31 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AP1NcLd017784;
        Sat, 25 Nov 2023 19:23:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=c9CbByJ4q7lI396RIfpc5M725lJvNGjFgx6JOsUCteQ=; b=o5
        yZWac1+X0fb7sBFt9jWUkoQRhcsCMd400gt7qM1q8unVZcGHsWlw4iXh2qK1qPkI
        7zntRjJ3+sHC8MDt/lqaHS/1wjvW0Pu/F2h60UgH1zZ2yZTUKEQPiKDUvMkip6Mo
        IwovnQghzsFr0hryptFWcMc/BymCoqyhSmuwc/mqtntvZ8IMWKLlC1gQYsPnCWWj
        WUSEUhv9V550gvx5JSCt25K46McoCPy+tTjolf0r8HzATopmHDeYf/IbeV0SswYg
        uLUbzKnl9PQqR4ucROC7HA1a5rce9VgYox8NsVBceXXJnTkxGcn1OaDLRvPUne7v
        y46zu6cS4xZTp41z4zng==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk77kj4ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:23:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB99E10002A;
        Sat, 25 Nov 2023 19:23:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D06CC23C6A4;
        Sat, 25 Nov 2023 19:23:13 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:23:14 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] media: i2c: st-mipid02: use active state to store pad formats
Date:   Sat, 25 Nov 2023 19:20:52 +0100
Message-ID: <20231125182057.1379357-5-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231125182057.1379357-1-alain.volmat@foss.st.com>
References: <20231125182057.1379357-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_17,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store formats information within pad allowing to simplify further more
the driver (mutex / format store within the driver structure no more
necessary).

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 206 ++++++++++++---------------------
 1 file changed, 75 insertions(+), 131 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 15f6c9e8b7f1..7af209905d7b 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -112,9 +112,6 @@ struct mipid02_dev {
 		u8 pix_width_ctrl;
 		u8 pix_width_ctrl_emb;
 	} r;
-	/* lock to protect all members below */
-	struct mutex lock;
-	struct v4l2_mbus_framefmt fmt;
 };
 
 static int bpp_from_code(__u32 code)
@@ -192,18 +189,6 @@ static u8 data_type_from_code(__u32 code)
 	}
 }
 
-static void init_format(struct v4l2_mbus_framefmt *fmt)
-{
-	fmt->code = MEDIA_BUS_FMT_SBGGR8_1X8;
-	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB);
-	fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
-	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB);
-	fmt->width = 640;
-	fmt->height = 480;
-}
-
 static __u32 get_fmt_code(__u32 code)
 {
 	unsigned int i;
@@ -317,12 +302,13 @@ static int mipid02_detect(struct mipid02_dev *bridge)
  * will be retrieve from connected device via v4l2_get_link_freq, bit per pixel
  * and number of lanes.
  */
-static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge)
+static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge,
+					   struct v4l2_mbus_framefmt *fmt)
 {
 	struct i2c_client *client = bridge->i2c_client;
 	struct v4l2_subdev *subdev = bridge->s_subdev;
 	struct v4l2_fwnode_endpoint *ep = &bridge->rx;
-	u32 bpp = bpp_from_code(bridge->fmt.code);
+	u32 bpp = bpp_from_code(fmt->code);
 	/*
 	 * clk_lane_reg1 requires 4 times the unit interval time, and bitrate
 	 * is twice the link frequency, hence ui_4 = 1000000000 * 4 / 2
@@ -394,7 +380,8 @@ static int mipid02_configure_data1_lane(struct mipid02_dev *bridge, int nb,
 	return 0;
 }
 
-static int mipid02_configure_from_rx(struct mipid02_dev *bridge)
+static int mipid02_configure_from_rx(struct mipid02_dev *bridge,
+				     struct v4l2_mbus_framefmt *fmt)
 {
 	struct v4l2_fwnode_endpoint *ep = &bridge->rx;
 	bool are_lanes_swap = ep->bus.mipi_csi2.data_lanes[0] == 2;
@@ -419,7 +406,7 @@ static int mipid02_configure_from_rx(struct mipid02_dev *bridge)
 	bridge->r.mode_reg1 |= are_lanes_swap ? MODE_DATA_SWAP : 0;
 	bridge->r.mode_reg1 |= (nb - 1) << 1;
 
-	return mipid02_configure_from_rx_speed(bridge);
+	return mipid02_configure_from_rx_speed(bridge, fmt);
 }
 
 static int mipid02_configure_from_tx(struct mipid02_dev *bridge)
@@ -439,16 +426,17 @@ static int mipid02_configure_from_tx(struct mipid02_dev *bridge)
 	return 0;
 }
 
-static int mipid02_configure_from_code(struct mipid02_dev *bridge)
+static int mipid02_configure_from_code(struct mipid02_dev *bridge,
+				       struct v4l2_mbus_framefmt *fmt)
 {
 	u8 data_type;
 
 	bridge->r.data_id_rreg = 0;
 
-	if (bridge->fmt.code != MEDIA_BUS_FMT_JPEG_1X8) {
+	if (fmt->code != MEDIA_BUS_FMT_JPEG_1X8) {
 		bridge->r.data_selection_ctrl |= SELECTION_MANUAL_DATA;
 
-		data_type = data_type_from_code(bridge->fmt.code);
+		data_type = data_type_from_code(fmt->code);
 		if (!data_type)
 			return -EINVAL;
 		bridge->r.data_id_rreg = data_type;
@@ -485,23 +473,31 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
 static int mipid02_stream_enable(struct mipid02_dev *bridge)
 {
 	struct i2c_client *client = bridge->i2c_client;
+	struct v4l2_subdev_state *state;
+	struct v4l2_mbus_framefmt *fmt;
 	int ret = -EINVAL;
 
 	if (!bridge->s_subdev)
 		goto error;
 
 	memset(&bridge->r, 0, sizeof(bridge->r));
+
+	state = v4l2_subdev_lock_and_get_active_state(&bridge->sd);
+	fmt = v4l2_subdev_state_get_format(state, MIPID02_SINK_0);
+
 	/* build registers content */
-	ret = mipid02_configure_from_rx(bridge);
+	ret = mipid02_configure_from_rx(bridge, fmt);
 	if (ret)
 		goto error;
 	ret = mipid02_configure_from_tx(bridge);
 	if (ret)
 		goto error;
-	ret = mipid02_configure_from_code(bridge);
+	ret = mipid02_configure_from_code(bridge, fmt);
 	if (ret)
 		goto error;
 
+	v4l2_subdev_unlock_state(state);
+
 	/* write mipi registers */
 	cci_write(bridge->regmap, MIPID02_CLK_LANE_REG1,
 		  bridge->r.clk_lane_reg1, &ret);
@@ -556,11 +552,32 @@ static int mipid02_s_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
+static const struct v4l2_mbus_framefmt default_fmt = {
+	.code = MEDIA_BUS_FMT_SBGGR8_1X8,
+	.field = V4L2_FIELD_NONE,
+	.colorspace = V4L2_COLORSPACE_SRGB,
+	.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT,
+	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
+	.xfer_func = V4L2_XFER_FUNC_DEFAULT,
+	.width = 640,
+	.height = 480,
+};
+
+static int mipid02_init_cfg(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_state *state)
+{
+	*v4l2_subdev_state_get_format(state, MIPID02_SINK_0) = default_fmt;
+	/* MIPID02_SINK_1 isn't supported yet */
+	*v4l2_subdev_state_get_format(state, MIPID02_SOURCE) = default_fmt;
+
+	return 0;
+}
+
 static int mipid02_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
 {
-	struct mipid02_dev *bridge = to_mipid02_dev(sd);
+	struct v4l2_mbus_framefmt *sink_fmt;
 	int ret = 0;
 
 	switch (code->pad) {
@@ -571,10 +588,13 @@ static int mipid02_enum_mbus_code(struct v4l2_subdev *sd,
 			code->code = mipid02_supported_fmt_codes[code->index];
 		break;
 	case MIPID02_SOURCE:
-		if (code->index == 0)
-			code->code = serial_to_parallel_code(bridge->fmt.code);
-		else
+		if (code->index == 0) {
+			sink_fmt = v4l2_subdev_state_get_format(sd_state,
+								MIPID02_SINK_0);
+			code->code = serial_to_parallel_code(sink_fmt->code);
+		} else {
 			ret = -EINVAL;
+		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -583,113 +603,36 @@ static int mipid02_enum_mbus_code(struct v4l2_subdev *sd,
 	return ret;
 }
 
-static int mipid02_get_fmt(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_state *sd_state,
-			   struct v4l2_subdev_format *format)
-{
-	struct v4l2_mbus_framefmt *mbus_fmt = &format->format;
-	struct mipid02_dev *bridge = to_mipid02_dev(sd);
-	struct i2c_client *client = bridge->i2c_client;
-	struct v4l2_mbus_framefmt *fmt;
-
-	dev_dbg(&client->dev, "%s probe %d", __func__, format->pad);
-
-	if (format->pad >= MIPID02_PAD_NB)
-		return -EINVAL;
-	/* second CSI-2 pad not yet supported */
-	if (format->pad == MIPID02_SINK_1)
-		return -EINVAL;
-
-	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
-		fmt = v4l2_subdev_state_get_format(sd_state, format->pad);
-	else
-		fmt = &bridge->fmt;
-
-	mutex_lock(&bridge->lock);
-
-	*mbus_fmt = *fmt;
-	/* code may need to be converted for source */
-	if (format->pad == MIPID02_SOURCE)
-		mbus_fmt->code = serial_to_parallel_code(mbus_fmt->code);
-
-	mutex_unlock(&bridge->lock);
-
-	return 0;
-}
-
-static void mipid02_set_fmt_source(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_format *format)
-{
-	struct mipid02_dev *bridge = to_mipid02_dev(sd);
-
-	/* source pad mirror sink pad */
-	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
-		format->format = bridge->fmt;
-	else
-		format->format = *v4l2_subdev_state_get_format(sd_state,
-							       MIPID02_SINK_0);
-
-	/* but code may need to be converted */
-	format->format.code = serial_to_parallel_code(format->format.code);
-
-	/* only apply format for V4L2_SUBDEV_FORMAT_TRY case */
-	if (format->which != V4L2_SUBDEV_FORMAT_TRY)
-		return;
-
-	*v4l2_subdev_state_get_format(sd_state, MIPID02_SOURCE) =
-		format->format;
-}
-
-static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
-				 struct v4l2_subdev_state *sd_state,
-				 struct v4l2_subdev_format *format)
-{
-	struct mipid02_dev *bridge = to_mipid02_dev(sd);
-	struct v4l2_subdev_format source_fmt;
-	struct v4l2_mbus_framefmt *fmt;
-
-	format->format.code = get_fmt_code(format->format.code);
-
-	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
-		fmt = v4l2_subdev_state_get_format(sd_state, format->pad);
-	else
-		fmt = &bridge->fmt;
-
-	*fmt = format->format;
-
-	/*
-	 * Propagate the format change to the source pad, taking
-	 * care not to update the format pointer given back to user
-	 */
-	source_fmt = *format;
-	mipid02_set_fmt_source(sd, sd_state, &source_fmt);
-}
-
 static int mipid02_set_fmt(struct v4l2_subdev *sd,
 			   struct v4l2_subdev_state *sd_state,
-			   struct v4l2_subdev_format *format)
+			   struct v4l2_subdev_format *fmt)
 {
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
 	struct i2c_client *client = bridge->i2c_client;
-	int ret = 0;
+	struct v4l2_mbus_framefmt *pad_fmt;
 
-	dev_dbg(&client->dev, "%s for %d", __func__, format->pad);
+	dev_dbg(&client->dev, "%s for %d", __func__, fmt->pad);
 
-	if (format->pad >= MIPID02_PAD_NB)
-		return -EINVAL;
 	/* second CSI-2 pad not yet supported */
-	if (format->pad == MIPID02_SINK_1)
+	if (fmt->pad == MIPID02_SINK_1)
 		return -EINVAL;
 
-	mutex_lock(&bridge->lock);
+	pad_fmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
+	fmt->format.code = get_fmt_code(fmt->format.code);
 
-	if (format->pad == MIPID02_SOURCE)
-		mipid02_set_fmt_source(sd, sd_state, format);
-	else
-		mipid02_set_fmt_sink(sd, sd_state, format);
+	/* code may need to be converted */
+	if (fmt->pad == MIPID02_SOURCE)
+		fmt->format.code = serial_to_parallel_code(fmt->format.code);
 
-	mutex_unlock(&bridge->lock);
+	*pad_fmt = fmt->format;
+
+	/* Propagate the format to the source pad in case of sink pad update */
+	if (fmt->pad == MIPID02_SINK_0) {
+		pad_fmt = v4l2_subdev_state_get_format(sd_state,
+						       MIPID02_SOURCE);
+		*pad_fmt = fmt->format;
+		pad_fmt->code = serial_to_parallel_code(fmt->format.code);
+	}
 
 	return 0;
 }
@@ -699,8 +642,9 @@ static const struct v4l2_subdev_video_ops mipid02_video_ops = {
 };
 
 static const struct v4l2_subdev_pad_ops mipid02_pad_ops = {
+	.init_cfg = mipid02_init_cfg,
 	.enum_mbus_code = mipid02_enum_mbus_code,
-	.get_fmt = mipid02_get_fmt,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = mipid02_set_fmt,
 };
 
@@ -868,8 +812,6 @@ static int mipid02_probe(struct i2c_client *client)
 	if (!bridge)
 		return -ENOMEM;
 
-	init_format(&bridge->fmt);
-
 	bridge->i2c_client = client;
 	v4l2_i2c_subdev_init(&bridge->sd, client, &mipid02_subdev_ops);
 
@@ -907,7 +849,6 @@ static int mipid02_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(bridge->regmap),
 				     "failed to get cci regmap\n");
 
-	mutex_init(&bridge->lock);
 	bridge->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	bridge->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
 	bridge->sd.entity.ops = &mipid02_subdev_entity_ops;
@@ -918,7 +859,13 @@ static int mipid02_probe(struct i2c_client *client)
 				     bridge->pad);
 	if (ret) {
 		dev_err(&client->dev, "pads init failed %d", ret);
-		goto mutex_cleanup;
+		return ret;
+	}
+
+	ret = v4l2_subdev_init_finalize(&bridge->sd);
+	if (ret < 0) {
+		dev_err(dev, "subdev init error: %d\n", ret);
+		goto entity_cleanup;
 	}
 
 	/* enable clock, power and reset device if available */
@@ -962,8 +909,6 @@ static int mipid02_probe(struct i2c_client *client)
 	mipid02_set_power_off(bridge);
 entity_cleanup:
 	media_entity_cleanup(&bridge->sd.entity);
-mutex_cleanup:
-	mutex_destroy(&bridge->lock);
 
 	return ret;
 }
@@ -978,7 +923,6 @@ static void mipid02_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&bridge->sd);
 	mipid02_set_power_off(bridge);
 	media_entity_cleanup(&bridge->sd.entity);
-	mutex_destroy(&bridge->lock);
 }
 
 static const struct of_device_id mipid02_dt_ids[] = {
-- 
2.25.1

