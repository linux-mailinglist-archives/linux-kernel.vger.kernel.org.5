Return-Path: <linux-kernel+bounces-59887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316184FCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C3A28A45C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7484A27;
	Fri,  9 Feb 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wPRz2hkG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090688289B;
	Fri,  9 Feb 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507329; cv=fail; b=YCi+7yRVTWyvV0QjFy955OcW+NX/kiqxWpxMk0XcfK4Mpc8MMlLYOw5revfG7ykPh7Lna6BSlr/9pVUC5VAuRiMTknI+LHS0U9MsO6KGk0vth27eVBwHovrV3slM6GJFpoPG329T+BeJ5BF03aRE/E8gDAC/1l9LQINVvkCXjZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507329; c=relaxed/simple;
	bh=hciYtzUbrFrSmTkcYgKnXmgwUrnpt8t9X86fhauIkLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnLedfuooumoJeouVErMucJTOWU8d7rKb/zYO0zk7lmCFbJJOMx4jyMrS0OYPRK1h04b8WtNQuTcEqygzNm3HiD4Kn5wtWaPDrU70g08bBarco3bT8F2OTEq1tx43wZmQF3cm/U7bK7vksIjR6EXLNotiHB2xe40FViZUzWqaMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wPRz2hkG; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBArl4PC3afz0uAcH3aJrCFL/h1AyW/RjcPbmKsvYBv/uaCVTJjjNUpZukaN+efzdhKiD9IHMXVv7LEvt7yC7sk3a1FK7vVt3RVPIe7lYDEwK3q0KOt3qmzk++7Hied8/h+VI3ejZT0yKhh4n2OhviVS1tca/ATZLSysbO4ga14NNChCmTeQlFG+fv9Q4oNipliCidKXlbpphqIMKdGOn1W+BWEkw+9yXtveZhEFMsHrgmVcVY236xhhMZww92D0KtfigRKUL+se98eveV/J1i+WajmBsV4a/hH3Fsb0/8tZn2Pf6RNElO/pKxcBqc0tEJQDFrlYieOnbIesa2pQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioWdN71uaZ49kdEoOEhUEj9xLWBThY9PxuIu3Jx0PuY=;
 b=lrSd6DzRciq5L/22GucfcNpMUOOAohoVJgM/eZqiAyApc/RxNZccIcia4D19R5LAchMNhiugboKvXS1LPqgjiwy4sBuOn6N3rq1ZX/u5902nn69nl/Qivgo5y6vPVL7472Q2vR8qNALXbaoQQRGqN/2sb+X4yeC/X9CU973OuVKk5IanvIt+JdNvQ6bg0ZpgFZLWpsR+8XqP6Y4gcSreloiCayexxqH0ykyQ/5ciZnDXZ8hG3BUY6vMEiGBdlvDXHaigqiWZr/QWfc72hHOTE0EjvA7aC6BkC1RLglRv0R6Qdh3sG2BmvBBeNChI3mB88Fqf3SUN5yoT1OSAP0dJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioWdN71uaZ49kdEoOEhUEj9xLWBThY9PxuIu3Jx0PuY=;
 b=wPRz2hkGB4SXuJpABxrldn2xajWQAQSQyG8eQnSv1/41LtjBllzDyIUkPdW6hBkQKahN4Wtw8LeWgWi0BomJ1K74SK579N6hOYq+ldzwSSYtufgnpEbKNyVXdZHnbS5AcWgXNVr6Y6eUm6ADT4HgK1zlTKfBS3DEnC30QLCe4Bk=
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.13; Fri, 9 Feb 2024 19:35:25 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::29) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Fri, 9 Feb 2024 19:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 19:35:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 13:35:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based addressing
Date: Fri, 9 Feb 2024 20:34:50 +0100
Message-ID: <20240209193451.163564-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: b5efa8d0-e71e-46a8-c646-08dc29a64064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9cxi+qScIGeRuY21F9U5waky1gIdzFw15dFw9oEu4D7lgzmzsYeuL0j+BXDfgQxPgMdlIP6la5SCHGgbZMz1sSoFxTkfC8NuyINbhuQrOnkK6eMqTSYvDc2QnQvvg80yI8UpBYFJ6L6UcRoI2Wnj8lIQSnzKSKnwgMrQLbqDrUhuam/ZjfMbIN2ydzAstwAUtMnKW4mc5Vee9aXu0zVFznwGIaN8f91+1VG9bY4Gjm1mcf4P5EIaohW4jPi/5xs+FDFKUr/GifPfIsVrcoEG3fllnkR6ydyu2PYIT0pGKm5vTqHiMx1EnW8j4wBx8O4Jel+dxYrN01nEZMNgvnaIhPJs3YAE6EeNEjKdnPFU9TmyyZIiNGxvGRtMpF3j8o5ZFYc/CGKsBcu2Bvj6HtMzBLHHuxN8T1Rbmunlgb6qsclGervV9KiW1LianGL92C2T2b26pWRdzYXMGb96dAW8r0kLjsW6io/O/kgGbmU+G7AyFoO7ENjLp03msaHpX5qsEHY4Z5oxQlGhpJoWjvYO4qfHEnI4SyXF5zxELY2Cf6tglxZ7OaJRUHw2aq9LJ4egLfs+RqCVRf63/8Owf7NkDyGzsS+vX6dHC3LrfYkYkQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(16526019)(6666004)(1076003)(26005)(2616005)(36756003)(478600001)(336012)(426003)(356005)(81166007)(82740400003)(83380400001)(8676002)(4326008)(8936002)(70206006)(110136005)(54906003)(316002)(70586007)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:35:20.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5efa8d0-e71e-46a8-c646-08dc29a64064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

Based on CPU implementation and architecture, the CXL memory address
decode per memory channel can be implemented as zero based address for
addressing the CXL attached memory. In such case, the CXL host
physical address may not match the system address. The CFMWS contains
CXL ranges that are based on the system address range for the host
physical address and may not match with the CXL decoders.

During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
8.1.3.8) are checked if the memory is enabled and the CXL range is in
an HPA window that is described in a CFMWS structure of the CXL host
bridge (cxl-3.1, 9.18.1.3).

Now, if the range registers are programmed with zero-based addresses,
the ranges do not match the CFMWS windows and the CXL memory range
will be disabled. The HDM decoder stops working then which causes
system memory being disabled and further a kernel hang during HDM
decoder initialization, typically when a CXL enabled kernel boots.

If the decoder is programmed with a zero-based hardware address and
the range is enabled, the CXL memory range is then in use by the
system.

Fix a kernel hang due to disabling of CXL memory during HDM decoder
initialization by adding a check for zero-based address ranges, mark
such ranges as used which prevents the CXL memory from being disabled.

Note this patch only fixes HDM initialization for zero-based address
ranges and a kernel hang this may cause. Decoder setup still does not
enable the HPA ranges for zero-based address ranges, the HDM decoder
cannot be added then and the kernel shows a message like the
following:

 cxl decoder1.0: failed to add to region: 0x0-0x3ffffffff

However, support for this can be added in a later series.

Fix for stable, please add stable tag.

Fixes: 9de321e93c3b ("cxl/pci: Refactor cxl_hdm_decode_init()")
Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 569354a5536f..3a36a2f0c94f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
 		struct device *cxld_dev;
 
+		/*
+		 * Handle zero-based hardware addresses
+		 */
+		if (!info->dvsec_range[i].start &&
+		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
+		    info->dvsec_range[i].end) {
+			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
+				info->dvsec_range[i].start, info->dvsec_range[i].end);
+			allowed++;
+			continue;
+		}
+
 		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
 					     dvsec_range_allowed);
 		if (!cxld_dev) {
-- 
2.39.2


