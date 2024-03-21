Return-Path: <linux-kernel+bounces-110807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D873886429
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB52A2842E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167C288AE;
	Thu, 21 Mar 2024 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/AIWHy2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DD3232
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065487; cv=none; b=ddrJhs36rrTmLeEShBIZydTbNhqFIj2OK3EfeK8r8/Pw5Dr0V1OnmybRgsvJQrUD0sq9olSAUCRfc8RUXjFkU1EtoU0zsIQ2OV/RZdEKnmMEBAEE4jBsgAarEHLbxyRNOrpXrcbm87ehM3sQb9PL9GLmFDFfUoIJipNAetgo/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065487; c=relaxed/simple;
	bh=D3spBzrZCMW5GEaWKfvQ7BuGSOqDGgSKDmzylSP5FUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzVIeLI5zJgRswevPLlyZBlx5qhgmJthffHTzXZ+jcMW7O7nxxYxxRTywt+Kr9BBwXgnbXHp5u3i1SgCbP5TEZUeH1cu27Dn1dtA/GYIRlKT0CKzwISX8d6rpU1ftH3XHIAye+3m2HwPGj9naj0aOe1jwUX3/oVx8r+pSaJBxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/AIWHy2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46cc947929so220711766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711065484; x=1711670284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul906RHRjtTt9ICgM5G5gAfi1fYFVLGfZkDm8s9ACk0=;
        b=E/AIWHy2kUhdi3ylQFwNaEfElX3VmpAR4a9kUwzaxVNiuluLP3TrySnZXHQRISIEkK
         PlrG13hwwupceFSkA1X6DYNxR5Zo648FEXaah+Ogo7MlPyVMsot0bmpv1nBEMxP02tIb
         zsR1P+oCeRQj3ZrxFb4N5FY+c+uTeC1Ogi0mr0BCrYsc0PBGg0tN7oEX6eENMnnZXY3w
         jUV8FQ119UNddvbH8rgla9iUkgZtooxVR1MK9QJMkt1334GQSgR+gyxPfxBlhmEPsjJk
         g7ZODYY7W3OJOG4agd13whrEmq0z4St5mn1E6bQ3xSqjXf9dpGpUxbDcxApwuvhJt8UJ
         SnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065484; x=1711670284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul906RHRjtTt9ICgM5G5gAfi1fYFVLGfZkDm8s9ACk0=;
        b=c0/+UJmL7MJws2JmlXzfCJcHAy5yOTIiwZ8PnmTCdulm+z5z6eFE+J8QQQ2LV4nJyf
         PAVqTFiLpoEgwyKoIfs43W8R7IFNpp8zxT46YjA5UVuOucgOknxE2tRH1bA+aZKIJkxM
         Uf4H/v4bDGMBLU/QENfxoUmFH3QeYUoXQghncbhhpfp/w2fg0fQs9uPBm6kAOGveEXRz
         SIoGh1uxpPNBRKO0r/WF8XBPYCIgezFDtSH7AnidCJRv6ncxiDVBjtmipRSAWG1LJC81
         2cFZD2Syvj6F6aUP2h+a7qjzrmcr0hy6laJN+/Ig7pSJvWKKa3q1BthHJYT1Nux648Bx
         v0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/MUAtWlwWXMWPwtTRSBrARD2KzT42HFbVnhunLiRBnTQjsdGSUWpjRn5imZXzgm+bN/BtfLyDaF9aja5aLr0i2u1VnIHFy/fu1LN
X-Gm-Message-State: AOJu0YwNd8yfH0F8tCKoh5VROSpAGjI3c4C53y+lyxy8pDI6Emf67bCv
	6UpVkHtbYCj4Mc1UnlgjjlZA0c4kxaNk9NrB/zOqxeBUPSPZxgrwiT5+zBVkS5Zlh90tcdb98xT
	tQuiq912Br2EW4DZiiuMm69z4F3eSKVKFzLKjmoLtHESu+cj2IA==
X-Google-Smtp-Source: AGHT+IF5f1CTZlnm2Xl7nXWvcQsW6QwnCYmk7+9IjBQsblTlSyNewbp8mF70Rfoe45h0EzCiIdM8zWpvtSCe0UPev0k=
X-Received: by 2002:a17:906:c349:b0:a47:876:28b9 with SMTP id
 ci9-20020a170906c34900b00a47087628b9mr532234ejb.42.1711065483601; Thu, 21 Mar
 2024 16:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com>
 <20240320020823.337644-2-yosryahmed@google.com> <CAJD7tkYb-=Ho85e2AJbkfe-FmT6KXpJpUgPRaXQb5-+sY5j4Hg@mail.gmail.com>
 <CAKEwX=PjpJCewYEMp+=g+92=R-Wr2y+7pwJ81xb9-pogohFC4w@mail.gmail.com>
In-Reply-To: <CAKEwX=PjpJCewYEMp+=g+92=R-Wr2y+7pwJ81xb9-pogohFC4w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 21 Mar 2024 16:57:27 -0700
Message-ID: <CAJD7tkaC5eTe8Os6f0VsGx9o06YE8zX1r0R0PPMvExRfcGhPgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove nr_zswap_stored atomic
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:50=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Mar 21, 2024 at 2:09=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Mar 19, 2024 at 7:08=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > zswap_nr_stored is used to maintain the number of stored pages in zsw=
ap
> > > that are not same-filled pages. It is used in zswap_shrinker_count() =
to
> > > scale the number of freeable compressed pages by the compression rati=
o.
> > > That is, to reduce the amount of writeback from zswap with higher
> > > compression ratios as the ROI from IO diminishes.
> > >
> > > However, the need for this counter is questionable due to two reasons=
:
> > > - It is redundant. The value can be inferred from (zswap_stored_pages=
 -
> > >   zswap_same_filled_pages).
>
> Ah, I forgot about this. For context, nr_stored was originally a
> zswap_pool-specific stat, but I think Chengming has pulled it out and
> converted it into a global pool stat in an earlier patch - yet,
> globally, we already have zswap_stored_pages that is (mostly) the same
> counter.

Thanks for the context.

>
> Might as well use existing counters (zswap_stored_pages) then, rather
> than a newly introduced counter. Probably will shave off a couple
> cycles here and there for the atomic increment/decrement :)
>
> > > - When memcgs are enabled, we use memcg_page_state(memcg,
> > >   MEMCG_ZSWAPPED), which includes same-filled pages anyway (i.e.
> > >   equivalent to zswap_stored_pages).
>
> This is fine I suppose. I was aware of this weird inaccuracy. However,
> for the CONFIG_MEMCG case, it was kinda silly to introduce the counter
> for per-cgroup same filled zswap pages, just for this one purpose, so
> I decided to accept the inaccuracy.
>
> > >
> > > Use zswap_stored_pages instead in zswap_shrinker_count() to keep thin=
gs
> > > consistent whether memcgs are enabled or not, and add a comment about
> > > the number of freeable pages possibly being scaled down more than it
> > > should if we have lots of same-filled pages (i.e. inflated compressio=
n
> > > ratio).
> > >
> > > Remove nr_zswap_stored and one atomic operation in the store and free
> > > paths.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Any thoughts on this patch? Should I resend it separately?
>
> Might be worth resending it separately, but up to you and Andrew!

I will resend to add some context and include your R-b, thanks.

>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

