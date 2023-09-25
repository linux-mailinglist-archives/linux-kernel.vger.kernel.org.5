Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA847ADE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjIYR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:57:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A810F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/+kbgn1GpN2AmLIkr0doDuGwqg+KlgmHlPJabra6QM3nbUGBu3L52FLDDO3s69P8CLJPYoWCe+9LT93Un1MgOURU7WO7cTi7herBsvOGezGbb5gpUBlMesHEy8ADHz6dnmO58ttO838s5AiNNG+/lOrp66LzogXMVGWeyjyGcqmzPia3mWfWEozJpJgxv6yIrMVz/0hvDFM6exRFjV2zEcUXKNZRCF0RgHceotbRfcmgSNTVAdnHOf5Y+EbLQXiU+MNeyl9wDgKjD5tC2QbsTg52+U7eLbpcbs4stesYmyZe1ju5UBz3GPdZ498idmXS2I64xK6CEvGR4rCZ31Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE7beFWphLRjC/t8Sg5pHs8YnzmYsQ64BwNZiHFx/u4=;
 b=aAu+RfAFdeAHf4sdoQdq8SyxWIco64nwIwl+X9kGlAhMBeAhsX66tQUegPv/WzWWjcx9DUsFfrE3a0m0o4Q9F/VfdCvWc/j47XftXhFR6XYVMKLj2v5HcfSA93BrN5P9vuNMmXt1GpCDFilEem8oRXaWcnauVfSWPOmazmYJ6RJ28z+AmnNzAc5b+U46BYYufOAGa2SXMJhp5Ghuk1TMizU48moJHKoPBCu3s3be6N3+6hrIBRGmz+aQ+rKiUcKwABWOPxEtUepWCRT0OHsTsRSwiPeOHXHpMup76fRHMoPVdzM0aQcflerwUkTeYLJoQUQDwjXlhaO0hsZM1hiiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE7beFWphLRjC/t8Sg5pHs8YnzmYsQ64BwNZiHFx/u4=;
 b=C1ZJJchFwHZI7JwiOvLq1ZabaMOcdQE5uTqk4vetJki01/h0WJ67RlrWVim5x6hF319uLlri0Ly2LVmUzy32gCZ77GxSXR4smuaEs5R3UgK8X/xp8Bx/I8P2ibXHyAY3q0370jvA7g0e4kB9aA52qR59Lzyqrkbk++Y8cp307bkG1Rb4HoM+kvizNKwc8ckD7FPeNn2egiALsgu66oXqB0y+nt6oXOAICew9o3ZUym4FW54XKBLZbhY8VWNaCcqPNP9BWUe9f32IPET/7d2gSh72tNjZEfIeQCRo6sTdxhXeofUFr2MX7z04a+bETatZwwLVIfg2UbPIGUb8ZHtY9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 17:57:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 17:57:09 +0000
Date:   Mon, 25 Sep 2023 14:57:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, mshavit@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Add boolean bypass_ste and
 skip_cdtab flags
Message-ID: <20230925175708.GA251639@nvidia.com>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <45b65b0a774068be805b7e1b45063fe10ec51d3a.1695242337.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b65b0a774068be805b7e1b45063fe10ec51d3a.1695242337.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL6PEPF0001640D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 815bc93e-387e-40f3-0c4a-08dbbdf0d6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXwvqcjWwSmnLC830AF0H5AIvJw5yUJbTXkegm8+NiLz8SVwVw8+pPKR+31kFXY2C4oNWsYuE0AUrw7bsFp3t1W1UMFLmqSZlpZYyXAl2Lrffv0ez7Y11mQ6haNHvzV/BsZQmdmBAXDCugeiENzH9A4l9ggBRsHQDvQOnmEe+JmjAm+NA9lbRItrmcgVlW0yAXkd+H0ItadEdMBDAEKXOeu5duTEYI5UewDqVqgzx0+dWKB5ujObwtQIBDBNfbB8ZfPtzv+JHZ3EoNZS+FAk7eGA/+WJyNHDgj60m0HAVwTIEX/F+VfDXq8gY0y+75MkT3Dj4u7e7WN8yhHsT2dHmwBQoV/mvIf6CzFTEbPJKLZa/2f9uedaK6i+/X0+AJDaxrTtuaFTIIYHYOzOE+iGoP+Dxm3DI8WGl1V00KCoBT2tTkSixgus/+SezM1QTKyYRL4NPRl947xhctEZOjKzlncXKoX87yq0AdjO/qM0qLIuyymG0QH6jMVotKX8ZXqttr60cv1dhX54VNK0oDVcrJgAVKLdn6JNRoMcTq8QFq12gjPlmaGVIio4RpyIc4Gl0WZRdRtjqY+YpoDTehCOGAk1RN12smtYQMMfoCYvyfgM+bFtBTueyQsw8/elQe91
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(66899024)(6506007)(6512007)(26005)(33656002)(1076003)(66556008)(66476007)(86362001)(66946007)(6486002)(478600001)(38100700002)(83380400001)(2906002)(37006003)(5660300002)(36756003)(8936002)(8676002)(6862004)(2616005)(4326008)(316002)(6636002)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Thg2vCiGYVC1wFbn2YjGZ92L59wkiNaLuLNE+NsJ3yYKQ1UPkFykJbRFcnD?=
 =?us-ascii?Q?VtqBEb73QiBP0gruHbmcIJheWheUpCct9kTIYKP4z9x/exLdn1HBkl1Jo/bT?=
 =?us-ascii?Q?1j/jXHtfFi1T04TjBv2Qc68nCPGgW3apCOQ5BY82jlycicqRX4mfI22IOkZ/?=
 =?us-ascii?Q?Pc0dcjZYp/3VCuJXNyhO6xKc0HSJAmC59Bke5KpTJk/2ZNFIRBkCffdAiZN4?=
 =?us-ascii?Q?8k0PA8P4o6Ts08Ayg5JiUTlr8JMHBtvoegnj6RHdgQwBKIb9nqR+gb05C3B6?=
 =?us-ascii?Q?cIBHOb+gLNEqb8HEXtG+fLn2uUZYhH5Luj51fYmKvAuBkzqXifbx+1hJUQQh?=
 =?us-ascii?Q?4sHUHH7ymHJEynVV08Cq2LMfvPheQn4ruE78ks8RKwoeNZh09y0Vh5XVmOg5?=
 =?us-ascii?Q?X8P3xEksKuHRbZ46sbOvhMxRUXfimobnKDnQE5ZQUVN3f4UNappObVFewake?=
 =?us-ascii?Q?M0izcM1qTw06o0UhlNyyb2KQLZ+jch2QcnoWtL7ToxiJgTu4t/DZ0MXINsFV?=
 =?us-ascii?Q?O4mw6yF/msg690eS0p3XfLgbFS7y0PsLXxbFIU3rWpL0vnUUTsC6SWVTcUTR?=
 =?us-ascii?Q?jWr0rT1bFs1JDz7Fh2AUuSZ8F1xQjr9z9hGCl4LrciNDSh8gEu3IJD8GXvXx?=
 =?us-ascii?Q?MvnWShp8tJmi1oUnH1ozvMUoJJUgly7retMOSCFHtaDKA4qzKdptsnZ0EtyE?=
 =?us-ascii?Q?breYeJj6cKABIgDHPAGUqt/YjZLvNDP7a6cxW8WVwzTQ60ELJyOtz/6BvfA/?=
 =?us-ascii?Q?wbLpSfQvgTAv8DlirynOKsVW9cPsVWkIVF4ldRtZ/F5Qpae6W+VpvTt4kYIi?=
 =?us-ascii?Q?E8z9pIcPQfBdn84MsHgw0DhtcRnlljfNTfLvWh/w0fXhZlqcOWmTxndLs2pA?=
 =?us-ascii?Q?+OUgxAwIWndM7baDC8ndMYhwoceWy+5grQVSnwoGX6lroftyzM9tNe/e2DdI?=
 =?us-ascii?Q?nD7IuBkoT49IbECZjrcs8R6QjOxsh8T+EZ/Hyr/OQeO5gD3k6kD5S7DFV0Hw?=
 =?us-ascii?Q?CF3kiqfbum1DxhZCmvkNOoUGBjFEEUhfd2YiML0ieGn2FbwyEnl4UY8ljidM?=
 =?us-ascii?Q?lgOH4bU1ai+boNO/ed5McR0tOfeDMgxx7/pZxZWpYYSi4/YWr4kaok6Ly7wy?=
 =?us-ascii?Q?BQ+PALaw7w3pzFJjCN/fGejp/awWCS20gRCtOkQqGcHsMTE/y+AYDC7+xZvf?=
 =?us-ascii?Q?YesJhD4/fD7JPzYH3LJ+N19ldyHsRPx22aA0FFDcCb4p9gFq+4c3/zqSV0fA?=
 =?us-ascii?Q?rjKMYn8j/TVnuMtpNWBEyCUkrPSmoEwpsVQZzpkh6SJXj3UIgFwhV+AhGEFE?=
 =?us-ascii?Q?eRM16afbS/6omemkeabgU1Rx4eLtTonECcUHLCRoBrUr9kdmkLXDzSeiGDmh?=
 =?us-ascii?Q?PRkYFizPWzyAq7R7QqyOlBm+DXYSvbZqfGucljPyU3Wq6sJnZGLYOOpidKu0?=
 =?us-ascii?Q?V5awpTebKSjPpThVn/DOmyVGxk9OWovGTScIcsHBGwKVHDQ8Qtl7PA/8vsF4?=
 =?us-ascii?Q?zDzlLm0/WBOfD18LMx6weIGEEOzCUieGFZO3GuLUMYjmPk0DOF/DW2W0V+i0?=
 =?us-ascii?Q?SELhlb+J23nZ88xi1dZxfQliFf18pOfyDOmv6dk8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815bc93e-387e-40f3-0c4a-08dbbdf0d6cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:57:09.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgOF/TcygReyyBA3e1Y1LM6xtBkQhiEXtiNpHEp6r3k9GvM2bpZz27OW2afyzRn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:52:03PM -0700, Nicolin Chen wrote:
> If a master has only a default substream, it can skip CD/translation table
> allocations when being attached to an IDENTITY domain, by simply setting
> STE to the "bypass" mode (STE.Config[2:0] == 0b100).
> 
> If a master has multiple substreams, it will still need a CD table for the
> non-default substreams when being attached to an IDENTITY domain, in which
> case the STE.Config is set to the "stage-1 translate" mode while STE.S1DSS
> field instead is set to the "bypass" mode (STE.S1DSS[1:0] == 0b01).
> 
> If a master is attached to a stage-2 domain, it does not need a CD table,
> while the STE.Config is set to the "stage-2 translate" mode.
> 
> Add boolean bypass_ste and skip_cdtab flags in arm_smmu_attach_dev(), to
> handle clearly the cases above, which also corrects the conditions at the
> ats_enabled setting and arm_smmu_alloc_cd_tables() callback to cover the
> second use case.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++++++++-----
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index df6409017127..dbe11997b4b9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2381,6 +2381,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_master *master;
> +	bool byapss_ste, skip_cdtab;
>  
>  	if (!fwspec)
>  		return -ENOENT;
> @@ -2416,6 +2417,24 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	master->domain = smmu_domain;
>  
> +	/*
> +	 * When master attaches ARM_SMMU_DOMAIN_BYPASS to its single substream,
> +	 * set STE.Config to "bypass" and skip a CD table allocation. Otherwise,
> +	 * set STE.Config to "stage-1 translate" and allocate a CD table for its
> +	 * multiple stage-1 substream support, unless with a stage-2 domain in
> +	 * which case set STE.config to "stage-2 translate" and skip a CD table.
> +	 */

It might be clearer like this:

static bool arm_smmu_domain_needs_cdtab(struct arm_smmu_domain *smmu_domain,
					struct arm_smmu_master *master)
{
	switch (smmu_domain->stage) {
	/*
         * The SMMU can support IOMMU_DOMAIN_IDENTITY either by programming
         * STE.Config to 0b100 (bypass) or by configuring STE.Config to 0b101
         * (S1 translate) and setting STE.S1DSS[1:0] to 0b01 "bypass". The
         * latter requires allocating a CD table.
	 *
	 * The 0b100 config has the drawback that ATS and PASID cannot be used,
         * however it could be higher performance. Select the "S1 translation"
         * option if we might need those features.
	 */
	case ARM_SMMU_DOMAIN_BYPASS:
		return master->ssid_bits || arm_smmu_ats_supported(master);
	case ARM_SMMU_DOMAIN_S1:
	case ARM_SMMU_DOMAIN_NESTED:
		return true;
	case ARM_SMMU_DOMAIN_S2:
		return false;
	}
	return false;
}

Then the below is

       if (needs_cdtab || smm_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
		master->ats_enabled = arm_smmu_ats_supported(master);

And the CD table should be sync'd to the result of arm_smmu_domain_needs_cdtab()..

It looks like there is still some kind of logic missing as we need to
know if there are any PASIDs using the cd table here:

if (!master->cd_table_empty && !needs_cdtab)
   return -EBUSY;

if (needs_ctab && !master->cd_table.cdtab)
     ret = arm_smmu_alloc_cd_tables(master);

if (!needs_ctab && master->cd_table.cdtab)
    arm_smmu_dealloc_cd_tables(master);

And add master->cd_table_emty to the arm_smmu_domain_needs_cdtab bypass logic.

Also, are these patches are out of order, this should come last since
the arm_smmu_write_strtab_ent hasn't learned yet how to do
STRTAB_STE_1_S1DSS_BYPASS?

Jason
