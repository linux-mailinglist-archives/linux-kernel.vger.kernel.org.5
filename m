Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD376B61E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHANoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjHANn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:43:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3607ED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqYR4OhDu6FLLGBA1Pl6awSyqTIXiSRCblDZ/LXi2ftpxwXHxCGPNIhoSfZVW3Usiy13gE/8ZmKCc0w9XtV6aJizh5BrcUxMc3Vw3PE2Yka5DE2zAJ0RN77OY3ym1OwlSOsLL3KJJ6HwmpALtyMDtHQh3YA6JjjqXpduikpZ4HnqiiLxFpVwcLKr9RnURFfOwDOmgwv3Cszg4sC03fyR4xXRPb7OD43XfNI4hrVWnIIOQ1/ZKzlyR88TlxGVJt6IeatJvHHWNfoYaAxcjBFRrNFlJe5AloxBLRTLVBQx+agbjoka2/kXiOCIPHJvPhaZAqK7QrbrsngCzvZEa1NN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeLrJsBRx809wSzthRVJaS0su+INSmoMyqI1Y8P9RqM=;
 b=TD0MvNuM6idR6C/jFXovcJL4lMosrONBAO9Jic0alyXhWKd8Az8R6sL6Y+2MndkryNChUe+jIrYEJfwLPTWrDY1hQPOA/9YIatbd7phtwIOjB44UZZAvmecg7BM4lj3JZeVDnLCRAWd8+PoH/ETaWecgs0yn/PXnPzN7ujeWJvFe+mB3ZyrlhCwccLHvGG1tr1mvE1apA/bnkzungSu7wapfPwF0O2rtucThKqga85Zb5yrYYZwB8jOO7rQyzFC5Xdfd3hK6G3DxbekL9OLNV7gFGfgBqkEeMaRXmyGSYTgB+f7CXF83KwbmiMbPwEBrKGt/djdnQJNIshcmdSifoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeLrJsBRx809wSzthRVJaS0su+INSmoMyqI1Y8P9RqM=;
 b=mpxaD/pEzT59JH90UyuQoAaqW1QuouhrlRYzACOW/qQiamFYHfZUSUQXeNNKhEH5bfb3z6wj2+ckboSgu1Bk9mEd1BozxFAqboMWf4c1fPREd/Ljal5bw1loPKLIpKrjdUtcWYycIxzm8yJ7HxRLi/CtTb127vP9hlk7xGe2NHP1FAA3YA+XwFuSUE/WI4uW4GEZanspWdGCR/BAjxLfXLktpAFoWAr7j49VuLueuaTclWZR+sUsk1jYqQ+8kt7B6/bhHjD6mLZDIKeasAjFKyIwvns08VMs9sfICOS61o/IhBSyxB3EN1NXG9g3ws7oCTroZBOmZwBE4dVncNEDtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:43:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:43:54 +0000
Date:   Tue, 1 Aug 2023 10:43:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZMkMF4e7w1GTln7s@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
X-ClientProxiedBy: YTBP288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbe4752-355e-4c75-f277-08db929558ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ai8iA6umqi0vx6K58NfROcKTqPbN3lpe+YIrzcZb7nwrf2k3CZKmdxJPBfsta+ZAc1Q2+2R+WSDl6bS2Je+zhs9mqdsYaQQk9aSERbgmkcIUK7sXaKms58W5bmi/kQ7tta0Sfd/AEo6iMedEs0vv3KxIQzfZ3gwRmGrd6DabYVMGFlthEQ5kspFQY7FkM0LK5euaPY5V9nWj11iYA/6b0Li9LRVucJDQgUwI48aaGBfv4+AfH48jifjyk4N9EFnpPRjVJcv2zEsPk2SX+Q4XKkpIJ8gJfFb/eP9cE1/euZOh5O+LasLRqBPOYsa3q2W4TzaZDAL+OJa4/xVsZKQKOSnumNKe1MQWt4YJU8Jq4Kd9t1832rklpbck7b+kACOcy/d2zPKqyTCnZvLTiPF0z/sWgWRCOcZgpudMirLLF0br/+1hasGyMwUanJgc9+QFNt08umUnl1McaDPK8qyFFWwf1dyUix+HXriKUJtCVtRJn8wEr6600D7fo5NAY1fM3vZDCB9vg8mn+b8mYM5Q4j0TEMdvJTsZ6VcTcTFz50LfHIFX0ChDJWDSBpXHsckG2BoWYxoeAiAJbc54adAQULM4+yCbqr9AmA4h3elgkakI7iCKdhZmlyDlLkRKkfvfutt2VtueUSm5FSeyVvy5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(86362001)(2906002)(38100700002)(2616005)(478600001)(66556008)(66476007)(66946007)(36756003)(6486002)(6512007)(6666004)(26005)(5660300002)(186003)(6506007)(8676002)(8936002)(41300700001)(4326008)(83380400001)(316002)(6916009)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDqECfhHHcQLe8zY93pH9uCY+95THbW9e/Udxs1D2Jm5DPJZ0nJFAitPiKAp?=
 =?us-ascii?Q?Vm5mbX1HzPfvKQODo66ij5R9iK5xo5MEyuA4P/5YgJgR+GOUn5WCQltxT0tl?=
 =?us-ascii?Q?F4tt6iP5eoJF4wwWjjWPjmzbUgJGtf74D/jAW2T/pob9JkWsNa/RMr7g9UJt?=
 =?us-ascii?Q?74+UjDcXVYjKHj0Xj5EWAugTZUI5NyqgHkD67D/3LzCkgi7s6xLTWafQoCgI?=
 =?us-ascii?Q?NuSMbp/vEESsB6auz/+dxE+GtyolTwaq0rltb2mXQi+pryVMWKSWyr8N6oI9?=
 =?us-ascii?Q?pTHzoEoy1EYt3uPC/aD2J5u5Om9jDwB4sYcJNIsf046Km0MlVCO4GF5JwdZZ?=
 =?us-ascii?Q?Mxny0NAB5fR633jS02F41qxK9Pziyp8Zd97f8AgQstTcqoaHQ55FzTXJmy1A?=
 =?us-ascii?Q?ikvRZ7avRxknnAoUM4t1vhKxkhinH1sEYCQnlaeyND/E4BkbCIhZbBS3p057?=
 =?us-ascii?Q?N2EoCSrtAGiBmf+dltbi/tqh8JAWnfKMxp3eKzu35a0faAzIDRe60uMODjL2?=
 =?us-ascii?Q?ZYLrzjeAH1FrWjBou0Zn8JyZu9zrG6yxcIwio1UlzoclE2bdzAKB1bQfzgnW?=
 =?us-ascii?Q?1b39BOXGsO48D0venl8nP5/zSzAtd3uxMZPTeBcDwspTxHu+au7j2lNkGnBg?=
 =?us-ascii?Q?muU+G60jWhQs0ofBE1vYgcTRHEiMVkhTr/BUL4d8vMyUZ653mXaCEtA0bzRa?=
 =?us-ascii?Q?PTNfeeJ+U1MDZtmi4CZro2ZphCg9XsfzupLp/1d5OlsYxx63lw7XZBT0ns94?=
 =?us-ascii?Q?y0UfrktH8goSG8vzw7l4sEs2lOgVYkeLlYG6VwQCRCN7I684xR0LVTWI27ac?=
 =?us-ascii?Q?DmdSsJ2fdXrqdcFdvZmFUCsUlaHeGgRPRhry6GvM5nM7g5pLtdgi2rwH+FpK?=
 =?us-ascii?Q?5MOiBYLOrxSq2cmF2wIygFdXMZOvjt8jK75XslFFntCYZDuDcm1pH11xY9UA?=
 =?us-ascii?Q?UGgwyokm9Y1glsI4cxM6iMG/cDHFl0JVbTGV+Qp1qkFu7j8TzqZz2LtSvPbX?=
 =?us-ascii?Q?LiDissGbZAUT6aQkHEs93LZUjABT/4NsR+CSG22hPTyqNWEkB4G0X6aaGe6I?=
 =?us-ascii?Q?ytqZojtsBgHeGV22880yWyQKOUTI4CsUJtkRt9hiWjA0qLdqyAS+/oMWklqv?=
 =?us-ascii?Q?HcJu5+3OLB3TgRuvD2Qxqp5CqrXsJVWqHcqLbrANoJOjwO7KQ7nRgcYyqsQN?=
 =?us-ascii?Q?EZ3dJwUJFsvKi0rGZ8M6zaopHZfrOidmF4X5zCna8cc6uDY2Ht+mYyspSx+w?=
 =?us-ascii?Q?tjqCqHCTTtLgJBfpTNsHvgR1cXHCcagvvBMosWTLJfarEdbZRPeo+ceaZaPd?=
 =?us-ascii?Q?wgu+iMHNIdrSsETgvSQ0lqTRkBFgbfbEE8Ou07/edJ31+KTUM0gh95pJ+dMf?=
 =?us-ascii?Q?M93IhSMRpTlQDayHJ+8F4YZVYKhPBXVAUx/mIoRIrwPzLCCAdMEOqTjRO9Hj?=
 =?us-ascii?Q?MJC7dRRak6Xz0DTtX/mw2OjhlMvbJYCqxdw+uxw8qWbgy8W6v2lUhIj8dtGv?=
 =?us-ascii?Q?S3XKBmTuAQFchIqwV6ceKledtVONnE5GqaF3Gl7qHF7ZA/QgeVK9/6/jUQpr?=
 =?us-ascii?Q?33UtivdnyJIWYFE8zzTfHUWAVpmoMN6XQgiHlfN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe4752-355e-4c75-f277-08db929558ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:43:54.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGBFGwkH6T4kpApIzThohvB1rOwrenqLq1CV9qwDLBNaUQtxC4lWgsVLjPfLJ9k6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:48:12PM +0800, Michael Shavit wrote:
> arm_smmu_ctx_desc_cfg is renamed to arm_smmu_cdtab_cfg to make it more
> obvious that it represents a cd table. The max number of CDs that can be
> represented by the CD table is stored in this truct in its log2 form
> since it is more useful for users of the CD table, and replaces the
> s1cdmax field in s1_cfg. Instead of storing s1_cfg.s1fmt, it can also be
> trivially computed from the cdtab_cfg, and is therefore removed from
> s1_cfg.

To Nicolin's suggestion, how about

Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
bit of extra information. Enhance the existing CD table structure,
struct arm_smmu_ctx_desc_cfg, with max_cds_bits and replace all usage
of arm_smmu_s1_cfg with arm_smmu_ctx_desc_cfg.

Compute the other values that were stored in s1cfg directly from
existing arm_smmu_ctx_desc_cfg.

For clarity the name "cd_table" for the variables pointing to
arm_smmu_ctx_desc_cfg in the new code.  A later patch will make this
fully consistent.

> @@ -2082,11 +2083,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  
>  	/* Free the CD and ASID, if we allocated them */
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +		struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;

Use cd_table here
  
>  		/* Prevent SVA from touching the CD while we're freeing it */
>  		mutex_lock(&arm_smmu_asid_lock);
> -		if (cfg->cdcfg.cdtab)
> +		if (cdcfg->cdtab)
>  			arm_smmu_free_cd_tables(smmu_domain);
>  		arm_smmu_free_asid(&smmu_domain->cd);
>  		mutex_unlock(&arm_smmu_asid_lock);
> @@ -2106,7 +2107,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	int ret;
>  	u32 asid;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> +	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;

And here

Jason
