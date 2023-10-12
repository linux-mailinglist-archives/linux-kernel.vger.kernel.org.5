Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A37C6317
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLCwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJLCwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:52:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01691A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:52:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c88b46710bso4058935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697079124; x=1697683924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgvsnkzJDg833cgyFUp1z86vPxjfwxf/muQwdEgBqiQ=;
        b=Z9WSql7bGHPZdAz6v/B29fn2K1Zt9Uty13uWbxxm/Yjhq+4xxK7AMyc7229z3yreua
         k02YAzkcd3XV+zWwqyt8TdGVTfPvJrlFjntXJ+91xXNDCfD5xbcvKkf9irYNOpzu+sSA
         4RPKiYSZakga3PnPBephvwB49V5PUnNYA0EoE82glu6kvJ19VV1Iyd8O8wXoZjNDcO/1
         rK0YJy4xMIfdJPRtoJMcBVEE5xQcAv60zbyBjNPCt7cgzZrHVNaJZf3hKkF54ltjuOlf
         emOMj2B6cqBdx8S746CVV1C53snktBZb05QzcO2z21SGojs+iXrbULXhaXHmVLELGWOD
         40Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697079124; x=1697683924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sgvsnkzJDg833cgyFUp1z86vPxjfwxf/muQwdEgBqiQ=;
        b=gCAUNtdcz4ePhPqWaiz8jQ/+1ikeLxJEotZ6a/hkmtMcrjSViI/gM9bVXtnX9nW+6K
         GAyPvDDKvMyJTTLUpUiVUtSMErtb6b6m2bK2Db7sOxmygUCU1aF5tqet60Kp1XKAMve4
         kNNGo5AmQdWcjHOrtEAEDwkNyJyX1zwhQ1xl6XOTeM82AeVskxF7D24qDDfRUZr2VcVM
         qS0/1ttACOPGJG7UonjJNcW2yHAL7yLgTndZgzOT3pzUOjZ2ZWVqErJTceGYU4Evw24k
         83saHsiXYhVCtztGqRsi5kmzFSg2Fq16jtnRvDJ9kOWw89Bp3tmcepwALN4kZPR4Pbft
         hPIQ==
X-Gm-Message-State: AOJu0YwBTOHRwn4f5oK4OSO6HT3Rm+6mHUvD5RKdIPj5iOrQZKrzE+pY
        MNUZBaEaQ6HUlqj+aHNN5/kWZQ==
X-Google-Smtp-Source: AGHT+IE3KCzPp1Sgb0WmF/euQZXp9MPXqgBd3ibxjoqdrYsQ/KvMgeyxAyVFoIqIRbHcd59EcyjcRw==
X-Received: by 2002:a17:902:c952:b0:1c0:d17a:bfef with SMTP id i18-20020a170902c95200b001c0d17abfefmr23975582pla.30.1697079124416;
        Wed, 11 Oct 2023 19:52:04 -0700 (PDT)
Received: from [10.84.144.218] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ji20-20020a170903325400b001bbc8d65de0sm635992plb.67.2023.10.11.19.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 19:52:04 -0700 (PDT)
Message-ID: <14679c1d-463c-4dfb-8ccb-8b58c9e36c36@bytedance.com>
Date:   Thu, 12 Oct 2023 10:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: Add GFP_KERNEL to allocations in
 mas_expected_entries()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jason.sim@samsung.com, Andrew Morton <akpm@linux-foundation.org>
References: <20231010141737.1592866-1-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231010141737.1592866-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/10 22:17, Liam R. Howlett 写道:
> Users complained about OOM errors during fork without triggering
> compaction.  This can be fixed by modifying the flags used in
> mas_expected_entries() so that the compaction will be triggered in low
> memory situations.  Since mas_expected_entries() is only used during
> fork, the extra argument does not need to be passed through.
> 
> Additionally, the testing in the maple tree fork testing needed to be
> altered to use the correct locking type so that allocations would not
> trigger sleeping and thus failures in the testing.  The additional
> locking change requires rwsem support additions to the tools/ directory
> through the use of pthreads pthread_rwlock_t.  With this change
> test_maple_tree works in userspace, as a module, and in-kernel.
> 
> Users may notice that the system gave up early on attempting to start
> new processes instead of attempting to reclaim memory.
You still haven't updated check_forking() and bench_forking().
It will still produce the same error as [1].

[1] https://lore.kernel.org/oe-lkp/202309242123.7ebe65b5-oliver.sang@intel.com/
> 
> Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Cc: <stable@vger.kernel.org>
> Cc: jason.sim@samsung.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c            |  2 +-
>   lib/test_maple_tree.c       | 13 ++++++++----
>   tools/include/linux/rwsem.h | 40 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+), 5 deletions(-)
>   create mode 100644 tools/include/linux/rwsem.h
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 0e00a84e8e8f..bb24d84a4922 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
>   	/* Internal nodes */
>   	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
>   	/* Add working room for split (2 nodes) + new parents */
> -	mas_node_count(mas, nr_nodes + 3);
> +	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
>   
>   	/* Detect if allocations run out */
>   	mas->mas_flags |= MA_STATE_PREALLOC;
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 06959165e2f9..204743bc161c 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/maple_tree.h>
>   #include <linux/module.h>
> +#include <linux/rwsem.h>
>   
>   #define MTREE_ALLOC_MAX 0x2000000000000Ul
>   #define CONFIG_MAPLE_SEARCH
> @@ -2616,6 +2617,10 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   	void *tmp;
>   	MA_STATE(mas, mt, 0, 0);
>   	MA_STATE(newmas, &newmt, 0, 0);
> +	struct rw_semaphore newmt_lock;
> +
> +	init_rwsem(&newmt_lock);
> +	mt_set_external_lock(&newmt, &newmt_lock);
>   
>   	if (!zero_start)
>   		i = 1;
> @@ -2625,9 +2630,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   		mtree_store_range(mt, i*10, (i+1)*10 - gap,
>   				  xa_mk_value(i), GFP_KERNEL);
>   
> -	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> +	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
>   	mt_set_non_kernel(99999);
> -	mas_lock(&newmas);
> +	down_write(&newmt_lock);
>   	ret = mas_expected_entries(&newmas, nr_entries);
>   	mt_set_non_kernel(0);
>   	MT_BUG_ON(mt, ret != 0);
> @@ -2640,9 +2645,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   	}
>   	rcu_read_unlock();
>   	mas_destroy(&newmas);
> -	mas_unlock(&newmas);
>   
> -	mtree_destroy(&newmt);
> +	__mt_destroy(&newmt);
> +	up_write(&newmt_lock);
>   }
>   
>   /* Duplicate many sizes of trees.  Mainly to test expected entry values */
> diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
> new file mode 100644
> index 000000000000..83971b3cbfce
> --- /dev/null
> +++ b/tools/include/linux/rwsem.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _TOOLS__RWSEM_H
> +#define _TOOLS__RWSEM_H
> +
> +#include <pthread.h>
> +
> +struct rw_semaphore {
> +	pthread_rwlock_t lock;
> +};
> +
> +static inline int init_rwsem(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_init(&sem->lock, NULL);
> +}
> +
> +static inline int exit_rwsem(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_destroy(&sem->lock);
> +}
> +
> +static inline int down_read(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_rdlock(&sem->lock);
> +}
> +
> +static inline int up_read(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_unlock(&sem->lock);
> +}
> +
> +static inline int down_write(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_wrlock(&sem->lock);
> +}
> +
> +static inline int up_write(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_unlock(&sem->lock);
> +}
> +#endif /* _TOOLS_RWSEM_H */
