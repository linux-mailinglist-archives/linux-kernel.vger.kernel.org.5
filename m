Return-Path: <linux-kernel+bounces-76430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77085F742
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D011F287F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19473FB2F;
	Thu, 22 Feb 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fseJfSx0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641F54F94;
	Thu, 22 Feb 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601630; cv=none; b=AtZWAL2JLp9lloBTFLhUIDM3yfXv/1QzMM3/Vdai/SQPBBAxF3NXwO2lBNx//bMJh4NUtMSyBSW68VJMb657SMgf04V6k572MHW8TFzw4T6opPdnUUixiMSKU8rXimmIRVUe/+Oyu8t4nKuGrA8tNV0Dz4AMCffdrUGrOAQj8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601630; c=relaxed/simple;
	bh=WfP2M++UZHmobW4n0X1+ukfph/52tAvXyfl7uynbcSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IsDax/UlUd/CIoSnnBVPVBtchNg38utmofzTaHynCxeH5zyi4p+a4tYjhtnjRSyzF50t7iQvdHqT3OCQ8eeIIAYyhuNAoE6k3oiAgZ6Y5UWABmktA0uq2HEzs1DD7y5BVCY1usSNcLUtXJ8t5Y7ROEtpiffoVJA8FF6pfXIFCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fseJfSx0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXarm018107;
	Thu, 22 Feb 2024 05:33:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601616;
	bh=fBRydw75ApRmvvqdKjFPWvCH74RUiQ+/VsEaFBfSZYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=fseJfSx0IVJ0WMH/ZXJPYPZZqZtVgJhdsw5dp20GKwFVFKUdsyvpkzXdcTS/meRhx
	 8saQmKgi42TD7ah0JUN4dOLTR5jVhI1Veou6gL6pU3a9KGBFitmmfAOxUdvbV3B3q/
	 h8vLD53XcxqifI1LQSs5HsKZKcMCL1wcZDaUwoY0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBXaC5057384
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:36 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:36 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBXZ25128867;
	Thu, 22 Feb 2024 05:33:35 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:32 +0530
Subject: [PATCH RFC 16/21] SQUASH: media: cadence: csi2rx: Filter using
 MIPI virtual channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-16-1837ed916eeb@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=WfP2M++UZHmobW4n0X1+ukfph/52tAvXyfl7uynbcSk=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDp9MzO7AC1G2cfH2ka7czWOgG/S/zDVF1NY
 iY/HGsFre2JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw6QAKCRBD3pH5JJpx
 ReYdEADBa1DxNEj7OmBjq5CNyDEhfIMMTrPn4UDKlUTqbBr2SJKwr8uGhOctYxIoVz33ACealaj
 jzRzki2Gwd+0/gXS9yMB+yaz4Jvr1/gYxwNu8M3+ogXtwsasKwv99oJMPxdJ2wccLYCAhbzE9H2
 xX7RYAmHaDmcjJ/m+q5oUORZ6CT/Uy5UjXZs8un6d1C+sv+aC6UVendjGT/2VcpLmAAgMwVil3p
 SsxG6uCygPmLMfEojoj/QuD7AZWYdbW/rT7CRIbu5SLAWUlgBqsh5RImckks2yEWaRAs8h2Nma+
 i4FV0vuB7hafqdOM/R+Z85LpwiDm0wudfnA3ZtO79EV80BQUB+/aZrn2pfTwOLm3xAC4O343I6w
 wATolzrOwifl7N5blz1Uvf4WGkCWQIjUNzyVTGLMt6xV6V6SRVXQY6MBGMHIlla4epWh231tL6j
 fnN0sPZJtlvBFsWu6+hFpBHM38EI+ah553QgQKp6hLWgNi+g3NsXzlgHFPi4QyRbhQqtWc+vrc7
 N7DSRz56YUOTWZiZCQQC6zUdKE3+jPwKSIr+KGaQm65AoXEQ06vF7noIrmb55h3sYQIkIKn50Qp
 JFT0h7CDs38/ez11xgX8PNElsJ4hqFOihX1Lj5tXWmdlYz8XYE+e0CNf77UZWXXyBqOXc0i7lcX
 COvJqKm8tPhPknQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

With stream routing now supported by the driver, we can check if the
CSI-TX source provides extra bus information through frame descriptor
entries, and use it to filter for particular VCs on the source pads.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 59 +++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index f08d3b845dc9..f96638b9f252 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -90,6 +90,7 @@ struct csi2rx_priv {
 	struct reset_control		*pixel_rst[CSI2RX_STREAMS_MAX];
 	struct phy			*dphy;
 
+	u32				vc_select[CSI2RX_STREAMS_MAX];
 	u8				lanes[CSI2RX_LANES_MAX];
 	u8				num_lanes;
 	u8				max_lanes;
@@ -312,11 +313,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		/*
-		 * Enable one virtual channel. When multiple virtual channels
-		 * are supported this will have to be changed.
-		 */
-		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
+		writel(csi2rx->vc_select[i],
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,
@@ -387,6 +384,48 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	}
 }
 
+static void csi2rx_update_vc_select(struct csi2rx_priv *csi2rx,
+				    struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_frame_desc fd = {0};
+	struct v4l2_subdev_route *route;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < CSI2RX_STREAMS_MAX; i++)
+		csi2rx->vc_select[i] = 0;
+
+	ret = csi2rx_get_frame_desc_from_source(csi2rx, &fd);
+	if (ret || fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		dev_dbg(csi2rx->dev,
+			"Failed to get source frame desc, allowing only VC=0\n");
+		goto err_no_fd;
+	}
+
+	/* If source provides per-stream VC info, use it to filter by VC */
+	for_each_active_route(&state->routing, route) {
+		int cdns_stream = route->source_pad - CSI2RX_PAD_SOURCE_STREAM0;
+		u8 used_vc;
+
+		for (i = 0; i < fd.num_entries; i++) {
+			if (fd.entry[i].stream == route->sink_stream) {
+				used_vc = fd.entry[i].bus.csi2.vc;
+				break;
+			}
+		}
+		csi2rx->vc_select[cdns_stream] |=
+			CSI2RX_STREAM_DATA_CFG_VC_SELECT(used_vc);
+	}
+
+err_no_fd:
+	for (i = 0; i < CSI2RX_STREAMS_MAX; i++) {
+		if (!csi2rx->vc_select[i]) {
+			csi2rx->vc_select[i] =
+				CSI2RX_STREAM_DATA_CFG_VC_SELECT(0);
+		}
+	}
+}
+
 static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
 				 struct v4l2_subdev_state *state, u32 pad,
 				 u64 streams_mask)
@@ -558,11 +597,19 @@ static int csi2rx_set_routing(struct v4l2_subdev *subdev,
 			      struct v4l2_subdev_krouting *routing)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	int ret;
 
 	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csi2rx->count)
 		return -EBUSY;
 
-	return _csi2rx_set_routing(subdev, state, routing);
+	ret = _csi2rx_set_routing(subdev, state, routing);
+
+	if (ret)
+		return ret;
+
+	csi2rx_update_vc_select(csi2rx, state);
+
+	return 0;
 }
 
 static int csi2rx_set_fmt(struct v4l2_subdev *subdev,

-- 
2.43.0


