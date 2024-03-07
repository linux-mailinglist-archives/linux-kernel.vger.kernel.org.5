Return-Path: <linux-kernel+bounces-94939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16318746EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6072E1F293A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4F1BC3F;
	Thu,  7 Mar 2024 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b308a0Ta"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BE1BC3E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782715; cv=none; b=iMmOU2HAYbdY+dWW52oMRvPAXpGSQ6C+KKfysgprF0vmQIBnEOIDFX1jnF3SF6y8kjnZkQt0XAG2dGr6Ln4f0sRQiM+KYaud8I5hQeJXTMngcDmeJlRqGSVKAWrhK6qFSzKpNIqp8mM8r31+DmuSf4Jd8IpuHDcfv+YPl8WNIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782715; c=relaxed/simple;
	bh=kxpc57kZvXLb5ERasWU3qCP4HD6Tkpsp57SaRit2Now=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsMCoJL1IOBTbtnL+aROvgGGyIjbX4Ps0Q+kPelmuT9gZLv44JE4i+PLBCwqnVQ9LMmj0O407QtqT39rG0D6UdHpNtQcZ1VxcwkMvd7eqG04zk5b/pBRBupXZj8wJFFNIQvC5tXYXebwKow48ahG5/t1XMkO1jyLKkn6bstscB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b308a0Ta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709782711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vznKFdjEQh3Hx7ci6OGrOLtatnJe9ZKpAF7T9E0NWA=;
	b=b308a0TaCDTJAmcPBWmAg+mHOLc/VXpKoIiihSy4g/8Epro+rzo3QDzjZQGO5y62PNPWRW
	nIpY7zNAVmzI7VPDrYGJU/7J598l94pZr/3xjTP1m4+/WBNzgrCwk4tU60mAv5nH3cZ3Ab
	QFsgsl2W2mH1d1cbXlxGNMH2LZWnt0c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-LvPdOutuOsmwRTPV4glN5Q-1; Wed,
 06 Mar 2024 22:38:29 -0500
X-MC-Unique: LvPdOutuOsmwRTPV4glN5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57FE31C41A0D;
	Thu,  7 Mar 2024 03:38:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A9ED2200B01D;
	Thu,  7 Mar 2024 03:38:27 +0000 (UTC)
Date: Thu, 7 Mar 2024 11:38:24 +0800
From: Baoquan He <bhe@redhat.com>
To: rulin.huang@intel.com
Cc: urezki@gmail.com, akpm@linux-foundation.org, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v8] mm/vmalloc: Eliminated the lock contention from twice
 to once
Message-ID: <Zek2sGrxAzrNlsZv@MiWiFi-R3L-srv>
References: <20240307021440.64967-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307021440.64967-1-rulin.huang@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/06/24 at 09:14pm, rulinhuang wrote:
> When allocating a new memory area where the mapping address range is
> known, it is observed that the vmap_node->busy.lock is acquired twice.
> 
> The first acquisition occurs in the alloc_vmap_area() function when
> inserting the vm area into the vm mapping red-black tree. The second
> acquisition occurs in the setup_vmalloc_vm() function when updating the
> properties of the vm, such as flags and address, etc.
> 
> Combine these two operations together in alloc_vmap_area(), which
> improves scalability when the vmap_node->busy.lock is contended.
> By doing so, the need to acquire the lock twice can also be eliminated
> to once.
> 
> With the above change, tested on intel sapphire rapids
> platform(224 vcpu), a 4% performance improvement is
> gained on stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
> which is the stress test of thread creations.
> 
> Co-developed-by: "Chen, Tim C" <tim.c.chen@intel.com>
> Signed-off-by: "Chen, Tim C" <tim.c.chen@intel.com>
> Co-developed-by: "King, Colin" <colin.king@intel.com>
> Signed-off-by: "King, Colin" <colin.king@intel.com>
> Signed-off-by: rulinhuang <rulin.huang@intel.com>
> ---
> V1 -> V2: Avoided the partial initialization issue of vm and
> separated insert_vmap_area() from alloc_vmap_area()
> V2 -> V3: Rebased on 6.8-rc5
> V3 -> V4: Rebased on mm-unstable branch
> V4 -> V5: Canceled the split of alloc_vmap_area()
> and keep insert_vmap_area()
> V5 -> V6: Added bug_on
> V6 -> V7: Adjusted the macros
> V7 -> V8: Removed bugs_on and adjustion of macros
> ---
>  mm/vmalloc.c | 50 ++++++++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 25a8df497255..f933a62fef50 100644
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
> @@ -3002,14 +2998,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
>  	}
>  
> -	setup_vmalloc_vm(area, va, flags, caller);
> -
>  	/*
>  	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
>  	 * best-effort approach, as they can be mapped outside of vmalloc code.
> @@ -4584,7 +4578,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  
>  		spin_lock(&vn->busy.lock);
>  		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
> -		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> +		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
>  		spin_unlock(&vn->busy.lock);
>  	}
> 
> base-commit: f4239a5d7acc1b5ff9bac4d5471000b952279ef0
> -- 
> 2.43.0
> 


