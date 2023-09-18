Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C587A50B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIRRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjIRRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:12:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9449D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntAP3j+qquNk6IwPl1xmvfjWh/Rek2AWCIKLLdEyCkMU1k03lHqvY4aD6S2tx1lj/4ihBKI6HI0G0e+sKYtHQSPir8pmK51vUh03wOCZlhVF21CNCthsISlIUH6qPooHapSoI5udB8rguFWU6HLG7ImkaLWiSjy66tw1BJH8BUaogDPI0KWgdRoXFM6SpbVMFZPP3Tw83JkRHdvL1vQtfS57RcwfpGv8sQB/raHLmq/ekN+kSK6f6x+1/U6f6fvya/wcMNZN+GinS+Rrpfm3Au7LehEty/3FAgsX1KYhL4ayZPp88q4dyzKm9JuBpyGmYXHIWyRIcof5bkF0aiQJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjwq5zmrGw6oU6OTTsDSj4VEEOByDUSicW8BHOACi3A=;
 b=k4lMyv1owiwpCT3ybBPAykzBRfylJOCJLkBTfIayKqijxExXpeqowsryCcjqhUj7/9iGfQ7FqncjGPMbXm/sY1enB+owl4R0Qp2I/Y2/aqUVPQ3aSK/ObDw1B8jy3MOGA5JYxhSMJrQKcxbkqIIqJVOML6myEcAJ78H0B4b4b4IBL6okNXsFsV53cFxoDYaISsgj8K3usIi1lBchJpC1ju/uiOhGeDyoneAlH0bcX35fThZlgMCuvtZ375woTCjpkn7vV0DhdnuiFO+06SrdIU0AuQjdU/PZDkUjUwJUb8fUFBNDaDdsMlRYQJQIjaMx17OMhUMiBDV6SWBIpj3m1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjwq5zmrGw6oU6OTTsDSj4VEEOByDUSicW8BHOACi3A=;
 b=rX3YPoNROrLwvhQnKwvLPTWqZy1Iz4wpPU2VlcX+cQWLhjOTNtIKZ+drcLPizDosp01jkUMz7PMGm3ML9V/WBvMKY5Wzn7usC1df4tFty/1m/MYpXBsU61pVPuffYkNqUxDA2NrSgelJuFyONtcJSG05jeH1Rx9HC97uTLsVOsqTlMTaiZdYxRqLkG7m/oaY7jqYOiHAUSyoyWEO4ESOemcb0A7xqWWOW80h6uMzqgUWIqFwwIvNTRFTGAdr6tLJER29PFOidjF/v+l3cQl0uiKt8FwVoEC9rMJ0bj4PQFUD1ra/T3hbmkIpeL+kl5JVxBq+p3A5PwspYjEljY4uGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 18 Sep
 2023 17:12:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:12:18 +0000
Date:   Mon, 18 Sep 2023 14:12:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 2/7] iommu: Decouple iommu_present() from bus ops
Message-ID: <20230918171216.GK13733@nvidia.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
 <b7cd933aa7774ad687c695ebe5e00c17178a7542.1694693889.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cd933aa7774ad687c695ebe5e00c17178a7542.1694693889.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0269.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b15352d-b0b1-46e9-1f99-08dbb86a69c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYq9fMoLwJeRArO7pePCysdNRSOK3MoUdML6aW4W+gPFXYh2QvvOT6xq+6tt/4Ib98YaiR2jFKURVVqIxsvjn8/VS1Kkdzo/Qkiw9wcYpAtihyHjsYwa3brB/pJP7+9S2lunSnb/oLrdN/5PQ7fpAmUa6bpIs4ufd1Kfz2eZjyfnAbfwUtYCxhZfiCia+FxgHbWQtFaKarfhkXJFKEipLfOtK8vUll6lE4/lrBNHuP1bkhrv/pdScQ/0F+XLbnsB+hg+81qPtaevoKlCrQeB19QDZjW5IcO/M1CCBXsGqOw46OilIUJaz2TnhM+POVWGo0vC0cj9TqTe2aQU8ReQSvSQE/MA1o5mbH6HBxL5I1k/Amq03wjnWMrT8suQ2ZF7G7rDQ8alOAPesk457vwAOKr9mJLhTVRNe+i7v2CFgGx/GbDjedKQbF+uaNyGptgVi4j4Aj2rEOjrXZ4g49PwUJAdcCJbJGY0FoAF9XeVvdJjv6HJ5i5AfnrCRJWSzHf3uQMYD4HEdzzcUO8hYBFTok0qYdLk6ySWSyhCzKRebj2keEvJ8IyiC/ZIyfFOFYVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(186009)(451199024)(1800799009)(2906002)(83380400001)(6506007)(33656002)(2616005)(1076003)(38100700002)(86362001)(6486002)(478600001)(6512007)(36756003)(8936002)(66556008)(8676002)(5660300002)(26005)(6916009)(4326008)(66476007)(66946007)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zixMIiWI2Xv6/eDvG0OnShUW302dKZ1oztPreLu/e+vy9N4ww9tSa584IytK?=
 =?us-ascii?Q?PB/qfDMUjmuE8TTEu4nj4W642XUxfzchZa3gf3PG8s56ik4faOdFP69khdG9?=
 =?us-ascii?Q?B0TbchOqf5K6zCmoo7+T4Y+iBaTIu4zw7YnrmhYvlLBVmaub2MUnarjX2/x4?=
 =?us-ascii?Q?P42K58O2ZlU/VUe3UI7fMSalFg9agJ1jR82Jpx9oaB3RbvmW4Gjw2wnuEUrH?=
 =?us-ascii?Q?SgH35i0jfd/3PYkNhE4jVI3xx/86qqbY96GWenKFrHbEhNpPT5QjZcPwLV7s?=
 =?us-ascii?Q?mYh4HBusNBmSwDr3k3Uakdaz0HBk3LBICeT4Nna1PgmqHXmkOnwYab6Xs97u?=
 =?us-ascii?Q?YV54faFiBniqL9U0+1mw813IroOS350SuO2xGVm8KKqkt4qts4fmMhZQILdl?=
 =?us-ascii?Q?D9czkb9pnaEKtHC/Yne5MxPkvBpKDS43fXaHrjU//BKRF1A2/KMA5BUVjrHd?=
 =?us-ascii?Q?EhP3Nf82Xl4w/DAudwpVzn4XuPtZA4d8tPLnWS5yXkXGt5VTta+fjj4u2j2D?=
 =?us-ascii?Q?Pjjdb2dZYorK2OPTY7gMLe/3qpjNI04bREHiLQEedzGadKtZDNEoFQTZ7onm?=
 =?us-ascii?Q?1yrKJI/lNVbFLuX42SFoWJN/+u+Gni9Bje+BUuFh2D38xLyJs3wZid6m4A4X?=
 =?us-ascii?Q?NyGEzb9JdjggMPU0WQkFuDk3tUrhfRksBOVSzfCd59aq9nesVncKxeL/fP5W?=
 =?us-ascii?Q?L4HsRO6NS/dwFMq8YF1WpWybj65jntFseIXvHWK8qshnnzW9ZvjJ/CT3nFIf?=
 =?us-ascii?Q?EiXlqdrd6M5vbr1s3LqSsNfzWL+t8Mmnq9roziu3+SGtTZxL3HzuulThMxo5?=
 =?us-ascii?Q?TNEQh9Lntww16RBqo1FeGUJmBmD85YIAx6tr0HMY3WBmv0WJQ5ut+HeCYV0P?=
 =?us-ascii?Q?7Wg42E6hfeFn/cHz/EeUEHrXWQ05+Qu6phIoYAep0Wf8qt0ok8E0IHStjqPV?=
 =?us-ascii?Q?5+SY4O14kl8pQc7LL9Y08eo9NybFPlbuFgaiYZm4XtVk8KUAfLk9ZEnz5dHu?=
 =?us-ascii?Q?Ov5oCN3/uUSH41BSB0IQb3kjdu/wKB0KTRoHRPRTHOtSBogyRcfTYych6ckv?=
 =?us-ascii?Q?m8KgY1fwsK4qB3CA46IwM2lGWhqbL36gGfZq2qIGOcy1Zf4JcyTuBj6FD+jK?=
 =?us-ascii?Q?KHWo/+fYjVV+4IxVkDi2gKjC1sbkXZUPBjLD8pJ6u6QzEuaimDUz+SHbXmLA?=
 =?us-ascii?Q?wytdJCnN1XLYTbpoUnk//nRgGevPA0ne9anP5adUmYT1HEc8G7wjlfs5t2gX?=
 =?us-ascii?Q?oAnk9XCa9OsYpWy1gDeom+dp+LbxV1wQ5Mu7ZUwq7KtYsRIAAub00TbzHhT+?=
 =?us-ascii?Q?ID3zbr8H6WYjJn3R7/1THzhJWnU89xCQXpCBlKWwXyDPckyDg1I4L018SAwP?=
 =?us-ascii?Q?SBuaXDGpbhF6MIb4donBzyqhjum7Qo0mA+pUqlOCZe2JN0upavqGGjpVug+P?=
 =?us-ascii?Q?11bYAHWt1r8ojjzCX+eFIGSVmS2kEDKm1jqUHQAhAjH/o1WMuhk9IgRV3MpP?=
 =?us-ascii?Q?2gT7X64Pgc+MSPaPj3+zfI3wCBWY4BQU/Wl9UQwO3utPrU4LbtjfXyAOOR+W?=
 =?us-ascii?Q?Fj/bJ2Uy1ccuHxC61QXoDxGXqp5T+xllN4wPcONP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b15352d-b0b1-46e9-1f99-08dbb86a69c1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:12:18.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXF87hTdksitFIhWKNp7eIAm676d65vqx48cC2ZgsLHqEvVbH8NiVg385khk1PYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:58:06PM +0100, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down
> the road and just rework it to preserve the current behaviour without
> depending on bus ops.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Tweak to use the ops-based check rather than group-based, to
>     properly match the existing behaviour
> ---
>  drivers/iommu/iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4566d0001cd3..2f29ee9dea64 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1907,9 +1907,24 @@ int bus_iommu_probe(const struct bus_type *bus)
>  	return 0;
>  }
>  
> +static int __iommu_present(struct device *dev, void *unused)
> +{
> +	return dev_has_iommu(dev);
> +}

This is not locked right..

Rather than perpetuate that, can we fix the two callers instead?

Maybe this for mtk:

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 93552d76b6e778..e7fe0e6f27de85 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -500,6 +500,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
                dev_err(drm->dev, "Need at least one OVL device\n");
                goto err_component_unbind;
        }
+       if (!device_iommu_mapped(dma_dev))
+               return -EPROBE_DEFER;
 
        for (i = 0; i < private->data->mmsys_dev_num; i++)
                private->all_drm_private[i]->dma_dev = dma_dev;
@@ -583,9 +585,6 @@ static int mtk_drm_bind(struct device *dev)
        struct drm_device *drm;
        int ret, i;
 
-       if (!iommu_present(&platform_bus_type))
-               return -EPROBE_DEFER;
-
        pdev = of_find_device_by_node(private->mutex_node);
        if (!pdev) {
                dev_err(dev, "Waiting for disp-mutex device %pOF\n",


? It doesn't seem to use the iommu API so I guess all it is doing is
trying to fix some kind of probe ordering issue? Maybe the probe
ordering issue is already gone and we can just delete the check?

And tegra:

	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
		tegra->domain = iommu_domain_alloc(&platform_bus_type);
		if (!tegra->domain) {

Lets do the same:

	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dev->dev.parent)) {

?

Alternatively how about:

bool iommu_present(void)
{
	bool ret;

	spin_lock(&iommu_device_lock);
	ret = !list_empty(&iommu_device_list);
	spin_unlock(&iommu_device_lock);
	return ret;
}
EXPORT_SYMBOL_GPL(iommu_present);

Since neither of the two users is really needing anything more than that?

Jason
