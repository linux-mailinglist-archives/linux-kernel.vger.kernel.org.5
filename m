Return-Path: <linux-kernel+bounces-30797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B039583246F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409C31F2492C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CA28E2D;
	Fri, 19 Jan 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p8j09Rpa"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688528E04
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643695; cv=fail; b=NVAmnVDGpjVJAvSMfSqy0+eaYBWFL/XYvJwLKW38AYEa4TppbOpaRhtd6vtuoYM094lPTIfE0EHD5iBXrmJ5szKd3eoW8yCLoy2LkTxv50pzctqrv0QL7ZDQX7uu6e9QF8rBvqEi4OztambTgMV2+FNZjQH9FMCNCwl7rZ+eTmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643695; c=relaxed/simple;
	bh=sVcDNeUh7fsYktx5246lAlf0oeTGsGFaF2eU6dNKmQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0S1KhL+Mq1BwyZ0w+ARPxLRQ/vsx+BTIoA6wZY968ip6cKkwacH+wu7RWTP4ffoRZNmiK2GixZMsRQX7be+EhU4p4fcmCATZGmH+PYlyHQaYEJ6zG6zzd36FVDMZOMg1lEyVm19Te0onmuMfm91mi4qnZsZ7aXI73TQURsQ8SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p8j09Rpa; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjJsbJ1QlOCfwlZ7evOSrKKLkSz/hGH33287nFoGe8GR0dCTdbh2wcpDhqxy5LOD2KrSwBF3xpL9R6Ap+/9dY9KT8HPBWKIPgsOB1GAplj0JKQnsUih887cLQgvDAQKnwlFHCJBFOxPvgkrn/JlwLNnzRu0W6GgsIMq+iv9brhszTzxo7Q1E6cvKocAmD1YaBwnLolwRcDgx8h5xkr+vcd7DJLP+vLAixuabAb8DQ/aT9u+07G+SVy3hfcl61p9P17tKfRZ9o+vLhFNzM1fImxRP4mdpB1pHrDTc0QHmdVBgeu9UcPtzMY82vL2cRozFgQly+Azek16zNhffIkUMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A078BbaAGY/zU6JL5BJwe7eSaF1X+L8idnxCjUVxvc0=;
 b=nS7Zz6mA6v3BrYfq2qQYX9jKcGBEDL0i5watj0sx2gfok84scRaG+lj9zE1jHsVy1v+QKh6QYmYVkpC5umlWMune55i48sGeZ018jBw3IFp5QSeLfFbgyLqT1BkicCsY/2jb4YwXeKrNa11+ryMy53blnTHhjmj3azDe9sB0gOkK8F9hZAUnkH84ikfi9XMB2oWzMOaaS69kK3/1ddd9qvCAi1fVD71PqPTyhXlnC/8isqLie8w4I0T6+3gz8cDGThsJLrRyhDxbq+WDGHF8pt66V1sMlXM/ykuKLZtBbymwbebkzsNMp5b7owY0wyNQ3QyobTE4YEItuNxviIp58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A078BbaAGY/zU6JL5BJwe7eSaF1X+L8idnxCjUVxvc0=;
 b=p8j09RpanAOmiaolyjIrLJDpih6KABFdLll6QraG8SP6dV7BrYsKrrmWASaBOGeSOZv/ZJa2NDXId/l+IoUhekLSDFuBimivQ8sc4obF3je+8vdwr6/1o92/V7vPpFHa77Tmx0+5roLUemqWCQCR7bhOukxKL7nsVvM4cJL3f84=
Received: from DS7PR05CA0053.namprd05.prod.outlook.com (2603:10b6:8:2f::34) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 05:54:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::62) by DS7PR05CA0053.outlook.office365.com
 (2603:10b6:8:2f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 05:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 05:54:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 23:54:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 21:54:38 -0800
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 23:54:38 -0600
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <michal.simek@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] drm: xlnx: zynqmp_dpsub: Make drm bridge discoverable
Date: Thu, 18 Jan 2024 21:54:34 -0800
Message-ID: <20240119055437.2549149-2-anatoliy.klymenko@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119055437.2549149-1-anatoliy.klymenko@amd.com>
References: <20240119055437.2549149-1-anatoliy.klymenko@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae4bcc8-a139-4356-6ced-08dc18b32681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zZDWEeeNwCRCyldCEW83modsjzGVmXGuY+L+1U972nEos56MtM/etm9pX9rCR5CoPsOt2y2oAKiE/dGEt5iZJH+TYqsZD3VkJCsPYJOOgOSAJShENyb++J12tLhOreR16Ae9X6OeNzKVMwEJzGYD3vTdi9vZGLKiBq6A1b9JVYyveAXgA4Nlzhc5qct2EcT8CXdnjgObwYENgMcYuYUAWZzmCiarcErP9Yiq+uvdAC3GR2WSIF4xhSHBJpB8Fq/mtmcx7nIoGL08P3bqOdKhIyxg2qw8l+dELJ1PS07xwbe6XzJ8IifCEP5KngJQ7Y8eXcx7kwsP2lRX9cpJeVsKJUDKbv95wll8bc4QIQZyLaLnbI+/grXVFaZkXgjZxjCbqCZTUof8a6N9DRHPS4UXzEMOWlcXpEK4FdCYG2N1QBPJnoj7fCbDmn9I6Jn0IqQvRKGQfbi6c6xkbfVDZ+2RlAHd7pSiEvwZCGfxX9NIVLbnuE87GvHYCflu/AKr5vz3/DGwbAlmhCyD2AxSXBEWqiTIeHt0Tz+JOqFRW42hFBFh3+n7VDn9Gk4pkwV69K2F0XWNBozR0bcUIOW6K4Cq3Y4qMHhS5hG52Fgf/0RFTEU92eJlBe0PmVE6dSCPqj/kLeAxntzhj4m1+Y/dpc+YbKNW1uOM0WINhg0mjIs7uDRifCHBCCK87Db3BzQfReMed2vXMYtGCga/G7H8k+d15J6tq42ioP/CCUTcxA3t7HkGGYKb42Fjm06Ba7la3tMzpEgCnuXNMY7S304MgpB02ZwQdZSk7FVaBNXO81I/94pvs0nk/9s59PofC/8pfhn5PumznC8/HSMgpErbIzZFEBls62O/HqPVw8aNdsUKbbK2mzuY/Z8YEP3Ee+rAip2t
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(36756003)(41300700001)(86362001)(81166007)(356005)(82740400003)(110136005)(70206006)(316002)(6666004)(70586007)(1076003)(478600001)(2616005)(5660300002)(47076005)(8676002)(83380400001)(336012)(426003)(8936002)(44832011)(26005)(921011)(40480700001)(40460700003)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 05:54:50.3215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae4bcc8-a139-4356-6ced-08dc18b32681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

ZynqMP DPSUB supports 2 input modes: DMA based and live video.

In the first mode, the driver implements CRTC and DP encoder DRM bridge
to model the complete display pipeline. In this case, DRM bridge is
being directly instantiated within the driver, not using any bridge
discovery mechanisms.

In the live video input mode video signal is generated by FPGA fabric
and passed into DPSUB over the connected bus. In this mode driver
exposes the DP encoder as a DRM bridge, expecting external CRTC to
discover it via drm_of_find_panel_or_bridge() or a similar call. This
discovery relies on drm_bridge.of_node being properly set.

Assign device OF node to the bridge prior to registering it. This will
make said bridge discoverable by an external CRTC driver.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index a0606fab0e22..d60b7431603f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1721,6 +1721,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 		    | DRM_BRIDGE_OP_HPD;
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
+	bridge->of_node = dp->dev->of_node;
 	dpsub->bridge = bridge;
 
 	/*
-- 
2.25.1


