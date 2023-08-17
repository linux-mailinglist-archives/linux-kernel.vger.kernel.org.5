Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182477FE54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354648AbjHQTGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354683AbjHQTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:06:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B030E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifILKOCDWb2PbvaO4VOtf0Mhnc18OLgsAKf33R4sfMQkewGPnNfLwAOLya9C/VcYJNYr7bjBbWo9MKsbQFrw6agHxKR97bBX+XN13H/8sYHn5gKsyAB1MOYODpa76EsvjGtBW+Ke7Gu2of9FQ/g34gd4ovkr5/5kbXuzFBhw4U5FhRNDi2JrDt6CU5OXOR+AYnD017T+z0OWujzvvvBJLTz8lT6maOZxwGu0UCGrqXYaIxFjiXrwrZpXGX3MMrDIJk7aZ90vLs09dSA1KvCuHcSZHBXN78GRQiNT8f104dponlRurP6IBjNVVBOg+TpaVg5aF+f6RUpcENOMPStXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtlAfq4ZCuuJMdx5t7o9QjMgnDsUY5R6xrMQBKkdLxo=;
 b=myPcT+36OP6ayaB7uK6GhYL5Va0SXHex+By53Twr6Ya7JLGRfUcPd35VFQpZ/bE8JYZmp/aPVFAOt34T3XVd4fdcTkWB3ODCw4vm1niws9nYarMU6qlGQCV4lHre0z2soBDGhpZ/IsdbFohSWlX/EZ9my0d23Wso9n+K8YxBTC/C6G1D8Kp0q9+I7aAWUmZL8NctSE6R3m+NIQCTVG9L7M+aUQyuUkwZaS/Rg8gVjXJNxryEVjH9lHK01w6v0e0N8G03bqI4gfK5eNfbdUmWXN7oHiVduJwFbXA94TEttzTnoZfY6KII1GFTMH3VyJv9AvJEzlRSGAx4dv6Br0aQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtlAfq4ZCuuJMdx5t7o9QjMgnDsUY5R6xrMQBKkdLxo=;
 b=jAgnNGdkjgUddQEc7C4Rc+9mZG3YaLb+XArYOi3ugjbGlBTeoxbCUyCH+rhkOVnoVANa/BxQbn/6wpVpC20DpqVvOStbrGwSpOMOzCf14sN8ES+fQvMdwgkEKCFLT1GMyvYKxKVmm8WkhXQ1IcektGanz8U3BmyzJJ1e1apaqA8ItkNHVTmksJ4SlhDoULpMckk75BUBYQovW9oeQz1iZLnjNHFcZvdcHQa3QtM3tNum17dN3s7XSPY1y0QMnSnkylcYwjzsWeZVw/C+XmW3XArbTO60gzehGQurqd13x88PgAhbyUahIvE9UAewBHqnctuXwqFX+59lOafAjle4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:05:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:05:56 +0000
Date:   Thu, 17 Aug 2023 16:05:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
Message-ID: <ZN5vk9cVp0j0jd8T@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8c66ae-0630-45ce-1ac0-08db9f54fc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezvAPYfFQRgmg+jnU6UcmrkANL9Wth4ZBRYp6rTbiVwhMgDB4dyL3KACPYQgrWcpHVd+LRi/EWJ9ayzI+mO8c4ImHFbvtvrUG5uWS8RMIZ9hgWRTaFfZBrQ166jrIYeLJzyMLxx9+Db1wStcmV1RHgTdpSZGkT+7jxs+8RJGx4H2MiS83JO8vcVHON6mA/rkHiYX1YRkMqRqyikG5PllqxrBfnObDIG+95buTuVWdo8DCXD0pvH750DwnX0b78RC03qB6EtLc40YcuE7lgTDEHfmHloXNk3yu9C4Wqh/f5vPmRSkwq+gdzisI/CaixwSrro24jLmjH9WkeJJiz/x8ylWcOXS/IXwovSOJKObK12cgoSPJQpymmUPq69rFe7plm+sWBNOfVsWIjF8gDB//lCcaP2s/zRVKJupKQ+c+jk4hP5GwEdOvBWuE2A9jkctPYf4+E7/nXMj/ZZ7ynzhW/0JtQ9Vi1WBUmxHkdLUDh83/hrP3pHjffnjjTyomdo356MdqGxUaInA8I/a4Ocrgc55SPPUgLRmBaHnsxpa62sb4/bdIGXNH8fPq1SSxz8a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(1800799009)(186009)(86362001)(36756003)(38100700002)(2616005)(5660300002)(66556008)(478600001)(6506007)(66476007)(66946007)(316002)(6486002)(6916009)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TE+uPD0GpyqsuTU30i1zTjFBSydaz5C96khRWQT5B21slnyJHAt2cA/Zlf6U?=
 =?us-ascii?Q?dvDt7oG6YjKYbp335vEiElF6nYOJp8i2ajhK0IIR5etsRjemBAtq9OnquVBd?=
 =?us-ascii?Q?H8PFHCWcjQhZ+nBVKe6N+bNdJCu1xOfccM5bJddeGYUygm8usSJh1YAVDp9m?=
 =?us-ascii?Q?O3/QOHSKhlmdtHCgpCX4IAYOrp2+qZBi9o2W8Zv1ANNqg4WwjQz4hxDmDLLB?=
 =?us-ascii?Q?jdCY9Ccis72otTENHv8yMhn7vo1ySpN5Or/TKHb4S+km2QMz8GUtePYQfD5T?=
 =?us-ascii?Q?b4Do/fXC1sNcHpI8mxglvAXhqIwwfKoTkQ5V2CEMdqsQw0H6d5gANkcMPDWC?=
 =?us-ascii?Q?fMsbkMsY+uwocMuhi/xk8Q8cjdVcmc8S8Czws89yxZNRGjXDNcDXJO6Zqejk?=
 =?us-ascii?Q?FD/2TBXUNgYxqfP8/sDhPdC4gmTyZOfXL/jD+Og2S+5J6tfgfW9Ia/32stKT?=
 =?us-ascii?Q?GH1lV4xn5G4gTdEtttvRAf/rpfLfUYfs66CoQ7j0r/8LpDHEuhf1RcKDO5Se?=
 =?us-ascii?Q?UTJJSvRWddMmhkh8ZwaEfyZcwjEaD7gkzGTLMJqzBQ3T8+HQHCgA/9nkV36P?=
 =?us-ascii?Q?kiBBouges2ehuvJ6mTj0pQSkKFvnuL0VuSN2k3dae/s/bhw43vsEfb/TU9q9?=
 =?us-ascii?Q?DfX2OVbUJvydK4oz53yuDvOQBg1zRv8eR54EF6n/r4YAjX88CpAxCjtromFk?=
 =?us-ascii?Q?THLQcCLvFenyCWzZIaUTHeCi+SeVlyQickJLZuZ38Eg+BqZA2ajSoTwcBJnG?=
 =?us-ascii?Q?4aoIMWhVfIBx6H93c/ZdL4Sx2v4YOBx1Nte9FMvWY93GTUQtKuMKV9wKuGAI?=
 =?us-ascii?Q?hoxDNYhDic8A56vIW+bXu5/QCThiJ/KkppODxbDLy4zP0uP/Bh0nol2ER6Xy?=
 =?us-ascii?Q?Xrrnrpa079K0xlQViTmrkEj4n7AU57NGEO9sqSiAx3ZLQ+sSWarU2zeF4YTm?=
 =?us-ascii?Q?RyP5/aNBbHkeuQJluIy0NhWBf910ru4utyvnyoKkquDEgoF229H0JXrZUu65?=
 =?us-ascii?Q?3BAf5rsl2GH9yXy+PCR8Ftbn5kHlTp1ZTdK/pIsgGGn0AsbNVrwg7t5cuzLl?=
 =?us-ascii?Q?YC9sDdi/kcDryABgo7xBUHKpxQV83pAxgQ06f3wWug/YRkE2hFA9DHGxmBAn?=
 =?us-ascii?Q?n9y5RrZiwakKE9BebZc4ZxtkZ5f+BXjIhhdrfjtmJyvBeHcIHpNlNy4zwybw?=
 =?us-ascii?Q?iuFOqvXuY40sn3lavivbKEr7aGQMgv9Qwt+SjRGzi8q6ly5Y7O8VBTrZ8Oq2?=
 =?us-ascii?Q?QmrDnPT6qWA6gAk0CZ+8bSVA5HVHBfqUpJAu9AhQJbA4BjXxhrxldG16c9In?=
 =?us-ascii?Q?OhzhnTJ9Nsv+pL1g6azjcO8XzHiGOTx2tGlEC77KBehJkgzAgnVKCygw8gQs?=
 =?us-ascii?Q?kHtquxxmG6YyXgexRZktG8RjE+UiNwUGQC+JbFOJH84zR9ckQHsDrfUjThHP?=
 =?us-ascii?Q?jMFSfWU1zDhLI+ZVP/NdeBXwhKbuorzt9V5BIFLVrHiHw2zfLm1va7ITqVSy?=
 =?us-ascii?Q?4AYRGCif4qUWmSV64C7anqcS2bPcfnUw7tWfSkcRATBrOsPoaHec3IY/b0u/?=
 =?us-ascii?Q?+ZzxebfUFVBNDRVPd5YJcVcydEIAmbNwS5La0ldj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8c66ae-0630-45ce-1ac0-08db9f54fc56
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:05:56.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2CWbPtzK8gnET3wVsvfaVpHIuYMF1NRc4P/XbtN2Ue6GDNw1dle/4moT1UOcA15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:16:23AM +0800, Michael Shavit wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 83d2790b701e7..a9202d2045537 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -690,12 +690,20 @@ struct arm_smmu_stream {
>  	struct rb_node			node;
>  };
>  
> +/* List of smmu devices that a domain is installed to */
> +struct arm_smmu_installed_smmu {
> +	struct list_head	list;

'installed_smmus_item'

> +	/* List of masters that the domain is attached to*/
> +	struct list_head	devices;
> +	struct arm_smmu_device	*smmu;
> +};

Ah, if you have this struct you could just put

  u32 cache_tag; // ASID or VMID depending on domain type

And make both allocators local to the instance.

AFAIK the only specific thing that needs a global ASID is the SVA BTM
stuff and it already has code to handle collisions, it can just run
that code per-instance.

>  /* SMMU private data for each master */
>  struct arm_smmu_master {
>  	struct arm_smmu_device		*smmu;
>  	struct device			*dev;
>  	struct arm_smmu_domain		*domain;
> -	struct list_head		domain_head;
> +	struct list_head		list;

What is list for now?

Jason
