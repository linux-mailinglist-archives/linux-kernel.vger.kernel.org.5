Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C947CCA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjJQSQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJQSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:16:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD093
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muaRN+v6AKXF2Q/GWx1IMgqVPQdH5k4GdbOmym10ktJlEMeWrRwZc82Xwu4O/PUCVQKreDhUWUBevXM+ITnpYwpyrXExfk1HzqUqpyNLGw0hZAnSaUXQ80Gr8rJD+6ro/Mtge4mPZaH/Vz1R3de3X9caJp9R1M2gjUbjyaVHE09fc/ZKQyXVEef2lpTA3XffVyANiQEMMLaQbWoyrNMyTBfTpsOXOKw/fSvP/EcBUSwrm2W2blNnkw3gR4BzHi6L+QHMOIj5/oaqONUM/j0NglNNMSCvZHDPI3N/bpmawJgB1XqUvk1lje8jBLPJ7ygy4OEhQ6rqSaDGYtcEi/0dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCkP7Cfa5udXj3hkQtCvCD+Y4NgIa13Jimac8qH50p0=;
 b=i+bBpSQnA1ozqsqtsDjeIZ/3aP6eyqCay6x3SLREpm/TvHmjGhDXfq7BZfSkx4/J3hIophMRDxL0eQApOKWXZniR92iedydtFwWRQm9qEVb4UMxtVyY3xo2o+gOHTGIiIHH7TPQqxkM3NAZUKp4THxmoIppe1KaAhJjS0DSTL+aixgpwRsXV4AOXXzWQVOqcE8Vr4TrL47AJTZX1heBEJcaV7DDwqcnigcA/fXP5XCeQpd1Hwxq9v0cDHFkM6XvyXg/DDg+0168/epgnlHN5U17onJS+isbJgnbHCWzi5QCUwAVhrmMOpRq5wWJ0WOjLtetud/oraouRphYRY8xKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCkP7Cfa5udXj3hkQtCvCD+Y4NgIa13Jimac8qH50p0=;
 b=bnOD5gLt1KPoo1BYWr0KrXEGWcwDhy3S+yauOdkB0oJVxc0kK9RNp8NkZmRsX6utChpufEc77IcGkTuX4QKuvPNEGx0QUpDAlsCwV5MbqEZiuojjH3N8pptPP44/TTcOVRoT25KFHn6kfqOYZtBnBDf1n9Xvynnb7irgJ+3eQQ5znVaDOCG2rJ76Y6Z8t6kU5YANUE2C2eoenmtQlxyKDcvQfFS/3FywjRv5R+QpUCKutZBX+iS0qB2aIkALus0stJibSde9bdKFgrxNFRuHk38uSaSpbW/Op8DdZWho5nLTXjB+EgNjGbmT3OaatCbUHJ/W3KFleWqmpCkYqQpj6g==
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 18:16:17 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::f1) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Tue, 17 Oct 2023 18:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 18:16:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 11:15:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 11:15:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 11:15:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommufd: Correct IOMMU_HWPT_ALLOC_NEST_PARENT description
Date:   Tue, 17 Oct 2023 11:15:52 -0700
Message-ID: <20231017181552.12667-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4015a2-9e53-47fc-90d3-08dbcf3d2794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIze+t5I9SpbROd0e698jQ49igxfzagJ2+kQXSUArM+DVFVQqOrUMqweopXEsWAzmnqpNrkOCNGfTU6UyK7J0bJX2Q/IZpbDEIFk8i4CNOF8+/Qb6hmTmfn4eMJYQPMlnmyN30gLX2B98YuVT+NF/+UjXUj6bnkNZOmSg28qGvRlvp1LqzHRpCqbbeglKTN+7fGt2VjZbdPEiSSjwedCjBOuKgXULf+vi2hSlW5r2nJ/nsg065LJur8BfFe7/P0+k0qpdAnaWr9yglDBSdJKbd6PFxjSGxTumbbKo8Z58uLKnEGAlpbXi+pkBN+zDPPmmAJLf2CaSYfTtSP9ec+gO832cCloD5An52yRD9dN5r5DOFiuYfysxP0MWzbhT2VczJGZEPpnbRuW5YMWNAex0vpcnMxXd/gl82rXvtu1yHQ87w0ayv4GhjDnP9o09mjcXTwtWNXCbyZdEQV7MJIo7mKP8O24pyrDJ3/y+GLS+l3JcWNwEuIqyZYS39Vyd/1AZJoxKfJ015T2tkX4asEaPIYW0xi8SHSPHRNahvkvjjgWIIr5UzyjHlxYCSb1mwq7ZGN4Z0Jf4Hal6sSlDUjGTR8AvV6/y+N3eCfc/PQKwzy4bh5W7WochUIjQYvqLePIM8aOpyKo3rAb7MCcoSuHsUgKXGJjuOIY0RptEasDtMWdoQLhMdx4EzHn2b94arCtOHiuydhQ3XZkYN05o9SF40BmCdzRBwnq3eD7giqYLRU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(336012)(426003)(36756003)(2906002)(86362001)(1076003)(356005)(7636003)(26005)(82740400003)(2616005)(83380400001)(7696005)(478600001)(47076005)(6666004)(4326008)(36860700001)(5660300002)(8936002)(8676002)(40480700001)(316002)(40460700003)(70206006)(110136005)(70586007)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:16:16.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4015a2-9e53-47fc-90d3-08dbcf3d2794
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU_HWPT_ALLOC_NEST_PARENT flag is used to allocate a HWPT. Though
a HWPT holds a domain in the core structure, it is still quite confusing
to describe it using "domain" in the uAPI kdoc. Correct it to "HWPT".

Fixes: 4ff542163397 ("iommufd: Support allocating nested parent domain")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4a7c5c8fdbb4..be7a95042677 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -349,9 +349,8 @@ struct iommu_vfio_ioas {
 
 /**
  * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
- * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
- *                                as the parent domain in the nesting
- *                                configuration.
+ * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a HWPT that can serve as
+ *                                the parent HWPT in a nesting configuration.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
-- 
2.42.0

