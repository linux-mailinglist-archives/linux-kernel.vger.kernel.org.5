Return-Path: <linux-kernel+bounces-100979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051887A066
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36261F2265A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82112E5E;
	Wed, 13 Mar 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jk4ScPx+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D6BE68;
	Wed, 13 Mar 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291315; cv=fail; b=gtpAYAUe7UsrYZtvTjw98utevmkBdcdqj0IkcpCJI3aUz1EIPIk59EuT9jnxYdq96+QaHYEdH7Wv/SfPsU1UI2UNVqbdJqXO2cFVksYFjhXr6O0+GZAGmojv9iIDl1KgtFO89MMmjPr49XdZ6+ssng2lVtfVnrBQeNY239HfQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291315; c=relaxed/simple;
	bh=eAurosNPVsXE2e1EduOom/jSzmRaNvFUGTcRH2ilBuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pFERHS5tXlpPzVhyTelGFV3XRnKkbmoz8AR4lzhtHBP6m841CWeEEUOvZerqr89RYXDPgIgim7nLkgh9YwobYaHRUMEwkhOX6/jwBByghJQochqHZDEW/1iAqcNhsIuXSB2NDxqWe4IQdq2XpviN2WvOz/b/qDgsyEvBSlFphFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jk4ScPx+; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaQJeOWxUzO1s7Pox6JVOo3CwH4PzPnW4ztSrl/3pmnjTzKjYcnKUQ6jAP+LjSRiJN+yYpAzIxmreqJpabghtJgUD2DtlfLqQb6mJvRmO0e9LZbsrMNcoNzIpe9cd5D8hODtmVnLQpCpHCA4xUh/px+kMW9SAV4Cj5zsuXaFmPYx845h1vzI4C5R8ILIZZzKFstIhx9Zs2YoF5qnYtAZCpIR7Pj8zm61jKOo6MsuqMDbzuqp2i+VNXdc5HdG2gmXzIa8/+N7c1qkcaJha7yJ82E5XONBQPAtPz+cOBfGtNku1gizKJh1vBkN4krhqE2NilSofjhEvxzqLyAZaXuybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2DwGrSu2jUWc49F+HOCYQHBQGGwOqBE37O8Ck5UkZ4=;
 b=IkgIN3gnVH0HoGZe9ONBh99MA1M/ZY9qgLot+acyqhgLqef/usZB4gYIejh7KcP8eBKU9DmsL2RdNJU8OJTaaXADOSzs0bD70xU98MMmWDsaaP2tgPafUWQbTqwpJjJYS6iuUvlw68vzRfU6HprKiYzlRj5lUq6kUe/ZdUwKyz3R1xIkIQMBbRIbTmGY4hkmjviGwlfJtYKlJHxH373klz9D+nyQ1z+8XZNlzh1HuMVLNdWzo+U55uBInvD3frug56HTOCqmz92Y3+gvlblfqQR80hOL7vZc5+AbZEBhomjZbfHDLVZLO8t6fuAU/hC5MKYoFJxwUKFXszKPiZD8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kwiboo.se smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2DwGrSu2jUWc49F+HOCYQHBQGGwOqBE37O8Ck5UkZ4=;
 b=jk4ScPx+4Oi6TJbKkIuNh6mEBAp0+AV8/HeNj2PA69Gktpxu9ft5o8vIJnktAOogWVtF0bR2KkCQL7+PHaR5v825oii8383hPUtSMSxoBjCMpTHquwpb9L7kKqop1B/rg6II9usfYd9aXAxOxh32BCyg2CkCYQ2SDzNEpCzq70Q=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 00:55:11 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fe) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 00:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 00:55:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 19:55:08 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 19:55:07 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Tue, 12 Mar 2024 17:55:01 -0700
Subject: [PATCH v2 4/8] drm: xlnx: zynqmp_dpsub: Minimize usage of global
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240312-dp-live-fmt-v2-4-a9c35dc5c50d@amd.com>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
In-Reply-To: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
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
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB03.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: be69a5a1-5736-47c2-6fa9-08dc42f83ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9v+7fmB4ly79jTCBWGd7EezStCs4fgKecvvIWa9lBygmY0JNg+FCP+vELZTwyqQF331g4wvTjx0mx+6udizt87BbZdLOtgJldSiu2yWpLTC71520RhMpOPR3Py2vh+rAGpuvJ4uniP3hzthXCGIxgpfT2vfjtF/M3oeLEd4/FDwwIzW2BtANv8AcUp1HAvsagZxQQYy8AqvnB4p3I4w3Cs3vJJcXZK9xnw5VFdt+xJRDge+4qTqZ0xuCf4RUIxznaZnFp2HIHsIguauy8mWh3pkz94rC3tH4fLvJrsMXwxvkTbYypAewPdowCbDnmfp5nTFd1JiTT+E1R/3oiw5QL7uLwnVmfOE1Hkb3LxMbe3HTg3phBQx74Rt7s1/F27Q4V8niSk1SX3zBVjcyHhKHH6u+1rVkOHT+fcGs7taCGvPdbAURH7jt5nqxhPh8Dg8diPm5kHNu23LNmh4HNCTQN4438zUjOECGpfU2krk6T9Hx/U5F8FtNJfW3JrxwJFy+2OAPIhg/H3d1wjq+kIQOPPaq/sNZc6xQ9rFFJ4Y1oPHGJyJUdVFbra2w8heltC3xQzFGPiTEVQRTxYyiVU2REsUfkHhYiNopRdFq3VSRFWTpnkbV8/jEGryPEuNO4bQ+KsMAUgpCpz53x1SjGJnhJsRvn1VgxZjTgCO7wD9jHRXlYgunxhYAnHekz8prCKhh1TKG76wRvbA+uGuamE67ymJ2nd3CrH44SCZtIEnB1isYZPtmxWxdMJwL/f9YxIGkpNQrD+t3O7O2RGO9Ac7MVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 00:55:11.5612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be69a5a1-5736-47c2-6fa9-08dc42f83ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

Avoid usage of global zynqmp_dpsub.dma_enabled flag in DPSUB layer
context. This flag signals whether the driver runs in DRM CRTC or DRM
bridge mode, assuming that all display layers share the same live or
non-live mode of operation. Using per-layer mode instead of global flag
will siplify future support of the hybrid scenario.

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index af851190f447..dd48fa60fa9a 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -975,7 +975,7 @@ void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer)
 {
 	unsigned int i;
 
-	if (layer->disp->dpsub->dma_enabled) {
+	if (layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE) {
 		for (i = 0; i < layer->drm_fmt->num_planes; i++)
 			dmaengine_terminate_sync(layer->dmas[i].chan);
 	}
@@ -1001,7 +1001,7 @@ void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
 
 	zynqmp_disp_avbuf_set_format(layer->disp, layer, layer->disp_fmt);
 
-	if (!layer->disp->dpsub->dma_enabled)
+	if (layer->mode == ZYNQMP_DPSUB_LAYER_LIVE)
 		return;
 
 	/*
@@ -1039,7 +1039,7 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
 	const struct drm_format_info *info = layer->drm_fmt;
 	unsigned int i;
 
-	if (!layer->disp->dpsub->dma_enabled)
+	if (layer->mode == ZYNQMP_DPSUB_LAYER_LIVE)
 		return 0;
 
 	for (i = 0; i < info->num_planes; i++) {
@@ -1089,7 +1089,7 @@ static void zynqmp_disp_layer_release_dma(struct zynqmp_disp *disp,
 {
 	unsigned int i;
 
-	if (!layer->info || !disp->dpsub->dma_enabled)
+	if (!layer->info)
 		return;
 
 	for (i = 0; i < layer->info->num_channels; i++) {
@@ -1132,9 +1132,6 @@ static int zynqmp_disp_layer_request_dma(struct zynqmp_disp *disp,
 	unsigned int i;
 	int ret;
 
-	if (!disp->dpsub->dma_enabled)
-		return 0;
-
 	for (i = 0; i < layer->info->num_channels; i++) {
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
 		char dma_channel_name[16];

-- 
2.25.1


