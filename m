Return-Path: <linux-kernel+bounces-105794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D634C87E498
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A1F1F21EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96625763;
	Mon, 18 Mar 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhl5nkYu"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29C250F8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748884; cv=none; b=rGvPJq6xLVaVINjP/MR46pwuy7PmBmdPBT+oi/5dY3UEO0Em/3wdg7l3G8h872SW2UcGR2icV/3H9IwGhGyExAwhSDxCGtdD3iuU4fcd13GM2eCs7ZdVyLr2M4Zn4Rf6INDNOj7/4MMpzTXJTDNbPgOepZcoOHBqHkSEJrgknGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748884; c=relaxed/simple;
	bh=PZyrbkwevDI9NPGznhgKgASWkfEa1UGJIeNjocS81VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnU5vRYYK2YAKFNYDEUbeqYpdBn5l4PXEhgZMpglYkgLs+CUmo+C524MndUUcI10EodCnMyvOZzeeLXn0iIvXu1lbto9ffp8/jfLWcFWDLsKR4ezj0tOzJAlPg7XHXZ8VQfbk47I30mB6u6CSNYDIR/UUKg+3lHQRVGCDDpGf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhl5nkYu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so37155411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710748881; x=1711353681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RkSK5/rL7+nrcDu6W4JMfMUWleyDEMj8nS89Ven6gI=;
        b=Yhl5nkYuh5+vvqrCI88AvMT5sINwHjDqG2+Q6RIWxdZCRBZ9bNcmx2038o9BcyKiBs
         iRtZKqBeMzcZqU3OdP1q6it4h1j/velEtYXuiEioNmAwJKtTIHuGhAQQh33hTlXoQ29u
         HFwYshb2P/xB8uTIzRdEnmm24etl35q67d+7pctZ7B2Xhdf7aWE3tbamL5uUcvJicT0a
         H1+4wqOVVbLC3x6R0zZa7uNwDQHzRJXWjVIP7bDGYnG43j0NSlLVstYWlu3BqlwDmHB9
         3Q1vho7tZEM6NkWmw1GXeBDThib3HNKlkO/XPS+Bv9lNSY5qxssbSvRNzCWflse0Z7UJ
         MRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748881; x=1711353681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RkSK5/rL7+nrcDu6W4JMfMUWleyDEMj8nS89Ven6gI=;
        b=ooIW/aszehSr0E2h8ym9LuSlz3PEWVffceean/xHcpf7/w7Epqo3wqQx1z+3HFJR25
         GVCuCZ6Aaygpg+QgPp1gjhATRhNQeY9aDqw5xNYCb2z884zNubjzrtoYIZL8Xdqb0bNm
         8zXexTzvmMrYqzQqftHNfRC7s0frlAec0h8SXRM2bbGnL3Omxret724aXdqqnOWnRjpK
         OFRsdipamDwrAy4jBcAOcevUeLch1uNpYjseihn+qVmQ6YbiGu0LpJcs7KehhCA43Ghs
         j2PGEDlshwLRkOdULVbyUP9Oq6oSMM+38DzTuwZgTY6IueWT1bnmn6plM+IR2Iyp3v6s
         RPBA==
X-Forwarded-Encrypted: i=1; AJvYcCXglVNs8/1DmT0J+tZIl/YgHlxze2viARqGVbZ4YgfP2Twh2H8Kpq+4tuujm/fKKcz/MAJ9JvUTSNlNImm49xkL/Bno4r9yQ6A19Ilm
X-Gm-Message-State: AOJu0YxKE3ngg53o5/IkwCYgc494eMV2mGEA6+Gagozrby/etTiiW6RQ
	UoncePe4mn05yc1/J+K5hMEq6QTn+9mKjHguGgFWCoinHHBIpVAxYNpG1jXsiaZnX/XhJ98LCX9
	gvsrxMsrFGdGeFTa1aXhY64hh6eU=
X-Google-Smtp-Source: AGHT+IGMH3lhqUYgmFgqJRNqfeoYwJtJ/H3jRknEGjY/jGfZI4wfOZNsfbaQsNbkTlBe8wYxxITrsdV3A9ZgrQj0d0c=
X-Received: by 2002:a2e:b5c8:0:b0:2d2:6227:d30a with SMTP id
 g8-20020a2eb5c8000000b002d26227d30amr6771186ljn.2.1710748880358; Mon, 18 Mar
 2024 01:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b88ce9ecad0d456d8adbc78e42ec713a@BJMBX01.spreadtrum.com>
 <Zfe0yl2QTV1zSS1n@casper.infradead.org> <CAGWkznHQLoU48Wx5kP64LN-ord6J2kvopBzpOLno4PDKTnQsiQ@mail.gmail.com>
In-Reply-To: <CAGWkznHQLoU48Wx5kP64LN-ord6J2kvopBzpOLno4PDKTnQsiQ@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 18 Mar 2024 16:01:09 +0800
Message-ID: <CAGWkznEZcn74KX-4rWxUocNLa-ZRTf+Ay=dQKNdbUCxLX0wyEA@mail.gmail.com>
Subject: Re: reply: [PATCH] mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:15=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
com> wrote:
>
> On Mon, Mar 18, 2024 at 11:28=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:37:04AM +0000, =E9=BB=84=E6=9C=9D=E9=98=B3 (=
Zhaoyang Huang) wrote:
> > > >On Sun, Mar 17, 2024 at 12:07:40PM +0800, Zhaoyang Huang wrote:
> > > >> Could it be this scenario, where folio comes from pte(thread 0), l=
ocal
> > > >> fbatch(thread 1) and page cache(thread 2) concurrently and proceed
> > > >> intermixed without lock's protection? Actually, IMO, thread 1 also
> > > >> could see the folio with refcnt=3D=3D1 since it doesn't care if th=
e page
> > > >> is on the page cache or not.
> > > >>
> > > >> madivise_cold_and_pageout does no explicit folio_get thing since t=
he
> > > >> folio comes from pte which implies it has one refcnt from pagecach=
e
> > > >
> > > >Mmm, no.  It's implicit, but madvise_cold_or_pageout_pte_range()
> > > >does guarantee that the folio has at least one refcount.
> > > >
> > > >Since we get the folio from vm_normal_folio(vma, addr, ptent); we kn=
ow that
> > > >there is at least one mapcount on the folio.  refcount is always >=
=3D mapcount.
> > > >Since we hold pte_offset_map_lock(), we know that mapcount (and ther=
efore
> > > >refcount) cannot be decremented until we call pte_unmap_unlock(), wh=
ich we
> > > >don't do until we have called folio_isolate_lru().
> > > >
> > > >Good try though, took me a few minutes of looking at it to convince =
myself that
> > > >it was safe.
> > > >
> > > >Something to bear in mind is that if the race you outline is real, f=
ailing to hold a
> > > >refcount on the folio leaves the caller susceptible to the
> > > >VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio); if the other thread=
 calls
> > > >folio_put().
> > > Resend the chart via outlook.
> > > I think the problem rely on an special timing which is rare, I would =
like to list them below in timing sequence.
> > >
> > > 1. thread 0 calls folio_isolate_lru with refcnt =3D=3D 1
> >
> > (i assume you mean refcnt =3D=3D 2 here, otherwise none of this makes s=
ense)
> >
> > > 2. thread 1 calls release_pages with refcnt =3D=3D 2.(IMO, it could b=
e 1 as release_pages doesn't care if the folio is used by page cache or fs)
> > > 3. thread 2 decrease refcnt to 1 by calling filemap_free_folio.(as I =
mentioned in 2, thread 2 is not mandatary here)
> > > 4. thread 1 calls folio_put_testzero and pass.(lruvec->lock has not b=
een take here)
> >
> > But there's already a bug here.
> >
> > Rearrange the order of this:
> >
> > 2. thread 1 calls release_pages with refcount =3D=3D 2 (decreasing refc=
ount to 1)
> > 3. thread 2 decrease refcount to 0 by calling filemap_free_folio
> > 1. thread 0 calls folio_isolate_lru() and hits the BUG().
> >
> > > 5. thread 0 clear folio's PG_lru by calling folio_test_clear_lru. The=
 folio_get behind has no meaning there.
> > > 6. thread 1 failed in folio_test_lru and leave the folio on the LRU.
> > > 7. thread 1 add folio to pages_to_free wrongly which could break the =
LRU's->list and will have next folio experience list_del_invalid
> > >
> > > #thread 0(madivise_cold_and_pageout)        #1(lru_add_drain->fbatch_=
release_pages)       #2(read_pages->filemap_remove_folios)
> > > refcnt =3D=3D 1(represent page cache)             refcnt=3D=3D2(anoth=
er one represent LRU)          folio comes from page cache
> >
> > This is still illegible.  Try it this way:
> >
> > Thread 0        Thread 1        Thread 2
> > madvise_cold_or_pageout_pte_range
> >                 lru_add_drain
> >                 fbatch_release_pages
> >                                 read_pages
> >                                 filemap_remove_folio
> Thread 0        Thread 1        Thread 2
> madvise_cold_or_pageout_pte_range
>                 truncate_inode_pages_range
>                 fbatch_release_pages
>                                 truncate_inode_pages_range
>                                 filemap_remove_folio
> Sorry for the confusion. Rearrange the timing chart like above
> according to the real panic's stacktrace. Thread 1&2 are all from
> truncate_inode_pages_range(I think thread2(read_pages) is not
> mandatory here as thread 0&1 could rely on the same refcnt=3D=3D1).
> >
> > Some accuracy in your report would also be appreciated.  There's no
> > function called madivise_cold_and_pageout, nor is there a function call=
ed
> > filemap_remove_folios().  It's a little detail, but it's annoying for
> > me to try to find which function you're actually referring to.  I have
> > to guess, and it puts me in a bad mood.
> >
> > At any rate, these three functions cannot do what you're proposing.
> > In read_page(), when we call filemap_remove_folio(), the folio in
> > question will not have the uptodate flag set, so can never have been
> > put in the page tables, so cannot be found by madvise().
> >
> > Also, as I said in my earlier email, madvise_cold_or_pageout_pte_range(=
)
> > does guarantee that the refcount on the folio is held and can never
> > decrease to zero while folio_isolate_lru() is running.  So that's two
> > ways this scenario cannot happen.
> The madivse_xxx comes from my presumption which has any proof.
> Whereas, It looks like truncate_inode_pages_range just cares about
> page cache refcnt by folio_put_testzero without noticing any task's VM
> stuff. Furthermore, I notice that move_folios_to_lru is safe as it
> runs with holding lruvec->lock.
> >
BTW, I think we need to protect all
folio_test_clear_lru/folio_test_lru by moving them into lruvec->lock
in such as __page_cache_release and folio_activate functions.
Otherwise, there is always a race window between judging PG_lru and
following actions.

