Return-Path: <linux-kernel+bounces-125732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35780892B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE772831AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671E29CEF;
	Sat, 30 Mar 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf2FMaJp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF717BDA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711804903; cv=none; b=Pmgqy/XtLpFNqCNwzHxWuNAQ59xDB3hq3gb5DhwRPPzXFhQ5uW+9JIk8OPsAO5VCUkTnaBOjKkk7JMmQxaL4Mz5QVycE3DDUY9dsQ1SqAWaY5GeYZ3o3NEy1xKCPE6iGLDJZQD8Zj2ODyvmBbsWhPQ6H0MZKK4yB0AWmlqD4Yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711804903; c=relaxed/simple;
	bh=OtAyZUNpiaaK9FBAJWzURMHRnhhBulYXRkIxckgdySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI9yM1E7OBY1s7eR/vTLd25EA6Ug254AZAJwe+LHwsy4IvGJHLl1P2FZcsan2JxyqG8HriV7fVumRKWGxF2CXbvIWac81YWe0GVl0lkzsI5ObJJ0sd0pCmic9Xrtd8ZLwlJqDYykf9TIdvXHf/NQ1lMq76zUD1aF9sruf9wRvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pf2FMaJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711804899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnvnhMuSGBykpK5jfG/3fZk4ulDz//mFCyfnQdVS0v4=;
	b=Pf2FMaJpiKgQRquNKS2WBzc/KlNQ+K7XgpTbFMACOxsA5WZhhOE7HUAuS7gNBxkb8EliSK
	jNOBYADHKYk1BOxN1etr0sMO4u4IHyG5EgT67kF3YfhBZnJz9YYXXm7RacvZusHypm4TSa
	2Yw1T/7abWFfH96bGt1oWlL9dU7OS24=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0Q0k-nFKMZiDJ1ixXK3iJA-1; Sat, 30 Mar 2024 09:21:35 -0400
X-MC-Unique: 0Q0k-nFKMZiDJ1ixXK3iJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D839101A552;
	Sat, 30 Mar 2024 13:21:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6041C060D0;
	Sat, 30 Mar 2024 13:21:32 +0000 (UTC)
Date: Sat, 30 Mar 2024 21:21:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix lockdep warning
Message-ID: <ZggR1fW0rAHSKF+j@MiWiFi-R3L-srv>
References: <20240328140330.4747-1-urezki@gmail.com>
 <ZgZxaOg6/qZAfUUA@MiWiFi-R3L-srv>
 <ZggLwbnaeK0AsRwQ@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZggLwbnaeK0AsRwQ@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 03/30/24 at 01:55pm, Uladzislau Rezki wrote:
> On Fri, Mar 29, 2024 at 03:44:40PM +0800, Baoquan He wrote:
> > On 03/28/24 at 03:03pm, Uladzislau Rezki (Sony) wrote:
.....snip 
> > How about below change about va_start_lowest? Personal preference, not
> > strong opinion.
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 9b1a41e12d70..bd6a66c54ad2 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1046,19 +1046,19 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> >  static struct vmap_node *
> >  find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
> >  {
> > -	unsigned long va_start_lowest;
> > +	unsigned long va_start_lowest = ULONG_MAX;
> >  	struct vmap_node *vn;
> >  	int i;
> >  
> >  repeat:
> > -	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
> > +	for (i = 0; i < nr_vmap_nodes; i++) {
> >  		vn = &vmap_nodes[i];
> >  
> >  		spin_lock(&vn->busy.lock);
> >  		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> >  
> >  		if (*va)
> > -			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
> > +			if ((*va)->va_start < va_start_lowest)
> >  				va_start_lowest = (*va)->va_start;
> >  		spin_unlock(&vn->busy.lock);
> >  	}
> > @@ -1069,7 +1069,7 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
> >  	 * been removed concurrently thus we need to proceed
> >  	 * with next one what is a rare case.
> >  	 */
> > -	if (va_start_lowest) {
> > +	if (va_start_lowest != ULONG_MAX) {
> >  		vn = addr_to_node(va_start_lowest);
> >  
> >  		spin_lock(&vn->busy.lock);
> > 
> > 
> To me it looks as incomplete. The "va_start_lowest" should be initialized
> when repeat. Otherwise we can end up with an infinite repeating because
> va_start_lowest != ULONG_MAX.

You are right. Anyway, it's just a suggestion from a different code
style, please feel free to adjust it in or leave the patch as is.
> 
> > >  	}
> > >  
> > > -	return va_node;
> > > -}
> > > -
> > > -static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> > > -{
> > > -	struct rb_node *n = root->rb_node;
> > > +	/*
> > > +	 * Check if found VA exists, it might it is gone away.
> >                                         ~~~~ grammer mistake?
> > > +	 * In this case we repeat the search because a VA has
> > > +	 * been removed concurrently thus we need to proceed
> > > +	 * with next one what is a rare case.
> >                          ~~~~ typo, which?
> > > +	 */
> > > +	if (va_start_lowest) {
> > > +		vn = addr_to_node(va_start_lowest);
> > >  
> > > -	addr = (unsigned long)kasan_reset_tag((void *)addr);
> > > +		spin_lock(&vn->busy.lock);
> > > +		*va = __find_vmap_area(va_start_lowest, &vn->busy.root);
> > >  
> > > -	while (n) {
> > > -		struct vmap_area *va;
> > > +		if (*va)
> > > +			return vn;
> > >  
> > > -		va = rb_entry(n, struct vmap_area, rb_node);
> > > -		if (addr < va->va_start)
> > > -			n = n->rb_left;
> > > -		else if (addr >= va->va_end)
> > > -			n = n->rb_right;
> > > -		else
> > > -			return va;
> > > +		spin_unlock(&vn->busy.lock);
> > > +		goto repeat;
> > >  	}
> > 
> > Other than above nickpick concerns, this looks good to me.
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > 
> Thank you!
> 
> --
> Uladzislau Rezki
> 


