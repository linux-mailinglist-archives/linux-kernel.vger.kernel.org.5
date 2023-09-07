Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CE7797B62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjIGSPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbjIGSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:15:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEA2136
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/p7M6mLopwFc5BWOvgORByYdGkjRK4wWv4SPGQA8MAialtFaKPjCi0CJ+tBu1UtBmd/a2epCz5O8Nm3A0Ql0hRC60QXE+khHlhqbNrdUrArN67yMg+TKS0WVGvh6xnFIwFFNiDqEH9STnvl7FG96ytwoS4Q/9RKDyK3i2FpTyzLcM4vHqLm8HfglRDeyphB0fPrYApkdGJw5k5xgt2W/bHPH5gkxe7t++4H2D+s9A7ekLQn1JIQbIIQDm6S2UMvkmm8coL2cj79WKcavrgFInzKH+F9glAAEmrNlpNz86D6pU/9HI4wvPHLMOu7N25o+nr0grUjNAjP5wtchQuriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntxOXAzag4KmsXPbY2xOEHwIZsNihmZ+5XcVn3QEkg4=;
 b=lkeKx5Fk4EPv4y4GlyJ8qX8CDNlKobG9jp1sLdG3mABaDJ6wCScgPtgiE/9XG8XEJnu3a7VpBaRq2bGJKTIkPjnN08H3BqFYUsQLmFcQ1G+PVoGow266O40QoyzOZAoAPSyOLa4udG+Um53Es2BDmeuEL0+0bUCn4Jb2zP7OYkzts1S+NJZ/0ctzTIsjC8oVUZSyCw22jjvmzrX6kDEbnMDeZBLvgOQfTJ/O2zIb0JW/sG7biP8cU5oeSGFjlUqFAXFk+UgtqpwP196NFC5PPAykjHPtuDaQcq7JD+4Q45/dcP9THwfXu8/prHA3N0SOpxRUPBNhJCRLkLoMb1Jm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntxOXAzag4KmsXPbY2xOEHwIZsNihmZ+5XcVn3QEkg4=;
 b=fDzpwk30DkpnrP0jOKSLxPNaZNpaVpQlj40bO2T/ecURZimK4+T18LvbTT+n6akdIND1I1AQB51AluXcrKqK8PDl71/BHtk9fE7uv2xN6yfKyld+1eTeyqh5DmiymFSkvQ6XkXYnHACwyHH1Vm2lcw7OHz0uIUvou15CfNjULMYPKDdafvHZj1kthoaW6BWeS0AdZUgstyYxiUSBLHfhhPvJ3cUv9UNp7ANwxSTAiZsdLOnbyZ8sRKhXxJtB1GlosUh2I+M3Q7hSZC1WkzQRKN34GwcO0czdVjv0ysIZY5A+Y+Q4MaRhf7ccE3TlBRKqAvR+8LtQQ5delXeRabPYZg==
Received: from DM6PR08CA0046.namprd08.prod.outlook.com (2603:10b6:5:1e0::20)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 18:15:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::29) by DM6PR08CA0046.outlook.office365.com
 (2603:10b6:5:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 18:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:15:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 11:15:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 11:15:01 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 11:15:00 -0700
From:   <ankita@nvidia.com>
To:     <ankita@nvidia.com>, <jgg@nvidia.com>, <maz@kernel.org>,
        <oliver.upton@linux.dev>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
        <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
        <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and NORMAL_NC for IO memory
Date:   Thu, 7 Sep 2023 11:14:59 -0700
Message-ID: <20230907181459.18145-3-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907181459.18145-1-ankita@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 567b9141-f874-4537-7f10-08dbafce5f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mnDT81U7AQITPoNCJSezBIzT2LzZ9NvGswTaOTfb6GXMPMpsLP5uKFlR/Aa/oZZ38GmlYPayg3KgRD6DZGZUmznJI6v1RoOcMIqVkqK0UScwNx77s7uLypKMjBxPPBQytdVrC9zPxmEceGcW+EZy6zFFgWHiojtZdstp3oIwu74flGzddJORKY/KK7Fse5MyMWc0McW1B266zNy3tSbBOB93cODj89avZfIXDvHqPp1kM6MdU5Ht4TRWmySL0Fm1zGbYhMO6r2Nsx7/vzzdNHdcFyg0kSsoIPMerA5oAwvjgMwFoC3+sqhZaQ8jOE5vruhmRrhesv5zAAmUJwNomnBxe5QPlBu8ac11gPRo8kY5UNu/aYf9sVOSufkH309CnRlRozvg92WUtT/QEZodvLQNJpjJ5DKivdP//I1gq/OJsyhuY+cPRHE40xxCKLj4LqYvR9SwKin8D8C4MGGHxLoXUM5fYTw9++8AhVt6MeJQzvafaev9TunHuFl/Dzwho0tDB6h+ZMJiIuDm402AVUGBc2QepiuUceNtyFQNbAO8XVLfLFVG/9B23vuTQGFeULYlXufdyvjNFmS1/p5YJFv4XhomzkGDBButXe4uAA2OBJUYvzF/x54NgTTG3dAYIA3sk+sFm2z6vwOFlOYVf23BHdu2wDKBsvJpbYS+nH2X/JOybGPBAAion3P3S1SaCWHANob0SnzIkcVkr3+FRPrxfjDoUpZx9xo/sygVYTR9VVskmZbfSBM2jCuWnZqn
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(316002)(2616005)(82740400003)(1076003)(36860700001)(86362001)(110136005)(70586007)(2876002)(70206006)(2906002)(41300700001)(8676002)(4326008)(8936002)(47076005)(5660300002)(19627235002)(336012)(426003)(478600001)(40480700001)(7636003)(26005)(356005)(7696005)(40460700003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:15:09.5608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567b9141-f874-4537-7f10-08dbafce5f1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Agrawal <ankita@nvidia.com>

Linux allows device drivers to map IO memory on a per-page basis using
"write combining" or WC. This is often done using
pgprot_writecombing(). The driver knows which pages can support WC
access and the proper programming model to generate this IO. Generally
the use case is to boost performance by using write combining to
generate larger PCIe MemWr TLPs.

Allow VMs to select DEVICE_* or NORMAL_NC on a page by page basis for
all IO memory. This puts the VM in charge of the memory attributes,
and removes the KVM override to DEVICE_nGnRE.

Ultimately this makes pgprot_writecombing() work correctly in VMs and
allows drivers like mlx5 to fully operate their HW.

After some discussions with ARM and CPU architects we reached the
conclusion there was no need for KVM to prevent the VM from selecting
between DEVICE_* and NORMAL_NC for IO memory in VMs. There was a fear
that NORMAL_NC could result in uncontained failures, but upon deeper
analysis it turns out there are already possible cases for uncontained
failures with DEVICE types too. Ultimately the platform must be
implemented in a way that ensures that all DEVICE_* and NORMAL_NC
accesses have no uncontained failures.

Fortunately real platforms do tend to implement this.

This patch makes the VM's memory attributes behave as follows:

 S1           |   S2          |  Result
 NORMAL-WB    |  NORMAL-NC    |  NORMAL-NC
 NORMAL-WT    |  NORMAL-NC    |  NORMAL-NC
 NORMAL-NC    |  NORMAL-NC    |  NORMAL-NC
 DEVICE<attr> |  NORMAL-NC    |  DEVICE<attr>

See section D8.5.5 of DDI0487_I_a_a-profile_architecture_reference_manual.pdf
for details.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 arch/arm64/include/asm/memory.h | 2 ++
 arch/arm64/kvm/hyp/pgtable.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index fde4186cc387..c247e5f29d5a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -147,6 +147,7 @@
  * Memory types for Stage-2 translation
  */
 #define MT_S2_NORMAL		0xf
+#define MT_S2_NORMAL_NC	0x5
 #define MT_S2_DEVICE_nGnRE	0x1
 
 /*
@@ -154,6 +155,7 @@
  * Stage-2 enforces Normal-WB and Device-nGnRE
  */
 #define MT_S2_FWB_NORMAL	6
+#define MT_S2_FWB_NORMAL_NC	5
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
 #ifdef CONFIG_ARM64_4K_PAGES
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index ccd291b6893d..a80949002191 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -696,7 +696,7 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
 				kvm_pte_t *ptep)
 {
 	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
-	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, DEVICE_nGnRE) :
+	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, NORMAL_NC) :
 			    KVM_S2_MEMATTR(pgt, NORMAL);
 	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
 
-- 
2.17.1

