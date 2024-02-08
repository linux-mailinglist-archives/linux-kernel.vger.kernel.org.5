Return-Path: <linux-kernel+bounces-57341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCE84D725
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414DEB22364
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049A1D534;
	Thu,  8 Feb 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZU508YYk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353F15AF1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351936; cv=none; b=HtLaKM9Ow2pZmgdmYAUik+apqF327Amm8fyBZTqOGtd8rRcNOamFEEA+d4oXqoPImMvZ3YkOz5odLDFNxomU7NcW56tjVnHgTvFJEkC+Qbr4xTOdIqa98Afq7KA69VCwsyq81dJt8X48Sx4j5vSz8aJPTWTgCtfSE6NY6TGkzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351936; c=relaxed/simple;
	bh=oJn50IfU4IRaUWEmSVb7+qTaEyrgKyEr/A0sku56B50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW7JFSWIV2brVmDfiHUMqSRMfaInEq4ZHUNx3IrN4TadXqJ8bpEq4gvnos0BIydThTGwRvPfn8Oc7KyE/MVOleYVT+Hgsr9gLz3CYNyirAYSTtYXzyBk+MCUKykgITizn/AZQts7LHOQLzJ0IMznUBUHnNgc0gsuB/Z8vwQL7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZU508YYk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707351932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHaYlrIA5EDr5LpWkaSw9P6ZwBIbKCJoCxR4E3XHd4I=;
	b=ZU508YYkbyxCLz0km5WSmQpV3WgDVn69vKstmgjY8ugxaS0MimecuRQamkCw+XHSBvzCh4
	nuDGh+o5TdjBZO+04BH1vsb4tOUb/b6N73hIdRJaRz+/qMByzeqY7YaBqgtfx9hhkbH16V
	40rvDGp1WMDlfsF01JY+qD0FD9vh6Z4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-gXxYP3p8M1qHCdKYzfL7rg-1; Wed,
 07 Feb 2024 19:25:28 -0500
X-MC-Unique: gXxYP3p8M1qHCdKYzfL7rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04FEB3C0FC82;
	Thu,  8 Feb 2024 00:25:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E531103A;
	Thu,  8 Feb 2024 00:25:26 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:25:23 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZcQfc6myl5KCFk3V@MiWiFi-R3L-srv>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-8-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 01/02/24 at 07:46pm, Uladzislau Rezki (Sony) wrote:
.....
> +static struct vmap_area *
> +node_alloc(unsigned long size, unsigned long align,
> +		unsigned long vstart, unsigned long vend,
> +		unsigned long *addr, unsigned int *vn_id)
> +{
> +	struct vmap_area *va;
> +
> +	*vn_id = 0;
> +	*addr = vend;
> +
> +	/*
> +	 * Fallback to a global heap if not vmalloc or there
> +	 * is only one node.
> +	 */
> +	if (vstart != VMALLOC_START || vend != VMALLOC_END ||
> +			nr_vmap_nodes == 1)
> +		return NULL;
> +
> +	*vn_id = raw_smp_processor_id() % nr_vmap_nodes;
> +	va = node_pool_del_va(id_to_node(*vn_id), size, align, vstart, vend);
> +	*vn_id = encode_vn_id(*vn_id);
> +
> +	if (va)
> +		*addr = va->va_start;
> +
> +	return va;
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
>   * vstart and vend.
> @@ -1637,6 +1807,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	struct vmap_area *va;
>  	unsigned long freed;
>  	unsigned long addr;
> +	unsigned int vn_id;
>  	int purged = 0;
>  	int ret;
>  
> @@ -1647,11 +1818,23 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		return ERR_PTR(-EBUSY);
>  
>  	might_sleep();
> -	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
>  
> -	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> -	if (unlikely(!va))
> -		return ERR_PTR(-ENOMEM);
> +	/*
> +	 * If a VA is obtained from a global heap(if it fails here)
> +	 * it is anyway marked with this "vn_id" so it is returned
> +	 * to this pool's node later. Such way gives a possibility
> +	 * to populate pools based on users demand.
> +	 *
> +	 * On success a ready to go VA is returned.
> +	 */
> +	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);

Sorry for late checking.

Here, if no available va got, e.g a empty vp, still we will get an
effective vn_id with the current cpu_id for VMALLOC region allocation
request.

> +	if (!va) {
> +		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> +
> +		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> +		if (unlikely(!va))
> +			return ERR_PTR(-ENOMEM);
> +	}
>  
>  	/*
>  	 * Only scan the relevant parts containing pointers to other objects
> @@ -1660,10 +1843,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
>  
>  retry:
> -	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> -	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> -		size, align, vstart, vend);
> -	spin_unlock(&free_vmap_area_lock);
> +	if (addr == vend) {
> +		preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> +		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +			size, align, vstart, vend);

Then, here, we will get an available va from random location, but its
vn_id is from the current cpu.

Then in purge_vmap_node(), we will decode the vn_id stored in va->flags,
and add the relevant va into vn->pool[] according to the vn_id. The
worst case could be most of va in vn->pool[] are not corresponding to
the vmap_nodes they belongs to. It doesn't matter? Should we adjust the
code of vn_id assigning in node_alloc(), or I missed anything?

> +		spin_unlock(&free_vmap_area_lock);
> +	}
>  
>  	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
>  
> @@ -1677,7 +1862,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_start = addr;
>  	va->va_end = addr + size;
>  	va->vm = NULL;
> -	va->flags = va_flags;
> +	va->flags = (va_flags | vn_id);
>  
>  	vn = addr_to_node(va->va_start);
>  
> @@ -1770,63 +1955,135 @@ static DEFINE_MUTEX(vmap_purge_lock);
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
>  {
> -	unsigned long num_purged_areas = 0;
> -	struct vmap_area *va, *n_va;
> +	struct vmap_area *va, *n;
>  
> -	if (list_empty(&vn->purge_list))
> -		return 0;
> +	if (list_empty(head))
> +		return;
>  
>  	spin_lock(&free_vmap_area_lock);
> +	list_for_each_entry_safe(va, n, head, list)
> +		merge_or_add_vmap_area_augment(va,
> +			&free_vmap_area_root, &free_vmap_area_list);
> +	spin_unlock(&free_vmap_area_lock);
> +}
> +
> +static void
> +decay_va_pool_node(struct vmap_node *vn, bool full_decay)
> +{
> +	struct vmap_area *va, *nva;
> +	struct list_head decay_list;
> +	struct rb_root decay_root;
> +	unsigned long n_decay;
> +	int i;
> +
> +	decay_root = RB_ROOT;
> +	INIT_LIST_HEAD(&decay_list);
> +
> +	for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
> +		struct list_head tmp_list;
> +
> +		if (list_empty(&vn->pool[i].head))
> +			continue;
> +
> +		INIT_LIST_HEAD(&tmp_list);
> +
> +		/* Detach the pool, so no-one can access it. */
> +		spin_lock(&vn->pool_lock);
> +		list_replace_init(&vn->pool[i].head, &tmp_list);
> +		spin_unlock(&vn->pool_lock);
> +
> +		if (full_decay)
> +			WRITE_ONCE(vn->pool[i].len, 0);
> +
> +		/* Decay a pool by ~25% out of left objects. */
> +		n_decay = vn->pool[i].len >> 2;
> +
> +		list_for_each_entry_safe(va, nva, &tmp_list, list) {
> +			list_del_init(&va->list);
> +			merge_or_add_vmap_area(va, &decay_root, &decay_list);
> +
> +			if (!full_decay) {
> +				WRITE_ONCE(vn->pool[i].len, vn->pool[i].len - 1);
> +
> +				if (!--n_decay)
> +					break;
> +			}
> +		}
> +
> +		/* Attach the pool back if it has been partly decayed. */
> +		if (!full_decay && !list_empty(&tmp_list)) {
> +			spin_lock(&vn->pool_lock);
> +			list_replace_init(&tmp_list, &vn->pool[i].head);
> +			spin_unlock(&vn->pool_lock);
> +		}
> +	}
> +
> +	reclaim_list_global(&decay_list);
> +}
> +
> +static void purge_vmap_node(struct work_struct *work)
> +{
> +	struct vmap_node *vn = container_of(work,
> +		struct vmap_node, purge_work);
> +	struct vmap_area *va, *n_va;
> +	LIST_HEAD(local_list);
> +
> +	vn->nr_purged = 0;
> +
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
>  		unsigned long orig_end = va->va_end;
> +		unsigned int vn_id = decode_vn_id(va->flags);
>  
> -		/*
> -		 * Finally insert or merge lazily-freed area. It is
> -		 * detached and there is no need to "unlink" it from
> -		 * anything.
> -		 */
> -		va = merge_or_add_vmap_area_augment(va, &free_vmap_area_root,
> -				&free_vmap_area_list);
> -
> -		if (!va)
> -			continue;
> +		list_del_init(&va->list);
>  
>  		if (is_vmalloc_or_module_addr((void *)orig_start))
>  			kasan_release_vmalloc(orig_start, orig_end,
>  					      va->va_start, va->va_end);
>  
>  		atomic_long_sub(nr, &vmap_lazy_nr);
> -		num_purged_areas++;
> +		vn->nr_purged++;
> +
> +		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
> +			if (node_pool_add_va(vn, va))
> +				continue;
> +
> +		/* Go back to global. */
> +		list_add(&va->list, &local_list);
>  	}
> -	spin_unlock(&free_vmap_area_lock);
>  
> -	return num_purged_areas;
> +	reclaim_list_global(&local_list);
>  }
>  
>  /*
>   * Purges all lazily-freed vmap areas.
>   */
> -static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
> +static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
> +		bool full_pool_decay)
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
>  	for (i = 0; i < nr_vmap_nodes; i++) {
>  		vn = &vmap_nodes[i];
>  
>  		INIT_LIST_HEAD(&vn->purge_list);
> +		vn->skip_populate = full_pool_decay;
> +		decay_va_pool_node(vn, full_pool_decay);
>  
>  		if (RB_EMPTY_ROOT(&vn->lazy.root))
>  			continue;
> @@ -1845,17 +2102,45 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
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
>  		for_each_cpu(i, &purge_nodes) {
> -			vn = &nodes[i];
> -			num_purged_areas += purge_vmap_node(vn);
> +			vn = &vmap_nodes[i];
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
> +		for_each_cpu(i, &purge_nodes) {
> +			vn = &vmap_nodes[i];
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
> @@ -1866,14 +2151,14 @@ static void reclaim_and_purge_vmap_areas(void)
>  {
>  	mutex_lock(&vmap_purge_lock);
>  	purge_fragmented_blocks_allcpus();
> -	__purge_vmap_area_lazy(ULONG_MAX, 0);
> +	__purge_vmap_area_lazy(ULONG_MAX, 0, true);
>  	mutex_unlock(&vmap_purge_lock);
>  }
>  
>  static void drain_vmap_area_work(struct work_struct *work)
>  {
>  	mutex_lock(&vmap_purge_lock);
> -	__purge_vmap_area_lazy(ULONG_MAX, 0);
> +	__purge_vmap_area_lazy(ULONG_MAX, 0, false);
>  	mutex_unlock(&vmap_purge_lock);
>  }
>  
> @@ -1884,9 +2169,10 @@ static void drain_vmap_area_work(struct work_struct *work)
>   */
>  static void free_vmap_area_noflush(struct vmap_area *va)
>  {
> -	struct vmap_node *vn = addr_to_node(va->va_start);
>  	unsigned long nr_lazy_max = lazy_max_pages();
>  	unsigned long va_start = va->va_start;
> +	unsigned int vn_id = decode_vn_id(va->flags);
> +	struct vmap_node *vn;
>  	unsigned long nr_lazy;
>  
>  	if (WARN_ON_ONCE(!list_empty(&va->list)))
> @@ -1896,10 +2182,14 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>  				PAGE_SHIFT, &vmap_lazy_nr);
>  
>  	/*
> -	 * Merge or place it to the purge tree/list.
> +	 * If it was request by a certain node we would like to
> +	 * return it to that node, i.e. its pool for later reuse.
>  	 */
> +	vn = is_vn_id_valid(vn_id) ?
> +		id_to_node(vn_id):addr_to_node(va->va_start);
> +
>  	spin_lock(&vn->lazy.lock);
> -	merge_or_add_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
> +	insert_vmap_area(va, &vn->lazy.root, &vn->lazy.head);
>  	spin_unlock(&vn->lazy.lock);
>  
>  	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
> @@ -2408,7 +2698,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  	}
>  	free_purged_blocks(&purge_list);
>  
> -	if (!__purge_vmap_area_lazy(start, end) && flush)
> +	if (!__purge_vmap_area_lazy(start, end, false) && flush)
>  		flush_tlb_kernel_range(start, end);
>  	mutex_unlock(&vmap_purge_lock);
>  }
> @@ -4576,7 +4866,7 @@ static void vmap_init_free_space(void)
>  static void vmap_init_nodes(void)
>  {
>  	struct vmap_node *vn;
> -	int i;
> +	int i, j;
>  
>  	for (i = 0; i < nr_vmap_nodes; i++) {
>  		vn = &vmap_nodes[i];
> @@ -4587,6 +4877,13 @@ static void vmap_init_nodes(void)
>  		vn->lazy.root = RB_ROOT;
>  		INIT_LIST_HEAD(&vn->lazy.head);
>  		spin_lock_init(&vn->lazy.lock);
> +
> +		for (j = 0; j < MAX_VA_SIZE_PAGES; j++) {
> +			INIT_LIST_HEAD(&vn->pool[j].head);
> +			WRITE_ONCE(vn->pool[j].len, 0);
> +		}
> +
> +		spin_lock_init(&vn->pool_lock);
>  	}
>  }
>  
> -- 
> 2.39.2
> 


