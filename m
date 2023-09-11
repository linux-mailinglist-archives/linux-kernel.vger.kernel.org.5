Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF179A18C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjIKC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIKC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3BB0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694401032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7eG1PKh05+S6mxXUS3wn0U9L33NEEGjPL4aMtcQrJRw=;
        b=duKwS89ZXBqxgGNELnCezI15CyCW3jHs8JNXXYw/g0LJZuzdcgwia/a3b+1fXHu9pnoXse
        DmP79HSQKU+yny/8E2XV5qsbtW1wmmP4APKYlMny4INdPrWup/Smw36IPr1RPfOhJkiwn7
        NpT62RbV8/BwXDO2iPmGnUArZh7OkT8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-HQGC1K1-Pha5K98cf0Ha_g-1; Sun, 10 Sep 2023 22:57:07 -0400
X-MC-Unique: HQGC1K1-Pha5K98cf0Ha_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 498B48002B2;
        Mon, 11 Sep 2023 02:57:06 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C5FBC03295;
        Mon, 11 Sep 2023 02:57:04 +0000 (UTC)
Date:   Mon, 11 Sep 2023 10:57:02 +0800
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
Subject: Re: [PATCH v2 5/9] mm: vmalloc: Remove global purge_vmap_area_root
 rb-tree
Message-ID: <ZP6B/vAsZ3z+k6af@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-6-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
> Similar to busy VA, lazily-freed area is stored to a node
> it belongs to. Such approach does not require any global
> locking primitive, instead an access becomes scalable what
> mitigates a contention.
> 
> This patch removes a global purge-lock, global purge-tree
> and global purge list.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 135 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 82 insertions(+), 53 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ae0368c314ff..5a8a9c1370b6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -733,10 +733,6 @@ static DEFINE_SPINLOCK(free_vmap_area_lock);
>  LIST_HEAD(vmap_area_list);
>  static bool vmap_initialized __read_mostly;
>  
> -static struct rb_root purge_vmap_area_root = RB_ROOT;
> -static LIST_HEAD(purge_vmap_area_list);
> -static DEFINE_SPINLOCK(purge_vmap_area_lock);
> -
>  /*
>   * This kmem_cache is used for vmap_area objects. Instead of
>   * allocating from slab we reuse an object from this cache to
> @@ -784,6 +780,12 @@ struct rb_list {
>  struct vmap_node {
>  	/* Bookkeeping data of this node. */
>  	struct rb_list busy;
> +	struct rb_list lazy;
> +
> +	/*
> +	 * Ready-to-free areas.
> +	 */
> +	struct list_head purge_list;
>  };
>  
>  static struct vmap_node *nodes, snode;
> @@ -1768,40 +1770,22 @@ static DEFINE_MUTEX(vmap_purge_lock);
>  
>  /* for per-CPU blocks */
>  static void purge_fragmented_blocks_allcpus(void);
> +static cpumask_t purge_nodes;
>  
>  /*
>   * Purges all lazily-freed vmap areas.
>   */
> -static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> +static unsigned long
> +purge_vmap_node(struct vmap_node *vn)
>  {
> -	unsigned long resched_threshold;
> -	unsigned int num_purged_areas = 0;
> -	struct list_head local_purge_list;
> +	unsigned long num_purged_areas = 0;
>  	struct vmap_area *va, *n_va;
>  
> -	lockdep_assert_held(&vmap_purge_lock);
> -
> -	spin_lock(&purge_vmap_area_lock);
> -	purge_vmap_area_root = RB_ROOT;
> -	list_replace_init(&purge_vmap_area_list, &local_purge_list);
> -	spin_unlock(&purge_vmap_area_lock);
> -
> -	if (unlikely(list_empty(&local_purge_list)))
> -		goto out;
> -
> -	start = min(start,
> -		list_first_entry(&local_purge_list,
> -			struct vmap_area, list)->va_start);
> -
> -	end = max(end,
> -		list_last_entry(&local_purge_list,
> -			struct vmap_area, list)->va_end);
> -
> -	flush_tlb_kernel_range(start, end);
> -	resched_threshold = lazy_max_pages() << 1;
> +	if (list_empty(&vn->purge_list))
> +		return 0;
>  
>  	spin_lock(&free_vmap_area_lock);
> -	list_for_each_entry_safe(va, n_va, &local_purge_list, list) {
> +	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
>  		unsigned long orig_end = va->va_end;
> @@ -1823,13 +1807,55 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  
>  		atomic_long_sub(nr, &vmap_lazy_nr);
>  		num_purged_areas++;
> -
> -		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> -			cond_resched_lock(&free_vmap_area_lock);
>  	}
>  	spin_unlock(&free_vmap_area_lock);
>  
> -out:
> +	return num_purged_areas;
> +}
> +
> +/*
> + * Purges all lazily-freed vmap areas.
> + */
> +static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> +{
> +	unsigned long num_purged_areas = 0;
> +	struct vmap_node *vn;
> +	int i;
> +
> +	lockdep_assert_held(&vmap_purge_lock);
> +	purge_nodes = CPU_MASK_NONE;
> +
> +	for (i = 0; i < nr_nodes; i++) {
> +		vn = &nodes[i];
> +
> +		INIT_LIST_HEAD(&vn->purge_list);
> +
> +		if (RB_EMPTY_ROOT(&vn->lazy.root))
> +			continue;
> +
> +		spin_lock(&vn->lazy.lock);
> +		WRITE_ONCE(vn->lazy.root.rb_node, NULL);
> +		list_replace_init(&vn->lazy.head, &vn->purge_list);
> +		spin_unlock(&vn->lazy.lock);
> +
> +		start = min(start, list_first_entry(&vn->purge_list,
> +			struct vmap_area, list)->va_start);
> +
> +		end = max(end, list_last_entry(&vn->purge_list,
> +			struct vmap_area, list)->va_end);
> +
> +		cpumask_set_cpu(i, &purge_nodes);
> +	}
> +
> +	if (cpumask_weight(&purge_nodes) > 0) {
> +		flush_tlb_kernel_range(start, end);
> +
> +		for_each_cpu(i, &purge_nodes) {
> +			vn = &nodes[i];
> +			num_purged_areas += purge_vmap_node(vn);
> +		}
> +	}
> +
>  	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
>  	return num_purged_areas > 0;
>  }
> @@ -1848,16 +1874,9 @@ static void reclaim_and_purge_vmap_areas(void)
>  
>  static void drain_vmap_area_work(struct work_struct *work)
>  {
> -	unsigned long nr_lazy;
> -
> -	do {
> -		mutex_lock(&vmap_purge_lock);
> -		__purge_vmap_area_lazy(ULONG_MAX, 0);
> -		mutex_unlock(&vmap_purge_lock);
> -
> -		/* Recheck if further work is required. */
> -		nr_lazy = atomic_long_read(&vmap_lazy_nr);
> -	} while (nr_lazy > lazy_max_pages());
> +	mutex_lock(&vmap_purge_lock);
> +	__purge_vmap_area_lazy(ULONG_MAX, 0);
> +	mutex_unlock(&vmap_purge_lock);
>  }
>  
>  /*
> @@ -1867,6 +1886,7 @@ static void drain_vmap_area_work(struct work_struct *work)
>   */
>  static void free_vmap_area_noflush(struct vmap_area *va)
>  {
> +	struct vmap_node *vn = addr_to_node(va->va_start);
>  	unsigned long nr_lazy_max = lazy_max_pages();
>  	unsigned long va_start = va->va_start;
>  	unsigned long nr_lazy;
> @@ -1880,10 +1900,9 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  	/*
>  	 * Merge or place it to the purge tree/list.
>  	 */
> -	spin_lock(&purge_vmap_area_lock);
> -	merge_or_add_vmap_area(va,
> -		&purge_vmap_area_root, &purge_vmap_area_list);
> -	spin_unlock(&purge_vmap_area_lock);
> +	spin_lock(&vn->lazy.lock);
> +	merge_or_add_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
> +	spin_unlock(&vn->lazy.lock);
>  
>  	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
>  
> @@ -4390,15 +4409,21 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
>  
>  static void show_purge_info(struct seq_file *m)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
> +	int i;
>  
> -	spin_lock(&purge_vmap_area_lock);
> -	list_for_each_entry(va, &purge_vmap_area_list, list) {
> -		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> -			(void *)va->va_start, (void *)va->va_end,
> -			va->va_end - va->va_start);
> +	for (i = 0; i < nr_nodes; i++) {
> +		vn = &nodes[i];
> +
> +		spin_lock(&vn->lazy.lock);
> +		list_for_each_entry(va, &vn->lazy.head, list) {
> +			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
> +				(void *)va->va_start, (void *)va->va_end,
> +				va->va_end - va->va_start);
> +		}
> +		spin_unlock(&vn->lazy.lock);
>  	}
> -	spin_unlock(&purge_vmap_area_lock);
>  }
>  
>  static int s_show(struct seq_file *m, void *p)
> @@ -4545,6 +4570,10 @@ static void vmap_init_nodes(void)
>  		vn->busy.root = RB_ROOT;
>  		INIT_LIST_HEAD(&vn->busy.head);
>  		spin_lock_init(&vn->busy.lock);
> +
> +		vn->lazy.root = RB_ROOT;
> +		INIT_LIST_HEAD(&vn->lazy.head);
> +		spin_lock_init(&vn->lazy.lock);
>  	}
>  }
>  
> -- 
> 2.30.2
> 

