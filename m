Return-Path: <linux-kernel+bounces-68934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B5858212
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C034285BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8F12FF67;
	Fri, 16 Feb 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bfSU+foN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520812BF1B;
	Fri, 16 Feb 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099299; cv=fail; b=LbmK8MzuB3zRsZZgfuLIx9sgjKZN9BjI3fS8rC2Xw1Y5MJ634eIapADZPpijE3h84pes+/yAGcd+FeEj7HmHO6TPOZYAqeeXiTMfri/8voGFUuTZqs9adnZtDjc7zyryUc7VS79Fw2HHrXd5Dm8jR+iEir22wxWAc/xgf3qn9b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099299; c=relaxed/simple;
	bh=zN3/UbPHHIMJ3QKs5XoxhMVLuA6Lcd5wveDISvIsMZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oV8186m0Kl2q8HTBp/tbGBZ++r/8Fx9et9DRH1P44Uhk1ELJ9RYxkqw49gppl5MJcQBH6TFzCVRhSCAAOVLmTq1CyGyeD5Cuq66ynwn/plOrEderKxDHTQZU6KzC14bcvARC6brgZj6qMjB2HK7X6uAT8FaLXBuR+fv7wb9SDeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bfSU+foN; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3a7H1KyoyHRLohsnQYpSsN9BRjB9EDpO30YZOa8azVN2zHOJ3FKTriQWkZbKz5tAYmtwdasNtIrGhLY2brhlqRt84wDaIwyo7O1LgMbbxODQFov8kBD5zBa9aC4qcRh13buDnnhb7m1fCaqQ3ykA4nmUI26wd0sizYXMLeRsu9byKORVbizUBTaiMD2svFN9O0jragoEqEIZzzNXu1HC9rM8szxdJGuvnlBLrUta88i6x9saMsdCgIg8oA1FkeJft56IMKhsKDSDIomv3Mb/J7Hgr9M9sb62MYF8he2yXsaAr8AA7JDB68wtLKcsL3UcfhJFYfhXIMySdPs9FHoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmaMlXyo3WPhxUMaxDQeBwbSknTUPIajE8OzAX7QxUI=;
 b=PVZj3Ku398judp8RFW6qrRL6q/sOcFCbgTw36uapDrCV0rlEsjLGMPrzSwIhBNT7E47Od77FAPxZvonVWLYMAqdTySKsH6o16O0sPEr2IlDWLYhvY5yhptPsuUNu4w/8AM2gX/8LDU9o1tulfu7HLU03WdmPGRPAcrArxO2NgK0gt94JBzCQ8FolPvorGsAK2E3x5x6gTt2CEoFSuU+oDEU+jhYI+pbZTMf1DbxidrK1ufqMrTbcEYaROomwurUbTtQkgaffYwTyUCjHDvOQKpeOGXPYmP0mky+n7/ldqDJ4qWx/D26A3R7TbD9OqQIFxP5wX+ojxhBCUlZcY7oy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmaMlXyo3WPhxUMaxDQeBwbSknTUPIajE8OzAX7QxUI=;
 b=bfSU+foNyhZwDeeokdmoW2qg+KD3eKfLEC87IPl/bm/YNbg8MXpRlurn14NX0kpkTnP9WF95ILnsIxBzkLDes1gOPIiyUlTX1o0amOBVBiaOtqTDE5EoTIXmB1I7oJtp9/sry86YcXLvq77wEtiojgD9QKqC561oI9RoZJIrXuE=
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 16:01:33 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::2) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29 via Frontend
 Transport; Fri, 16 Feb 2024 16:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 16:01:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 10:01:30 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window
Date: Fri, 16 Feb 2024 17:01:13 +0100
Message-ID: <20240216160113.407141-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b328b10-e6dc-4831-f3e8-08dc2f088bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HkjfyST8NXQzNwB67Ym4UpWvQdHDuWBOz5SUpgWEn8QiaGrTNOJRef1Vp/deIguHjIMrnc1LlcUOEzidRNskA8KewghVeJJcb4fLnQvPSswJfHpzQQQpyJ0a/V/BNSus5cXZw/JZOD96uUjheqn8Il77H/KKQ7WvuowYUda1KBpqijo6uZnzquPZ8yF2EaqKjlBP7PDMxV/VVelc3/WAf+PrJ/cdMXXosDrhEV9LSpoJAix7Rt0AFPFvyzve4faz8jbFL5q3QFqoGTfoWZhQ+HBWUQSRmV4m21OIfepsFrpeiMZPYL7S4nIbd3S5TBCxyXskXohtrR3OZ4RQpAFTVFznrRAM/6rUA0RRln6CUFIxgJm7lWdDGysTW+PXhnpcDEfAjQrmRJXG0ynlVDQVnHKUCWZcugQpQTe3Qjvcjeu/SKDHrasXERiwNG6aWLEubBup0kzM0blG5E5K2Cwzconn+0mseUxdV+eEu731SkGtPNhSsXBregN7f58BUPto4WW8VcQE6Pio5jS0Zt/IlcUrRDjZrG5Jom+ipD4+bfFa+NAvgvOMwF+n/Ze/rvJSw7B7pNKBd9uJCxLJbIKPFP+98FotjbVoPFZk51ZWSa6FdJTXF110aCMObzDZFNyC2wzngQKn8GXTeZ8kAEJltWoFS8rHftR22lT6WgfLS4Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(36860700004)(64100799003)(46966006)(40470700004)(54906003)(316002)(110136005)(6666004)(5660300002)(8676002)(2906002)(70206006)(70586007)(8936002)(4326008)(1076003)(478600001)(81166007)(36756003)(41300700001)(26005)(2616005)(83380400001)(356005)(16526019)(82740400003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:01:33.4350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b328b10-e6dc-4831-f3e8-08dc2f088bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

The Linux CXL subsystem is built on the assumption that HPA == SPA.
That is, the host physical address (HPA) the HDM decoder registers are
programmed with are system physical addresses (SPA).

During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
8.1.3.8) are checked if the memory is enabled and the CXL range is in
a HPA window that is described in a CFMWS structure of the CXL host
bridge (cxl-3.1, 9.18.1.3).

Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
window and the CXL memory range will be disabled then. The HDM decoder
stops working which causes system memory being disabled and further a
system hang during HDM decoder initialization, typically when a CXL
enabled kernel boots.

Prevent a system hang and do not disable the HDM decoder if the
decoder's CXL range is not found in a CFMWS window.

Note the change only fixes a hardware hang, but does not implement
HPA/SPA translation. Support for this can be added in a follow on
patch series.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a0e7ed5ae25f..18616ca873e5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	}
 
 	if (!allowed) {
-		cxl_set_mem_enable(cxlds, 0);
-		info->mem_enabled = 0;
+		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
+		return -ENXIO;
 	}
 
 	/*
-- 
2.39.2


