Return-Path: <linux-kernel+bounces-123816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6220890E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8E11F24AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A44CB36;
	Thu, 28 Mar 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZSpmTHY"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866531CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667968; cv=none; b=SWCj3P1f7PxCA3osveDQYj1JJiCJFBGw64GQvIt4TV8+dpmT+Jxc3r9yBARzj8DBeUWxT6WqRzgZUQ0+7sPKd1DCrsaM80xKZd7q8du1WjDP1xNeDCzR/4f1v2LlXAT+IfTp3QQSxZapGROWv9eTC1Ju4DneD85ouFzlJH7UQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667968; c=relaxed/simple;
	bh=VP6W286q1NN/0DtU5s1MUXxqF5nS+yIHVLDQLXHMLP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhzMCyeHHA9x6lSlM7uOKw1onpktWkKu0AMju8mil0AVXQUZpUICMncCZHvzBGG3LeRZ6/I1c6O7IN7Tixx/y8tl/p13PiaPljei/wO66oGvWXy0kSXShIpvQG7wKRW3lZh4thkSheXMfXzBT55sxbnxhPjgMZ50LfgPzUffLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZSpmTHY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690be110d0dso8733166d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711667965; x=1712272765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIbaw2eMeenxypIQFqFji+0xGTljNvCMCxvoti4qhyA=;
        b=OZSpmTHYzbspO7uIaCQBCNTBfHLcYuy/FjD4eb/GFQBZXPs4CJHYLJfd+Fe94wgbap
         tBGz+5e3oMpXz3VKko7vpTrXvm9CFmFE8zwrTlD9xp9EgCAZN1a1m+kVDKvQ3Np81tSX
         00aJCPFJ2BU0E6WqpV5JUQtegnqhFuauVV2ajhLMq23V1+2SH0WNwsy3UKCI3IBnczZ1
         TZvq7bjyeRoHgb3vjjmnZQapYgAtYPKqvL7nGXdh6j8sNypteoDiVkYg2M08Xy6KhdjZ
         ipkxIIQrht19ZYsnA91YfexuU2qDBXCEtvgkPd7D10g2tAEyUpKJkLQDTERZTvMO0XmD
         eBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667965; x=1712272765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIbaw2eMeenxypIQFqFji+0xGTljNvCMCxvoti4qhyA=;
        b=Q0Z/Wjg0LFdOS21WC0Fpicv0T4bIvWQQ490cY+lsvBIAITm20qmZ+8PoGWW5/hLJyz
         w6HovgIcv44Q7+DWz0KkAjqJFykM3sCXfGADHsrY5vGTmPk8mnZ4xtt+m1kbAT2dYTSG
         PeYtHARToeSwdnDt2IGni3WT8jduXPSBxHI+X248wzXL7mZCsA9ZuZMa6RMbZrwBNIFE
         +qFzbKmn/5tCm3EvdMrHLPADpHnrdh/svDgSuPBhfL7H/ksKwh5nA/u0HQOvzoF/zaSo
         h10/sIWoZezY/Sp1IszHe35AkN1QSAFZpxtCdUX/c4YOEtCZKbkPQ33wvZBHRCfHG8t7
         YVPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTT5ooJEZMKk518M0KehHbYlp7R5W0hcEm6LykUZ+c32TVU/HcTzG6WjHpZ5ydAsr3p7VebZ9dB7hZn1wPAKBiIdtUUwgwNHFRiWaW
X-Gm-Message-State: AOJu0YzfDPZJ8yGFMR4PYHW/YjGdkhaOzyUGDRXGxkIrWe7eqEo+WA+2
	SmttJyfGtr9uxTntuG6MyHeG7hZTxs8TdGRsZehNcmNfiSCVtBGtgeVRLsfjQH0UUtu9XUBfX50
	QZJSd1LErMwk+U0nFqM9MJ6+DRcEQOg2KnNH6uw==
X-Google-Smtp-Source: AGHT+IFgN+DW8j78guKJpsV7F2scc+l42v5DbNe6u5YAh5XqcRs3LJxE9Z1ZoI0poPiXHYUHsFnTYWHLlbPB/vPFZAc=
X-Received: by 2002:a0c:f549:0:b0:698:e89b:6982 with SMTP id
 p9-20020a0cf549000000b00698e89b6982mr681948qvm.28.1711667965306; Thu, 28 Mar
 2024 16:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <20240328193149.GF7597@cmpxchg.org>
 <CAJD7tkaFmbnt4YNWvgGZHo=-JRu-AsUWvCYCRXVZxOPvcSJRDw@mail.gmail.com> <20240328210709.GH7597@cmpxchg.org>
In-Reply-To: <20240328210709.GH7597@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 Mar 2024 16:19:14 -0700
Message-ID: <CAKEwX=OPDLxH-0-3F+xOc2SL5Ouj-R-HEC5QQrW+Q9Fn8pyeRg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 28, 2024 at 01:23:42PM -0700, Yosry Ahmed wrote:
> > On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > > The current same-filled pages handling supports pages filled with a=
ny
> > > > repeated word-sized pattern. However, in practice, most of these sh=
ould
> > > > be zero pages anyway. Other patterns should be nearly as common.
> > > >
> > > > Drop the support for non-zero same-filled pages, but keep the names=
 of
> > > > knobs exposed to userspace as "same_filled", which isn't entirely
> > > > inaccurate.
> > > >
> > > > This yields some nice code simplification and enables a following p=
atch
> > > > that eliminates the need to allocate struct zswap_entry for those p=
ages
> > > > completely.
> > > >
> > > > There is also a very small performance improvement observed over 50=
 runs
> > > > of kernel build test (kernbench) comparing the mean build time on a
> > > > skylake machine when building the kernel in a cgroup v1 container w=
ith a
> > > > 3G limit:
> > > >
> > > >               base            patched         % diff
> > > > real          70.167          69.915          -0.359%
> > > > user          2953.068        2956.147        +0.104%
> > > > sys           2612.811        2594.718        -0.692%
> > > >
> > > > This probably comes from more optimized operations like memchr_inv(=
) and
> > > > clear_highpage(). Note that the percentage of zero-filled pages dur=
ing
> > > > this test was only around 1.5% on average, and was not affected by =
this
> > > > patch. Practical workloads could have a larger proportion of such p=
ages
> > > > (e.g. Johannes observed around 10% [1]), so the performance improve=
ment
> > > > should be larger.
> > > >
> > > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg=
org/
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > This is an interesting direction to pursue, but I actually thinkg it
> > > doesn't go far enough. Either way, I think it needs more data.
> > >
> > > 1) How frequent are non-zero-same-filled pages? Difficult to
> > >    generalize, but if you could gather some from your fleet, that
> > >    would be useful. If you can devise a portable strategy, I'd also b=
e
> > >    more than happy to gather this on ours (although I think you have
> > >    more widespread zswap use, whereas we have more disk swap.)
> >
> > I am trying to collect the data, but there are.. hurdles. It would
> > take some time, so I was hoping the data could be collected elsewhere
> > if possible.
> >
> > The idea I had was to hook a BPF program to the entry of
> > zswap_fill_page() and create a histogram of the "value" argument. We
> > would get more coverage by hooking it to the return of
> > zswap_is_page_same_filled() and only updating the histogram if the
> > return value is true, as it includes pages in zswap that haven't been
> > swapped in.
> >
> > However, with zswap_is_page_same_filled() the BPF program will run in
> > all zswap stores, whereas for zswap_fill_page() it will only run when
> > needed. Not sure if this makes a practical difference tbh.
> >
> > >
> > > 2) The fact that we're doing any of this pattern analysis in zswap at
> > >    all strikes me as a bit misguided. Being efficient about repetitiv=
e
> > >    patterns is squarely in the domain of a compression algorithm. Do
> > >    we not trust e.g. zstd to handle this properly?
> >
> > I thought about this briefly, but I didn't follow through. I could try
> > to collect some data by swapping out different patterns and observing
> > how different compression algorithms react. That would be interesting
> > for sure.
> >
> > >
> > >    I'm guessing this goes back to inefficient packing from something
> > >    like zbud, which would waste half a page on one repeating byte.
> > >
> > >    But zsmalloc can do 32 byte objects. It's also a batching slab
> > >    allocator, where storing a series of small, same-sized objects is
> > >    quite fast.
> > >
> > >    Add to that the additional branches, the additional kmap, the extr=
a
> > >    scanning of every single page for patterns - all in the fast path
> > >    of zswap, when we already know that the vast majority of incoming
> > >    pages will need to be properly compressed anyway.
> > >
> > >    Maybe it's time to get rid of the special handling entirely?
> >
> > We would still be wasting some memory (~96 bytes between zswap_entry
> > and zsmalloc object), and wasting cycling allocating them. This could
> > be made up for by cycles saved by removing the handling. We will be
> > saving some branches for sure. I am not worried about kmap as I think
> > it's a noop in most cases.
>
> Yes, true.
>
> > I am interested to see how much we could save by removing scanning for
> > patterns. We may not save much if we abort after reading a few words
> > in most cases, but I guess we could also be scanning a considerable
> > amount before aborting. On the other hand, we would be reading the
> > page contents into cache anyway for compression, so maybe it doesn't
> > really matter?
> >
> > I will try to collect some data about this. I will start by trying to
> > find out how the compression algorithms handle same-filled pages. If
> > they can compress it efficiently, then I will try to get more data on
> > the tradeoff from removing the handling.
>
> I do wonder if this could be overthinking it, too.
>
> Double checking the numbers on our fleet, a 96 additional bytes for
> each same-filled entry would result in a
>
> 1) p50 waste of 0.008% of total memory, and a
>
> 2) p99 waste of 0.06% of total memory.
>
> And this is without us having even thought about trying to make
> zsmalloc more efficient for this particular usecase - which might be
> the better point of attack, if we think it's actually worth it.
>
> So my take is that unless removing it would be outright horrible from
> a %sys POV (which seems pretty unlikely), IMO it would be fine to just
> delete it entirely with a "not worth the maintenance cost" argument.
>
> If you turn the argument around, and somebody would submit the code as
> it is today, with the numbers being what they are above, I'm not sure
> we would even accept it!

The context guy is here :)

Not arguing for one way or another, but I did find the original patch
that introduced same filled page handling:

https://github.com/torvalds/linux/commit/a85f878b443f8d2b91ba76f09da21ac0af=
22e07f

https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344d=
de9fce0@epcms5p1/T/#u

The number looks impressive, and there is some detail about the
experiment setup, but I can't seem to find what the allocator +
compressor used.

Which, as Johannes has pointed out, matters a lot. A good compressor
(which should work on arguably the most trivial data pattern there is)
+ a backend allocator that is capable of handling small objects well
could make this case really efficient, without resorting to special
handling at the zswap level.

