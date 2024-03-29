Return-Path: <linux-kernel+bounces-124256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F0E891476
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E860B1F22F01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C34086C;
	Fri, 29 Mar 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBTqHaK6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F38249F7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698300; cv=none; b=bOMKlXVg0bPXFTve4Wt6628fdGLrn7VWC/RQIEdr/gUpxQtJ76QQoZ4NZfDc8bC0iptSCfSvujYy1IqMfueLB/EMadl0kO59JlCkNb3XtTHcUN9apFfgUejkyC5kPgUiyV3I3BfFH8e4Krkln43zQHSHXbS+6WPkfDi6ch/v/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698300; c=relaxed/simple;
	bh=mBcJaNPKUSSx/l4nv6cZC7DoHwkcuaBDybljzKKuods=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBACuFiepP7b8ZGIGzmYeHlk07msQm1ZVrhRFfJTWcZPZgA0bLfsDRkI56lFC1koY0CONIkw+RoaqmoiLmkruWuUqJarhk+Nc6n69XwSEJxk1UBKyR1jjevb4PJkfsoKMqhMj5aTSLtlNaicriJtdA6Z6Mp7qY/W5OdGW/N8JyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBTqHaK6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711698297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pl9KzSbZMAWocxmjGaVx75BO/6kKQO4HQT51oylGjk=;
	b=XBTqHaK6POJPUj9VM/apRwyWIb3Ga7QIMrcGilDit7T/lm1pJi4dddSBxFzN9k9s3cP8xP
	PheeXw9A3W205W12ldUs8u618DPHXn/WFCdK7nYfsflBi0+8Sqrycn4Y2oi94Us1HbSyP1
	DC4JOTzZAhVyHO/Hh7y/OZjb6sH757k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-MLE3Be8zMDOf9zMXD9arWw-1; Fri, 29 Mar 2024 03:44:52 -0400
X-MC-Unique: MLE3Be8zMDOf9zMXD9arWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5E25101A56C;
	Fri, 29 Mar 2024 07:44:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B3F72022EDB;
	Fri, 29 Mar 2024 07:44:49 +0000 (UTC)
Date: Fri, 29 Mar 2024 15:44:40 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix lockdep warning
Message-ID: <ZgZxaOg6/qZAfUUA@MiWiFi-R3L-srv>
References: <20240328140330.4747-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140330.4747-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/28/24 at 03:03pm, Uladzislau Rezki (Sony) wrote:
> A lockdep reports a possible deadlock in the find_vmap_area_exceed_addr_lock()
> function:
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.9.0-rc1-00060-ged3ccc57b108-dirty #6140 Not tainted
> --------------------------------------------
> drgn/455 is trying to acquire lock:
> ffff0000c00131d0 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124
> 
> but task is already holding lock:
> ffff0000c0011878 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&vn->busy.lock/1);
>   lock(&vn->busy.lock/1);
> 
>  *** DEADLOCK ***
> 
> indeed it can happen if the find_vmap_area_exceed_addr_lock()
> gets called concurrently because it tries to acquire two nodes
> locks. It was done to prevent removing a lowest VA found on a
> previous step.
> 
> To address this a lowest VA is found first without holding a
> node lock where it resides. As a last step we check if a VA
> still there because it can go away, if removed, proceed with
> next lowest.
> 
> Fixes: 53becf32aec1 ("mm: vmalloc: support multiple nodes in vread_iter")
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Tested-by: Omar Sandoval <osandov@fb.com>
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 74 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e94ce4562805..a5a5dfc3843e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -989,6 +989,27 @@ unsigned long vmalloc_nr_pages(void)
>  	return atomic_long_read(&nr_vmalloc_pages);
>  }
>  
> +static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> +{
> +	struct rb_node *n = root->rb_node;
> +
> +	addr = (unsigned long)kasan_reset_tag((void *)addr);
> +
> +	while (n) {
> +		struct vmap_area *va;
> +
> +		va = rb_entry(n, struct vmap_area, rb_node);
> +		if (addr < va->va_start)
> +			n = n->rb_left;
> +		else if (addr >= va->va_end)
> +			n = n->rb_right;
> +		else
> +			return va;
> +	}
> +
> +	return NULL;
> +}
> +
>  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
>  static struct vmap_area *
>  __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> @@ -1025,47 +1046,40 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
>  static struct vmap_node *
>  find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
>  {
> -	struct vmap_node *vn, *va_node = NULL;
> -	struct vmap_area *va_lowest;
> +	unsigned long va_start_lowest;
> +	struct vmap_node *vn;
>  	int i;
>  
> -	for (i = 0; i < nr_vmap_nodes; i++) {
> +repeat:
> +	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
>  		vn = &vmap_nodes[i];
>  
>  		spin_lock(&vn->busy.lock);
> -		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> -		if (va_lowest) {
> -			if (!va_node || va_lowest->va_start < (*va)->va_start) {
> -				if (va_node)
> -					spin_unlock(&va_node->busy.lock);
> -
> -				*va = va_lowest;
> -				va_node = vn;
> -				continue;
> -			}
> -		}
> +		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> +
> +		if (*va)
> +			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
> +				va_start_lowest = (*va)->va_start;

How about below change about va_start_lowest? Personal preference, not
strong opinion.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9b1a41e12d70..bd6a66c54ad2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1046,19 +1046,19 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 static struct vmap_node *
 find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
 {
-	unsigned long va_start_lowest;
+	unsigned long va_start_lowest = ULONG_MAX;
 	struct vmap_node *vn;
 	int i;
 
 repeat:
-	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
+	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
 		spin_lock(&vn->busy.lock);
 		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
 
 		if (*va)
-			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
+			if ((*va)->va_start < va_start_lowest)
 				va_start_lowest = (*va)->va_start;
 		spin_unlock(&vn->busy.lock);
 	}
@@ -1069,7 +1069,7 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
 	 * been removed concurrently thus we need to proceed
 	 * with next one what is a rare case.
 	 */
-	if (va_start_lowest) {
+	if (va_start_lowest != ULONG_MAX) {
 		vn = addr_to_node(va_start_lowest);
 
 		spin_lock(&vn->busy.lock);


>  		spin_unlock(&vn->busy.lock);
>  	}
>  
> -	return va_node;
> -}
> -
> -static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> -{
> -	struct rb_node *n = root->rb_node;
> +	/*
> +	 * Check if found VA exists, it might it is gone away.
                                        ~~~~ grammer mistake?
> +	 * In this case we repeat the search because a VA has
> +	 * been removed concurrently thus we need to proceed
> +	 * with next one what is a rare case.
                         ~~~~ typo, which?
> +	 */
> +	if (va_start_lowest) {
> +		vn = addr_to_node(va_start_lowest);
>  
> -	addr = (unsigned long)kasan_reset_tag((void *)addr);
> +		spin_lock(&vn->busy.lock);
> +		*va = __find_vmap_area(va_start_lowest, &vn->busy.root);
>  
> -	while (n) {
> -		struct vmap_area *va;
> +		if (*va)
> +			return vn;
>  
> -		va = rb_entry(n, struct vmap_area, rb_node);
> -		if (addr < va->va_start)
> -			n = n->rb_left;
> -		else if (addr >= va->va_end)
> -			n = n->rb_right;
> -		else
> -			return va;
> +		spin_unlock(&vn->busy.lock);
> +		goto repeat;
>  	}

Other than above nickpick concerns, this looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>


