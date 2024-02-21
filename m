Return-Path: <linux-kernel+bounces-74663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12385D769
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59981B22C18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3B3FE37;
	Wed, 21 Feb 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbVC0V8V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1945C10
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516180; cv=none; b=SDokK82nUxwEEwUft326rx8ch0tXSuV3hLdEQimlix00vZXAveHDMDjVHabNiCy6CXc1iUhB8qht11qEJ8r7ZD/ZapHi3Q3TIfQAlokRaABdJhm3sbjlcgwg5ePLnKSPJBH52dAFBfkrNkOwqO2NFa/XJaZUefqb6Mlkpoijap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516180; c=relaxed/simple;
	bh=RySDftSWHqCyUHcdMeWLVcN9zJyLrpoxG8msNBALDuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5K6zyPYi2E+BxKLw9/OgnP33ux9BhZDh5nhnyli2EtlYb2LWwlV/uTjGsuaEtqSXSH6zUK77I+XDw+W1iUO2XIoDwEPGhSy7z7f5d2uPCJtzcY7imlAfO8XQJVabVfDp5GbjXBqZ57dF3d4ElqA4EmySBgx33rYPc+KgSnXQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbVC0V8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bin7AzDlChDSAGWFKufeiYIoVcIyTk+S1hiBB6egTbw=;
	b=FbVC0V8Vhc5mwXZVypQyqzb+ZrZh+Acye/6/ruKuW6r3ol7YQ6Pd/vc4MJxeyng8+0Th6m
	rRYcPY5IHPbAmxIeKFjsjZaFXtTxz6FXYQ1OLwLUyXxj/ST1EHCQDqwDZDrsYwtk1jQPAw
	QZVu2//lL6CSg5p+VUEEQTxLKZfdPpo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-m2ua76FxNIKkxXuuzfmMZQ-1; Wed, 21 Feb 2024 06:49:36 -0500
X-MC-Unique: m2ua76FxNIKkxXuuzfmMZQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a0168a3df5so207250eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516175; x=1709120975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bin7AzDlChDSAGWFKufeiYIoVcIyTk+S1hiBB6egTbw=;
        b=jowQ11+QdG2fs/slx4vaTi1YFaPqj1150NmiQQYkXwOdm9TA6mDzyAOApWF5eviyQ+
         xeJ89/C61fgTwl2w9YKTZymyHvSI15fyM1uSor98iE+lOVv/bBEXoCSBlQ+KlD7iHsdf
         vnKSsSDisk2RmIR9xl+d06xyWd24ICqtsFRlRE2DMXUAOxK90vOtcAKPjio8RgD1mbZA
         4gRMxx3MSvUGzn+8FyVYhIQ5hizj+F3hwQdAedRUlnyc7JM33F85TqZD82ym1OB47s+5
         tdVbpv+2PiCxSdkVfghZPNL14RRS3BtS3rAzH/3lAre1jrEDsov8OTix9XpMEa/hgce0
         bimA==
X-Forwarded-Encrypted: i=1; AJvYcCVeTUwU95mnlQTbZn+rX2LEe1CvP/dUAMkJlBI0krEiHgAXee1ATPjzo10DWR7vCBwesAEa/C7Rmjrbo1RBH6NDyKWDtBraZtNTtPgE
X-Gm-Message-State: AOJu0YyO9D8jpUOZrrQzHJ1lJj2yRJA1pmy2dNEsEvyqATCcJq0yxW3m
	gnmXoSzUL5Ab1a19dfh36znL/Nc9LS1cD9u71ijeN45Dm+LaS4ZLpeCyxz7qxpOQQVlSVOjKj9L
	2gKpoUlqkamfwHdQskxUZSAfClRQYWB6IG9JRtfXC/eIRDKk/fKYQGgYPyQki0A==
X-Received: by 2002:a05:6358:e49a:b0:178:9f1d:65e3 with SMTP id by26-20020a056358e49a00b001789f1d65e3mr16912425rwb.0.1708516175559;
        Wed, 21 Feb 2024 03:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzL228YTGBKB2uXR1bZQUntRIhXzOYaVH/u+cU7rZshqOXYoJ5XOeq8q0ePg1PQ/TTyms+Jw==
X-Received: by 2002:a05:6358:e49a:b0:178:9f1d:65e3 with SMTP id by26-20020a056358e49a00b001789f1d65e3mr16912401rwb.0.1708516175144;
        Wed, 21 Feb 2024 03:49:35 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w24-20020aa78598000000b006e4695e519csm5146763pfn.194.2024.02.21.03.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:49:34 -0800 (PST)
Date: Wed, 21 Feb 2024 19:49:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>, linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 10/13] mm/gup: Handle huge pud for follow_pud_mask()
Message-ID: <ZdXjQjow4fa41ORD@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-11-peterx@redhat.com>
 <20240115184900.GV734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115184900.GV734935@nvidia.com>

On Mon, Jan 15, 2024 at 02:49:00PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 05:14:20PM +0800, peterx@redhat.com wrote:
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 63845b3ec44f..760406180222 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -525,6 +525,70 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> >  	return NULL;
> >  }
> >  
> > +#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > +static struct page *follow_huge_pud(struct vm_area_struct *vma,
> > +				    unsigned long addr, pud_t *pudp,
> > +				    int flags, struct follow_page_context *ctx)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct page *page;
> > +	pud_t pud = *pudp;
> > +	unsigned long pfn = pud_pfn(pud);
> > +	int ret;
> > +
> > +	assert_spin_locked(pud_lockptr(mm, pudp));
> > +
> > +	if ((flags & FOLL_WRITE) && !pud_write(pud))
> > +		return NULL;
> > +
> > +	if (!pud_present(pud))
> > +		return NULL;
> > +
> > +	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> > +
> > +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > +	if (pud_devmap(pud)) {
> 
> Can this use IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) ?

Sure.

> 
> > +		/*
> > +		 * device mapped pages can only be returned if the caller
> > +		 * will manage the page reference count.
> > +		 *
> > +		 * At least one of FOLL_GET | FOLL_PIN must be set, so
> > +		 * assert that here:
> > +		 */
> > +		if (!(flags & (FOLL_GET | FOLL_PIN)))
> > +			return ERR_PTR(-EEXIST);
> > +
> > +		if (flags & FOLL_TOUCH)
> > +			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
> > +
> > +		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
> > +		if (!ctx->pgmap)
> > +			return ERR_PTR(-EFAULT);
> > +	}
> > +#endif	/* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> > +	page = pfn_to_page(pfn);
> > +
> > +	if (!pud_devmap(pud) && !pud_write(pud) &&
> > +	    gup_must_unshare(vma, flags, page))
> > +		return ERR_PTR(-EMLINK);
> > +
> > +	ret = try_grab_page(page, flags);
> > +	if (ret)
> > +		page = ERR_PTR(ret);
> > +	else
> > +		ctx->page_mask = HPAGE_PUD_NR - 1;
> > +
> > +	return page;
> > +}
> > +#else  /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
> > +static struct page *follow_huge_pud(struct vm_area_struct *vma,
> > +				    unsigned long addr, pud_t *pudp,
> > +				    int flags, struct follow_page_context *ctx)
> > +{
> > +	return NULL;
> > +}
> > +#endif	/* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
> > +
> >  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> >  		pte_t *pte, unsigned int flags)
> >  {
> > @@ -760,11 +824,11 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
> >  
> >  	pudp = pud_offset(p4dp, address);
> >  	pud = READ_ONCE(*pudp);
> > -	if (pud_none(pud))
> > +	if (pud_none(pud) || !pud_present(pud))
> >  		return no_page_table(vma, flags, address);
> 
> Isn't 'pud_none() || !pud_present()' redundent? A none pud is
> non-present, by definition?

Hmm yes, seems redundant.  Let me drop it.

> 
> > -	if (pud_devmap(pud)) {
> > +	if (pud_huge(pud)) {
> >  		ptl = pud_lock(mm, pudp);
> > -		page = follow_devmap_pud(vma, address, pudp, flags, &ctx->pgmap);
> > +		page = follow_huge_pud(vma, address, pudp, flags, ctx);
> >  		spin_unlock(ptl);
> >  		if (page)
> >  			return page;
> 
> Otherwise it looks OK to me
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

-- 
Peter Xu


