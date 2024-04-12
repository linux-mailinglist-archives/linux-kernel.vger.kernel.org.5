Return-Path: <linux-kernel+bounces-142804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCED8A3051
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2DA1C21DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB485C52;
	Fri, 12 Apr 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKfFXUGa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69860205E22
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931503; cv=none; b=psgaCM1BJznAxTXrNzXj/292FaoUgbhLahq4sumCzG4hNaqmTnKgRrsdGlCerOXVbcJ63Wv2IvY0DwU1vi9UVN0QfOUePc7hG9nwoAxzGT+PWtl3R1pjhBggFDzOM+zQGiSqWLo/IPl/02ggLZEhodcuyztS11KNaVi3u/ESjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931503; c=relaxed/simple;
	bh=LC5v5kgGJFJkrqQAWLvW1T0DUIFoz5kasopvHLzQvxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLJnTCXWVcZjRW2oh7BCcnNnkmQXvD57sDdsDdmySQOVZi9JKJaJzFmOMNK3juViTfJd5iAcTlp2iDH2Abf/Qs9FMTl8L3DwcT9K4w3jAa/8nsxhH71RDImvHG/3uNMGw/N5qysqCS779NqFZPESkgIov7Dq8qno/z0B980gxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VKfFXUGa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2BYJNmVdG5wpg99XHThDNC7LECCoy2+Z5eSz1sME4BI=; b=VKfFXUGa5RGNXIQPsrIofPTz/w
	kCpdI0ua5ft51EzicG+Ch0K50IrrJoOVZgDzUMtoGFkrZin9tKkI34Nv7sZ2Ol3dzwKLuX/ZebtnS
	Rx5SKaJtulKZEz56dl3IdH0wCXk5WicLtLpfwvx6LvGAOMvS+2yVXGVQjOyDHtuNoWSvqMk6K1g1q
	0+6/dZXMS48D14SDSKlA4HbeY86Txw/9bXdbrjCjkpDqs2tjsSO7cTtpgtmnGmYdlYajKRVc+k0ZW
	szZr+/jhlFJw/1GXjij64uCOYg43nJ+FuAGnYb6MF5T9iasIkZ8AcXykRfluiXd5khw61FVOnBtCs
	UzRNXlVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvHjG-00000009PBV-3ArS;
	Fri, 12 Apr 2024 14:18:10 +0000
Date: Fri, 12 Apr 2024 15:18:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"Christoph Lameter (Ampere)" <cl@linux.com>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order page
Message-ID: <ZhlCogEsWEjTbl8_@casper.infradead.org>
References: <20240411091832.608280-1-haifeng.xu@shopee.com>
 <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
 <5d3c4a5e-0c27-4058-adf1-91e9602e5ccb@suse.cz>
 <ZhkmcNwOKktO3pxT@casper.infradead.org>
 <2031ea8c-29a0-4514-b042-7c0eabb4f443@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2031ea8c-29a0-4514-b042-7c0eabb4f443@shopee.com>

On Fri, Apr 12, 2024 at 10:14:39PM +0800, Haifeng Xu wrote:
> diff --git a/mm/slub.c b/mm/slub.c
> index e7bf1a1a31a8..49a3ebefab86 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4461,9 +4461,7 @@ static int calculate_sizes(struct kmem_cache *s)
>         if ((int)order < 0)
>                 return 0;
> 
> -       s->allocflags = 0;
> -       if (order)
> -               s->allocflags |= __GFP_COMP;
> +       s->allocflags = __GFP_COMP;
> 
>         if (s->flags & SLAB_CACHE_DMA)
>                 s->allocflags |= GFP_DMA;

Resend this with a proper changelog and you can add:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

