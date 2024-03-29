Return-Path: <linux-kernel+bounces-125275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65C892341
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C2D1C211D6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F8137900;
	Fri, 29 Mar 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtW2BC8H"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676812B7D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736601; cv=none; b=ScdoTImEJwuVOQgef+8Mr+C095yfulEiBKgjvHYkYHYa0W+ZfemhkTGo+izMXpmfrTVipSIvoV3AqizZZYgq+xXB0YJkEfUtwPFdvI0FCS15PdgKagRQILLpc+cwLJIXhBDvq/iFhaeZtX9Q2ULO1795t84CJApHlHIOQo1Ys+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736601; c=relaxed/simple;
	bh=Ri886Lw8jukx1prPJ32EUubdstdqvHgl3TtWW0FFYq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiQGzoCq79eW59PKD36tQ1yaYLZcAGV5WQxyLgMnLusdz7dsHGHRCp8QJPY0QyUVz6yXFnQOtZqHkDr3Ocs2eBqP7+5quUAvAImMv00hkW3d9kgclG9tFfY5AB/qoMaJGfGREPoBOVoRly3Z+xWpJq/UdbCgJUQns2SToZo5spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtW2BC8H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515c198e835so2471244e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711736598; x=1712341398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri886Lw8jukx1prPJ32EUubdstdqvHgl3TtWW0FFYq8=;
        b=KtW2BC8H249s1oOQzzxpKgavGGUINGaAZclGSOG0RPDd38baiMo7yTTVa/+1yrUwAj
         Ly7JvTj3M1nmEYt0kRWrmRZ8ruP8Zv2eVBoGTBUqA4xZvNejM45Z8xMLq0jrYfRCKnON
         QBd8NaLP+Ypiwjn/U8x54ExP3AhufatSSninvgyhrrvIZ9WSa9hbNeQaEkH5CAOkj4iV
         4kI6MkJ0XosbsyaLuI7FVjFX9LazsonZiUOH6LGNhXzRS7/NFkMy5hZnQ1Wr4uQSuQHn
         +hVxZJUZ+yxtUuOczIxHqw7k/Maxs3p0tH7KWu6XJ3l9E4LehYIJ9e4EvBU0MztRKkT/
         2GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736598; x=1712341398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri886Lw8jukx1prPJ32EUubdstdqvHgl3TtWW0FFYq8=;
        b=QdnN5gnjD16G7Bv9cG/NVA60jCj2TkUAQzhGW0YyZIeVkIRZlQOXycIohVDnWVfznP
         2CefSxXJVipRV7rj7FgvM8hEYrUxQZDQWhCp2nEjtvaH4MOGdGF4RhNuT7u+LMFBrcDd
         YyqX1RvF3q07JF775NU3JqMEWbaKbxLWeju30wKeHqpVdEZZmP8aUJn9wXDzh3ukIMrl
         ppo6GkKGsVFnGjxoX+ETQ7BskFUfGDr6n82Q/wvglWlriODXYDHsOdB3SjlmgmvToB1w
         /Wqwku76Og/LxYdtjDIuAEM2AycJGKzDnragDcAXqoN0wRQYrVNinw1sSSHNelY725cZ
         UuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmVsuhGvRhmAx3eLj2WYQAhUwVl9cjvBjM+QrEpX3cwb9dHFbAW6IMDANL7qwZ2wPWKRIU0ajsD8NZBT22R0gmK2N51RYk+cNw+DG6
X-Gm-Message-State: AOJu0Yw8zAOGv9EazWwaf0pO0Vzde9wuR0Hxpgzz9u4CrFTnYzxmWWXr
	zwJBSkf+u9or/FJqgoy5dg3U4CFpH/nkoV51Yy6TSoqzx1PzRGHGRz4mR2AdMYGqDDhzdQUiQS8
	K/Zi5XuUZ33cPBlzH9IXYuEDcTVRTDMQvlgbzjSmdqELHc8tCbfKZ
X-Google-Smtp-Source: AGHT+IHDOJqPMLXcyCbIlwaancqWKBwZDloy959OYM9mZhvLf8RyPOrb+rJYSzvZz/bwaIPa0lPnoCZbtii+fl/4ow8=
X-Received: by 2002:a05:6512:2213:b0:514:e5a7:110f with SMTP id
 h19-20020a056512221300b00514e5a7110fmr2342410lfu.54.1711736597606; Fri, 29
 Mar 2024 11:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com> <20240328191109.GE7597@cmpxchg.org>
 <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
 <CAJD7tkYo90ynKfBcWyMZLu7r-GJj3egnnJyGiJ5T2SN-Tn3d9A@mail.gmail.com>
 <19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name> <20240329174457.GJ7597@cmpxchg.org>
In-Reply-To: <20240329174457.GJ7597@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 29 Mar 2024 11:22:39 -0700
Message-ID: <CAJD7tkaXtbM6_6+Oe08_xorMRrU94nvEeDj4_R78nKdZZWqAMw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 10:45=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Mar 29, 2024 at 03:02:10PM +0100, Maciej S. Szmigiero wrote:
> > On 29.03.2024 03:14, Yosry Ahmed wrote:
> > > On Thu, Mar 28, 2024 at 1:06=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > >>
> > >> On Thu, Mar 28, 2024 at 12:11=E2=80=AFPM Johannes Weiner <hannes@cmp=
xchg.org> wrote:
> > >>>
> > >>> On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> > >>>> There is no logical reason to refuse storing same-filled pages mor=
e
> > >>>> efficiently and opt for compression. Remove the userspace knob.
> > >>>>
> > >>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >>>
> > >>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >>>
> > >>> I also think the non_same_filled_pages_enabled option should go
> > >>> away. Both of these tunables are pretty bizarre.
> > >>
> > >> Happy to remove both in the next version :)
> > >
> > > I thought non_same_filled_pages_enabled was introduced with the
> > > initial support for same-filled pages, but it was introduced
> > > separately (and much more recently):
> > > https://lore.kernel.org/all/7dbafa963e8bab43608189abbe2067f4b9287831.=
1641247624.git.maciej.szmigiero@oracle.com/
> > >
> > > I am CCing Maciej to hear more about the use case for this.
> >
> > Thanks for CCing me.
> >
> > I introduced "non_same_filled_pages_enabled" a few years ago to
> > enable using zswap in a lightweight mode where it is only used for
> > its ability to store same-filled pages effectively.
>
> But all the pages it rejects go to disk swap instead, which is much
> slower than compression...
>
> > As far as I remember, there were some interactions between full
> > zswap and the cgroup memory controller - like, it made it easier
> > for an aggressive workload to exceed its cgroup memory.high limits.
>
> Ok, that makes sense! A container fairness measure, rather than a
> performance optimization.
>
> Fair enough, but that's moot then with cgroup accounting of the
> backing memory, f4840ccfca25 ("zswap: memcg accounting").

Right, this should no longer be needed with the zswap charging.

Maciej, is this still being used on kernels with f4840ccfca25 (5.19+)?
Any objections to removing it now?

