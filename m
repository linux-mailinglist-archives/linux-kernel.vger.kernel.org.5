Return-Path: <linux-kernel+bounces-76432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458285F748
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67321F28D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972E45BFE;
	Thu, 22 Feb 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D8ss3jhg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68256440;
	Thu, 22 Feb 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601636; cv=none; b=BNp5XaQ+v+gwJs3eSKtC8/Qxj+07Utj4O4vCPNIzGzC/TY3aJ4ZFWYopMdC881JQRnhn+9XO0l/tgV4jrcoTW2ja+TcSa93QUFGLCCwehijSk23feTQ1eJaDLCthdFujVl8/QVWq7eqquT44F2FWclxymBWPdVvzH5v2ucLLDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601636; c=relaxed/simple;
	bh=Uk6tns0lOkArX4B5O1OscMnEfvQbP1P99m1HGZqaO9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ohz/tqUd0hX46EtZrNxjIhAl7dDO4NC7K798J3VjIR9uvLxAxaapgs09F6r2welNJ4o7hahG/18ubWTReJG3Bflwo/pB5DGISt0+qn9V9uTnp/QlxhAJ5Fckcj9gr7VeWLbPaKam17F7/RdTBErqE34zTK/Zm2o/laFksamX8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D8ss3jhg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXfXi059181;
	Thu, 22 Feb 2024 05:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601621;
	bh=E2sXMQeM24E290x6U+fxQQ3J78/9SfUpDvCVA4tYbmY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=D8ss3jhgjGeRH8ZWZx3x7TMwIfALFtCkE2OHdRkapF9FOm6Xss8NWIRCqLL5LjmIi
	 KgfffziqT3G0sQI7gV5urirM8aKCV6+O11A7CNy2Y2f69nWsETC7cI5Q69rabsryT8
	 +mmY1mN8Pbqxqi9SF0JEdihXZFM/XFwPJ2ypTgJs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXfIP008002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:40 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXdP3128923;
	Thu, 22 Feb 2024 05:33:39 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:34 +0530
Subject: [PATCH RFC 18/21] media: ti: j721e-csi2rx: add multistream support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-18-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5889; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=Uk6tns0lOkArX4B5O1OscMnEfvQbP1P99m1HGZqaO9k=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDriY0aL26RG33DbX8+UJWo9eYF46K8+paTt
 VYsJTs9C6KJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw6wAKCRBD3pH5JJpx
 RVXyEACDi0DA7PqiRCqE8h72alwKttVtCliVrDLsmfOYmRcO4MMganEMxMcpklMgSpPSdlvIZhD
 02i6vjEEKIg0U3cW139gb0NuMQ35JeTrNrLduZ4ScI3rkpQfWjoxOKjqgNPzbhysp428T8AY37p
 3t8xGtDsTZLZBTHFd2V6mwEut9FLSbinWsyfwEFGzgBg8XgKe5H8xMj3iZ74i4chLiVQeYgSC6r
 nUkLL9Og1UWaF7REAywqxavAIAg3FtDsc7pxQsmyhTjUgQHMU2zRCyrQpcSC1fZlbnKmmM94qAk
 yG/+9OUrSRN/ZyV/+rGyCZkk1t46kW3SFMXdNq+UZ7GETg6EP3X3M77pVJsrTxMZuBAY6bkSu4C
 ImCIB7TFGG7XhbZmbOM+v8j1zZ7UHXS4S3LQfzXyqw39z9sdfCUngyQlvKj+5KFw0dv19f11644
 ahSxyE+D7scxmG+iOWE0TAPVrocX7ie3rWNnREDM0ru+XAXHTaJDDHxxznPajZYktvfU76XVNSk
 JFplA9i6GMdWin1FJeXvxfSKQKFNwa+d9cg2I+DCytKW/JnrPOnMT4loO12J4OJd3+tGRpNuwLa
 dwloRFNaXBzT1qlofM9ZjrxDPh9TvP6ZsYadIqJpdLgBhSTTzNw/lLoQj9EdlsixXj054qv1GgJ
 7YrN9bjF+fzwrPQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Each CSI2 stream can be multiplexed into 4 independent streams, each
identified by its virtual channel number. To capture this multiplexed
stream, the application needs to tell the driver how it wants to route
the data. It needs to specify which context should process which stream.
This is done via the new routing APIs.

Add ioctls to accept routing information from the application and save
that in the driver. This can be used when starting streaming on a
context to determine which route and consequently which virtual channel
it should process.

Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 110 +++++++++++++++++----
 1 file changed, 93 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 4be8a306ac1f..b33681e1e2db 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -905,8 +905,12 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct ti_csi2rx_dma *dma = &ctx->dma;
 	struct ti_csi2rx_buffer *buf;
+	struct v4l2_subdev_krouting *routing;
+	struct v4l2_subdev_route *route = NULL;
+	struct media_pad *remote_pad;
 	unsigned long flags;
-	int ret = 0;
+	int ret = 0, i;
+	struct v4l2_subdev_state *state;
 
 	spin_lock_irqsave(&dma->lock, flags);
 	if (list_empty(&dma->queue))
@@ -919,6 +923,40 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
+	remote_pad = media_entity_remote_source_pad_unique(ctx->pad.entity);
+	if (!remote_pad) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
+
+	routing = &state->routing;
+
+	/* Find the stream to process. */
+	for (i = 0; i < routing->num_routes; i++) {
+		struct v4l2_subdev_route *r = &routing->routes[i];
+
+		if (!(r->flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
+			continue;
+
+		if (r->source_pad != remote_pad->index)
+			continue;
+
+		route = r;
+		break;
+	}
+
+	if (!route) {
+		ret = -ENODEV;
+		v4l2_subdev_unlock_state(state);
+		goto err;
+	}
+
+	ctx->stream = route->sink_stream;
+
+	v4l2_subdev_unlock_state(state);
+
 	ret = ti_csi2rx_get_vc(ctx);
 	if (ret == -ENOIOCTLCMD)
 		ctx->vc = 0;
@@ -1019,8 +1057,8 @@ static int ti_csi2rx_sd_set_fmt(struct v4l2_subdev *sd,
 	}
 	*fmt = format->format;
 
-	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE,
-					   format->stream);
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
 	if (!fmt) {
 		ret = -EINVAL;
 		goto out;
@@ -1031,24 +1069,61 @@ static int ti_csi2rx_sd_set_fmt(struct v4l2_subdev *sd,
 	return ret;
 }
 
+static int _ti_csi2rx_sd_set_routing(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     struct v4l2_subdev_krouting *routing)
+{
+	int ret;
+
+	const struct v4l2_mbus_framefmt format = {
+		.width = 640,
+		.height = 480,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+	};
+
+	ret = v4l2_subdev_routing_validate(sd, routing,
+					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1 |
+					   V4L2_SUBDEV_ROUTING_NO_SOURCE_MULTIPLEXING);
+
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
+
+	return ret;
+}
+
+static int ti_csi2rx_sd_set_routing(struct v4l2_subdev *sd,
+				    struct v4l2_subdev_state *state,
+				    enum v4l2_subdev_format_whence which,
+				    struct v4l2_subdev_krouting *routing)
+{
+	return _ti_csi2rx_sd_set_routing(sd, state, routing);
+}
+
 static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *state)
 {
-	struct v4l2_subdev_format format = {
-		.pad = TI_CSI2RX_PAD_SINK,
-		.format = {
-			.width = 640,
-			.height = 480,
-			.code = MEDIA_BUS_FMT_UYVY8_1X16,
-			.field = V4L2_FIELD_NONE,
-			.colorspace = V4L2_COLORSPACE_SRGB,
-			.ycbcr_enc = V4L2_YCBCR_ENC_601,
-			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
-			.xfer_func = V4L2_XFER_FUNC_SRGB,
-		},
+	struct v4l2_subdev_route routes[] = { {
+		.sink_pad = 0,
+		.sink_stream = 0,
+		.source_pad = TI_CSI2RX_PAD_FIRST_SOURCE,
+		.source_stream = 0,
+		.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+	} };
+
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = 1,
+		.routes = routes,
 	};
 
-	return ti_csi2rx_sd_set_fmt(sd, state, &format);
+	/* Initialize routing to single route to the fist source pad */
+	return _ti_csi2rx_sd_set_routing(sd, state, &routing);
 }
 
 static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
@@ -1087,6 +1162,7 @@ static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
 }
 
 static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
+	.set_routing = ti_csi2rx_sd_set_routing,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ti_csi2rx_sd_set_fmt,
 };
@@ -1288,7 +1364,7 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 	v4l2_subdev_init(sd, &ti_csi2rx_subdev_ops);
 	sd->internal_ops = &ti_csi2rx_internal_ops;
 	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
-	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_STREAMS;
 	strscpy(sd->name, dev_name(csi->dev), sizeof(sd->name));
 	sd->dev = csi->dev;
 	sd->entity.ops = &ti_csi2rx_subdev_entity_ops;

-- 
2.43.0


