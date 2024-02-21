Return-Path: <linux-kernel+bounces-74420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3B85D3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772101F24D70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE103D3A7;
	Wed, 21 Feb 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFHnGmnL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2B3C6A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508275; cv=none; b=SxEKYyA0mKJA8676q59GBPfkNDqqi6xSjR5PQW6Oao/sewdihY+zqWqH823AZMbuuOh2clz2chEJp5uaL5RdXsFV1LEfPcZd7fH9QWGKOFruq7Z0mEqAygxWkMQMsOUNcDkZJKJujkiROWc+J93geP6/Ad7vQ+QFvx8HbaXbXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508275; c=relaxed/simple;
	bh=UTBKMZKTMSyHNytfC7MXF3sYkrxnXGO8g1oIE0Xngrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGbT6Ek8g4YHicoay8INeMOI4bq9YSjeIdHmC/5FgLCEzdQI6yA8u458qD28VqHmKh9tiA9PfsKP/GKQLmmuJu9EK2wA8uL2vfOAhb0bCGmMX+1nePsIEs332IqcpGq5kPZ3splp4IA3Lyxjnp+SwuAyv3JRtj1AqmsghU+LvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFHnGmnL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708508272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdaKpo1zKogZCn5PWAqhqXGnoFVUrqpY1LtEmaKu+FM=;
	b=UFHnGmnLLF1dyPsTJH5oE/3mBxEFT/++jT/G+HjD7XNGKQ3fM50r6Ae/bvTlMF2ZPJ50sA
	u4HFcu/ZT+AYd4PF/tCzxX75rWp8XDI2yzbRON2gREhNo/34KFrv5SRAVpeLgG8bJJHgaT
	AYFbp2Yq5fFDoJfM16nbxysxbaKm4+E=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-MewX7aF9Pye4DziUeeFEtw-1; Wed, 21 Feb 2024 04:37:51 -0500
X-MC-Unique: MewX7aF9Pye4DziUeeFEtw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6db0e05548fso1863907b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508270; x=1709113070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdaKpo1zKogZCn5PWAqhqXGnoFVUrqpY1LtEmaKu+FM=;
        b=R8Lvw89/xmEA0oLh79385u1tMiCjQaSF8WWzbvEiHPKfsRpWP+yoazB1pDIzgwACKW
         Ri91dMA3+ybcv5+larzgplKTUZ14lXoAUH3HyLBrr2RelVxxQuP/M5zyva1h0Pspl87S
         Oo1ZkOyFDlKk/0yAeoe9dqTsejPwj/CgkdZiM/tCzcFAPhpL+MAjt8EAIZ66+cEpSgj4
         nYJhX2tq3bYtwST0LsAISRGxvxpLg7jxHLRtyCn+cPqka2Os+Ih4LzamzwlksA4WL8kX
         9DwqjiipkkK2O808a3m82w2F680FOWPUH2U3VBHnm94Wt7RvIoNAvRb5ytGOi5jJ8XzY
         pbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAU1oAP5RMT/+hdLtE6mNgN8kg9LBm+zDJVKA/QjH7XwGQX7z09Bbx3TyeaLK9Fg0ZyG90ZUy7t09h/BwyD20FErFDqATIa6RyyZx9
X-Gm-Message-State: AOJu0Yz8EK0ihbCj0iYb5ymhiEoSI5FWhp1wifGMlh1TUvEPCjeAC1ad
	wjrkYedez5RdYLw4b75QvhckHUuGFg4wS15GVffX9G/NniRADGDf93vX5dMVztHpAZtfhDAA2K6
	fTzf3FrE5HYQmbMyGNV3ovuhB4hroKlLG7ZMP6/JU9aFttfJIAeXyi/7DEwCM6A==
X-Received: by 2002:a05:6a00:3d13:b0:6e4:672b:f384 with SMTP id lo19-20020a056a003d1300b006e4672bf384mr7669533pfb.2.1708508269915;
        Wed, 21 Feb 2024 01:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnK/5Xc9SKm0wQPEnUuYiqinVCHstqfWVnR5OuYxZ4xQLJmopCSPYZqNRQ2oNZWFAP27lsbg==
X-Received: by 2002:a05:6a00:3d13:b0:6e4:672b:f384 with SMTP id lo19-20020a056a003d1300b006e4672bf384mr7669524pfb.2.1708508269578;
        Wed, 21 Feb 2024 01:37:49 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e11-20020aa7980b000000b006e4698d53casm4990624pfl.140.2024.02.21.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:37:49 -0800 (PST)
Date: Wed, 21 Feb 2024 17:37:37 +0800
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
Subject: Re: [PATCH v2 03/13] mm: Provide generic pmd_thp_or_huge()
Message-ID: <ZdXEYfs_xhS_9gRo@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-4-peterx@redhat.com>
 <20240115175551.GP734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115175551.GP734935@nvidia.com>

On Mon, Jan 15, 2024 at 01:55:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 05:14:13PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > ARM defines pmd_thp_or_huge(), detecting either a THP or a huge PMD.  It
> > can be a helpful helper if we want to merge more THP and hugetlb code
> > paths.  Make it a generic default implementation, only exist when
> > CONFIG_MMU.  Arch can overwrite it by defining its own version.
> > 
> > For example, ARM's pgtable-2level.h defines it to always return false.
> > 
> > Keep the macro declared with all config, it should be optimized to a false
> > anyway if !THP && !HUGETLB.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/pgtable.h | 4 ++++
> >  mm/gup.c                | 3 +--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 466cf477551a..2b42e95a4e3a 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1362,6 +1362,10 @@ static inline int pmd_write(pmd_t pmd)
> >  #endif /* pmd_write */
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >  
> > +#ifndef pmd_thp_or_huge
> > +#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> > +#endif
> 
> Why not just use pmd_leaf() ?
> 
> This GUP case seems to me exactly like what pmd_leaf() should really
> do and be used for..

I think I mostly agree with you, and these APIs are indeed confusing.  IMHO
the challenge is about the risk of breaking others on small changes in the
details where evil resides.

> 
> eg x86 does:
> 
> #define pmd_leaf	pmd_large
> static inline int pmd_large(pmd_t pte)
> 	return pmd_flags(pte) & _PAGE_PSE;
> 
> static inline int pmd_trans_huge(pmd_t pmd)
> 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
> 
> int pmd_huge(pmd_t pmd)
>         return !pmd_none(pmd) &&
>                 (pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;

For example, here I don't think it's strictly pmd_leaf()? As pmd_huge()
will return true if PRESENT=0 && PSE=0 (as long as none pte ruled out
first), while pmd_leaf() will return false; I think that came from
cbef8478bee5.  I'm not sure whether that is the best solution, e.g., from a
1st glance it seems better to me to process swap entries separately
(including both migration and poisoned entries)..

Sparc has similar things there, which in that case I'm not sure whether a
direct replace is always safe.

Besides that, there're also other cases where it's not clear of such direct
replacement, not until further investigated.  E.g., arm-3level has:

#define pmd_leaf(pmd)		pmd_sect(pmd)
#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
						 PMD_TYPE_SECT)
#define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)

While pmd_huge() there relies on PMD_TABLE_BIT ()

int pmd_huge(pmd_t pmd)
{
	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
}

#define PMD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)

These are just the trivial details that I wanted to avoid to touch in this
series, so as to resolve the hugetlb issue separately from others.

The new pmd_huge_or_thp() is not ideal, but that easily isolates all these
trivial details / evils out of the picture, so that we can tackle them one
by one.  It is strictly an OR or huge||thp, so it's hopefully safe to not
break anything yet from that regard.

> 
> I spot checked a couple arches and it looks like it holds up.
> 
> Further, it looks to me like this site in GUP is the only core code
> caller..
> 
> So, I'd suggest a small series to go arch by arch and convert the arch
> to use pmd_huge() == pmd_leaf(). Then retire pmd_huge() as a public
> API.
> 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index df83182ec72d..eebae70d2465 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -3004,8 +3004,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
> >  		if (!pmd_present(pmd))
> >  			return 0;
> >  
> > -		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
> > -			     pmd_devmap(pmd))) {
> > +		if (unlikely(pmd_thp_or_huge(pmd) || pmd_devmap(pmd))) {
> >  			/* See gup_pte_range() */
> >  			if (pmd_protnone(pmd))
> >  				return 0;
> 
> And the devmap thing here doesn't make any sense either. The arch
> should ensure that pmd_devmap() implies pmd_leaf(). Since devmap is a
> purely SW construct it almost certainly does already anyhow.

Yep, but only if pmd_leaf() is safe to be put here. A pmd devmap should
always imply as a pmd_leaf() indeed.

Thanks,

-- 
Peter Xu


