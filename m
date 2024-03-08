Return-Path: <linux-kernel+bounces-96646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637D875F61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883B41C20897
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7B51C33;
	Fri,  8 Mar 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUWStFcN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A822B9CD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886232; cv=none; b=SyUCH7Y/e8y3mYVFvD7lvA9m/EKPhV8u8LMO3/ZDVbdBOqdB3fi635WD2XIrekB1SvaKyBaLKDshuoigk5Uvxc+u7dxse4SX3mwnIfs5wDAnLUnS+3lIfD4bs1f47Tf7CCS3Yiy5a3hW16gthiypwP8bK1j3U4WSLeaICj3ySZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886232; c=relaxed/simple;
	bh=t0yiUDttfghyCwCdXVElpqyZr+Y67DCgy6RmorVm/ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6mn4ZShgBEgyk2aiMBYwWlA6uF1Ze8yXt3HjjjE/j9/KLqBf9CSgwQRaROamIQmg93m3GB4sf4I25KcMqqyrE2MR1V4dJLJ20lRJfmNuScQCeNysYYqGAMhKrEAO3eIZtTrqKlbd1UJScp2BZxwQjHxmZIHgCAfpKxo1/NzPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUWStFcN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709886229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaoVjEwEAGh6LlluyS+mmIgBwGX5K9uW9cbG7rfkPo8=;
	b=BUWStFcNf1pLQ8TXAtiwUJki5QiB3XAPF65yXMxscYd53pteZ3bOE3QdHxlCIjWXyOW0WI
	pxJvae+7VyTO5I+1SJTGVQ5L/MA8bR32mblXuTzGxcOz3yEaoJ5eI2T7keulW0pHB098sY
	XN02MlarZD33P9btttALAouj2QTD5hI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-jlJUUveVPGmrfJdNYPhgoQ-1; Fri,
 08 Mar 2024 03:23:45 -0500
X-MC-Unique: jlJUUveVPGmrfJdNYPhgoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1314E383CCE9;
	Fri,  8 Mar 2024 08:23:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1257C492BC6;
	Fri,  8 Mar 2024 08:23:43 +0000 (UTC)
Date: Fri, 8 Mar 2024 16:23:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: rulinhuang <rulin.huang@intel.com>, akpm@linux-foundation.org,
	colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZerLB/LNWAOvC2HM@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <ZeoSiP-hOeHG89BJ@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoSiP-hOeHG89BJ@pc638.lan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 03/07/24 at 08:16pm, Uladzislau Rezki wrote:
> On Thu, Mar 07, 2024 at 09:23:10AM +0800, Baoquan He wrote:
> > On 03/06/24 at 08:01pm, Uladzislau Rezki wrote:
> > > On Fri, Mar 01, 2024 at 10:54:16AM -0500, rulinhuang wrote:
> > ......
> > > 
> > > Sorry for the late answer, i also just noticed this email. It was not in
> > > my inbox...
> > > 
> > > OK, now you move part of the per-cpu allocator on the top and leave
> > > another part down making it split. This is just for the:
> > > 
> > > BUG_ON(va_flags & VMAP_RAM);
> > > 
> > > VMAP_RAM macro. Do we really need this BUG_ON()?
> > 
> > Sorry, I suggested that when reviewing v5:
> > https://lore.kernel.org/all/ZdiltpK5fUvwVWtD@MiWiFi-R3L-srv/T/#u
> > 
> > About part of per-cpu kva allocator moving and the split making, I would
> > argue that we will have vmap_nodes defintion and basic helper functions
> > like addr_to_node_id() etc at top, and leave other part like
> > size_to_va_pool(), node_pool_add_va() etc down. These are similar.
> > 
> > While about whether we should add 'BUG_ON(va_flags & VMAP_RAM);', I am
> > not sure about it. When I suggested that, I am also hesitant. From the
> > current code, alloc_vmap_area() is called in below three functions, only
> > __get_vm_area_node() will pass the non-NULL vm. 
> >  new_vmap_block()     -|
> >  vm_map_ram()         ----> alloc_vmap_area()
> >  __get_vm_area_node() -|
> > 
> > It could be wrongly passed in the future? Only checking if vm is
> > non-NULL makes me feel a little unsafe. While I am fine if removing the
> > BUG_ON, because there's no worry in the current code. We can wait and
> > see in the future.
> > 
> >        if (vm) {
> >                BUG_ON(va_flags & VMAP_RAM);
> >                setup_vmalloc_vm(vm, va, flags, caller);
> >        }
> > 
> I would remove it, because it is really hard to mess it, there is only
> one place also BUG_ON() is really a show stopper. I really appreciate
> what rulinhuang <rulin.huang@intel.com> is doing and i understand that
> it might be not so easy.

I agree, I was hesitant, now it firms up my mind.

> 
> So, if we can avoid of moving the code, that looks to me that we can do,
> if we can pass less arguments into alloc_vmap_area() since it is overloaded 
> that would be great.

Agree too, less arguments is much better. While I personnally prefer the open
coding a little bit like below. There is suspicion of excessive packaging in
__pre/__post_setup_vmalloc_vm() wrapping. They are very simple and few
assignments after all. 

---
 mm/vmalloc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0fd8ebaad17b..0c738423976d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1924,8 +1924,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask,
-				unsigned long va_flags, struct vm_struct *vm,
-				unsigned long flags, const void *caller)
+				unsigned long va_flags, struct vm_struct *vm)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
@@ -1988,8 +1987,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
-	if (vm)
-		setup_vmalloc_vm(vm, va, flags, caller);
+	if (vm) {
+		vm->addr = (void *)va->va_start;
+		vm->size = va->va_end - va->va_start;
+		va->vm = vm;
+	}
 
 	vn = addr_to_node(va->va_start);
 
@@ -2565,8 +2567,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK, NULL,
-					0, NULL);
+					VMAP_RAM|VMAP_BLOCK, NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2924,7 +2925,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
 				node, GFP_KERNEL, VMAP_RAM,
-				NULL, 0, NULL);
+				NULL);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -3063,7 +3064,10 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
+	area->flags = flags;
+	area->caller = caller;
+
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
-- 
2.41.0


> 
> Just an example:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 25a8df497255..b6050e018539 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1841,6 +1841,30 @@ node_alloc(unsigned long size, unsigned long align,
>  	return va;
>  }
>  
> +static inline void
> +__pre_setup_vmalloc_vm(struct vm_struct *vm,
> +		unsigned long flags, const void *caller)
> +{
> +	vm->flags = flags;
> +	vm->caller = caller;
> +}
> +
> +static inline void
> +__post_setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va)
> +{
> +	vm->addr = (void *)va->va_start;
> +	vm->size = va->va_end - va->va_start;
> +	va->vm = vm;
> +}
> +
> +static inline void
> +setup_vmalloc_vm_locked(struct vm_struct *vm, struct vmap_area *va,
> +		unsigned long flags, const void *caller)
> +{
> +	__pre_setup_vmalloc_vm(vm, flags, caller);
> +	__post_setup_vmalloc_vm(vm, va);
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
>   * vstart and vend.
> @@ -1849,7 +1873,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
>  				int node, gfp_t gfp_mask,
> -				unsigned long va_flags)
> +				unsigned long va_flags, struct vm_struct *vm)
>  {
>  	struct vmap_node *vn;
>  	struct vmap_area *va;
> @@ -1912,6 +1936,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = (va_flags | vn_id);
>  
> +	if (vm)
> +		__post_setup_vmalloc_vm(vm, va);
> +
>  	vn = addr_to_node(va->va_start);
>  
>  	spin_lock(&vn->busy.lock);
> @@ -2486,7 +2513,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
>  					node, gfp_mask,
> -					VMAP_RAM|VMAP_BLOCK);
> +					VMAP_RAM|VMAP_BLOCK, NULL);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2843,7 +2870,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END,
> -				node, GFP_KERNEL, VMAP_RAM);
> +				node, GFP_KERNEL, VMAP_RAM, NULL);
> +
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2946,26 +2974,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
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
> @@ -3002,14 +3010,15 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> +	/* post-setup is done in the alloc_vmap_area(). */
> +	__pre_setup_vmalloc_vm(area, flags, caller);
> +
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
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
> <snip>
> 
> --
> Uladzislau Rezki
> 


