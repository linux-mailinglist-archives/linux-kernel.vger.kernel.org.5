Return-Path: <linux-kernel+bounces-30457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17218831EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1151F2360E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E52D614;
	Thu, 18 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCqXL/3M"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2C2C842
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601302; cv=none; b=JwECGLZJx1+3EXZscxp6xXtGQrlCK7E1bvF/0TQSYNjwaQFWmx+BXpUOpI8hHYU+p7GdkJUCREY3izkGCmMhouAZeOQt7qdaz5LLhEqtq/0qjqBKVsOpZmJf5pjfxhcjzIWgolg2boe9O076JU3NYMi0PVQYEiHYj/6uE1S11nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601302; c=relaxed/simple;
	bh=lb+KFR5UwwKootoHG78GkwJ5LrRDGOQzgc5mdvn66a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1R20eo+ck1DbYqKZu6YNEg6PfQJjy3zUHn7aC+d8aRuyhWF0TFFM8Cr/ypI8OglSV4IuP9Oj858ExWmBJ7ygUMG4iddKSlJqrUpdl8Dxt5S88/WH1pmnBuIPRhKz1aJctFbcNPst+YKAUa55Yp1WUYNR8NegpRYhpkREhyxPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCqXL/3M; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee87b2f5eso261547639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601300; x=1706206100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9oyBIjEpoT3XMaWPjAXVyQ5+LqPNizEst4EFi9ms0Q=;
        b=MCqXL/3M5UGJPztQoGpoOCz0JVYatYKsM2D2p7GB4LBHTH+LXVUZcIUKlMeKrugy7J
         ckelnOV7o6YF7zRuLO5VLvdoiv9kfzUEgEYYV+ytOkh+NBgXXNYTB2Gv6tlWN2tPTsPk
         oZm4pVpJQQbaV8dyWiIHtWWwUxmkFQk646a79YLye9g8XREf91CsXYHCXWsQsERc4C6e
         To5vm5fvn4mkaI9t9dO1UHdJNOipk5YVGpFSFsGB08LFDC/L3N6g6jbFhzdTH/o4/iG/
         q22WwP9VjlArUq1K6FLDc8WxN+viqrAfYh58dHJ5/CUsMlUROHhP8tGINKc1t5H4iurh
         lnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601300; x=1706206100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9oyBIjEpoT3XMaWPjAXVyQ5+LqPNizEst4EFi9ms0Q=;
        b=Vh007JTnJJLI9djaMd1whBpLw8paGF9zBEGEfM9GImIb2PJFqbSAYvFOBtL47+7Q/m
         pCzA9rhzNDRhe/1C8mMMGFu1e0Ftoie0AdIhq2q4QkZ0ZvMRrJuAnc2N3VSOL/qXyyiz
         F/qpgbeeYo5XEUdkQ//PhGuLlX+lsnGnuZ+56XQyVAPvTqk0YFNSjGp7h/GpETBg8Q76
         u/2nvXgigiFLMGLWo5KoZ/voqdacMWKheYcm2Tz9F5SnWr/lmm64l6g8lbHWJJNAJuny
         GTZ2EL52BPSJQ2e+n0fr1U6DAktCvOiqvb0jADGVoxVWhVG6ZZNB8w0TufELv1qXOy1V
         zWKg==
X-Gm-Message-State: AOJu0YyPjVK7Wj+cHuMVkKXRzJxUWyO5Z5e99OB4HD3oIg8VTdDfZ2GT
	GEy1o1XYEaz0iVmC6AS8tcvkIes4ScfuCk2+5j21eQHoE+gnNXWYFOwqi9E/fodY8KVYyBvSQ5I
	FNONwq1PD+kavFt4wAs9QKEuKb4A=
X-Google-Smtp-Source: AGHT+IFPx4jMifBcYgXWizqwzIkj3U7a3ZuHUudPepeumwLD+rKp+Cv/jbSzuIaNPFjH+aO8rc3jNodYlQO1f/3cyBg=
X-Received: by 2002:a6b:ea0a:0:b0:7bf:37b7:b0c0 with SMTP id
 m10-20020a6bea0a000000b007bf37b7b0c0mr1609603ioc.31.1705601300656; Thu, 18
 Jan 2024 10:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org> <20240118164839.GK939255@cmpxchg.org> <CAJD7tkZRMK2F09jgnjqPkoJtbFJ=Dj=QBtZbqXREKp4WE=_wyg@mail.gmail.com>
In-Reply-To: <CAJD7tkZRMK2F09jgnjqPkoJtbFJ=Dj=QBtZbqXREKp4WE=_wyg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 10:08:09 -0800
Message-ID: <CAKEwX=O10C80GAaYiem3z9KVMtZ_dgZrCqTQ=7wvx-br_hzuRw@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Jan 18, 2024 at 8:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Jan 18, 2024 at 11:16:08AM -0500, Johannes Weiner wrote:
> > > > > On Tue, Jan 16, 2024 at 5:32=E2=80=AFAM Ronald Monthero
> > > > > > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> > > > > >                 zswap_enabled =3D false;
> > > > > >         }
> > > > > >
> > > > > > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > > > > > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > > > > > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> >
> > > What could make a difference though is the increased concurrency by
> > > switching max_active from 1 to 0. This could cause a higher rate of
> > > shrinker runs, which might increase lock contention and reclaim
> > > volume. That part would be good to double check with the shrinker
> > > benchmarks.
> >
> > Nevermind, I clearly can't read.
>
> Regardless of max_active, we only have one shrink_work per zswap pool,
> and we can only have one instance of the work running at any time,
> right?

I believe so, yeah. Well I guess you can have a weird setup where
somehow multiple pools are full and submit shrink_work concurrently?
But who does that :) But let's just keep it as is to reduce our mental
workload (i.e not having to keep track of what changes) would be
ideal.

>
> >
> > Could still be worthwhile testing with the default 0, but it's not a
> > concern in the patch as-is.
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >

