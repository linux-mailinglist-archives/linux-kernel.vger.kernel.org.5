Return-Path: <linux-kernel+bounces-28246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89382FC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37DC28E22B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A781DA3E;
	Tue, 16 Jan 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk61hpZs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B01D526
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436967; cv=none; b=n5y7KG+GWfCwz908ksbEp0rLl/5iLAm5B297xzxEZB50855ZtSXJHT3AMXdC7JoQf152e2/9ldbdXVd+DXEOZiIGhgC9WKyGjdEusuIMfjkdPHf6POH1k2F0AXIs78xF4Av9JmPiohauhqQxC5HWTlaOUg/prCqtsZT7oAAWslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436967; c=relaxed/simple;
	bh=cwAOQUr30q2ktqa9/7YMYPZE3GrhQvorb3OmRFp57kY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Ytoiyr2yEEefj0vSCnTi3y2Y3xZoz3pfWwZUz0u0bj8j0lg6BPfihAvopR9C5lNMXjsn4/5jcjKiNB2MHWI9P6dkIenCvdt7HZIjUcePXib9sU4dYdiI665Ln1gnCRVDAs/8Tj4HoEGZsbbXXMuGvw1OwpR5HVyqlOD6kdzqEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk61hpZs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2c67be31edso646636966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705436964; x=1706041764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlVylpwq7EHMoUhpeUYxVoKLMBZq2evpSqBt9P2b8io=;
        b=mk61hpZsn6xlDrmf0kXNj8OHyLxi+uOYO4jC0Me78JDBO+T2J0+GuLMIkw4LhfDA9D
         TxGehj19PcoOJBrY72I4ZETQ4Tja11tSkXDKglHqtjzdXr/Z+feJ8YeE/KG9SUdPP7K3
         DVydXLzJjTj5kKz3ynGeBfmxj37ZaibZufOTjQOBgrSw43TX3WXj6iEqpHhZlNRMHKnr
         cuBuEs4FynzSuXwLLfex1UwEdka0qtHiHX9UskgA7nFobdX5dCVfMKM5HzW6tWoKNh0X
         HniSEIQ+TVDHD/LqP/eAsLrHFfv5m62ou0o6hin5HsqnRpGNHYf7WEheM//rBOh4tVfC
         +yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436964; x=1706041764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlVylpwq7EHMoUhpeUYxVoKLMBZq2evpSqBt9P2b8io=;
        b=Vj7OXT6au1V4fsRSjf6DMM8i5Lc2xvLiVjbkvaDL4rBNZfQzqP9/j4vpwBejlo+K4i
         iBT12cb+16+JfaBGCVGRz0m+lI1rcm+njD1ndxdnf0G7FdGtmal/hFhO9pHp/IZV1vzI
         mqWVrWn9aNRisC3tLNaWWqUic1Apq90lU7D9Qyncumzpedip0g8JwMXTn3CvrFl/G4uB
         bG4S5nVYiMKvuOtcoKEdpcYI5TD1BfzI1Tm0bWHQe37zfyQCJG8p3Nk1nVFJ1/4WwnvM
         SRczbcDcOxbfJ1hQf6CRlTTofhDQbibd5sh5DN/YfWFRcsghyMyONwlxcTjmDnKrRlxc
         drwA==
X-Gm-Message-State: AOJu0YwG+qEzs0xQq9n8Np4f4rIOdBltqTm2+PVMArPUNMuVDRlS+mBl
	hgtLO38OZyfkTnzsZ3OvQgw2gnR1EYHLJtLcpXBpAxpipBWq
X-Google-Smtp-Source: AGHT+IGmdi+XOz4E+uUCLfi66st3ymRH99QBHes/4q8aLhSjqZmqqv1KZ8kwORV6KDYGoH3VENm5TAw+h2FB4HE/+fs=
X-Received: by 2002:a17:906:79c5:b0:a28:f771:aeb2 with SMTP id
 m5-20020a17090679c500b00a28f771aeb2mr2063045ejo.180.1705436964172; Tue, 16
 Jan 2024 12:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com> <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
In-Reply-To: <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jan 2024 12:28:46 -0800
Message-ID: <CAJD7tkbfe5duVhN7kJhkQZLCbK48giVZ8LBx=RQDmp80oa2FDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:40=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> > > > >
> > > > > Unless some page flag/readahead expert can confirm that the first
> > > > > option is safe, my vote is on this option. I mean, it's fairly mi=
nimal
> > > > > codewise, no? Just a bunch of plumbing. We can also keep the othe=
r
> > > > > call sites intact if we just rename the old versions - something =
along
> > > > > the line of:
> > > > >
> > > > > __read_swap_cache_async_head(..., bool add_to_lru_head)
> > > > > {
> > > > > ...
> > > > > if (add_to_lru_head)
> > > > >   folio_add_lru(folio)
> > > > > else
> > > > >   folio_add_lru_tail(folio);
> > > > > }
> > > > >
> > > > > __read_swap_cache_async(...)
> > > > > {
> > > > >    return __read_swap_cache_async_tail(..., true);
> > > > > }
> > > > >
> > > > > A bit boilerplate? Sure. But this seems safer, and I doubt it's *=
that*
> > > > > much more work.
> > > > >
> > > >
> > > > Yes=EF=BC=8C agree. I will try it again.
> > >
> > > Look forward to seeing it! Thanks for your patience and for working o=
n this.
>
> Please forgive me for adding additional information about this patch.
>
> I have finished the opt for introducing a folio_add_lru_tail(), but
> there are many
> questions:
> 1) A new page can be move to LRU only by lru_add_fn, so
>     folio_add_lru_tail could not add pages to LRU for the following code
>     in folio_batch_move_lru(),which is added by Alex Shi for
>     serializing memcg changes in pagevec_lru_move_fn[1].
>
> /* block memcg migration while the folio moves between lru */
>         if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(folio))
>             continue;
> To achieve the goal, we need to add a new function like  lru_add_fn
> which does not have the lru flag and folio_add_lru_tail()
> +               if (move_fn !=3D lru_add_fn && move_fn !=3D lru_move_tail=
_fn_new &&
> +                       !folio_test_clear_lru(folio))
>
> 2)  __read_swap_cache_async has six parameters, so there is no space to
> add a new one, add_to_lru_head.
>
> So it seems a bit hacky just for a special case for the reasons above.

It's a lot of plumbing for sure. Adding a flag to current task_struct
is a less-noisy yet-still-hacky solution. I am not saying we should do
it, but it's an option. I am not sure how much task flags we have to
spare.

>
> Back to the beginning,  lru_add_drain() is the simplest option=EF=BC=8Cwh=
ich is common
> below the __read_swap_cache_async(). Please see the function
> swap_cluster_readahead()
> and swap_vma_readahead(), of course it has been batched.
>
> Or we should  leave this problem alone=EF=BC=8Cbefore we can write back z=
swap
> in batches.

Calling lru_add_drain() for every written back page is an overkill
imo. If we have writeback batching at some point, it may make more
sense then.

Adding Michal Hocko was recently complaining [1] about lru_add_drain()
being called unnecessarily elsewhere.

[1]https://lore.kernel.org/linux-mm/ZaD9BNtXZfY2UtVI@tiehlicka/

