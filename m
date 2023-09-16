Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C87A2D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjIPBaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjIPB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86D43119
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694827740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qbIE5Sx2G6B9yvMVQiBRk6nSJz0jXl9dCA6L1yJm1M=;
        b=KrAtfbm+krvKslztbPqg4tLSSInziaPUe+NW2ga0FzQkRTN+zW9xwQXy9SidbYF25y+P+f
        hErXZYNVFTf4MGZ5/iw+HuyYcg9amiFFZZJ3azyOt0y8R+1ECO4HaKxxoRE1L4J+ePWD5d
        sXNQRwvYSFxobUd82exJmZ3zMZnS/3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-Tk3Gc_49MvaBP6egFecfag-1; Fri, 15 Sep 2023 21:28:56 -0400
X-MC-Unique: Tk3Gc_49MvaBP6egFecfag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D85691875062;
        Sat, 16 Sep 2023 01:28:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05C732026D68;
        Sat, 16 Sep 2023 01:28:52 +0000 (UTC)
Date:   Sat, 16 Sep 2023 09:28:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Message-ID: <ZQUE0e4i8HrGUthB@MiWiFi-R3L-srv>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-10-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908145302.30320-10-vbabka@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 at 04:53pm, Vlastimil Babka wrote:
> After the previous cleanups, we can now move some code from
> calc_slab_order() to calculate_order() so it's executed just once, and
> do some more cleanups.
> 
> - move the min_order and MAX_OBJS_PER_PAGE evaluation to
>   calc_slab_order().
> 
> - change calc_slab_order() parameter min_objects to min_order
> 
> Also make MAX_OBJS_PER_PAGE check more robust by considering also
> min_objects in addition to slub_min_order. Otherwise this is not a
> functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f04eb029d85a..1c91f72c7239 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4110,17 +4110,12 @@ static unsigned int slub_min_objects;
>   * the smallest order which will fit the object.
>   */
>  static inline unsigned int calc_slab_order(unsigned int size,
> -		unsigned int min_objects, unsigned int max_order,
> +		unsigned int min_order, unsigned int max_order,
>  		unsigned int fract_leftover)
>  {
> -	unsigned int min_order = slub_min_order;
>  	unsigned int order;
>  
> -	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> -
> -	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
> -			order <= max_order; order++) {
> +	for (order = min_order; order <= max_order; order++) {
>  
>  		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
>  		unsigned int rem;
> @@ -4139,7 +4134,7 @@ static inline int calculate_order(unsigned int size)
>  	unsigned int order;
>  	unsigned int min_objects;
>  	unsigned int max_objects;
> -	unsigned int nr_cpus;
> +	unsigned int min_order;
>  
>  	min_objects = slub_min_objects;
>  	if (!min_objects) {
> @@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
>  		 * order on systems that appear larger than they are, and too
>  		 * low order on systems that appear smaller than they are.
>  		 */
> -		nr_cpus = num_present_cpus();
> +		unsigned int nr_cpus = num_present_cpus();
>  		if (nr_cpus <= 1)
>  			nr_cpus = nr_cpu_ids;
>  		min_objects = 4 * (fls(nr_cpus) + 1);

A minor concern, should we change 'min_objects' to be a local static
to avoid the "if (!min_objects) {" code block every time?  It's deducing
the value from nr_cpus, we may not need do the calculation each time.

> @@ -4160,6 +4155,10 @@ static inline int calculate_order(unsigned int size)
>  	max_objects = order_objects(slub_max_order, size);
>  	min_objects = min(min_objects, max_objects);
>  
> +	min_order = max(slub_min_order, (unsigned int)get_order(min_objects * size));
> +	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
> +		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> +
>  	/*
>  	 * Attempt to find best configuration for a slab. This works by first
>  	 * attempting to generate a layout with the best possible configuration and
> @@ -4176,7 +4175,7 @@ static inline int calculate_order(unsigned int size)
>  	 * long as at least single object fits within slub_max_order.
>  	 */
>  	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
> -		order = calc_slab_order(size, min_objects, slub_max_order,
> +		order = calc_slab_order(size, min_order, slub_max_order,
>  					fraction);
>  		if (order <= slub_max_order)
>  			return order;
> -- 
> 2.42.0
> 

