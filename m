Return-Path: <linux-kernel+bounces-49654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED83846D81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04E7296EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F77E57D;
	Fri,  2 Feb 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO8NURvj"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351A7D414
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868818; cv=none; b=SjGzL/AtDttwNbp2heGBdHZmmcNBqoz+AZHsahzcXjfqO5k1a3n6rDh0fKR0y1WNaB6sFtx64TdGheoSp3yZX6aSBTUFa8VIR1bSq28c27Q7G5NNkKKYsuhHcJtVY7AV/pUytPGtUg9hEeopbUVsVhzoOQiYEHCzEC9GAWCs9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868818; c=relaxed/simple;
	bh=itc1lWSzDl2ak1k3l4KGvZCc9ZWdvBnL0W7Kq6iSLm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugMDAl4fSyB7X+N5H4enQRZBbQabuxJu3feHfqFN0h3QKWFj+bmmEPw6uyee4wfyFI+xL4P0Xh2AIAQVbdgL7s9YsTyef8HmgPKEgcMpgR+dC+MCP515uOJBTO2xURIpceew5sdMcuYPo6/8rjDvytdb6YLZ8whxNxXE89DeW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AO8NURvj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso796192241.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706868815; x=1707473615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itc1lWSzDl2ak1k3l4KGvZCc9ZWdvBnL0W7Kq6iSLm8=;
        b=AO8NURvj2gK7QOie9bG3BbMKMSvQrtQvvIjzCDrLqg/LhRonfOA4lMcD1ppKGnQjeW
         T5tTAbwgYXrMvfKyJcEih+PN9tpQxNUIW6kx1ocx5r6TxD04DFa71/XEC2xfkr1SMNX4
         16WVZE0ygJIYw4jziSF5bgf6i14Z2goZxgjrFWnFiAyfogDoJmxg36ohDs8W7UyJAxwS
         L6Gnc8AqE22+0vjFjtdpHI9mCwaekalox8zlwa+SzTW8AFv9YiWzBl6UbAEPSvAGI4eC
         I3A9J+YvD9dIXKqmn0QZmhObfkjRMyXj9sDU8QGBBLACnXuQ7OX0Emhst2SxS+ciYljr
         x4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868815; x=1707473615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itc1lWSzDl2ak1k3l4KGvZCc9ZWdvBnL0W7Kq6iSLm8=;
        b=c3TKl4LYQJi7sc1xMbFfAfFhACl5BkEugnHpZn+LdI4veDnk3kGB6+LtL/vpTdG3bc
         BMz/cUekrz9SvTt4qiEvxnCvaAMDUUSLGe6xQ0yCPDeGdtTWZIbHDm96ttYY9GCqCclN
         oCDeQy+R9WJmSDc/6W+KpopbJ4QPFbru9bnMNIlAvcK/zeQUDcokRuX9TT9RZFitDuUu
         Bo3yDP77h6mdfuCC0ZfLDLY8qxzBhpmCCcB/DkXHRqmlnnJ3i+HXNjsUkn9xylBgV46W
         S2b31kz+imNXauD3ODKGbqgmwHODkVbJCYP08MqqF6PjZAQQZ89b6V4/7OKg8xPLKkWa
         pzTQ==
X-Gm-Message-State: AOJu0YzcRTAIjlkGgAC/W0ECUjqM/oawGKwZJaH33JtyOo6JxlaciJZy
	DGDmS0ZCw4Ks7cUIs1wpakEAjmZ8swgpf2sIeDVp2OYM9kocLm/bC0fIpY1ND0dtVC0nZx1G/N3
	Mj0G+dN89FiEzulKzGQCX9l6/QyLC8eyaxK1b
X-Google-Smtp-Source: AGHT+IEzBgLYEciVPVcpCXSuKNO5sRz/LDpHNGxnl1X6HRseV3PVdmUe7idbfSkvOlrk/qYs+fmMOUdq2h2uHAW10r8=
X-Received: by 2002:a05:6122:13a:b0:4bd:789a:64dd with SMTP id
 a26-20020a056122013a00b004bd789a64ddmr6184191vko.2.1706868814944; Fri, 02 Feb
 2024 02:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131210041.686657-1-paul.heidekrueger@tum.de>
 <CANpmjNPvQ16mrQOTzecN6ZpYe+N8dBw8V+Mci53CBgC2sx84Ew@mail.gmail.com> <nrknx5hi3nw7t4kitfweifcwyb436udyxldcclwwyf4cyyhvh5@upebu24mfibo>
In-Reply-To: <nrknx5hi3nw7t4kitfweifcwyb436udyxldcclwwyf4cyyhvh5@upebu24mfibo>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 11:12:56 +0100
Message-ID: <CANpmjNP033FCJUb_nzTMJZnvXQj8esFBv_tg5-rtNtVUsGLB_A@mail.gmail.com>
Subject: Re: Re: [PATCH RFC v2] kasan: add atomic tests
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 at 11:03, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.d=
e> wrote:
>
> On 01.02.2024 10:38, Marco Elver wrote:
> > On Wed, 31 Jan 2024 at 22:01, Paul Heidekr=C3=BCger <paul.heidekrueger@=
tum.de> wrote:
> > >
> > > Hi!
> > >
> > > This RFC patch adds tests that detect whether KASan is able to catch
> > > unsafe atomic accesses.
> > >
> > > Since v1, which can be found on Bugzilla (see "Closes:" tag), I've ma=
de
> > > the following suggested changes:
> > >
> > > * Adjust size of allocations to make kasan_atomics() work with all KA=
San modes
> > > * Remove comments and move tests closer to the bitops tests
> > > * For functions taking two addresses as an input, test each address i=
n a separate function call.
> > > * Rename variables for clarity
> > > * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp=
_store_release()
> > >
> > > I'm still uncelar on which kinds of atomic accesses we should be test=
ing
> > > though. The patch below only covers a subset, and I don't know if it
> > > would be feasible to just manually add all atomics of interest. Which
> > > ones would those be exactly?
> >
> > The atomics wrappers are generated by a script. An exhaustive test
> > case would, if generated by hand, be difficult to keep in sync if some
> > variants are removed or renamed (although that's probably a relatively
> > rare occurrence).
> >
> > I would probably just cover some of the most common ones that all
> > architectures (that support KASAN) provide. I think you are already
> > covering some of the most important ones, and I'd just say it's good
> > enough for the test.
> >
> > > As Andrey pointed out on Bugzilla, if we
> > > were to include all of the atomic64_* ones, that would make a lot of
> > > function calls.
> >
> > Just include a few atomic64_ cases, similar to the ones you already
> > include for atomic_. Although beware that the atomic64_t helpers are
> > likely not available on 32-bit architectures, so you need an #ifdef
> > CONFIG_64BIT.
> >
> > Alternatively, there is also atomic_long_t, which (on 64-bit
> > architectures) just wraps atomic64_t helpers, and on 32-bit the
> > atomic_t ones. I'd probably opt for the atomic_long_t variants, just
> > to keep it simpler and get some additional coverage on 32-bit
> > architectures.
>
> If I were to add some atomic_long_* cases, e.g. atomic_long_read() or
> atomic_long_write(), in addition to the test cases I already have, wouldn=
't that
> mean that on 32-bit architectures we would have the same test case twice =
because
> atomic_read() and long_atomic_read() both boil down to raw_atomic_read() =
and
> raw_atomic_write() respectively? Or did I misunderstand and I should only=
 be
> covering long_atomic_* functions whose atomic_* counterpart doesn't exist=
 in the
> test cases already?

Sure, on 32-bit this would be a little redundant, but we don't care so
much about what underlying atomic is actually executed, but more about
the instrumentation being correct.

From a KASAN point of view, I can't really tell that if atomic_read()
works that atomic_long_read() also works.

On top of that, we don't care all that much about 32-bit architectures
anymore (I think KASAN should work on some 32-bit architectures, but I
haven't tested that in a long time). ;-)

