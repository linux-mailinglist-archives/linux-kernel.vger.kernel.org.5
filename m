Return-Path: <linux-kernel+bounces-122275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0488F48B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088001F28241
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435041804A;
	Thu, 28 Mar 2024 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWgsu5tL"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4788465
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589266; cv=none; b=PJ0F2m7VhQPhGuunlGRXM/9EqYEgqDcspQ+eDZlV/LxUnsLf81kF3GEDhq8OmQhfKNS99exe9O5cenfpTWoiapcwRgxUZZ4vl8tdDQN2c3xLoWxCaCr6fPyVAPu0g4tTUUFBfkG37eCZnum09TNqMKgnu8N8AM9+ri46Au6r47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589266; c=relaxed/simple;
	bh=fBO8KAJmy3wMi2rgjJu6UmFyCOj/5ge41qGaheG6254=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzcgxPvHkyT8KtbPZegFChIhW0GVzea47CVpR136s7fwHIXsQJBx4FtcYwcPUkIoxisD3sy38PKEUi7a0gD6b2F+e5/yr1EV09XFsLO06msQzuWbTDFBoJGtGIXEO0D7Z4JKKV0x3rIJOnp7ZydpMZhjVN05XfF1yEAAAahwglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWgsu5tL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d485886545so5983301fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589263; x=1712194063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4+6bhV4ASkyXzhB6rRjo48e6+mgSPLqfD3+eCsrCCs=;
        b=iWgsu5tLNneGAI8ArfZPjiBnze9Cbxblk/hUzM50dnEUcpBxwcNomO28paj/vD9S74
         R2v14eX59VmKihIuZDyqhKYmqNzmMJ67qOmgXtzF4hdLSrRY2EabLXi4YR/hZjjz9mKC
         Nb5kXgQsQCaQvS+E+p2W267ACEkBwSbA8Z9hNkZNj8Fxw6IcyQ+ymFp++M2D0mTYGjlK
         ZtQOVLIDrSwmUrYXAr4BVzKu8WNAcBeZ21UaJg+Sy+X/qrkepcj42h8uoCcxJjE/kltZ
         G+Kohp5GJDCxa+c36n7EdoUq5KgKBUPY/2k7bETVBbvTxoIoUsZ2bz9EGcZCBMwx3nZI
         vwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589263; x=1712194063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4+6bhV4ASkyXzhB6rRjo48e6+mgSPLqfD3+eCsrCCs=;
        b=Ci2l419iPFxvc2Rg+KPG3NA2cTI5KB/muhgnvsnMz6QdJHS3gKoV4/UrYzpfQCdMxQ
         85Kt4sVDcSK3MwGGPhTL7oIMkVif+KhbNlA0n6T6wv8d/ySiLhtumMIhc6U4gVmA6+HA
         997qMZypeSksTGrhyRaKEZuN/stGvMjkT7E6pGRcvYc/ElN62OysfaW69zfcpI6FhB9I
         ynY5sKKUb3Pzkm0exkEMnWfZNQqg17kFCNAGNn+bmCbUYn9FO4TP2MWRqUHOn+G9fULP
         XgTVXSDeiln2n+OTgZmz9Nrz6OYmK6RjpYesiBITFil1ijMVw/NPO8tOdx09S2r5ONAP
         ljgA==
X-Forwarded-Encrypted: i=1; AJvYcCU4BXJazgR2lnWnzSO6IoYFw4DJERdhS1MYcdjtNerqsL6atHeVn5mQ8jkhR7OdvLIixctnheB9Hc3bSFXPGaJb5QGYLLWFeXcNdp7t
X-Gm-Message-State: AOJu0YyT2RmG1BDdL17LHpmz/wyUPCPkCuAJl0yqmIb3HqOZbKKp7nL7
	PUjOa/3SPKSeXq7uDye+av83XakJ2yE/qb5E6Yv+k+CMq/biaNGILEUmnIxwNHO/EtlYYyS/eMm
	dVESviF39Vf0D35LZyE77M4rxrXk=
X-Google-Smtp-Source: AGHT+IHjHc/M5wg8Kjv4Xh41rdEpeSo18qi7fVeBXzM21c5hf+atpQ+Bm9FW8uywUPCAPYwN/gDi0QxSLifoeLU+Wbk=
X-Received: by 2002:a2e:8551:0:b0:2d5:acde:9065 with SMTP id
 u17-20020a2e8551000000b002d5acde9065mr1501774ljj.34.1711589262680; Wed, 27
 Mar 2024 18:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfj_-LbiIsAVWcPX@casper.infradead.org> <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org> <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org> <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org> <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org> <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org>
In-Reply-To: <ZgQRtQ60mrvOUKXo@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 28 Mar 2024 09:27:31 +0800
Message-ID: <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:31=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 27, 2024 at 09:25:59AM +0800, Zhaoyang Huang wrote:
> > > Ignoring any other thread, you're basically saying that there's a
> > > refcount imbalance here.  Which means we'd hit an assert (that folio
> > > refcount went below zero) in the normal case where another thread was=
n't
> > > simultaneously trying to do anything.
> > Theoretically Yes but it is rare in practice as aops->readahead will
> > launch all pages to IO under most scenarios.
>
> Rare, but this path has been tested.
>
> > read_pages
> >     aops->readahead[1]
> > ...
> >     while (folio =3D readahead_folio)[2]
> >         filemap_remove_folio
> >
> > IMO, according to the comments of readahead_page, the refcnt
> > represents page cache dropped in [1] makes sense for two reasons, '1.
> > The folio is going to do IO and is locked until IO done;2. The refcnt
> > will be added back when found again from the page cache and then serve
> > for PTE or vfs' while it doesn't make sense in [2] as the refcnt of
> > page cache will be dropped in filemap_remove_folio
> >
> >  * Context: The page is locked and has an elevated refcount.  The calle=
r
> >  * should decreases the refcount once the page has been submitted for I=
/O
> >  * and unlock the page once all I/O to that page has completed.
> >  * Return: A pointer to the next page, or %NULL if we are done.
>
> Follow the refcount through.
>
> In page_cache_ra_unbounded():
>
>                 folio =3D filemap_alloc_folio(gfp_mask, 0);
> (folio has refcount 1)
>                 ret =3D filemap_add_folio(mapping, folio, index + i, gfp_=
mask);
> (folio has refcount 2)
>
> Then we call read_pages()
> First we call ->readahead() which for some reason stops early.
> Then we call readahead_folio() which calls folio_put()
> (folio has refcount 1)
> Then we call folio_get()
> (folio has refcount 2)
> Then we call filemap_remove_folio()
> (folio has refcount 1)
> Then we call folio_unlock()
> Then we call folio_put()
ok, I missed the refcnt from alloc_pages. However, I still think it is
a bug to call readahead_folio in read_pages as the refcnt obtained by
alloc_pages should be its final guard which is paired to the one which
checked in shrink_folio_list->__remove_mapping->folio_ref_freeze(2)(this
2 represent alloc_pages & page cache). If we removed this one without
isolating the folio from LRU, the following race could happen.
Furthermore, the refcnt dropped in the readahead_folio represents page
cache, it doesn't make sense to drop it twice in read_pages.

0. Thread_readahead:
    folio_put()
        folio_put_test_zero() =3D=3D true
        __folio_put()
            folio_test_lru() =3D=3D true
            <preempted>

1. Thread_isolate
     folio_isolate_lru
         folio_test_clear_lru()
         lruvec_del_folio()

2. Thread_readahead
    folio_put()
        folio_put_test_zero() =3D=3D true
        __folio_put
            folio_test_lru() =3D=3D true
            <schedule back from 0>
            lruvec_del_folio()



> (folio has refcount 0 and is freed)
>
> Yes, other things can happen in there to increment the refcount, so this
> folio_put() might not be the last put, but we hold the folio locked the
> entire time, so many things which might be attempted will block on the
> folio lock.  In particular, nobody can remove it from the page cache,
> so its refcount cannot reach 0 until the last folio_put() of the
> sequence.

