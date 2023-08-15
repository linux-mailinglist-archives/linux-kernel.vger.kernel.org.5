Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31EB77CDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjHOOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbjHOOL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:11:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140841B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:11:55 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQCpd2Y0JzrSRN;
        Tue, 15 Aug 2023 22:10:33 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 22:11:52 +0800
Message-ID: <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
Date:   Tue, 15 Aug 2023 22:11:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH 2/2] iommu/iova: Manage the depot list size
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <john.g.garry@oracle.com>,
        <joro@8bytes.org>
References: <cover.1692033783.git.robin.murphy@arm.com>
 <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/15 1:53, Robin Murphy 写道:
> Automatically scaling the depot up to suit the peak capacity of a
> workload is all well and good, but it would be nice to have a way to
> scale it back down again if the workload changes. To that end, add
> automatic reclaim that will gradually free unused magazines if the
> depot size remains above a reasonable threshold for long enough.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d2de6fb0e9f4..76a7d694708e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -11,6 +11,7 @@
>   #include <linux/smp.h>
>   #include <linux/bitops.h>
>   #include <linux/cpu.h>
> +#include <linux/workqueue.h>
>   
>   /* The anchor node sits above the top of the usable address space */
>   #define IOVA_ANCHOR	~0UL
> @@ -626,6 +627,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    */
>   #define IOVA_MAG_SIZE 127
>   
> +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> +
>   struct iova_magazine {
>   	/*
>   	 * Only full magazines are inserted into the depot, so we can avoid
> @@ -646,8 +649,11 @@ struct iova_cpu_rcache {
>   
>   struct iova_rcache {
>   	spinlock_t lock;
> +	unsigned int depot_size;
>   	struct iova_magazine *depot;
>   	struct iova_cpu_rcache __percpu *cpu_rcaches;
> +	struct iova_domain *iovad;
> +	struct delayed_work work;
>   };
>   
>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> @@ -728,6 +734,7 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
>   
>   	rcache->depot = mag->next;
>   	mag->size = IOVA_MAG_SIZE;
> +	rcache->depot_size--;
>   	return mag;
>   }
>   
> @@ -735,6 +742,24 @@ static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *ma
>   {
>   	mag->next = rcache->depot;
>   	rcache->depot = mag;
> +	rcache->depot_size++;
> +}
> +
> +static void iova_depot_work_func(struct work_struct *work)
> +{
> +	struct iova_rcache *rcache = container_of(work, typeof(*rcache), work.work);
> +	struct iova_magazine *mag = NULL;
> +
> +	spin_lock(&rcache->lock);
> +	if (rcache->depot_size > num_online_cpus())
> +		mag = iova_depot_pop(rcache);
> +	spin_unlock(&rcache->lock);
> +
> +	if (mag) {
> +		iova_magazine_free_pfns(mag, rcache->iovad);
> +		iova_magazine_free(mag);
> +		schedule_delayed_work(&rcache->work, msecs_to_jiffies(IOVA_DEPOT_DELAY));
Hi, Robin,

I am a little confused why IOVA_DEPOT_DELAY need to be calculated twice 
in iova_depot_work_func(), as it already equals to 
"msecs_to_jiffies(100)". Besides, do we really need to invoke a 
delayed_work in iova_depot_work_func()? As each time we put a iova 
magazine to depot, a delayed_work will be invoked which is reponsible to 
free a iova magazine in depot if the depot size is greater than 
num_online_cpus().

Thanks,
Zekun
