Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70A7515C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGMBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjGMBWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:22:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A01FDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbqYIOgO5HM66qNuRqw4lrxMjrr5PbqJuatLv4PBqH1OnlNwC/xvnbaf+Of/YkcZwHgPwCPxulRTCprsZibxqrlaSpaFS2nPtmM/SyxU3eF8xvklZPMZLJqkwy2htyLqpLCAFoBp0i32j2LVyK0gK+9qUe6+oX8lGziNmxfy++pEZR6A52mhXmQqIEczvfIh4WVRY95y4WZyKTbOnF0Cl8w+eRtWSOlys4nxq6I9M6xAehBfABHuwakcO3ZgXJoI6uYWkVRVpExCRZUah7+/9m0cF4QSrTIYe0cjekIr1SRB1IbGRohF2mIZTFEC57Kb3uJ+aVxyxRGR5RtUWepmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icof62/UXdM64dw5pMxaKgOND+9Dmu92u6L0Eqc/NV8=;
 b=hSSQv4Hrd9gDnxu9T+qn8Tn/40FKGLNaN6v4sORJWQ7RnZItIeWoIJ3j6u3+gWbizHQIT0+yV3pRhX33Sw2k6ESw06f8ojmRRkCj3M9WzERqajCEOihGsPOqqO2D9wAxBGPxy2twAzjXal/bryvUuERFq6qFEZwQGFWM0HAHdICvaykogKy6wxSARpbPMITxwAUvuEN015C+9BU8Ym1utFCkWWMl0fTwjAIic7iEDnUJjET0rUNeT321FPGPEmEAlH54teRm7gDTqgNgu3tDQCbxXE9Xcn+ylJwcXRKAYEQUbEH+xR224SMihiG4AUZ6XgsBSpRS4ExSmIpc9W61tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icof62/UXdM64dw5pMxaKgOND+9Dmu92u6L0Eqc/NV8=;
 b=jdPytxRRXlnD8QbIrXfFEZqAO9MlhZz3kJeGSkmYuO2SkGYFuAJdQJ2XLOPsaERY/o+3J8FLRkYTHuoAiv8LE2rc88TlAoZTRBB+tYtSajQfV2FBWBPImeiacjyfsopK5sAiQdJasnetMeGfyclVdK+c4yPC8PGv9XLhmeFNbvjSPSAiHyYNlpnzmt4YXG5M+1uGXYQ5HrtWHq/2ZhoAsQX9uT5Wwb60y+Vc9mGXFxfkUOhRbHVGSaPQZmXDalo8SwuUxUGf0x7yQxMGIF0CBerwLSAqPJRxeEwytljCTnC9jlX1/3F4jbwe411QA86LhRLsJCMW92cZ18vfQNOZ3Q==
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 01:22:32 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::7a) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 01:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 01:22:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 18:22:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 18:22:19 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 18:22:19 -0700
Date:   Wed, 12 Jul 2023 18:22:17 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZK9RycgNAVrxe343@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-3-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 305874b4-8872-4a0b-9856-08db833fa1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgvGn8TZEK3oLLeUU8VC2aVIowUA2R0hrU1wUbAscDb+m+3yedmopxnDHhWBUXqLnwcRaGF7aEFxcwVm7djs9TCO4wgmREk9lrjS0d9TLygmUjgfr8k62gjq+oNI2YUkcDHIJb2M2p/4QTXzuy0+IJYFiMFagFHpiJRHUp8vSYxQQxICLD1JhdNa9fwE4fwXmQUBUlZP+Ya1985aPJwEkCirmU/VTWv8kEzOSGxEtWPolYidFp0NMWBV0srB0oaoOTzmoAkaAE14AIF4TURGdycR2iJHuuQlVg7s4ZFe42ri7+NZwCvTAJT8z7thzvT2mcdygWpC1TW403vxBO6V7tDGC/saR/C9jrwgfWrREppo/apwgWpxpEFpo58Dqx1O2eLHxW2s1de5Ds2zL0SNkEAPdq0k/csigmVz2H1FVDu3Ei+iz2FFUWKZfyQXJpCfDQG6JAJJ6fopDH5M1nOC9xIFs7QNcg5El0iWNmySO7fLH2s/G5KYy+HqwuZem5kmDxgqWhoG1lhaST0WByPgVJ+vMMAHL2wbgwpGYaboUTUO4jP9gKkYWeZL8hj8LT4rYvSzkIO+6k2oYvuxLZilTtxuSmigovd1KjuNKaQP/iNkGUNGe9YoQp0zPov0bNTe0DaGQgmIx12Coqf3wmeGSh/nbVDc4ClZJSWLP7fnLxGUwBpahHeYsTnsTYUyDMF9R4lsrh71mz1lIZgVlyNb+Z2NWxuAzTNmIUlTJV1Fo8eM+kXAdxYVKgLjEpPF2z6o
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(478600001)(82740400003)(7636003)(356005)(6916009)(4326008)(86362001)(33716001)(54906003)(70586007)(70206006)(316002)(41300700001)(36860700001)(47076005)(55016003)(2906002)(426003)(336012)(8936002)(8676002)(40460700003)(26005)(9686003)(40480700001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 01:22:32.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305874b4-8872-4a0b-9856-08db833fa1d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Jun 21, 2023 at 02:37:14PM +0800, Michael Shavit wrote:
 
> Except for Nested domains, arm_smmu_master will own the STEs that are
> inserted into the arm_smmu_device's STE table.

I think that the master still owns an STE when attached to a
nested domain. Though an IOMMU_DOMAIN_NESTED iommu_domain is
an opaque object to the STE in the guest, the host still has
a real STE for the nested configuration somewhere -- and it's
likely still to be owned by the master that's attached to the
opaque NESTED iommu_domain in the host kernel.

> -static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
> +static int arm_smmu_init_s1_cfg(struct arm_smmu_master *master,
> +                               struct arm_smmu_s1_cfg *cfg)

We here pass in an s1_cfg ptr because we expect someone else
rather than the master could own the s1_cfg?

But the final codeline by the end of this series seems that
only master owns an s1_cfg. So perhaps we could re-organize
the patches to clean this away, as the cfg always comes from
a master?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 68d519f21dbd8..053cc14c23969 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -688,6 +688,7 @@ struct arm_smmu_master {
>         struct arm_smmu_domain          *domain;
>         struct list_head                domain_head;
>         struct arm_smmu_stream          *streams;
> +       struct arm_smmu_s1_cfg          owned_s1_cfg;

I am a bit confused by this naming. If only master would own
an s1_cfg, perhaps we can just make it "s1_cfg" and drop the
s1_cfg pointer in the next patch.

Thanks
Nicolin
