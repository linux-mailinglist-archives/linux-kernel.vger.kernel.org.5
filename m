Return-Path: <linux-kernel+bounces-170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103A2813D04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A3D1C21B84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03C2C69D;
	Thu, 14 Dec 2023 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnYJWpA9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13472C682
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61784C433CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702591343;
	bh=C+Ukl1C4q56PMFXgAY2rFDxz55Ib83hO1GYH/qExqT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WnYJWpA9hh4rCdH+ni/v6Gr9i3n6qiWyvZGXLtqUEovTT7wtyHOd6Me/ksvu5YHdd
	 dyvjHatBO75SYk0DFWi/HH/XcdUGeR/FNqRQubprL1EofmWZl0/EapJRlpu2JGbe3z
	 9hq6OAqd9l0A6+XKBtEiK1tdOV5sQrYuV206qtmIG/P3CEOHyCqLoH7M2G2TZBNxof
	 ufCbBGWb3SqbQYcQ0lVdYQ+v2Uzh+RTIS2+QTYwZZVd0J29YMv80XQs85ZLN/K8AFx
	 fHqgrX9gTW0CQ2mMj6q+JAz0JW351VBq5EwjtQN4CZbYNQ/cEGFnmj6vD+BL6BS+dI
	 81/TTfz91MKLA==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b050cebc1so1018226a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:02:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxewJokv8loaDigtw7sjebZGRojlUuFLptllH6I2YMZbSJ04pw8
	k7+RZP0VORAOj8BkVj5qwwkGUbyWuUcWh5Mvu0YlyA==
X-Google-Smtp-Source: AGHT+IFgwY4ydcxX5SA5ZcLLxVd0G9cVRGEidy3qgrOv1NVhFhLl8ZPDgihzMEajEZYQ5SOQAvnCuSzK9qNdIFU1lp4=
X-Received: by 2002:a17:90a:ba8b:b0:28a:c74b:25a with SMTP id
 t11-20020a17090aba8b00b0028ac74b025amr2721462pjr.20.1702591342758; Thu, 14
 Dec 2023 14:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com> <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
 <CAJD7tkbmkUsNbtzrAS-ELANa_G3Qth=670A0zNu_K21QByJyZw@mail.gmail.com>
In-Reply-To: <CAJD7tkbmkUsNbtzrAS-ELANa_G3Qth=670A0zNu_K21QByJyZw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 14 Dec 2023 14:02:11 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO6MNhK7NF6B4-kmci05JamJ17qk2pg=vL_VmbpVLLAHw@mail.gmail.com>
Message-ID: <CAF8kJuO6MNhK7NF6B4-kmci05JamJ17qk2pg=vL_VmbpVLLAHw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Thu, Dec 14, 2023 at 10:27=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Dec 14, 2023 at 9:59=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to fi=
rst
> > > copy the entry->handle memory to a temporary memory, which is allocat=
ed
> > > using kmalloc.
> > >
> > > Obviously we can reuse the per-compressor dstmem to avoid allocating
> > > every time, since it's percpu-compressor and protected in mutex.
> >
> > You are trading more memory for faster speed.
> > Per-cpu data structure does not come free. It is expensive in terms of
> > memory on a big server with a lot of CPU. Think more than a few
> > hundred CPU. On the big servers, we might want to disable this
> > optimization to save a few MB RAM, depending on the gain of this
> > optimization.
> > Do we have any benchmark suggesting how much CPU overhead or latency
> > this per-CPU page buys us, compared to using kmalloc?
>
> IIUC we are not creating any new percpu data structures here. We are
> reusing existing percpu buffers used in the store path to compress
> into. Now we also use them in the load path if we need a temporary
> buffer to decompress into if the zpool backend does not support
> sleeping while the memory is mapped.

That sounds like pure win then. Thanks for explaining it.

Hi Nahn,

> I think Chengming is re-using an existing per-CPU buffer for this
> purpose. IIUC, it was previously only used for compression
> (zswap_store) - Chengming is leveraging it for decompression (load and
> writeback) too with this patch. This sounds fine to me tbh, because
> both directions have to hold the mutex anyway, so that buffer is
> locked out - might as well use it.

Agree.

Acked-by: Chris Li <chrisl@kernel.org>

>
> We're doing a bit more work in the mutex section (memcpy and handle
> (un)mapping) - but seems fine to me tbh.

Thanks for the heads up.

Chris

