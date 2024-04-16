Return-Path: <linux-kernel+bounces-147524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DF8A75B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A928479B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855686BB29;
	Tue, 16 Apr 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XaFZ9WxR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA64206F;
	Tue, 16 Apr 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299523; cv=fail; b=ix4n4yFYRGOj3yoWOpdVbIM35L6Q5wDy31cAzaL7hEoifJDG/BIzjROrfs4sHArpWh7JdDvTmaG9Q/t8MqTNNWtLE6GCpvGveyXXCUlX60p2dafJTLIpfVN5BTawGbC/GHhP+AjQZwBIj93mba2LVnHCcv5l9EAjJWcH8DL54Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299523; c=relaxed/simple;
	bh=wKxVJxTXMp2+FML3u+6XuROwMKwVr0NtiY7T01R8onw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nqc11cKPOx89aO1yOlP1AED7qzi9j9U7BYqYyDZ2SZw2icS73IH7pXYi8spCBAMmZLeg7tPr4N4COjRfGdrfUIhiwb87o4LtCx+CkdZm59UVPkBh6qKc3Y5k/jH63w+5VcjRRc+uSDHxgnVrQuAl5OtrAsjgPFCvf06geFwgk8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XaFZ9WxR; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+6P8BgEYBlwZOozEUfeuHfR1DrGenlH94In/VHE8vrE/VYgSOcjOaf8aoPjfZqW1x58F6svhmDCsNjq+X4Kqy1xKbuDl6Q2NwJX0kDXUu0fLxxs5kPS7HRl9nwO83aAxFXtogIc185DLKCMRUoWIBMa+sZC47Qo9WWIFjmTFiXcAMevH4UpntN543pDCQbTioEwEU1y8e0XnLUi9S03lMfs4Wmh3kqVTxFL8H2pDl0XCrzQOal1Jo7bd98+0i4wlmXgL/3re4Uu0nNZZfOFMHSYa0P/E2dOxaeP6bbfweB/tHeCLvEmzwXWHT6Qdung2nSfvF2rf5AIxgXXrMlcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI78DgeVSuvR0lmtMiBL8BCiSiZvCDxuOJhqcDKL/2w=;
 b=lRqUJZR1ZaxNkQPXwZKmYCbNd/bbTt4DCoYtQfhVPkvmZT7+C3XMlU1scZCp9DDmnAWKApd9H7BeWF9+CxTg6ALF6Tr8BFGk1SK9iiUpV0c4vYk5zceKr35G3dKozav0ZUKe4d9F8T/FicllP8e12n6mHc4DKOmkkpoIYMV4FTjgrEIj/oKvhZ8z4qJ9QQueapIGW76DIsgCjRS+w7sp6Ju018Gtnl3R9vWsQtAIJCd/G7FuGSDg6TtJauRXEzsxAu9ArGuvMNxM3itQuf4D1oTvXU38EJWJh+V7vZdC0NXEtt2MhwRtQqhwrJj8VfoPPTJpBWVTj1dzYQFB7pu00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI78DgeVSuvR0lmtMiBL8BCiSiZvCDxuOJhqcDKL/2w=;
 b=XaFZ9WxR+OU3gTy/753pLU0J3NhYtQSGDcGw2HVdP/6aYIqgoGkFw7ZUuKnoVrJHUTLal83AK1ZurW9p7oY701LhlUDs8fGJBzrxZA5FoaCIL5Z03ELt7vSxvdoQQxl0bKlLMKVyZTqDyPpCDrRcR37tC/7yrko8aihKxba8JRA=
Received: from MN2PR06CA0012.namprd06.prod.outlook.com (2603:10b6:208:23d::17)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:31:57 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::30) by MN2PR06CA0012.outlook.office365.com
 (2603:10b6:208:23d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 20:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 20:31:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 15:31:52 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 15:31:50 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Tue, 16 Apr 2024 13:31:36 -0700
Subject: [PATCH v4 1/7] drm: xlnx: zynqmp_dpsub: Set layer mode during
 creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240416-dp-live-fmt-v4-1-c7f379b7168e@amd.com>
References: <20240416-dp-live-fmt-v4-0-c7f379b7168e@amd.com>
In-Reply-To: <20240416-dp-live-fmt-v4-0-c7f379b7168e@amd.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
	"Andrzej Hajda" <andrzej.hajda@intel.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman
	<jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	Tomi Valkeinen <tomi.valkainen@ideasonboard.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB03.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 44045ffd-305c-4e1c-91b2-08dc5e54432f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	717mzN7iONfhb8QEmFa6i4Ua5gzYIx1haiTQOgA74U+3q2js1UPXr0W7VP0nKoclP5JvnOr6WINVppeAJGrVRA/XLyfOcECm7eLDjSwKlS9xPGL3kmcAgMQZ3PsMbHG76/+N65zM7VdXYpxdjI+yYmBp1QwLdSqnPY7sgxz1PKEPpTWFycVgrTPTF02aU5xiKzUuigRGqRlgpyKa494ltk0HnxZScd0fu44v0dh/b8JdDcxIT108e7mW2EMSsSEjuPDJ3jXCi1BHjmDrTwkLeR2675vK+WNo0riHVSJwCex/7I424nzYrV6HlJRPJs+usxGyQ5JoH9lg/bu42bxX6TDZrYkqrilU+wMV6cTi3WG0Y76foJyz4ezCkpxypoaLfNIunbjnNtHllWkS6LH6n14QQLaCUmyg5vjmr1rDfJ0mE/4NGRcadj7UXSoHPjbk3qhLG5TDeJdPnmEVfaaRjXcvMxlUfwn9LdptEe1xxXgFosp5G2cVUBiSksFPVSpResqgz8MIW8Bt0A/XdGNbHpQ9T7tPzozQcnaLYqC7ik//dVTm/jhNMGi3lXvC+EEXfaOEf7wZa+S9mxfVW3h1WrM2xtb6rGEZrq5xC8cTFrw1HLwBg3M8aH0Ll63UOAwi+PmrJF3w6Au7fH5GAEZUb/XWYrISM9dNeuEU6xqd3Jq9dp52xxkRf412oejl62FzQIJktLsI3jaYIDEWhusS+VmZWxMQilpcsVwJS+hfjBx60mzRyM5srkSPPFRXqx6UwNUTXGPtD9dwHxCiLbh1Iw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:31:57.6910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44045ffd-305c-4e1c-91b2-08dc5e54432f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

Set layer mode of operation (live or dma-based) during layer creation.

Each DPSUB layer mode of operation is defined by corresponding DT node port
connection, so it is possible to assign it during layer object creation.
Previously it was set in layer enable functions, although it is too late
as setting layer format depends on layer mode, and should be done before
given layer enabled.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkainen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 21 +++++++++++++++++----
 drivers/gpu/drm/xlnx/zynqmp_disp.h | 13 +------------
 drivers/gpu/drm/xlnx/zynqmp_dp.c   |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c  |  2 +-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 8a39b3accce5..891577475349 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -64,6 +64,16 @@
 
 #define ZYNQMP_DISP_MAX_NUM_SUB_PLANES			3
 
+/**
+ * enum zynqmp_dpsub_layer_mode - Layer mode
+ * @ZYNQMP_DPSUB_LAYER_NONLIVE: non-live (memory) mode
+ * @ZYNQMP_DPSUB_LAYER_LIVE: live (stream) mode
+ */
+enum zynqmp_dpsub_layer_mode {
+	ZYNQMP_DPSUB_LAYER_NONLIVE,
+	ZYNQMP_DPSUB_LAYER_LIVE,
+};
+
 /**
  * struct zynqmp_disp_format - Display subsystem format information
  * @drm_fmt: DRM format (4CC)
@@ -902,15 +912,12 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
 /**
  * zynqmp_disp_layer_enable - Enable a layer
  * @layer: The layer
- * @mode: Operating mode of layer
  *
  * Enable the @layer in the audio/video buffer manager and the blender. DMA
  * channels are started separately by zynqmp_disp_layer_update().
  */
-void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer,
-			      enum zynqmp_dpsub_layer_mode mode)
+void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer)
 {
-	layer->mode = mode;
 	zynqmp_disp_avbuf_enable_video(layer->disp, layer);
 	zynqmp_disp_blend_layer_enable(layer->disp, layer);
 }
@@ -1134,6 +1141,12 @@ static int zynqmp_disp_create_layers(struct zynqmp_disp *disp)
 		layer->id = i;
 		layer->disp = disp;
 		layer->info = &layer_info[i];
+		/*
+		 * For now assume dpsub works in either live or non-live mode for both layers.
+		 * Hybrid mode is not supported yet.
+		 */
+		layer->mode = disp->dpsub->dma_enabled ? ZYNQMP_DPSUB_LAYER_NONLIVE
+						       : ZYNQMP_DPSUB_LAYER_LIVE;
 
 		ret = zynqmp_disp_layer_request_dma(disp, layer);
 		if (ret)
diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
index 123cffac08be..9b8b202224d9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
@@ -42,16 +42,6 @@ enum zynqmp_dpsub_layer_id {
 	ZYNQMP_DPSUB_LAYER_GFX,
 };
 
-/**
- * enum zynqmp_dpsub_layer_mode - Layer mode
- * @ZYNQMP_DPSUB_LAYER_NONLIVE: non-live (memory) mode
- * @ZYNQMP_DPSUB_LAYER_LIVE: live (stream) mode
- */
-enum zynqmp_dpsub_layer_mode {
-	ZYNQMP_DPSUB_LAYER_NONLIVE,
-	ZYNQMP_DPSUB_LAYER_LIVE,
-};
-
 void zynqmp_disp_enable(struct zynqmp_disp *disp);
 void zynqmp_disp_disable(struct zynqmp_disp *disp);
 int zynqmp_disp_setup_clock(struct zynqmp_disp *disp,
@@ -62,8 +52,7 @@ void zynqmp_disp_blend_set_global_alpha(struct zynqmp_disp *disp,
 
 u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
 				   unsigned int *num_formats);
-void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer,
-			      enum zynqmp_dpsub_layer_mode mode);
+void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
 void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
 void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
 				  const struct drm_format_info *info);
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 1846c4971fd8..04b6bcac3b07 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1295,7 +1295,7 @@ static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
 	/* TODO: Make the format configurable. */
 	info = drm_format_info(DRM_FORMAT_YUV422);
 	zynqmp_disp_layer_set_format(layer, info);
-	zynqmp_disp_layer_enable(layer, ZYNQMP_DPSUB_LAYER_LIVE);
+	zynqmp_disp_layer_enable(layer);
 
 	if (layer_id == ZYNQMP_DPSUB_LAYER_GFX)
 		zynqmp_disp_blend_set_global_alpha(dp->dpsub->disp, true, 255);
diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index db3bb4afbfc4..43bf416b33d5 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -122,7 +122,7 @@ static void zynqmp_dpsub_plane_atomic_update(struct drm_plane *plane,
 
 	/* Enable or re-enable the plane if the format has changed. */
 	if (format_changed)
-		zynqmp_disp_layer_enable(layer, ZYNQMP_DPSUB_LAYER_NONLIVE);
+		zynqmp_disp_layer_enable(layer);
 }
 
 static const struct drm_plane_helper_funcs zynqmp_dpsub_plane_helper_funcs = {

-- 
2.25.1


