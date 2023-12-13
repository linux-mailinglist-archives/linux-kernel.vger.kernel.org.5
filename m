Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576088112D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379022AbjLMN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjLMN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:27:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77635DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:27:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHjB8nRftB+4tsJLAhEglNO6RtJ5Un9McF8s5munYQerbBT8805Lzx5Ps6xvXAJ2le8elnFqdz4UKGKd49SLreHx+dc2CLHVFKpBD/sUeWWwF2LC+4VdQRW267UPSqDUzlNEyztfw7cS3GAgtpNivGGBFiafngndyWfsmjOqtJzHsfnTj5u9KcwFF3M4ImOhX22XuaTHhg3mHFAocU/rjh4IgwNj3OzTwFj0TyiTz4iK1jb2l9ncGxk8Cixb/1nqz0ioZ8GHpGqe/HqE9M7TkEEa/V5mYU31Rr9+k7wlDQnL0oVLKtHvav0pKjHFU3NpOP5PZGbOakhmofAC5oKHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxm43qIX+0kxJEzPdJEUpWq0aXF8AUAQ1Sq7cObrmzY=;
 b=jW5bzSU9CxKJZLjngALA9WjvdcETnn8/1CtfIYzaPqZn/DH7n/RqPwEm1xa8Ii5wAltdZLPnOUDpa9UA42XZ0PlXLIBJLpyazLclnF5vCQTlkMcPXGiHEZc9uH3MLL7x44I2WOaWJHweCzpNSAOVRO+9yH5pTauKr+uaVTc2q7j2fyLUJStYhy0J2gXWIsjHbFbADXvVqAYYsOd8YPEfmMpv1kJaEOPm1QBxIp1EIUXLOCU5mgOTofFephgAzVpUjktXkeR0bfOzudhK+tszAefYWYSxDfIhTotPfPsYzYibyxDJwRIBiRDdfRY6v+QSk+bNoEmg0oBdt5uFsuWPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxm43qIX+0kxJEzPdJEUpWq0aXF8AUAQ1Sq7cObrmzY=;
 b=kt17Jcl+bK/bGt5YauSf0F+UUCTq4EGhmq/EbUjMsYT657gyRe3d97IpWy/gIcbPQsqpeYepZifoa6TlT31P5F96ZK/EFg2SoKDkcYZ6GDdOTUrhZ9EAImXzVxzqsCxLFTF7ExcH+DFMqT5ua7jM1znPTCGIIc7D0Pa2Ij0ML9NyfmWPElQi8M1Xz6nKNRQBW98sAv4GXifjrhLkJCjMqbMLQqIct2Nai0PnfTvnmWrBP0Jp5sxbdG7lufZSUNGL30GUOARCpUJ5RZ4snjMjUexc5ag9Z5cIozyvIV102hEpQO7oS9A+bI3iXi0zqJLUIuOEMYM0/31BjIhz2leYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:27:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:27:22 +0000
Date:   Wed, 13 Dec 2023 09:27:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, yi.l.liu@intel.com, kevin.tian@intel.com,
        nicolinc@nvidia.com, eric.auger@redhat.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
        pandoh@google.com, loganodell@google.com
Subject: Re: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <20231213132721.GT3014157@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aa15ad-53db-4f50-2123-08dbfbdf3d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 581EaJfCVacmhso0VpKAOEyG+XfgM9ZIXjYDkR+j0D1cw2tXf9BFaU07332GkRtDvqicusOH6kI/VzuuSoeuDlzjd5AcXf8s0kDhhrAkd1b6U8GJCToPbkDAyFzs0KS2XjBRxUSr8zx2RPbfz//pMDMWW0qjBhm9WY++OzGXNYu06eTITmkSgojuO4eMB1M0ZIuSKoWJVGTr52lCuBFuQOW9vf35oPy+TUOSAe36GA6Lkd1Nq9MPvA13MLH8LUWG9B3gnPAPOjBhmRmzNO9saWID8hUV8lrwLEL6Lrlf/m9d8dwoc/owbM9aWR1D/pRATgDNIHGxmw4Y5b3RtnEgKzsOxuuMJF6rtTN3nwCYoqWwN5Z1i5dWQ/HJjGh0HgNEQeDhdnuAgwQ1UlkcGf853+eVMVcU/9EzqdQkET3QbOKOHNb4tjgIhGTsNkNLfgszdZGhqvAo3yq2TZPbDeuXaQhX16Klo6eVpJ56ozn1eJlO+0mMirTPB1gJ5647n5tNqPoq6+7HlS7kU0lA/fMIPUOHIlNU8FymltstvKVGO81tLOhxue+FWQuOtAZgsWhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6506007)(1076003)(2616005)(6512007)(38100700002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(6486002)(478600001)(316002)(6916009)(66476007)(66556008)(66946007)(33656002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R322ozOdouwtaWsZGmnuNIMGbg006OzAYcr4GBxhZvTsWJPnTHNWJUs6yuNf?=
 =?us-ascii?Q?O/MPnNSJllVHTt1SauZQ+Cy4LA7OA1ZnjwJFqIWjJoq8TFpeYLVYZZYlWG/5?=
 =?us-ascii?Q?DGMCiDW/esdP77jzjo8lNAFivFSRTuj8KRYJ/aS0WaKKkwE8ev6DK6mhBtqe?=
 =?us-ascii?Q?sDSWS8TlZRJmCDCqJUGXYfHu7QP7+4bTd/WEy9QtHrMs+WSCm73tfdR3b5Lu?=
 =?us-ascii?Q?psnoBQKLgnAuW31ZB+J8YlVNh06MmqV7kWUzB0FcW0YGA1yVDiDxwoY9Da0m?=
 =?us-ascii?Q?oCFIHO/F9hbNznnxjKwAFH20Qe65xn44JbRS0JUws98P+r4LeBj/MrzE4Waz?=
 =?us-ascii?Q?iO8R2//0NdHlb0Yyrtv9BXjuczrt275KdpJ6Z1BwjwxYb3TXBOnGR3/8SfzO?=
 =?us-ascii?Q?dj0acPgtJU64sMEbxbZ5yS2sMWRu8j1KY0cbNrXgRZs05PmBBtYRvH03VS8V?=
 =?us-ascii?Q?71wW2ISnOJOjO8nVfIYV77vJS4Z0mPBJqmpYLwOYm0N7WlDzLtKiA7XQgbPm?=
 =?us-ascii?Q?WPbwVEtiJK+j4AtUFDC6styRwclfalwubkwz1tLU05kAxk7ffuZyV6v/sFQ8?=
 =?us-ascii?Q?YRpQbEY5sB5zKVNUEs0uvPezOozkD5R4HzfI80Xh7MODbWGQ8HehHOgZlJ23?=
 =?us-ascii?Q?iwoFPk+xgvzd8Jfof5CiO2lNGwRs8p63XkkiEHz9hSfNKFCm3FdK03FwnjRB?=
 =?us-ascii?Q?iqaIMdIK+nHYXw5rd+7ZDFqL+hEf5Zk4ze7thk35+ZsOA/L9GexFeRsiM+fW?=
 =?us-ascii?Q?1qVR0S0k39JMkFThR02LFhdmuy+d0TE8hK00t99HvSLpO0LIQP9epE/5AzkT?=
 =?us-ascii?Q?7fOOERns+RGoKQqqQhq0dCgteSb79AtUzyyCowqcu3dj+iepnViar3VhDvie?=
 =?us-ascii?Q?U1hPqCq27vWlPlnUR3emSVR4DvvfQezqkw4jbedPUc9wL+AJ2XMQOonqR9qC?=
 =?us-ascii?Q?HVMdzqpJS3r0z9N70Z1LUODGN7zfoQlHZqZKa6T0SpnSqGGpN+Eikdep8F8+?=
 =?us-ascii?Q?LmwE49AAzOJaxel8wLupjn1uhsBSgkp7Vv6/8S3MRN5c1D6r9ZidI8YJOjAe?=
 =?us-ascii?Q?K+kNN9qyJzg4FQMjktcPqkbVcVVv36srTtwQXe1ArrIY4pJYD0JzGqvmkfVw?=
 =?us-ascii?Q?fHIvUhQ5LJJ0udDdEPjyCO6IQ7bSwndtIoyQx5UrHp2TXAQCl5GJppzqgW3Y?=
 =?us-ascii?Q?MB9BT+iiTBQ4qX29VIGD+27prSTC8sC9JVPszJYDqvZAjBIBm2CHdIuZIRCi?=
 =?us-ascii?Q?P4exahrbO2U6tnKZ+fhO+2NMyiBwpMGxJ+IthfJR/NRJdslGje+uHIkP1c5k?=
 =?us-ascii?Q?VPFSP0/jQ7YA2Qtn8Uo2XAdZsPzMQhOJfKM3Lfdc36y84IK6YO8i75pKkHlF?=
 =?us-ascii?Q?MUcVa8h/mfzQ80zpiDWgY9XKLpWrnLAopOxQufd1ggCPVfL/5lLnNYlyio5u?=
 =?us-ascii?Q?6YMfTIPFUaYuVr3LG6rPszSDYJHtTx7ueBwYVLgl5l/UJhp2WihpEsU986yO?=
 =?us-ascii?Q?lF7aXeNH89ytFTmF6C/WEzNIhuKn95CD4bXVAojbEL8U6Co482aaJXg4tJah?=
 =?us-ascii?Q?MJs/XbUCA9D35hb+QJcyhaTE8LoJaQZqb4pY7Uyf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aa15ad-53db-4f50-2123-08dbfbdf3d34
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:27:22.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clFVRkSJRa+2ZPs6IFhTAZekxaCGVrkI78qHdj3T6E/DnpEvQubKuwPwIpt2icDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:01:35AM -0600, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor determines which IOMMU features to support
> in the guest, and communicates this information to user-space (e.g. QEMU)
> via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 ++
>  drivers/iommu/amd/amd_iommu_types.h |  3 +++
>  drivers/iommu/amd/iommu.c           | 38 +++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h        | 13 ++++++++++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 108253edbeb0..4118129f4a24 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -72,6 +72,8 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
>  void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
>  				   ioasid_t pasid);
>  
> +void amd_iommu_build_efr(u64 *efr, u64 *efr2);
> +
>  #ifdef CONFIG_IRQ_REMAP
>  int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
>  #else
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 14f67a8cf755..956fd4658a4a 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -100,12 +100,15 @@
>  #define FEATURE_HDSUP		BIT_ULL(52)
>  #define FEATURE_SNP		BIT_ULL(63)
>  
> +#define FEATURE_GATS_5LEVEL	1ULL
>  #define FEATURE_GATS_SHIFT	12
>  #define FEATURE_GATS_MASK	(0x03ULL << FEATURE_GATS_SHIFT)
>  
> +#define FEATURE_GLX_3LEVEL	0ULL
>  #define FEATURE_GLX_SHIFT	14
>  #define FEATURE_GLX_MASK	(0x03ULL << FEATURE_GLX_SHIFT)
>  
> +#define FEATURE_PASMAX_16	0xFULL
>  #define FEATURE_PASMAX_SHIFT	32
>  #define FEATURE_PASMAX_MASK	(0x1FULL << FEATURE_PASMAX_SHIFT)
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4e4ff1550cf3..c41932e9f16a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2822,8 +2822,46 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>  	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>  };
>  
> +void amd_iommu_build_efr(u64 *efr, u64 *efr2)
> +{
> +	if (efr) {
> +		*efr = (FEATURE_GT | FEATURE_GIOSUP | FEATURE_PPR);
> +
> +		/* 5-level v2 page table support */
> +		*efr |= ((FEATURE_GATS_5LEVEL << FEATURE_GATS_SHIFT) &
> +			 FEATURE_GATS_MASK);
> +
> +		/* 3-level GCR3 table support */
> +		*efr |= ((FEATURE_GLX_3LEVEL << FEATURE_GLX_SHIFT) &
> +			 FEATURE_GLX_MASK);
> +
> +		/* 16-bit PASMAX support */
> +		*efr |= ((FEATURE_PASMAX_16 << FEATURE_PASMAX_SHIFT) &
> +			 FEATURE_PASMAX_MASK);
> +	}
> +
> +	if (efr2)
> +		*efr2 = 0;

Why are you checking for null here? It is never called with null

> +/**
> + * struct iommu_hw_info_amd - AMD IOMMU device info
> + *
> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)

Please reference a section in the spec for what these are just for
clarity

> + */
> +struct iommu_hw_info_amd {
> +	__u64 efr;
> +	__u64 efr2;
> +};

__aligned_u64

Jason
