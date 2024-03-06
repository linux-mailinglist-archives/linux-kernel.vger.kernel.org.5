Return-Path: <linux-kernel+bounces-94004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22E87382B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D771C20B96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5B13174E;
	Wed,  6 Mar 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0IRwmaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05A130E4A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733333; cv=none; b=V13Mwy/RIUEPWWsEPTJdlaqQtCrqEwiAdC276J1tlW+szAwZr694FiLvjRTKw4pKhcUdHQVUeav22cuIB2iajYrX+3QP45k7dYx8J67GV9lcu5M7k7w6s0QgjECRKzt4XtVl8os9p2aS2ShB9o7OjpXvYhfVjBbAsssiB7iyBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733333; c=relaxed/simple;
	bh=FDHDbMkueElepj6CmPwUCfRz0jklGor2baIcAzKQadE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLTY75W20MVzjIPCMN9sI2A04RBsc/wQ3AExdcSbMjBPbWgUwDfTp7eTVbFePh6zBpyi2rMtScP2bkDi/yuvJyYJfxQwEAU6UPeLNVPjQRyLs7JRKnt5RiItgdtRR5mFrJrgOPiIrq5GgaiVGxHakiBy+kO2dwYi0nWJu9Ss1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0IRwmaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709733331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VS0cZXpWU84KGIQ0BKcm27vCqjgjrA0pw8rcYtG8Uos=;
	b=W0IRwmaKzLmtVSRk3BRS6R4JAjqLWIAC/4p6xRGU8ueBCqWsDtq6SzIWgKOAJ3cJ4Z+zfs
	btmA6Vc3LPUXqdrHMTKb5OgEjMfyowuWgxs+qtUhM1Bk4792ZoKfAFrtMwfbY88eA+GhFF
	IE7LcCT/3OwflHSjIBF0sd1HzDLnV6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-mpRM26vHPxCGp_nstlCdhQ-1; Wed, 06 Mar 2024 08:55:27 -0500
X-MC-Unique: mpRM26vHPxCGp_nstlCdhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322298007AB;
	Wed,  6 Mar 2024 13:55:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D1C4C04121;
	Wed,  6 Mar 2024 13:55:26 +0000 (UTC)
Date: Wed, 6 Mar 2024 21:55:22 +0800
From: Baoquan He <bhe@redhat.com>
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, akpm@linux-foundation.org, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 2/2] mm/vmalloc: Eliminated the lock contention from
 twice to once
Message-ID: <Zeh1yuUq3jb+B6Tx@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-3-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301155417.1852290-3-rulin.huang@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 03/01/24 at 10:54am, rulinhuang wrote:
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
> ---
>  mm/vmalloc.c | 52 ++++++++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index fc027a61c12e..5b7c9156d8da 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1972,15 +1972,26 @@ node_alloc(unsigned long size, unsigned long align,
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
> @@ -2043,6 +2054,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = (va_flags | vn_id);
>  
> +	if (vm) {
> +		BUG_ON(va_flags & VMAP_RAM);
> +		setup_vmalloc_vm(vm, va, flags, caller);
> +	}
> +
>  	vn = addr_to_node(va->va_start);
>  
>  	spin_lock(&vn->busy.lock);
> @@ -2486,7 +2502,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
>  					node, gfp_mask,
> -					VMAP_RAM|VMAP_BLOCK);
> +					VMAP_RAM|VMAP_BLOCK, NULL,
> +					0, NULL);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2843,7 +2860,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END,
> -				node, GFP_KERNEL, VMAP_RAM);
> +				node, GFP_KERNEL, VMAP_RAM,
> +				NULL, 0, NULL);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2946,26 +2964,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
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
> @@ -3002,14 +3000,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
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
> @@ -4584,7 +4580,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  
>  		spin_lock(&vn->busy.lock);
>  		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
> -		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> +		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
>  		spin_unlock(&vn->busy.lock);
>  	}
> -- 
> 2.43.0
> 


