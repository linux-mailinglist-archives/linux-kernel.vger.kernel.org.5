Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37EB75D61E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjGUVBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGUVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:01:38 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F51FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:01:37 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-78360b822abso108624239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689973296; x=1690578096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM+Mlo3/qdURDyU/jOXBjf2mTfeeu/j5kwoCIZNPzV4=;
        b=dCqFe+KZ43t5O8R5VvbWSkGkxR3UQCSAa30uucUJ/GvfoMOanFdIUiKO74oZCPv3+k
         w1k/spW4U8V2OoUFguPXBOEp2JYySsJYJAcUjO0huXdoTUgya3jGS6yD7U7UaZzVMaPS
         JH3KsJdBrVwnDeYhD7ezECgPR+h2HEdtfbwSl8RF4Gc+IEvjqvrWjnbC5B+pSqqVDcL1
         +3vJluBfmtSO/5vtllpoq3aBgmILuujzYmE7uoaiuynL3aR7IqELWWhV8D/Cx8ofjWi9
         yWh0CbxhtFfrh3QGyOCd+9lYb+FUwUL0DFG3PqT5te4l7AkES2IL1msmH8WM+6xY31fE
         kleQ==
X-Gm-Message-State: ABy/qLZci39Z+svv7NU1q/9w0uggEnpJbPRi+U2LMqGFKAiQXHyUbOt3
        YVuxQJ8Kn8QdF65PhgfrCiw=
X-Google-Smtp-Source: APBJJlEkNbiIvlo9GdVjs7O3HS7p2Fincaq3SVX/f/JJcykDQH0nGgIFUG1fZgJmhjt9Ga2CfRUS3g==
X-Received: by 2002:a05:6602:151:b0:787:5ca:d4f with SMTP id v17-20020a056602015100b0078705ca0d4fmr913746iot.8.1689973296198;
        Fri, 21 Jul 2023 14:01:36 -0700 (PDT)
Received: from snowbird ([2601:282:1800:1f50::d356])
        by smtp.gmail.com with ESMTPSA id c11-20020a6bfd0b000000b0076ffebfc9fasm1297464ioi.47.2023.07.21.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:01:35 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:01:34 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 2/3] mm/percpu.c: optimize the code in
 pcpu_setup_first_chunk() a little bit
Message-ID: <ZLryLmHm99Pea2Yj@snowbird>
References: <20230721131800.20003-1-bhe@redhat.com>
 <20230721131800.20003-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721131800.20003-3-bhe@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 21, 2023 at 09:17:59PM +0800, Baoquan He wrote:
> This removes the need of local varibale 'chunk', and optimize the code
> calling pcpu_alloc_first_chunk() to initialize reserved chunk and
> dynamic chunk to make it simpler.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 1480bf283d11..c25b058a46ad 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2581,7 +2581,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  {
>  	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
>  	size_t static_size, dyn_size;
> -	struct pcpu_chunk *chunk;
>  	unsigned long *group_offsets;
>  	size_t *group_sizes;
>  	unsigned long *unit_off;
> @@ -2697,7 +2696,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	pcpu_unit_pages = ai->unit_size >> PAGE_SHIFT;
>  	pcpu_unit_size = pcpu_unit_pages << PAGE_SHIFT;
>  	pcpu_atom_size = ai->atom_size;
> -	pcpu_chunk_struct_size = struct_size(chunk, populated,
> +	pcpu_chunk_struct_size = struct_size((struct pcpu_chunk *)0, populated,
>  					     BITS_TO_LONGS(pcpu_unit_pages));
>  
>  	pcpu_stats_save_ai(ai);
> @@ -2735,28 +2734,23 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  
>  	/*
>  	 * Initialize first chunk.
> -	 * If the reserved_size is non-zero, this initializes the reserved
> -	 * chunk.  If the reserved_size is zero, the reserved chunk is NULL
> -	 * and the dynamic region is initialized here.  The first chunk,
> -	 * pcpu_first_chunk, will always point to the chunk that serves
> -	 * the dynamic region.
> +	 * If the reserved_size is non-zero, initializes the reserved chunk
                                         ^initialize
> +	 * firstly. If the reserved_size is zero, the reserved chunk is NULL
        ^ can remove firstly.
> +	 * and the dynamic region is initialized directly. The first chunk,
> +	 * pcpu_first_chunk, will always point to the chunk that serves the
> +	 * dynamic region.

Reading this, I'll probably reword this comment to explain the reserved
chunk better.

>  	 */
>  	tmp_addr = (unsigned long)base_addr + static_size;
> -	map_size = ai->reserved_size ?: dyn_size;
> -	chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> -
> -	/* init dynamic chunk if necessary */
>  	if (ai->reserved_size) {
> -		pcpu_reserved_chunk = chunk;
> -
> -		tmp_addr = (unsigned long)base_addr + static_size +
> -			   ai->reserved_size;
> -		map_size = dyn_size;
> -		chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> +		map_size = ai->reserved_size;
> +		pcpu_reserved_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
>  	}
>  
> -	/* link the first chunk in */
> -	pcpu_first_chunk = chunk;
> +	/* init dynamic chunk if necessary */
> +	tmp_addr += (unsigned long)ai->reserved_size;

I'm not a big fan of += the tmp_addr as I personally find it easier to
read if it's just laid out explicitly.

> +	map_size = dyn_size;
> +	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> +
>  	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
>  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
>  
> -- 
> 2.34.1
> 

Overall, I think this is good, but I'd go 1 step further and get rid of
map_size. Regarding tmp_addr, I'd prefer if we kept all the math
together.

Thanks,
Dennis
