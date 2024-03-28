Return-Path: <linux-kernel+bounces-122273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4988F486
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996142990C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AB208B0;
	Thu, 28 Mar 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGZ43+hh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920D20335
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589057; cv=none; b=Ryc8z3atIpz4Q2OMfrLF7O7lO7XSPdUo90PqcdbmCqva0PpMkGYuj3xc1R4yIunvHtIUzIGh5NUAEtA8XoyyWlk4ccrn6fEsAFjKkInCGoOZqhKA2geZ21pwCZ0kS7qrokMWmX68MKg4xLaqTb0rxgGonpGTdOK9wzXTC0UiexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589057; c=relaxed/simple;
	bh=ZZr7QMnpNZnEM1qk3f4Iie1kMDltD45Dk+8VBSIy2Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB9s+4Md2LeD3D2tSJP7E4uLEK4yF1ZIxgejKWNqSfkdR+Eb8jckXqp/7NTZceDFbj53jd072nqu2eZ9WF3b7+oczpeVPz3xvD2of8ZPU1etuDLrvkz64qIJCgm1ajKR9o52x7fTtSjam3JM/30TNFJ/q9Hx5azGER9n8hIvIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGZ43+hh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711589054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LilcHusgSvqim2+d+06wj9NkX9jRJyVASh1CxKYlBM4=;
	b=hGZ43+hhNcktTcHRNrXw9xRuQiLJimSPlwcATD9l628EM1IcYX362/4Riq+mQBgiCgWGqn
	TYHJnXmCUc2O4miqkAgA9MHZ2kCX46fDC+bS3nheCG6H22euwv4ymoht7Vn71/ZU2OhwaV
	DZ9MIfQZ3tdNOpQHk0Cy3qieLA05GZ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-pbODCuinOoimN5IXwG6ifw-1; Wed,
 27 Mar 2024 21:24:10 -0400
X-MC-Unique: pbODCuinOoimN5IXwG6ifw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 238DA3C0EABF;
	Thu, 28 Mar 2024 01:24:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5369217A9D;
	Thu, 28 Mar 2024 01:24:08 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:24:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 5/6] mm/mm_init.c: remove unneeded calc_memmap_size()
Message-ID: <ZgTGsY/nQlKZd8jh@MiWiFi-R3L-srv>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-6-bhe@redhat.com>
 <ZgRHgL1zbQc2DJlc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgRHgL1zbQc2DJlc@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 03/27/24 at 06:21pm, Mike Rapoport wrote:
> On Mon, Mar 25, 2024 at 10:56:45PM +0800, Baoquan He wrote:
> > Nobody calls calc_memmap_size() now.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 
> Looks like I replied to patch 6/6 twice by mistake and missed this one.

Thanks for your careful reviewing.

> 
> > ---
> >  mm/mm_init.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 7f71e56e83f3..e269a724f70e 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1331,26 +1331,6 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
> >  	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
> >  }
> >  
> > -static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
> > -						unsigned long present_pages)
> > -{
> > -	unsigned long pages = spanned_pages;
> > -
> > -	/*
> > -	 * Provide a more accurate estimation if there are holes within
> > -	 * the zone and SPARSEMEM is in use. If there are holes within the
> > -	 * zone, each populated memory region may cost us one or two extra
> > -	 * memmap pages due to alignment because memmap pages for each
> > -	 * populated regions may not be naturally aligned on page boundary.
> > -	 * So the (present_pages >> 4) heuristic is a tradeoff for that.
> > -	 */
> > -	if (spanned_pages > present_pages + (present_pages >> 4) &&
> > -	    IS_ENABLED(CONFIG_SPARSEMEM))
> > -		pages = present_pages;
> > -
> > -	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
> > -}
> > -
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  static void pgdat_init_split_queue(struct pglist_data *pgdat)
> >  {
> > -- 
> > 2.41.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 


