Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567047C9728
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjJNXBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJNXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:01:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB42D6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 16:01:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3779C433C7;
        Sat, 14 Oct 2023 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697324471;
        bh=XO7DKNf9VXgcblgzYunjPQ6Iz024GpQIbrDxjVO0LAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LY68QcCWmdmIub7wuID3ZVKrVdvvduGFlwlEMqEpoBVYlofT2TL49Zl7GDwKGg9wC
         4nACqo9c+RFqVnJE0dzTgb1OseNF2rfdAsRyCBdHT1dBVkaraUp87+kKxLjjL0RVRk
         ZmV+p5htCLF9BNmVULCfMQ9LevNNDEGa8eB9rik8=
Date:   Sat, 14 Oct 2023 16:01:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huai-Yuan Liu <810974084@qq.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc.c: function call alloc_percpu() unchecked
Message-Id: <20231014160104.19912de669475deec235702d@linux-foundation.org>
In-Reply-To: <20231012082535.7135-1-810974084@qq.com>
References: <20231012082535.7135-1-810974084@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 01:25:35 -0700 Huai-Yuan Liu <810974084@qq.com> wrote:

> The function call alloc_percpu() returns a pointer to the memory address,
> but it hasn't been checked. Our static analysis tool indicates that null
> pointer dereference may exist in pointer zone->per_cpu_pageset. It is
> always safe to judge the null pointer before use.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5390,6 +5390,8 @@ void __meminit setup_zone_pageset(struct zone *zone)
>  		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
>  
>  	zone->per_cpu_pageset = alloc_percpu(struct per_cpu_pages);
> +	if (!zone->per_cpu_pageset)
> +		return;
>  	for_each_possible_cpu(cpu) {
>  		struct per_cpu_pages *pcp;
>  		struct per_cpu_zonestat *pzstats;

I suppose as it's __meminit, yes, we should be checking here.

In which case we should also be checking the alloc_percpu() two lines
earlier and we should be freeing zone->per_cpu_zonestats if this second
alloc_percpu() fails.  And we should be propagating the overall failure
back to higher layers whihc then handle it so the kernel won't immediately
crash anwyay.

