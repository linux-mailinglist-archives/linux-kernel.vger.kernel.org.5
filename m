Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9A67790D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHKNcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjHKNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:32:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7728B30D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:32:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C66E113E;
        Fri, 11 Aug 2023 06:33:30 -0700 (PDT)
Received: from [10.57.1.174] (unknown [10.57.1.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E63A3F6C4;
        Fri, 11 Aug 2023 06:32:46 -0700 (PDT)
Message-ID: <9582503d-6d48-e5e8-6eb0-a170eb0c1150@arm.com>
Date:   Fri, 11 Aug 2023 14:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH 1/2] iommu/iova: Add check for cpu_rcache in
 free_iova_rcaches
Content-Language: en-GB
To:     Zhang Zekun <zhangzekun11@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, robh@kernel.org, nicolinc@nvidia.com,
        john.g.garry@oracle.com, kevin.tian@intel.com
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
 <20230811130246.42719-2-zhangzekun11@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230811130246.42719-2-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-11 14:02, Zhang Zekun wrote:
> free_iova_rcaches() needs to check if cpu_rcache->loaded and
> cpu_rcache->prev is NULL before freeing them.

Why? iova_magazine_free() is just kfree(), and kfree(NULL) is perfectly 
valid, specifically to avoid having to make cleanup paths all fiddly and 
overcomplicated like this.

Thanks,
Robin.

> Because
> iova_domain_init_rcaches() may fail to alloc magazine for
> cpu_rcache->loaded and cpu_rcache->prev, but they will be freed
> for all cpus.
> 
> Fixes: 32e92d9f6f87 ("iommu/iova: Separate out rcache init")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   drivers/iommu/iova.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 10b964600948..3c784a28e9ed 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -746,8 +746,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   
>   			spin_lock_init(&cpu_rcache->lock);
>   			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
> +			if (!cpu_rcache->loaded) {
> +				ret = -ENOMEM;
> +				goto out_err;
> +			}
>   			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> -			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
> +			if (!cpu_rcache->prev) {
>   				ret = -ENOMEM;
>   				goto out_err;
>   			}
> @@ -903,7 +907,11 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   			break;
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +			if (!cpu_rcache->loaded)
> +				break;
>   			iova_magazine_free(cpu_rcache->loaded);
> +			if (!cpu_rcache->prev)
> +				break;
>   			iova_magazine_free(cpu_rcache->prev);
>   		}
>   		free_percpu(rcache->cpu_rcaches);
