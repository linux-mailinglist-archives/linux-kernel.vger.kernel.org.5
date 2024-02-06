Return-Path: <linux-kernel+bounces-54242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD084ACC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223A81C22C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098973196;
	Tue,  6 Feb 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK1Xig5O"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97233CC8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189203; cv=none; b=maYjEA64crz+XzFLrWHmOzBSZ3YAJ0Dqm74gGdS2VplRSd1gykFQ7q7lP24NCQ9x6yU4yZGljIIqGQPub2hllDgRNaXtXrDSzOSo6CzqG8XcUBpsjOEnVgQCu792bKKmzXEZn3ZF40N1KOD28tkVG9oPPAIhfXGqOa417wdv3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189203; c=relaxed/simple;
	bh=Wi6FX0RldvPV3w1VEeuYS/+ytY/jHtcKSnNphtqVodY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkkvY+5m52P8R2xvmDTrfxwAtmn+dyvb3JUQ+d3J5dcg0NkiI06XZwukqvuksu7ZtcyFD2KgglHV5hhJ5IWjaUw0Eg+lK2Nor82RpcZndkaA8qSo5jBRj7McjRA4egOVHweUOHw+l02M/H/IVchNPy7i/yAsVlTbNztqqPMVNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK1Xig5O; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0a6b9c9bcso24899091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707189200; x=1707794000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l3WILuSJF+kJd5Jl6uK0KvdfHoanQQl0YMdjWYvA3Q=;
        b=dK1Xig5OSj/xzMIGJiJ6vYrE6TGhGkykcYOsxl2dM54XsKI9ky3sMKrkTHCokXEGpR
         IGJ1T276QKzcBkSXJyAME/IqASzeIufh15fX6vRXgP5553izUqKf4JsVdvJGUzB5YNrF
         RFsewrCQibigEL8+6Mlz1TKapHxNHyaSMS3j4BQ6YmZoBsfTnhgcgmrf8117pmpKMfWR
         cObwmsgihl25KAzqST1qgP5KWCi36DuGKlLTexxmuAfWlqmV623ZPJ0YlIH8C4abxJtC
         WufQrzeaK+kDdMvQtd37zIUWcpSS8XCizkFlycDUc5aEDQcDRtbkGCI98nbj2n7x3Ier
         WAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189200; x=1707794000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9l3WILuSJF+kJd5Jl6uK0KvdfHoanQQl0YMdjWYvA3Q=;
        b=DZHq46CDYnndAZz/4+WqkpTO5ZcxWjAdJ4uSe3C2lQOamANUV41JuGZ/nIBGrJeqxB
         h3t6hL/pDUgyd9QOtpwO02OoOihLIgzR8W0qP6MYp2qwQyV3W0Zx5urDTDuo6fye/V2Y
         RjJ/t0M0bB1sHLTDhuVLLkpvgDXTrAeNi23+RRXMVEgSWdHQsCh4nU4flAmRqA53XDnk
         iRHfLImEwY+NpL+I69LvdctGmqZsvzOB1HZ3AwRruttV2J06FfLOUZn9NzZAJS1HlKLC
         pZhjbIMsLEitwmH/BFmEA8MsMLMeBTKxEgOU4COIjovC6hasLAoUA4G20daoX/Zp2oCc
         g2Qg==
X-Gm-Message-State: AOJu0Yx+rH1/LPF6RtFZLMwhSi5Ry35zRbFgmNZ+A0O8XFZslmlOD3AC
	3rHPutpGBStDWk+HGAZIwttQGjnJ32Wi8uc6NNR2F29LZjTHwjWoMCFdbLwiEelUyg4DsTe4au/
	lkuqI1nw8EiJYepynkh+63T5vvs8=
X-Google-Smtp-Source: AGHT+IFXrFG3gxFs8nDXLUDqJVYhGqZbNFITuS6VFDwPvh2dDqi780UaHVK7V+QezRy+0lfQ2CkTE4z41PWXVXCXD3c=
X-Received: by 2002:a05:651c:1059:b0:2d0:b2ce:3956 with SMTP id
 x25-20020a05651c105900b002d0b2ce3956mr930605ljm.32.1707189199603; Mon, 05 Feb
 2024 19:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com> <20240206022409.202536-1-sj@kernel.org>
In-Reply-To: <20240206022409.202536-1-sj@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 6 Feb 2024 11:13:01 +0800
Message-ID: <CAMgjq7BAOohAYpS3n3NFHcji-=oiydJJSO5oqerLqYJSVfCQ9w@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:24=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Kairui,
>
> On Mon,  5 Feb 2024 19:09:59 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> [...]
> >  mm/memory.c   | 19 +++++++++++++++++++
> >  mm/swap.h     |  5 +++++
> >  mm/swapfile.c | 16 ++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7e1f4849463a..fd7c55a292f1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > +                     /*
> > +                      * With swap count =3D=3D 1, after we read the en=
try,
> > +                      * other threads could finish swapin first, free
> > +                      * the entry, then swapout the modified page usin=
g
> > +                      * the same entry. Now the content we just read i=
s
> > +                      * stalled, and it's undetectable as pte_same()
> > +                      * returns true due to entry reuse.
> > +                      *
> > +                      * So pin the swap entry using the cache flag eve=
n
> > +                      * cache is not used.
> > +                      */
> > +                     if (swapcache_prepare(entry))
> > +                             goto out;
> > +
>
> I'm getting below build error after this patch.  I guess maybe the code n=
eed to
> take care of CONFIG_SWAP unset case?
>
>     .../mm/memory.c: In function 'do_swap_page':
>     .../mm/memory.c:4004:8: error: implicit declaration of function 'swap=
cache_prepare'; did you mean 'swapcache_clear'? [-Werror=3Dimplicit-functio=
n-declaration]
>      4004 |    if (swapcache_prepare(entry))
>           |        ^~~~~~~~~~~~~~~~~
>           |        swapcache_clear
>
>

Ah, right. Thanks for the feedback.

For the CONFIG_SWAP unset case I added an empty function for
swapcache_clear, but the original swapcache_prepare also needs an
empty placeholder now. Will add that in V2.

