Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC99765DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjG0U5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjG0U5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:57:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD20273E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1uSGpBsjvLdFN6PKvmOjtqPsJXpXDmqWZTBsdM0Ex3XZqIFIW4MCY3r1gfmLMCy1eVShRAlt4Xpl4DvO0Gg01BH3EQQY4kP8HdSeI7obgoYeUFspvyS3j7IdpfEOM8NhbS16ORqRSI+Q5c1P4Nrih1kdph/NSwzI2UHD4Xb7J/sgeIkMl6DVZt/oI0A6w4S64Si/MNZhC6DJlTAhvXy296W9mltUrtKE2ZWMbbB8kaW1Osbj/T2CLCiALQRBWnNtWe2y/lnrd5LdO2LZqN5Rs++JhmQuBNOwcUrrx4GXtA1w74MjXly1+bbXPUoD6K5/nZ1iCco1K49eyCKeChjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5VyKL0m+t2msTl+MBV2YxDcqbGQzDF1w7xDwCU4sUo=;
 b=ROlqMmWHcE8hPi48cKDxYZ7W0lJidPBrxBX/lERrmqp3cTLCSdpzzYS/zuBTSYZeeoEA5siadPyyKAgag70v6e8kPJwcZD+g6wsT9hmuIF72Gc0Ju+k2PnNsXoDazLCcRx+ruZu86Ld3rTxmZ2XPqeNNy2XhPnjXyxjHWuLOLhxlTeW5alJEYivqzL0rF3l5Ctr4wYNPRxXLmoP4TsKOzK1YUKd2igQHddOJ3LFlhq11t2+YSc+Vxqp3vIAO1d5whrLCNNIzAe80MPHNN4PT5CFqPSpSEo6SVJVcd+AJDMzdxqkQIcTMjzV/mBJzpWf8BADIlrAhaelzif5LTER+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5VyKL0m+t2msTl+MBV2YxDcqbGQzDF1w7xDwCU4sUo=;
 b=JGtqvM1siG4tFUfIDaQXylN5XRpBNTI3j7GZ4dXnir1+Jhe/C6fj8aQfdivVl1AWygc4trRKruGfpGf9OdsJzYfl20D/zc1QoMCEuOcI9wEZJHThWO39bu4BM8YNDtZy5dX4vw7n6LPDPkCPkvMDFShlkE21wiLqxYWpdswsCKuq3uJFh/J82yIKzfuItekfEgTrtByJpcPRcsepp0WX6fX3JwblQPCz7N37uK4g8pjVWbL9GyS64Hs0qotX3w+Di5kjR2sXkC5CNTDVQO0kQd4P8w/JXQgKcsCsq9RqUAWDUE99S04VGAbrYIb3paYmtcY5h1afwHw2hd6d8eTamw==
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:57:41 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::c4) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Thu, 27 Jul 2023 20:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:57:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:57:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 13:57:25 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:57:24 -0700
Date:   Thu, 27 Jul 2023 13:57:23 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with
 ctx_desc_cfg
Message-ID: <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-3-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-3-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: e112b377-cd3f-4f7a-cbcc-08db8ee41e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAX+7MYRtWRJp3TkqzPjK+R7yb6SLr270kNO38bP58ut3Rq0uyFdSu+KtDzLfbixzKS0bEKHRa+yfioKEo6Z/0ALqU4jS/tJWSBmsCXPpORhHZlXo2Ep3RUm2+sGu2KxosymXytQe1tw0A5sfUFB98CzPX2mrFicZSxqQ/tFJx+AFZrMEe8N8y1n2L1ZF7wUNoZf6uyVrpqRoh+KyoWhAVDhuAwjFlLYpCDNqlkkITmNfklVoMqm9bMXBnLY9PmqdOU47o9lnvAhtFOoV+hPFYsyOMhpN2bTKJR0k/L2+89QYm9W9V3z+P/pZkQH1W2ECaTYwtR2PwRT+EUcDn48LyuH+H+3QvN0l3jqxKUlCyJfbYAI/f1wldizTTIFn6IhwspGEOrctk4D1EY1usRqF8zDh+AFz8rT5Xq/cTTqh6qouh79InUMDBNwtufphU7ZrMJzEcsfc0t5vFAtQwAsHh9zFJ7Pl5bwQlw9S/zfo4MJ7x6y7zCn6dLfqBIH4Zi+aq3tRM0oKsXVDvwSOwNkjnwgaVvZJ0CRL8CrStDmBaCRCrViGjHAANZ32Ge8ZF+shSjULtkk9j+MfPgJRtI3M8hu4vBnJ1LOFuYLbMm8RV53t17cxsK6inxEqScki0talgkkx/EK/HstKRDFQaG1TKDGSpgLlp/NdyGkUYr6QoKjt0GhUvEm6eC9BjsZddD+9AhmLL8YFGCXaERbV00UsNlJVERdzrqFVbwduq5yhMIDX5tKgbepl7EiYR8SO+GD7spq3cigh0/VXEosrCOD/MuZLAoZJXIrZktu7GlzFa4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(47076005)(9686003)(478600001)(54906003)(336012)(26005)(70586007)(426003)(2906002)(33716001)(70206006)(6916009)(316002)(8936002)(7636003)(8676002)(5660300002)(41300700001)(82740400003)(4326008)(86362001)(356005)(55016003)(83380400001)(40480700001)(36860700001)(40460700003)(186003)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:57:40.9912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e112b377-cd3f-4f7a-cbcc-08db8ee41e10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:26:18AM +0800, Michael Shavit wrote:

> Remove or move s1_cfg fields that are redundant with those found in
> arm_smmu_ctx_desc_cfg. The arm_smmu_ctx_desc_cfg member is named
> cd_table to make it more obvious that it represents a cd table.

Though the "cd_table" is clear, it doesn't feel very obvious to me
that "struct arm_smmu_ctx_desc_cfg" means CD table, so a mismatch
with "cd_table". How about renaming to "struct arm_smmu_cdtab_cfg",
similar to "struct arm_smmu_strtab_cfg"?

> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++---
>  2 files changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bb277ff86f65f..8cf4987dd9ec7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1033,9 +1033,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
>         unsigned int idx;
>         struct arm_smmu_l1_ctx_desc *l1_desc;
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
> -       struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
> +       struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;

[<<<]

> @@ -1276,7 +1273,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>         u64 val = le64_to_cpu(dst[0]);
>         bool ste_live = false;
>         struct arm_smmu_device *smmu = NULL;
> -       struct arm_smmu_s1_cfg *s1_cfg = NULL;
> +       struct arm_smmu_ctx_desc_cfg *cd_table = NULL;

[>>>]

It'd be nicer to align all the variables to "cd_table" like the
2nd piece here. And if we rename the struct name too:

	struct arm_smmu_cdtab_cfg *cd_table = xxxx;

> -struct arm_smmu_s1_cfg {
> -       struct arm_smmu_ctx_desc_cfg    cdcfg;
> -       u8                              s1fmt;
> -       u8                              s1cdmax;
> +       /* log2 of the maximum number of CDs supported by this table */
> +       u8                              max_cds_bits;

Though "s1fmt" is redundant, "max_cds_bits" doesn't seem to be.

It'd be nicer to separate them in the commit message to why we
remove s1fmt and why we rename s1cdmax.

Thanks
Nicolin
