Return-Path: <linux-kernel+bounces-125444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963028925FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C353284A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1113BC2A;
	Fri, 29 Mar 2024 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xsOWBEQ3"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8913BAFC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747077; cv=none; b=WL/NB9eFKMX+sM3GUhw6WICBnaRhsoKwq2tQyUYLDQXcr89OyeJSSrOxe9qQ/rEms5AS+R1wE4f64KxEjJQp46sBC35fPcHh6lyVEqXdNR5iGmBUYM+F7Nwf3SbAD9ra3Q4wwuTEaUa/ldczkkCDQMz20dYLKeWm3Sn4gsxHV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747077; c=relaxed/simple;
	bh=GWfvSVS/hkE5sYsgLJPyS7fXPJHvPS5cV8zCY2dLcog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkCqH6BPNy26ub5OYWCVITHOcfNfXCp4nVc+HNBoZ5W6oDhX1N6RuggidmRFTbd3gX40qMUvbNerqWqPJBOoSIFJ3TkSYDpfIQKfDs7SjtIuxg5Z/+CNRrysYY5pJY8YrJRkkRrAsNCG1t0r6v3kZ0Nd1IoYX3IgzNon6LilKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xsOWBEQ3; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c35c4d8878so1030637b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711747072; x=1712351872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nu980NuM6xd/O+4Xhask+LOSmTDfo5VWq/XJqRRyMbI=;
        b=xsOWBEQ3wSpsdb1tcmUPFv87tfm212Uat9BAInthTYxrIDLxqSKpD5PbCokhngV02v
         Qz57JY6vX/0Rp+Ecxnfg31X18x9Jjwwwhr9YwRre9c4p377hGvqbtKewF0nAQFXhrCfz
         aTewJAIgSILKjXfcGE8OUTukdEzfC1SkuCmwK8hNQ1fSEqqEGvDJ9ys2HonPDe49EJew
         mlG5iUul+3m8MfVLRFFuZd36IEzZImqlHkhQne1PumCP6QeZortC7BkuQsymiP7toSJw
         uHu8DH20W29gen/fOCzD9lWCDSGfuLVJlytLp+1zsSnTVxnQ08wzaCBcNNY+uNTINN8j
         xhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711747072; x=1712351872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu980NuM6xd/O+4Xhask+LOSmTDfo5VWq/XJqRRyMbI=;
        b=r8hVFealN5/sEx0qZdOLEMkCgtZxD6iOUP6vJQt6+77uuHU6YzAW1FzME/BEn54JJj
         1uwrs8phQhOI4aCljBrKDya9L9tT2Qg5NEWuuSSuOEn0fLr9O/jQpSj+Qoc6CUQDhhbl
         9p6p1EnX7nz/ZZqoUu7BOvymEuE6O9j9wJXPIi6gfGW/vbLLEze1vTtQGBp3QtE0bnju
         dLZUiewc+TPLLAyRtaqboTDn7+yqIhI4bFngSryxLFNkYP/scfIfOnFUqEOEDIpvUGyN
         X+WxyTzu1VvsF6U0yPiQqkNsWEUwATU0aCJRN/VYAwk39mg1PXIh5G27UdaO6NITn0e2
         KA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyyo3eGZUDl6pDQl+mSnkpuHHo+DUqozoXBB7zHF1KG+ZDKTVD4Z7aRyRO6+gXggK1r/kRHVEAyc7lKmbaWWtQ+iClRIFvm1dVlsJ3
X-Gm-Message-State: AOJu0Yzs2kU1N6JKdb+R5YXIszKcxEgV6yDNIdWMHiMp07MhCz+8BVW6
	1lJ71O7E3eexcmqsBo8/h+SWPwSPCE6h5q3TiAuBJt1/YLHZH0uSSOdZFyuySh0=
X-Google-Smtp-Source: AGHT+IGi8PJJ3d9mjlRW2QnLvDkHwpMO55X1puE02BIM4yVgk/Fr9cUW3IRrrGdJkbM5sn/jVNcM0w==
X-Received: by 2002:a05:6808:208c:b0:3c3:a294:5bc9 with SMTP id s12-20020a056808208c00b003c3a2945bc9mr3777594oiw.9.1711747072549;
        Fri, 29 Mar 2024 14:17:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id hb12-20020a05622a2b4c00b00431604af3c1sm1982361qtb.20.2024.03.29.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:17:51 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:17:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Srividya Desireddy <srividya.desireddy@gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
Message-ID: <20240329211723.GA882964@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com>
 <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com>
 <20240328210709.GH7597@cmpxchg.org>
 <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
 <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
 <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com>
 <20240329173759.GI7597@cmpxchg.org>
 <CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com>

On Fri, Mar 29, 2024 at 11:56:46AM -0700, Yosry Ahmed wrote:
> > I perf'd zswapping out data that is 10% same-filled and 90% data that
> > always needs compression. It does nothing but madvise(MADV_PAGEOUT),
> > and the zswap_store() stack is already only ~60% of the cycles.
> >
> > Using zsmalloc + zstd, this is the diff between vanilla and my patch:
> >
> > # Baseline  Delta Abs  Shared Object         Symbol
> > # ........  .........  ....................  .....................................................
> > #
> >      4.34%     -3.02%  [kernel.kallsyms]     [k] zswap_store
> >     11.07%     +1.41%  [kernel.kallsyms]     [k] ZSTD_compressBlock_doubleFast
> >     15.55%     +0.91%  [kernel.kallsyms]     [k] FSE_buildCTable_wksp
> >
> > As expected, we have to compress a bit more; on the other hand we're
> > removing the content scan for same-filled for 90% of the pages that
> > don't benefit from it. They almost amortize each other. Let's round it
> > up and the remaining difference is ~1%.
> 
> Thanks for the data, this is very useful.
> 
> There is also the load path. The original patch that introduced
> same-filled pages reports more gains on the load side, which also
> happens to be more latency-sensitive. Of course, the data could be
> outdated -- but it's a different type of workload than what will be
> running in a data center fleet AFAICT.
> 
> Is there also no noticeable difference on the load side in your data?

     9.40%     +2.51%  [kernel.kallsyms]  [k] ZSTD_safecopy
     0.76%     -0.48%  [kernel.kallsyms]  [k] zswap_load

About 2% net.

Checking other compression algorithms, lzo eats 27.58%, and lz4
13.82%. The variance between these alone makes our "try to be smarter
than an actual compression algorithm" code look even sillier.

> Also, how much increase did you observe in the size of compressed data
> with your patch? Just curious about how zstd ended up handling those
> pages.

Checking zsmalloc stats, it did pack the same-filled ones down into 32
byte objects. So 0.7% of their original size. That's negligible, even
for workloads that have an unusually high share of them.

> > It's difficult to make the case that this matters to any real
> > workloads with actual think time in between paging.
> 
> If the difference in performance is 1%, I surely agree.
> 
> The patch reported 19-32% improvement in store time for same-filled
> pages depending on the workload and platform. For 10% same-filled
> pages, this should roughly correspond to 2-3% overall improvement,
> which is not too far from the 1% you observed.

Right.

> The patch reported much larger improvement for load times (which
> matters more), 49-85% for same-filled pages. If this corresponds to
> 5-8% overall improvement in zswap load time for a workload with 10%
> same-filled pages, that would be very significant. I don't expect to
> see such improvements tbh, but we should check.

No, I'm seeing around 2% net.

> > But let's say you do make the case that zero-filled pages are worth
> > optimizing for.
> 
> I am not saying they are for sure, but removing the same-filled
> checking didn't seem to improve performance much in my testing, so the
> cost seems to be mostly in maintenance. This makes it seem to me that
> it *could* be a good tradeoff to only handle zero-filled pages. We can
> make them slightly faster and we can trim the complexity -- as shown
> by this patch.

In the original numbers, there was a certain percentage of non-zero
same-filled pages. You still first have to find that number for real
production loads to determine what the tradeoff actually is.

And I disagree that the code is less complex. There are fewer lines to
the memchr_inv() than to the open-coded word-scan, but that scan is
dead simple, self-contained and out of the way.

So call that a wash in terms of maintenance burden, but for a
reduction in functionality and a regression risk (however small).

The next patch to store them as special xarray entries is also a wash
at best. It trades the entry having an implicit subtype for no type at
all. zswap_load_zero_filled() looks like it's the fast path, and
decompression the fallback; the entry destructor is now called
"zswap_tree_free_element" and takes a void pointer. It also re-adds
most of the lines deleted by the zero-only patch.

I think this is actually a bit worse than the status quo.

But my point is, this all seems like a lot of opportunity cost in
terms of engineering time, review bandwidth, regression risk, and
readability, hackability, reliability, predictability of the code -
for gains that are still not shown to actually matter in practice.

https://lore.kernel.org/all/20240328122352.a001a56aed97b01ac5931998@linux-foundation.org/

This needs numbers to show not just that your patches are fine, but
that any version of this optimization actually matters for real
workloads. Without that, my vote would be NAK.

