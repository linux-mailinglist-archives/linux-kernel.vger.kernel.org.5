Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A4783C18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjHVIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjHVIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:47:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97049CDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtW7auNzHUzXfthEWF+UN9Dnq+irNSicvyoaHXWb/7uOlYL7fEu1yWzUg97q55yRlGuef+bIi9SNpB6aWv9gs5nIzGasHmBRCW40oVad5fy4dg879wxzFi0epiE50x+reX/wABztr+JjYc3/csNoUOcEIcbgVJHa7dEQpx/6JzgLxyICrJXYk4ntnsZtd64evPkY7eqae2Z4aVNomhcc7458S4nAhHxedwquCOys7buOhFrgoP6S4IZV6NkDtWWtNOc1cLFeA9iKA4d7vPQjRcPCq2QCtBBLbTTQRyCtG5biGqKHss/4LRqGSar6SvE6G4Cck+9DRULq962Ti3ThHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjgbRMTEWbvEnQVB2lIXmGAwbywmUqYGCPSrsKCeCg4=;
 b=Dlc4a7Z0qbzEOunIZMmMqMF5A/U+HZVNPHBAJCvsYxYZPANIUMHGPlHetnHNaw44Pn/V3eKU57BqvYwfnq5wps0qUw3GeStVJ8LT+AN7l6SGIG0l+SMsw57oNrR2U+udx631vLeCrA6ZIqi0O50opC6+LxNpw9OF4KhNMABrhnsHEaI+FNTCwbngfPRty8dXzaou8gD+PQYA3rv5ABjeYdr5xo50ICNqvIQo+3oPXZUBXC3f2sQyr+r7NQfbthRksGgkdQw7Y38mXf2tQY6nd4WC1RhzrnlV2ay4fuWrols8twIpl3UmfQc4m6LqH0Z+5/Je8AgcgM+4ywC108BjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjgbRMTEWbvEnQVB2lIXmGAwbywmUqYGCPSrsKCeCg4=;
 b=WYf03wojETJA1BC4hNEMogNxT1xJNnOg4r61KkJynreM6McLyRQmG54IRPkIoJ8SU+FXG+oXYShXwAkE8gIGFXzDJcsY0Vljx+l4fGdyKMqfVOQrUskjgd58MoCBlyE2W6R4f2X+4zPATku9AVgTDkxSgtuf7w9i5mFZj1Ud1PG5aBi8TtSSdtA+qp2FvTpnt2q4cuQkxqwByVKd4Z3VP1wggSWagRRC1EmvMNgAsKOeJ+nEIXceURy60o7BBGbtpkqPhR3lq+v9Lxj+RhjI1SDZrlIIX5ZaGcNETuWm5+gvd3/TttU1u/htO9fN/PQHdOI5yP3vo0U1F+3tpI1WNA==
Received: from CY8PR10CA0041.namprd10.prod.outlook.com (2603:10b6:930:4b::12)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 08:46:12 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::c7) by CY8PR10CA0041.outlook.office365.com
 (2603:10b6:930:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 08:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 08:46:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 01:46:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 01:46:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 01:46:02 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH 0/3] iommu/arm-smmu-v3: Reduce latency in __arm_smmu_tlb_inv_range()
Date:   Tue, 22 Aug 2023 01:45:50 -0700
Message-ID: <cover.1692693557.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM6PR12MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c64e0ab-924d-4c25-cbc6-08dba2ec3d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q4nbTG4yeUOePC4/rm4Qk4xmIMRn+tk8rmNB1lUBlOeSwZc+r5U/bpqNj4/IKDDuyswsOtrvuxMMXqOpuBFaCcrjDgsPfpPxzlP9pzXnSCKHjhYk6gdIeCj0ZvhUvJdJE0PX6FreafnyDMXx9kP0RNkQMoOlLp3U/vj37Q3rReT2XAmsTwCeozrlIHPBy+8wtmGkR0LsJunuBb7Dtfl2Dib6L4sfhL0aj04RwMOb9dqYPWN/Hwa/viRySrIp614H2oEjLTeOhh/8n/jhNAV/i6GuMXKAXdya4RqkUlZjghw5FOlhXndAaEopqdZTZFDUU6tjTjZGPkSq6836nZXDEwIRH7mjzeWKZfd4oLJF/6exztGjw9qq3d0mmCuWO2x7fzMIEmsIbUSgIjCEKgkWH7Kk7hqgC/3/DZPeSNUv5ZcAQ4QAdXl3V5VfnHvAo9hmDs4gLJd5EjCuQzHAiStKvQzCKr/viZEwE0oMFsxemI7TPnsZKTDajkykIMScNiQ+WNdfPCPhYrv0abN8c7xBJAu+olhaTv6uzS0KPm5uEz+0hV1f5KN5WSoZbHHAglMbcpQpnEfhcZHCDk/vWmjWZBgSU87z8n+rvIWhSaKLpn9aM8Cz9z9E+mdOOPr1EaQJFtoLGBlMUu86APqO9HtvkglWzILqWoMoEYD5tlj0jKDt0b5/4vQXtakacoGR3XssM50jj2PNqTgVFXL/UoR8CP9+FNgFXQMg+0skAwikODhpSfcSDheB/cNlGW52Px1hnUtp+eUU7PpAVyIrcAwKA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70206006)(70586007)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(7636003)(40460700003)(36756003)(41300700001)(82740400003)(356005)(966005)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 08:46:12.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c64e0ab-924d-4c25-cbc6-08dba2ec3d4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is reformatted from the tlb_invalidate_threshold patch:
https://lore.kernel.org/linux-iommu/ZN5oojF6vKOKB%2FeI@Asurada-Nvidia/
The discussion in the thread above moved towards the direction of adding
an arbitrary max_tlbi_ops (similar to MAX_TLBI_OPS in tlbflush.h file).

The changes here aim to reduce the latency in __arm_smmu_tlb_inv_range()
due to the large number of TLBI commands on an SMMU without the support
of range TLBI commands. The solution is to add a threshold at the number
of TLBI commands that one __arm_smmu_tlb_inv_range() callback can issue,
and to replace those TLBI commands with one single per-asid or per-vmid
TLBI command.

Nicolin Chen (3):
  iommu/io-pgtable-arm: Add nents_per_pgtable in struct io_pgtable_cfg
  iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain helper
  iommu/arm-smmu-v3: Add a max_tlbi_ops for __arm_smmu_tlb_inv_range()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/io-pgtable-arm.c              |  3 ++
 include/linux/io-pgtable.h                  |  2 ++
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.41.0

