Return-Path: <linux-kernel+bounces-123576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7F890B42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387411F25CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2913AD2A;
	Thu, 28 Mar 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eqn1aOe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E6137C2A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657462; cv=none; b=mf0n0VAmHcFbi+1XlYatyj8ZXR300XNHqJGhvslysHIJi44VCb4tfvjiPQUrO7dwW+z0jjM7OdxJ7LP4vQdjxlGXPllHv4Yg+NuvKSWlu5UyXQ4VGDvNdWekcdKR2GH0WBnUb6YoA133PJ6Z+uIH5zEOmMDguaSOrfFMoO9j1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657462; c=relaxed/simple;
	bh=qmxf34bTMVgxH0f4NNBYG+HHviiW1iKApL+RlIdON68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGA83CDM15nSYtIYTEJZcNYeC+itHjJPD2kv6CbwfJ6UMMwrnqOh2c2BqC85ER/ELFZHebKvKKZN+1a4zlP0OugbgHtgOPJxfDqRI07keH0bX5cNdHw1FU7qZWTjzSx38pV3FZzH7BiBcpfbkqVe4UjrhLRm9wfDz9dgNTIm8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eqn1aOe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3417a3151c4so1230560f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711657458; x=1712262258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6wzOI8f0nNiuU7SM67JbM3AAeU2GfbdXdqb/BOOqV4=;
        b=2eqn1aOesEfXvERF1AgEg1ZKalq/F3Ex+9mt9T6D5AAbvEEB7V72V/Gf8koaGVWQjW
         dQJTr2tnqVwVZOVfXk/4HmsIlWoHagg/x8kfkVsZpUDgdqZdBDHdZiv+DwJAHynrZPYj
         6/cNK8eL/TqouD3l1yCFy+rxwIN07k6y6Mrsrp7O74Ca4epDmxjGxvawAZN4K39yqxAG
         m66f4u8ykCH46g6wDAAA51F3vPiBmKHjuDLukq7dIIXTCO8unvN8J1r3mjEJkUwnLVnP
         zYFKm7nywZwyUJFFjrhb5UwakRz6z81BrH1PSHTF+fnEUmenIVhY3bAzSxX7f36/GMLh
         Y2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657458; x=1712262258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6wzOI8f0nNiuU7SM67JbM3AAeU2GfbdXdqb/BOOqV4=;
        b=lxByp+04iLH1vdPTmVH9UmAi5Y/1tLk3InmYsoFKAQzmPrvHDE6RFsF1ADPTvrqrwJ
         2kcNfl23Ah8d+Pi4NoAszwoLWQIQPdtHhgPBeGNAHvFeBoG8qJIAmnUoIA7H8Chs4lCe
         OjsQJXZvw/M2SkQs6KPEuhcSZCOk/dNw8sLe3uEQd+mrKkduuKiUuYL3uFgMIBmsxQfh
         UeEHnMukbos8Es8JLTess0vu3ytVuwRPVInE9Pcv7PHBCeB7T2+L93dW979DhknaETTp
         pU1qs4NP/lI/1jLGhfHuoeid0YV5MKag53vpVX4o2Bb/lWsfkVyjTm7Gk+5RCh3AC4uX
         erXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKFvLwaLDOej3XCmjtjV6apctonW7ifSdZ5cMdbq9nbdxoyYY0W6+wbD0Izhfe7I1F1YTe7WsjmS1k2L0KAgXQKjqRo8ignNLBYWP2
X-Gm-Message-State: AOJu0YwyharX2frEqqXKGx1H+cdoyGaet0nqUF6CEPgdW3g4/a6XJIuj
	C8BszQXHM9xS+9kPCKdZYedUhYJAHYwITf2woY6+5aj9lHE40pqKQNA0bYIqo1LmFWQx0e4j8Jw
	50YXCC5Qm38Ho/C3vZjGiW2txTztZ5+T/5VJdkibWDt7aEdWXLH+v
X-Google-Smtp-Source: AGHT+IFXkGygkGArDNlR3c03YewcMnsXn2Y3WZHSXGvnNDU1C+7dW3MQ3mb3DZucF5DN+YcgsADtFr+OPnTSdxO7Axs=
X-Received: by 2002:a05:6000:1d86:b0:33e:76a1:d031 with SMTP id
 bk6-20020a0560001d8600b0033e76a1d031mr160319wrb.50.1711657458197; Thu, 28 Mar
 2024 13:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
In-Reply-To: <20240328193149.GF7597@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 13:23:42 -0700
Message-ID: <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > The current same-filled pages handling supports pages filled with any
> > repeated word-sized pattern. However, in practice, most of these should
> > be zero pages anyway. Other patterns should be nearly as common.
> >
> > Drop the support for non-zero same-filled pages, but keep the names of
> > knobs exposed to userspace as "same_filled", which isn't entirely
> > inaccurate.
> >
> > This yields some nice code simplification and enables a following patch
> > that eliminates the need to allocate struct zswap_entry for those pages
> > completely.
> >
> > There is also a very small performance improvement observed over 50 run=
s
> > of kernel build test (kernbench) comparing the mean build time on a
> > skylake machine when building the kernel in a cgroup v1 container with =
a
> > 3G limit:
> >
> >               base            patched         % diff
> > real          70.167          69.915          -0.359%
> > user          2953.068        2956.147        +0.104%
> > sys           2612.811        2594.718        -0.692%
> >
> > This probably comes from more optimized operations like memchr_inv() an=
d
> > clear_highpage(). Note that the percentage of zero-filled pages during
> > this test was only around 1.5% on average, and was not affected by this
> > patch. Practical workloads could have a larger proportion of such pages
> > (e.g. Johannes observed around 10% [1]), so the performance improvement
> > should be larger.
> >
> > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org=
/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> This is an interesting direction to pursue, but I actually thinkg it
> doesn't go far enough. Either way, I think it needs more data.
>
> 1) How frequent are non-zero-same-filled pages? Difficult to
>    generalize, but if you could gather some from your fleet, that
>    would be useful. If you can devise a portable strategy, I'd also be
>    more than happy to gather this on ours (although I think you have
>    more widespread zswap use, whereas we have more disk swap.)

I am trying to collect the data, but there are.. hurdles. It would
take some time, so I was hoping the data could be collected elsewhere
if possible.

The idea I had was to hook a BPF program to the entry of
zswap_fill_page() and create a histogram of the "value" argument. We
would get more coverage by hooking it to the return of
zswap_is_page_same_filled() and only updating the histogram if the
return value is true, as it includes pages in zswap that haven't been
swapped in.

However, with zswap_is_page_same_filled() the BPF program will run in
all zswap stores, whereas for zswap_fill_page() it will only run when
needed. Not sure if this makes a practical difference tbh.

>
> 2) The fact that we're doing any of this pattern analysis in zswap at
>    all strikes me as a bit misguided. Being efficient about repetitive
>    patterns is squarely in the domain of a compression algorithm. Do
>    we not trust e.g. zstd to handle this properly?

I thought about this briefly, but I didn't follow through. I could try
to collect some data by swapping out different patterns and observing
how different compression algorithms react. That would be interesting
for sure.

>
>    I'm guessing this goes back to inefficient packing from something
>    like zbud, which would waste half a page on one repeating byte.
>
>    But zsmalloc can do 32 byte objects. It's also a batching slab
>    allocator, where storing a series of small, same-sized objects is
>    quite fast.
>
>    Add to that the additional branches, the additional kmap, the extra
>    scanning of every single page for patterns - all in the fast path
>    of zswap, when we already know that the vast majority of incoming
>    pages will need to be properly compressed anyway.
>
>    Maybe it's time to get rid of the special handling entirely?

We would still be wasting some memory (~96 bytes between zswap_entry
and zsmalloc object), and wasting cycling allocating them. This could
be made up for by cycles saved by removing the handling. We will be
saving some branches for sure. I am not worried about kmap as I think
it's a noop in most cases.

I am interested to see how much we could save by removing scanning for
patterns. We may not save much if we abort after reading a few words
in most cases, but I guess we could also be scanning a considerable
amount before aborting. On the other hand, we would be reading the
page contents into cache anyway for compression, so maybe it doesn't
really matter?

I will try to collect some data about this. I will start by trying to
find out how the compression algorithms handle same-filled pages. If
they can compress it efficiently, then I will try to get more data on
the tradeoff from removing the handling.

Thanks for the insights.

