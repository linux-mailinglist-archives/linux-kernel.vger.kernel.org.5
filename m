Return-Path: <linux-kernel+bounces-82703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EB86885F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F85B2661B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6252F8B;
	Tue, 27 Feb 2024 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i63QeADV"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D1524BB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009092; cv=fail; b=cQIt5Ozd7GgOnObwjZlSwLpYNbRDnR0VscLsecAGH4MvDaiAb1CVJNEFyaazHAO5SjdcnGNwIPBpTctyDKAn1T5OayeMMaBz1nOf8fsfMOJbkR/C5+JgjoK7x79ShqA4lwS/128yFUL/mxbYZZdXu6sk3yAivpoK49XE64aMP74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009092; c=relaxed/simple;
	bh=hbHi3afSwaYiqxvZTBvYZVwMdPsCtdg4zU/2X6NCrh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=atoWfS7uxpDoDK+5mJh2tDQYZYWiyzEtH17LFfGbBUcfFSzF3oGGm0H8WhQ3TF2pWWvmH0QYor/d8V7MdoF+BLo8bXbTmGo4HTC4D1R89t/QP/Ku8Yj1u7Py5SH+HPzmK1VY6VMr125VjDpHPKhcP/FbqoHYO1gn0uaMpDsXuBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i63QeADV; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l44MOzZxE77z1NYfw4yqaU7F9tIzzwrbrGaEFytLYvGAzAbQzi3MbVhyaMIw7sgKjPRq4hiDM3iQJTiHDzXW0etJedhteUuoPuoFYaNk+JiRuheLDmxvyNuRju+60tqfZobwHWjCr3W5OmP8NehLsTWhjaIQAUCeoHtzJwcTrRtBOGW1tZNgtmx1BAokEbn50cmlqk5NatzGTkXCzbnncYXMPICJG7P5yXPJa7iegVvjoJS1fpqYijGaalEa3QsPYm9azd84f3QuNqDjAcJo0lptNa1zy+QBNiiljpygHgvSVNkHXgR/P63WXWS4Hoi/MIkMlmpe88IYPoo7BD/NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmm3ANBDFb4E1feLCWp5eHU7ZLsoIaqutY1MLn9jOCc=;
 b=Pb6ImxsTwgeSX9bRLNHq7kVQBerVjqwAs5WUuCUzoryVQJUXCldsqrDYYI3UiExJ037DX+YEJwiz/cx3bsAT4XHXviTKvn+0RqZbhgDn3Sc1ccgUDkbr6f4e8xc51MRoNWUbsMxGBYy3gXw8jmW2j3HACS3TQF9UcWh7unFkmYmEyEbH+MSO7crTZqnV72T4XUtD4XpPpjt9GflFMMcxzBkTrY2Dhrh4AwPou8oDdkIfqQ+ljka0knhPLCmLXBgXhpP47hyW5npKFOoNlozPX4xSC9WA+TzDoGQOSF9M/RYb5BBg130LyIV0wPuOhlMgeq/weCXtR63OGL5aiCvIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmm3ANBDFb4E1feLCWp5eHU7ZLsoIaqutY1MLn9jOCc=;
 b=i63QeADVSrFlj7dwsy4OI6mQ71X83QP0tJwVlCkpM660tUgf1+g49Tv2aQtj0wG9SIEg1fwGrTNLXQblGW3l5jPoawfhoZt6m0e0QrndKumVHKKYwgq1wQD9gaUtILfY+Yn2Hv6anMLQeuLoEpEuiCKb/1QJ5ZG9YoNUoxc21zc=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 04:44:49 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::88) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 04:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 04:44:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:48 -0600
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 22:44:47 -0600
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Mon, 26 Feb 2024 20:44:42 -0800
Subject: [PATCH 1/4] drm: xlnx: zynqmp_dpsub: Set layer mode during
 creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240226-dp-live-fmt-v1-1-b78c3f69c9d8@amd.com>
References: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
In-Reply-To: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>
X-Mailer: b4 0.12.4
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BN9PR12MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: d79432cc-4efb-4e88-89a5-08dc374ed4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAcvVeR7KvuYCvs1Yh0Mm6BLEz/rqtiD8T9XXBVCxK6VKH9Qykq4jVpyFRVllwf6Fs7BkvpinoRByBpJyGFCUeyXLQuEg1QYBj/8HBqGmQtwlyWmxg5obtjCneFarohA9pRLOztSrzToBYtfo/LdW0KIdhTIGHMIdwoErD4tBX+uiIOd1WJUePGDt5EJlF3di3eL+d1cR7bt+CCyDjV8/ktYkqY5ok0GQ6DsDq5jow+kcyX2LKaIciykv9+fyrZO4pHnn1Kute9Cgayc/MJUuf7s5fyzrjVw6keK54wqn29LXHDubH8uDvDadlmNu0x1wCXyOZ7gc1sksf+OfiFMRnjDydKUtu/v+Z5y8vah481gc4VH0ECKL47+V9znj69dUSeR0MzCF1xqPloj6+TeDUn0abJKlF55Pr0oaik1+NcYeG+dpZUaS8ep+Ie5+BX/vg+IjsESeIeaLGglMWRbYNnePUlVssXdrdsX6wtGohwior/vI/k5tDiKTeSYXdkTc6+nbYWtaXz/RW89UvEPlpsfGHBYEbzvdjO3F7H+AtOewkVJtMsOGt9js4ACUpHUcuX/oFDvPnPAISvMwBy9d43BvqfBIW9n0fXa5HhEmF3hCo8jJBALagMw57151Ac/Ukxg7E5s/iNe+8vll2q8PwdUizLEBCG3QoZ+vcVg2eVoT+pP5Lik/o4eOWBt4ZY2TK/a2AtUZTxYeeZrqmGXjcHIpvExReppYW+0HaiCUk6uMWfR5I/xF+wCQRNMoby7oohxU798nIrkFDmm4yqn6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 04:44:49.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d79432cc-4efb-4e88-89a5-08dc374ed4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353

Set layer mode of operation (live or dma-based) during layer creation.

Each DPSUB layer mode of operation is defined by corresponding DT node port
connection, so it is possible to assign it during layer object creation.
Previously it was set in layer enable functions, although it is too late
as setting layer format depends on layer mode, and should be done before
given layer enabled.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 20 ++++++++++++++++----
 drivers/gpu/drm/xlnx/zynqmp_disp.h | 13 +------------
 drivers/gpu/drm/xlnx/zynqmp_dp.c   |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c  |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 8a39b3accce5..e6d26ef60e89 100644
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
@@ -1134,6 +1141,11 @@ static int zynqmp_disp_create_layers(struct zynqmp_disp *disp)
 		layer->id = i;
 		layer->disp = disp;
 		layer->info = &layer_info[i];
+		/* For now assume dpsub works in either live or non-live mode for both layers.
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


