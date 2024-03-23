Return-Path: <linux-kernel+bounces-112173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8C88768B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AFD1F22819
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3173D9E;
	Sat, 23 Mar 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Th2/ZZP5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF1EC2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159337; cv=none; b=rEjLpYBYI799pHHewa6Qn//RcMm8h6vmAswouFh0t94d3Dy4eZzlVUTvIxBqQlWjbzMyGkH5fJYMTwfr6DNenShRwyJAPROuR8f6qhTC1BN2Rnp6oJ0I3VRs847QGPo7yhcjKlT4vNT1wElsvDuzwZGJ00qy5aFKs3kbg8hc5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159337; c=relaxed/simple;
	bh=kjQK/ZXJeuufuWKUqTmtrVb3RiT09PzKuAhVluGT+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIJDiLrLQVtIDrKN2W5DdQujjwDABYxv4RqaH3fGglE3ledR5Fg1eYWo09SYXQscQX4hR39uAoMm+b0tXAWYuPmc2QwI0FgV5HC/AWaq9SqTOc8GyzAo0PLNgevCq+KUQsQairMdG0j+0Pqk8e15Sn7Q6dvcjHNRbRnDiZ6LML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Th2/ZZP5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso3309890a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711159334; x=1711764134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=Th2/ZZP5sfW7yYwdEB9kKPKe2ZEgP8l3WruK+7IkwBzFdPxlX/g+SVdYemdVtDjFyC
         2zZEePDIChlyKqGtSPF3yvm3NEEPdmvB48Z/IvmClr4xwUYaV/XZpPe/h0VebglO1oJj
         ZycMb+zFvakcYLLGYpuKKRitAOBIUz72AqkDIow9zt1L6rkIT+VKxmo/9GaUoPB6brsR
         CYdcZHZV8T8v5yOPHJjeKKSYZCtx0UuMh4rC5MZUAFcAHh8JWBs1aOyNPNX6fy6xDJbS
         wWKBtzZVeClTa0PduraQBpY40SqZlMIPsygl48/86za6Gd7btjQC9xmtXoLv2nMivwUc
         U4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159334; x=1711764134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=h0qlCtAZN2qposIsdX7sA1CzONEpNkm0dy3xl4ipa/mV5DmRys4gDAB7J/Ibtcumlc
         H1QPO01my3vF/qUv5aSy5XEGgiVSogd8qtigovbbOxasMuZ0wp9i8hrt3uHSvF+C1nnZ
         /ZYsuzle+i6e3GEh/e+QfB6VCIi+0ayQPPa/YgPRPAAPJmbO+jwPVP3dSxzmBBz44sSn
         YgJ+MV9iSoNH7Y0F2rC6HS0yGpWR+Sg/Kt42kTnIwUwLiR1aXiv6JmTKVsfyo6ANrCA5
         8Tow+j/iRF/Mks3ORJhwBJeX76XmRW5sCuJFgrp7NU29LhnmB3BmYAp2FUbm6zsjYclY
         aj2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcf3s/Lww/l7KaLj2PGt2102aWfarFLca2wlOvQyeD/oI7N3tKOLTgduG4JVLy+3E2wJboWL/Y6Q3BqaPLWz7v+hSe3zZtaHcUmKGz
X-Gm-Message-State: AOJu0Yxd/3fmb2shwy8A0gYdLHnVyikZ0lHdRp8q9SRqtXMTSyvK2iqU
	dkTuPz+5/YqVwk5o8MaxnlkxtDTu//6hCyJ+Ko16IVRxKZYD4iie4FK2L6/IOVCVvwJa9LqzcNy
	qyh6ippWYv83MObnmNl7y2OqheaZGvGcqIUr03A==
X-Google-Smtp-Source: AGHT+IFilYtLpWhQMZrvvCHnCL+cWrm27JI38D0QFqame+iNQqNKz8aOz9QXGy0lw2uDZ/Nj6Ill05uOw4ImUyjck/s=
X-Received: by 2002:a17:906:81c8:b0:a46:a712:3972 with SMTP id
 e8-20020a17090681c800b00a46a7123972mr797745ejx.11.1711159334004; Fri, 22 Mar
 2024 19:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710877680.git.yan@cloudflare.com> <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de> <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
In-Reply-To: <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 22 Mar 2024 21:02:02 -0500
Message-ID: <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	Joel Fernandes <joel@joelfernandes.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT ker=
nels would
> > > + * have more chance to invoke schedule() calls and provide necessary=
 quiescent
> > > + * states. As a contrast, calling cond_resched() only won't achieve =
the same
> > > + * effect because cond_resched() does not provide RCU-Tasks quiescen=
t states.
> > > + */
> >
> > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > Why does RT have more scheduling points?
>
> In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> RCU Tasks.
>
By "more chance to invoke schedule()", my thought was that
cond_resched becomes no op on RT or PREEMPT kernel. So it will not
call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
normal irq exit like timer, when NEED_RESCHED is on,
schedule()/__schedule(0) can be called time by time then.
__schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.

But I think this code comment does not take into account frequent
preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
When returning to these busy kthreads, irqentry_exit_cond_resched is
in fact called now, not schedule(). So likely __schedule(PREEMPT) is
still called frequently, or even more frequently. So the code comment
looks incorrect on the RT argument part. We probably should remove the
"IS_ENABLED" condition really. Paul and Sebastian, does this sound
reasonable to you?

Yan

