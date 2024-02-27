Return-Path: <linux-kernel+bounces-82705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0C868860
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2221F1C22978
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D6535BD;
	Tue, 27 Feb 2024 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0o5Lzd5Q"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1D52F79
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009095; cv=fail; b=t23EbYQfa/ReyRi6VXWcxeDNxWIArqHA2FBlsi44UMdtIesj8kRvy87+j6VRCoCMddeJoFLbfzonQhJSyncOTRH303pP7XgKqHgeatC9/IlPrQXhRH+R0J3qd47YBREit3tNzwmz0JWTskVYyMD1QQRQ3dHZqOYdIe8LqHUBZRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009095; c=relaxed/simple;
	bh=/FdnEOU032s+vAQdFAq2ID7YxR3qom2rwK3pzD9YAy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BEam2acaI9EAgmEnTSuR0qoJSiPpys4IEpql8KtX7uMEp+EprvhVFQyZVzor+S8xSHBsSsfbHl12fEFMwpiSZLsbneDpCx8QAHiPup+ibF/J6zeHxdVxTgAhudrZBsh0wRLJt42Y4aPr7IYEPbpUgbZ0Ly2UzmW2CF+TCf8sQpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0o5Lzd5Q; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOkdwklHzpcFjsfnR+sQ38MiTopGQ01gpJKImq4kHch5FKzFVFsU2qTXQDR3DaFLmLjH0Jb3/GZ5WPkylAjpMWF3UgXaUBZrW8Ll37Xy/tzEizVR1vjU/NLYqQkJ6zWVCL+Gj4cjbO0EkezGV3C4PKYh32J6z4s2L+tGuHg3VXWmxF2hQbHOl9EhehEorCpzcXcFWGOvJNcix/LB/UNRC48ZY6b0HQlLTEVTYqpTjJ0sWSKhyCIx+IkarsaX4fNmkE0kCTKUJoGF3e/i9O0cnJPnVGWdhX5VDDpjKdAwLNKlkRjzpDOPN8+qV8ZIahmL4o7t8RcmBM/8eSBwCIEgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrMs2pVGrkuW3/jHrN6htLNHCNNHDIXtIlnLA1yqqrc=;
 b=h8o+CylIZrD//w5LJo6f4FS1lZGZarCB9oiEAILFcV+QdKbSF6W9u3rS9TNbMuNeNmT61Wo0lJAwkvpZ1o1ZzaLROfOoGbsYZo2g59yo4VdG6VYv0BRkL+LUiQVFVYWHkXHqSQ8Rwu71QsipD1N6WAHvV96rP2ywIACmIgzC4etatO8tNIReb10Mmy8OJf8pvoTFZFwIP5TeL69R2izZhFlN0xE6APU7nu1uh6g3+LhsPynT2JXEit9ZOXtDNgPb4AHyZAzSImIUfCIehkGOwg0CuG7UQCFEvKoJ2Kh2K22wgJ9f44qMQ74Jcg6Bxz1gWCKN340SJ+whdMYiL1Rx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrMs2pVGrkuW3/jHrN6htLNHCNNHDIXtIlnLA1yqqrc=;
 b=0o5Lzd5QJshrQqEuK73dm4f/VaWGjWr5gd0uyIaAhyQpPEpEXgP3afuVj0YJD4/QH3MU/4tLTL5qZnsLT8wZwRj4Hb+rlnV9p7i+WKERyfXkql/kW7/3ww1SLKkemkqLmsbSyv1vebgPAN6GXd6/nIMIGAMLCqPW5m4JfEJPSgc=
Received: from SJ0PR05CA0206.namprd05.prod.outlook.com (2603:10b6:a03:330::31)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 04:44:51 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::60) by SJ0PR05CA0206.outlook.office365.com
 (2603:10b6:a03:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Tue, 27 Feb 2024 04:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 04:44:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:49 -0600
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 22:44:48 -0600
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Mon, 26 Feb 2024 20:44:43 -0800
Subject: [PATCH 2/4] drm: xlnx: zynqmp_dpsub: Anounce supported input
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240226-dp-live-fmt-v1-2-b78c3f69c9d8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 02341b30-d2a7-45bb-d959-08dc374ed5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DlUm/6jJz5lPQyVunmsUY/FyRzNh7lzmHHCHQF6+gFmRC6035/1MXuoI/pmNkbPkNTxqMLFOggDVODDZK2H66g71OGLB20GZZNrf9fXmw+A4qVtgm+BqfiD3PEgFQymJOtk9MOQ80FHFp6FO0ihO+479CTXy1bw3lxmNQoA9yUO6B2JYpHzEnSuTsVNyUIt5YtmlKo+r4VfnU0FtKQTf/4rmuLQWU4ndDH7cm+Q+iwimTji6wFcZL+ombVS/ZF13DPb4H3f/SOIQTFJl56msmsBvB6njf3vuSPp03McmxngWwCTYuWW9XcgBW+wem7NaP2OjRmScuTYNnz9xor1rxoL6yLlyF2gqW7qv9/UavAt6IgXhCsNJJ77O+IAe6SHaMIcEYHdU5VQepnjhcKznRU9AdN3YF/d5WS2lLEcokKeI+kdRdul1s7xfz2o6ZuwQd0qs4Zxw0x+zInDB8wlEVxtVOjD+GSjXDvICtwahlUHEfwPk01W98AI4SOTmLgDLknB9FArCmzVNXi34A/foaDax67fUWIkciX+ROxuHQxp2eyZUhepnmmHDej+1eFxs/HiaZEgMlyJpUnOxxakxAZqu58wtR1zCO9Eaq9/Vg5Bv2/pph7/E/ciOYLOt4ZVUMyhvYh0l3JTDSmcjOw8CjXeRIB/nhFRZPBokPjQPHS3HQPGSnJSttbC0Q98PWTyGLKQjrle/w/vBmCh/ipUsIDyxZXt5RFq76w5nkOzHYCOrB7vs2YTCZ9xhLAv/BnIZcmw1qvfGt9DXCfJEHupG0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 04:44:51.0394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02341b30-d2a7-45bb-d959-08dc374ed5aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

DPSUB in bridge mode supports multiple input media bus formats.

Announce the list of supported input media bus formats via
drm_bridge.atomic_get_input_bus_fmts callback.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xlnx/zynqmp_disp.h | 10 ++++++++++
 drivers/gpu/drm/xlnx/zynqmp_dp.c   |  1 +
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index e6d26ef60e89..ee99aad915ba 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -18,6 +18,7 @@
 #include <linux/dma/xilinx_dpdma.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -77,12 +78,14 @@ enum zynqmp_dpsub_layer_mode {
 /**
  * struct zynqmp_disp_format - Display subsystem format information
  * @drm_fmt: DRM format (4CC)
+ * @bus_fmt: Media bus format
  * @buf_fmt: AV buffer format
  * @swap: Flag to swap R & B for RGB formats, and U & V for YUV formats
  * @sf: Scaling factors for color components
  */
 struct zynqmp_disp_format {
 	u32 drm_fmt;
+	u32 bus_fmt;
 	u32 buf_fmt;
 	bool swap;
 	const u32 *sf;
@@ -364,6 +367,40 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
 	},
 };
 
+/* List of live video layer formats */
+static const struct zynqmp_disp_format avbuf_live_fmts[] = {
+	{
+		.drm_fmt	= DRM_FORMAT_VYUY,
+		.bus_fmt	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_8 |
+				  ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422,
+		.sf		= scaling_factors_888,
+	},
+};
+
+u32 *zynqmp_disp_get_input_bus_fmts(struct drm_bridge *bridge,
+				    struct drm_bridge_state *bridge_state,
+				    struct drm_crtc_state *crtc_state,
+				    struct drm_connector_state *conn_state,
+				    u32 output_fmt,
+				    unsigned int *num_input_fmts)
+{
+	int i;
+	u32 *input_fmts;
+
+	input_fmts = kcalloc(ARRAY_SIZE(avbuf_live_fmts), sizeof(*input_fmts), GFP_KERNEL);
+	if (!input_fmts) {
+		*num_input_fmts = 0;
+		return input_fmts;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(avbuf_live_fmts); ++i)
+		input_fmts[i] =  avbuf_live_fmts[i].bus_fmt;
+	*num_input_fmts = ARRAY_SIZE(avbuf_live_fmts);
+
+	return input_fmts;
+}
+
 static u32 zynqmp_disp_avbuf_read(struct zynqmp_disp *disp, int reg)
 {
 	return readl(disp->avbuf.base + reg);
diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
index 9b8b202224d9..c2c8dd4896ba 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
@@ -27,6 +27,10 @@
 struct device;
 struct drm_format_info;
 struct drm_plane_state;
+struct drm_bridge;
+struct drm_bridge_state;
+struct drm_connector_state;
+struct drm_crtc_state;
 struct platform_device;
 struct zynqmp_disp;
 struct zynqmp_disp_layer;
@@ -52,6 +56,12 @@ void zynqmp_disp_blend_set_global_alpha(struct zynqmp_disp *disp,
 
 u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
 				   unsigned int *num_formats);
+u32 *zynqmp_disp_get_input_bus_fmts(struct drm_bridge *bridge,
+				    struct drm_bridge_state *bridge_state,
+				    struct drm_crtc_state *crtc_state,
+				    struct drm_connector_state *conn_state,
+				    u32 output_fmt,
+				    unsigned int *num_input_fmts);
 void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
 void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
 void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 04b6bcac3b07..9cb7ac9f3097 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1580,6 +1580,7 @@ static const struct drm_bridge_funcs zynqmp_dp_bridge_funcs = {
 	.atomic_check = zynqmp_dp_bridge_atomic_check,
 	.detect = zynqmp_dp_bridge_detect,
 	.edid_read = zynqmp_dp_bridge_edid_read,
+	.atomic_get_input_bus_fmts = zynqmp_disp_get_input_bus_fmts,
 };
 
 /* -----------------------------------------------------------------------------

-- 
2.25.1


