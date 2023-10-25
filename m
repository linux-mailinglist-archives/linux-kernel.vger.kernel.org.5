Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF107D6C72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjJYMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJYMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:55:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AC90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGNAupZLugSMiF/02kxmG7pg1DCx5/fJeE0SD9gU5LILbaXZb718HjQCrkDmqNJFKP3EJM3rzVNIMQyfZuYpshODVtexbvRDHKNImFqL+0q4fSwqv2A5L7q+s9g+GgMWTZl6Z8I7ljLr0rOd0sBW78iMroPwJnESRW2gywSNcG69cX4Ms05bZu5SqYnYs3Y+M8/tml1cBoV+i20efpFpO6zT/2yupfu66C8u/3sx9CnWyXRsJpTAv9a24Icf6yuK1LM+eewe2H9YzvGSigI2mlRYTZmL+R/kL99tRv905KI305DdcfEi19tpCY/JmdxVNs+VQP70HYxakdslHjCEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0dzpna+yEKi74joM1IVQp/g/TiIFrNvPRGAQotp+bk=;
 b=npyJ/kMbodz7ieyV5mfLS8LwsMynl9+jIk5QxZfYY8bHw+Z1p30i8reh7IB2r7UhDm2EckeNjiISxcO6KM3c0AQ2ya5V3xLOzhLs9N9UTl5+4/orfmoHADZ8goapAjKR5mE/HJcrfswmYUhjRH1YXM4vXVqUSU3O2T04+35esYcZEwv6h9NXsy+El9wU8T67GNewGnHi5fsudbjBTftRPod7yF0qtWlaeDLY9B0kunNu/32HlnQB3V3K44Ua7NxhTbotnGQcyfDJajcDw488oF+M2XkMERMdgTc2ioFg27rOBSmbVAb0AsUsSV/5pzhi0H/T4A5Sn5GO+4dcZc2LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0dzpna+yEKi74joM1IVQp/g/TiIFrNvPRGAQotp+bk=;
 b=DISN97NFcqKOERpW4tEpDX3jY9ABqBcjyyuRWWLzDt089rIX6rJ+x/y4rjUzvzZvuVtDVQrj3kEDAspqNHv46QjxNvjGNE7rEpbT7kUkkNlWZiqwIfBYR3mcLA1KomjIZheU+m6igL3C1RmwHwRxO+NUMDfKFQgSrRKXnFxViuAT0nfCCORc6BqTkP6Rf8C9GvKYb14IfKIGJ6gqpkT4jonrKWpXa0bC4nxD+ZPRg1y1Q8lsePg9+6HwNtRhnU6Qow2nHV+taNrk5XOVb86rjt8XKHn9JCWuRh3bzqT2DVL1LwXV7qlFcMzDCkStvGyE8SI4vglfVkSq9keTc4ejxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 12:55:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 12:55:29 +0000
Date:   Wed, 25 Oct 2023 09:55:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Message-ID: <20231025125528.GG3952@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
 <20231024185213.GA1061115@nvidia.com>
 <ec86712a-0c46-4b27-9736-e34b02168e19@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec86712a-0c46-4b27-9736-e34b02168e19@arm.com>
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e7fbdc-5a4d-4219-1894-08dbd559aae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izDymWbrl/HRl4xLWFPXUBE0SQumxWv/MA95HqIG4JPWSxlP0XKogc+ObdNdWQq/3E0jHjDHWzd2ibPRXG8aKuvGp7JBgbYkOeU/hEHe1aQbnHkbztGLV6WX80XJ7yxKhVKj57vuKqZJi6eqfgKAEKU7yGnVu3SZuvg05OtIsFFBLM+6nC5mHcrIOeCXFQkqRxxbAaxat5CK7FZSogdmz2zQ+1JEWzkODdi8WtEUvGa2jYYpaBiTBNwJyD4frDr4/yfk37u7jv7JSc8I++WMnzUnkPXt6dy3so7RUtxeB1DwF/2R4iaEgeLA9j6dX0GGRYHfMkuuR5Z9jWtlBA2g9OyWmaUTgL5UajJScMkbNOhQ9bdJcM+KJiBvCrQz/fgJn60sTsxypAfUqo3mpljSFKr4DaDvih0M4MNxtjq9QamWEwValPpv/Bm9l8xmtbUM0HAJgWDsspQCE/JeI2Fl0Rgrg97h2avDVWB+Wr+c+vF/b5XbkZH95EHONvFV/G2k0av89ReGEcUVUeW0bX6BEMDuoeubfD2u2IZOg+KLISrV+GRa0hF16c1Qa+RF8X5O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(15650500001)(66556008)(6916009)(316002)(478600001)(6486002)(41300700001)(66946007)(5660300002)(8936002)(4326008)(53546011)(8676002)(86362001)(33656002)(36756003)(83380400001)(2906002)(6506007)(6512007)(38100700002)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?orLNzAPdXwa2dPbzYzrKkSYFYBt0gwLOlj0GpXjVMAV6RzVGRiqBNCvvos/0?=
 =?us-ascii?Q?UY/pvOdraH3MF6gDzMCv0sS5Q5I05Q1YT0tk3FPbxV4Lb7xWRocdL5Et/LAM?=
 =?us-ascii?Q?KgrbB+TG1nwlDPlVzvgNezSalwmmaYKGFeQU5l7nz8iyvzjpQ0ZScpyvItgv?=
 =?us-ascii?Q?Zs0bwBhqZe4MGaXJhvqud3Ni9BGmW0Nxum5GhhqCajwZ4bnRk/MbcM7zrbPG?=
 =?us-ascii?Q?iH7IMoSyJHRKHXiIgNpK9Br0bYt8F6RPavq4bbCG6eG6GVPZbpqg14nnnAPu?=
 =?us-ascii?Q?pYPCFF9wGNYVz2QW3gHgAphqtctJ9dtA+HSV6rC905fVvdDjNwsv38q6K6QY?=
 =?us-ascii?Q?zfa44eJTn7LT5lwQu/QiwRoYD47k2wWaEQQEN6FDxTTyI60/ECX7tRHaJxe5?=
 =?us-ascii?Q?5st4DTipcrjJLObkysONQHmCqWbhfkt0x9KTA8CCdMMHIdRCi31kgzbu1u2I?=
 =?us-ascii?Q?DzX3/GniDMxLfbHa0feAuAr+TcyRYt4vG06HrioIEj5ccJ+7rMpDhKDdPSuF?=
 =?us-ascii?Q?TaAg4VaIOnT+CEBAUBG3dWqjg3ye2lUUBdJcE7eDNum71OcEUohSLWBoG8j5?=
 =?us-ascii?Q?FjaB5P3tqmmlE1ZMu1Cy3mQn+E0GUZ+AhpFwyS+uPw2R/FEpFfHTkc8DpR4J?=
 =?us-ascii?Q?o7vaBaeveNQQwpAHeOQwm12nwLQLzTfpg5fF5OVkCaZDMa2EzOIAPtKHEVPz?=
 =?us-ascii?Q?vE49aL+Peg2VqGSA86/HmyyWvSIy12kvoex9OO1ok+j6fhSiW2hYJkmk4gSE?=
 =?us-ascii?Q?SqstQh3rnbolkznCpXOWg5C4nCFZiXIhFlGW6x1tBvkRZj8O64OTIyBeuyz3?=
 =?us-ascii?Q?PDwH24VGZR20+5FNnzfrasl4gxKSAkYP+Mi1W3H3rUTmAz4hmme4CuPH3TK9?=
 =?us-ascii?Q?jjFt4KdP0VWyALSPU9w6lzc4dUNtAnt/YKnVaO5C3hezd0GPAWL6mgQ4nIce?=
 =?us-ascii?Q?6nYOUZ3Nm05NejSNVpKA8jx3kqs/+znGOs3L1LxZYD3F4URRga/gulGCQ5MB?=
 =?us-ascii?Q?rgOI+jsRpGnpzaI4T1TNV+bmNJNAJNIvv/qfTB1rT2jku1aNTAFK4LUgixty?=
 =?us-ascii?Q?aPTN7c9cFbH4gYBfHrwFAdA48Jy5bKMShC6Wm7rUzbUWHeNBqM0cETSJ6aXp?=
 =?us-ascii?Q?RvjDppe20ddE9cZoAfoBwBWYvWJOCoaPGMkRbkKLu90k4eBJWhJNLWIA1Ozs?=
 =?us-ascii?Q?7iFvI0PuE+q/ruiQnfi4wZZRr1VKVNrNnaXqoVva7tcvhOpMG9v9QveXUbpT?=
 =?us-ascii?Q?orMCAEIXI41lIiDlVdyjOZhmEt/oGYbmLL5VEh8CS+jbdaOHFc8wE11fyRwK?=
 =?us-ascii?Q?o+mCw9P5MryujT+LJbeAVn5rLweUpX62cxa6suHLW8xOoAY0PZCfjy+lAUYA?=
 =?us-ascii?Q?IxISoGAXOSXKlkJHY2o+2e6NjFqCGEcEzXpEntjN/lgCbnmignFrOlzGqBMc?=
 =?us-ascii?Q?jsY7MG6WFYWOUM7TBwLJVXOVvqbTcGf85i5CpyTY5krX3NbL613tYE47rdhj?=
 =?us-ascii?Q?GOng5QO0gyMLi8vZPJc1KPCVccLTs/TNUfbNktvzm1weQppmwxS3cryNh1y3?=
 =?us-ascii?Q?CA5tJNjmD8s4XXxA5H9oEUkQV5+2IQtnRKrZSsxJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e7fbdc-5a4d-4219-1894-08dbd559aae0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:55:29.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZyAziy+kccTDbqDbtsjsy580x9bGROxEF2u0aGBvLic4f8uhkAGrJjzIr5Fw9QG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:39:56PM +0100, Robin Murphy wrote:
> On 24/10/2023 7:52 pm, Jason Gunthorpe wrote:
> > On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
> > 
> > > @@ -2279,10 +2280,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> > >   static int __iommu_attach_group(struct iommu_domain *domain,
> > >   				struct iommu_group *group)
> > >   {
> > > +	struct device *dev;
> > > +
> > >   	if (group->domain && group->domain != group->default_domain &&
> > >   	    group->domain != group->blocking_domain)
> > >   		return -EBUSY;
> > > +	dev = iommu_group_first_dev(group);
> > > +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
> > > +		return -EINVAL;
> > 
> > I was thinking about this later, how does this work for the global
> > static domains? domain->owner will not be set?
> > 
> > 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
> > 		return ops->identity_domain;
> > 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
> > 		return ops->blocked_domain;
> > 
> > Seems like it will break everything?
> 
> I don't believe it makes any significant difference - as the commit message
> points out, this validation is only applied at the public interface
> boundaries of iommu_attach_group(), iommu_attach_device(), 

Oh, making it only work for on domain type seems kind of hacky..

If that is the intention maybe the owner set should be moved into
iommu_domain_alloc() with a little comment noting that it is limited
to work in only a few cases?

I certainly didn't understand from the commit message to mean it was
only actually working for one domain type and this also blocks using
other types with the public interface.

> and iommu_attach_device_pasid(), which are only expected to be
> operating on explicitly-allocated unmanaged domains.

We have nesting now in the iommufd branch, and SVA will come soon for
these APIs.

Regardless this will clash with the iommufd branch for this reason so
I guess it needs to wait till rc1.

Thanks,
Jason
