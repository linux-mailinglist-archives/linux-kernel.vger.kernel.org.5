Return-Path: <linux-kernel+bounces-59117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1949084F17D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776BA287524
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231865BDF;
	Fri,  9 Feb 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9c66UWr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C69664A2;
	Fri,  9 Feb 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468036; cv=fail; b=nnGRsIr92zyKMfrj4AlsrdP+PW5I7d7CZTlpwWIFyIGC5+MRuvTYdv3ln3Z/Zx3SIcVsuH94CDjew4WSOrqkWetfvCI7wvsl06ziRy6p4yfh6NIrtlfdye+ljIDZ06Np6qSFp/xU/IfV6CrQi2XHH/RrX8K4nolera1Vr/ivfgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468036; c=relaxed/simple;
	bh=jUimay0pmyh2qIdcMbHjc58B5XCl0Gcdcuz1I2AsH2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8OBkqSXoSN49sYHnXXIEoQUccTfB/KNRAs7Ibj9+q6S7Y+A+Eu+XC3muYBcwqZ6EJ5Hvlu4lOuz3eNM7hv3wpL/J53nB+RB6dgcgUVaSdxtP886pkr/wO84+2dsZXkEFZjJWaHtsJWIi813win75KbJPZVNowfosl4X6jd0z94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9c66UWr; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LasTXD53eMNK5YB2R0YltST+zv7nIyQzU7G+yKzj4BVUEM+FNdR+JgfdvUP4rrAMNjF5ruvmaMd7Ie/ReMuv8ueE9rmlvbf6AUuheJZFgM7ViOSiSmN8AAzoiv7sHmoAL2a+fjOZM11F9HrbDtETOIDdWqj55eTESdww3rCw0IG702dTL303lE+6LQ4p0+YGP0ELMlfJ+7ogXHMHqcVYx4it5UX1nkmbdszMrQwy8xYWSrpJKwKgpZIcGI4ZJHoAKiRmqUIDYcETF7Bo73elPXGOJkC17G6loHgC9lQlCGhcyInEW3FEeWX5+cJCCa/SgyeT+Em5ZD7Pxkco35tAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkO64VhZbJmmfW1WDFauGg2+iN3HRJDwheFM5gmYX58=;
 b=N67XC51qJK9h8NoSfzPMM6GcsJahkKP4og4rCJJSpcxbYk173MhvYDkR/1elmOGP78hHWdj4YdpRCNUALzAq+Z32eH+GaiDsgriLnk06vDnv9RrF0/luk1WT6fcAAGI2CgAucnW1+IMLNd4J0Hm6sQxCIcpdY5r9e28cZNNAkJ/OYUvLmKa9zcar6jNaGp9DLEKNNXniN7xttZdDmyePirAa4hBK5tW4+PgvKhBjub7iLX1SKGG3It4QiQSmSU7yJykgiyd2W7oqkpxOkI0xDFL9QnxQpGi+w72hpBV/LzYMynoKc9H7NHY5pPwXYVcjY3lvf28UF71x9czq3Zwn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkO64VhZbJmmfW1WDFauGg2+iN3HRJDwheFM5gmYX58=;
 b=n9c66UWrYe1pKCaEehL0lZRxxceEHm6jPAM0vJ0ufPGBH7l6oMF53MVr3JB8Pxb6wbqqL8uR8lge0pc3yJ8wTiCr9duNdpTUNUeULHCaSVrsEcvxBMQS6KC0sRyZnprlfbPRSSOg1ybqs1EMXBhFKw92yeAS1M/XD9p2UfexrXCEFH5uSORAurWLNERQ07zSNflogfJHSxad+HRCi+0YGBIuaceuqC6p2DLJWZ0e4yLf9vddHxYMAzDgn/rOP7cq7T7lBbWKTO4AhaOEp5qqOxCUVqF/3jieE29Yi41IbXd3b1RaSdkX1QgaO6shQwxFUx2fz61xkLyJzWLQz+KL2g==
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 08:40:31 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::39) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Fri, 9 Feb 2024 08:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 08:40:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 9 Feb 2024
 00:40:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 9 Feb 2024 00:40:08 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 9 Feb 2024 00:40:07 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Updates to mlxbf-pmc
Date: Fri, 9 Feb 2024 03:39:53 -0500
Message-ID: <cover.1707466888.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c58b1b0-8be7-4f6a-e419-08dc294ac64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5lsTM8Wt1Ju2rXfUiMprPNpbTfJZwr2eFH1kjE7RVZC6NrnFMH94sM00eiMhVGcLziNPNfDDZsk5PEDfzmI8fVo3vPiF2SOSPUZulBm2F1XnA45uPBxkBKQqFo9GuUzCodmeC2AyKk6YXboRqjLdn51n1w+t7/LP+m7hpV2pOY9BuqUFhMpGq/XUTroyuRyIois4wr6EkLd9PzITl1qNWGu2VS632d+cMlEVRstiqFTAyJ6hivNjyFGFNRFEcfN2fc8ddnZ+4uOlre38Eum7avl4MdW5xYJsY9saV3OVHRdlgoXsuar86m+yhTzi///T2knRYxeOf5JomA5M4W/CM5Ia0nnX6Kup4mDzPnefRUFyE3BQ20EnOPlwcgpYl2R4Fs0GaookxjW2RvYQ5qXyFjNw8ZWDSateXvQdkT5QqtoOOQP0A9Y8wqMvM1xmySKw+60YtKSN0RlJxvLBD0aP91Uc99ry8rI9y1rvs8zORyKUlFxRo9o/IM0SCZuBOwzDgXaUkqB6+R7iC1zLiMgDD39KlR0U7ogxPidUJzaporAXDlICtaXdnojHmifgPWCHVMVLl3PXMz64qmomTy+iFgQLhLk6yjeY+CzTTduFv8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(41300700001)(6636002)(36756003)(478600001)(8676002)(4326008)(8936002)(110136005)(356005)(2906002)(54906003)(5660300002)(2616005)(70586007)(70206006)(86362001)(7696005)(6666004)(7636003)(316002)(82740400003)(26005)(426003)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:40:30.9673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c58b1b0-8be7-4f6a-e419-08dc294ac64d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

This submission contains 4 patches:
(N) Patch 1 replaces all uintN_t usage with kernel-style types
(N) Patch 2 resolves signed/unsigned int mix-up
Patch 3 adds support for 64-bit counters and tracking cycle count
Patch 4 adds support for the clock_measure performance block

v1 -> v2
Added 2 new patches to address generic issues
Replaced all uintN usage in the driver
Fixed signed/unsigned mix-up and replaced identifiers accordingly
Replaced kstrtoint with kstrtouint as applicable
Retained devm_kasprintf usage since other instances require dynamic allocation

Shravan Kumar Ramani (4):
  platform/mellanox: mlxbf-pmc: Replace uintN_t with kernel-style types
  platform/mellanox: mlxbf-pmc: Fix signed/unsigned mix-up
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block

 drivers/platform/mellanox/mlxbf-pmc.c | 381 +++++++++++++++++++-------
 1 file changed, 278 insertions(+), 103 deletions(-)

-- 
2.30.1


