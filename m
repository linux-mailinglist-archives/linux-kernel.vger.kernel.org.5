Return-Path: <linux-kernel+bounces-164250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5368B7B62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146DF1F22876
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D7172BA8;
	Tue, 30 Apr 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RGVFTxp9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1814373D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490701; cv=fail; b=LkzWyimZ6adg7+pSpnAhxmCS4v4nv/BmTiRdzbokR3FvCvE5hURS55njnMzpeYTUHJMjR0sC9T7W6RYxXqwfOk01zsbUNkuzRgLASKcGTCyPCjeV66hp6uCswxmDJUOnCQ4XtvxU2jBoRKwBmgq1Fafn+9iq8uv2rxzczT0IKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490701; c=relaxed/simple;
	bh=ZsAm/8qDULbCMZmUw2Nllf4avr0F/pSlm0kuMx5cJL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAFGeIdBT4rXq7eQKHkewAyp3AzJQEnFzIU3/u+gn3VGbBsrQ+l9u+ZsbHf2hBVbt6YiIqQ6lFxhimeNSjA+70XYrl32WHSNViRQDKoUksfHNRZcw9AIl68HSy6mgi8BkbI6QJdGK0wHrzKvtsasdfLz3TN0Dhfc1IuBRus+HQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RGVFTxp9; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV1FtynjiEZiMiVH2e9RnKQwOIStOpWLiriEFhKRVNOFwI19kCtkVqZb8JVmsbKFj9b3MkN4GrEVt5/ztWZIrZ8Fsm6KcjiYoTm0MVGC1Jd+vmq5DFQNwpJTTGGZDCGb709HK6jFHEz2E78WXUvf9ZdsA6LQlJbdHXeDSSEbcP6guFeKD2H/1/l3JxgBR0nMjTO/TSqGLxxrqtorWTWmtBMfkhqGN5HLjTS+huxmpAA5P0RbcNRNoJwMxbkBVVy4qmnUHA9XCviCAR6XqQkU7lu8OpsY8WXE/VXyYfqDxR8CgEuHkMYjSIdq4726NpdeVE2k5CNRkBLZ4SVSAHA20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiHDPcEJ8jh9NMbc8mV90pNhBXHsG72zqWLbTqYBrfA=;
 b=WgUv7R7mARXS5g+hQ0Dn1q6PUI0kTrm6ilhuy/imoKDIAqkmdat9g7G2E2+/5I5vn7ot+kMecxhJsg/4QselrztGN4mk/SUhzu20o0ubzFQI3nuHr7j/0Q40tjB0XrXlOAFIbCEZK2jhpCxCKjTf4qomXbXCEBBmdcHhkbq0EAOQS9qMDyUAwYQaNtpKap5RZAiZ6a5CQFt+PgTUhd2UdJkA6FUnJ5ly1ByYVhIzK5tQKEz94d0KVJyf47OtmCsJ7ChhzlZAxAOU2m2NvNCfK/3pP3+W8LRed87jfwQgum+E2fnhb1vV1EcLzlyzywr2McODXGmuNpcjnv6MN5RjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiHDPcEJ8jh9NMbc8mV90pNhBXHsG72zqWLbTqYBrfA=;
 b=RGVFTxp9mzRKgmHb0NyeWYaJi4idXM3dQ47UoL8j19FhgzqndGjtRbJTlKtQhiM3Pz9wxR+KV7iEnNgeVl9Z69tVetSWHUM1FvFz5/99SRqnrJ1Z27Ek42MvSIt+TH0KKvDkU6FQ+aoLO+D0yPprOFJhLPSlnJWkIFzzgLTXQp4=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:24:57 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::a7) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 15:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:24:57 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:56 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/9] iommu/amd: Add AMD IOMMU emulation support for SEV-SNP guest kernel
Date: Tue, 30 Apr 2024 15:24:21 +0000
Message-ID: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3890f3-76ed-47c5-92ac-08dc6929b1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ils9fupWgesJ7iQ80cWx69R3vJmV5Zs7wCkWQ1EYVt+AssFeiKzXar14DLkZ?=
 =?us-ascii?Q?reAv/RCvk+F0kb302JjVC4N2CAntwx8fVvS7eqYjnHwVWCTBhkTG0dqTONZi?=
 =?us-ascii?Q?NUukerCuRm9uAR1Z6RM8wxolUOV2Hi337zl5ZRGw0aTORCq1Bgdx6rJa9zio?=
 =?us-ascii?Q?o1YJSf81NBlLQ203nzT87aO9YdpjrmTL+MTibt7eOCuRfnwFZxogq8ADdhtq?=
 =?us-ascii?Q?Ba7+7gX+NcDTX1P4AadeottGbLYAQbI1rKTnnulJQLFkjQLJ6VS8SotTncfZ?=
 =?us-ascii?Q?HekcTChhmaby82KC/aMCY4tTppin5wNom95L/SKpPiC/nJ4Kdz22ri4yyljJ?=
 =?us-ascii?Q?vr458/ZSX7Lep4Q/0oq8xVZlQoygkkhJvUovdbzqXUQWrajTRZUo9VRi7z7R?=
 =?us-ascii?Q?BpM4CYgGoaCgGTIBUyS6EKxw1M3UrF0wCJrZcH4T/RNRqcI4IOmYUyF49Gy+?=
 =?us-ascii?Q?x3WJVhXgszpSpJV1hgJOOAdt6VERlBdVOKiY3XWnfhhnfex3a3qDpjQmrviZ?=
 =?us-ascii?Q?HoVrcYQKJJYmBI+wzcvuLOw8PyMm4CN4u4BJhkDcBm4IkA4682Kv8r62GNM8?=
 =?us-ascii?Q?P4P+n5CqJoRqfh2KFrzmYUjpWwMLBYdE1/VZsOSBkovszELyw8Iuc4ymoV6G?=
 =?us-ascii?Q?0QriFol1MbyYIkmTwQ/y9o2L+qr7/Nk8YtsRrtBawDRki+BXeMOzyyfS9svN?=
 =?us-ascii?Q?DfPmOAEIgkGenHJ05+HTnpbiEpNC2KpLwTyPZzQKDLd1mlcojrucuu090axS?=
 =?us-ascii?Q?PMaJ/MTOU9+Cmy2e3hrjY3wkhfgWzk4S2JZg5EKXLPihrjK0E2VmtkKSPdK3?=
 =?us-ascii?Q?hyZVQi9hydq9wWLgzQSzlNRp/32MKtC0jWbQj/ZHg6RGAO0eyVdVWGswND5P?=
 =?us-ascii?Q?FXtf2jJ8yGaMfwMGH4L+FH2gGZfLY8ZRYQnAjhz2RMobDlD/ks5EL4GjJpB+?=
 =?us-ascii?Q?rcDhW/oEpjwASae2OcyaEPb0u/ZDS0xd1uotDZnmfO7C2hDtO1rercPW8/4Q?=
 =?us-ascii?Q?3y2sPcPUHm3RBen/iLseLoOQntaSeK4vsGLR2zSb86/RU8ZcTxxNaF9rfBp0?=
 =?us-ascii?Q?TYmI3r4y+dhCBsj2S9dnpC3McgxVVlKXdCSNqgIBjFiC5Zin3uPHyyqPTJBn?=
 =?us-ascii?Q?dz+SLyn/awhIjkDYsoIU/9Uot2mP0tEa1iviFNOu3uOTC8i6Ig98OztB+q9H?=
 =?us-ascii?Q?9hmqHV4uaE1JEJ4el/zK8a9C/DQ74EHByTnll46NvZYdXoyWVOXJ89Biat1k?=
 =?us-ascii?Q?XPReh5bMNNFLVTA8W4eZqA9JCgbLFzkuDTgJxZlfexCXw4SHGgARpdei8EB2?=
 =?us-ascii?Q?NVRpgh9iYsHhsKWbCCHOsqhxSPZR9WqHkpzRU2vwn0wErqfRtbBcwNyFh3ru?=
 =?us-ascii?Q?WQRoyT2waSjTDC+nOoc+FoH1LeNG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:24:57.4282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3890f3-76ed-47c5-92ac-08dc6929b1ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

To boot a VM w/ x2APIC ID > 255, guest interrupt remapping emulation 
is required. For SEV guest, this can be achieved using an emulated
AMD IOMMU.

In order to support emulated AMD IOMMU in SEV guest, memory pages used
by the guest IOMMU data structures must be in decrypted mode. Also GPAs
for these pages must not have the memory encryption bit set.

Testing:
  - Booting Linux SEV guest w/ 512 vcpus w/ QEMU emulated amd-iommu with
    qemu-system-x86_64 option: -device amd-iommu,intremap=on,xtsup=on
    (emulated devices only for now).

GIT repos:
* https://github.com/AMDESE/linux-iommu/tree/iommu_next_sev-iommu-v1 

Thanks,
Suravee

Suravee Suthikulpanit (9):
  iommu/amd: Introduce helper functions for managing IOMMU memory
  iommu/amd: Convert Device Table pointer to use struct amd_iommu_mem
  iommu/amd: Convert Command Buffer pointer to use struct amd_iommu_mem
  iommu/amd: Convert Completion-Wait Semaphore pointer to use struct
    amd_iommu_mem
  iommu/amd: Convert Event Log pointer to use struct amd_iommu_mem
  iommu/amd: Convert PPR Log pointer to use the struct amd_iommu_mem
  iommu/amd: Remove iommu_alloc_4k_pages() helper function
  iommu/amd: Decrypt interrupt remapping table for AMD IOMMU emulation
    in SEV guest
  iommu/amd: Set default domain to IDENTITY_DOMAIN when running in SEV
    guest

 drivers/iommu/amd/amd_iommu.h       |  31 +++++-
 drivers/iommu/amd/amd_iommu_types.h |  28 ++++--
 drivers/iommu/amd/init.c            | 144 +++++++++++++++-------------
 drivers/iommu/amd/iommu.c           | 133 +++++++++++++++++++------
 drivers/iommu/amd/ppr.c             |  22 +++--
 5 files changed, 246 insertions(+), 112 deletions(-)

-- 
2.34.1


