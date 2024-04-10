Return-Path: <linux-kernel+bounces-139043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7189FDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10B428CD26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374917BB0F;
	Wed, 10 Apr 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahcKjWq9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C117A918
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768915; cv=fail; b=fypZFABbHf1otv1VvsbCr6FXnRdR3zC9jXLh/Kwn2lsEUiEuagjMQQ4Wf5tHCPHdqAcUEYh7SzAjREITkcz9xIlespEhowOez5ntNooYWnzX73NDRk2JV6p27rk/Zw4vlNsrLieGLqrOSqz2WKNOeOoLsHYYbR3JVo45fOwXQYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768915; c=relaxed/simple;
	bh=DqysxFUD18EyrHxgVdkaiuvxrxwR+T51gFgWw27jwfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boWbc1LkrKkPnoJUGNGuvTBQ6FEOL0lyPgwYjysNdiWukyZP3xPCoQbQvQxnrlUFb0WL2WZAJCVZ1keezIDw0T+MRdTohG8ln9VPccv/1Bw8uyhaLvZdGOcktaPMEl5TTbzi3rbLVWO+ObA3PFPEm1ocvfR3WEmduluEFmV2fzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahcKjWq9; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdqKRJhIlzqaMEvZ+obFcoKsuj9hHdAy7szzRh/bY3Ph0Az9qgMhITBeyABsjHw4s+e3uT3/VQfDFcV8KutRRfO3ElDwKiOBHR6aVvu69YdWtM3vpapCZY289DklM2T0wp1BNSq6RGPWcficuDPaXSESGPowqSto7dmD2AcXWihvBAfJb6FOIxhjbflvHHLHEINz+4oVWYA0ixJ9LkaLMZt83/h1nxd4LSRgIjaxdSnQi4bSkVRfFKVao3achauppJYX+vQ2G1He48n0XIvybSeEBHV4oAHDC1F2ZRjKv5EGwNA2wkRJtR8gcil7l0rvgrWH4180XgbS0a2FUfW5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y5+UefAlgIIas46Ne2sxo2p/QW+AUVqmBsHw/XJMic=;
 b=DcTbWBMcsKHPs92POUpaOAVbwJGrHds79Vsy6ngbaZT143yg75dIWbRA9aHXQ5Oei2cfe1Af9viEuX5WMuGa7rhQH792E3z7HuKBGNW9snCU2y6bhxQoZpAPXXnd3xgHZBu3dA11qzD3vnp5imh7kSEwnNJecsHKdGBtqv8cdK1Q8xnd89Z8NB3oDYtZpwlvlS3GgxD4Nr3NTqiQfgPGG4lCe2j6EoXMip3GxGWqzQIhrWRGbPxftus+0Amzxnn24Q0HXc9bHGeqsjB8u7WUdphe+ir5aIpC/nm7pY6pu329zBYQGe6c6fleMMEz63rxYl0f6UJDra8XImtmcCkTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y5+UefAlgIIas46Ne2sxo2p/QW+AUVqmBsHw/XJMic=;
 b=ahcKjWq925HDkpQeuSF59sseq95oi78uGDNgw8FsJ4iUTxzv40QHGGaRItutse+UvKfC+a6dNq/JhJPm4M1DNUEAQYyVWRNLe91J15uOkgzxw1K7N1lFdAOf6o2uz7LG60EjLfy94kVjraQJLdIyTFAAIuWzuhg/W6UTghTKJCY=
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 17:08:31 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::f6) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Wed, 10 Apr 2024 17:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:08:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 12:08:27 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 12:08:26 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>,
	<shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/3] mailbox: zynqmp: Move of_match structure closer to usage
Date: Wed, 10 Apr 2024 10:08:23 -0700
Message-ID: <20240410170825.1132324-2-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410170825.1132324-1-ben.levinsky@amd.com>
References: <20240410170825.1132324-1-ben.levinsky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ben.levinsky@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c1b72b-d562-4a33-6116-08dc5980d89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	76s5irjoESpTeKv64mzZ9Jo7/8ba+a/2bQsxgZAeCZSGSrOxG8XDrUjWKlSsc2Vvg0Bg/NWM3zseoFfJpKp+X6+mssBMh7EexH1Sy9KP7rxdCp/v+YP2T4mbaHqfFl1C6C2u/3RycMm9NvZY8p9KHVv+dDGAHanJwplXNHzwkZEzs0bqCQbmuQm2Ab5clkHV4Z+XqI566YmcvgV0WwjFCBIKVip0+n5uGvyH/G7U89K7Wl3vE4hDEzfHmfhDG3smmGV4+0M1LoVRu2rEDL83BRKqex0ChiuWHla2mwbDRxm14vlFHhLJWGmT8OFnWYCcBuCckJdGjXdTzuoujt0B6Ze+4q8VmM24LTuKVFprGKUkUlFM6aXYryKmsPAOPQ7I5XH51h/ZXGsZNhWS70Rk1oDjMlDsJP8zSDQciM0Oeg/E5/8sFwx99qcAesJ8P/o/tjf0hv7rAefiAXqIxfWDoLpLurtT+NPcSOFH9stcwISZ1O2qIziwiovaeOTDgYoytyzcaSwy7ciCMuREuJ4na1xh2pFhoTMFyQ5roUlDzbecoguZRbHuZlxmHStzuXf57Hlv13Fu02Y/z5ppJXK6M56c82Pn0OjYjEbHmSNm6eVQvs0kNQaek8aq7w9w7xkbYyDxkKlubivhfbcyECfp0+ozaDfUtfFMROdUegYULkOx1RDkrwSMaTz67A8qPxVZCkyDGXARbJfnAuqTrZXgTgKQJlIXAdpkHr+HLaBMka2hQARpTDZaS0JXfcc6jotI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:08:30.3577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c1b72b-d562-4a33-6116-08dc5980d89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

The of_match structure zynqmp_ipi_of_match is now adjacent to where it
used in the zynqmp_ipi_driver structure for readability.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 25c65afc030a..c7ce0826383f 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -415,12 +415,6 @@ static struct mbox_chan *zynqmp_ipi_of_xlate(struct mbox_controller *mbox,
 	return chan;
 }
 
-static const struct of_device_id zynqmp_ipi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
-
 /**
  * zynqmp_ipi_mbox_get_buf_res - Get buffer resource from the IPI dev node
  *
@@ -695,6 +689,12 @@ static void zynqmp_ipi_remove(struct platform_device *pdev)
 	zynqmp_ipi_free_mboxes(pdata);
 }
 
+static const struct of_device_id zynqmp_ipi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-ipi-mailbox" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
+
 static struct platform_driver zynqmp_ipi_driver = {
 	.probe = zynqmp_ipi_probe,
 	.remove_new = zynqmp_ipi_remove,
-- 
2.25.1


