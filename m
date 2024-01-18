Return-Path: <linux-kernel+bounces-30391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EAD831E19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328791F26580
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD02C6B2;
	Thu, 18 Jan 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2lU76t/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF125770
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597422; cv=none; b=G6IMYz45STOFhgtL4mvyfNbkSImO1YFlrBWt5q2bmqWGRi5gTnpOQOg5aOXV6YIIthBiQ1LhTz9F1RD9p4t7ykAviOedGG6AR7YhnUkPvMQXBAQ1bavYsKwb8oCc/UWtl6ib9HCSLAc61I/aG1aiuIAlD7QPVTXN5lB2sQp0OcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597422; c=relaxed/simple;
	bh=Xf0vVZ0CtTzvbv85PyOM6avhkZxNdVgvuagjNBhMa1Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=N4fqjq6USvv73W4kyMkR0ZHi3gTGOoxo8YTLCW6cBTrdU9dh5qgZ0SUTHtRGKCHX9clCAwxblfR5vGxGQmRoGqsFAAu283ZswCtPs89YMSVczBE7Q1OpX/Am+H5R3lM8T9w66VUkOqlYz+Y52TLgRJfJVfwmI5XT4qIPUlj6S6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2lU76t/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso455213a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705597419; x=1706202219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I307JXW0PD3nSS/XpS3TGtlMDXTLZF0yfATueCQN9yk=;
        b=O2lU76t/64m0d1/ZEP1LQfa7s1/pDFGJkIqkQftSHgfGCced079mY1aJw79LEr3jY/
         riyOmYXjhDzfmfjJOwlRv5HkUdaBMv5KprvBUf4Dq2Q7W08s7V5yVJIMRN8+GJ7DX4Nz
         dStyNkR+NZVPBD8dp5pKX6ARPrVk0HoiionD0vE0IXKu+5HJ3jZGd5L2Zb+pyZ1ppjQO
         XwrRBqNDDCVvDZz3xbjL/QyxkBOsusPSnBT9MMtkxJif5sHwRcJKErHGLv22gYyQnUoe
         1b2U+WKOxqz5pkEu09DW+mzed2fk1k+aY1QNCTgU1Po9GdFFSzjm0QEXcV8LdNUCAaQk
         3zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597419; x=1706202219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I307JXW0PD3nSS/XpS3TGtlMDXTLZF0yfATueCQN9yk=;
        b=qFKcmGEJ1pk2E/lc1uJgW3lMfA3i9SdQG+d2B8mb/NUAIpirgkG/ttfh9myhGZ8qGM
         4mz5ZnsixpwRAb7/JASrlr2M6eFMua4tXbT4+zTimL8lRnYF2qVpinPaFyOrP3wBjYuo
         06AcmM8+7F7qGjqb6xSuzJjYhSWOZ/kLQIIDRwvywe2ks/ViF3UGq1ZujpN5j6wjUVNd
         QhflXX49fCv42TS6hveKsvK1X754+Gxw54UaGn7se8rgIdxRrk/31CmzERIMFsRtJgbA
         iMURiEunvZr6V77lYUHQs9PepJKi1ZCvp20wFrAFwixZ89C49Sq0qtbQceMM+PwfjWEe
         hmmQ==
X-Gm-Message-State: AOJu0YzexxvrQTJBpmHdtND8DedfkEUGDYeDIsyNfgZ32EFA6V8uZLDM
	NXcxaReHA8B3v6eGoxx1P670cfAfyaGHtJaH6xZJxBv7LZtIyekAzMfdCadZmi5j2uo28CzQmr3
	h4GFeLRYwOCQzk1tJCDafTastOKH+xxqXF/3Z
X-Google-Smtp-Source: AGHT+IHuKD7maC0nGcnATuuHa2w9rlSgs1J23fq1aMgrTRCopXT2ixM6PjBqomxuPr8I6ScWM/QfYuNvRMXHzYokJDI=
X-Received: by 2002:a17:906:ca41:b0:a2e:d88b:53ae with SMTP id
 jx1-20020a170906ca4100b00a2ed88b53aemr674261ejb.129.1705597419020; Thu, 18
 Jan 2024 09:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org> <20240118164839.GK939255@cmpxchg.org>
In-Reply-To: <20240118164839.GK939255@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 09:03:03 -0800
Message-ID: <CAJD7tkZRMK2F09jgnjqPkoJtbFJ=Dj=QBtZbqXREKp4WE=_wyg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 8:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jan 18, 2024 at 11:16:08AM -0500, Johannes Weiner wrote:
> > > > On Tue, Jan 16, 2024 at 5:32=E2=80=AFAM Ronald Monthero
> > > > > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> > > > >                 zswap_enabled =3D false;
> > > > >         }
> > > > >
> > > > > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > > > > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > > > > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>
> > What could make a difference though is the increased concurrency by
> > switching max_active from 1 to 0. This could cause a higher rate of
> > shrinker runs, which might increase lock contention and reclaim
> > volume. That part would be good to double check with the shrinker
> > benchmarks.
>
> Nevermind, I clearly can't read.

Regardless of max_active, we only have one shrink_work per zswap pool,
and we can only have one instance of the work running at any time,
right?

>
> Could still be worthwhile testing with the default 0, but it's not a
> concern in the patch as-is.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>

