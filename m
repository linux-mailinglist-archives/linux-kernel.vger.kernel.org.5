Return-Path: <linux-kernel+bounces-110658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F48861F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0212AB22AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260CF137767;
	Thu, 21 Mar 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Od6tbx6f"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1C135A51;
	Thu, 21 Mar 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053852; cv=fail; b=JH6c8gwzy+Ak89qjvwfLzLoohTQs69k3iChL+jS8NA1u2a8Zm22/nlidugDufnoH6HXKaL++QLOHR0t/tmFMs7EdLz0Tj2/kjUEGO7Du0AFAmsLLpnUeEG875m+kw6993hgmJwFcNMYKF7OijuCK5yxM+1p8hZDa1MueN3rGy4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053852; c=relaxed/simple;
	bh=xW5DPfKe/gruKJN+qRIBQF/4JY0Mp1c9/72kUCBmRIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uDgKjRShQTkLa/v2Gebf83BUzLBTz40psvg6MfsN3ZfzZIs9iMHqMN0XtMT7m+X217OYSppJA+srOocdTdgEbzVWyup+tcoUO6nJztslnfQOqa6NyqGwVnikdVOKvrq6PIFYtwaomn1WcjBQCxCeiHxiAN5jH/h6lM/DWnE3TPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Od6tbx6f; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELUJGs9YslPNQ4MAuteZ1On5VT51PPB9OTWvVhnG+lUEU6baJxnkLOg9a6/4dy+nfrZjHUDcYb8aO6gaLY/fSxyXazHZUyWRs0gVwxmQQ090UzUNqaAH6SjZ8IZCHqQOoMqyRIp7eOz9VTiL5pyqIvEfScyhRjc0LSVfCZ74LiA3rFZbdco5Nyu83BVLVMICqD2iEOh01nE3sD1dJDMsivE51uCQT57/fy6qowtL0eJxXMhmJMNw/+xtwqOqqcDs2Y/UhOLTHCJ6GiCxqXcX2o9aEsa3jduvhA9jxwx8v5BVagPgEXh4YFvhNXtXZu6F+YVj9d2INk3hMTJehA3zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPa9xUcbPrlbx4CkiBTHF1HNkikikjFiBO5NxPXHIPE=;
 b=GBSw747B7iaeOcp0laUemLRwsLcnqG4j0TRglp9KV5R9TyhpXcVN3zTI4cJ1YsN38cLPkwWXaB/q6hc8OdobzW2N1R+o2mlo1JC5wndPGCeMs7wrg8MIdzkqoFjU0K/LD6bd/fCe87z4u4jefKv1ACAnBo+FYQJ8ZIzA+2KDRkF1+oy//q96AmDmifsFsVVhCHW3Zc0REIdBitmStGUNnXx7/jGJGxlhRA0dEihri0slQy561JTcNT2PGtjKoJxQ60REqZ3TNavQ5hO9FZ+qTyGJBZAv4YZcjcG8vsegmmQvYRKNvHUtaZJCvh0l+gwg4Ln/+pHm1x4WIuVkDu4j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPa9xUcbPrlbx4CkiBTHF1HNkikikjFiBO5NxPXHIPE=;
 b=Od6tbx6fPy8OezmtlrKZKrPptewe2qAmu/LglkfrBDf2IifTr6Te60raHmAopQUpHmSr5Csn+if0Ejmt89au8Nv04HgGIA8V2GtRfKKTRYmO/7/3kHBvX4PUXWaxxmpvsiRdpnWOXwOf36gVMqSsq3MtLXg+bYyXlJSWYBdmewQ=
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 20:44:06 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::a6) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 21 Mar 2024 20:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 20:44:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 15:44:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 15:44:01 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 21 Mar 2024 15:44:00 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Thu, 21 Mar 2024 13:43:41 -0700
Subject: [PATCH v3 3/9] drm: xlnx: zynqmp_dpsub: Add connected live layer
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240321-dp-live-fmt-v3-3-d5090d796b7e@amd.com>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
In-Reply-To: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB05.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c45738c-40ba-4896-3476-08dc49e7a4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hKCyZ7W847d1RdohucFvVUyN0NYCpXzVcOz4WpIO7r0yutkOdRm50+rtVnIm57x7F9lVxhroCHuj7iyPBbRFCF4MZDEwBOE77avlrVve9neBgetY3Msf+J034285k73l6JDbZniH3E0D6ZpzLrmERPBWfnJ6Csi1Q3Z46n5KKrEiRYb2p9yEkcZLOHqzi3x1X8sJKAcV913usk9Qf/bT15K7ANi5KqQqb/q3ETe6ST9JSDOGkMT2c8frfeZwDPAqScdosKpUtLCxB21CG95JLJv3z+lNm5AtZjpo/LEOIoV57AP21dxp6sH2IqcWptVMEJLZKqO9AykChREWkx9UGVytv5/H6/KiUbbXTNh3ir30oxehh0suTs8y0wZPWppyOACG5D9q/9YJJQIlutw/ps+tRvtFiwhVy7/jMAcGKVy/MJupZD8kbIW+Nxs+vxQiFeQ1ZgHyl74i8ZC8S7mhzHBLlj4mmKDxunU7yWZKuz9NkxTwL0LPsc3w2XU9mcQStbhvBORLqJGjml6kQN5ec7/ew+XYY/+uHKzMxbMw25ONo86MJfGJR+rEu+TNVA5OWS8JIkYlDK74SWu1Y7WrElrqtTWYBQ3Y5J1aNbswZ/LkiesWwhuWXpMpcdqmQmAOkGQi4ScGix8vVgXkNslfGXjgasiuTiILlFA5GZ8m40AbKJ/mIHtx6Y6EgoS7rQHZImZ0WOGjGVjYQ59thVUzq8khmZSBZFdjN378eHX3xEIa926dWew8yr21t6CgR3gZR8dTaABqGVFpbCP5Fp/eTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 20:44:02.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c45738c-40ba-4896-3476-08dc49e7a4d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

Add a helper function capturing the first connected live display layer
discovery logic.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 04b6bcac3b07..4faafdd76798 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1276,28 +1276,40 @@ static void zynqmp_dp_encoder_mode_set_stream(struct zynqmp_dp *dp,
  * DISP Configuration
  */
 
+/**
+ * zynqmp_dp_disp_connected_live_layer - Return the first connected live layer
+ * @dp: DisplayPort IP core structure
+ *
+ * Return: The first connected live display layer or NULL if none of the live
+ * layer is connected.
+ */
+static struct zynqmp_disp_layer *
+zynqmp_dp_disp_connected_live_layer(struct zynqmp_dp *dp)
+{
+	if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_VIDEO))
+		return dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_VID];
+	else if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_GFX))
+		return dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_GFX];
+	else
+		return NULL;
+}
+
 static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
 				  struct drm_bridge_state *old_bridge_state)
 {
-	enum zynqmp_dpsub_layer_id layer_id;
 	struct zynqmp_disp_layer *layer;
 	const struct drm_format_info *info;
 
-	if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_VIDEO))
-		layer_id = ZYNQMP_DPSUB_LAYER_VID;
-	else if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_GFX))
-		layer_id = ZYNQMP_DPSUB_LAYER_GFX;
-	else
+	layer = zynqmp_dp_disp_connected_live_layer(dp);
+	if (!layer)
 		return;
 
-	layer = dp->dpsub->layers[layer_id];
-
 	/* TODO: Make the format configurable. */
 	info = drm_format_info(DRM_FORMAT_YUV422);
 	zynqmp_disp_layer_set_format(layer, info);
 	zynqmp_disp_layer_enable(layer);
 
-	if (layer_id == ZYNQMP_DPSUB_LAYER_GFX)
+	if (layer == dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_GFX])
 		zynqmp_disp_blend_set_global_alpha(dp->dpsub->disp, true, 255);
 	else
 		zynqmp_disp_blend_set_global_alpha(dp->dpsub->disp, false, 0);
@@ -1310,11 +1322,8 @@ static void zynqmp_dp_disp_disable(struct zynqmp_dp *dp,
 {
 	struct zynqmp_disp_layer *layer;
 
-	if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_VIDEO))
-		layer = dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_VID];
-	else if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_GFX))
-		layer = dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_GFX];
-	else
+	layer = zynqmp_dp_disp_connected_live_layer(dp);
+	if (!layer)
 		return;
 
 	zynqmp_disp_disable(dp->dpsub->disp);

-- 
2.25.1


