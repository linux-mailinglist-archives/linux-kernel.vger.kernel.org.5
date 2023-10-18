Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE07CD176
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjJRAwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjJRAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF9FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697590325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FK1HTlHJ+0l3R06vHMoTLhT2NX6e511ARHCQNoD5obE=;
        b=Mll2DxNOqBO9xcRILQUG8Dzx/vvkyh+vlqt5RR+p6A9+H7g/8g2blIl9EHgq2XdECSgYRk
        luHJfAglCJIDNChRD+ItI2VkuJSzFif/CJ+oLdPpQ4uSwNODfSFxW+VA9IvCe9Noe3zzjn
        IEemTQJ2acCsLouSlgJAnWj7gljJVno=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-MncavxcFMiWQ2xX8HXTwdg-1; Tue, 17 Oct 2023 20:52:03 -0400
X-MC-Unique: MncavxcFMiWQ2xX8HXTwdg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77892d78dd3so12532385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590323; x=1698195123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FK1HTlHJ+0l3R06vHMoTLhT2NX6e511ARHCQNoD5obE=;
        b=sCv/E0zrHplhVZ8U6XZ6GqzLF3p93WV82fZDCg9/LQSZi4EF/+6RJUMlcOlLc+jFan
         tvCeH4K4LBlo9b8WOMZ+Y51zxQuxvQoqGAYZXwy8c9bpZqdtoqjO1fUIj5QR+ANF7cKl
         DKhc4do36VCali3gdaQmxfIvxatuSoY5zrOGcPB0DLd7Qx4X4Pxq5IgvMHt7t6+rftPD
         gtrqHYFoIzVBhz3Jee9dW9Bi+bfc/51uoQDWkalPfZeAcrwfzugK6OfewE2KdnYUpcpt
         5Y5KZjRbj8yYimb36Qdj29S/WT9QOfeFJHxycAMxYKDPA9ArFtNh4N9byCNB/uNGHOCs
         BWeA==
X-Gm-Message-State: AOJu0Yx66Q/HaeTWiDHA5ipWmtecwMvMqF2wU7wPTbDorXSFzjIk9CkG
        43MuZ1QjSVGKYApgcH3ebTbNEufGhhK7TTN/gMpOGQWbWO1sJ9m0PkZtDuJ2Jr0mD0kg5+h7xWL
        EX231BP8lKTp5sNIzRoNe3Sipn1Flns/x
X-Received: by 2002:a05:620a:404b:b0:778:91ee:a9fb with SMTP id i11-20020a05620a404b00b0077891eea9fbmr775773qko.5.1697590323300;
        Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHir5AcRevEbyBxlM67AyCtcgYu4/8oXdFaF+eZVrQj0Vpe5aLV+xNdi/1ePelDyN7VpVyqQw==
X-Received: by 2002:a05:620a:404b:b0:778:91ee:a9fb with SMTP id i11-20020a05620a404b00b0077891eea9fbmr775761qko.5.1697590323028;
        Tue, 17 Oct 2023 17:52:03 -0700 (PDT)
Received: from [192.168.0.189] (pool-173-76-165-118.bstnma.fios.verizon.net. [173.76.165.118])
        by smtp.gmail.com with ESMTPSA id s17-20020ae9f711000000b0076f16e98851sm1077482qkg.102.2023.10.17.17.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 17:52:02 -0700 (PDT)
Message-ID: <f62c39ad-24a4-45e2-9f3e-52f033ac9807@redhat.com>
Date:   Tue, 17 Oct 2023 20:52:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20231013124758.1492796-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20231013124758.1492796-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Joe Mario <jmario@redhat.com>

Verified that block kworker threads no longer ran on isolated cpus.
Joe

On 10/13/23 8:47 AM, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
> for specific task, and user often won't want block IO to disturb these CPUs,
> also long IO latency may be caused if blk-mq kworker is scheduled on these
> isolated CPUs.
> 
> Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> the responsibility should be on wq user.
> 
> So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
> from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
> all CPUs in this hw queue are offline, this way can avoid any cost in fast
> IO code path.
> 
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Andrew Theurer <atheurer@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> Cc: Sebastian Jug <sejug@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove module parameter, meantime use queue map to check if
> 	all cpus in one hctx are offline
> 
>  block/blk-mq.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec922c6bccbe..91055bdc4426 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/blk-crypto.h>
>  #include <linux/part_stat.h>
> +#include <linux/sched/isolation.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -3476,14 +3477,27 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> -static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> -		struct blk_mq_hw_ctx *hctx)
> +static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx)
>  {
> -	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
> -		return false;
> -	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> -		return false;
> -	return true;
> +	struct blk_mq_tag_set *tag_set = hctx->queue->tag_set;
> +	int cpu;
> +
> +	/*
> +	 * hctx->cpumask has rule out isolated CPUs, but userspace still
> +	 * might submit IOs on these isolated CPUs, so use queue map to
> +	 * check if all CPUs mapped to this hctx are offline
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		unsigned idx = tag_set->map[hctx->type].mq_map[cpu];
> +
> +		if (idx != hctx->queue_num)
> +			continue;
> +
> +		if (cpu_online(cpu))
> +			return true;
> +	}
> +
> +	return false;
>  }
>  
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> @@ -3491,8 +3505,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> -	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +	if (blk_mq_hctx_has_online_cpu(hctx))
>  		return 0;
>  
>  	/*
> @@ -3900,6 +3913,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  	}
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> +		int cpu;
> +
>  		/*
>  		 * If no software queues are mapped to this hardware queue,
>  		 * disable it and free the request entries.
> @@ -3926,6 +3941,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  		 */
>  		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
>  
> +		/*
> +		 * rule out isolated CPUs from hctx->cpumask for avoiding to
> +		 * run wq worker on isolated CPU
> +		 */
> +		for_each_cpu(cpu, hctx->cpumask) {
> +			if (cpu_is_isolated(cpu))
> +				cpumask_clear_cpu(cpu, hctx->cpumask);
> +		}
> +
>  		/*
>  		 * Initialize batch roundrobin counts
>  		 */

