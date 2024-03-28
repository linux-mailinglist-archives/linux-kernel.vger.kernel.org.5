Return-Path: <linux-kernel+bounces-123583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978F890B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3BDB208FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE164645B;
	Thu, 28 Mar 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zbu9ctp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA62EAE9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657816; cv=none; b=iso6D2mtiRd2RbeRP457dFU8lJVPATNj23Iyzpg9EsHMrFbUlNAYa6JQlOhGVOcvX8kwXd1a/NsAmxvv+waFbZBc1w2xGN23XL8Dmkww14oh6fzmPkp9Oy+t+1+zLq4MbmzmaJnHmUNGsofiluqrwH5PfCgCg884Bp1Yg+sQPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657816; c=relaxed/simple;
	bh=nIh7elDIyrZjmFM7UiM8LPKOv43kC25hurdSiLWjFt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puQbiibTElQBex3mX8nZ+0N82f/9orEkz7a2AdlHbNOwTJz8JNDuAf+msJxZW44/iX/AZCTk9AocsaDi8GanY7ACk+OCEpXKOKGOMkqDQIn56UC3CvZqejSck6G7Eo88Rxb3YsWpF1HM9FmYxz4dRzxdE4Kauu0/LqV76+bghuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zbu9ctp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515a97846b5so1455354e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711657812; x=1712262612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjVUquLiWCNblxyiLjuM34vhuxWsmaQ8B9F++hiYL2w=;
        b=0zbu9ctpX42WhNJx1hbCGJeTxpRenWOa684Vyap32aHT2NMPCF60PuaD1Sjr3KkOcQ
         29MNpfoDY7Pfmo2tRqvg/nDrkasY7aNqyVuOP8G6UWBWleHwNd2Tb9f6yiRvMz6XFlBy
         kd1+62G3zBwzCjK/wRAj9xVJzG0dJjtFa0DOH2OAALZzYtkQDPLq2NDwBfvgewj2rEPM
         ypWsJ6P53g8oGIqmg47z3m5BDEBd1XA6dCyEsy0U0IfEbL9nBnFpnO5TWVN3kHFka/Sj
         bTQYARSV6Yemjk0h+gqyV8S5e6ilYUYbUz9PScFXhiDNUxutzwr+0o2rp15SfRni62bn
         FaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657812; x=1712262612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjVUquLiWCNblxyiLjuM34vhuxWsmaQ8B9F++hiYL2w=;
        b=N4U/Qhs86v+MRzinrMQ9Nm0z5eL7RqPtXBLHXbhtiYlXMRYdW7nZ+qcA3UXNGXO7pY
         xszKsbQVt21zhN3a4/YtkMzAXfVebaO2uM91JfLkmyNBGgkdEZQDJUKuWzg4eXCrjvHe
         JNJCP/nrcxuKsudLXdBAtD/pWA9yu8yb0mn5lDCytKv4ZUG7n7gEPm+Bue9E1JykzUy3
         AaTMNOkUJ1LQ1Oy9DO2aoG6Q/9gKYB2f2k3xWnsEVF3ycCZgYVursWJS7Nme3NL+k4lq
         jaFK01BklLBPjFVTe0vMtzCPeP+8oJQg17ZkybGN0JPnEt1K77YoUClX5OuToDuieqib
         Tokw==
X-Forwarded-Encrypted: i=1; AJvYcCVdX1QINPmuZf9HgPTpWZAMahJUSRAJY02L8jCMw+pQhqW2hboYJ8YIaFrImoYnzq7BR0LzdSrAkvIft/tm9MRHETWHYh+WYvsvNC/4
X-Gm-Message-State: AOJu0YyDzXM0MQ0bQwJXVEadXAQYJg0hoEZFRW/Hg+T5p/8KvSqXj6ry
	ibVstThEIZEoLaFAxkv2iw6fmQ7qdr0hpZnNfJPBsoGi2fZaIooHztcnp/EidUVpahAwV3wDjbj
	JDcKmbAzM3ynGrsQHzMeiQxPAl3B4R2BBntwz
X-Google-Smtp-Source: AGHT+IGNIY/c+G0dyBw5Hjzrx64iJgli4YK+uTJUhwFFODz261SDdi7HPJ2bpQgOg6gJW+JzOAnMdEbX0cJtre++h0U=
X-Received: by 2002:a05:6512:10cd:b0:515:abc7:8b0c with SMTP id
 k13-20020a05651210cd00b00515abc78b0cmr369366lfg.25.1711657812050; Thu, 28 Mar
 2024 13:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-8-yosryahmed@google.com> <20240328193853.GG7597@cmpxchg.org>
In-Reply-To: <20240328193853.GG7597@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Mar 2024 13:29:35 -0700
Message-ID: <CAJD7tkbFK2DJ0e7zCeYzwQKGC6-Pa111rHV0HMQeDBho1dVWQg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] mm: zswap: store zero-filled pages without a zswap_entry
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:38=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Mar 25, 2024 at 11:50:15PM +0000, Yosry Ahmed wrote:
> > After the rbtree to xarray conversion, and dropping zswap_entry.refcoun=
t
> > and zswap_entry.value, the only members of zswap_entry utilized by
> > zero-filled pages are zswap_entry.length (always 0) and
> > zswap_entry.objcg. Store the objcg pointer directly in the xarray as a
> > tagged pointer and avoid allocating a zswap_entry completely for
> > zero-filled pages.
> >
> > This simplifies the code as we no longer need to special case
> > zero-length cases. We are also able to further separate the zero-filled
> > pages handling logic and completely isolate them within store/load
> > helpers.  Handling tagged xarray pointers is handled in these two
> > helpers, as well as the newly introduced helper for freeing tree
> > elements, zswap_tree_free_element().
> >
> > There is also a small performance improvement observed over 50 runs of
> > kernel build test (kernbench) comparing the mean build time on a skylak=
e
> > machine when building the kernel in a cgroup v1 container with a 3G
> > limit. This is on top of the improvement from dropping support for
> > non-zero same-filled pages:
> >
> >               base            patched         % diff
> > real            69.915          69.757                -0.229%
> > user            2956.147        2955.244      -0.031%
> > sys             2594.718        2575.747      -0.731%
> >
> > This probably comes from avoiding the zswap_entry allocation and
> > cleanup/freeing for zero-filled pages. Note that the percentage of
> > zero-filled pages during this test was only around 1.5% on average.
> > Practical workloads could have a larger proportion of such pages (e.g.
> > Johannes observed around 10% [1]), so the performance improvement shoul=
d
> > be larger.
> >
> > This change also saves a small amount of memory due to less allocated
> > zswap_entry's. In the kernel build test above, we save around 2M of
> > slab usage when we swap out 3G to zswap.
> >
> > [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org=
/
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 137 ++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 78 insertions(+), 59 deletions(-)
>
> Tbh, I think this makes the code worse overall. Instead of increasing
> type safety, it actually reduces it, and places that previously dealt
> with a struct zswap_entry now deal with a void *.
>
> If we go ahead with this series, I think it makes more sense to either
>
> a) do the explicit subtyping of struct zswap_entry I had proposed, or

I suspect we won't get the small performance improvements (and memory
saving) with this approach. Neither are too significant, but it'd be
nice if we could keep them.

>
> b) at least keep the specialness handling of the xarray entry as local
>    as possible, so that instead of a proliferating API that operates
>    on void *, you have explicit filtering only where the tree is
>    accessed, and then work on struct zswap_entry as much as possible.

I was trying to go for option (b) by isolating filtering and casting
to the correct type in a few functions (zswap_tree_free_element(),
zswap_store_zero_filled(), and zswap_load_zero_filled()). If we
open-code filtering it will be repeated in a few places.

What did you have in mind?

