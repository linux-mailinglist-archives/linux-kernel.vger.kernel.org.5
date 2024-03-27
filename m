Return-Path: <linux-kernel+bounces-122109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0988F1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F4E291624
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2815359B;
	Wed, 27 Mar 2024 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAwCzK33"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CF152DF7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579160; cv=none; b=Qt5RkdQ4ZpnK4uaB1eGQFkewI9AvvLEBbgz3Ab08BkF+SqWDzQbRPUx5dXJIrsQjrItgyXaxokSkf2X+5/z6lxSPLBpr5pm+pHRizZwWuF3K8yRLe35tpQUpuaJbTg2x3OGayM4nQLX3Un070RV0AfdAZh+oFcVTamESBY4Agqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579160; c=relaxed/simple;
	bh=43PGJMNm6dcBxGBJVQQJfMWWY+4XfwTZKIeOY/+KzUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzzWw/E2DB50e1GwYOrpjIUi4CieSyTiV5TSR2sXl2HP3wVz3XfKCjznATywXOU5dJD4KsAUT5rGRkfUlhOGJ4X0ZYPOxNL4ygkKrCty3dZQ9XeG8GjUxWK/rcoCdQhqtg/d/d8oqV+OLK3XXuOe/Q2UpczvP+0KwYhiguMmGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAwCzK33; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso38305666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711579157; x=1712183957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1cjAPg3P3yGfB0cGLLrcBuhJSOl7HjfK6fppKH08jA=;
        b=JAwCzK33y3NogNda/+Us2doHqOR3hKcuw+PSeBLVDFqBhbTspjdOlr9HxvLx8tLBTU
         9AJ4N4yzT3TusDRg2tezVs1ZLxZqJ3N8wvn4sWesYh5+QvPXYdiFx+fDQ4N4Z5DpJ5tX
         ICdpD0SJqDzAFMC3PSRq+C8aPeMZalArhoOxzQlS5FIYQgT0n1du7QZOBEzKsEfz6Xr9
         cKR2tZz407rpAV1QMn5vX9OyEhfSwPOJfntK4LoCL/57usZA5WQ6/cEuNMwaF/3d9M6c
         94QZmANRWMDnNM8+0Oj8vit7AGxYj12UUUC5P1/jc2DPNn1ZeVfe2tSmbivWVOLeza98
         g1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711579157; x=1712183957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1cjAPg3P3yGfB0cGLLrcBuhJSOl7HjfK6fppKH08jA=;
        b=Wf239KskQcXDeaV4xnDKCg4ZqxRl0+W1oDgFXTErnMU20uFYpkdDX7LEMBiRv+mkwG
         YUfztgOMr1yDFWJb1WVnuoeS+OBh3UOvAjXgPhbz081t+Yy4whPosl6syNeDDNCsk4q2
         5gg0MFGHgoizKbpHTtJtVLBKTfax1G+K2iRyGPrannZXkLdXn3yOA7z+kWuKmXDo17h0
         aYwuGfybdKgEkgFGwJihjPZz+HIx/x+75/6xkwd4x7Z/PJ0h3rk/0Bm0eMt4j/10W5P0
         A2PrtrFg6UKrZ9jeUOOnZ97FL2iQigSew+KBW/szabq/XiXqci+f7cj6qazRsPOcqZRl
         KXGg==
X-Forwarded-Encrypted: i=1; AJvYcCVJY2TJ8acEAeruFFBRp6qbl2uCByR96GIIKtDzfeXehSUg3aPZSZbVETCp4uI7IhmN+isjA1a9Frf9inQzMMb2HPyv+Eq0roazo+uv
X-Gm-Message-State: AOJu0Yyc2IebxI7XJrV6qW7vzhF+fpve62OtXLGKBR0PDj0iea+cjAsm
	7L6pFV1T48npKUx83KC3p9juDPmqqwp9QJamEQ0lFZNazVLu3+N8Nmcu4VQwtzi1wf2wHz/7pnz
	+8Zoq3s7xmVI9R6zOTqFccsgYvVjkE3jkiJrv
X-Google-Smtp-Source: AGHT+IESpxUOy2aQd+X7y995ivnCyLCCmWIPPWojFHEzKTwZRx1vPrT90ItIXVBuS18eRAL4o6RCM6nArSnuyp1T/8Q=
X-Received: by 2002:a17:906:bc94:b0:a4d:f26b:e103 with SMTP id
 lv20-20020a170906bc9400b00a4df26be103mr497807ejb.12.1711579156798; Wed, 27
 Mar 2024 15:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-7-yosryahmed@google.com> <CAKEwX=OMtqFKLRXF5v2P-Z5WEq3x0Tb=6dPKta8uGqi3MXsZEA@mail.gmail.com>
In-Reply-To: <CAKEwX=OMtqFKLRXF5v2P-Z5WEq3x0Tb=6dPKta8uGqi3MXsZEA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 27 Mar 2024 15:38:40 -0700
Message-ID: <CAJD7tkYmVUhBw5ZXT2yopGOSKRg0Rord1+FFddHWfmb58Z1cgA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:41=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Mar 25, 2024 at 4:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > The current same-filled pages handling supports pages filled with any
> > repeated word-sized pattern. However, in practice, most of these should
> > be zero pages anyway. Other patterns should be nearly as common.
>
> It'd be nice if we can verify this somehow. Maybe hooking bpftrace,
> trace_printk, etc. here?

I am trying to do that. Unfortunately collecting this data from our
fleet is not easy, so it will take some time to figure out. If the
data happens to be easy-ish to collect from your fleet that would be
awesome :)

>
> That aside, my intuition is that this is correct too. It's much less
> likely to see a non-zero filled page.
>
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
> >                 base            patched         % diff
> > real            70.167          69.915          -0.359%
> > user            2953.068        2956.147        +0.104%
> > sys             2612.811        2594.718        -0.692%
> >
> > This probably comes from more optimized operations like memchr_inv() an=
d
> > clear_highpage(). Note that the percentage of zero-filled pages during
>
> TIL clear_highpage() is a thing :)
>
>
[..]
>
> The code itself LGTM, FWIW:
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!

