Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147C79A1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjIKD7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIKD7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0E419C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694404703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBHlcKoN3c5yczq5rx1M3pZOqy+cae4xcEc6Zh1bvkI=;
        b=YLhV1KX3AeepOuRydqycSC0sd+8J8fChb3+w/mzkVLfFqEifWsm2zJxg2nY5ytRbac+sl+
        0pDNIrn3cKtYKIsmJQvGwOkeTlGMcaa97lfloTZADX6pLIdBgRFpTcJbLuWo1MtlwN0gbC
        Wv2CPV8CQwxlDGQDHYFxIy5BTezujIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-gjf6X0SpO_-4nlawRMxxkQ-1; Sun, 10 Sep 2023 23:58:18 -0400
X-MC-Unique: gjf6X0SpO_-4nlawRMxxkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E431944DC2;
        Mon, 11 Sep 2023 03:58:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC347403F4F6;
        Mon, 11 Sep 2023 03:58:16 +0000 (UTC)
Date:   Mon, 11 Sep 2023 11:58:13 +0800
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 7/9] mm: vmalloc: Support multiple nodes in vread_iter
Message-ID: <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-8-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> Extend the vread_iter() to be able to perform a sequential
> reading of VAs which are spread among multiple nodes. So a
> data read over the /dev/kmem correctly reflects a vmalloc
> memory layout.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4fd4915c532d..968144c16237 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
......  
> @@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  
>  	remains = count;
>  
> -	/* Hooked to node_0 so far. */
> -	vn = addr_to_node(0);
> -	spin_lock(&vn->busy.lock);

This could change the vread behaviour a little bit. Before, once we take
vmap_area_lock, the vread will read out the content of snapshot at the
moment. Now, reading out in one node's tree won't disrupt other nodes'
tree accessing. Not sure if this matters when people need access
/proc/kcore, e.g dynamic debugging.

And, the reading will be a little slower because each va finding need
iterate all vmap_nodes[].

Otherwise, the patch itself looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

> -
> -	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
> -	if (!va)
> +	vn = find_vmap_area_exceed_addr_lock((unsigned long) addr, &va);
> +	if (!vn)
>  		goto finished_zero;
>  
>  	/* no intersects with alive vmap_area */
>  	if ((unsigned long)addr + remains <= va->va_start)
>  		goto finished_zero;
>  
> -	list_for_each_entry_from(va, &vn->busy.head, list) {
> +	do {
>  		size_t copied;
>  
>  		if (remains == 0)
> @@ -4084,10 +4116,10 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  		WARN_ON(flags == VMAP_BLOCK);
>  
>  		if (!vm && !flags)
> -			continue;
> +			goto next_va;
>  
>  		if (vm && (vm->flags & VM_UNINITIALIZED))
> -			continue;
> +			goto next_va;
>  
>  		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
>  		smp_rmb();
> @@ -4096,7 +4128,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  		size = vm ? get_vm_area_size(vm) : va_size(va);
>  
>  		if (addr >= vaddr + size)
> -			continue;
> +			goto next_va;
>  
>  		if (addr < vaddr) {
>  			size_t to_zero = min_t(size_t, vaddr - addr, remains);
> @@ -4125,15 +4157,22 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  
>  		if (copied != n)
>  			goto finished;
> -	}
> +
> +	next_va:
> +		next = va->va_end;
> +		spin_unlock(&vn->busy.lock);
> +	} while ((vn = find_vmap_area_exceed_addr_lock(next, &va)));
>  
>  finished_zero:
> -	spin_unlock(&vn->busy.lock);
> +	if (vn)
> +		spin_unlock(&vn->busy.lock);
> +
>  	/* zero-fill memory holes */
>  	return count - remains + zero_iter(iter, remains);
>  finished:
>  	/* Nothing remains, or We couldn't copy/zero everything. */
> -	spin_unlock(&vn->busy.lock);
> +	if (vn)
> +		spin_unlock(&vn->busy.lock);
>  
>  	return count - remains;
>  }
> -- 
> 2.30.2
> 

