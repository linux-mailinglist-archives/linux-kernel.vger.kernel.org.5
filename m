Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88280793507
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbjIFFwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIFFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151ADD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693979477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G83BxpPc4WuLLC0t4HnKmDmMZOsqRC+rNDlNuSmF3kc=;
        b=TvErpQWzpo5kbXMh8LPYqf2RrR0AX+imS1YYT6qH2geDbI+fzcbpYe6Q7Rhbw/4pnVk5JH
        6xkZ8ZYXyRHBdkzWW39dAmWlG1YVHm4eRmHOrxKpONKV1DUomwCNPXD10+uiWv9dhsgPsI
        TNR2WbWYT0+yLp29sEDVsGb76D9r5xk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-hg_DDyMgOYWudTdJ8_A34w-1; Wed, 06 Sep 2023 01:51:08 -0400
X-MC-Unique: hg_DDyMgOYWudTdJ8_A34w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC448181792B;
        Wed,  6 Sep 2023 05:51:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F61493110;
        Wed,  6 Sep 2023 05:51:06 +0000 (UTC)
Date:   Wed, 6 Sep 2023 13:51:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/9] mm: vmalloc: Add va_alloc() helper
Message-ID: <ZPgTR19GX9EI8J0d@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-2-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Currently __alloc_vmap_area() function contains an open codded
> logic that finds and adjusts a VA based on allocation request.
> 
> Introduce a va_alloc() helper that adjusts found VA only. It
> will be used later at least in two places.
> 
> There is no a functional change as a result of this patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..00afc1ee4756 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1481,6 +1481,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>  	return 0;
>  }
>  
> +static unsigned long
> +va_alloc(struct vmap_area *va,
> +		struct rb_root *root, struct list_head *head,
> +		unsigned long size, unsigned long align,
> +		unsigned long vstart, unsigned long vend)
> +{
> +	unsigned long nva_start_addr;
> +	int ret;
> +
> +	if (va->va_start > vstart)
> +		nva_start_addr = ALIGN(va->va_start, align);
> +	else
> +		nva_start_addr = ALIGN(vstart, align);
> +
> +	/* Check the "vend" restriction. */
> +	if (nva_start_addr + size > vend)
> +		return vend;
> +
> +	/* Update the free vmap_area. */
> +	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> +	if (WARN_ON_ONCE(ret))
> +		return vend;
> +
> +	return nva_start_addr;
> +}
> +
>  /*
>   * Returns a start address of the newly allocated area, if success.
>   * Otherwise a vend is returned that indicates failure.
> @@ -1493,7 +1519,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  	bool adjust_search_size = true;
>  	unsigned long nva_start_addr;
>  	struct vmap_area *va;
> -	int ret;
>  
>  	/*
>  	 * Do not adjust when:
> @@ -1511,18 +1536,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  	if (unlikely(!va))
>  		return vend;
>  
> -	if (va->va_start > vstart)
> -		nva_start_addr = ALIGN(va->va_start, align);
> -	else
> -		nva_start_addr = ALIGN(vstart, align);
> -
> -	/* Check the "vend" restriction. */
> -	if (nva_start_addr + size > vend)
> -		return vend;
> -
> -	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> -	if (WARN_ON_ONCE(ret))
> +	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
> +	if (nva_start_addr == vend)
>  		return vend;
>  
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> -- 
> 2.30.2

Reviewed-by: Baoquan He <bhe@redhat.com>

