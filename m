Return-Path: <linux-kernel+bounces-38255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2F83BD35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330EEB2BB45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9EB1BC5C;
	Thu, 25 Jan 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RdueRfj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289771BC3E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174855; cv=none; b=QJ4CuUwVX4mRawo4JzyG5mIGWk6Da4wWHcKYFKeXd/8X0R4TD5jEo3j2ydFaRknSqSlCqCM8bC7/ptsDy2V4AMBzwP9/V1NyaY8Zyb/sEEFsv1ndZfYDG5SW645UCqgnDuYYQ8Dok0q7Uzwltnvw5oN20y/aXk8zL/YDPpPYXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174855; c=relaxed/simple;
	bh=jxu9V88yZ4UG+aRX+313RxWb5ML+i/iwlaR54KeMD+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbmUMtvbLUwjAIohB0P+y7T5RtqVXG/UWueL7vgSFRWjSNay6/q6lVZoto14xa0i3+77KYDoOmZiTEOVW6NbLP0ZXCcYp3QPcsLUP9pJMVbEmJP1EkrjNwWhArm/dItJIb6x/aIjtO3eGZ0hDBn62DhoheDgfK/grWq9XG9LtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RdueRfj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30b3a9e9c6so351542866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706174852; x=1706779652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxu9V88yZ4UG+aRX+313RxWb5ML+i/iwlaR54KeMD+s=;
        b=2RdueRfj+ygV1uHTW+ycrqr2NObDygr5/nJmTxoRqCwlNNn49fQhrA35+b1d+2qNvS
         HJSdrbTErPq/TLmhXB22+9MxVvIdanOxihqQnmdsBDsjBIsSXK6UwHgLgTzP1wEw4xFz
         4cpvVSLgYMXITMol0lZhW0fHLhEyT23GRhJJ0BaafByTh1QI3cqKTc+Ubt7R4/OdMVxo
         0jgsNL56y5soz4I2wvymoWdSU8e9YI0JNs1cLcPJmLOJwwlmmTEGSSW4HONqEAK6+7oK
         AwsYRpZn7xPLdLkbb6n7UTrploKzdaJdpl2ewJfmKg9pgn1aUezRFwcGHHkWj8Jkcqoz
         /zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174852; x=1706779652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxu9V88yZ4UG+aRX+313RxWb5ML+i/iwlaR54KeMD+s=;
        b=pj6OaON1AChr4nxOcKe7c252MKSR1t6JS0t4NraFPZ61Yn+SKNxSDY8A8/nnDkmqcL
         zjvwey68B4BusbXfneNmEvNoDEhgZRGsyWIwei38QdFmMZjiZEmz6A0IpYIZ1IzpeF78
         pc6UpbDKq55ry9KETmO/cBxAlS9Ak/B2/JsJZzJIuFXIZww3vpOx5cEYwXzHR2zCfDn4
         DsioGmhPF+/cL/Dq8g6qC0tvSrgqJTcLtFr9qk61ltqDEARu/aMMsvVH5RUTNeUmRAQU
         c/URzI0p8TUkW982TbiMwg4rB26V3mMbyc0ZXgbHlgcZJBMlOl4lemZYnXGUldY1rPVG
         /l5A==
X-Gm-Message-State: AOJu0Yzwn0MitLONesuAD9pvsWyrLkq/zNGKPMH+PtrRYMqoxsphUGbr
	4f9iObor3hF3r7aJC3S1nFiCJDGjrBhcqXidZV0oMIQ6gaa9Jnd+rjdXNmMKbjk0HZqGamPVQG2
	jhV8szXUx79Wx2umGYS3khh+W8z42Q5t0uGjY4jtmk7qCtZ12Wz16
X-Google-Smtp-Source: AGHT+IHbGQaeXi5No/2WNrUVDS8iMvqeU07IVEV094Noq1vLvOQCbf1UJl4TTMMDDGyNMp2P8E1fyOD057RP4WlyE1I=
X-Received: by 2002:a17:906:c056:b0:a30:deb6:1bb7 with SMTP id
 bm22-20020a170906c05600b00a30deb61bb7mr211283ejb.132.1706174852166; Thu, 25
 Jan 2024 01:27:32 -0800 (PST)
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
 <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com> <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
 <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com> <CAJD7tkak+ZA8t+AVbYNXYWnrmVBBs=NfMTBQBsnHJQni2=gG2Q@mail.gmail.com>
 <1a8a513f-fa84-41ca-b7f4-62726e78fd31@bytedance.com>
In-Reply-To: <1a8a513f-fa84-41ca-b7f4-62726e78fd31@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 01:26:56 -0800
Message-ID: <CAJD7tkYBLkh82VQ6DmNQNXtnCxTVOY_7JRjARRtDrkKfKyTFSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:22=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/1/25 17:03, Yosry Ahmed wrote:
> >>>>>> The second difference is the handling of lru entry, which is easy =
that we
> >>>>>> just zswap_lru_del() in tree lock.
> >>>>>
> >>>>> Why do we need zswap_lru_del() at all? We should have already isola=
ted
> >>>>> the entry at that point IIUC.
> >>>>
> >>>> I was thinking how to handle the "zswap_lru_putback()" if not writeb=
ack,
> >>>> in which case we can't use the entry actually since we haven't got r=
eference
> >>>> of it. So we can don't isolate at the entry, and only zswap_lru_del(=
) when
> >>>> we are going to writeback actually.
> >>>
> >>> Why not just call zswap_lru_putback() before we unlock the folio?
> >>
> >> When early return because __read_swap_cache_async() return NULL or !fo=
lio_was_allocated,
> >> we don't have a locked folio yet. The entry maybe invalidated and free=
d concurrently.
> >
> > Oh, that path, right.
> >
> > If we don't isolate the entry straightaway, concurrent reclaimers will
> > see the same entry, call __read_swap_cache_async(), find the folio
> > already in the swapcache and stop shrinking. This is because usually
> > this means we are racing with swapin and hitting the warmer part of
> > the zswap LRU.
> >
> > I am not sure if this would matter in practice, maybe Nhat knows
> > better. Perhaps we can rotate the entry in the LRU before calling
> > __read_swap_cache_async() to minimize the chances of such a race? Or
> > we can serialize the calls to __read_swap_cache_async() but this may
> > be an overkill.
>
> Also, not sure, rotate the entry maybe good IMHO since we will zswap_lru_=
del()
> once we checked the invalidate race.

Not sure what you mean. If we rotate first, we won't have anything to
do in the failure case (if the folio is not locked). We will have to
do zswap_lru_del() if actually writeback, yes, but in this case no
synchronization is needed because the folio is locked, right?

