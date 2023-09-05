Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90077792A37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjIEQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354568AbjIEMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:42:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DE1B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZfW0v2bibuOCwNYRcSF9i7mJOuQX/9AyPCGUI+85OvW/NGN18TQRfhcxnfBBSZIMevVSquLMyxYvKc3cGoWgdOql3zuBwIq2Cafuph1i3gPSFBKPCPkFHXdhFsvl6oH2H6eTXbqgtVcZqAmrwKUtMh86IsfOl36WSqWkxHmPS7wA7XfBtxwWIC8nb43psFSYC/d1XbtXZfs9nvZQWEHm7SJPmrvqNMdppecSMO0Ehl1auK8Rx4UCuSVejdKiZJfF3EI1KqU39h+Mo3YcuwueZsoSzNOKXpBQGvkvnc8g/CXtC282mIC1T6v0iBGA4c3qCL8yQqPIm83ZjAqll3Eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm2DCUXtb+LMgiw9REldUi6QmcT0dJNjf4s66J9v/S8=;
 b=Qdpb5AOrRPTZr2pSd57g9fNdNJFWZmQRMgwaA8paQYdY/HT+roygcZEeofjL/JGerk43m4FXkV2bwde0Q8tGRbYu0WPR2clnSq9tj92WwudzfTnFw0ix6W8enJPmWfcrrA34CyrkWsr0iyezUep5olltsAL2fKO0sLtQ2JAiAkLk/QdRSQq/9DrW3eKJErOycswI4Vgc+VbgXYXl9d5NeIgVCaWcLcHXluWsru7mJLGTwusIdiVMOJgXYCigmFFYpPM5+3IvwjD5o0QxrREvxga23689mdK4OujFmUfuVcfdAW7Y8pJRDogyO1EPSFsk482Fxr0Ew+DeNQBaCG7zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm2DCUXtb+LMgiw9REldUi6QmcT0dJNjf4s66J9v/S8=;
 b=O5Wzk/+krmj9uiGbwWQ41QxvPtGfU2Bdw9icHD4JtFUeryPgln0w0MyYPXZxWMy3kUrgBQQLZjBRnctU1tomJT29JpE3C6x0PXeBGtANs3+rnPqDGbj5E25P6/gRn+dWiDDaKL9jJU245HtMkqfZhuW7mhXhZ5FzqXJQ4wgcivSDiUxML2m6GCqC5WV1rNEP7VJ4bNPuGPcRKTYB1avlxpQcey35dZKdht84WdNvW9lJoLhXb6Xx8NcDCNsJl/9lATIiaiA+y7ZBecXAQirocsrHk9m7yP0fXvKtDXcBioIMA4Vh/VKjzLUFj1hH203D7ZBdEmNBXIGzfiEXq30Y2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:42:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:42:24 +0000
Date:   Tue, 5 Sep 2023 09:42:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 3/3] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
Message-ID: <ZPciLKG2Gi/Biovp@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
 <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905194849.v1.3.I211f2ab0ee241f53cdfbc3a8a573f14b8a46fb26@changeid>
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5d1d95-2d1a-459a-37c8-08dbae0d8d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6QBgYg/GVvNpVCosmWt4RhvV1N0fPopfNRIAQFXVSHE8fG2OVGbSEcWeQL/N9pmuzQvYzse5DbGk8927rI0h9AtJcXT5pSypyjXVylUtjeUl9WtoKGmwz1csf6foVjlkX/ITFInfxoktf/NQXezi06k1OV3hz7jLVmmYMqMIrKyHIpArshBuuZWQ3KEJ4M8HPCmWGiuIiFGnHssStKkpiA898pDP+tNXbTlKtX2xpLlD+f138TyyCwRntl4AmkYuJEKY7ol92F2b5EKsA+en9k55/nMA1addEmkg0O306EOwJMj5LUAIfOjAVsSOitQOCc/KmB3B//LNjyxjVL1xx4UhUCLwcopDHqMgGm8QqcMKS+iG02B1kBcS4jJ8UbB+y80B5jttR9JH1T9Lbrk1Amr1s4zmkpPmnm/eYaejRFIznYhAUAB+cnT5iAWlon2M4B6AvtqyQBRLeoXI6bMVqbGTcyxex40XwiI2ZWH77Ze2gFHSicQgbq022RMHK91h+7CqeTirlZCJQI4qzQGtQ9KZAucHY1y2X0dEy7dVd5np0rYr6fc35dkEYarUYH0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(26005)(5660300002)(2616005)(66556008)(66946007)(66476007)(54906003)(316002)(6512007)(6916009)(6506007)(41300700001)(6666004)(4326008)(8676002)(8936002)(478600001)(6486002)(83380400001)(7416002)(2906002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3MsQq6L+fyitP9gYRsbABpJkJCRFlccpOMCfc6OZwFIQEbuzxo7lJy6kcEO?=
 =?us-ascii?Q?RsoRZjpWAxglD/PQZCpXs+H9IqNouxgE+wS71KuTTIv3u4+UKE7xGphhGEZq?=
 =?us-ascii?Q?eOGwmLqEfjuoNjEZWaJyn5OvkHe/gPnqyW6n2FHHedapRt1M4Jio7BTYET5m?=
 =?us-ascii?Q?APKfwspwOi1eJDibVe/5dsGwLiN58o6h54SBkrd1Up/MJOj3yOWQxrTLW7Y/?=
 =?us-ascii?Q?sW1fAxw2FHY5TGJ1VuiLFjQ8f+l1kEo5E64sZ2vJA2gjEiC1CgqIu1Pr7xso?=
 =?us-ascii?Q?60liI9eZveJaAIDc8hFTjvGc/m3tC6rbZvQgcc/CQm5JvSZGeNZfTdMOlj/2?=
 =?us-ascii?Q?6NM0pWUCqk/lHXzvX4aGTlulGeC1j5UUOD6vsU4LFyWkq2BJqAXWdLBGkXfV?=
 =?us-ascii?Q?rRBbVfJk9ethbpoSLo5PjZQBW7U/tTNi0YYSlcJa+KkMoIooMPACUBXI/KpU?=
 =?us-ascii?Q?zQ1+G0kWNU4HRdKjH3NK7O52yVG9sh4XdUhWtf31qK8ISw7YhWLZ/cvdlIdu?=
 =?us-ascii?Q?6bW6j40ZEfEn7uXjmnMN6QJ34YNEDd2oTTHqy4jJy5F51+/EahsQ4tbF8Rk8?=
 =?us-ascii?Q?4EjAo/Nbp1Uh3eb5wAJDDfxM7zrRQAk8qdLGPhuhOpbTYR8hFf12ARUM4ea2?=
 =?us-ascii?Q?V6U9LM81+Tq0/Pw3GbB7IFtFChlFe92CNXjs6mApLJvL6WNuZ3v4f17POEWb?=
 =?us-ascii?Q?wBB8EBeESB2s0HjGoB0cI+BqeJCjOmSeNY+lDvrMokTi1+5SdOuh4RbDuKQk?=
 =?us-ascii?Q?0owOwUtHFX5AuCMrkSGuy3BniBwG/HjfohQRQDkSjPghzEQW1RRtvusTSBs3?=
 =?us-ascii?Q?aGfNn/9d6y87TVjVcRaGnoFORlo2sMefEkJGU0W/ukFw4iPQBLHKjat55US/?=
 =?us-ascii?Q?1c/LHtLF5p69lekqGyleEKtPSA09LK/H0VM1g/beweuJGUPSEEZkdvYo+pBJ?=
 =?us-ascii?Q?YHA203FZEiCpuPdx32x8QfxteRcLzPRqRPypzuvKv2fqLPeENLJ5evt1F8sU?=
 =?us-ascii?Q?D/76tvkcfTy5jYTqAH+V12kvPSvPpaxsAJECrAz49uJmArOpxMPdYhbKl1CA?=
 =?us-ascii?Q?BYgsB5kAPOuqLaqkzTOp4+ZyAvVZYXZQZD+uKu0zNhKqLpZdQ5IqHnaHBPOd?=
 =?us-ascii?Q?PLSxSFJt2gpYAmb+tbpVMqddbrENNTu7OdE/R8Apk+oBBrFcZzy0ufrF7us8?=
 =?us-ascii?Q?c94dd/N6C0+O+vzSNS1670KktwrnlR+3eKmskltjwn+xZ3a5l2BNbR7AENwv?=
 =?us-ascii?Q?zwjZRnzyytYnjoC/a25omxBMPIT2EdYhrKyqGPYLL+N4ykurhQB3VIh5zyj7?=
 =?us-ascii?Q?VHslb75ErLjlVeIddki0pE/xK7/MsNS0Cw4evmNok/uqSfsgC/T5jt6JHd3A?=
 =?us-ascii?Q?frMlDoE5ArVz4g7Yc/r4X6LeOAxmuZCLj7J57pKu6UOLSQTzaqISraZrd9Nw?=
 =?us-ascii?Q?hFogytT/N7KWuMOYQ4oap2pdHfadoWzO6I+H1pzrRAZSwo4uhrqzQJZIj1XX?=
 =?us-ascii?Q?F512uzC6q5kqTILWlDxfKCNZM3h261Y8iA/vcgp4uWcPNAhQVmgK2XZYlAm5?=
 =?us-ascii?Q?cosn217YVtktHF1b0yvgps6RJ1H38oEkygzu14tV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5d1d95-2d1a-459a-37c8-08dbae0d8d9f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:42:23.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHtx9CSQttbvKFLqRjc8Hxh93dzmeAZvhQMYRt0pKFcQmg7eZxaUVbqDRpylz4Vn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:49:14PM +0800, Michael Shavit wrote:
> Create a new iommu_domain subclass for SVA iommu domains to hold the
> data previously stored in the dynamically allocated arm_smmu_bond. Add a
> simple count of attached SVA domains to arm_smmu_master to replace the
> list of bonds.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 70 +++++++------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>  3 files changed, 26 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 9fb6907c5e7d4..0342c0f35d55a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
>  
>  #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
>  
> -struct arm_smmu_bond {
> -	struct mm_struct		*mm;
> +struct arm_smmu_sva_domain {
> +	struct iommu_domain		iommu_domain;
>  	struct arm_smmu_mmu_notifier	*smmu_mn;
> -	struct list_head		list;
>  };
>  
> -#define sva_to_bond(handle) \
> -	container_of(handle, struct arm_smmu_bond, sva)
> +#define to_sva_domain(domain) \
> +	container_of(domain, struct arm_smmu_sva_domain, iommu_domain)

I'm not sure about this? This seems like a strange direction

The SVA domain and a UNMANAGED/PAGING domain should be basically the
same thing. Making a sva_domain a completely different type looks like
it would stand in the way of that?
> @@ -545,12 +526,11 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>  
>  struct iommu_domain *arm_smmu_sva_domain_alloc(void)
>  {
> -	struct iommu_domain *domain;
> +	struct arm_smmu_sva_domain *sva_domain;
>  
> -	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -	if (!domain)
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
>  		return NULL;
> -	domain->ops = &arm_smmu_sva_domain_ops;
> -
> -	return domain;
> +	sva_domain->iommu_domain.ops = &arm_smmu_sva_domain_ops;

arm_smmu_sva_domain_free() should container_of before freeing, but
gross to assume the iommu_domain is the first member.

Jason
