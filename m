Return-Path: <linux-kernel+bounces-159151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D818B2A00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D502823E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8459152E0F;
	Thu, 25 Apr 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gD5UC/7y"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA714C591
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077762; cv=none; b=LV3Purjx55pYnyXhqbF90XArKsw9SPdzo7VL6mLQh01cPWkNxVInRFPWnE/dxBrmzvMsoyi3xrIO4LH7BRkqMAxQdOSabfv6WTj5k+rx0dNdBwqvg6xXL/eA3a4976KLs8o8g+F3iTUiYiVQ8EU2poyWagWfm5xX7EGAlW6AExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077762; c=relaxed/simple;
	bh=Edu66Pp361LP1TJKH9qQGwnWCXUz4E51XfhmasI4O5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zlx128/fQxfkIBxI33IMQ688If0aeKxlkykXSNt2ZTwy6BLUXfmq1n1ORZ4MmnvXtt3RpFIhRBNsv1es3nRU6QhDCAQVzu/Sq3ZU8vT8jJQKuDdR24OP1ZCsgNzxP5JjLgjYk9o3dfnVMLwQFX3duKk6q1bsxCQPvs3ROvnjfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gD5UC/7y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a55b93f5540so193125466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714077759; x=1714682559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8a5q661VPv7YxA4YAbF7nmm8AiOpL1vdq49c/Cxoac=;
        b=gD5UC/7ycNlP/aZY5PO92oCaovzSljG23i9LpJzzvV+O/QH6c7nA/KovC4FPlGTu/9
         VLTMkxc0luAZFEUJ2omEg/VS7hdLyEs8GAtrABePsPjvA5sUmDXsTHFV0baMK5wG2ncv
         NdwHDLnWb6rhuJ8dZ2prpitF6bfKLYIR17M5qkxP3xAFqMxJCi6GlGYbCZe0J8lURtke
         oihF/hK6U9Do+1fWuSj1VJyRsU02fU6xzIlyaQ7guOXTBrK9eexP0VxsEnuyRb9y23Qt
         MaTcmQhcqUtATj6H75KltmL91WkQyxYGxMtw2Ia1zvcmx6f0pyK99OSgM5/qbks65il+
         eWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077759; x=1714682559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8a5q661VPv7YxA4YAbF7nmm8AiOpL1vdq49c/Cxoac=;
        b=GfTFL+CdOSRxqxXlfah/MBNDzzxJHkSwNtk16SfkxOCDv4cduwqnD4P5WX+Z0dvPMd
         tpPvos1alN/4bS+/r5+PmMFgROJNWo3lUJf7OwxV39T/BqyqsJdAvsSd5PLtvRoPNGw6
         qE92L1Ts1v9DchWepLFxkJkQTppBzGFdjrnCWZlhomUIr1N4MIb477Dz55kKwmU1RlG3
         Pj/GkSB3k37FTrmezAyVlLZXEcqsBjdfAVSefjq3PjFzWQ4O6dXmt62J4nbkAw02YwkT
         B+VvJDshXiY/v81kUyljhhBb4gB4gHuGOWVQuUZv6/k7PvdiSvxoa9KIKd83QDJF9Kl+
         3vzw==
X-Forwarded-Encrypted: i=1; AJvYcCXYisVyq5+PC8fDt2gk8MC3Yjp401WwVFTm9/h3u4TCSF0aAZuZ2+pAnIsEgpCH3S325hDQyz7NydO3zG+BGBFOiA0f4yXxNrdL2ETF
X-Gm-Message-State: AOJu0YwNO+Htp6hLD9j98OEgg8bB1Dtx2SCr4AhUdYazQCQWt7L4azxs
	MPiDRLoWwHQ2+jyadwheSF5wadG97c9uu5ylAofV1HymQorDG/v+RIa1f4HI1H52NVQUPcMYHFr
	HV9TW7WuBShj9wY0O3Oy00jwR3aiiQ0R6RlrI
X-Google-Smtp-Source: AGHT+IF8glrQQZXivTHTEdZkivvyewVxG1or4YNFL13C7gDAHUAxcrvQ+LqyKeNL3S/zxBLZ9GrqgEsXW2c3S4x8MCc=
X-Received: by 2002:a17:906:13c9:b0:a58:8fa6:df18 with SMTP id
 g9-20020a17090613c900b00a588fa6df18mr483805ejc.41.1714077758402; Thu, 25 Apr
 2024 13:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com> <63222bf6a298ae38e77b0c0f49d13581dd9d3a74.camel@nvidia.com>
In-Reply-To: <63222bf6a298ae38e77b0c0f49d13581dd9d3a74.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 25 Apr 2024 13:42:24 -0700
Message-ID: <CAHS8izNyJWhcRro8OFPTqsh9J4LEbm7Le6-CiW_oxi2NopAqeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	Jianbo Liu <jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 12:48=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Thu, 2024-04-25 at 12:20 -0700, Mina Almasry wrote:
> > On Thu, Apr 25, 2024 at 1:17=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
com> wrote:
> > >
> > > On Wed, 2024-04-24 at 15:08 -0700, Mina Almasry wrote:
> > > >  If that doesn't work, I think I prefer
> > > > reverting a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
> > > > rather than merging this fix to make sure we removed the underlying
> > > > cause of the issue.
> > > This is the safest bet.
> > >
> > > So, to recap, I see 2 possibilities:
> > >
> > > 1) Revert a580ea994fd3 ("net: mirror skb frag ref/unref helpers"): sa=
fe, but it
> > > will probably have to come back in one way or another.
> > > 2) Drop the recycle checks from skb_frag_ref/unref: this enforces the=
 rule of
> > > always referencing/dereferencing pages based on their type (page_pool=
 or
> > > normal).
> > >
> >
> > If this works, I would be very happy. I personally think ref/unref
> > should be done based on the page type. For me the net stack using the
> > regular {get|put}_page on a pp page isn't great. It requires special
> > handling to make sure the ref + unref are in sync. Also if the last pp
> > ref is dropped while there are pending regular refs,
> > __page_pool_page_can_be_recycled() check will fail and the page will
> > not be recycled.
> >
> > On the other hand, since 0a149ab78ee2 ("page_pool: transition to
> > reference count management after page draining") I'm not sure there is
> > any reason to continue to use get/put_page on pp-pages, we can use the
> > new pp-ref instead.
> >
> > I don't see any regressions with this diff (needs cleanup), but your
> > test setup seems much much better than mine (I think this is the
> > second reffing issue you manage to repro):
> >
> > diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> > index 4dcdbe9fbc5f..4c72227dce1b 100644
> > --- a/include/linux/skbuff_ref.h
> > +++ b/include/linux/skbuff_ref.h
> > @@ -31,7 +31,7 @@ static inline bool napi_pp_get_page(struct page *page=
)
> >  static inline void skb_page_ref(struct page *page, bool recycle)
> >  {
> >  #ifdef CONFIG_PAGE_POOL
> > -       if (recycle && napi_pp_get_page(page))
> > +       if (napi_pp_get_page(page))
> >                 return;
> >  #endif
> >         get_page(page);
> > @@ -69,7 +69,7 @@ static inline void
> >  skb_page_unref(struct page *page, bool recycle)
> >  {
> >  #ifdef CONFIG_PAGE_POOL
> > -       if (recycle && napi_pp_put_page(page))
> > +       if (napi_pp_put_page(page))
> >                 return;
> >  #endif
> >         put_page(page);
> >
> >
> This is option 2. I thought this would fix everything. But I just tested =
and
> it's not the case: we are now reaching a negative pp_ref_count. So probab=
ly
> somewhere a regular page reference is still being taken...
>

I would guess the most likely root cause of this would be a call site
that does get_page() instead of skb_frag_ref(), right?

The other possibility would be if something like:

- page is not pp_page
- skb_page_ref(page) // obtains a regular reference.
- page is converted to pp_page
- skb_page_unref(page) // drops a pp reference.

But I'm not aware of non-pp pages ever being converted to pp pages.

You probably figured this out already, but if you would like to dig
further instead of reverting the offending patch, this diff would
probably catch the get_page() callsite, no? (on my test setup this
debug code doesn't trigger).

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b0ee64225de..a22a676f4b6b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1473,8 +1473,14 @@ static inline void folio_get(struct folio *folio)
        folio_ref_inc(folio);
 }

+static inline bool debug_is_pp_page(struct page *page)
+{
+       return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
+}
+
 static inline void get_page(struct page *page)
 {
+       WARN_ON_ONCE(debug_is_pp_page(page));
        folio_get(page_folio(page));
 }

@@ -1569,6 +1575,8 @@ static inline void put_page(struct page *page)
 {
        struct folio *folio =3D page_folio(page);

+       WARN_ON_ONCE(debug_is_pp_page(page));
+
        /*
         * For some devmap managed pages we need to catch refcount transiti=
on
         * from 2 to 1:

--=20
Thanks,
Mina

