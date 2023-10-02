Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633207B54F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbjJBORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjJBORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:17:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEFDCE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP6e0FGFkTxRpreV3hajoktGbTKAd3WjBsci5KlKVbybCWbhjomt3xPbM9yo3qWMZkLnI4fFWaIYnTYI308D4qbj4+rd+VTk8rjScdXsh4xSzJxxq0GUZeCzVSW1ivCkl2E7YgWb0A58HGcrN3Xq7SyjgoMaStGcWU6bwqZddyhv/0w5P0GhV/B1mJOR1F6c0KNkPrsIx4b2U8IMW2mRR3DCZESC004jTUZnovRScD0GNkt9DRU5kBg2Jg8dFF0lTUZ04od762ukaSmduf74Dwv3nBFAOoJsGMmUzn6YxiCZRexqYEaBcpma7g9tCZ3iG78effZRegtm8Ad1w+I3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZLfYjoGrNR81gyADSk9PdeRbu/KSE+QeH55I3y7s+w=;
 b=avcG+gVaO8BB+8LZ7VL+rkbzIyq6UWui7ITh4W8B6ak0HKzEuTI6IOIkQRvLQqh/dJb1o+8tjhnUhVj3tu23Yp/ZRc49SJGt+mBv3b/sCCyifNiviBqJ6nku64rp3sJSDBXVM2nIsFPuZQaFTkJ7PXLKOHfPTVf+dR99Z+gu6vbHyVsg26+zN1T9CdqAmdfcpnB+UqcD09EM6lI+K/mhpD4fCLLljyRCvZg9LLqWIsPwzpn+LdDZ9sseZBc+7mOXFDJyI6kAvTA1JzzFT0ANvLkg4NBhI5YFYqCryffBc/VZgrkok5soLVTSnAmqWvJwBEhO7QpVkhBQJj9KVOCr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZLfYjoGrNR81gyADSk9PdeRbu/KSE+QeH55I3y7s+w=;
 b=e4b7MNjG5tPUZJ7BUvJ7M4SMA6c3Pd3cFvZeTLE4WBBfTQ4ft4312LICcxfIa4KP7EHUsx1KjbHQdr7zmQATYQBf+oTN7TpSArMlvUPAXKL2umLzEVLPWrt/NkFan7XG0bmdzGd6f61cdYFf50BGLCQ5kL7sk026LD4BDiMMa4hgK+GZqGNhh7tTvBWcAjJCv8PHcDKP+8DS+2hEBG/wAWJpklulltYsduD1AUOj5hjad5E3gUmqgAjsrcnG8pkBFmzDjC4sw6qIYXYnyF97gGUOzEx1ouK8J3xeQFKDI/3ysp0kg8wvzzQ4LWO1Vj4Gb5rRuGqdUzL/8J7XWqeh5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Mon, 2 Oct
 2023 14:17:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 14:17:07 +0000
Date:   Mon, 2 Oct 2023 11:17:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <20231002141704.GG339126@nvidia.com>
References: <cover.1696253096.git.robin.murphy@arm.com>
 <c734557f46fa5ea79b766ce847b003e31096d0bb.1696253096.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c734557f46fa5ea79b766ce847b003e31096d0bb.1696253096.git.robin.murphy@arm.com>
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: bf514e74-7f80-4d25-d096-08dbc3524259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl0AXRg3vp0IbwTvQvlKqGvmx24k+sY4hps4eoWu6FzyT2eCZ2F/FCkUJalrbCQoD0XcwRwiyKF4rg2FsyLoT50ldN43D1G4vjWNnGmVCQtAyhkQQtnSnhqwRT+8YcW1/r5jQi6665SJ8hJwdXJ3PfSOTUqo2LVHbXIMYQ6bQenKLlRjQIIKUw4FiSz8vMbeXaLsNSlfrIHYm5bgxi6yNINuhSoHufCv0wPOEDkA5jkH+L5l17G9QfX7eOUUtjC+fNpViyNjn3cs//I9nuSq+GaoRmlverbM5OoTO0rFbYKLVknzm34IR2tD6NATeOtXTewMvbiLsd5IrLEHEIk0MfJh+32AaCtNxXtlh/C5KtsT9TjhfCwXlOBViKw4WZhY0lHFyFkJb2OZHNCa8wQinYA07ZSI7PxbVnDHA4sIsvwrT31/Tb899BlCaU0jBP9O4SZ0HqFw5fsMb3nag8MrRsES/1x52xYPTVqIp66v8lzSuB3cGw+xRiAjkmtN5cmOh/UFnchViUGtJgMxQ2irNsBBfcmZdfrKQ2Azvhnol2JQCs54BlXK8+hPq8J829mnrIFKNPpm1/qwRbftFJc8Ukbx0tRN9j6K3yB3CMMSC2bijUQcfnyIum4V7E7w4dlB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(478600001)(6506007)(6486002)(6666004)(38100700002)(86362001)(1076003)(83380400001)(2616005)(26005)(6512007)(2906002)(33656002)(316002)(6916009)(41300700001)(36756003)(66556008)(66946007)(8676002)(66476007)(8936002)(5660300002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIVrlFZHg3auLQcHqnG8vNofL/8s9ls5fpvNmvfG91VB+B5V0aEGbMfZIzSH?=
 =?us-ascii?Q?wSReNtMp1afeEnKNqL2O5zDBCkpM0PHtrEDZ4qPuTnG7CmWumf/CF1mTmud6?=
 =?us-ascii?Q?dTwTIQktjm/vjCkwxLpEUChB8r+Pxr+oca6qPEjYEX0Q9QAFAEpIFsFoU4kh?=
 =?us-ascii?Q?dWDLYxQxUJUbYhiaHdzZ/fJ4AKLZG8/g6al2HExbjjSLy9Mibr01MsiinCa7?=
 =?us-ascii?Q?SNLH5jF7gUbydCaggsvC2kuPrb5o82donQDkkXcTFF8DvBtrI8hvOwdVdp9u?=
 =?us-ascii?Q?dAvHzRhmYHCKzYtA6c+uW3xr63stN9ahqPzg5xwrqq6UuAJMQVugDtFGqP8V?=
 =?us-ascii?Q?QkQFJVRDbgGGdMB1ZyPn6whkXBKsN5DpRGaipRSUdcog+P7GvRMxS5ZPFOqv?=
 =?us-ascii?Q?KpmDLd+iQ14bPOoPItSn8Mxc3FTgdTNjIVFBw6MCFPOa8idU1Hb4Tj4d0sfO?=
 =?us-ascii?Q?0QF7QqokDVp7nM/wTSLJhHhYrDkoGS/O+POtgFfcNNTs2B1VEGmqux7QVMg7?=
 =?us-ascii?Q?dJ6j9ZNR+DLp6yUsCoQyA08Q89avS1ljLz8fH+wNVKyjp7tHmYk5EyUzM7mk?=
 =?us-ascii?Q?hd309dUfgMpIHbdFK/ou3LDX9veEigCwb3+VhMKr8Qk9ciioRSJXxV/y+zFm?=
 =?us-ascii?Q?LEAEnndmdJoVte9fbhfDSrO7EceiFGiE3dAc00VIWXo5cmMAwPqPJ0WMddNW?=
 =?us-ascii?Q?N2sQQKaSK9+3OKN9eK5LB/7t5l0qFrcvtYDsxAOt1UuFwzZPMEMakJC7a+HY?=
 =?us-ascii?Q?5T+lSOwOhJH72hyvU3OJs935kFdsZzEzc6qUPUG8q8Mbekkz8aWFw5CiF5sU?=
 =?us-ascii?Q?prkL2uEuP1S7pnWhK7yrfeTRWjy4tUJhZ+NLAJPZlidCaJDD7kVy4Am/12g/?=
 =?us-ascii?Q?cx1BxDfJh+wsrsMpL4nsqrc7fW4kNJyLEE+LgBHxeM7Ji7qGi28hWvj8Gbz/?=
 =?us-ascii?Q?fPsg5/9T62MNNv+VsKS1N9ymqWvfcHA+fuRGaSoIMf8aRCPhd4OAjBiaYcfl?=
 =?us-ascii?Q?wmbzC+SRYFqTFm3/GRfLdMh+RuGMSt+F4AamauhIw831ClLnPSMMadM3bguM?=
 =?us-ascii?Q?WSb0iipv2CNwWve7gTpdY1wet55imW9IY7Vq9lPB1RySQ3bC/G/tzhMd7nmA?=
 =?us-ascii?Q?s86dZqL2r097/u1AlUPVUBzy0lbc6czyPhjdVSKhjCCW4+hfNKGdaIIO+K92?=
 =?us-ascii?Q?elNTtX8vk2FIEfRV8GdRJGbAJiSJej9bAUiyqB/7NswKGHinhq0hbN48Lh2b?=
 =?us-ascii?Q?+sFJ9/qPPhaU9uswdUbUxPbHRHikniXIX+47C8A6a6Ipl/K0t5k5Sz0wFj/x?=
 =?us-ascii?Q?xUCRS/brx14vKV3FrCzGfBtiWJ+5cNJ9zdqxRO+FTI6HqvSxNXssRjqYDD2t?=
 =?us-ascii?Q?wnbXQzQQCTLNdz7um7g48KzsSsN8Go2RgGgg3CNANzSmZ+0Zht4nbqtKZaIF?=
 =?us-ascii?Q?OJVDpzQLa2CupgwdanNrJ74oGaZm5qo9PpPF+aHmiOe14aNGbKiMQSevW2sn?=
 =?us-ascii?Q?7MQXziDz9dpNUBsq2EHuQkLvE9DJavFrVrcuCEtV3l11uA7roNKx0vM9s2qb?=
 =?us-ascii?Q?4/Rsmh+e3cbau5SEdqqRzFiLdPnCe3GQgjtC+cfa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf514e74-7f80-4d25-d096-08dbc3524259
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:17:07.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N91d+Rgp72at5h6ytWwVzCUCHdheGLEl4w98JeQC6cXdPbHTwtQbblB4l5qOZsZs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:49:10PM +0100, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down the
> road and just rework it to preserve the current behaviour without
> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
> to IOMMU device registration"), any registered IOMMU instance is already
> considered "present" for every entry in iommu_buses, so it's simply a
> case of validating the bus and checking we have at least once IOMMU.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Tweak to use the ops-based check rather than group-based, to
>     properly match the existing behaviour
> v4: Just look for IOMMU instances instead of managed devices
> ---
>  drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f7793d1b5c3e..ef7feb0acc34 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1988,9 +1988,28 @@ int bus_iommu_probe(const struct bus_type *bus)
>  	return 0;
>  }
>  
> +/**
> + * iommu_present() - make platform-specific assumptions about an IOMMU
> + * @bus: bus to check
> + *
> + * Do not use this function. You want device_iommu_mapped() instead.
> + *
> + * Return: true if some IOMMU is present and aware of devices on the given bus;
> + * in general it may not be the only IOMMU, and it may not have anything to do
> + * with whatever device you are ultimately interested in.
> + */
>  bool iommu_present(const struct bus_type *bus)
>  {
> -	return bus->iommu_ops != NULL;
> +	bool ret = false;
> +
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		if (iommu_buses[i] == bus) {
> +			spin_lock(&iommu_device_lock);
> +			ret = !list_empty(&iommu_device_list);
> +			spin_unlock(&iommu_device_lock);
> +		}

Add here:

return ret;

> +	}
> +	return ret;

And this becomes

return false

?

Regardless

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
