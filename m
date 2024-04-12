Return-Path: <linux-kernel+bounces-142318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E408A2A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FA31F219A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06A50294;
	Fri, 12 Apr 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OVqy/QJV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791E50291
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911658; cv=none; b=buCavR48Ei7pN2t+c091PFToF8dnFwAZElOPD1zzr1wWV6GOSpkY6sjIz8oHJ4zuCOnccIynLB3BVZ5SgaB2FQLTeLPGCl6k2gePL7le6Go3bT7VlDnn/I0Afop1rInTU5sJh9Zoqz9OljjKMEhjrL/ft9gHFEL0YabyqGJK9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911658; c=relaxed/simple;
	bh=VpIqXvjhXyF3eIw9HJGdlR+EucOZ9lzjocmVT/oYmcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QISoRZXA2TwSNBKJ0GX6pyFlB9PTPFvVCBBLgdtzlY8rayFzhF2bovY1LD+mYGQ/O5uCaSyuaucGCW6Enm4CM/idu7tbQQ5gytTl+b4q7hQQ5PDOjhjBs4G+Te6z14MANTZvshKbXHz+w9WSJdpsuPRolYoxw1tCyBZyZa/9CHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OVqy/QJV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4f8a2b026so1578295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712911656; x=1713516456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6ysC/lfoTTvwlV3mc3WbVSv5d9bBjero909B69z+ZQ=;
        b=OVqy/QJVKWbpgb2WZqcCdprs0SQztn2EHvASpJiuwm2uimYtyz0ECP8Qsu5Mk2LOas
         3pRweIdnOQA+X20UpMMYD98KsKc+Zb2fNzykufttoFSvdpe9x3ZfXmwFq4EbwGTe8UHZ
         Q4IfcOu22tiMHMB1XeSneHXU6q+sFvP/Y6WSw9CYPjXS0bzgdyvdK8NbHxIzJdvEz6E1
         fY5iZZCpRFbNzItOF4aTNT4fgaKY/j6LzwRl66ahkzHNbqcOrl5yls7UGfqev0lX/E2w
         vOrY3ox83ANJIGq2Y9jxBtjgJPAu2tBZYqpTtZi5dfcsaLVcuy3oTZ6QQLykLVvLh//6
         m9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911656; x=1713516456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6ysC/lfoTTvwlV3mc3WbVSv5d9bBjero909B69z+ZQ=;
        b=bXT2qhKOO1yrhmU7Xvr1ySGO7NsZ0anda4AkBBgLC4N5gBCTwjd6nI4bV4EbomYNvn
         mDCj7pMIMcRaBBywF8MX4d6HX62qzlQiUyrHmdagx8vF6Ue0U1wvJGAKGGXK3LugChIV
         mJmTlYkCyfp1mnIqjb/u8VtTEg3wqR4VEMBvsd9JvIUNtiIJQ8ysylg6RnKwGpVMlbOn
         HlAn+Zn1HJaYznmTLSfPKgxebatpkES88sRXxB3tzu+k9OwMJgpwhEOBROFc/bzo80Xr
         ape6DgkSz+tiTxKle748MZD8+mT5+95owWYNT8zmNGerZLvE7CrJi9xXmMA8cIOinb+Z
         AI6A==
X-Forwarded-Encrypted: i=1; AJvYcCWL83mhUu88dpUm6HLG9W/1q1nrADdLsmYOmurorapOmq/m68hT0cXGlAATyCXOkosxzmygfYZaPKUrOgg4yN1/21NWj7tb4QKnbDAP
X-Gm-Message-State: AOJu0YzlqzpWatNZ/TeAd9HDHS8/PRclPfIdCbdjSxXlsvU3Wi9WWzc8
	h6QeIibIRK3JK05vSPI8bbUd8sownuGCSwDi0X+jCBlazXs2hJUMdX35lFQ5G/A=
X-Google-Smtp-Source: AGHT+IGXHCR7DkV2Qhp9EnIAwrmEKcmf9qAOdfy4XzgtY1646I6SP5pvyUHVAUz3Lr/p3J69gLG3ow==
X-Received: by 2002:a17:90a:db0f:b0:2a6:8e66:d585 with SMTP id g15-20020a17090adb0f00b002a68e66d585mr1849884pjv.4.1712911655796;
        Fri, 12 Apr 2024 01:47:35 -0700 (PDT)
Received: from [10.84.154.17] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090aa58800b002a574ab7f5esm2284129pjq.53.2024.04.12.01.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 01:47:35 -0700 (PDT)
Message-ID: <d78ec9ea-006a-4317-b0df-99ad31994b0d@bytedance.com>
Date: Fri, 12 Apr 2024 16:47:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
Content-Language: en-US
To: lipeifeng@oppo.com
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240412080706.744-1-lipeifeng@oppo.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240412080706.744-1-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peifeng,

On 2024/4/12 16:07, lipeifeng@oppo.com wrote:
> From: Peifeng Li <lipeifeng@oppo.com>
> 
> In the case of insufficient memory, threads will be in direct_reclaim to
> reclaim memory, direct_reclaim will call shrink_slab to run sequentially
> each shrinker callback. If there is a lock-contention in the shrinker
> callback,such as spinlock,mutex_lock and so on, threads may be likely to
> be stuck in direct_reclaim for a long time, even if the memfree has reached
> the high watermarks of the zone, resulting in poor performance of threads.
> 
> Example 1: shrinker callback may wait for spinlock
> static unsigned long mb_cache_shrink(struct mb_cache *cache,
>                                       unsigned long nr_to_scan)
> {
>          struct mb_cache_entry *entry;
>          unsigned long shrunk = 0;
> 
>          spin_lock(&cache->c_list_lock);
>          while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>                  entry = list_first_entry(&cache->c_list,
>                                           struct mb_cache_entry, e_list);
>                  if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
>                      atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
>                          clear_bit(MBE_REFERENCED_B, &entry->e_flags);
>                          list_move_tail(&entry->e_list, &cache->c_list);
>                          continue;
>                  }
>                  list_del_init(&entry->e_list);
>                  cache->c_entry_count--;
>                  spin_unlock(&cache->c_list_lock);
>                  __mb_cache_entry_free(cache, entry);
>                  shrunk++;
>                  cond_resched();
>                  spin_lock(&cache->c_list_lock);
>          }
>          spin_unlock(&cache->c_list_lock);
> 
>          return shrunk;
> }
> Example 2: shrinker callback may wait for mutex lock
> static
> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker *s,
> 		struct shrink_control *sc)
> {
> 	struct kbase_context *kctx;
> 	struct kbase_mem_phy_alloc *alloc;
> 	struct kbase_mem_phy_alloc *tmp;
> 	unsigned long freed = 0;
> 
> 	kctx = container_of(s, struct kbase_context, reclaim);
> 
> 	// MTK add to prevent false alarm
> 	lockdep_off();
> 
> 	mutex_lock(&kctx->jit_evict_lock);
> 
> 	list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, evict_node) {
> 		int err;
> 
> 		err = kbase_mem_shrink_gpu_mapping(kctx, alloc->reg,
> 				0, alloc->nents);
> 		if (err != 0) {
> 			freed = -1;
> 			goto out_unlock;
> 		}
> 
> 		alloc->evicted = alloc->nents;
> 
> 		kbase_free_phy_pages_helper(alloc, alloc->evicted);
> 		freed += alloc->evicted;
> 		list_del_init(&alloc->evict_node);
> 
> 		kbase_jit_backing_lost(alloc->reg);
> 
> 		if (freed > sc->nr_to_scan)
> 			break;
> 	}
> out_unlock:
> 	mutex_unlock(&kctx->jit_evict_lock);
> 
> 	// MTK add to prevent false alarm
> 	lockdep_on();
> 
> 	return freed;
> }
> 
> In mobile-phone,threads are likely to be stuck in shrinker callback during
> direct_reclaim, with example like the following:
> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
> 			dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
> 			dynamic_mem_shrink_scan+0x0/0xb8 ...
> 
> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM that
> allows driver to set shrinker callback not to be called in direct_reclaim
> unless sc->priority is 0.

Hmm, this is just a workaround, no shrinker will want to set this flag.
If a shrinker has a lock contention problem, then it needs to be fixed.

Perhaps executing do_shrink_slab() asynchronously may be a more
fundamental solution, but this may result in untimely reclamation.

> 
> The reason why sc->priority=0 allows shrinker callback to be called in
> direct_reclaim is for two reasons:
> 1.Always call all shrinker callback in drop_slab that priority is 0.
> 2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to call
> shrinker callback, to reclaim memory timely.
> 
> Note:
> 1.Register_shrinker_prepared() default not to set

This API is no longer included in the latest upstream code. Please
submit a patch based on the latest code.

Thanks,
Qi

> SHRINKER_NO_DIRECT_RECLAIM, to maintain the current behavior of the code.
> 2.Logic of kswapd and drop_slab to call shrinker callback isn't affected.
> 
> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
> ---
>   include/linux/shrinker.h |  5 +++++
>   mm/shrinker.c            | 36 ++++++++++++++++++++++++++++++++++--
>   2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a..2d5a8b3a720b 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -130,6 +130,11 @@ struct shrinker {
>    * non-MEMCG_AWARE shrinker should not have this flag set.
>    */
>   #define SHRINKER_NONSLAB	BIT(4)
> +/*
> + * Can shrinker callback be called in direct_relcaim unless
> + * sc->priority is 0?
> + */
> +#define SHRINKER_NO_DIRECT_RECLAIM	BIT(5)
>   
>   __printf(2, 3)
>   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..3ac50da72494 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>   			if (!memcg_kmem_online() &&
>   			    !(shrinker->flags & SHRINKER_NONSLAB))
>   				continue;
> -
> +			/*
> +			 * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
> +			 * should not be called in direct_reclaim unless priority
> +			 * is 0.
> +			 */
> +			if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
> +					!current_is_kswapd()) {
> +				/*
> +				 * 1.Always call shrinker callback in drop_slab that
> +				 * priority is 0.
> +				 * 2.sc->priority is 0 during direct_reclaim, allow
> +				 * direct_reclaim to call shrinker callback, to reclaim
> +				 * memory timely.
> +				 */
> +				if (priority)
> +					continue;
> +			}
>   			ret = do_shrink_slab(&sc, shrinker, priority);
>   			if (ret == SHRINK_EMPTY) {
>   				clear_bit(offset, unit->map);
> @@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>   			continue;
>   
>   		rcu_read_unlock();
> -
> +		/*
> +		 * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
> +		 * should not be called in direct_reclaim unless priority
> +		 * is 0.
> +		 */
> +		if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
> +				!current_is_kswapd()) {
> +			/*
> +			 * 1.Always call shrinker callback in drop_slab that
> +			 * priority is 0.
> +			 * 2.sc->priority is 0 during direct_reclaim, allow
> +			 * direct_reclaim to call shrinker callback, to reclaim
> +			 * memory timely.
> +			 */
> +			if (priority)
> +				continue;
> +		}
>   		ret = do_shrink_slab(&sc, shrinker, priority);
>   		if (ret == SHRINK_EMPTY)
>   			ret = 0;

