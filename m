Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AC7CE2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjJRQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJRQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:39:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9813118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:39:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2389FC433AD;
        Wed, 18 Oct 2023 16:39:04 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:39:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] mm/kmemleak: fix partially freeing unknown object
 warning
Message-ID: <ZTAKJstsXrcUtOjn@arm.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
 <20231018102952.3339837-8-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018102952.3339837-8-liushixin2@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:29:52PM +0800, Liu Shixin wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 7c9125c18956..a956b2734324 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -816,16 +816,25 @@ static void delete_object_full(unsigned long ptr)
>   */
>  static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>  {
> -	struct kmemleak_object *object;
> -	unsigned long start, end;
> +	struct kmemleak_object *object, *object_l, *object_r;
> +	unsigned long start, end, flags;
> +
> +	object_l = __alloc_object(GFP_KERNEL);
> +	if (!object_l)
> +		return;
>  
> -	object = find_and_remove_object(ptr, 1, is_phys);
> +	object_r = __alloc_object(GFP_KERNEL);
> +	if (!object_r)
> +		goto out;
> +
> +	raw_spin_lock_irqsave(&kmemleak_lock, flags);
> +	object = __find_and_remove_object(ptr, 1, is_phys);
>  	if (!object) {
>  #ifdef DEBUG
>  		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
>  			      ptr, size);
>  #endif
> -		return;
> +		goto unlock;
>  	}
>  
>  	/*
> @@ -835,14 +844,25 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>  	 */
>  	start = object->pointer;
>  	end = object->pointer + object->size;
> -	if (ptr > start)
> -		__create_object(start, ptr - start, object->min_count,
> -			      GFP_KERNEL, is_phys);
> -	if (ptr + size < end)
> -		__create_object(ptr + size, end - ptr - size, object->min_count,
> -			      GFP_KERNEL, is_phys);
> +	if ((ptr > start) &&
> +	    !__link_object(object_l, start, ptr - start,
> +			   object->min_count, is_phys))
> +		object_l = NULL;
> +	if ((ptr + size < end) &&
> +	    !__link_object(object_r, ptr + size, end - ptr - size,
> +			   object->min_count, is_phys))
> +		object_r = NULL;
> +
> +unlock:
> +	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> +	if (object)
> +		__delete_object(object);
>  
> -	__delete_object(object);
> +out:
> +	if (object_l)
> +		mem_pool_free(object_l);
> +	if (object_r)
> +		mem_pool_free(object_r);
>  }

Ah, I see now why __link_object() needs to do further object
initialisation under the lock as prior to find_and_remove_object() we
don't have all the information needed for object_l and object_r.

Maybe in the __create_object splitting patch you can leave
__alloc_object() just do the actual allocation and __link_object() do
the full initialisation. Up to you, you can send a separate patch on top
as I can see Andrew picked them up already.

Otherwise the series looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
