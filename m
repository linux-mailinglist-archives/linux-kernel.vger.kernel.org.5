Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7DE793509
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbjIFFxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIFFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8428BE4E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693979537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oBroSdJKa/XGQNFjilG4BQjGiI7AjaAD4cAdBuTzN8=;
        b=EQPQfrlcPE785ZXMHjXfigdcwGt9DYrOXUl3i48d7nbBbSKFZWMIqvjPNcEzbcq5TGcJp6
        E/uu7fy7NIeO54yYZGadsq4jHenRoX/m0pVjI5BIAtxCC3ARAyTEFBFgtlM7WF7JHtKRF7
        pjNIedGJvdtfSn+NfuTECcaOwqG3nPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-nMmOOAXlPamZNekQSAY2-A-1; Wed, 06 Sep 2023 01:52:12 -0400
X-MC-Unique: nMmOOAXlPamZNekQSAY2-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D55AA1817929;
        Wed,  6 Sep 2023 05:52:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3159B140E962;
        Wed,  6 Sep 2023 05:52:10 +0000 (UTC)
Date:   Wed, 6 Sep 2023 13:52:08 +0800
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
Subject: Re: [PATCH v2 3/9] mm: vmalloc: Move vmap_init_free_space() down in
 vmalloc.c
Message-ID: <ZPgTiCoJIjYpN+ak@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-4-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
> A vmap_init_free_space() is a function that setups a vmap space
> and is considered as part of initialization phase. Since a main
> entry which is vmalloc_init(), has been moved down in vmalloc.c
> it makes sense to follow the pattern.
> 
> There is no a functional change as a result of this patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 09e315f8ea34..b7deacca1483 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2512,47 +2512,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>  }
>  
> -static void vmap_init_free_space(void)
> -{
> -	unsigned long vmap_start = 1;
> -	const unsigned long vmap_end = ULONG_MAX;
> -	struct vmap_area *busy, *free;
> -
> -	/*
> -	 *     B     F     B     B     B     F
> -	 * -|-----|.....|-----|-----|-----|.....|-
> -	 *  |           The KVA space           |
> -	 *  |<--------------------------------->|
> -	 */
> -	list_for_each_entry(busy, &vmap_area_list, list) {
> -		if (busy->va_start - vmap_start > 0) {
> -			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> -			if (!WARN_ON_ONCE(!free)) {
> -				free->va_start = vmap_start;
> -				free->va_end = busy->va_start;
> -
> -				insert_vmap_area_augment(free, NULL,
> -					&free_vmap_area_root,
> -						&free_vmap_area_list);
> -			}
> -		}
> -
> -		vmap_start = busy->va_end;
> -	}
> -
> -	if (vmap_end - vmap_start > 0) {
> -		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> -		if (!WARN_ON_ONCE(!free)) {
> -			free->va_start = vmap_start;
> -			free->va_end = vmap_end;
> -
> -			insert_vmap_area_augment(free, NULL,
> -				&free_vmap_area_root,
> -					&free_vmap_area_list);
> -		}
> -	}
> -}
> -
>  static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  	struct vmap_area *va, unsigned long flags, const void *caller)
>  {
> @@ -4443,6 +4402,47 @@ module_init(proc_vmalloc_init);
>  
>  #endif
>  
> +static void vmap_init_free_space(void)
> +{
> +	unsigned long vmap_start = 1;
> +	const unsigned long vmap_end = ULONG_MAX;
> +	struct vmap_area *busy, *free;
> +
> +	/*
> +	 *     B     F     B     B     B     F
> +	 * -|-----|.....|-----|-----|-----|.....|-
> +	 *  |           The KVA space           |
> +	 *  |<--------------------------------->|
> +	 */
> +	list_for_each_entry(busy, &vmap_area_list, list) {
> +		if (busy->va_start - vmap_start > 0) {
> +			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +			if (!WARN_ON_ONCE(!free)) {
> +				free->va_start = vmap_start;
> +				free->va_end = busy->va_start;
> +
> +				insert_vmap_area_augment(free, NULL,
> +					&free_vmap_area_root,
> +						&free_vmap_area_list);
> +			}
> +		}
> +
> +		vmap_start = busy->va_end;
> +	}
> +
> +	if (vmap_end - vmap_start > 0) {
> +		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +		if (!WARN_ON_ONCE(!free)) {
> +			free->va_start = vmap_start;
> +			free->va_end = vmap_end;
> +
> +			insert_vmap_area_augment(free, NULL,
> +				&free_vmap_area_root,
> +					&free_vmap_area_list);
> +		}
> +	}
> +}
> +
>  void __init vmalloc_init(void)
>  {
>  	struct vmap_area *va;
> -- 
> 2.30.2
> 

Reviewed-by: Baoquan He <bhe@redhat.com>

