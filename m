Return-Path: <linux-kernel+bounces-38133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AC83BB47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD0B28D4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F54D171C9;
	Thu, 25 Jan 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ml85Uu8i"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148413AE8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169872; cv=none; b=MQcF8fHOUvqoDTXbh2OBrBgl9s9R3doxAnR0Qc75TXqnnmks7A+/7qr1JTV/oRsss1DyoOA3f493MPSzG5n/i2/f3apUoIkUCzhVE6+zgyQB42VdHqSOUhvL2YbEb64vjsjC17SG860u8YHd4oLzfqrQ5UuqZB4yv6cPdfKlbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169872; c=relaxed/simple;
	bh=nbEIuFB5A5XX39UC0VCdyx+dlgGNaYXATJU8aqEkgfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlgdj5KKiDoOvVYSmYiHcj6L3wQ8OiFyrmrSe/B+5zPm0ZBaN8jWXhLTHvGzXD0bP94iFx/KtVTzYMLZVvvr6UdZh7w6VIZqLZDqlNPMGGMPcLk1/541WDDnZ7fLyLGERGwg24ELb7gpw26iWQGDUNfUZhIADzwyUxvBJO9GpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ml85Uu8i; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4311327a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706169869; x=1706774669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbEIuFB5A5XX39UC0VCdyx+dlgGNaYXATJU8aqEkgfk=;
        b=Ml85Uu8iRC6cz7FhDoFL4pO7iYyRF6CS9U+SxwKHpAIbIhNcSPVvJU4Tdho7a/340y
         OBJTC5xiuqeUVWOfJ594DFUSlZp4jnGohNKlOVBwvym19OxGTOIhbagMu7SkFH0X6KhM
         2ruKmZfp2nncrXh8kUYOaCJuUtNwUOLcTL0UlZpsmbLoVAwCYznu3YyGAblkPSRBVFsS
         PVQUWTS8pYbPeCkWwF43hPyoNAHaSeUCdjLQkfodaRJRVI6UJChl92MER8JSZSI1wbJC
         i1cubDyBCHwV/iyUtFdiKDT3yBUI47XqtZPp4MAE5w08ns8y23alrPnh/770jZuVCyqs
         +nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169869; x=1706774669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbEIuFB5A5XX39UC0VCdyx+dlgGNaYXATJU8aqEkgfk=;
        b=ED5r/vr9N8TEvrZ42sz4t0AU2Gg3HYr2L/o+F4Orpdn3X1+riLcPoRP5N6tWhjrD46
         uRqz1K8/VWQBwI4BrapOWSuA+cVGCwl/82i34qMUVGgBW24rl8whNPKhb/uBmvJ71EIa
         ZheH1ZfGoZE/B9B6yStyjcXb5GJ6mgv+J9g6AoOLhRqNI3L38JjhMCgCnPich/wHu5Qc
         iqZ9dx/fcWmlcXlzEb7aptWvq6ALR06TtgoHCFVAkJTK1Uc+4fqAQeyEQqudeMXLElxZ
         e4etwrGL6G4uGGnSEz76/j5YdLqRthkeNyGezIWOzCFvDHXmikdUMV+o0xO93JxA9BDn
         IJOg==
X-Gm-Message-State: AOJu0YyTf8FcmWB0AzPRlhp8jiRkjl53awnu4UnGjKyB6zotWSJHTYHs
	MUNDzAAbwQ2kczV1TCksOEXCZQxO4uT6OLsqiSHAGuurk89zWKXm0xEGunzlivWuvM4DK7OEh9C
	7Q4Y4UNKrdAxmJG56md50sIw9RDW9gAZcs/0Y
X-Google-Smtp-Source: AGHT+IGIW7mc7I7DA3/R/orIYvaRnOs6vYuyv9HmINqG5ofGjNKk3OYQW9skTMwEegGwIEruiRoZzoCb+htD1FzYTxE=
X-Received: by 2002:a17:907:8743:b0:a31:7c5a:bf5b with SMTP id
 qo3-20020a170907874300b00a317c5abf5bmr260977ejc.5.1706169868749; Thu, 25 Jan
 2024 00:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com> <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
In-Reply-To: <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 00:03:52 -0800
Message-ID: <CAJD7tkZEJ1hzSoQ-8yG5-TYJBKUXCBNAW8Kdh=FSG3W0f_Dc4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > Hello,
> >
> > I also thought about this problem for some time, maybe something like b=
elow
> > can be changed to fix it? It's likely I missed something, just some tho=
ughts.
> >
> > IMHO, the problem is caused by the different way in which we use zswap =
entry
> > in the writeback, that should be much like zswap_load().
> >
> > The zswap_load() comes in with the folio locked in swap cache, so it ha=
s
> > stable zswap tree to search and lock... But in writeback case, we don't=
,
> > shrink_memcg_cb() comes in with only a zswap entry with lru list lock h=
eld,
> > then release lru lock to get tree lock, which maybe freed already.
> >
> > So we should change here, we read swpentry from entry with lru list loc=
k held,
> > then release lru lock, to try to lock corresponding folio in swap cache=
,
> > if we success, the following things is much the same like zswap_load().
> > We can get tree lock, to recheck the invalidate race, if no race happen=
ed,
> > we can make sure the entry is still right and get refcount of it, then
> > release the tree lock.
>
> Hmm I think you may be onto something here. Moving the swap cache
> allocation ahead before referencing the tree should give us the same
> guarantees as zswap_load() indeed. We can also consolidate the
> invalidate race checks (right now we have one in shrink_memcg_cb() and
> another one inside zswap_writeback_entry()).
>
> We will have to be careful about the error handling path to make sure
> we delete the folio from the swap cache only after we know the tree
> won't be referenced anymore. Anyway, I think this can work.
>
> On a separate note, I think there is a bug in zswap_writeback_entry()
> when we delete a folio from the swap cache. I think we are missing a
> folio_unlock() there.
>
> >
> > The main differences between this writeback with zswap_load() is the ha=
ndling
> > of lru entry and the tree lifetime. The whole zswap_load() function has=
 the
> > stable reference of zswap tree, but it's not for shrink_memcg_cb() bott=
om half
> > after __swap_writepage() since we unlock the folio after that. So we ca=
n't
> > reference the tree after that.
> >
> > This problem is easy to fix, we can zswap_invalidate_entry(tree, entry)=
 early
> > in tree lock, since thereafter writeback can't fail. BTW, I think we sh=
ould
> > also zswap_invalidate_entry() early in zswap_load() and only support th=
e
> > zswap_exclusive_loads_enabled mode, but that's another topic.
>
> zswap_invalidate_entry() actually doesn't seem to be using the tree at al=
l.

Never mind, I was looking at zswap_entry_put().

