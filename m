Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F17CE164
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjJRPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjJRPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:42:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2311B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:42:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD0FC433C8;
        Wed, 18 Oct 2023 15:42:14 +0000 (UTC)
Date:   Wed, 18 Oct 2023 16:42:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] mm: kmemleak: split __create_object into two
 functions
Message-ID: <ZS_81Oy5S-VeLrT3@arm.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
 <20231018102952.3339837-5-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018102952.3339837-5-liushixin2@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this, it looks better.

On Wed, Oct 18, 2023 at 06:29:49PM +0800, Liu Shixin wrote:
> -/*
> - * Create the metadata (struct kmemleak_object) corresponding to an allocated
> - * memory block and add it to the object_list and object_tree_root (or
> - * object_phys_tree_root).
> - */
> -static void __create_object(unsigned long ptr, size_t size,
> -			    int min_count, gfp_t gfp, bool is_phys)
> +static struct kmemleak_object * __alloc_object(gfp_t gfp)
>  {
> -	unsigned long flags;
> -	struct kmemleak_object *object, *parent;
> -	struct rb_node **link, *rb_parent;
> -	unsigned long untagged_ptr;
> -	unsigned long untagged_objp;
> +	struct kmemleak_object *object;
>  
>  	object = mem_pool_alloc(gfp);
>  	if (!object) {
>  		pr_warn("Cannot allocate a kmemleak_object structure\n");
>  		kmemleak_disable();
> -		return;
> +		return NULL;
>  	}
>  
>  	INIT_LIST_HEAD(&object->object_list);
> @@ -649,13 +639,8 @@ static void __create_object(unsigned long ptr, size_t size,
>  	INIT_HLIST_HEAD(&object->area_list);
>  	raw_spin_lock_init(&object->lock);
>  	atomic_set(&object->use_count, 1);
> -	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
> -	object->pointer = ptr;
> -	object->size = kfence_ksize((void *)ptr) ?: size;
>  	object->excess_ref = 0;
> -	object->min_count = min_count;
>  	object->count = 0;			/* white color initially */
> -	object->jiffies = jiffies;
>  	object->checksum = 0;
>  	object->del_state = 0;

I'd keep all the initialisation in one place even if it means passing
more arguments to __alloc_object(). It feels a bit weird and error prone
to split the initialisation in two places. Otherwise I'm fine with the
split.

-- 
Catalin
