Return-Path: <linux-kernel+bounces-99640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFC878B08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833432823BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DA58AAB;
	Mon, 11 Mar 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SP5Rpl6c"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5959157
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197910; cv=none; b=Fr4gc9KgI8zWgIUUv3gbk9XB7LwRT0Vxr94FmrDz6aOWz3zfDq/1IDmzLef+QYiGNA29OZenLtFR4vPQ+khYsJyfK+RFwJQzrOILrCHCBMuQkbcaeQKgy+eA/DcabThUVD9Epwf1gpE2pq6wdHT8qm/G2YuuQIeij7B0PMJQ1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197910; c=relaxed/simple;
	bh=Sy2ja+oWY4kLIoimKcOlUaKukJLyATY5SDDnWhA91Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC1aErXHhNTGEYAW2DL4PA7gac3cAgmtypmmxesrI41a2o+Vv+FlzwCSagxo2v3UIRtcK3c8a1r015mpcNI8MWtKl5y1rS9pm58GtHJ1t2IB+zhZwdvuuXLQxG+Pp2ttezFUwQUK7Hiepglnsz0CS/v8psIBmsAZccBYgbyfJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SP5Rpl6c; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so6305233a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710197907; x=1710802707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZU1Phb/CtBsFoY7di9Z4tKqixjDqwCWx89567ciR4U=;
        b=SP5Rpl6czg4AU2txJ9pwoUIX+jKaWyTESCU8zziCpmLg+9os4JbkywPsfiptOmsE41
         029+WB3JRQYltxioUHSXUIPGpDqv6LS2+PG1soznW2JfpV96EjfGnnzZzhcX32+gHYTo
         M3HX78zmlGi2YrAZhv9a318L7vrIRrkom9wKuw0MK1EWC/yl9rjFYIvNrBA3RvgUN7m4
         UX6bs5d8pA+o3VT2hffvfjZYRGBG/ScKy1aI2B9aEAE8UH1BZRx8S/zTp9nZohsb+gGQ
         wPZBsijOHwmHJWmVSgeKpWvs+gw9dgEtQ3qzYK6EZ1piU5acpGjVdZt5dGaENkWC/1QT
         0ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197907; x=1710802707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZU1Phb/CtBsFoY7di9Z4tKqixjDqwCWx89567ciR4U=;
        b=Sil4qJj8EUJNzsyYf4Z/0c8thYagf6BACfPgqOU+1JeFuUlYerqDLuQK0ynNNfQN7g
         J95YQwoA1j/dlumGpoPvZ6tGKG2KDuovZBZZ2gjMglwgUbODIIIWU4mdDBBTHwcCeLDq
         mZ9YorKl7Odyzs6H+ny0FGyCHMflY5DTJUk0xRC2YtWb8QM3aNkUqZ5eig3/+wN1R/lr
         cmrKllTi37ncl5DB0Qf8oDlxgAfcHyRPwyj+XzLAs1df437oLnIsnKheJHp8QO4f4Cgw
         heGjcq3USgoTQkANemuAusf5UGi1vhTfr6bh5MkQolpBGIIrXmKoy7KzymA0lBi+aHHm
         ND9A==
X-Forwarded-Encrypted: i=1; AJvYcCXnGZC0ARq0hzw1KUmYP0aljKNAfYCqyyIW6Tz9a52jafZq6C6MccN4SqprHWueIWTALLxFNJYqxB16b91WyqeE1GmQp2pPByDv4xGj
X-Gm-Message-State: AOJu0YwphilzOQtnYeUd1EGyhDZUu9/ozVuJ3zInhzOtrg4uFg2ThuS4
	adyXIqmnwRoHni5E7sHAzzri/3Vloo7fCCMoRCZCOs6XnUisGeu8b8jE5vhkvh9K961qQRebREc
	b5VBR7yxQYGehZuzlXv9cY8rogsI2BSsn4o82CQ==
X-Google-Smtp-Source: AGHT+IGITjDbeDqDL56Vs6ZKVYZbv/7Re4zuMWjQ1QwBopqmSC3CV4Fh/8ykwO7zXo4qD39wARjuqm67gf/TwkPnlqE=
X-Received: by 2002:a50:cccb:0:b0:566:a235:9355 with SMTP id
 b11-20020a50cccb000000b00566a2359355mr1211898edj.33.1710197907206; Mon, 11
 Mar 2024 15:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
 <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com> <ed57b5fa-8b44-48de-904e-fe8da1939292@paulmck-laptop>
In-Reply-To: <ed57b5fa-8b44-48de-904e-fe8da1939292@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 11 Mar 2024 17:58:16 -0500
Message-ID: <CAO3-Pbp0Pxbbgmjf03wKo6MDrQYE7uiL+mUnheT9UA9Pjj5bUQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Mar 01, 2024 at 11:30:29AM -0600, Yan Zhai wrote:
> > Hi Eric,
> >
> > On Fri, Mar 1, 2024 at 2:30=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > I could not see the reason for 1sec (HZ) delays.
> > >
> > > Would calling rcu_softirq_qs() every ~10ms instead be a serious issue=
 ?
> > >
> > The trouble scenarios are often when we need to detach an ad-hoc BPF
> > tracing program, or restart a monitoring service. It is fine as long
> > as they do not block for 10+ seconds or even completely stall under
> > heavy traffic. Raising a QS every few ms or HZ both work in such
> > cases.
> >
> > > In anycase, if this all about rcu_tasks, I would prefer using a macro
> > > defined in kernel/rcu/tasks.h
> > > instead of having a hidden constant in a networking core function.
> >
> > Paul E. McKenney was suggesting either current form or
> >
> >          local_bh_enable();
> >          if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >                  rcu_softirq_qs_enable(local_bh_enable());
> >          else
> >                  local_bh_enable();
> >
> > With an interval it might have to be
> > "rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
> > unnecessary extern/static var. Will it make more sense to you?
>
> I was thinking in terms of something like this (untested):
>
>         #define rcu_softirq_qs_enable(enable_stmt, oldj) \
>         do { \
>                 if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
>                     time_after(oldj + HZ / 10, jiffies) { \
>                         rcu_softirq_qs(); \
>                         (oldj) =3D jiffies; \
>                 } \
>                 do  { enable_stmt; } while (0) \
>         } while (0)
>
> Then the call could be "rcu_softirq_qs_enable(local_bh_enable(), last_qs)=
",
> where last_qs is initialized by the caller to jiffies.
>
> The reason for putting "enable_stmt;" into anothor do-while loop is
> in case someone typos an "else" as the first part of the "enable_stmt"
> argument.
>
> Would that work?
>
Thanks Paul, just got time to continue this thread as I was
travelling. I think it is probably better to move
preempt_disable/enable into the macro to avoid the friction. And also
since this can affect NAPI thread, NAPI busy loop and XDP cpu map
thread (+Jesper who reminded me about this), let me send a v3 later to
cover all of those places.

Yan


>                                                         Thanx, Paul

