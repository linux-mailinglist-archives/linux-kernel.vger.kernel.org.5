Return-Path: <linux-kernel+bounces-76427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536285F73C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0751F27CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B945338C;
	Thu, 22 Feb 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZSobvgg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A54F8A3;
	Thu, 22 Feb 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601626; cv=none; b=Fcgz3lqN4WOFj5SHu1rTO76oiFJqeeTuNJBXrL0ZfMCYeExGX8leT2nWP6EmJz4SEr+v1ROYGECNC58lORLRiu+ITW0rQiYTksqEcbDLMNLn30s0zZGIiEO0ApTqtMc4gbQKQj+icAnh1+oH2+KMd47X6Z6WD04rh/05duXXr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601626; c=relaxed/simple;
	bh=caGp7GvizSMoNT4KdlOqx40uaBwfhs60zrkO8TCm4es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b39KBMSeXokZ9e3j0pSYra0aldw2VT++XougPYb6osJpePWWekM98/mtq0ZfVtsARCAlXih12vnXts4s1ia83x5MZ6KxckQ7q1fCNEPNScrY78fkinFwNEOyWd2h+lsXrSJgNsQNdQxj6rixbwICwY8E2PFELlziS6LR8u68eJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZSobvgg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXWBb059162;
	Thu, 22 Feb 2024 05:33:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601612;
	bh=M0LF22QZF6XumchGpsVakuaBOLKZPFb9Ju0h5sruiyg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=fZSobvggbYfwD4k3cwMcZfshepi7vkm/70hKxzlev8n/O9mW7MOXZd4D+b4nUy1WO
	 suPGuJOoWUuyrsfw/HINCo8stFJoHCYU7ZxmEcs1ZwDSgkWBghLzi+rjggYfL+PwHb
	 pZ1BFoQExtnuj2tcwI35lMHsp7u2MNK/I4Y1CqtI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXWDC059534
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:32 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:32 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXV8s091398;
	Thu, 22 Feb 2024 05:33:31 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:30 +0530
Subject: [PATCH RFC 14/21] media: cadence: csi2rx: Enable stream-wise
 routing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-14-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=caGp7GvizSMoNT4KdlOqx40uaBwfhs60zrkO8TCm4es=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDnPMcTZn6E0hY5yUJa6GilHK/2G3ouPPN8x
 /yfWRR25u2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw5wAKCRBD3pH5JJpx
 RQrYD/9Dwn1OkvuJLiQO0qtEF/UGc4H2O5r+HWUSMcklhki/ZrYe/8HOgupxR0eLrh/KVGSoqER
 s3d7KCDgzysGFU4K0queqfKpL8MIUQvXGPoaBTN+ekPn8i0giJy44CIawqNfpKavsxcAbvZsFvq
 ovRcMII8/FT+RI/LboU11eVfmoW8vu2VwH/PwJj7AG5RwD+HOjMH9Ziy/6M/UqXBSp7Nk4CD/5V
 kVrFBoPPcfsmBUXIwrK2mdFMcteJ8tQoGFQpBOQhvJ8isMCBhnAxRqR5NMTbYqLszyw2vFFUolP
 smyRUyY1+OrLS3H0r15xAptEmyq4OtnfTp+1gptkfqNhpy5M55v5/gRmjNPDW7N446u6ZNJnwB9
 gw8loGLbhu2VpmcMIE3vEsmx9e9xyRyEg7DutmIk+kmDDoVrGSCspKUuy/0d6RgnjDdDEKFF60T
 ex8pcFOoI1lSvvdwknj4RUkjDIUuuo99UQ/Gw2kRMv7LHiY6d4nED5uH8u0qnEaLgDcdLYqlx3C
 mgdjquRYxlhsga4i7mN45Nj+0JUroSOwgXCVWPytVIEgM0/T4UcW/Kxv7xr7b6zcONskGyGJkLM
 8RwVK5Z9lncS+cmrOiiD9SP3x+OEFboizuE9KJEYFPpXBAe6/YPa1ONQrrLfObCknRBfaaRBhKG
 DK4bVZnXGVzpyBQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Cadence CSI-2 bridge IP supports capturing multiple virtual "streams"
of data over the same physical interface using MIPI Virtual Channels.

The V4L2 subdev APIs should reflect this capability and allow per-stream
routing and controls.

While the hardware IP supports usecases where streams coming in the sink
pad can be broadcasted to multiple source pads, the driver will need
significant re-architecture to make that possible. The two users of this
IP in mainline linux are TI Shim and StarFive JH7110 CAMSS, and both
have only integrated the first source pad i.e stream0 of this IP. So for
now keep it simple and only allow 1-to-1 mapping of streams from sink to
source, without any broadcasting.

This commit only adds support for subdev routing APIs, without actually
setting the registers in the Cadence IP to filter for particular virtual
channels. Subsequent commits will add that support.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 91 ++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index bac341881e41..1b76610ff617 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -450,12 +450,55 @@ static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
 	return 0;
 }
 
+static int _csi2rx_set_routing(struct v4l2_subdev *subdev,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_krouting *routing)
+{
+	static const struct v4l2_mbus_framefmt format = {
+		.width = 640,
+		.height = 480,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+	};
+	int ret;
+
+	if (routing->num_routes > V4L2_FRAME_DESC_ENTRY_MAX)
+		return -EINVAL;
+
+	ret = v4l2_subdev_routing_validate(subdev, routing,
+					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_set_routing_with_fmt(subdev, state, routing, &format);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int csi2rx_set_routing(struct v4l2_subdev *subdev,
+			      struct v4l2_subdev_state *state,
+			      enum v4l2_subdev_format_whence which,
+			      struct v4l2_subdev_krouting *routing)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csi2rx->count)
+		return -EBUSY;
+
+	return _csi2rx_set_routing(subdev, state, routing);
+}
+
 static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 			  struct v4l2_subdev_state *state,
 			  struct v4l2_subdev_format *format)
 {
 	struct v4l2_mbus_framefmt *fmt;
-	unsigned int i;
 
 	/* No transcoding, source and sink formats must match. */
 	if (format->pad != CSI2RX_PAD_SINK)
@@ -467,14 +510,19 @@ static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 	format->format.field = V4L2_FIELD_NONE;
 
 	/* Set sink format */
-	fmt = v4l2_subdev_state_get_format(state, format->pad);
+	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
+	if (!fmt)
+		return -EINVAL;
+
 	*fmt = format->format;
 
-	/* Propagate to source formats */
-	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
-		fmt = v4l2_subdev_state_get_format(state, i);
-		*fmt = format->format;
-	}
+	/* Propagate to source format */
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt)
+		return -EINVAL;
+
+	*fmt = format->format;
 
 	return 0;
 }
@@ -482,21 +530,22 @@ static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 static int csi2rx_init_state(struct v4l2_subdev *subdev,
 			     struct v4l2_subdev_state *state)
 {
-	struct v4l2_subdev_format format = {
-		.pad = CSI2RX_PAD_SINK,
-		.format = {
-			.width = 640,
-			.height = 480,
-			.code = MEDIA_BUS_FMT_UYVY8_1X16,
-			.field = V4L2_FIELD_NONE,
-			.colorspace = V4L2_COLORSPACE_SRGB,
-			.ycbcr_enc = V4L2_YCBCR_ENC_601,
-			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
-			.xfer_func = V4L2_XFER_FUNC_SRGB,
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = CSI2RX_PAD_SINK,
+			.sink_stream = 0,
+			.source_pad = CSI2RX_PAD_SOURCE_STREAM0,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
 		},
 	};
 
-	return csi2rx_set_fmt(subdev, state, &format);
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	return _csi2rx_set_routing(subdev, state, &routing);
 }
 
 static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
@@ -512,6 +561,7 @@ static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
 	.get_fmt	= v4l2_subdev_get_fmt,
 	.set_fmt	= csi2rx_set_fmt,
 	.get_frame_desc = csi2rx_get_frame_desc,
+	.set_routing	= csi2rx_set_routing,
 };
 
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
@@ -770,7 +820,8 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
-	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+		V4L2_SUBDEV_FL_STREAMS;
 	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,

-- 
2.43.0


