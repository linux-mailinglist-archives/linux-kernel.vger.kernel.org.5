Return-Path: <linux-kernel+bounces-125478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430378926BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9FD283FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F013D288;
	Fri, 29 Mar 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MaTCu3L7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E728DC1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751389; cv=none; b=Ba3PoqbbC2dc64mLc6ohtJVGjGIyUibcO9qGlZEQ9AXGrn4mFRvwGvX90ZqgXegidqOeuet22wUIBnVp4a8aKrKgQITh4Maxattfzz3C3y4a8WAm45KS8rC0qhuksxPm7Wy/iXHilrppoRJla292aYDqSi5y+jwUYF/gBo+AJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751389; c=relaxed/simple;
	bh=ZhS15EJWoC9d+whMPENxa4c8jVobeAR8ixYkWHdE4jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRKRlkjgl9X6xiqV+Qx+9dN7cNoDkZ0lQTZZ1A6RClbT7YTupe7tmy9OrrIXIP3pDekY6R9E3pCs++45MwO62mxpflfFJd80gHfEcbxiIpJFrG79FhKJ1veF0SBpPEMTsOwIZ2j7MfKn28ZU7n7mFseDM6jMUQqyuRvf+BuXjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaTCu3L7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46a7208eedso312472966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711751386; x=1712356186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7HucFjZo+IYW7DIZaEciZZcS/GCvuWFK/7eA6qgdTI=;
        b=MaTCu3L7Au/QBT0aGlP+eobgxnAmnd1exUyHqcZM0E5o63xFoJWsIN2EvjnDoa2R3o
         xhjA9Gcc+RaX2FB1WnwOKRXoDYW/Mx6N2iKFPsdIpuDRdsVRdwmPvLhNNFr0wTGtMOst
         OzUJrUScfKS+uHUnQr1HyAivoSfwW8ZFPL5u3AC+f8Z+kHQTDofEV8eyk+a8SuKaAv//
         F++eb64Wn4nUwN3ktIqxNGjdQbYLs6pplfMr6CcTZ4jEEWuv7q7Bk93gWpCGBnLOOVaR
         4N0EutgH3x743dAx0DLgUTE++lRs10pbNoRTmG403fLvdJeHIZSLfAiFCijn2WQhzcXM
         hrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751386; x=1712356186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7HucFjZo+IYW7DIZaEciZZcS/GCvuWFK/7eA6qgdTI=;
        b=GzJUp3cjY+ziNyYbWPaAbkpgnekwO345+IUkatG/4BlZit0RAmph41wxxTV4LLtXVe
         X/T2Ucn4W/nbGzkFjmVYa3DiZ2Puy/dQJmiGUih6t54X5o4Rxz8OQBnfri6Qfk3apcRM
         JTUv8JaBwGx3PVrfXPvdvbaYHnqCrxiZ/h+usSeMC0MMlsIa2fPaw4PbW/fgCSkrOx6q
         xFR2NgfUuSU4zM/5mcUylyWXI20DD5aC2Dj2zhAlenxFBDP2tc7q/oSEV+/QzEJvuzHj
         p0Eoj9yGsLdeINcLVvbG1JuyeoplIllZm2ZgOdPIkTOrzfVsZv5VREadDgWG8ImVDrrk
         MYKg==
X-Forwarded-Encrypted: i=1; AJvYcCWIna+uZfqjsOCBKe8o+eaB8KD7X0MYEOnQZxTqrEwEFX3WcJXfpLrwwfkTqY921GL1U5srbbmOBbICb6pUwHpK8aHXjrNLCe9pXXBT
X-Gm-Message-State: AOJu0YwBOtOmEd3kCvTZAUC4U9DJiUrsyf2D8rXrXgpS+/zLKq2PMMBM
	kLoGEDP9zdEi4DkoQmg9B7W3rE05U0GXQxvF4rsRZrrAeZ2OUb7NyEObsh8gg2TW7R+edHyFSHi
	iPm6bctIaJ72pWsc/jBZ/SM2zWw5SpbM3x9Tv
X-Google-Smtp-Source: AGHT+IG4teUTwPktp+DR/5ayqNkHcdTq36vc3n8+aVyWq9S2DzWoZpaL12inphGYAcc7sq15bW+08Sn6mRyVTrx26qU=
X-Received: by 2002:a17:906:4f92:b0:a47:61cd:2b51 with SMTP id
 o18-20020a1709064f9200b00a4761cd2b51mr2283347eju.2.1711751385930; Fri, 29 Mar
 2024 15:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
 <20240328210709.GH7597@cmpxchg.org> <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
 <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
 <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com>
 <20240329173759.GI7597@cmpxchg.org> <CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com>
 <20240329211723.GA882964@cmpxchg.org>
In-Reply-To: <20240329211723.GA882964@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 29 Mar 2024 15:29:07 -0700
Message-ID: <CAJD7tkZeYi65nYZ8c-3ZdNRWuSsgHjerXAPbZcMH5kKF3Kjdow@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Srividya Desireddy <srividya.desireddy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:17=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Mar 29, 2024 at 11:56:46AM -0700, Yosry Ahmed wrote:
> > > I perf'd zswapping out data that is 10% same-filled and 90% data that
> > > always needs compression. It does nothing but madvise(MADV_PAGEOUT),
> > > and the zswap_store() stack is already only ~60% of the cycles.
> > >
> > > Using zsmalloc + zstd, this is the diff between vanilla and my patch:
> > >
> > > # Baseline  Delta Abs  Shared Object         Symbol
> > > # ........  .........  ....................  ........................=
............................
> > > #
> > >      4.34%     -3.02%  [kernel.kallsyms]     [k] zswap_store
> > >     11.07%     +1.41%  [kernel.kallsyms]     [k] ZSTD_compressBlock_d=
oubleFast
> > >     15.55%     +0.91%  [kernel.kallsyms]     [k] FSE_buildCTable_wksp
> > >
> > > As expected, we have to compress a bit more; on the other hand we're
> > > removing the content scan for same-filled for 90% of the pages that
> > > don't benefit from it. They almost amortize each other. Let's round i=
t
> > > up and the remaining difference is ~1%.
> >
> > Thanks for the data, this is very useful.
> >
> > There is also the load path. The original patch that introduced
> > same-filled pages reports more gains on the load side, which also
> > happens to be more latency-sensitive. Of course, the data could be
> > outdated -- but it's a different type of workload than what will be
> > running in a data center fleet AFAICT.
> >
> > Is there also no noticeable difference on the load side in your data?
>
>      9.40%     +2.51%  [kernel.kallsyms]  [k] ZSTD_safecopy
>      0.76%     -0.48%  [kernel.kallsyms]  [k] zswap_load
>
> About 2% net.
>
> Checking other compression algorithms, lzo eats 27.58%, and lz4
> 13.82%. The variance between these alone makes our "try to be smarter
> than an actual compression algorithm" code look even sillier.
>
> > Also, how much increase did you observe in the size of compressed data
> > with your patch? Just curious about how zstd ended up handling those
> > pages.
>
> Checking zsmalloc stats, it did pack the same-filled ones down into 32
> byte objects. So 0.7% of their original size. That's negligible, even
> for workloads that have an unusually high share of them.

Glad to see that this was handled appropriately.

>
> > > It's difficult to make the case that this matters to any real
> > > workloads with actual think time in between paging.
> >
> > If the difference in performance is 1%, I surely agree.
> >
> > The patch reported 19-32% improvement in store time for same-filled
> > pages depending on the workload and platform. For 10% same-filled
> > pages, this should roughly correspond to 2-3% overall improvement,
> > which is not too far from the 1% you observed.
>
> Right.
>
> > The patch reported much larger improvement for load times (which
> > matters more), 49-85% for same-filled pages. If this corresponds to
> > 5-8% overall improvement in zswap load time for a workload with 10%
> > same-filled pages, that would be very significant. I don't expect to
> > see such improvements tbh, but we should check.
>
> No, I'm seeing around 2% net.

You mentioned that other compressors eat more cycles in this case, so
perhaps the data in the original patch comes from one of those
compressors.

>
> > > But let's say you do make the case that zero-filled pages are worth
> > > optimizing for.
> >
> > I am not saying they are for sure, but removing the same-filled
> > checking didn't seem to improve performance much in my testing, so the
> > cost seems to be mostly in maintenance. This makes it seem to me that
> > it *could* be a good tradeoff to only handle zero-filled pages. We can
> > make them slightly faster and we can trim the complexity -- as shown
> > by this patch.
>
> In the original numbers, there was a certain percentage of non-zero
> same-filled pages. You still first have to find that number for real
> production loads to determine what the tradeoff actually is.
>
> And I disagree that the code is less complex. There are fewer lines to
> the memchr_inv() than to the open-coded word-scan, but that scan is
> dead simple, self-contained and out of the way.
>
> So call that a wash in terms of maintenance burden, but for a
> reduction in functionality and a regression risk (however small).
>
> The next patch to store them as special xarray entries is also a wash
> at best. It trades the entry having an implicit subtype for no type at
> all. zswap_load_zero_filled() looks like it's the fast path, and
> decompression the fallback; the entry destructor is now called
> "zswap_tree_free_element" and takes a void pointer. It also re-adds
> most of the lines deleted by the zero-only patch.
>
> I think this is actually a bit worse than the status quo.
>
> But my point is, this all seems like a lot of opportunity cost in
> terms of engineering time, review bandwidth, regression risk, and
> readability, hackability, reliability, predictability of the code -
> for gains that are still not shown to actually matter in practice.

Yeah in terms of code cleanliness it did not turn out as I thought it
would. Actually even using different subtypes will have either
similarly abstract (yet less clear) helpers, or completely separate
paths with code duplication -- both of which are not ideal. So perhaps
it's better to leave it alone (and perhaps clean it up slightly) or
remove it completely.

I wanted to see what others thought, and I was aware it's
controversial (hence RFC) :)

Anyway, I will send a separate series with only cleanups and removing
knobs. We can discuss completely removing same-filled handling
separately. I suspect 2% regression in the load path (and potentially
larger with other compressors) may not be okay.

If handling for zero-filled pages is added directly in reclaim as you
suggested though, then the justification for handling other patterns
in zswap becomes much less :) Handling it in reclaim also means we
avoid IO for zero pages completely, which would be even more
beneficial than just avoiding compression/decompression in zswap.

>
> https://lore.kernel.org/all/20240328122352.a001a56aed97b01ac5931998@linux=
-foundation.org/
>
> This needs numbers to show not just that your patches are fine, but
> that any version of this optimization actually matters for real
> workloads. Without that, my vote would be NAK.

