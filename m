Return-Path: <linux-kernel+bounces-105326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B387DC4D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 05:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89451C20B60
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 04:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961326112;
	Sun, 17 Mar 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KURIObgN"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22855240
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710648475; cv=none; b=XlAdxPkk7GANQ8x90d0bNn4NfYHyHEyA6ScI7YNnvnkP/uSxcDFvgf0EK15tGsso4f2CbOgU9xjpcQ/VggZFFxc1ybBmRaoVz5LPxb4LLFqXt1KLs4XRBLf5U8ilOUVQSRSDpFLfoJE6ujvZoN7Pulrs30vd5GAHOiJog0xgcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710648475; c=relaxed/simple;
	bh=6hncRWi+KV0ZxK8AWmCheR9C0BLWSTtJ0cHFbLjSZy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWUKMFNzrpLRBcqHIeRAR+Pf4xpbeRldu3FRQZOd5wapJlBEAM+EnTPx/rGbT4WqpDrYm+Amb0nXQCY1vE5XmZhDM+DyTkiUZdkXby7f8gq4YAZ/t5TINiIFDHzT3Pg5oMfUtFJwq6w0/Me+fddya0oN/OE24ZzkvHvggEp+zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KURIObgN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d288bac3caso42110131fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710648472; x=1711253272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrsAagVxnJJgGq4beAJ0RLGtxYosTgQyFVa7IwKk2Dc=;
        b=KURIObgNMnp93ao/ppt1k8LpajR/nPR3s1gEQRuzSLCd8YM5H3ePEfLFvqZnnCuZXj
         /hJogZC/ACfyPT8cCtCLF4VOG4EV6xScbwDdwlEmPe5yMMZep9r51Hy4GGO60J1TGKAf
         wrt52MGU3Uw+3yCx6n/wl4wjy7/eahSvO/6QO2NCc2i6DwQFzfA2RS9eKXto4VkSJZAH
         XlyTvVfowwngMlj5y2YrK9Q21P58BlORGP0GrvZI5SoluqOhwKEt8d3MSbhr/Tl7/O8c
         3rm/d4UmTg1ycUiP1s/4Xa2kEyel2cs505E9GZUGI39Xqm4Sok6ft+jlPteJ609XuHnG
         rH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710648472; x=1711253272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrsAagVxnJJgGq4beAJ0RLGtxYosTgQyFVa7IwKk2Dc=;
        b=lJE657KBFlpzL+rftacGRfOWDhysXPas6uNlZZPyQ7xe67DA9TGj9uWnJlWecgaKjJ
         fqQLuaUuleyuNx6isTg8fYTB5NlWWue4FPr7NRQUMen2biTASWtsGQ19KKAP/CPmriGC
         wk2Hie2UZZeG4i+0SsacJfh5YsJGeOSWLdDnT1nPFDLZTJG1Pax4YUW+BFFnSczxpA20
         HtGUjtr5ZOMOkZ5WO2U2faBu4gxKtRALmhVSJpAkgQdfFmZlBvzEeno/39Awg0O9iIwL
         GITWosQKK6Q6hJ9yJ7sgxbHVB2XYlPpwzpjDWpQWxwSK4ewAFVmGnlp1Q4javRZlX89E
         5s8A==
X-Forwarded-Encrypted: i=1; AJvYcCXO+lrnTwwidzTwzugfmD0na6t+/LTfqIDYqWzJ8+OxNODNsOEuyy0pJmnAvgdIE2QDl01sBbdthVeWFzbyJRY4vTsdYtYQLl65mNtt
X-Gm-Message-State: AOJu0YwdtpIbAKHaOzWMZbzT0VZT4InJHghl6iJFZsQTe1ZauOAwoLFL
	Kk9mEgYPnO7X9nijoLobchjiTM+6uQGNW1PvvYIeyjywycZ5/3d+IiumCwtlA8v95GVmVKLq3EE
	7JMMFgTza7JJcqPFNJMmJBFcYZws=
X-Google-Smtp-Source: AGHT+IElwjwg10UlhuYyRIKD1o2Wk343chTN2Bb2aAnSQcUtC/rN2FirgwzpB1kAz7Poir3ON1YvjgfwcfYb5sJvtKo=
X-Received: by 2002:a2e:8611:0:b0:2d4:5d44:fe1d with SMTP id
 a17-20020a2e8611000000b002d45d44fe1dmr5285431lji.52.1710648471835; Sat, 16
 Mar 2024 21:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
 <ZfRDJTrFJq3KSbIB@casper.infradead.org> <CAGWkznGiVrqMs9fX2WGG9QsfTm72ffFj-cWXSUo3azrgeBOgAg@mail.gmail.com>
 <ZfWzxOq7JupJtZtg@casper.infradead.org>
In-Reply-To: <ZfWzxOq7JupJtZtg@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sun, 17 Mar 2024 12:07:40 +0800
Message-ID: <CAGWkznG8dAorMG_qRDe5+NH9H1gj8qFbif_v+ztEcjQVu-fjXQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 10:59=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sat, Mar 16, 2024 at 04:53:09PM +0800, Zhaoyang Huang wrote:
> > On Fri, Mar 15, 2024 at 8:46=E2=80=AFPM Matthew Wilcox <willy@infradead=
org> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 04:39:21PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Panic[1] reported which is caused by lruvec->list break. Fix the ra=
ce
> > > > between folio_isolate_lru and release_pages.
> > > >
> > > > race condition:
> > > > release_pages could meet a non-refered folio which escaped from bei=
ng
> > > > deleted from LRU but add to another list_head
> > >
> > > I don't think the bug is in folio_isolate_lru() but rather in its
> > > caller.
> > >
> > >  * Context:
> > >  *
> > >  * (1) Must be called with an elevated refcount on the folio. This is=
 a
> > >  *     fundamental difference from isolate_lru_folios() (which is cal=
led
> > >  *     without a stable reference).
> > >
> > > So when release_pages() runs, it must not see a refcount decremented =
to
> > > zero, because the caller of folio_isolate_lru() is supposed to hold o=
ne.
> > >
> > > Your stack trace is for the thread which is calling release_pages(), =
not
> > > the one calling folio_isolate_lru(), so I can't help you debug furthe=
r.
> > Thanks for the comments.  According to my understanding,
> > folio_put_testzero does the decrement before test which makes it
> > possible to have release_pages see refcnt equal zero and proceed
> > further(folio_get in folio_isolate_lru has not run yet).
>
> No, that's not possible.
>
> In the scenario below, at entry to folio_isolate_lru(), the folio has
> refcount 2.  It has one refcount from thread 0 (because it must own one
> before calling folio_isolate_lru()) and it has one refcount from thread 1
> (because it's about to call release_pages()).  If release_pages() were
> not running, the folio would have refcount 3 when folio_isolate_lru()
> returned.
Could it be this scenario, where folio comes from pte(thread 0), local
fbatch(thread 1) and page cache(thread 2) concurrently and proceed
intermixed without lock's protection? Actually, IMO, thread 1 also
could see the folio with refcnt=3D=3D1 since it doesn't care if the page
is on the page cache or not.

madivise_cold_and_pageout does no explicit folio_get thing since the
folio comes from pte which implies it has one refcnt from pagecache

#thread 0(madivise_cold_and_pageout)        #1
(lru_add_drain->fbatch_release_pages)
#2(read_pages->filemap_remove_folios)
refcnt =3D=3D 1(represent page cache)

refcnt=3D=3D2(another one represent LRU)
   folio comes from page cache
folio_isolate_lru
release_pages
                 filemap_free_folio


                             refcnt=3D=3D1(decrease the one of page cache)

 folio_put_testzero =3D=3D true

  <No lruvec_del_folio>

 list_add(folio->lru, pages_to_free) //current folio will break LRU's
integrity since it has not been deleted

In case of gmail's wrap, split above chart to two parts

#thread 0(madivise_cold_and_pageout)        #1
(lru_add_drain->fbatch_release_pages)
refcnt =3D=3D 1(represent page cache)

refcnt=3D=3D2(another one represent LRU)
folio_isolate_lru                                               release_pag=
es

 folio_put_testzero =3D=3D true

  <No lruvec_del_folio>

 list_add(folio->lru, pages_to_free)

 //current folio will break LRU's integrity since it has not been
deleted

#1 (lru_add_drain->fbatch_release_pages)
#2(read_pages->filemap_remove_folios)
refcnt=3D=3D2(another one represent LRU)
   folio comes from page cache
release_pages
                 filemap_free_folio

                            refcnt=3D=3D1(decrease the one of page cache)
 folio_put_testzero =3D=3D true
 <No lruvec_del_folio>
 list_add(folio->lru, pages_to_free)
//current folio will break LRU's integrity since it has not been deleted
>
> >    #0 folio_isolate_lru          #1 release_pages
> > BUG_ON(!folio_refcnt)
> >                                          if (folio_put_testzero())
> >    folio_get(folio)
> >    if (folio_test_clear_lru())

