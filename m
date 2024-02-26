Return-Path: <linux-kernel+bounces-81876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E01867B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E628CA13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253B12C548;
	Mon, 26 Feb 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN2K994n"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BA12C53E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964004; cv=none; b=bq1U/9HM1zF5gxfY8imvP3eFCMXRVgHVMOgZpZkR4v+EQTY6pLVrZ1AEZOtdz7LAUccMmbwdnmLL1vTo9KbAJ7mkzBuBR7XMJWntXCb3vZZukPdg68lJ4Bc9mUxLWw3Xf/I7dAnb+qNItvpv8xmfAxDtYyZtdOjWfzjv6nz/eCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964004; c=relaxed/simple;
	bh=mOK4Q3ifnIj+875T3wjIs22+dyQ5N366k6rQFEkfZdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjxKJ1gKJ7a3rLYze8RRAEzXjSawMUrhDUXDTNNReett9kLO5iHRdWarCf/KQBOxye6e+4XbsQ3TOjYwo+/6OHt0SUV6Iec4vELwYDeVStVgdl4teARnnL021tYNHeqZ4J/EOzbPbofe2IHzZhthpwRpJW671MjUwnv39xeafao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fN2K994n; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608ceccb5f4so11947127b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708964002; x=1709568802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW2P7s5GOudhG2wB4Rb+S+Sqx8F90ikdbK5TGYSYqGw=;
        b=fN2K994nQbcJTNegqeEuZMaodr7gB5BswWV8G8hJwrPbkD+hoc1+WiXtLYQIds1dGM
         /bP2sP4OSt98zKPLvMe8X6HhfKz5Ms8ueQk1BZqgqHURRdrr3NMan0R92uDLD4+jONPw
         RuDZAsGyStu9w6B/rsNHvmmuK1CvafeuUfEvDbPLEVx8EFsowAnywUNEGd7paYP5BAV3
         l5ZGmrNaTKxrwqBGQL07PActsTuj5WHIHfBRjPrr47vJCTCxjhj1eUEqhXv+UB1llzx0
         ghcdBzGDRlTtqsjJS5oZX4wm+0QpvciihXAZQ5K2g5HMtCtqaZXkb9fxAVBMI3ILbonf
         W20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964002; x=1709568802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW2P7s5GOudhG2wB4Rb+S+Sqx8F90ikdbK5TGYSYqGw=;
        b=Sgvdh0HS+1JrYzH5wLd5AjSHBSqWA6fMXgrqjWt6/RpeZ7H6QJ74MK/2nhdjUmAyrT
         MVBRbXxYzUyRuo3b3AxNkKBNUtWevDXbyRHrOnP49cPj5sgYIeCTVcZo6NQ4kBO3Oe3w
         bavL1ecZeMSRibNABUV8taklOtIL5TDWPbGRKfnjmKNb5lTB/tJRIder79AKzXbmO9Kg
         A++iz6sbo2CZGGce2J6R1QwXWDsLCorumrV74/Cq6BunmaoINaUaRjTXEwvhKoNIF4tB
         k2ky4J3w64gwpdZdda35Xxltj94X1RMDGC6V1Eqtna4iKxeMh229Kt4V6SIod0WVWMGM
         EPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyFky4ZEtxCD1Vd4DDmXnP+N0BbWmqXxfXFoT37R2UurqgvS3uyzRlSLPCpBh4hWeJ6ka8vU5l5/b0R0Hy4rMWKzMp+P3NZ6ldpaqC
X-Gm-Message-State: AOJu0YyByWzEq5Nd+tbS4QLiFWOEV6GNXuxbrWBz5XdrJkasMTil91iG
	IE7LKw2FQlaQ1yxczTEaqp192zPzcFFpknoPdSDpzWEAjOvKzWrI/StyCTi8coQvxW6A/TMn/oR
	eTAjlfNG0EbYU9XvoyXyI1AqPn1ZEaYkFmCdv
X-Google-Smtp-Source: AGHT+IE9eZNSED/rVpI8+NxOvuy5es9uemnJbcDcVT26wGQR0+v2/KDTMV/LlFJZ6uABBH6ioDdEsR937b/kK1g9ugY=
X-Received: by 2002:a25:94c:0:b0:dc6:c617:7ca with SMTP id u12-20020a25094c000000b00dc6c61707camr4740121ybm.29.1708964001501;
 Mon, 26 Feb 2024 08:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224015800.2569851-1-surenb@google.com> <c45d16c6-abab-4132-a499-c231dcedebb2@wanadoo.fr>
 <CAJuCfpFskKqCGj4imMMLjUQJWR_8-KHuYc=xAZ4e20+57Zf5Rg@mail.gmail.com> <ZdxPN4RpNW54ckTE@tiehlicka>
In-Reply-To: <ZdxPN4RpNW54ckTE@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 08:13:10 -0800
Message-ID: <CAJuCfpHvK4DgKqoHcB1YhQqKEZwniGsVL9LbVdLxWUxBd=9EVA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: enumerate all gfp flags
To: Michal Hocko <mhocko@suse.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, petr@tesarici.cz, keescook@chromium.org, 
	pasha.tatashin@soleen.com, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Sun 25-02-24 01:12:46, Suren Baghdasaryan wrote:
> > On Sat, Feb 24, 2024 at 7:03=E2=80=AFAM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > >
> > > Le 24/02/2024 =C3=A0 02:58, Suren Baghdasaryan a =C3=A9crit :
> > > > Introduce GFP bits enumeration to let compiler track the number of =
used
> > > > bits (which depends on the config options) instead of hardcoding th=
em.
> > > > That simplifies __GFP_BITS_SHIFT calculation.
> > > >
> > > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > > Changes from v4 [1]:
> > > > - Split from the series [2] as a stand-alone patch, per Michal Hock=
o
> > > > - Added Reviewed-by, per Pasha Tatashin
> > > > - Added Acked-by, per Michal Hocko
> > > >
> > > > [1] https://lore.kernel.org/all/20240221194052.927623-7-surenb@goog=
le.com/
> > > > [2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@goog=
le.com/
> > > >
> > > >   include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++-------=
-----
> > > >   1 file changed, 62 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > > > index 1b6053da8754..868c8fb1bbc1 100644
> > > > --- a/include/linux/gfp_types.h
> > > > +++ b/include/linux/gfp_types.h
> > > > @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
> > > >    * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
> > > >    */
> > > >
> > > > +enum {
> > > > +     ___GFP_DMA_BIT,
> > > > +     ___GFP_HIGHMEM_BIT,
> > > > +     ___GFP_DMA32_BIT,
> > > > +     ___GFP_MOVABLE_BIT,
> > > > +     ___GFP_RECLAIMABLE_BIT,
> > > > +     ___GFP_HIGH_BIT,
> > > > +     ___GFP_IO_BIT,
> > > > +     ___GFP_FS_BIT,
> > > > +     ___GFP_ZERO_BIT,
> > > > +     ___GFP_UNUSED_BIT,      /* 0x200u unused */
> > >
> > > Hi,
> > >
> > > what is the need to have this ___GFP_UNUSED_BIT now?
> >
> > Hi!
> > We can remove it but then all values will shift. That should be safe
> > to do now but I prefer one patch to do only one thing. We can add a
> > separate patch to do further cleanup of unused values.
>
> Agreed!
>
> > > > +     ___GFP_DIRECT_RECLAIM_BIT,
> > > > +     ___GFP_KSWAPD_RECLAIM_BIT,
> > > > +     ___GFP_WRITE_BIT,
> > > > +     ___GFP_NOWARN_BIT,
> > > > +     ___GFP_RETRY_MAYFAIL_BIT,
> > > > +     ___GFP_NOFAIL_BIT,
> > > > +     ___GFP_NORETRY_BIT,
> > > > +     ___GFP_MEMALLOC_BIT,
> > > > +     ___GFP_COMP_BIT,
> > > > +     ___GFP_NOMEMALLOC_BIT,
> > > > +     ___GFP_HARDWALL_BIT,
> > > > +     ___GFP_THISNODE_BIT,
> > > > +     ___GFP_ACCOUNT_BIT,
> > > > +     ___GFP_ZEROTAGS_BIT,
> > > > +#ifdef CONFIG_KASAN_HW_TAGS
> > > > +     ___GFP_SKIP_ZERO_BIT,
> > > > +     ___GFP_SKIP_KASAN_BIT,
> > > > +#endif
> > > > +#ifdef CONFIG_LOCKDEP
> > > > +     ___GFP_NOLOCKDEP_BIT,
> > > > +#endif
> > > > +     ___GFP_LAST_BIT
> > > > +};
> > >
> > > Does it make sense to have something like:
> > >    BUILD_BUG_ON(___GFP_LAST_BIT > BITS_PER_LONG, "blah");
> >
> > I suppose that would not hurt, except gfp_t is unsigned int, not long.
> > Something like this would work I think:
> >
> > BUILD_BUG_ON_MSG(___GFP_LAST_BIT > BITS_PER_TYPE(gfp_t), "GFP bit overf=
low");
> >
> > except I'm not sure where to put this check. One of the __init
> > functions in page_alloc.c would probably work but none seem to be
> > appropriate. mm_core_init() perhaps? Other ideas?
>
> Would that check add much? We currently cannot use the full width of the
> gfp_t because radix tree code needs to fit also its own tag into the
> same word (see radix_tree_init). If the radix tree constrain is lifted
> then we should add something like the above.

Ah, good point. That check in radix_tree_init() is already more strict
than this one. Looks like we are covered.
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs

