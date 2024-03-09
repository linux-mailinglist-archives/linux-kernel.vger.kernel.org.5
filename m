Return-Path: <linux-kernel+bounces-97772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569D876F38
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D976B21419
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B761E533;
	Sat,  9 Mar 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAgjFgXV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06577210FF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709960095; cv=none; b=cQMdQqqBenlt2UIe1TNa30buEAeVyAS0hiwYkwylHONiLGkRsUcWc6004uNW9DLSGPT5RSgTKZNzNULHG9YMDr5PaHqT30bQA9AKaae17BlXoanzWvOo9hv3WFxHkTCiET9HH1Nzdp+aYcep8RM173Zj5xKOWhPy3glUE5jr6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709960095; c=relaxed/simple;
	bh=rfHyP0lQSK3aKFLJiISKeFx8KD/1QOqU9uwMThFCDcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwOMOOIPWfBcCN1I/bILsayh0WI5JK4K1ZHzOb2EI8/7bOPanH64z4SzqBMkp9n7oa3l2/m00I3rGIo72vTPjRTiXh/oCmbchceG11Y4LoRJVIe22MP6pHBbsSk9oImF7WH8J82LH85eQ7PGvovXdXOkb6jK6+HwhagrCeWig18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAgjFgXV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709960091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rWyrsf0w2AweKgC2cynq9jkTg3n3/2JTrcPx96wv4M=;
	b=OAgjFgXViUusXI33BItStkGAFalA3R9nK4qBZIu7Mkf6wN4QS3Q6PLPM77Ymtl6V+1qU0d
	BN6FwI4gxbJ02B994ks4XYFcSR/f4zbpSD/IQjv7PMuj7M2pDpg/5ZIHDyv/eRoF7BAaec
	h6S2PaaxVj26pIezG7nuuJwpbiaG6G8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-2pYKs7cqPpuiZ4Iya-GZmg-1; Fri,
 08 Mar 2024 23:54:45 -0500
X-MC-Unique: 2pYKs7cqPpuiZ4Iya-GZmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 686AD3806708;
	Sat,  9 Mar 2024 04:54:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A89FC112131D;
	Sat,  9 Mar 2024 04:54:43 +0000 (UTC)
Date: Sat, 9 Mar 2024 12:54:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: rulinhuang <rulin.huang@intel.com>, akpm@linux-foundation.org,
	colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZevrkCCDG/7WKBYm@MiWiFi-R3L-srv>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <ZeoSiP-hOeHG89BJ@pc638.lan>
 <ZerLB/LNWAOvC2HM@MiWiFi-R3L-srv>
 <ZeroNTcyEMx6jiZF@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeroNTcyEMx6jiZF@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/08/24 at 11:28am, Uladzislau Rezki wrote:
> > > I would remove it, because it is really hard to mess it, there is only
> > > one place also BUG_ON() is really a show stopper. I really appreciate
> > > what rulinhuang <rulin.huang@intel.com> is doing and i understand that
> > > it might be not so easy.
> > 
> > I agree, I was hesitant, now it firms up my mind.
> > 
> > > 
> > > So, if we can avoid of moving the code, that looks to me that we can do,
> > > if we can pass less arguments into alloc_vmap_area() since it is overloaded 
> > > that would be great.
> > 
> > Agree too, less arguments is much better. While I personnally prefer the open
> > coding a little bit like below. There is suspicion of excessive packaging in
> > __pre/__post_setup_vmalloc_vm() wrapping. They are very simple and few
> > assignments after all. 
> > 
> > ---
> >  mm/vmalloc.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 0fd8ebaad17b..0c738423976d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1924,8 +1924,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  				unsigned long align,
> >  				unsigned long vstart, unsigned long vend,
> >  				int node, gfp_t gfp_mask,
> > -				unsigned long va_flags, struct vm_struct *vm,
> > -				unsigned long flags, const void *caller)
> > +				unsigned long va_flags, struct vm_struct *vm)
> >  {
> >  	struct vmap_node *vn;
> >  	struct vmap_area *va;
> > @@ -1988,8 +1987,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	va->vm = NULL;
> >  	va->flags = (va_flags | vn_id);
> >  
> > -	if (vm)
> > -		setup_vmalloc_vm(vm, va, flags, caller);
> > +	if (vm) {
> > +		vm->addr = (void *)va->va_start;
> > +		vm->size = va->va_end - va->va_start;
> > +		va->vm = vm;
> > +	}
> >  
> >  	vn = addr_to_node(va->va_start);
> >  
> > @@ -2565,8 +2567,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
> >  					VMALLOC_START, VMALLOC_END,
> >  					node, gfp_mask,
> > -					VMAP_RAM|VMAP_BLOCK, NULL,
> > -					0, NULL);
> > +					VMAP_RAM|VMAP_BLOCK, NULL);
> >  	if (IS_ERR(va)) {
> >  		kfree(vb);
> >  		return ERR_CAST(va);
> > @@ -2924,7 +2925,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> >  		va = alloc_vmap_area(size, PAGE_SIZE,
> >  				VMALLOC_START, VMALLOC_END,
> >  				node, GFP_KERNEL, VMAP_RAM,
> > -				NULL, 0, NULL);
> > +				NULL);
> >  		if (IS_ERR(va))
> >  			return NULL;
> >  
> > @@ -3063,7 +3064,10 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
> >  	if (!(flags & VM_NO_GUARD))
> >  		size += PAGE_SIZE;
> >  
> > -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
> > +	area->flags = flags;
> > +	area->caller = caller;
> > +
> > +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
> >  	if (IS_ERR(va)) {
> >  		kfree(area);
> >  		return NULL;
> > -- 
> > 2.41.0
> > 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Looks even better :) It can be applied on on top of:
> 
> [PATCH v8] mm/vmalloc: Eliminated the lock contention from twice to once
> 
> We are a bit ahead since v8 will be taken later. Anyway please use the
> reviewed-by tag once you send a complete patch. 

Thanks, have posted.


