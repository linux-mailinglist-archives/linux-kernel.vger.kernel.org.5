Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48E7A4F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjIRQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIRQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:40:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E3B5BB1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHii84OixFiWYqr+36DYhOxSu93E3Jy7xA3+GpcR3jNiLkPXYsIgSExl83urRkrUTU13s3+BMHmxJbT5Xo1ZV2E5uZqyBEDMOIRvnPAjH+jo7CkbXpQVIt/CWspQ1fBAUT10eKgY0aZSZhAW9YdKbDdL/uRVr7ya83XFQDx1ORiibI080L7Z7qln/lxGGs483ypSn4brd29YyZCbc4CBqW/q85iGsU5H+/imm+RpABsCarXXk/9lqvPUEw2pG1L7/LWnpz/XSYTbBWDXze7UBFWSwN8GciSIenvc664yBaYES7QlwBiU2lvK27PqqbyFCGGGRkiEzgktB2eCELPGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIeiHRC8yh/Bj713AylIgGfj4D4BGZcuyRvS6yYsTK8=;
 b=TfGtiIxCk9EKj2C+ZFtlcvdAX4G8nyiW4Qt9Iz6MhAzBvlbv2DDubC0vsvqB0VQiVU8ljdOmIlYjal4wd5LZk3VfbEAnAPo5ux7UOgkDRKvex2iLYiSWh4/eFAWMWiepRCHdBaBHcmP7GZbRFwrPiUDfOr/2lJcORCWJOzpJ5gcXgs5sieRAXk7Aa2X7jQnZsjeVoOgXGdejuTtD/mAVnu5sJfBLQGt3lhSU5lww2XKkoVT1aEKtf2IwnlNalDdu6eG5HzcdWQq2uCdZC/6hs7c34/TUpHwZsHLRMav0WrZGWeXgoWXnIXLlB7Z8n4bTx5N5GprH1Y5tfYaiotbgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIeiHRC8yh/Bj713AylIgGfj4D4BGZcuyRvS6yYsTK8=;
 b=MScK+0DGT92qk6JC+4kzmv/FEyTGi1YWr6w8WWvqPhQO0JVrfeZzfROoquLCw6kTbBDbGnnuWl5Xe8fQXVfgmSFNb3wX0S5O1QNgLZ+oG0sYetoT61+c0OHLpLKkZBnT7zRKAsISZJFcqQOviw+trT882nAR7gG/cS450g2HyenMLLXYb3k7p37ykuy547FXfE3sUq/r/tAmt4B6QIOuwIf3FUc2Hl3E7cvCSB4oMayoR8LlFbr1F8pnUXWCiiBNgUmey4StxhR+1AcgpKCjqNTpDH+35sUQdiz66vC/nAK/oyZApLyJy+QHzWsg24NEYTDLz7Fd0AHzRy9lWdWTaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:36:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:36:53 +0000
Date:   Mon, 18 Sep 2023 13:36:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 1/7] iommu: Factor out some helpers
Message-ID: <20230918163652.GJ13733@nvidia.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
 <a24acdd821a87ddab2ed4f5dc4e5ba047e126404.1694693889.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24acdd821a87ddab2ed4f5dc4e5ba047e126404.1694693889.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 812da2fd-7c02-4605-f580-08dbb8657741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7pepj++KB5PgiC5tFACs9UBkcvyn98qsZoqzH27bHQnOYZqRHRF265UMlzKwcezJ8AMbr6gt7kuCAF1jKjeJSGw7pTJWNs9uCbxgTnhfpJXQKYMYavHhXu8ous0nDTguSH0u+4CJvEFsjcna16kfrTbQbhogdMNNedhdG8yTP4/s4XGS3UUeFdW4HH50ErNMb8XefC1W3zwgUrlO4cTg1WCeQxDhvrgZ0Wg+ZmCE5G7vb1gs1pXlzavnc/87Lev68zPLmxW4cKbpk318B3iDRd082/njVcC07dRqKVPdIudgaBQubdZVezBJLmK489GkBOcfbZSkupYskdUd/6cQP9Lmih7j4Q4WIHEN+6EWvNYMP0/I4Z2hhQYHXc+H7WeH0c8l1qpb9zKEJVXUbhbdTD9OK/q7xMmbzaP4VpjC0oON3hAAeenhkj7CyWShi6CqPHN8FmDA353N3UCkK1Qt/4KOgCiim01KCy9eodoPv7C/GG8nog1LWI1n5PFd/S7nuN6XUmKV+A72wECwy83++E7zXLheRPPUSkAZzl3nlWhWdMT+4E7DQ7jQDccYoWf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(66946007)(66476007)(66556008)(6916009)(316002)(2616005)(26005)(1076003)(83380400001)(6486002)(6512007)(6506007)(36756003)(33656002)(86362001)(38100700002)(478600001)(2906002)(5660300002)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E762fLt8ZihXzl8W0iijVlrfmgCKSkrNCo+mQ7mPE3JUUdwwJbS8wvD/8txK?=
 =?us-ascii?Q?RyCwIkyoVXW/BafAeDT5KfUhRLoaxgL5X1FghWokeMChhDRA8d5DgCD5XbYU?=
 =?us-ascii?Q?Y3RMlt4lLy5DN7hu4A9KTzUj3YM1gHar6bIo2H6WT55te9cQCR7eWuu8RYN3?=
 =?us-ascii?Q?7MnkUFdIadF1p/wuyzhBKYwtM59D2YoqMIWzcL7Clzk5yohcqSR1++08mtEc?=
 =?us-ascii?Q?dE+oCnWJmDWyXhJbjklyxyR/Re89w2XTHISk0CqLFn81ej6stwwXNU2VOxsr?=
 =?us-ascii?Q?675z1LutKmT2vDFiioiKmo+nN8CQ1fESqylmW9l92guX2s9FodFB71TTKHul?=
 =?us-ascii?Q?89VO/bN15nt7IiKWXcNiXW0aF+7f+ERtD/XCRq51OQkaMdiA5Bn4xX6AVWub?=
 =?us-ascii?Q?lRQkSZe/4Y4RlMeEy7d4W84ovJq8+4TOjyikXlgvuC+RnS4b4Qvw5cqrL/9f?=
 =?us-ascii?Q?XqUaJcGfaAqFZY9NBHCoNFtVKjx/XLVyZsJH0rR+s7wqgqFzfbOFkuurBWw/?=
 =?us-ascii?Q?e7Xl/KOzBPcNf9/NKHnppZcPy1W4w5MmSGMKhRxHhtAG4761Zgt46wOenvXh?=
 =?us-ascii?Q?cimUDdmCNYO8Tts7ZrFlcM5ENDnkVAvfOZ6vxPoRs6eCLMVXH/AX6JQ0+Dsl?=
 =?us-ascii?Q?O8TsVyVdv8D3RUI7+6lyWOcwFqiAjIyqvDcGTuPRXNCOKgvKAZROVLhnvLOD?=
 =?us-ascii?Q?R7+CocTuNYhTTiazxj+p8tnPbe3Jvd54ANwuhPNdM1oQvprwhPCN7FVOLseY?=
 =?us-ascii?Q?9P1BTZ/mQU4exqh8dXQijQSXQk7zeWeyQZhl/ayEsO83ASf2fRxPkZc/mezH?=
 =?us-ascii?Q?Q3WkYxTl7axZP8KV9K5E45ND02aCKU2Xj1WWJGMd29vl096QFPbCRNwQa801?=
 =?us-ascii?Q?3BtOZtcVNicPocWKwree/mms5irBQomXJm2FflOHk5vIJ+A1i0JlcYoKH1Fb?=
 =?us-ascii?Q?5Dxfi27sw30r6ZLOfraKmmOXdnkb9EHHanePgbTv2TYm1DNoVO7VkARc+Au2?=
 =?us-ascii?Q?vjUi0/N+p2D7psdlRgbqjhSihC9Gx7kfBJIiednGaixzTRCq3eIK/W3YMMrj?=
 =?us-ascii?Q?ujKx/8G4gbyQdXOtTzA3+BRrmF9LMyNpoYV+WHvJySZBBsRFs33p67MOEUTm?=
 =?us-ascii?Q?1Zju27+VlJ/vv0vO6nDKmgNczvcjUUbJ575fGZVMMVPMdHgayRXI0Pg021LM?=
 =?us-ascii?Q?VeCjjbWAYLgrB160F6zfATLFRfdMoAwB1zZkxGFckTDVRdL+/5JE81nGmsWy?=
 =?us-ascii?Q?rOVrqB0zLB/MHAHX6MxdqzJzrIhLuffztU7hiTs7FlMrhz6bBcCb5bVXSTk+?=
 =?us-ascii?Q?HxFg9q30URcFHzlPcmN4gJfWeBgwx8qZNJx7HN//+/3gWh3tYpmjvTF2Rcmt?=
 =?us-ascii?Q?b14TCUcz/E+R1IWT3IuhlIMSYL48JP8hY2erLZLXjUQjB2vPHDQL7kVORAtZ?=
 =?us-ascii?Q?p9P4o56wNy1qtOewzvwlG9R/KCKhPLj5cyO/bB5jSgRFNZlEQ2UZQ+svRdua?=
 =?us-ascii?Q?9RPytqOD56On7JX9USCC1huPQSeqAQKp3a93Ps1FQfub/sk1gso3cGQbas9o?=
 =?us-ascii?Q?KIIwjIeLBxHVMQZoSNbASySk55TV9T/q76Kyt+Ma?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812da2fd-7c02-4605-f580-08dbb8657741
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:36:53.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYV6qdv65pnzo0z60WAPA7uE9mWeHEY18hEcUuFzVKpo088frNKCN/jhNViMTtzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:58:05PM +0100, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out, which
> also helps hide the iommu_group_dev detail from places that don't need
> to know. Similarly, the safety check for dev_iommu_ops() at certain
> public interfaces starts looking a bit repetitive, and might not be
> completely obvious at first glance, so let's factor that out for clarity
> as well, in preparation for more uses of both.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Rename dev_iommu_ops_valid() to reflect what it's actually checking,
>     rather than an implied consequence.
> ---
>  drivers/iommu/iommu.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3bfc56df4f78..4566d0001cd3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -363,6 +363,15 @@ static void dev_iommu_free(struct device *dev)
>  	kfree(param);
>  }
>  
> +/*
> + * Internal equivalent of device_iommu_mapped() for when we care that a device
> + * actually has API ops, and don't want false positives from VFIO-only groups.
> + */
> +static bool dev_has_iommu(struct device *dev)
> +{
> +	return dev->iommu && dev->iommu->iommu_dev;
> +}

After having gone through all the locking here, I'd prefer to err on
the side of clearer documentation when it is actually safe to invoke
this.

I suggest

/* Use in driver facing APIs, API must only be called by a probed driver */
static inline const struct iommu_ops *dev_maybe_iommu_ops(struct device *dev)
{
	if (!dev->iommu || !dev->iommu_iommu_dev))
		return NULL;
	return dev_iommu_ops(dev);
}

Since only this:

>  static u32 dev_iommu_get_max_pasids(struct device *dev)
>  {
>  	u32 max_pasids = 0, bits = 0;
> @@ -614,7 +623,7 @@ static void __iommu_group_remove_device(struct device *dev)
>  
>  		list_del(&device->list);
>  		__iommu_group_free_device(group, device);
> -		if (dev->iommu && dev->iommu->iommu_dev)
> +		if (dev_has_iommu(dev))
>  			iommu_deinit_device(dev);
>  		else
>  			dev->iommu_group = NULL;

Uses a different rule, and it is safe for some pretty unique reasons.

The next patch doesn't follow these rules, I will add a note there..

> @@ -3190,21 +3203,18 @@ void iommu_device_unuse_default_domain(struct device *dev)
>  
>  static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
>  {
> -	struct group_device *dev =
> -		list_first_entry(&group->devices, struct group_device, list);
> +	struct device *dev = iommu_group_first_dev(group);
>  
>  	if (group->blocking_domain)
>  		return 0;
>  
> -	group->blocking_domain =
> -		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
> +	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
>  	if (!group->blocking_domain) {
>  		/*
>  		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
>  		 * create an empty domain instead.
>  		 */
> -		group->blocking_domain = __iommu_domain_alloc(
> -			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
>  		if (!group->blocking_domain)
>  			return -EINVAL;
>  	}

My identity domain series fixed this up by adding __iommu_group_domain_alloc()

Jason
