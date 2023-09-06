Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F47E793518
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjIFGFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIFGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B0CFD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693980265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPK4MxvTcbYhN01kTvqT1WAn3PfoCUVSBQIq7FXEx44=;
        b=E2g7lk10LzzEAL9b9X5lHlK4e2L+CHSaxM1Vppm9OjlQC+Mbt0z8XPNpOIU3TTF/rWiA83
        pAHqP1nwB/wjLaxn5VfGpQtQs45vWwD4TMSxb86Jef8ZZvkqlZkNT73f/XtjqBgTcQuJio
        p3lmw5pAOejBLEA1tsJnKAKTp5ymcgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-QX6eOuefPDS2P7A6xs9JvA-1; Wed, 06 Sep 2023 02:04:19 -0400
X-MC-Unique: QX6eOuefPDS2P7A6xs9JvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 819EA10264F4;
        Wed,  6 Sep 2023 06:04:18 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70058493110;
        Wed,  6 Sep 2023 06:04:17 +0000 (UTC)
Date:   Wed, 6 Sep 2023 14:04:14 +0800
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
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZPgWXgL1nLASjx8O@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-7-urezki@gmail.com>
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
> Concurrent access to a global vmap space is a bottle-neck.
> We can simulate a high contention by running a vmalloc test
> suite.
> 
> To address it, introduce an effective vmap node logic. Each
> node behaves as independent entity. When a node is accessed
> it serves a request directly(if possible) also it can fetch
> a new block from a global heap to its internals if no space
> or low capacity is left.
> 
> This technique reduces a pressure on the global vmap lock.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 316 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 279 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5a8a9c1370b6..4fd4915c532d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -779,6 +779,7 @@ struct rb_list {
>  
>  struct vmap_node {
>  	/* Bookkeeping data of this node. */
> +	struct rb_list free;
>  	struct rb_list busy;
>  	struct rb_list lazy;
>  
> @@ -786,6 +787,13 @@ struct vmap_node {
>  	 * Ready-to-free areas.
>  	 */
>  	struct list_head purge_list;
> +	struct work_struct purge_work;
> +	unsigned long nr_purged;
> +
> +	/*
> +	 * Control that only one user can pre-fetch this node.
> +	 */
> +	atomic_t fill_in_progress;
>  };
>  
>  static struct vmap_node *nodes, snode;
> @@ -804,6 +812,32 @@ addr_to_node(unsigned long addr)
>  	return &nodes[addr_to_node_id(addr)];
>  }
>  
> +static inline struct vmap_node *
> +id_to_node(int id)
> +{
> +	return &nodes[id % nr_nodes];
> +}
> +
> +static inline int
> +this_node_id(void)
> +{
> +	return raw_smp_processor_id() % nr_nodes;
> +}
> +
> +static inline unsigned long
> +encode_vn_id(int node_id)
> +{
> +	/* Can store U8_MAX [0:254] nodes. */
> +	return (node_id + 1) << BITS_PER_BYTE;
> +}
> +
> +static inline int
> +decode_vn_id(unsigned long val)
> +{
> +	/* Can store U8_MAX [0:254] nodes. */
> +	return (val >> BITS_PER_BYTE) - 1;
> +}
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {
> @@ -1586,6 +1620,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  static void free_vmap_area(struct vmap_area *va)
>  {
>  	struct vmap_node *vn = addr_to_node(va->va_start);
> +	int vn_id = decode_vn_id(va->flags);
>  
>  	/*
>  	 * Remove from the busy tree/list.
> @@ -1594,12 +1629,19 @@ static void free_vmap_area(struct vmap_area *va)
>  	unlink_va(va, &vn->busy.root);
>  	spin_unlock(&vn->busy.lock);
>  
> -	/*
> -	 * Insert/Merge it back to the free tree/list.
> -	 */
> -	spin_lock(&free_vmap_area_lock);
> -	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> -	spin_unlock(&free_vmap_area_lock);
> +	if (vn_id >= 0) {

In alloc_vmap_area(), the vn_id is encoded into va->flags. When
allocation failed, the vn_id = 0. Here should we change to check 'if
(vn_id > 0)' becasue the vn_id == 0 means no available vn_id encoded
into. And I do not get how we treat the case vn_id truly is 0.

	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;

> +		vn = id_to_node(vn_id);
> +
> +		/* Belongs to this node. */
> +		spin_lock(&vn->free.lock);
> +		merge_or_add_vmap_area_augment(va, &vn->free.root, &vn->free.head);
> +		spin_unlock(&vn->free.lock);
> +	} else {
> +		/* Goes to global. */
> +		spin_lock(&free_vmap_area_lock);
> +		merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> +		spin_unlock(&free_vmap_area_lock);
> +	}
>  }
>  
>  static inline void
......
> @@ -1640,7 +1810,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	unsigned long freed;
>  	unsigned long addr;
>  	int purged = 0;
> -	int ret;
> +	int ret, vn_id;
>  
>  	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
>  		return ERR_PTR(-EINVAL);
> @@ -1661,11 +1831,17 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 */
>  	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
>  
> +	vn_id = this_node_id();
> +	addr = node_alloc(vn_id, size, align, vstart, vend, gfp_mask, node);
> +	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;
> +
>  retry:
> -	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> -	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> -		size, align, vstart, vend);
> -	spin_unlock(&free_vmap_area_lock);
> +	if (addr == vend) {
> +		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> +		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +			size, align, vstart, vend);
> +		spin_unlock(&free_vmap_area_lock);
> +	}
>  
>  	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
>  
> @@ -1679,7 +1855,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_start = addr;
>  	va->va_end = addr + size;
>  	va->vm = NULL;
> -	va->flags = va_flags;
> +	va->flags |= va_flags;
>  
>  	vn = addr_to_node(va->va_start);
>  
> @@ -1772,31 +1948,58 @@ static DEFINE_MUTEX(vmap_purge_lock);
>  static void purge_fragmented_blocks_allcpus(void);
>  static cpumask_t purge_nodes;
>  
> -/*
> - * Purges all lazily-freed vmap areas.
> - */
> -static unsigned long
> -purge_vmap_node(struct vmap_node *vn)
> +static void
> +reclaim_list_global(struct list_head *head)
> +{
> +	struct vmap_area *va, *n;
> +
> +	if (list_empty(head))
> +		return;
> +
> +	spin_lock(&free_vmap_area_lock);
> +	list_for_each_entry_safe(va, n, head, list)
> +		merge_or_add_vmap_area_augment(va,
> +			&free_vmap_area_root, &free_vmap_area_list);
> +	spin_unlock(&free_vmap_area_lock);
> +}
> +
> +static void purge_vmap_node(struct work_struct *work)
>  {
> -	unsigned long num_purged_areas = 0;
> +	struct vmap_node *vn = container_of(work,
> +		struct vmap_node, purge_work);
>  	struct vmap_area *va, *n_va;
> +	LIST_HEAD(global);
> +
> +	vn->nr_purged = 0;
>  
>  	if (list_empty(&vn->purge_list))
> -		return 0;
> +		return;
>  
> -	spin_lock(&free_vmap_area_lock);
> +	spin_lock(&vn->free.lock);
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
>  		unsigned long orig_end = va->va_end;
> +		int vn_id = decode_vn_id(va->flags);
>  
> -		/*
> -		 * Finally insert or merge lazily-freed area. It is
> -		 * detached and there is no need to "unlink" it from
> -		 * anything.
> -		 */
> -		va = merge_or_add_vmap_area_augment(va, &free_vmap_area_root,
> -				&free_vmap_area_list);
> +		list_del_init(&va->list);
> +
> +		if (vn_id >= 0) {
> +			if (va_size(va) != node_size - (2 * PAGE_SIZE))
> +				va = merge_or_add_vmap_area_augment(va, &vn->free.root, &vn->free.head);
> +
> +			if (va_size(va) == node_size - (2 * PAGE_SIZE)) {
> +				if (!list_empty(&va->list))
> +					unlink_va_augment(va, &vn->free.root);
> +
> +				/* Restore the block size. */
> +				va->va_start -= PAGE_SIZE;
> +				va->va_end += PAGE_SIZE;
> +				list_add(&va->list, &global);
> +			}
> +		} else {
> +			list_add(&va->list, &global);
> +		}
>  
>  		if (!va)
>  			continue;
> @@ -1806,11 +2009,10 @@ purge_vmap_node(struct vmap_node *vn)
>  					      va->va_start, va->va_end);
>  
>  		atomic_long_sub(nr, &vmap_lazy_nr);
> -		num_purged_areas++;
> +		vn->nr_purged++;
>  	}
> -	spin_unlock(&free_vmap_area_lock);
> -
> -	return num_purged_areas;
> +	spin_unlock(&vn->free.lock);
> +	reclaim_list_global(&global);
>  }
>  
>  /*
> @@ -1818,11 +2020,17 @@ purge_vmap_node(struct vmap_node *vn)
>   */
>  static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  {
> -	unsigned long num_purged_areas = 0;
> +	unsigned long nr_purged_areas = 0;
> +	unsigned int nr_purge_helpers;
> +	unsigned int nr_purge_nodes;
>  	struct vmap_node *vn;
>  	int i;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
> +
> +	/*
> +	 * Use cpumask to mark which node has to be processed.
> +	 */
>  	purge_nodes = CPU_MASK_NONE;
>  
>  	for (i = 0; i < nr_nodes; i++) {
> @@ -1847,17 +2055,45 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  		cpumask_set_cpu(i, &purge_nodes);
>  	}
>  
> -	if (cpumask_weight(&purge_nodes) > 0) {
> +	nr_purge_nodes = cpumask_weight(&purge_nodes);
> +	if (nr_purge_nodes > 0) {
>  		flush_tlb_kernel_range(start, end);
>  
> +		/* One extra worker is per a lazy_max_pages() full set minus one. */
> +		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
> +		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
> +
> +		for_each_cpu(i, &purge_nodes) {
> +			vn = &nodes[i];
> +
> +			if (nr_purge_helpers > 0) {
> +				INIT_WORK(&vn->purge_work, purge_vmap_node);
> +
> +				if (cpumask_test_cpu(i, cpu_online_mask))
> +					schedule_work_on(i, &vn->purge_work);
> +				else
> +					schedule_work(&vn->purge_work);
> +
> +				nr_purge_helpers--;
> +			} else {
> +				vn->purge_work.func = NULL;
> +				purge_vmap_node(&vn->purge_work);
> +				nr_purged_areas += vn->nr_purged;
> +			}
> +		}
> +
>  		for_each_cpu(i, &purge_nodes) {
>  			vn = &nodes[i];
> -			num_purged_areas += purge_vmap_node(vn);
> +
> +			if (vn->purge_work.func) {
> +				flush_work(&vn->purge_work);
> +				nr_purged_areas += vn->nr_purged;
> +			}
>  		}
>  	}
>  
> -	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
> -	return num_purged_areas > 0;
> +	trace_purge_vmap_area_lazy(start, end, nr_purged_areas);
> +	return nr_purged_areas > 0;
>  }
>  
>  /*
> @@ -1886,9 +2122,11 @@ static void drain_vmap_area_work(struct work_struct *work)
>   */
>  static void free_vmap_area_noflush(struct vmap_area *va)
>  {
> -	struct vmap_node *vn = addr_to_node(va->va_start);
>  	unsigned long nr_lazy_max = lazy_max_pages();
>  	unsigned long va_start = va->va_start;
> +	int vn_id = decode_vn_id(va->flags);
> +	struct vmap_node *vn = vn_id >= 0 ? id_to_node(vn_id):
> +		addr_to_node(va->va_start);;
>  	unsigned long nr_lazy;
>  
>  	if (WARN_ON_ONCE(!list_empty(&va->list)))
> @@ -4574,6 +4812,10 @@ static void vmap_init_nodes(void)
>  		vn->lazy.root = RB_ROOT;
>  		INIT_LIST_HEAD(&vn->lazy.head);
>  		spin_lock_init(&vn->lazy.lock);
> +
> +		vn->free.root = RB_ROOT;
> +		INIT_LIST_HEAD(&vn->free.head);
> +		spin_lock_init(&vn->free.lock);
>  	}
>  }
>  
> -- 
> 2.30.2
> 

