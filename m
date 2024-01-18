Return-Path: <linux-kernel+bounces-30472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65A831F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D811F2389D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631AA2D7A6;
	Thu, 18 Jan 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBGbnc21"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353262D791
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602787; cv=none; b=hE0BJCJXjam0zmdVsiOjFDPuzorrHsS5Pd8AWXiDCSWdhR1LRdNvJAfIC5f5JgLM8LSKEdnMs2On7jrqehwU2o+TmEneKtCLV851ljYbiDJDWpMvNYkEnsrh17krrwHqFZAUqkJmztpz9DQxVpDDfZgnrxgduB2agXdlF74bA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602787; c=relaxed/simple;
	bh=AoKvtiZnBVW/PmvlVnV1RfQwRL3DN9j4sZFOWAIFXeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHnCFD6JMx/Gq3cf7oAJ8WGDPT/pYWUaWHDTKAaveaT2kBKX14DUihU7oiR3ZwgtpVEMi8su7fypOD1VOn7MofjVMO/vczqw4yofdACNGmv5fQy0NxV81GZesdvWXIk4WiqNt1rFFq2IfoqJl/gHfH0k/qBEEfqyDqBiccSMj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBGbnc21; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b7153b8d76so2148316e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705602785; x=1706207585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoKvtiZnBVW/PmvlVnV1RfQwRL3DN9j4sZFOWAIFXeo=;
        b=QBGbnc21gDYX39pRJWb6inxDpBloZKQgQxfs5pwYwe82L/3LpFlww4Jxs8Z7YA+t35
         4n++nlqpqKQUfddj59NzF8EFKOi9ar5KFGWnoeWWLcygiBegj+L/kDt3Eqx42U+DVLHJ
         uV4y0OO/9qEDolO6RXnV2bR75QIjNl0SdRTbCDlhyTSqfwPGBCKAiwlzRQPxsOh1DbUs
         Dt82N5S4n2cLQaR+3ctbx8ZLzWUN5mwjRhD/yY84LTtRxH8LaigDj9Y3QrmNkUIhDz/X
         9qWEl+ALXVP/MFkfxK8wuy/5q7HfmhtunGJKdwFq1IESbh/Ni81Sm3kH0BUXzoV43z9N
         JnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602785; x=1706207585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoKvtiZnBVW/PmvlVnV1RfQwRL3DN9j4sZFOWAIFXeo=;
        b=Xps1jRw6SMVEBAotpGFjGcT9CwCDW/arG2MHPGKxVjJ7ibvaBbs8MCzmuJXE3SZq6P
         BmD/LyOen7fSSchF7CnAu6sChRg16n7rM5P4MfvA2r5vd92KPn9IljHLQIsWLZ+ns6a2
         nrxI2ETmsGV0lDVuVmhwZb0rSRRK4Hyqn+SRcqUI+BOcEkbL2rtXrwquoXa5rQYSl+qk
         GOwP6E+I3nnCrtOnTNEpT/kED13km/ryXU3a/5IG/Wb+Dsr+encjXAZGuBrv4OUqjLyn
         wO/lGQxnZ0BDo3pP6mxBdCzC736v3ANN2Jy6vDIh6znGJ/uDloyTu++k9iuacrEWLx/Y
         b8Qw==
X-Gm-Message-State: AOJu0YzFZgi2CanUJOkSvbDX725mZHJi++k31mo+yyREBIuNr+HL8XXF
	SK5G7hJfRLQ1/TZdHC2apc/3c6oXsn7pK+/xFfqKCM/J35oIGdddWcrDFYT8Mloud6yjBlx39RS
	w+kYotZxF/Cn7dqjgo5jcheo9DoU=
X-Google-Smtp-Source: AGHT+IGz8+VV+YjIzdeZnTGQat3BrS60m1s2aKJuDXDW43uot7OTGBId3+z+1dtYJTgJcqGKtfBevgjflgOsIJSNG8E=
X-Received: by 2002:a05:6122:3128:b0:4b7:4cfb:4217 with SMTP id
 cg40-20020a056122312800b004b74cfb4217mr937797vkb.22.1705602783574; Thu, 18
 Jan 2024 10:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org> <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>
 <20240118173927.GL939255@cmpxchg.org>
In-Reply-To: <20240118173927.GL939255@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 10:32:51 -0800
Message-ID: <CAKEwX=PKBaqcpFwXpf1-M2nZ+ytFv2oCwxRVCe+CC5++rhgY=A@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Ronald Monthero <debug.penguin32@gmail.com>, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Jan 18, 2024 at 09:06:43AM -0800, Yosry Ahmed wrote:
> > > > > On a different note, I wonder if it would help to perform synchro=
nous
> > > > > reclaim here instead. With our current design, the zswap store fa=
ilure
> > > > > (due to global limit hit) would leave the incoming page going to =
swap
> > > > > instead, creating an LRU inversion. Not sure if that's ideal.
> > > >
> > > > The global shrink path keeps reclaiming until zswap can accept agai=
n
> > > > (by default, that means reclaiming 10% of the total limit). I think
> > > > this is too expensive to be done synchronously.
> > >
> > > That thresholding code is a bit weird right now.
> > >
> > > It wakes the shrinker and rejects at the same time. We're guaranteed
> > > to see rejections, even if the shrinker has no trouble flushing some
> > > entries a split second later.
> > >
> > > It would make more sense to wake the shrinker at e.g. 95% full and
> > > have it run until 90%.

Yep, we should be reclaiming zswap objects way ahead of the pool
limit. Hence the new shrinker, which is memory pressure-driven (i.e
independent of zswap internal limits), and will typically be triggered
even if the pool is not full. During experiments, I never observe the
pool becoming full, with the default settings. I'd be happy to extend
it (or build in extra shrinking logic) to cover these pool limits too,
if it turns out to be necessary.

> > >
> > > But with that in place we also *should* do synchronous reclaim once w=
e
> > > hit 100%. Just enough to make room for the store. This is important t=
o
> > > catch the case where reclaim rate exceeds swapout rate. Rejecting and
> > > going to swap means the reclaimer will be throttled down to IO rate
> > > anyway, and the app latency isn't any worse. But this way we keep the
> > > pipeline alive, and keep swapping out the oldest zswap entries,
> > > instead of rejecting and swapping what would be the hottest ones.
> >
> > I fully agree with the thresholding code being weird, and with waking
> > up the shrinker before the pool is full. What I don't understand is
> > how we can do synchronous reclaim when we hit 100% and still respect
> > the acceptance threshold :/
> >
> > Are you proposing we change the semantics of the acceptance threshold
> > to begin with?
>
> I kind of am. It's worth looking at the history of this knob.
>
> It was added in 2020 by 45190f01dd402112d3d22c0ddc4152994f9e1e55, and
> from the changelogs and the code in this patch I do not understand how
> this was supposed to work.
>
> It also *didn't* work for very basic real world applications. See
> Domenico's follow-up (e0228d590beb0d0af345c58a282f01afac5c57f3), which
> effectively reverted it to get halfway reasonable behavior.
>
> If there are no good usecases for this knob, then I think it makes
> sense to phase it out again.

Yeah this was my original proposal - remove this knob altogether :)
Based on a cursory read, it just seems like zswap was originally
trying to shrink (synchronously) one "object", then try to check if
the pool size is now under the limit. This is indeed insufficient.
However, I'm not quite convinced by the solution (hysteresis) either.

Maybe we can synchronously shrink a la Domenico, i.e until the pool
can accept new pages, but this time capacity-based (maybe under the
limit + some headroom, 1 page for example)? This is just so that the
immediate incoming zswap store succeeds - we can still have the
shrinker freeing up space later on (or maybe keep an asynchronous
pool-limit based shrinker around).

