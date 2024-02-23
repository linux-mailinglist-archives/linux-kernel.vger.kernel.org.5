Return-Path: <linux-kernel+bounces-78437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC786137C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76691283FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD917FBC5;
	Fri, 23 Feb 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efHR4ON/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD697F460
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697031; cv=none; b=eG/oIdg9FDYrcxDBsteaQIn/TxplyUZ5UpkBRta4LJ+CY/YV0zjJeyCkCMtJFWoFAqv9COmJDtXh35FCQRwZTNUvJogG/U5z8aVpPJ0g1heC/gEKVByjFWq2KQbw42JjVRjEVqJavjJX3/r+G4Xfr0qyYgpKTrt8tbeEw9iDtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697031; c=relaxed/simple;
	bh=YXpg3mzmRNTgL/bgrgvTKdeThIxiarXfTS+HezeGh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHMIerw6qT124kLsG8Q1SgAd3zGQh9O3fTuCxAXnkhauYvxiLHv8Fvnk3omO7pniR6T1tF2AkwcZJdZRtcF4cEbWLrIGqFGsRYgpaChewbwt1J07q6x7A6zBYU1vCVhWdVU1BJRVvg1EFVLJUJm/GxODWTVH5FebqscfO2Ae9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efHR4ON/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708697029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0V31ObxG5auoCtgae8PDeH/jiF4IyClWW1aJTl3/qDg=;
	b=efHR4ON/sbVKhQZfboNI9D5op0h53/7+NdfFXuy+NATSJ99sjrCLgDVX984NAds9FCc6Hg
	ZrmqOPc+wY6UGSmFEbfTVgN33gCZKtrC9KedOuKzVFmsrxgk5eTX5ZHTBHEzFXFOV+IS2c
	jn+JXJCYdiVmkeigmalS4SkA++QBGmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-HkpALEzdO7yOzJBNqMB_1A-1; Fri, 23 Feb 2024 09:03:45 -0500
X-MC-Unique: HkpALEzdO7yOzJBNqMB_1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0182A862FDF;
	Fri, 23 Feb 2024 14:03:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ABF0200B251;
	Fri, 23 Feb 2024 14:03:43 +0000 (UTC)
Date: Fri, 23 Feb 2024 22:03:34 +0800
From: Baoquan He <bhe@redhat.com>
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v5] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZdiltpK5fUvwVWtD@MiWiFi-R3L-srv>
References: <20240207033059.1565623-1-rulin.huang@intel.com>
 <20240223130318.112198-2-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223130318.112198-2-rulin.huang@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Rulin,

On 02/23/24 at 08:03am, rulinhuang wrote:
> When allocating a new memory area where the mapping address range is
> known, it is observed that the vmap_area lock is acquired twice.
> The first acquisition occurs in the alloc_vmap_area() function when
> inserting the vm area into the vm mapping red-black tree. The second
> acquisition occurs in the setup_vmalloc_vm() function when updating the
> properties of the vm, such as flags and address, etc.
> Combine these two operations together in alloc_vmap_area(), which
> improves scalability when the vmap_area lock is contended. By doing so,
> the need to acquire the lock twice can also be eliminated.
> With the above change, tested on intel icelake platform(160 vcpu, kernel
> v6.7), a 6% performance improvement and a 7% reduction in overall
> spinlock hotspot are gained on
> stress-ng/pthread(https://github.com/ColinIanKing/stress-ng), which is
> the stress test of thread creations.

This log can be rearranged into several paragraphes for easier reading.

> 
> Reviewed-by: Chen Tim C <tim.c.chen@intel.com>
> Reviewed-by: King Colin <colin.king@intel.com>

Since you have taken different way to fix, these Reviewed-by from old
solution and patch should be removed. Carrying them is 

Yeah, this v5 is what I suggested in the draft. It looks good to me.
There's one concern in code, plesae see inline comment.

> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
> V1 -> V2: Avoided the partial initialization issue of vm and
> separated insert_vmap_area() from alloc_vmap_area()
> V2 -> V3: Rebased on 6.8-rc5
> V3 -> V4: Rebased on mm-unstable branch
> V4 -> V5: cancel the split of alloc_vmap_area()
> and keep insert_vmap_area()
> ---
>  mm/vmalloc.c | 48 ++++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 25a8df497255..6baaf08737f8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1841,15 +1841,26 @@ node_alloc(unsigned long size, unsigned long align,
>  	return va;
>  }
>  
> +static inline void setup_vmalloc_vm(struct vm_struct *vm,
> +	struct vmap_area *va, unsigned long flags, const void *caller)
> +{
> +	vm->flags = flags;
> +	vm->addr = (void *)va->va_start;
> +	vm->size = va->va_end - va->va_start;
> +	vm->caller = caller;
> +	va->vm = vm;
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
> - * vstart and vend.
> + * vstart and vend. If vm is passed in, the two will also be bound.
>   */
>  static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
>  				int node, gfp_t gfp_mask,
> -				unsigned long va_flags)
> +				unsigned long va_flags, struct vm_struct *vm,
> +				unsigned long flags, const void *caller)
>  {
>  	struct vmap_node *vn;
>  	struct vmap_area *va;
> @@ -1912,6 +1923,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = (va_flags | vn_id);
>  

We may need add a BUG_ON() or WARN_ON() checking if (va_flags & VMAP_RAM)
is true and vm is not NULL. Not sure if this is over thinking.

By the way, can you post it separately if you decide to post v6 to
polish the log and remove the ack tag? Sometime adding all posts in one
thread looks so confusing.

Thanks
Baoquan

> +	if (vm)
> +		setup_vmalloc_vm(vm, va, flags, caller);
> +
>  	vn = addr_to_node(va->va_start);
>  
>  	spin_lock(&vn->busy.lock);
> @@ -2486,7 +2500,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
>  					node, gfp_mask,
> -					VMAP_RAM|VMAP_BLOCK);
> +					VMAP_RAM|VMAP_BLOCK, NULL,
> +					0, NULL);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2843,7 +2858,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END,
> -				node, GFP_KERNEL, VMAP_RAM);
> +				node, GFP_KERNEL, VMAP_RAM,
> +				NULL, 0, NULL);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2946,26 +2962,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>  }
>  
> -static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
> -	struct vmap_area *va, unsigned long flags, const void *caller)
> -{
> -	vm->flags = flags;
> -	vm->addr = (void *)va->va_start;
> -	vm->size = va->va_end - va->va_start;
> -	vm->caller = caller;
> -	va->vm = vm;
> -}
> -
> -static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
> -			      unsigned long flags, const void *caller)
> -{
> -	struct vmap_node *vn = addr_to_node(va->va_start);
> -
> -	spin_lock(&vn->busy.lock);
> -	setup_vmalloc_vm_locked(vm, va, flags, caller);
> -	spin_unlock(&vn->busy.lock);
> -}
> -
>  static void clear_vm_uninitialized_flag(struct vm_struct *vm)
>  {
>  	/*
> @@ -3002,7 +2998,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
> @@ -4584,7 +4580,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  
>  		spin_lock(&vn->busy.lock);
>  		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
> -		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> +		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
>  		spin_unlock(&vn->busy.lock);
>  	}
> 
> base-commit: c09a8e005eff6c064e2e9f11549966c36a724fbf
> -- 
> 2.43.0
> 


