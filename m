Return-Path: <linux-kernel+bounces-93971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795C8737A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E315B21F21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB5130AFC;
	Wed,  6 Mar 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8R82yL1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F712D1FC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731414; cv=none; b=QEelLEXAN1iXp6NhX5504j3woT35LdCYbrcR/aotETTCJ04AixfyjXf0migDidb7I2MU5Wo9T71zvMVRjM95SknBvxbicFtVkepTFs0DtIXeXrw4vBylB9XypABbyqNsM7B6P1DZkunKM2aEtFIu2yLCZxinNJAoNEE5FvBm1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731414; c=relaxed/simple;
	bh=rKW3ft37ZMKSqEXYm/vAWr2d6eCNLj10DGC2XshvqDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOMNMnma4JOLFcJLBsu9pkK7I9M0cX39pzsyfaX+hi839y7bOUR0EBKjuADom27DhbF/KwDvifg8qD/O1JY3CpnFEkwY9kx68e0lMUtvAt+ZoUf9+plNpF/kN/wyLxIeuWDEyASs8hU1F4qIbPyoOnx2A8LIPdp5OHnF2LLXH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8R82yL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709731411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaQGurn/ktHKXD7AUOUSUDulwzVJEBlYlsg/v+7xnJg=;
	b=G8R82yL11i53emwhSz0VBFbbVEzCsdaZAIVlhC6431E6NhqgIoDY9mH1uaI0UHzRFjCl7I
	d0BcuHP3/8lPNvU9lbTmS54m1I8QYp3wlTazE3A31/l1GrP9eC+zQXdb4OLt1MwgLjmxgi
	ApSFIyQyHGA7dYajinI/iq5jZv+N7i8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-9LQ1wa9LMnaK3oyuuQWzHw-1; Wed, 06 Mar 2024 08:23:26 -0500
X-MC-Unique: 9LQ1wa9LMnaK3oyuuQWzHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BB648007A1;
	Wed,  6 Mar 2024 13:23:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3015E40C6CBC;
	Wed,  6 Mar 2024 13:23:23 +0000 (UTC)
Date: Wed, 6 Mar 2024 21:23:21 +0800
From: Baoquan He <bhe@redhat.com>
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, akpm@linux-foundation.org, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZehuScJSsyHMVVhp@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301155417.1852290-2-rulin.huang@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Sorry, I missed this patchset in my mail box.

On 03/01/24 at 10:54am, rulinhuang wrote:
> Moved data structures and basic helpers related to per cpu kva allocator
  ~~~ s/Moved/move/? And the subject too?
> up too to along with these macros with no functional change happened.

Maybe we should add below line to tell why the moving need be done.

This is in preparation for later VMAP_RAM checking in alloc_vmap_area().

Other than above nitpicks, this looks good to me. If you update
this patch log and post a new version, please feel free to add:

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
> V6 -> V7: Adjusted the macros
> ---
>  mm/vmalloc.c | 262 +++++++++++++++++++++++++--------------------------
>  1 file changed, 131 insertions(+), 131 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 25a8df497255..fc027a61c12e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -887,6 +887,137 @@ is_vn_id_valid(unsigned int node_id)
>  	return false;
>  }
>  
> +/*
> + * vmap space is limited especially on 32 bit architectures. Ensure there is
> + * room for at least 16 percpu vmap blocks per CPU.
> + */
> +/*
> + * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
> + * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
> + * instead (we just need a rough idea)
> + */
> +#if BITS_PER_LONG == 32
> +#define VMALLOC_SPACE		(128UL*1024*1024)
> +#else
> +#define VMALLOC_SPACE		(128UL*1024*1024*1024)
> +#endif
> +
> +#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
> +#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
> +#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
> +#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
> +#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> +#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
> +#define VMAP_BBMAP_BITS		\
> +		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
> +		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
> +			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
> +
> +#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> +
> +/*
> + * Purge threshold to prevent overeager purging of fragmented blocks for
> + * regular operations: Purge if vb->free is less than 1/4 of the capacity.
> + */
> +#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
> +
> +#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> +#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> +#define VMAP_FLAGS_MASK		0x3
> +
> +struct vmap_block_queue {
> +	spinlock_t lock;
> +	struct list_head free;
> +
> +	/*
> +	 * An xarray requires an extra memory dynamically to
> +	 * be allocated. If it is an issue, we can use rb-tree
> +	 * instead.
> +	 */
> +	struct xarray vmap_blocks;
> +};
> +
> +struct vmap_block {
> +	spinlock_t lock;
> +	struct vmap_area *va;
> +	unsigned long free, dirty;
> +	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
> +	unsigned long dirty_min, dirty_max; /*< dirty range */
> +	struct list_head free_list;
> +	struct rcu_head rcu_head;
> +	struct list_head purge;
> +};
> +
> +/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> +static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> +
> +/*
> + * In order to fast access to any "vmap_block" associated with a
> + * specific address, we use a hash.
> + *
> + * A per-cpu vmap_block_queue is used in both ways, to serialize
> + * an access to free block chains among CPUs(alloc path) and it
> + * also acts as a vmap_block hash(alloc/free paths). It means we
> + * overload it, since we already have the per-cpu array which is
> + * used as a hash table. When used as a hash a 'cpu' passed to
> + * per_cpu() is not actually a CPU but rather a hash index.
> + *
> + * A hash function is addr_to_vb_xa() which hashes any address
> + * to a specific index(in a hash) it belongs to. This then uses a
> + * per_cpu() macro to access an array with generated index.
> + *
> + * An example:
> + *
> + *  CPU_1  CPU_2  CPU_0
> + *    |      |      |
> + *    V      V      V
> + * 0     10     20     30     40     50     60
> + * |------|------|------|------|------|------|...<vmap address space>
> + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> + *
> + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> + *
> + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> + *
> + * This technique almost always avoids lock contention on insert/remove,
> + * however xarray spinlocks protect against any contention that remains.
> + */
> +static struct xarray *
> +addr_to_vb_xa(unsigned long addr)
> +{
> +	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +
> +	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> +}
> +
> +/*
> + * We should probably have a fallback mechanism to allocate virtual memory
> + * out of partially filled vmap blocks. However vmap block sizing should be
> + * fairly reasonable according to the vmalloc size, so it shouldn't be a
> + * big problem.
> + */
> +
> +static unsigned long addr_to_vb_idx(unsigned long addr)
> +{
> +	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> +	addr /= VMAP_BLOCK_SIZE;
> +	return addr;
> +}
> +
> +static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> +{
> +	unsigned long addr;
> +
> +	addr = va_start + (pages_off << PAGE_SHIFT);
> +	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> +	return (void *)addr;
> +}
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {
> @@ -2327,137 +2458,6 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  
>  /*** Per cpu kva allocator ***/
>  
> -/*
> - * vmap space is limited especially on 32 bit architectures. Ensure there is
> - * room for at least 16 percpu vmap blocks per CPU.
> - */
> -/*
> - * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
> - * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
> - * instead (we just need a rough idea)
> - */
> -#if BITS_PER_LONG == 32
> -#define VMALLOC_SPACE		(128UL*1024*1024)
> -#else
> -#define VMALLOC_SPACE		(128UL*1024*1024*1024)
> -#endif
> -
> -#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
> -#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
> -#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
> -#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
> -#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
> -#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
> -#define VMAP_BBMAP_BITS		\
> -		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
> -		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
> -			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
> -
> -#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> -
> -/*
> - * Purge threshold to prevent overeager purging of fragmented blocks for
> - * regular operations: Purge if vb->free is less than 1/4 of the capacity.
> - */
> -#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
> -
> -#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
> -#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> -#define VMAP_FLAGS_MASK		0x3
> -
> -struct vmap_block_queue {
> -	spinlock_t lock;
> -	struct list_head free;
> -
> -	/*
> -	 * An xarray requires an extra memory dynamically to
> -	 * be allocated. If it is an issue, we can use rb-tree
> -	 * instead.
> -	 */
> -	struct xarray vmap_blocks;
> -};
> -
> -struct vmap_block {
> -	spinlock_t lock;
> -	struct vmap_area *va;
> -	unsigned long free, dirty;
> -	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
> -	unsigned long dirty_min, dirty_max; /*< dirty range */
> -	struct list_head free_list;
> -	struct rcu_head rcu_head;
> -	struct list_head purge;
> -};
> -
> -/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> -static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> -
> -/*
> - * In order to fast access to any "vmap_block" associated with a
> - * specific address, we use a hash.
> - *
> - * A per-cpu vmap_block_queue is used in both ways, to serialize
> - * an access to free block chains among CPUs(alloc path) and it
> - * also acts as a vmap_block hash(alloc/free paths). It means we
> - * overload it, since we already have the per-cpu array which is
> - * used as a hash table. When used as a hash a 'cpu' passed to
> - * per_cpu() is not actually a CPU but rather a hash index.
> - *
> - * A hash function is addr_to_vb_xa() which hashes any address
> - * to a specific index(in a hash) it belongs to. This then uses a
> - * per_cpu() macro to access an array with generated index.
> - *
> - * An example:
> - *
> - *  CPU_1  CPU_2  CPU_0
> - *    |      |      |
> - *    V      V      V
> - * 0     10     20     30     40     50     60
> - * |------|------|------|------|------|------|...<vmap address space>
> - *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> - *
> - * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> - *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> - *
> - * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> - *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> - *
> - * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> - *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> - *
> - * This technique almost always avoids lock contention on insert/remove,
> - * however xarray spinlocks protect against any contention that remains.
> - */
> -static struct xarray *
> -addr_to_vb_xa(unsigned long addr)
> -{
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> -
> -	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> -}
> -
> -/*
> - * We should probably have a fallback mechanism to allocate virtual memory
> - * out of partially filled vmap blocks. However vmap block sizing should be
> - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> - * big problem.
> - */
> -
> -static unsigned long addr_to_vb_idx(unsigned long addr)
> -{
> -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> -	addr /= VMAP_BLOCK_SIZE;
> -	return addr;
> -}
> -
> -static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> -{
> -	unsigned long addr;
> -
> -	addr = va_start + (pages_off << PAGE_SHIFT);
> -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> -	return (void *)addr;
> -}
> -
>  /**
>   * new_vmap_block - allocates new vmap_block and occupies 2^order pages in this
>   *                  block. Of course pages number can't exceed VMAP_BBMAP_BITS
> -- 
> 2.43.0
> 


