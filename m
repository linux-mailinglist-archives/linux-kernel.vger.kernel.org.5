Return-Path: <linux-kernel+bounces-160594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483C8B3FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F3A1F22F93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454620319;
	Fri, 26 Apr 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PclBr43e"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993711D53F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158244; cv=none; b=IDazPAR7jTHUle0CmczYCJDvgA7cfFTuMtwyM/lh/p7iCMbhkC04DSB6+73Ck8+lqO93xwS6U0P2uwRI+uepLngF295qq/9BdSIWbaK7bJ0NwJEbJAvyb3RMHoi0wY80j4gs43TNo4azFPafXex4OD2PQh78p+MD2i4N4jAal10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158244; c=relaxed/simple;
	bh=CQdNTTJu3j/mg39vJK3C5jXIss3CCLzQnXvMUyqzbOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWn9YE5vf8brCJAwL3jYn0900AAP8GCUPpLiCml2StiVFWnc1yTqnwiABBUeDANKIHxel76mXa1Zwbcbblqb3mC/xgXLsGWEsjbfbXesA3ICJKnkDEZZQ0MI0XEg2euZ0yR1vR0CEXcirW3b4EVjvfqu1Z3UCWB54iGcsj9yNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PclBr43e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso3101632a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714158241; x=1714763041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m00bEU780KBB1VMtPyI6E3MI0vl8OtQDqHQXttBNFNg=;
        b=PclBr43eJAbMLPKPuOQhgUrhAnSDMXEjJhPoImLzIVUKrLNE5xuBpYI5Nc3sZ2mVwI
         YTn4UL9VzaCfb8P6AIEhLkmz76/s2HSdQ22XAXcdWEt0IKnzqYFAW9M+m79Ze7u/GI2k
         Paq/37hD5l6yD2Pmp6hknzxYe7cXidjL8TulNOZwlEbNEjW2q52zZM5sWEgWSSgOW4gw
         vrzQUcasv2nBN+EfMTaeepQHHINv7I3eXow1wlvC6pYXcg4QFTlvFZZkulBHIK3J0dPM
         O7gTa+5KtAuvTMjK3uftF8UE93bZGMP9agTQpSJD97v859Uvry2z76owgQHs4LCaLTE6
         4vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714158241; x=1714763041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m00bEU780KBB1VMtPyI6E3MI0vl8OtQDqHQXttBNFNg=;
        b=LAPuSzYbILZXZqc/NA6AZzUFoNw33e4i5k+wVfAvhJlv0t5g+sdKvuGQCBP53ynvr1
         mA9fUmqaqNjvttCebhb06AiKLOmDhBuTPvWtGEe/3PDjW22FkHHaD/5NqMBAfpXdtiNq
         8GHTxetg0nBz8xQ7LyZjDZRxgcC/cXx6dGISFEvV0zlyestfo28GTv5pLCWjIfZddMCw
         JsTcP2Lgn8X/vi/GlckTVGDpybvicvmde0Ue0HWByByKBItGMNs9nOgPdl6YhBM6YvJm
         wHGOuDWghBTJu/fuSaSu0A00nH5tCC+ZZH3WJMXjnYNcOcr56NAtZw5eMryfsUiGIm18
         bVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYF5fqXllfP4sEu7mbUWfmbH7d9wXQo5w546/Ifz8gGi35ZXXsqke25iePM+MA/1KTbcv25c0xSCl4TVPzELyoB+ryEcNwoY2WKDZB
X-Gm-Message-State: AOJu0Yy7mlHk585E8Z+tRWCZmxJlu/xNhb5czVy9bHQmfWoH3bEED94b
	VH1kYEroMEfzc7h1yWxivb7Sf143Pyq9SFCuoBhSk2RSTmA7aSOXNDFqvyJeNkGUYXDDVZknMTY
	f9QSk5LE1dj+kFin/Sc6voJdZRiYnMs0ejHF+
X-Google-Smtp-Source: AGHT+IHC29f8VkEC0j2ntDFfs1/Xgh7oSkE15z+ZaqRDydnhpQDaoumrjx3ub5RHts27HndacKq3GJDbcLuIolCzNUc=
X-Received: by 2002:a17:906:6048:b0:a58:87d5:b624 with SMTP id
 p8-20020a170906604800b00a5887d5b624mr2572733ejj.20.1714158240548; Fri, 26 Apr
 2024 12:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
 <63222bf6a298ae38e77b0c0f49d13581dd9d3a74.camel@nvidia.com>
 <CAHS8izNyJWhcRro8OFPTqsh9J4LEbm7Le6-CiW_oxi2NopAqeQ@mail.gmail.com> <88222bf4d3b4d142ee227eb56d24fa7a7ca43fe1.camel@nvidia.com>
In-Reply-To: <88222bf4d3b4d142ee227eb56d24fa7a7ca43fe1.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 26 Apr 2024 12:03:41 -0700
Message-ID: <CAHS8izOhDknjJFZNstXLg=UvbtKTwjbw+0w+4Xx1p+cnqOKRxw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:59=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, 2024-04-25 at 13:42 -0700, Mina Almasry wrote:
> > On Thu, Apr 25, 2024 at 12:48=E2=80=AFPM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> > >
> > > On Thu, 2024-04-25 at 12:20 -0700, Mina Almasry wrote:
> > > > diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.=
h
> > > > index 4dcdbe9fbc5f..4c72227dce1b 100644
> > > > --- a/include/linux/skbuff_ref.h
> > > > +++ b/include/linux/skbuff_ref.h
> > > > @@ -31,7 +31,7 @@ static inline bool napi_pp_get_page(struct page *=
page)
> > > >  static inline void skb_page_ref(struct page *page, bool recycle)
> > > >  {
> > > >  #ifdef CONFIG_PAGE_POOL
> > > > -       if (recycle && napi_pp_get_page(page))
> > > > +       if (napi_pp_get_page(page))
> > > >                 return;
> > > >  #endif
> > > >         get_page(page);
> > > > @@ -69,7 +69,7 @@ static inline void
> > > >  skb_page_unref(struct page *page, bool recycle)
> > > >  {
> > > >  #ifdef CONFIG_PAGE_POOL
> > > > -       if (recycle && napi_pp_put_page(page))
> > > > +       if (napi_pp_put_page(page))
> > > >                 return;
> > > >  #endif
> > > >         put_page(page);
> > > >
> > > >
> > > This is option 2. I thought this would fix everything. But I just tes=
ted and
> > > it's not the case: we are now reaching a negative pp_ref_count.
> > >
> I was tired and botched the revert of the code in this RFC when testing.
> Dropping the recycle flag works as expected. Do we need an RFC v2 or is t=
his non
> RFC material?
>
> Thanks,
> Dragos
>

IMO, it needs to be cleaned up to remove the bool recycle flag dead
code, but other than that I think it's good as a non RFC.

To save you some time I did the said clean up and here is a patch
passing make allmodconfig build + checkpatch/kdoc checks + tests on my
end:

https://pastebin.com/bX5KcHTb

I could submit it to the list if you prefer.

FWIW, if this approach shows no regressions, I think we may be able to
deprecate skb->pp_recycle flag entirely, but I can look into that as a
separate change.

--
Thanks,
Mina

