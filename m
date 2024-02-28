Return-Path: <linux-kernel+bounces-85093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D074286B058
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8DA1C25B20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB214AD3B;
	Wed, 28 Feb 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJsUzn0Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29F14F972
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126945; cv=none; b=nhjmjoihji4sSp5GV5jRk7Gs2J6S0coQrkAu1IdrrrXkwCIwxT4c8luLd3RG3fGfFkeTO6omwV/8Zu1JO2VIExaUm6vBYE+bhyiblsGKsMIyFS5wMsFMqOO8HXUM++J9TEoFk/MXNvE6MVhunf1eUBxHZ/8vzz1VVelsuDsLBxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126945; c=relaxed/simple;
	bh=IfmFXfbK3R/LIyE90QHJWRfTx4KyigVZpqXpto5Q4DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVAcKfibB75UFU94QaF8tR4dgmXz4PWN1JdB96P14N+7ImFQ6Ay0xZhEPAdhLp9/qNzkXrG0r1hcc4AuQPfT0kgR0El4sp5uEq1yc7ZHdQFF4gKldoiidYMqhAlkFBtHKf3tekOepHhu4LEMHxpUQE0TAnZUpgoNKrMFOmWc+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJsUzn0Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709126942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzKz87X7zhw07wGgQEpRWyJyCCLZwlQ33or22c6llKE=;
	b=eJsUzn0ZHxrHJmLAtV8L2k9z8VILP95YRixQ/YWYhWksapeqmbj0V85z+yJdg6EWxsdf4c
	GCGsVrzwcnBojAVMT6cL/Z7miAq+Kh13E6LH1KjCAPTeDDqb6UheE8ty3cwD7RSeDArRF/
	nv7ZbbFkC9kegm2+wlHSpkkcy+FemVI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-pBD6APGbPkeVSvgH1pe_ww-1; Wed, 28 Feb 2024 08:28:59 -0500
X-MC-Unique: pBD6APGbPkeVSvgH1pe_ww-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d51bb9353so2900742f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126938; x=1709731738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzKz87X7zhw07wGgQEpRWyJyCCLZwlQ33or22c6llKE=;
        b=S+SZV6LoysaOve7u3oideJTABBuumet66dt8FkIY35z6mGSM1sF7BAIe+xU6Fea1gX
         GPfjUBP1RyiiQLC8xLiZE77LP5/Em1/IN2qLlMnxQB4XCq8b9gq4XmAQB931j/KhDZII
         2a842G5vX2dL6eeqCHvh9Uo5xxAvN121VdtRCLU3Fl0LneRRbAUDzDVMNofxb41iPLjh
         FPgxxGSAvnQDvW9sWe8hAYr70NxDZaW7m/SA6ZGBdSrFBk17O82jAy/QJftYlx0byene
         L55uyUfypXrT827DVzSDQ4salUCB7OYYx2dFCjcoeffqzQMHbYqnix45HPjkVfBm7X1o
         2Mug==
X-Forwarded-Encrypted: i=1; AJvYcCUwj7HCORJxrQYyE8Zz2PXi+eKmEYgQKm8tVtwMO9Bojj/5xeMRQ+XeOiuK+kFtkYomx8Oi8UJK26nDvg0vaALVsBBNOaUVyd4y7KU9
X-Gm-Message-State: AOJu0Yy7OViCIwn9jfI3HHItq6EMNQX80+JZXUnqVnpkf62zngKlUFgL
	CeFdE7DuMBzlRZBAdyQpg//p3aC4adnVCnHIWRQa2kPoI2OXfxFJd0ao8lF90cNelb6gHtS/wg3
	ctdyb+F54/gw2NqzX2ja06gqfc/tiU/CivYegX1ud1ybdDwx8mhkdjdQn7HyqI0tSDZGYr0LuFs
	9oDJNjLhoAmtcJM20cYgvTS3qfFasjuBnk1I02
X-Received: by 2002:adf:e810:0:b0:33d:debe:15ee with SMTP id o16-20020adfe810000000b0033ddebe15eemr5490341wrm.41.1709126938102;
        Wed, 28 Feb 2024 05:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/7tTth1UugRontBQamP0uQUJItTsuBcfEuO2T9Qe+0sz/72aEcJpcLxVCnucG0jdzD9JxAvhSiIh44nXuwU0=
X-Received: by 2002:adf:e810:0:b0:33d:debe:15ee with SMTP id
 o16-20020adfe810000000b0033ddebe15eemr5490327wrm.41.1709126937780; Wed, 28
 Feb 2024 05:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-18-pbonzini@redhat.com>
 <Zd6W-aLnovAI1FL3@google.com> <CAJD7tkapC6es9qjaOf=SmE9XYUdbh_fAperjSe9hy=_iqdB0wQ@mail.gmail.com>
 <Zd8x3w2mwyAufKvm@casper.infradead.org>
In-Reply-To: <Zd8x3w2mwyAufKvm@casper.infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 14:28:45 +0100
Message-ID: <CABgObfZ9LFDrtLkMaT5LVwy0Z2QMk6SqJ104+D=w7o9i0gEu+g@mail.gmail.com>
Subject: Re: [PATCH 17/21] filemap: add FGP_CREAT_ONLY
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:15=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 27, 2024 at 06:17:34PM -0800, Yosry Ahmed wrote:
> > On Tue, Feb 27, 2024 at 6:15=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Feb 27, 2024, Paolo Bonzini wrote:
> > >
> > > This needs a changelog, and also needs to be Cc'd to someone(s) that =
can give it
> > > a thumbs up.
> >
> > +Matthew Wilcox
>
> If only there were an entry in MAINTAINERS for filemap.c ...

Not CCing you (or mm in general) was intentional because I first
wanted a review of the KVM APIs; of course I wouldn't have committed
it without an Acked-by. But yeah, not writing the changelog yet was
pure laziness.

Since you're here: KVM would like to add a ioctl to encrypt and
install a page into guest_memfd, in preparation for launching an
encrypted guest. For this API we want to rule out the possibility of
overwriting a page that is already in the guest_memfd's filemap,
therefore this API would pass FGP_CREAT_ONLY|FGP_CREAT
into__filemap_get_folio. Do you think this is bogus...

> This looks bogus to me, and if it's not bogus, it's incomplete.

.. or if not, what incompleteness can you spot?

Thanks,

Paolo

> But it's hard to judge without a commit message that describes what it's
> supposed to mean.
>
> > >
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > ---
> > > >  include/linux/pagemap.h | 2 ++
> > > >  mm/filemap.c            | 4 ++++
> > > >  2 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > > index 2df35e65557d..e8ac0b32f84d 100644
> > > > --- a/include/linux/pagemap.h
> > > > +++ b/include/linux/pagemap.h
> > > > @@ -586,6 +586,7 @@ pgoff_t page_cache_prev_miss(struct address_spa=
ce *mapping,
> > > >   * * %FGP_CREAT - If no folio is present then a new folio is alloc=
ated,
> > > >   *   added to the page cache and the VM's LRU list.  The folio is
> > > >   *   returned locked.
> > > > + * * %FGP_CREAT_ONLY - Fail if a folio is not present
> > > >   * * %FGP_FOR_MMAP - The caller wants to do its own locking dance =
if the
> > > >   *   folio is already in cache.  If the folio was allocated, unloc=
k it
> > > >   *   before returning so the caller can do the same dance.
> > > > @@ -606,6 +607,7 @@ typedef unsigned int __bitwise fgf_t;
> > > >  #define FGP_NOWAIT           ((__force fgf_t)0x00000020)
> > > >  #define FGP_FOR_MMAP         ((__force fgf_t)0x00000040)
> > > >  #define FGP_STABLE           ((__force fgf_t)0x00000080)
> > > > +#define FGP_CREAT_ONLY               ((__force fgf_t)0x00000100)
> > > >  #define FGF_GET_ORDER(fgf)   (((__force unsigned)fgf) >> 26) /* to=
p 6 bits */
> > > >
> > > >  #define FGP_WRITEBEGIN               (FGP_LOCK | FGP_WRITE | FGP_C=
REAT | FGP_STABLE)
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 750e779c23db..d5107bd0cd09 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -1854,6 +1854,10 @@ struct folio *__filemap_get_folio(struct add=
ress_space *mapping, pgoff_t index,
> > > >               folio =3D NULL;
> > > >       if (!folio)
> > > >               goto no_page;
> > > > +     if (fgp_flags & FGP_CREAT_ONLY) {
> > > > +             folio_put(folio);
> > > > +             return ERR_PTR(-EEXIST);
> > > > +     }
> > > >
> > > >       if (fgp_flags & FGP_LOCK) {
> > > >               if (fgp_flags & FGP_NOWAIT) {
> > > > --
> > > > 2.39.0
> > > >
> > > >
> > >
>


