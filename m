Return-Path: <linux-kernel+bounces-82707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EE868862
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1932A1F22064
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4053E1B;
	Tue, 27 Feb 2024 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DrqMM5k8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E5535A2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709009098; cv=fail; b=UrJOYSYTBX3CbunInqTNWvU8Lpo7fhdgsqwCgbxL/7qZUyPKoFS9qBpO+C+PJSl98z0fWLaPgOpqFlhxJdUQKiPxJfv50yg0GLzmyE0kFi8O2xbQ0lu2/0ZHK3X0KOtBtgmI7GNukm0ZjUPSSXfJbLKj/hgiwCTA1qwcpc/rFnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709009098; c=relaxed/simple;
	bh=eCsw2/5vfLXerKMm8bAWcUilMVBr3oj/raw505PbIQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dafDHNaVt8geV8vWIrNV/9+vHUrYleJ0sWtzJzXnp6MiHOcOSeowdv3uCpJ4mULeb7qAkcJIh/tanOmErsLVnp6l+GD6n+MPjuano9pjaP1BPb1JgVDJrJ26suRX9JdCnqLNUcm0wN6WWinTtFFEgx0FwyFgONVMAdO0fftxB4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DrqMM5k8; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF6EY+caYYeAm0SPy1eBWlw72pJ6hAN2ebqWm2t4hRJXz7b9YwFcSDPb9uqNBmUM1HLxdbQswDWi9uFNxotbWpTDqvx7puJjJ/fhoQsnDFgB7PfxCAQbY3W3e/FcnWHSz+MSWPt15nllHwvSdKklDFCNMrSwerr6d+Iw+/4zFQm1SG6AR82V9mDU5gPTXid5teXuJnagU+Be7CvjfhfkS82WZUCafq6HAxBpxflaQIc/6e1wfSzi+ns8+HXXJbEfutiAziTkAbxJmQw5MMj4B0F2nb3giw2/ESyHlpd7tPZWCyS4XLmXA2MfSXHm6C0mWJ0zboWKKtgwIqF2+IIC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTQdkjIMZ3d4r2gNDfvu6RVGpF+bvxfJk/Lg4ELOmFc=;
 b=W8KQv/BtxzkIUvVrrELBy1SY2JkINTixCDDryQKaPGUwPQHmboGLc47DXmIJy4ff/8rVtLz0MGEMRYSET6PwX19X2+UpxWddj4+UK/n1fZiZ2ZV34hFeNGnz9JbFyqG22fmx0vQSjNObI59eeagZ+nTDpWHrTxNuH8tK3hGecD4IYyHVgSKTZ1AEbbaCBXYVGt4/MfUiQSKTeh1Xa7gPxPTW345p+f+2L1uvpgEa9J5yrVRLaOZoKLUPso0SH1gxQXfjJiF9HW79sazSSOguWxYeHkkleqLpS8Y6YnNivclZhJrlG5A6o1TDxwe+4Ijo+XpHc5jL1Cs5aAfOP5YZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTQdkjIMZ3d4r2gNDfvu6RVGpF+bvxfJk/Lg4ELOmFc=;
 b=DrqMM5k8tI4W5famIxrLoYiPoqK0uqfwiXY9HfpwnVj5czTEfCCRSLtOZrgWIyy5PXLgronrQKDvbJ0vnIHM90HtFFOkE6td9jI6fFOR+/++buj7xqMsMun5qVGcTt9tWJNmrbx2UfRzvZbHBDCcOJdfRgKwtV4CP7gxhCuzpPI=
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 04:44:54 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 04:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 04:44:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 22:44:52 -0600
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 22:44:51 -0600
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Mon, 26 Feb 2024 20:44:45 -0800
Subject: [PATCH 4/4] drm/atomic-helper: Add select_output_bus_format
 callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240226-dp-live-fmt-v1-4-b78c3f69c9d8@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW3PR12MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be37ea8-74a2-486d-e251-08dc374ed71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o8o6y122jURxHD/aocDiZ44qpbq8cnpBpuxzwXGtZ48sFPbHso4g5OE/4b+J+tjF4AxkrB7KANdbuTG/N5bY95RkysIDYqH8TxfAfPvEh690G5RdlUxSnaa/aFNg15Vw2rfe1HYrMGV1eL9w7FgAEn3Mn+OsDFYSAh12feM6JKNA/EYKz9ScN/GFPvuZXzkdcl0EL4pjSqfgj2qj6mo4351SBSxdweqYwsCHsYOcK7/ZDcaNhQbdccYIKFkQadtNw/1M06zV6A+lnIgxOWYfZTphQtUaBDkn9sVZr/g4hUion1qRZ8wLqRRmMOQva1YwTk5hlkMiIbKfq41/+aFuQP3UWPg3mn6pFX5vNHJ5mgvnHQvR7G2DFPiyXjd/M2+p/LMdjoFPaH784rHhIFSo/FZpE5vWvzgUtL2VWMbPVVQdoIv4UllaKVVJLCX36XJhuKS8qbnHf7vjAC1WXIzWx8hjrqlnJH/0PCUdCx53MtrF6FrKtKjK+8LHB+amw2Qg+zBhEw154EeQjPJwq8YLcw6kkeUu7NEKvVMrue9e5MvXbzCBJ/IoTDOJ3giE9VqVColAIr/pE80em81TzZgpFKjgiwlyulxNjLYR592fjO4ZmUkY9sxJaPmCAogXWkROgA4+313APq3pnv9hxDSu3Bp1GfdCdjYGKfIfpWpx1qt7UyDjCweCqFkib7lpT7H/y5E4fyGEQ3WC9c3nEhv3ZSGQC/bqwaprzQRNyJOFYr97EfEx2w4wmAy2Kk1S+q67UNlePZhxenxxeKilAmfnZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 04:44:53.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be37ea8-74a2-486d-e251-08dc374ed71d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570

Add select_output_bus_format to CRTC atomic helpers callbacks. This
callback Will allow CRTC to participate in media bus format negotiation
over connected DRM bridge chain and impose CRTC-specific restrictions.
A good example is CRTC implemented as FPGA soft IP. This kind of CRTC will
most certainly support a single output media bus format, as supporting
multiple runtime options consumes extra FPGA resources. A variety of
options for FPGA are usually achieved by synthesizing IP with different
parameters.

Incorporate select_output_bus_format callback into the format negotiation
stage to fix the input bus format of the first DRM bridge in the chain.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/drm_bridge.c             | 19 +++++++++++++++++--
 include/drm/drm_modeset_helper_vtables.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 521a71c61b16..453ae3d174b4 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -32,6 +32,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 
@@ -879,7 +880,8 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
 	unsigned int i, num_in_bus_fmts = 0;
 	struct drm_bridge_state *cur_state;
 	struct drm_bridge *prev_bridge;
-	u32 *in_bus_fmts;
+	struct drm_crtc *crtc = crtc_state->crtc;
+	u32 *in_bus_fmts, in_fmt;
 	int ret;
 
 	prev_bridge = drm_bridge_get_prev_bridge(cur_bridge);
@@ -933,7 +935,20 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
 		return -ENOMEM;
 
 	if (first_bridge == cur_bridge) {
-		cur_state->input_bus_cfg.format = in_bus_fmts[0];
+		in_fmt = in_bus_fmts[0];
+		if (crtc->helper_private &&
+		    crtc->helper_private->select_output_bus_format) {
+			in_fmt = crtc->helper_private->select_output_bus_format(
+							crtc,
+							crtc->state,
+							in_bus_fmts,
+							num_in_bus_fmts);
+			if (!in_fmt) {
+				kfree(in_bus_fmts);
+				return -ENOTSUPP;
+			}
+		}
+		cur_state->input_bus_cfg.format = in_fmt;
 		cur_state->output_bus_cfg.format = out_bus_fmt;
 		kfree(in_bus_fmts);
 		return 0;
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 881b03e4dc28..7c21ae1fe3ad 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -489,6 +489,37 @@ struct drm_crtc_helper_funcs {
 				     bool in_vblank_irq, int *vpos, int *hpos,
 				     ktime_t *stime, ktime_t *etime,
 				     const struct drm_display_mode *mode);
+
+	/**
+	 * @select_output_bus_format
+	 *
+	 * Called by the first connected DRM bridge to negotiate input media
+	 * bus format. CRTC is expected to pick preferable media formats from
+	 * the list supported by the DRM bridge chain.
+	 *
+	 * This callback is optional.
+	 *
+	 * Parameters:
+	 *
+	 * crtc:
+	 *     The CRTC.
+	 * crcs_state:
+	 *     New CRTC state.
+	 * supported_fmts:
+	 *     List of input bus formats supported by the bridge.
+	 * num_supported_fmts:
+	 *     Number of formats in the list.
+	 *
+	 * Returns:
+	 *
+	 * Preferred bus format from the list or 0 if CRTC doesn't support any
+	 * from the provided list.
+	 *
+	 */
+	u32 (*select_output_bus_format)(struct drm_crtc *crtc,
+					struct drm_crtc_state *crtc_state,
+					const u32 *supported_fmts,
+					int num_supported_fmts);
 };
 
 /**

-- 
2.25.1


