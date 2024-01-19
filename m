Return-Path: <linux-kernel+bounces-31514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2727832F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660331F227B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EB5645A;
	Fri, 19 Jan 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ag1eNQAJ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7B55C22
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692665; cv=none; b=mdPnv4nio4DoOdvRu2X0J2V2r/7LCZMUUpIeh7x1qFeXNtciwT8uHr1kCkfCw4fNaBtMiVd7nTT/xj7rbtVH00fBQKncD1orcgY9vbX78JVPQgLbjzS4zV8HtRdl2Pcy1maTnvTsYVdFAmHsJFufYD0y4vBBJdPnpQ/Jc0to88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692665; c=relaxed/simple;
	bh=OKoW9Kb//BaTZ8/QW5uOo1sHZX3P0hjEfYgyeWLR2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyRpzwjDwpPQ30farSPzF6MnXXqUC3zZONGeMmt5T/C52RVdQpl29fnadWVvfoVpgRkwovBoOjzwc0fEyfVEwXM4SStCLru2sQ6WmUFvkS+UUAR/lstI24CEvw0t8xZ1tUoVhkfV8dHz9Iksp3arEPTVVzxxQ194KB6cbxhVoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ag1eNQAJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2cea0563cbso177814566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705692662; x=1706297462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ubddLskYXECGJ0tXpTZu2g1Mde5rJ6xI0bsqPnV2qw=;
        b=Ag1eNQAJDEbTFRwNKXxZfrDroTdigZnISH2U8iDRlR5dlx+cgUN1OQD2+TVUl2nHkS
         39i1SEaIV9xHk2dhEaM2itgx8GrXaSkraCwpevhFAfZ5f+7Dpj6O6X1Xz7Pvc+woJEB3
         PrBT82MqU8czOzGxJy3t5ANPLnVpXW8E896xHBZ1xU2B9Sji9BLgkU8P9rJeROfg13vp
         hb4Lv+GDGl6fRiMPYCkWH3Km1fmHT5W7EZGltnEh7cMH1MPanXVgKMkZW5xHoMfrPF5W
         4bffrMwldfSZeOV2S9sBMz5XE/jnF2GF10GLV1W8Jme8oHvRLOZRkERgEydpR7gfbung
         bD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705692662; x=1706297462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ubddLskYXECGJ0tXpTZu2g1Mde5rJ6xI0bsqPnV2qw=;
        b=QAqDBP1N2AYEq+ABgnlKJ9obbnAW8n1iCpXGLR70FNS473WkiieTORE9Y5GxvoFSjX
         185st8zCcxSkOGf/xg5DzEPhGBV2M/fICHgmW3qUy8ye49AZ7BjQ7YSeXZjAWLqntNzK
         UmPCup87Ih9+HKcGP5qrtXl8Ynv8HKJQIg0YQ+96FcJS8Sw/YH1ZV6uB/kvnfm5I2jgq
         jz18p5h+tsRforxE9A29tOXcZ8UqYEMIM6Dd0yNoh2Vm/tb03cMD/RVOYES/e9U6d86z
         tTuK7lyEGEk7+b5mDtZ7vULX4eLUJrdkPcKOaBMPde9qdtGyVZpLtbmbDbQX48ScS5PW
         D+IA==
X-Gm-Message-State: AOJu0YwTFD0ujbTTr/GE7WxgpItOylTjnZV1c9+5+tphX6FTexZOTJ1a
	ifGSkrTaoYNIQlbaO7599sVXOxq77z1sv57FQy+aLV+3IDRYUzsflszRHyhZQz6G5U17eILzdfP
	7gOkLEKWyYGIsvx7f40mm1YHDxj+uL1oySADy
X-Google-Smtp-Source: AGHT+IFYrODpKofEkDwc//ZP6TaZx3Hd2HhQqXKJfQKuVIkKBYy0k0KAMBi1e5Wz4yMorqeVJV3RiLjSPevtfY04spo=
X-Received: by 2002:a17:906:3b96:b0:a2c:a9c3:e405 with SMTP id
 u22-20020a1709063b9600b00a2ca9c3e405mr165006ejf.127.1705692661731; Fri, 19
 Jan 2024 11:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <ZaktH7xc72x4Xr3d@casper.infradead.org> <CAJD7tkapY4nx=uAXuyQhJN=rz7QPj6p9OJzpPwZGr_7+7Ywotw@mail.gmail.com>
 <ZaltEwGXHyFFuI0F@casper.infradead.org> <CAF8kJuPMhbMsjNf7gJF=5s+m0eVXg1juX1e9tVCEffrd5HbGaQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPMhbMsjNf7gJF=5s+m0eVXg1juX1e9tVCEffrd5HbGaQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 11:30:25 -0800
Message-ID: <CAJD7tkZRR2wwCyu-99+3y7FFOKm7omBZrrj-G5_tb9vOivpjWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Chris Li <chrisl@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:28=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Jan 18, 2024 at 10:25=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Jan 18, 2024 at 08:59:55AM -0800, Yosry Ahmed wrote:
> > > On Thu, Jan 18, 2024 at 5:52=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Wed, Jan 17, 2024 at 10:20:29PM -0800, Yosry Ahmed wrote:
> > > > > >         /* walk the tree and free everything */
> > > > > >         spin_lock(&tree->lock);
> > > > > > +
> > > > > > +       xas_for_each(&xas, e, ULONG_MAX)
> > > > >
> > > > > Why not use xa_for_each?
> > > >
> > > > xas_for_each() is O(n) while xa_for_each() is O(n log n), as mentio=
ned
> > > > in the fine documentation.  If you don't need to drop the lock whil=
e
> > > > in the body of the loop, always prefer xas_for_each().
> > >
> > > Thanks for pointing this out. Out of ignorance, I skipped reading the
> > > doc for this one and operated under the general assumption to use xa_=
*
> > > functions were possible.
> > >
> > > The doc also says we should hold either the RCU read lock or the
> > > xa_lock while iterating, we are not doing either here, no?
> >
> > I have no idea; I haven't studied the patches in detail yet.  I have
> > debugging assertions for that, so I was assuming that Chris had been
> > developing with debug options turned on.  If not, I guess the bots will
> > do it for him.
>
> It is fine now because we have the extra zswap tree spin lock. When we
> remove the zswap tree spin lock it does require RCU read lock. You are
> right I would get assertion failure.

I would imagine the assertions are that we are holding either the RCU
read lock or the xa_lock, how would holding the zswap tree lock help?

