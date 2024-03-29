Return-Path: <linux-kernel+bounces-124112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FC891264
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC2B229A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973F3A8C0;
	Fri, 29 Mar 2024 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="2oM+oqxc"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93573A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711686478; cv=none; b=YHUuPwaz/Q4LTGnRZKu5E/avwwCxqHwqeSjmtUKVkhmsDmQ3xnucUMaM5mUWkTi9TNEyYN5lMflFmvctq2kWCsfXGqcs97EVeD2AY21zVH21wE/35UKx8xATVr525tGcsgUnLD1FCE8ezTB+MYtF4N9w2J5fGYDdwWE71dhxNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711686478; c=relaxed/simple;
	bh=sBlzYKxX2N1Rzd9itK6T89IXsUbte6bJpJvkf/pAeQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwSwaRiI9lhipYPeE7QC+JMgQd4WxMMjZbImYSWxsQ+Vnf4Zri24S940AJYNXr5OCb5NHoimvN95iNNqlQutp4w5Re238gvCs1JzELbr8G8HemTDPcXOWSdGGTIWOERGYA7aYo+eGNcyPU2NxK3E8344jVyg0Z+7QnBQ2x+2yaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oM+oqxc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so13443481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711686475; x=1712291275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/vAyJ4a5RQBFlL1Mz9qHhkQoRCF3uS+NkBJETvCGyY=;
        b=2oM+oqxcP5VSVTPmLeH1UXVQ4XyYHghMk8RO3vjYHovTQrT2L15I+iH2kv+CNX1lvU
         +SFOoomxpeseTQ0Laui86HDQYeHMDoo012NbT8mSKMAMF7bLHoScLq/83IZo9Juu/ovO
         2ASIrcts2o5flD+ar3Jo+YjmvQLwV3SZs4Nr2NAkO8GX5iTE7KKwrqeLiDAOEUxPWd7a
         XjP0NmyhNsTne7RoP0EJziVnbAnmK3eZQjrm8J8wgy6ub5oJHM+qXBBQoPpS8qlbOZ0O
         Fl64sHA8eu+W/b9qg7iqsPy146ZKRVOO8E9PcORctMqkIYGqfOtbi416u8tKr7H/EOj6
         HErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711686475; x=1712291275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/vAyJ4a5RQBFlL1Mz9qHhkQoRCF3uS+NkBJETvCGyY=;
        b=dE0SrEKPQFFaL74Y8ecvnCZS0z2N6wKi9S80+yyj+SLfJXd10Qj7hPrVtiCTiCRzBU
         ffZNRrZvd+qiL4oKQsLqzORe7ns/VnVyJNn9DaSY3cJyw3UQ9b3v+IaWAvk+VVkckyza
         sSIHArpeejMBUpddlSRlKTKjph6kSSyeoa2iNAlXmmN3IP+8Pa/zFQd1U/mFqJG1plN7
         rzVB7zDXVPjhl/WFkTmB7NvkslAtUHdA5vGN7wN37cFyi+0rv0vJaa4iEzL5ujQQVwAp
         Asb7Ryh/nucVs087r9AfA3FrEStyyQo9sujanrZKUQdnW6DrUZRTRjwAr1LnkqV8KHaX
         mtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUahXhb7z8tbhltaW3ETnrEqxp5NPYsr7VzcFm7/lZ8jOjyZm3ItmBFLxI6v4klR21FudViUi+oK1H5V1mKypMV7IuDkdNozd0MIhf
X-Gm-Message-State: AOJu0YwNX2L8JF7Klj0BByPFBus8u6hWLDetGMndh0eqLIHxtzq+3ycD
	7Vk7fUQlfMvCs7++5ciD+3EzZrsS6K+piYWfr/6ySNIxiFdx6zzpaQGIu7007IlYOsmgnLCP5FM
	rjRckHEVbMeyV0j7rSoFTDKeB+32xdThfh5+S
X-Google-Smtp-Source: AGHT+IGJk5o1bduZOx1XkmIoLSUMm6ZQnfDKEkl2dt0ysbqUb2ufvf4hhNYO99cHR06Sr1kn5VgzlsS+iCHEX9AHYZA=
X-Received: by 2002:a05:6512:48c6:b0:515:cedb:a518 with SMTP id
 er6-20020a05651248c600b00515cedba518mr526032lfb.16.1711686474537; Thu, 28 Mar
 2024 21:27:54 -0700 (PDT)
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
In-Reply-To: <CAJD7tkaGBofWm1eGBffEtpuKUDBVB_6RfHbYKQSKOX3fKn2jeg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 21:27:17 -0700
Message-ID: <CAJD7tkbKY0T6jd5v_GhNFyCO0578SNqfMgs1ZrZiCckY05hzZA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Mar 28, 2024 at 4:19=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Thu, Mar 28, 2024 at 2:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Thu, Mar 28, 2024 at 01:23:42PM -0700, Yosry Ahmed wrote:
> > > > On Thu, Mar 28, 2024 at 12:31=E2=80=AFPM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > >
> > > > > On Mon, Mar 25, 2024 at 11:50:14PM +0000, Yosry Ahmed wrote:
> > > > > > The current same-filled pages handling supports pages filled wi=
th any
> > > > > > repeated word-sized pattern. However, in practice, most of thes=
e should
> > > > > > be zero pages anyway. Other patterns should be nearly as common=
.
> > > > > >
> > > > > > Drop the support for non-zero same-filled pages, but keep the n=
ames of
> > > > > > knobs exposed to userspace as "same_filled", which isn't entire=
ly
> > > > > > inaccurate.
> > > > > >
> > > > > > This yields some nice code simplification and enables a followi=
ng patch
> > > > > > that eliminates the need to allocate struct zswap_entry for tho=
se pages
> > > > > > completely.
> > > > > >
> > > > > > There is also a very small performance improvement observed ove=
r 50 runs
> > > > > > of kernel build test (kernbench) comparing the mean build time =
on a
> > > > > > skylake machine when building the kernel in a cgroup v1 contain=
er with a
> > > > > > 3G limit:
> > > > > >
> > > > > >               base            patched         % diff
> > > > > > real          70.167          69.915          -0.359%
> > > > > > user          2953.068        2956.147        +0.104%
> > > > > > sys           2612.811        2594.718        -0.692%
> > > > > >
> > > > > > This probably comes from more optimized operations like memchr_=
inv() and
> > > > > > clear_highpage(). Note that the percentage of zero-filled pages=
 during
> > > > > > this test was only around 1.5% on average, and was not affected=
 by this
> > > > > > patch. Practical workloads could have a larger proportion of su=
ch pages
> > > > > > (e.g. Johannes observed around 10% [1]), so the performance imp=
rovement
> > > > > > should be larger.
> > > > > >
> > > > > > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmp=
xchg.org/
> > > > > >
> > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > >
> > > > > This is an interesting direction to pursue, but I actually thinkg=
 it
> > > > > doesn't go far enough. Either way, I think it needs more data.
> > > > >
> > > > > 1) How frequent are non-zero-same-filled pages? Difficult to
> > > > >    generalize, but if you could gather some from your fleet, that
> > > > >    would be useful. If you can devise a portable strategy, I'd al=
so be
> > > > >    more than happy to gather this on ours (although I think you h=
ave
> > > > >    more widespread zswap use, whereas we have more disk swap.)
> > > >
> > > > I am trying to collect the data, but there are.. hurdles. It would
> > > > take some time, so I was hoping the data could be collected elsewhe=
re
> > > > if possible.
> > > >
> > > > The idea I had was to hook a BPF program to the entry of
> > > > zswap_fill_page() and create a histogram of the "value" argument. W=
e
> > > > would get more coverage by hooking it to the return of
> > > > zswap_is_page_same_filled() and only updating the histogram if the
> > > > return value is true, as it includes pages in zswap that haven't be=
en
> > > > swapped in.
> > > >
> > > > However, with zswap_is_page_same_filled() the BPF program will run =
in
> > > > all zswap stores, whereas for zswap_fill_page() it will only run wh=
en
> > > > needed. Not sure if this makes a practical difference tbh.
> > > >
> > > > >
> > > > > 2) The fact that we're doing any of this pattern analysis in zswa=
p at
> > > > >    all strikes me as a bit misguided. Being efficient about repet=
itive
> > > > >    patterns is squarely in the domain of a compression algorithm.=
 Do
> > > > >    we not trust e.g. zstd to handle this properly?
> > > >
> > > > I thought about this briefly, but I didn't follow through. I could =
try
> > > > to collect some data by swapping out different patterns and observi=
ng
> > > > how different compression algorithms react. That would be interesti=
ng
> > > > for sure.
> > > >
> > > > >
> > > > >    I'm guessing this goes back to inefficient packing from someth=
ing
> > > > >    like zbud, which would waste half a page on one repeating byte=
.
> > > > >
> > > > >    But zsmalloc can do 32 byte objects. It's also a batching slab
> > > > >    allocator, where storing a series of small, same-sized objects=
 is
> > > > >    quite fast.
> > > > >
> > > > >    Add to that the additional branches, the additional kmap, the =
extra
> > > > >    scanning of every single page for patterns - all in the fast p=
ath
> > > > >    of zswap, when we already know that the vast majority of incom=
ing
> > > > >    pages will need to be properly compressed anyway.
> > > > >
> > > > >    Maybe it's time to get rid of the special handling entirely?
> > > >
> > > > We would still be wasting some memory (~96 bytes between zswap_entr=
y
> > > > and zsmalloc object), and wasting cycling allocating them. This cou=
ld
> > > > be made up for by cycles saved by removing the handling. We will be
> > > > saving some branches for sure. I am not worried about kmap as I thi=
nk
> > > > it's a noop in most cases.
> > >
> > > Yes, true.
> > >
> > > > I am interested to see how much we could save by removing scanning =
for
> > > > patterns. We may not save much if we abort after reading a few word=
s
> > > > in most cases, but I guess we could also be scanning a considerable
> > > > amount before aborting. On the other hand, we would be reading the
> > > > page contents into cache anyway for compression, so maybe it doesn'=
t
> > > > really matter?
> > > >
> > > > I will try to collect some data about this. I will start by trying =
to
> > > > find out how the compression algorithms handle same-filled pages. I=
f
> > > > they can compress it efficiently, then I will try to get more data =
on
> > > > the tradeoff from removing the handling.
> > >
> > > I do wonder if this could be overthinking it, too.
> > >
> > > Double checking the numbers on our fleet, a 96 additional bytes for
> > > each same-filled entry would result in a
> > >
> > > 1) p50 waste of 0.008% of total memory, and a
> > >
> > > 2) p99 waste of 0.06% of total memory.
>
> Right. Assuming the compressors do not surprise us and store
> same-filled pages in an absurd way, it's not worth it in terms of
> memory savings.
>
> > >
> > > And this is without us having even thought about trying to make
> > > zsmalloc more efficient for this particular usecase - which might be
> > > the better point of attack, if we think it's actually worth it.
> > >
> > > So my take is that unless removing it would be outright horrible from
> > > a %sys POV (which seems pretty unlikely), IMO it would be fine to jus=
t
> > > delete it entirely with a "not worth the maintenance cost" argument.
> > >
> > > If you turn the argument around, and somebody would submit the code a=
s
> > > it is today, with the numbers being what they are above, I'm not sure
> > > we would even accept it!
> >
> > The context guy is here :)
> >
> > Not arguing for one way or another, but I did find the original patch
> > that introduced same filled page handling:
> >
> > https://github.com/torvalds/linux/commit/a85f878b443f8d2b91ba76f09da21a=
c0af22e07f
> >
> > https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1=
344dde9fce0@epcms5p1/T/#u
>
> Thanks for digging this up. I don't know why I didn't start there :)
>
> Following in your footsteps, and given that zram has the same feature,
> I found the patch that added support for non-zero same-filled pages in
> zram:
> https://lore.kernel.org/all/1483692145-75357-1-git-send-email-zhouxianron=
g@huawei.com/#t
>
> Both of them confirm that most same-filled pages are zero pages, but
> they show a more significant portion of same-filled pages being
> non-zero (17% to 40%). I suspect this will be less in data centers
> compared to consumer apps.
>
> The zswap patch also reports significant performance improvements from
> the same-filled handling, but this is with 17-22% same-filled pages.
> Johannes mentioned around 10% in your data centers, so the performance
> improvement would be less. In the kernel build tests I ran with only
> around 1.5% same-filled pages I observed 1.4% improvements just by
> optimizing them (only zero-filled, skipping allocations).
>
> So I think removing the same-filled pages handling completely may be
> too aggressive, because it doesn't only affect the memory efficiency,
> but also cycles spent when handling those pages. Just avoiding going
> through the allocator and compressor has to account for something :)

Here is another data point. I tried removing the same-filled handling
code completely with the diff Johannes sent upthread. I saw 1.3%
improvement in the kernel build test, very similar to the improvement
from this patch series. _However_, the kernel build test only produces
~1.5% zero-filled pages in my runs. More realistic workloads have
significantly higher percentages as demonstrated upthread.

In other words, the kernel build test (at least in my runs) seems to
be the worst case scenario for same-filled/zero-filled pages. Since
the improvement from removing same-filled handling is quite small in
this case, I suspect there will be no improvement, but possibly a
regression, on real workloads.

As the zero-filled pages ratio increases:
- The performance with this series will improve.
- The performance with removing same-filled handling completely will
become worse.

