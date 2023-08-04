Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B345F770BED
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHDW0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHDWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:25:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1C1704
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/0EF6ILZzv/ECeUUIIiIdGXraZ/bKDuIqbZx7sHIyw6YDnjpya3J7EwKV/z7METTqk+Jnqwc0Hf5kFi+DekSlz8bxWjJQLQdutyy9MC13KDLJJYqg9dUcruXMdjRJDWbmW9nHkn87nAYTPEhrJpLuqIOjLhOw39IxrUYiUmMOuH+nJIrGDCnn8vkbb/F9z8QU0wUjoWDGNlQjgq1IeTm8eki2dNl7fE8HT3HuEFmPId6rgfAIR349M/F494Belijayjo9KH6uABBjRvAhUGvUI97V0AL6O3v50Xv/yHL+Iqyl1sDTIwDq2FVajw92I+HZEDcJMqpjNh49TEpCL81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ6K9MdcMIBpulwiaMpvW4l/DU2e0+wmvhisO/GpWOE=;
 b=WhyJiIAN1NaRSndWi6yO25Ln0TT5kpCAJwI9Gh25oS0GApO+2Z5uK1bIagotVtOmqcZsub6lT2eclskKE17GB60/hHUWViHfe4+E72toqnM2EEjGXGRby6bYi/CTjD4NH0UP1eYVoX09eRZ3MtLJFzXWxFCiu1Mmh4mLHpbtu5b7wkBfz51R9EGiDJb+Oo4OohTHnNNvrA3XNNsSvnA1xaNsMRT+iNd0JTVTYE563ZTJhAlryMQPHbs6Wq0Ak862AA4wupmKNEE8eLrHSSiJQAP3yR3YffbBb6zN146BVoDfrFvMgWAUHf4QvrYdIxSrA3GkgRQ190DtIYK0MUgcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ6K9MdcMIBpulwiaMpvW4l/DU2e0+wmvhisO/GpWOE=;
 b=VwZLd8UI6Ydk/ZRdPwfPeeX43GchjMCrrYG7v1uoDA5an8dw7pLM1ABFTJJkIoBNWAdolD+bc/4qUHp71FzOpRfr9KjMK5Y9COMpM+1Vuhh25pkupuysUPeRFJmYXjHNM98kM03W0BAm5598OVVKPenPuUdGIUZ5y5VNeVkI+Rw/dYPITxYBPhFeJTbvqxl3WCKy1Ez3k+TQdbABYSUvKSwy67d+2rQumvb79rhoS8byVYCXRr6zKgUj4QaZ02cKl3tdbDNYQRDDhg2A04w6gOnYweGkGMuzfdv0I9WNIx5j9a2Uv1Y9epdDq079Nj7lhnR02FnrNZerlolvc1WNtw==
Received: from SJ0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:33b::7)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 22:25:56 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::84) by SJ0PR05CA0002.outlook.office365.com
 (2603:10b6:a03:33b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.10 via Frontend
 Transport; Fri, 4 Aug 2023 22:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Fri, 4 Aug 2023 22:25:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 15:25:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 15:25:45 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 15:25:44 -0700
Date:   Fri, 4 Aug 2023 15:25:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZM165+0WUNsIZ3Sn@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 932f9b72-f6bc-41da-dd1f-08db9539c529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTQYSkw+6Ap2ArB9lncEQTLpqrw3qNMh6C/Zut5rTCMZo5bn/DGQHBpgHhucDVygWAv57UxrPRJAfAglb43NGEe2MTjOw+OBuc57F2RrW42ckyVHUKa6h/xKRiQd7ZUJAbF0+AmdwoDy43bztT3RsZzlCrq7uLGLPDAm3/WgiNhjwsY3XByRxY/0xKmoxvOeSJzdi7zlAXoCMrOwm472LxUbSDk9VWuWVYiTUXn5Zr8nZGGROtIIdy1CG1RTPgpqnnYFxQbmehMB5fMaXl3OXC52tFaYqDWcLEyZZt54S3Rlyn7NK6Jb3m3wD34iB1pVMTlJqMUzjzsdGjlsRqDKa+FPKz5+uedHmTydrrtNecyVcpDY6rXlg1TGDOGzTa0S6yGpeczNKl0CYIIQEi1bC2odEPxhZ1LgU7GRoOtHPHrqyh6U06AS98Tc5/1Ii9DyukpvepPBIQRbZMZinAFtVIqO5V7zHmSIiaTdQf/jqx0tqQ+lkYJcKhPQwVI4BJ9i2NzPzNfZQsMltvUAYfxGsL21yVrtVSNlce/VOlRE5bsnd/4dmGZ5jCkySegAohJWLIaFFD4dzZu5qhQ4KwxfGbKmIkmG5u8nDKMYGKj/6jfLohcaT/5RKPhW/hPdFWlAvNJzVn2f9qG89ucwOjCANrzQQdijNU9QiUIbm2H1OhnpmLcRh0XeKXm6L1TdON9WqBxeGUzXyDoxZXv572x+sPNuiZqgZH5UbukxzbEN9hOBs7GUP59MxGtCdPbjE3hU5g3RlC7Ja1hrDMXFN0Rg4ofM/q2YVsOHvgxg2/vJQjT8v9+oBC+Pl5R7WX9XqXc5
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(82310400008)(1800799003)(186006)(36840700001)(46966006)(40470700004)(82740400003)(33716001)(86362001)(40460700003)(40480700001)(55016003)(54906003)(478600001)(7636003)(356005)(47076005)(83380400001)(426003)(336012)(26005)(9686003)(41300700001)(8936002)(6916009)(4326008)(5660300002)(36860700001)(70586007)(2906002)(316002)(8676002)(70206006)(67856001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 22:25:55.5649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932f9b72-f6bc-41da-dd1f-08db9539c529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:34AM +0800, Michael Shavit wrote:
> +static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
>  {
>         int ret;
>         size_t l1size;
>         size_t max_contexts;
>         struct arm_smmu_device *smmu = master->smmu;
> -       struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
> +       struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
> 
>         cdcfg->stall_enabled = master->stall_enabled;

We have stall_enabled at both master->cd_table->stall_enabled
and master->stall_enabled, and we removed stall_enabled from
the CD structure...

> @@ -2436,22 +2419,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>         if (!smmu_domain->smmu) {
>                 smmu_domain->smmu = smmu;
>                 ret = arm_smmu_domain_finalise(domain, master);
> -               if (ret) {
> +               if (ret)
>                         smmu_domain->smmu = NULL;
> -                       goto out_unlock;
> -               }
> -       } else if (smmu_domain->smmu != smmu) {
> +       } else if (smmu_domain->smmu != smmu)
>                 ret = -EINVAL;
> -               goto out_unlock;
> -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> -                  master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
> -               ret = -EINVAL;
> -               goto out_unlock;
> -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> -                  smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
> -               ret = -EINVAL;
> -               goto out_unlock;
> -       }

... then we remove this stall_enabled sanity also.

This means a shared domain (holding a shared CD) being inserted
to two CD tables from two masters would have two different CDTE
configurations at the stall bit.

If this is fine (I can't think of something wrong but not sure),
it would be okay here, though I feel we could mention this some-
where (maybe commit logs) since it changes the attach behavior?

Thanks
Nicolin
