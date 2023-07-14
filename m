Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D98753296
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjGNHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGNHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:09:38 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967511D;
        Fri, 14 Jul 2023 00:09:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R2MzS3xBBz4f3lwv;
        Fri, 14 Jul 2023 15:09:24 +0800 (CST)
Received: from [10.67.110.48] (unknown [10.67.110.48])
        by APP3 (Coremail) with SMTP id _Ch0CgBnTQuj9LBk4Y+8Mw--.45485S2;
        Fri, 14 Jul 2023 15:09:24 +0800 (CST)
Message-ID: <11e0a7af-ed31-3ac9-29ca-335dea05a730@huaweicloud.com>
Date:   Fri, 14 Jul 2023 15:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com, Julian Pidancet <julian.pidancet@oracle.com>
References: <20230626031835.2279738-1-gongruiqi@huaweicloud.com>
 <b0ff727a-e4bf-ed25-56fe-62860f198dce@suse.cz>
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
In-Reply-To: <b0ff727a-e4bf-ed25-56fe-62860f198dce@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBnTQuj9LBk4Y+8Mw--.45485S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF43GF1DWF4kWF1fGF13XFb_yoW3Wr13p3
        yUZr9rJ3yqgFy7Crn5uayF93WfZw4rK3yYkw13Wr4kuF4UXw10gFWDXrWrur1DXFn8Ca4x
        JF1q9r92qasxW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFYFCUUUUU
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/07/13 20:46, Vlastimil Babka wrote:
> 
> On 6/26/23 05:18, GONG, Ruiqi wrote:
>> When exploiting memory vulnerabilities, "heap spraying" is a common
>> technique targeting those related to dynamic memory allocation (i.e. the
>> "heap"), and it plays an important role in a successful exploitation.
>> Basically, it is to overwrite the memory area of vulnerable object by
>> triggering allocation in other subsystems or modules and therefore
>> getting a reference to the targeted memory location. It's usable on
>> various types of vulnerablity including use after free (UAF), heap out-
>> of-bound write and etc.
>>
>> There are (at least) two reasons why the heap can be sprayed: 1) generic
>> slab caches are shared among different subsystems and modules, and
>> 2) dedicated slab caches could be merged with the generic ones.
>> Currently these two factors cannot be prevented at a low cost: the first
>> one is a widely used memory allocation mechanism, and shutting down slab
>> merging completely via `slub_nomerge` would be overkill.
> 
> Interesting :) Here's a recent patch to make slub_nomerge a default:
> https://lore.kernel.org/all/20230629221910.359711-1-julian.pidancet@oracle.com/
> 
> In v1, Kees said he's been running with that for ages:
> https://lore.kernel.org/all/202306281358.E6E6C2759@keescook/
> 
> So it's not universally accepted in the kernel hardening community?
> 

Thanks for the information! I'm not sure if the slub merging is that
much unwelcomed in the hardening community, since I don't see hardening
folks complaining a lot about it. I personally don't hate it as it does
bring benefits for the performance, at least theoretically (e.g. keeping
cache hot, reducing internal fragments etc.).

> [...]
> 
> Here's the renumbering diff. It assumes SLUB_TINY would be excluded as
> suggested, otherwise more adjustment would be needed for KMALLOC_RECLAIM.
> 
> ----8<----
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 96fdfd96b708..2f6337361515 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -347,10 +347,10 @@ static inline unsigned int arch_slab_minalign(void)
>                                 (KMALLOC_MIN_SIZE) : 16)
>  
>  #ifdef CONFIG_RANDOM_KMALLOC_CACHES
> -#define RANDOM_KMALLOC_CACHES_NR	16 // # of cache copies
> +#define RANDOM_KMALLOC_CACHES_NR	15 // # of extra cache copies
>  #define RANDOM_KMALLOC_CACHES_BITS	4  // =log2(_NR), for hashing
>  #else
> -#define RANDOM_KMALLOC_CACHES_NR	1
> +#define RANDOM_KMALLOC_CACHES_NR	0
>  #endif
>  
>  /*
> @@ -362,15 +362,15 @@ static inline unsigned int arch_slab_minalign(void)
>   * kmem caches can have both accounted and unaccounted objects.
>   */
>  enum kmalloc_cache_type {
> -	KMALLOC_RANDOM_START = 0,
> -	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + RANDOM_KMALLOC_CACHES_NR - 1,
> -	KMALLOC_NORMAL = KMALLOC_RANDOM_END,
> +	KMALLOC_NORMAL = 0,
>  #ifndef CONFIG_ZONE_DMA
>  	KMALLOC_DMA = KMALLOC_NORMAL,
>  #endif
>  #ifndef CONFIG_MEMCG_KMEM
>  	KMALLOC_CGROUP = KMALLOC_NORMAL,
>  #endif
> +	KMALLOC_RANDOM_START = KMALLOC_NORMAL,
> +	KMALLOC_RANDOM_END = KMALLOC_RANDOM_START + RANDOM_KMALLOC_CACHES_NR,
>  #ifdef CONFIG_SLUB_TINY
>  	KMALLOC_RECLAIM = KMALLOC_NORMAL,
>  #else
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a1a111ca229c..0479037b2959 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -784,22 +784,21 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #ifdef CONFIG_RANDOM_KMALLOC_CACHES
>  #define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
>  #define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
> -#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  0] = "kmalloc-rnd-01-" #sz,
> -#define KMA_RAND_2(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-rnd-02-" #sz,
> -#define KMA_RAND_3(sz)  KMA_RAND_2(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-rnd-03-" #sz,
> -#define KMA_RAND_4(sz)  KMA_RAND_3(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-rnd-04-" #sz,
> -#define KMA_RAND_5(sz)  KMA_RAND_4(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-rnd-05-" #sz,
> -#define KMA_RAND_6(sz)  KMA_RAND_5(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-rnd-06-" #sz,
> -#define KMA_RAND_7(sz)  KMA_RAND_6(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-rnd-07-" #sz,
> -#define KMA_RAND_8(sz)  KMA_RAND_7(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-rnd-08-" #sz,
> -#define KMA_RAND_9(sz)  KMA_RAND_8(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-rnd-09-" #sz,
> -#define KMA_RAND_10(sz) KMA_RAND_9(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-rnd-10-" #sz,
> -#define KMA_RAND_11(sz) KMA_RAND_10(sz) .name[KMALLOC_RANDOM_START + 10] = "kmalloc-rnd-11-" #sz,
> -#define KMA_RAND_12(sz) KMA_RAND_11(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-rnd-12-" #sz,
> -#define KMA_RAND_13(sz) KMA_RAND_12(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-rnd-13-" #sz,
> -#define KMA_RAND_14(sz) KMA_RAND_13(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-rnd-14-" #sz,
> -#define KMA_RAND_15(sz) KMA_RAND_14(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-rnd-15-" #sz,
> -#define KMA_RAND_16(sz) KMA_RAND_15(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-rnd-16-" #sz,
> +#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-rnd-01-" #sz,
> +#define KMA_RAND_2(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-rnd-02-" #sz,
> +#define KMA_RAND_3(sz)  KMA_RAND_2(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-rnd-03-" #sz,
> +#define KMA_RAND_4(sz)  KMA_RAND_3(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-rnd-04-" #sz,
> +#define KMA_RAND_5(sz)  KMA_RAND_4(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-rnd-05-" #sz,
> +#define KMA_RAND_6(sz)  KMA_RAND_5(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-rnd-06-" #sz,
> +#define KMA_RAND_7(sz)  KMA_RAND_6(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-rnd-07-" #sz,
> +#define KMA_RAND_8(sz)  KMA_RAND_7(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-rnd-08-" #sz,
> +#define KMA_RAND_9(sz)  KMA_RAND_8(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-rnd-09-" #sz,
> +#define KMA_RAND_10(sz) KMA_RAND_9(sz)  .name[KMALLOC_RANDOM_START + 10] = "kmalloc-rnd-10-" #sz,
> +#define KMA_RAND_11(sz) KMA_RAND_10(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-rnd-11-" #sz,
> +#define KMA_RAND_12(sz) KMA_RAND_11(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-rnd-12-" #sz,
> +#define KMA_RAND_13(sz) KMA_RAND_12(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-rnd-13-" #sz,
> +#define KMA_RAND_14(sz) KMA_RAND_13(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-rnd-14-" #sz,
> +#define KMA_RAND_15(sz) KMA_RAND_14(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-rnd-15-" #sz,
>  #else // CONFIG_RANDOM_KMALLOC_CACHES
>  #define KMALLOC_RANDOM_NAME(N, sz)
>  #endif
> @@ -957,7 +956,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	/*
>  	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
>  	 */
> -	for (type = KMALLOC_RANDOM_START; type < NR_KMALLOC_TYPES; type++) {
> +	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
>  				new_kmalloc_cache(i, type, flags);
> 
> 

I've adjusted the code according to all suggestions I received and sent
out the v5 patch. Thanks for the comments!

