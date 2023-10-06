Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661567BBD2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjJFQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjJFQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:46:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A9F116
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:46:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA282C15;
        Fri,  6 Oct 2023 09:46:41 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035C03F5A1;
        Fri,  6 Oct 2023 09:46:00 -0700 (PDT)
Message-ID: <6a049f36-f0eb-4ae4-a257-7d72b723f0c7@arm.com>
Date:   Fri, 6 Oct 2023 17:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/smmu-v3: Refactor smmu stream data structure
Content-Language: en-GB
To:     Dawei Li <set_pte_at@outlook.com>, will@kernel.org, joro@8bytes.org
Cc:     jgg@ziepe.ca, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <TYTP286MB3564A9E3854CACDEE366D59DCAC9A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <TYTP286MB3564A9E3854CACDEE366D59DCAC9A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-06 15:56, Dawei Li wrote:
> The relationship between stream ID and stream can be abstracted in K-V
> mappings, in which stream is identified uniquely by ID, but with notes
> below:
> 
> <1> The number of streams is varied.
> <2> The stream IDs are not necessarily contigeous, they can be sparsely
>      ranged.
> 
> Xarray is a data structure which can deal with interger-pointer mapping
> in cache-friendly way.

Cache effects shouldn't really matter here, however last time it came 
up[1] there was a question of memory consumption increasing. Have you 
tested the difference in performance and memory overhead, and if so, on 
what size of system?

> Compared with current rbtree implementation, xarray are more handy for
> index-orinted operations:
> <1> Find/locate an entry based on a key  //xa_load
> <2> Associating a key with an entry. //xa_insert
> 
> Rbtree version for ops above will be cumbersome, for it is implementer's

"will be" ? AFAICS it's already implemented, and judging by the diffstat 
below it wasn't all that bad really ;)

> duty to specify full logic of lookup, such as key comparision and so on.
> 
> As such, re-implement mapping between stream ID and streams from rbtree to
> xarray.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 ++++++---------------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +-
>   2 files changed, 16 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bd0a596f9863..31cf1c0d0a88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -489,7 +489,6 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
>   	local_irq_restore(flags);					\
>   })
>   
> -
>   /*
>    * Command queue insertion.
>    * This is made fiddly by our attempts to achieve some sort of scalability
> @@ -1446,23 +1445,13 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>   static struct arm_smmu_master *
>   arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>   {
> -	struct rb_node *node;
>   	struct arm_smmu_stream *stream;
>   
>   	lockdep_assert_held(&smmu->streams_mutex);
>   
> -	node = smmu->streams.rb_node;
> -	while (node) {
> -		stream = rb_entry(node, struct arm_smmu_stream, node);
> -		if (stream->id < sid)
> -			node = node->rb_right;
> -		else if (stream->id > sid)
> -			node = node->rb_left;
> -		else
> -			return stream->master;
> -	}
> +	stream = xa_load(&smmu->streams, sid);
>   
> -	return NULL;
> +	return stream ? stream->master : NULL;
>   }
>   
>   /* IRQ and event handlers */
> @@ -2573,11 +2562,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
>   static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>   				  struct arm_smmu_master *master)
>   {
> -	int i;
> -	int ret = 0;
> -	struct arm_smmu_stream *new_stream, *cur_stream;
> -	struct rb_node **new_node, *parent_node = NULL;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
> +	struct arm_smmu_stream *new_stream;
> +	int ret = 0;
> +	int i;
>   
>   	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
>   				  GFP_KERNEL);
> @@ -2597,34 +2585,18 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>   		if (ret)
>   			break;
>   
> -		/* Insert into SID tree */
> -		new_node = &(smmu->streams.rb_node);
> -		while (*new_node) {
> -			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
> -					      node);
> -			parent_node = *new_node;
> -			if (cur_stream->id > new_stream->id) {
> -				new_node = &((*new_node)->rb_left);
> -			} else if (cur_stream->id < new_stream->id) {
> -				new_node = &((*new_node)->rb_right);
> -			} else {
> -				dev_warn(master->dev,
> -					 "stream %u already in tree\n",
> -					 cur_stream->id);
> -				ret = -EINVAL;
> -				break;
> -			}
> -		}
> -		if (ret)
> +		ret = xa_insert(&smmu->streams, sid, new_stream, GFP_KERNEL);
> +		if (ret) {
> +			if (ret == -EBUSY)
> +				dev_warn(master->dev, "stream %u already binded\n",

Nit: "bound", however I think "in use" would be even better, to avoid 
confusion with SVA terminology.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/ecb3725c-27c4-944b-b42c-f4e293521f94@arm.com/

> +					 sid);
>   			break;
> -
> -		rb_link_node(&new_stream->node, parent_node, new_node);
> -		rb_insert_color(&new_stream->node, &smmu->streams);
> +		}
>   	}
>   
>   	if (ret) {
>   		for (i--; i >= 0; i--)
> -			rb_erase(&master->streams[i].node, &smmu->streams);
> +			xa_erase(&smmu->streams, master->streams[i].id);
>   		kfree(master->streams);
>   	}
>   	mutex_unlock(&smmu->streams_mutex);
> @@ -2643,7 +2615,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>   
>   	mutex_lock(&smmu->streams_mutex);
>   	for (i = 0; i < fwspec->num_ids; i++)
> -		rb_erase(&master->streams[i].node, &smmu->streams);
> +		xa_erase(&smmu->streams, master->streams[i].id);
>   	mutex_unlock(&smmu->streams_mutex);
>   
>   	kfree(master->streams);
> @@ -3097,7 +3069,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>   	int ret;
>   
>   	mutex_init(&smmu->streams_mutex);
> -	smmu->streams = RB_ROOT;
> +	xa_init(&smmu->streams);
>   
>   	ret = arm_smmu_init_queues(smmu);
>   	if (ret)
> @@ -3913,6 +3885,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
>   	arm_smmu_device_disable(smmu);
>   	iopf_queue_free(smmu->evtq.iopf);
>   	ida_destroy(&smmu->vmid_map);
> +	xa_destroy(&smmu->streams);
>   }
>   
>   static void arm_smmu_device_shutdown(struct platform_device *pdev)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 9915850dd4db..f500754d4fbe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -680,14 +680,13 @@ struct arm_smmu_device {
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
>   
> -	struct rb_root			streams;
> +	struct xarray			streams;
>   	struct mutex			streams_mutex;
>   };
>   
>   struct arm_smmu_stream {
>   	u32				id;
>   	struct arm_smmu_master		*master;
> -	struct rb_node			node;
>   };
>   
>   /* SMMU private data for each master */
