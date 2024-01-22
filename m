Return-Path: <linux-kernel+bounces-34298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F48377C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076F5B20DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226B4E1AD;
	Mon, 22 Jan 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fos0+rK3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA74BA94
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966463; cv=fail; b=K7s4VQGQzp+MXaWPY9Wxttbq7VBUZKk8Md4cykCx9iZQ+tb2NOzuJXd3cC3Lhl3CbSZMbXtYr4FRYrhClNSmQDzLYnBNbYN0dngIB82ytpPbIxzFj3OflBelsuIFTxVWFLHILAafrNLYPwynHHXN57CCPOmPJnLYb/XUceBLb14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966463; c=relaxed/simple;
	bh=i+fGfV1iKzd4P2HVtc5fY8RpyxEYmysiupZzf0YpwxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WallW0DKwCJ6zs5cpl0CPd25kstmgSqNjZTA80RGqUgkYpRjgnsSSEAUWhj4k9ZAxh7wgrdt0tz8GfBHbe2K+E2y4Zc2qw09dNS8V66cbPs6seOz0ct0iLlH3VEGpSLOdvNoEhCurY/3vDLLLsCgjygtN+s9eON5cjLdDb9w9gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fos0+rK3; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYCp8UC5SMB3o5DoTGTVBYDtraw/kqTzXn8SqxcKkspi4oRzJqb7RluoMxZESL1ObROgqSW19I3AdwK/AVlleIGMr+fxbrl+0TQtLwd6hHcI7/g857vZ9hw/hhgVqmqHiAx5EnZVaP9xosv0zHHTqkhwGajdsc7FoZXuyRASN1ib/YLAo2JIGfDQJCYTdSqKlsRZZLbyxLNTv2FwmEThXbGdyv8KIyHIPYm/IDFYAqpqUkyGrGPUiUn8vL4+n9TMqwMYeXW09QVmEd4gT3QMR+QPHzfFjWm1DLbrk0W7NIL9LJ089ovko5SHkr+mJvYb7AygeHvzSWhF5p6p9w3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fKlV/EM0/bnJ2JznlbEW8mLgjj8l1TFF1Ra0adSE9Y=;
 b=YGDifNLXzwut+yoBimBN13wH7So0sIK+Q8NFMcAnlUOZqiJTSIyrCg03CIkNWZqNAG4sRd1H6cq/pfo/34ubv1a3Q3XedE9z2oSQle2XLYjfooWW1esLD49qDiGAdqG4N7NGQMXeDGBjfgXkFXjVKya4k8pW/WDscvuXie2lM434FpoEjbREgwDj2dZwJdvgJ9xnhKQ2OXq8NfHmwhtJzrDzZixZ3aQD4aOXA1IW+tc0uYrlJqYXqC3QFb2QRbGZVdimSbzPQ1l4wLck0A6owB8kz6Y3Gm45Y3uSCjNG2yhGSuEp++bNW4hckxfirP84dwY22Xi9gwDDITO+sCiekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fKlV/EM0/bnJ2JznlbEW8mLgjj8l1TFF1Ra0adSE9Y=;
 b=fos0+rK3OJ2KioeedGkmaZECuFMaqOEKgRtNYVaVa/ltGZ41rdj+mO1sAO+z7sILYI5umdEh/PJTVBHm2ncYKrynhgD9nsLDhaHuZYoSWFvWQPlQEP5Dc3oYVPMIZ/ySzZD+pn9Vn9d1q2yz/IcduAoFLP+NkcG5zp325am8a7Q=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 23:34:19 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::8) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33 via Frontend
 Transport; Mon, 22 Jan 2024 23:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 23:34:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 17:34:16 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] iommu/amd: Mark interrupt as managed
Date: Mon, 22 Jan 2024 17:34:00 -0600
Message-ID: <20240122233400.1802-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e79ceb-9970-46ff-fc24-08dc1ba2a78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mnenekLSYFpbvs6/rG0R44cKa5nkEzv68ApkwSInoBDDa1/WRdf5xpPAPV8kP+3WDytd45GbQYkrD5cljTFWz3z5sfyCbVPhMidkyloimIKOCTBIYaJ+Kema7YxWpMzIOnS1kE2MDvFH6YWPXdVjQce9vzXSIIezRZDz5N2gmZgGxpVdq53whH1HpdauvpbICH1Fnf7rE+JVG5qJLqb+bk6Of7zIT25OVwjoW1A9y2mROV5YYZdxK46v5r8LpR4H2CXBiNMbwQG9UItAUKVKscxiXEq3i5cD7QAKFnXLh1N3YO8RRr7UKtRlQ8Q6CyYVNYPkkIhqfGzcY1bnCADehP6nu6m2RtUR8g2RhWUfflQ/EG8+lkELc+g4Genb2Le51Jj2frns6QRWnpEkVYWC7f6T10DfneAti4Nc9FDRm0v7hKGndSbc5kLYWy/O1T4SCLpukXmA6yMfgSeEwYRGtLcWF7RP296MVVAbvCvslLoWRxJQNJSRiv2/j8O+PhDQU1v24ONIwZXdn56533WUx6u56V5EtK+vAORgA54DNSR8iC1vtPd4LMcNYP+QX/fReykzucFbszJRykgl6M7PuWY3bd9rWbCSH8lkaWs4gUuK+QPWE9DW+HlQWE5mmHEV9ty6oCfp9dtZvS9UWhKvvjUAXeJS6hEAt9hBXnk1C/CaAymKjvfvfDAbCnABWbCg4LljqiVKlb/HDBe/HQn1sb+c82lqfoWO8BbQ7RfPJyuZWmRas/DG8z+Av5u5QvRPF3ExVbuxSP8ZNwOlDX93a5G8zm65vzccyFDlXkLX9dhr63U9pyraKHy+ZcwKn42m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(40480700001)(81166007)(356005)(36756003)(26005)(1076003)(2616005)(47076005)(82740400003)(36860700001)(83380400001)(336012)(16526019)(426003)(110136005)(70586007)(8936002)(70206006)(8676002)(7696005)(316002)(6666004)(6636002)(966005)(54906003)(44832011)(5660300002)(4326008)(2906002)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 23:34:18.7019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e79ceb-9970-46ff-fc24-08dc1ba2a78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

On many systems that have an AMD IOMMU the following sequence of
warnings is observed during bootup.

```
pci 0000:00:00.2  can't derive routing for PCI INT A
pci 0000:00:00.2: PCI INT A: not connected
```

This series of events happens because of the IOMMU initialization
sequence order and the lack of _PRT entries for the IOMMU.

During initialization the IOMMU driver first enables the PCI device
using pci_enable_device().  This will call acpi_pci_irq_enable()
which will check if the interrupt is declared in a PCI routing table
(_PRT) entry. According to the PCI spec [1] these routing entries
are only required under PCI root bridges:
	The _PRT object is required under all PCI root bridges

The IOMMU is directly connected to the root complex, so there is no
parent bridge to look for a _PRT entry. The first warning is emitted
since no entry could be found in the hierarchy. The second warning is
then emitted because the interrupt hasn't yet been configured to any
value.  The pin was configured in pci_read_irq() but the byte in
PCI_INTERRUPT_LINE return 0xff which means "Unknown".

After that sequence of events pci_enable_msi() is called and this
will allocate an interrupt.

That is both of these warnings are totally harmless because the IOMMU
uses MSI for interrupts.  To avoid even trying to probe for a _PRT
entry mark the IOMMU as IRQ managed. This avoids both warnings.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html?highlight=_prt#prt-pci-routing-table [1]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/amd/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c2a1c9..40979b0f5250 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2068,6 +2068,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 

base-commit: 75f74f85a42eb294b657f847c33e1bb7921dbec9
-- 
2.34.1


