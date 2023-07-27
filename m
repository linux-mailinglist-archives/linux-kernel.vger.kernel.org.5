Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF53765E50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjG0ViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0ViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:38:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705A211C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYNczqEBqy3fqUzczq0h3lDuqKskiizBV1bwQMCZMSUFSjcXfxeclKKFV7HlThCyS7zs+NTk9IXDrxs2+auDTOYh/w9SYHd+fO8vgqp9wbdqDplknuxo9+SoYQTey/n+jx7VHZ+6G7N9f295V3dDFpf3HA1a9tvqBQHwhS30xsYLd7RAhXC90eRXEA3Wj0/a17dEXSP7Ln+/ga+1M+8A4upjfM3xKWg0lZMuPFmLLfb7fTGqdhocFMUdVxNcLEKuYFmm/F8aiNn2EX+qoRf1xvg+q7glLRyS1QlfBUyBnM7pPYy+YDlrEssCvIjOrEmUM9hkl7Gi9N6YDqfY/nLwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZRJYRfSVCc4YMTDpDe4bt1zlIHu/66UzjINZokc3zU=;
 b=S24P/XIuKyWZ8XnalxLx4GgPA9RSqZTduQxFaUMEOWK0oFDjBl6WFPxLoM0nqpiAD45q5uPFHc6x/kzMDCQbdvVssGbQTCtEnrlLcXD0j2xJ22V2M/1rrfirpCXLvQJt+sPq59RTq3swHOTqi/YUEAJw6/ouU1hBSjbq7pr9BsaY2CUpEuMRkwo6XP0u8w7Zg/ew+P8daaR5TkVNreqKOmvu7Ldv7yggiis8L7UxLDxzlQWFxUSj0QJed9mMvb1d5njZ+mY2d0a9HrwzTd/7GhUtNsh28Ur3Ypl4zY8zML0Tuslarzx+XxuV6LVpwhw/ipuq4zZRp+xAXbmcxS+1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZRJYRfSVCc4YMTDpDe4bt1zlIHu/66UzjINZokc3zU=;
 b=Hxn0N5LCWaZgGdfJRl7Z8hwgt0q2BOrhevS5npE/oAP0uVfJSEvwL3hcBFWhhCQYj09j/RN0qxhZisa4OK4hExxpDJ31rieA9dIUlMd/paNDR+ByxnDlPdZkf8v3TJpGERS4y7uzXY+nWwzlZ9JXpgDK+lIO0gXwBHyZqH4lAb526LtvlTLyei4MmH0fgm1H3QbxJ18FKI88RyG0lXLLvFA8iMy6UgN1/dEr86AGajGZi4Qj+RqnMkFJaceiGCM6jdsZir0A0IgmAh5Ov2baNOqCWxxK6QtPDE3UoZYKiRFr8w3Wl5rNWBt0YfaNdbTl8qU9CtD64P88KPy2EoxGrg==
Received: from BN0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:408:ea::33)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Thu, 27 Jul
 2023 21:38:04 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::7c) by BN0PR04CA0088.outlook.office365.com
 (2603:10b6:408:ea::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 21:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:38:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:37:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:37:47 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:37:46 -0700
Date:   Thu, 27 Jul 2023 14:37:45 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZMLjqfp6M6n7HAxl@Asurada-Nvidia>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-7-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-7-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: c0033c83-0030-4e15-a47f-08db8ee9c287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oXs4AQGqeIg5CbxqaHSbmVZcKt8ugbk/Zeh6gqyT1yGY4oiBdsmLH9G0ce4LxKYT6sKCa4c4mrGbmzbgWiaMUg9Gb4+hC9dwEjnuR4CPwHp+J/wxuI6ID5dewbeZcLocTFuct2xEAOpjsTRG7kBCFoOe0xWEOuoSS6YNq18MCFqw7543f3n81yF9bd9jf3pcMvavZDl6mpgmn+o2BDHVleY6OVibVSlWq5QuO3aR/pa/kzrAHyc1PzAWaC2rPqAwF8NR3kIRMVz7XFiKI3CC021+4zm2M0+C7rgAbtLMDNcKl8C3w3+8vJ1Np3rbm+tNVFkG/xBb9vqDx+RB4cR/hF20Eg6/foZF5MbZ2HKVWC5uklGXHIb8PGY7Wr793zwM73rko9QP6e7+J67E6VE58vQrHB9BlYlsVaSjQYsfXbkcR5O4ZQnKeT2ZIrRkdSDtjFTnjAqCoZ5v1/ucioMOmPqEIESeNqdOexzFkalNHD3SkRS+mcLuxDvGiRTzviYOMqyo7TmuweSazPmw55gO/mWGhRd87+1UPRdThlY2xwaONNhYS57LyFoQhGhbo8JWOxPw4mGETV6XTo8RTEupdC1BaiHIcseipCFWsuZRgf/76QIQBg/cc2uNhEC+xbvxPzreW42p/dxZaD9SuNPqk0Eq5Je5Mh3QcU2arTpW9lgWRCCTjVYPIbg4Xd0U7hSIK8E+2QeTY3Vo2O2EjOhvQ3ZmOQrqmdk/NxJHIx8bBq7g8rKtc4eSKWyPO5ryJl7wphWCt1OR6hnp40/SiGlDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(33716001)(8676002)(316002)(8936002)(41300700001)(47076005)(2906002)(70206006)(70586007)(40460700003)(55016003)(36860700001)(40480700001)(4326008)(426003)(83380400001)(54906003)(9686003)(86362001)(6916009)(26005)(478600001)(356005)(186003)(82740400003)(336012)(7636003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:38:04.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0033c83-0030-4e15-a47f-08db8ee9c287
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:26:22AM +0800, Michael Shavit wrote:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 968559d625c40..57073d278cd7e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -45,10 +45,12 @@ static struct arm_smmu_ctx_desc *
>  arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  {
>         int ret;
> +       unsigned long flags;
>         u32 new_asid;
>         struct arm_smmu_ctx_desc *cd;
>         struct arm_smmu_device *smmu;
>         struct arm_smmu_domain *smmu_domain;
> +       struct arm_smmu_master *master;

It seems that the coding style at these struct lines is listing
from shorter to longer, like a Christmas tree? If so, we should
place "master" before "smmu_domain".

> @@ -80,7 +82,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>          * be some overlap between use of both ASIDs, until we invalidate the
>          * TLB.
>          */
> -       arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +       list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +               arm_smmu_write_ctx_desc(master, 0, cd);
> +       }

+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_write_ctx_desc(master, 0, cd);

> @@ -248,8 +260,10 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>                           struct mm_struct *mm)
>  {
>         int ret;
> +       unsigned long flags;
>         struct arm_smmu_ctx_desc *cd;
>         struct arm_smmu_mmu_notifier *smmu_mn;
> +       struct arm_smmu_master *master;

For the coding style topic, similarly, "master" before "smmu_mn".

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index af7949b62327b..b211424a85fb2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -971,14 +971,12 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  }
> 
> -static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
> +static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>                              int ssid, bool leaf)
>  {
>         size_t i;
> -       unsigned long flags;
> -       struct arm_smmu_master *master;
>         struct arm_smmu_cmdq_batch cmds;
> -       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct arm_smmu_device *smmu;

	struct arm_smmu_device *smmu = master->smmu;

Then ...

> @@ -987,19 +985,15 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
>                 },
>         };
> 
> -       if (!smmu_domain->cd_table.installed)
> +       if (!master->domain->cd_table.installed)
>                 return;
> 
> +       smmu = master->smmu;

... no need of this line.

> @@ -1029,14 +1023,12 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
>         WRITE_ONCE(*dst, cpu_to_le64(val));
>  }
> 
> -static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
> -                                  u32 ssid)
> +static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
>  {
>         __le64 *l1ptr;
>         unsigned int idx;
>         struct arm_smmu_l1_ctx_desc *l1_desc;
> -       struct arm_smmu_device *smmu = smmu_domain->smmu;

	struct arm_smmu_device *smmu = master->smmu;

Then ...

> @@ -1044,19 +1036,19 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
>         idx = ssid >> CTXDESC_SPLIT;
>         l1_desc = &cdcfg->l1_desc[idx];
>         if (!l1_desc->l2ptr) {
> -               if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
> +               if (arm_smmu_alloc_cd_leaf_table(master->smmu, l1_desc))

... no need to change this.

> @@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>                 cdptr[3] = cpu_to_le64(cd->mair);
> 
>                 /*
> -                * STE is live, and the SMMU might read dwords of this CD in any
> -                * order. Ensure that it observes valid values before reading
> -                * V=1.
> +                * STE may be live, and the SMMU might read dwords of this CD
> +                * in any order. Ensure that it observes valid values before
> +                * reading V=1.

This seems to be true only after the following patch? If so, we
should move this part over there too.

Thanks
Nicolin
