Return-Path: <linux-kernel+bounces-85010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6B86AF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6EA1F22E94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0613BBD9;
	Wed, 28 Feb 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR6EP4c2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89E73513
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123199; cv=none; b=SB4OCbH629jN+P2eNu6UyVvf0bXuIbjgVxWzUN1xrPnstSiSakFASvpR2CE9gQEEGYSHBAiXShHSkKr6wA/+PGmkO10U/zbKn2J7fuyfc9We1/aTitNJI47+YPjmmmZzrIQ0Xx0i4yA8zJnJhw07Brl8ZbsVf6XF8+TI8cMKjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123199; c=relaxed/simple;
	bh=VRPX8vusgT7bjSb0Awa16g019a+zyCgxgMgMpjkpYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9ouHRi6i/OzNw0HLdp+ZO6R7b3N+Q2yw+pqj0lNKmCe4EvkyzeSWAPW5bbTNqCc4rdK1JG9Ie0EZMLAxAP1OxQOkcxEheiBGqfILQ51MMQWro1IimG+tg8FBTxO67Ag6+c5TD4BzLqt3R0versVqKY0BnksZaUe1WQ57q1ViJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR6EP4c2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709123196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8T7na7hLDlOY+fpWxEVATnNGHZl5MLIMw+pfcdigZo=;
	b=bR6EP4c2tjVfyxRnX/ZKK9ZygAQZwNtnsdJTweFmITdJryOD01RAG/vVMm4Gi7pjpJzJ5i
	M37iw9qWVX7gzzeMg8zSZACCT83qgx96BQqWISTtKFxjxufLWMLhnBH9XFs502YHlrLPHI
	jO1tTkOZ+H9vIhP7h1533l6aFnOIPxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-BOHuYC_zNa-nq1ZE2WG5_Q-1; Wed, 28 Feb 2024 07:26:33 -0500
X-MC-Unique: BOHuYC_zNa-nq1ZE2WG5_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A50185A782;
	Wed, 28 Feb 2024 12:26:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF05610A58D9;
	Wed, 28 Feb 2024 12:26:31 +0000 (UTC)
Date: Wed, 28 Feb 2024 20:26:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
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
Message-ID: <Zd8mcuZeHKJJIjrj@MiWiFi-R3L-srv>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <Zd8BhUsh8sggG/RH@MiWiFi-R3L-srv>
 <Zd8NZFcNn5oekda4@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd8NZFcNn5oekda4@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/28/24 at 11:39am, Uladzislau Rezki wrote:
> On Wed, Feb 28, 2024 at 05:48:53PM +0800, Baoquan He wrote:
> > On 01/02/24 at 07:46pm, Uladzislau Rezki (Sony) wrote:
> > .....snip...
> > > +static void
> > > +decay_va_pool_node(struct vmap_node *vn, bool full_decay)
> > > +{
> > > +	struct vmap_area *va, *nva;
> > > +	struct list_head decay_list;
> > > +	struct rb_root decay_root;
> > > +	unsigned long n_decay;
> > > +	int i;
> > > +
> > > +	decay_root = RB_ROOT;
> > > +	INIT_LIST_HEAD(&decay_list);
> > > +
> > > +	for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
> > > +		struct list_head tmp_list;
> > > +
> > > +		if (list_empty(&vn->pool[i].head))
> > > +			continue;
> > > +
> > > +		INIT_LIST_HEAD(&tmp_list);
> > > +
> > > +		/* Detach the pool, so no-one can access it. */
> > > +		spin_lock(&vn->pool_lock);
> > > +		list_replace_init(&vn->pool[i].head, &tmp_list);
> > > +		spin_unlock(&vn->pool_lock);
> > > +
> > > +		if (full_decay)
> > > +			WRITE_ONCE(vn->pool[i].len, 0);
> > > +
> > > +		/* Decay a pool by ~25% out of left objects. */
> > 
> > This isn't true if the pool has less than 4 objects. If there are 3
> > objects, n_decay = 0.
> > 
> This is expectable.


> 
> > > +		n_decay = vn->pool[i].len >> 2;
> > > +
> > > +		list_for_each_entry_safe(va, nva, &tmp_list, list) {
> > > +			list_del_init(&va->list);
> > > +			merge_or_add_vmap_area(va, &decay_root, &decay_list);
> > > +
> > > +			if (!full_decay) {
> > > +				WRITE_ONCE(vn->pool[i].len, vn->pool[i].len - 1);
> > > +
> > > +				if (!--n_decay)
> > > +					break;
> > 
> >                                Here, --n_decay will make n_decay 0xffffffffffffffff,
> >                                then all left objects are reclaimed.
> Right. Last three objects do not play a big game.

See it now, thanks.


