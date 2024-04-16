Return-Path: <linux-kernel+bounces-147083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823778A6F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140022819D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CA130A53;
	Tue, 16 Apr 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="smFG36IS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEC12FF80
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279725; cv=none; b=WRA9CiF17TSIbRXKIU7gEefg0kxUctn+EWPud869g5DitVcA8eiD1E2asMJzyXJPWfGeVyX6yPkN0bsV5mse9GKVIudn63d4fZc+FjEC9awZiWm32Tb4c/v5VluJdnI4YKh/37xMhi9ge5WkSsdMm76OTE8GJPYSL84ORQdfbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279725; c=relaxed/simple;
	bh=KzPBgUp0P0mzFYv0Ir0TjqCpDIR8nY9XU9BVPOGWlTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU8SUPUyZCPXpUsT5ATf2a8B09w4ExoQwUwZqu7sFs0HnUqSOSg1dqUfRp+JSFGj/z0A28gvaxxzVXXqOOSLu5Vgso5ilTDKjTS/1RNeeIay+vTYn5ovc+nOJw36ehkwkCKOe3yRT8Wx6PMr1c/F+o1OnjP+CoYrqZFWOjiSALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smFG36IS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so13210a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713279722; x=1713884522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHskwCYN5DKZz6xNkCSk6vwOGj+enkiLUxIjxw7VbDk=;
        b=smFG36ISpYvULGzRZ9hx+vl8nZePAShiTo6DWXvKRwZ2mmzCAiZBGqaVc3OiJdELYb
         KXiiWLQ7OBB94+ft6NEnilEjTULFijn8dWhzj+QHMiOd66opiOo67xM0Y5mfXJWzmiay
         ULv5bQd8pZvQH28cFJ9Qcqf9DWKTOottl44XSLyqD0O0c8L0YoUH8I4EVhP5soclyCDV
         Ao+wNnVn9cRmyWFeginDm6bu5VL+D7NiIU1MrMtk2P02Ib5Tq2jwqnQG09PrcI+lCQfi
         ej2QwRMkuDYZwSKMJ/zvjzMyh37MvXERbzpGoVWeORqPvfJaKqf6v6SZXrMp0shiWr4M
         CZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279722; x=1713884522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHskwCYN5DKZz6xNkCSk6vwOGj+enkiLUxIjxw7VbDk=;
        b=p69vTwoVpbDMsDFbHY6KXVgfbqv3Ed2nG40XTBVF7Sm3ZuuTHnTnUMCeHuAVWipuaX
         E1YAAwzscHY7Y1YCHIcld2KgNAGlnu5YxnN+9hmU5TbHKRn/l8FAq6jBR53TTu+DWSgT
         o16Ysgkhv/LEDEflBdJYDajBItH54W0RQiYFqcjSYUHfGRIMN2qkghPniFfn8m9MWkMP
         fkQOJLnq5ej0BekrWNKO/4OOO5eJcXvvtzUSKGhQYOYAzxbQKQyKGfDCbht9+UFR6pq3
         S+1oUwhkhGLRCNDxJYanxsQJHZH+9pikms/1t94vvhRCtUtCAy0qCfL9Tcdsn9rALbEu
         XflQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoo8cpWZupcP24H8wFCUYYqtwjSNgXfjiSR/hL2dhKfZSghrbfyiZl5/DOU04Qp2d6FCuwYG3TaqJThNtAObQ1vLt3+SkaAABcaW3p
X-Gm-Message-State: AOJu0YyfVeedU/mcAW3jeBJS+RGjSMJXlFUWw+WWsBJBGffWSqEXRcj/
	IugkYi3ARd7bybmztgzmIGpv9ZgMoeGVNCP7ZHOY+ok6y/Z7iW3tTyvf8ZZmMo+pYMMymE2mrKe
	Ya39hPGcGQ8r83gnfc51E4MNaiT4ls5s1/l+Y
X-Google-Smtp-Source: AGHT+IG/IR4Gfj6sCIte145RGpLTj2bIn7khSBBTuC+r6b41aTYZEviPPSGHZIPosYUl1KtPMPIMSOew7ujE3ihCOxk=
X-Received: by 2002:aa7:ccd5:0:b0:570:2ec6:56b5 with SMTP id
 y21-20020aa7ccd5000000b005702ec656b5mr209810edt.4.1713279721667; Tue, 16 Apr
 2024 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415113436.3261042-1-vschneid@redhat.com> <CANn89iJYX8e_3Or9a5Q55NuQ8ZAHfYL+p_SpM0yz91sdj4HqtQ@mail.gmail.com>
 <xhsmhmspu8zlj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhmspu8zlj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 17:01:47 +0200
Message-ID: <CANn89iJRev5Kn_jEgimDfyHosmiyYeaz2gHRGS2tcFC-yMbGaQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:33=E2=80=AFPM Valentin Schneider <vschneid@redhat=
com> wrote:
>
> On 15/04/24 14:35, Eric Dumazet wrote:
> > On Mon, Apr 15, 2024 at 1:34=E2=80=AFPM Valentin Schneider <vschneid@re=
dhat.com> wrote:
> >>
> >> Hi,
> >>
> >> This is v5 of the series where the tw_timer is un-pinned to get rid of
> >> interferences in isolated CPUs setups.
> >>
> >> The first patch is a new one stemming from Jakub's bug reported. It's =
there
> >> mainly to make the reviewing a bit easier, but as it changes behaviour=
 it should
> >> be squashed with the second one.
> >>
> >> Revisions
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> v4 -> v5
> >> ++++++++
> >>
> >> o Rebased against latest Linus' tree
> >> o Converted tw_timer into a delayed work following Jakub's bug report =
on v4
> >>   http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org
> >
> > What was the issue again ?
> >
> > Please explain precisely why it was fundamentally tied to the use of
> > timers (and this was not possible to fix the issue without
> > adding work queues and more dependencies to TCP stack)
>
> In v4 I added the use of the ehash lock to serialize arming the timewait
> timer vs destroying it (inet_twsk_schedule() vs inet_twsk_deschedule_put(=
)).
>
> Unfortunately, holding a lock both in a timer callback and in the context
> in which it is destroyed is invalid. AIUI the issue is as follows:
>
>   CPUx                        CPUy
>   spin_lock(foo);
>                               <timer fires>
>                               call_timer_fn()
>                                 spin_lock(foo) // blocks
>   timer_shutdown_sync()
>     __timer_delete_sync()
>       __try_to_del_timer_sync() // looped as long as timer is running
>                        <deadlock>
>
> In our case, we had in v4:
>
>   inet_twsk_deschedule_put()
>     spin_lock(ehash_lock);
>                                           tw_timer_handler()
>                                             inet_twsk_kill()
>                                               spin_lock(ehash_lock);
>                                               __inet_twsk_kill();
>     timer_shutdown_sync(&tw->tw_timer);
>
> The fix here is to move the timer deletion to a non-timer
> context. Workqueues fit the bill, and as the tw_timer_handler() would jus=
t queue
> a work item, I converted it to a delayed_work.

I do not like this delayed work approach.

Adding more dependencies to the TCP stack is not very nice from a
maintainer point of view.

Why couldn't you call timer_shutdown_sync() before grabbing the lock ?

