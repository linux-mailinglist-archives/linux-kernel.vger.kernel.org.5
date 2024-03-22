Return-Path: <linux-kernel+bounces-111855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDC8871C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B35282BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B655FBAE;
	Fri, 22 Mar 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ywb2pSrF"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48285FB81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127525; cv=none; b=ij0Dix7A40wTr7SQpy+q21IcydB39t9UmclEfwd6jdFZp3pRUH6RHeVL9aQrDLlydXIwLbvJ3qhHgMO2o0HgvSPGNG8jEsIEPoojL7QJUGufB0znFA7bpA117Oa8bb7tBpnempN5eOhHeb8DvJtOC0UEhTBbw9wkgmGL0fVL9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127525; c=relaxed/simple;
	bh=+ct2h7/fDBnMFZPkg8VIxn6Af6gVcsnE8gTLZhsQvpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyuOXJCh2/VmknQuUSgDwNT5DTn98IKpKGRIT0nyWq+myj6DfhQ2q5QHsNhGCjVFVr58Q5WxGRn0Nggwyw8+QOegv9DlgUeczOw3R3WikVLeDLrXSW8KgBV4pQRzN33C1HbWb3uWLRJlG9cqLfMUEJG2JekaQFZ/3TYE13y/5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ywb2pSrF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789e209544eso140236985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711127521; x=1711732321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AhgKXUbVNsRIrFdcvhPW/fXvU30n5049WUO63MYWMHk=;
        b=ywb2pSrFYD4czLKrHc8PgpVUcwkP7AMEG4B/+0effaAQ8H90Bv+87Aqm/jbKJOSlmi
         WRZrfGd5OT/gkLbhi+2aRBAFoAOL8NWQo/ZnggSCUPgnXEQno0FHYthCdqg3ksRKDcJa
         cAo6C1Ml5Mx0IZdEeomjCsolDAybsLCkH8AW4DEw4EKQe78Pb6+sSUrCKUDaXd6JV0Op
         4Ppcl4JG67SjJOF06yYSxXrlhxK4aqIt9OqckZxRtwq2Bh7DO7QldCHmlzJBeY4zfHMa
         qzuZ87UhRUMO8YM9if4h9DnmgM60fROHTgNNCa67hQlu1SBt3TK0E8B3mTy2h5zig0ef
         t8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127521; x=1711732321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhgKXUbVNsRIrFdcvhPW/fXvU30n5049WUO63MYWMHk=;
        b=KraQkJugEfLQGElTw5qvGwIS3Snkt2nuhkOKuLZSOzbXJ7QvpxTsy2aYXf0HUAwbCV
         MNNfSAq2YF6w5EnQulNfWXX9AYs/0CExRJcFW3svPU9UTu2YB2/FmYzMVbHD9ZTTJB3p
         eAPWSZTuf09KjTJH5RM6g6BKdtDhpUEHG1sPnH7MTOrdOvQPJy7LQPRUa95RUyPPR3DM
         nmDeC9xfDEID6he/IqmdR2ZwWlEkHbfECqhJP//6fbzZbJLoQqlxnnkAtoep8EDa/fiv
         SAHOt3LtPIY1d0FjVA0PEKjmTN7nKI9OUFoGUFFQQBbxtv++YTJwCbBAUFNre7QCSdPu
         CtVw==
X-Forwarded-Encrypted: i=1; AJvYcCXPlhJqeL/3wooWvgoUhGRbRgVTU+ORupN/MMKZrb+5xWQKo0APgE+cW5NWXhSavZLCv3VdAfEYN91LMFBGHed91jkbLO02MZv/lIv5
X-Gm-Message-State: AOJu0Yz9mZdrH9jGvSiiGRHKEOmky1w1OnsOMcRjOJf4jRZNcgG99Ahr
	Qz98mVk7sra02mNFJvbrJhrmUi31TWmsVvq3PKERFx5GvI0qfqxRDbEHAds4yCI=
X-Google-Smtp-Source: AGHT+IGagVLORI8RsabPqhy5Z9tIk+Bm9PW30xqfpOL0RjEQw3cGOQSh2YuEBEt6E2gvn2JnlObyng==
X-Received: by 2002:a05:6214:2525:b0:68f:e779:716c with SMTP id gg5-20020a056214252500b0068fe779716cmr3486339qvb.63.1711127521539;
        Fri, 22 Mar 2024 10:12:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id g15-20020a0562140acf00b0068fdb03a3a3sm1250906qvi.95.2024.03.22.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:12:01 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:11:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
Message-ID: <20240322171156.GC237176@cmpxchg.org>
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
 <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
 <20240322031907.GA237176@cmpxchg.org>
 <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNe5xXVp00Ogk2AL_zXFK6pN0u7=0avjyPPkagB3FWy8Q@mail.gmail.com>

On Fri, Mar 22, 2024 at 06:35:43AM -0700, Chris Li wrote:
> On Thu, Mar 21, 2024 at 8:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 21, 2024 at 04:56:05PM -0700, Yosry Ahmed wrote:
> > > On Thu, Mar 21, 2024 at 4:53 PM Chris Li <chrisl@kernel.org> wrote:
> > > >
> > > > Current zswap will leave the entry->pool uninitialized if
> > > > the page is same  filled. The entry->pool pointer can
> > > > contain data written by previous usage.
> > > >
> > > > Initialize entry->pool to zero for the same filled zswap entry.
> > > >
> > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > > ---
> > > > Per Yosry's suggestion to split out this clean up
> > > > from the zxwap rb tree to xarray patch.
> > > >
> > > > https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> > > > ---
> > > >  mm/zswap.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index b31c977f53e9..f04a75a36236 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
> > > >                         kunmap_local(src);
> > > >                         entry->length = 0;
> > > >                         entry->value = value;
> > > > +                       entry->pool = 0;
> > >
> > > This should be NULL.
> > >
> > > That being said, I am working on a series that should make non-filled
> > > entries not use a zswap_entry at all. So I think this cleanup is
> > > unnecessary, especially that it is documented in the definition of
> > > struct zswap_entry that entry->pool is invalid for same-filled
> > > entries.
> >
> > Yeah I don't think it's necessary to initialize. The field isn't valid
> > when it's a same-filled entry, just like `handle` would contain
> > nonsense as it's unionized with value.
> >
> > What would actually be safer is to make the two subtypes explicit, and
> > not have unused/ambiguous/overloaded members at all:
> >
> > struct zswap_entry {
> >         unsigned int length;
> >         struct obj_cgroup *objcg;
> > };
> >
> > struct zswap_compressed_entry {
> >         struct zswap_entry entry;
> >         struct zswap_pool *pool;
> >         unsigned long handle;
> >         struct list_head lru;
> >         swp_entry_t swpentry;
> > };
> >
> > struct zswap_samefilled_entry {
> >         struct zswap_entry entry;
> >         unsigned long value;
> > };
> 
> I think the 3 struct with embedded and container of is a bit complex,
> because the state breaks into different struct members

That's kind of the point. They're different types that have their own
rules and code paths. The code as it is right now makes it seem like
they're almost the same. From the above you can see that they have
actually almost nothing in common (the bits in struct zswap_entry).

This would force the code to show the difference as well.

Depending on how Yosry's patches work out, this may or may not be
worth doing. It's just an idea that could help make it easier.

> How about:
> 
> struct zswap_entry {
>         unsigned int length;
>         struct obj_cgroup *objcg;
>         union {
>                 struct /* compressed */ {
>                          struct zswap_pool *pool;
>                          unsigned long handle;
>                          swp_entry_t swpentry;
>                          struct list_head lru;
>                 };
>                struct /* same filled */ {
>                        unsigned long value;
>                 };
>         };
> };
> 
> That should have the same effect of the above three structures. Easier
> to visualize the containing structure.

I suppose it makes the struct a bit clearer when you directly look at
it, but I don't see how it would help with code clarity.

