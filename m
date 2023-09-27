Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4EB7B0AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjI0RGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI0RG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:06:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAB13A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:06:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B32C433C8;
        Wed, 27 Sep 2023 17:06:25 +0000 (UTC)
Date:   Wed, 27 Sep 2023 18:06:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/kmemleak: fix partially freeing unknown object
 warning
Message-ID: <ZRRhDgR/SIxbOCDk@arm.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
 <20230927035923.1425340-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035923.1425340-3-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:59:22AM +0800, Liu Shixin wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 54c2c90d3abc..5a2bbd85df57 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -208,6 +208,8 @@ static struct rb_root object_tree_root = RB_ROOT;
>  static struct rb_root object_phys_tree_root = RB_ROOT;
>  /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
>  static DEFINE_RAW_SPINLOCK(kmemleak_lock);
> +/* Serial delete_object_part() to ensure all objects is deleted correctly */
> +static DEFINE_RAW_SPINLOCK(delete_object_part_mutex);

Don't call this mutex, it implies sleeping.

>  
>  /* allocation caches for kmemleak internal data */
>  static struct kmem_cache *object_cache;
> @@ -784,13 +786,16 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>  {
>  	struct kmemleak_object *object;
>  	unsigned long start, end;
> +	unsigned long flags;
>  
> +	raw_spin_lock_irqsave(&delete_object_part_mutex, flags);
>  	object = find_and_remove_object(ptr, 1, is_phys);
>  	if (!object) {
>  #ifdef DEBUG
>  		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
>  			      ptr, size);
>  #endif
> +		raw_spin_unlock_irqrestore(&delete_object_part_mutex, flags);

I prefer a goto out and a single place for unlocking.

However, we already take the kmemleak_lock in find_and_remove_object().
So better to open-code that function here and avoid introducing a new
lock. __create_object() may need a new bool argument, no_lock or
something. Or just split it into separate functions for allocating the
kmemleak structure and adding it to the corresponding trees/lists under
a lock.

-- 
Catalin
