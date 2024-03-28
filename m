Return-Path: <linux-kernel+bounces-122242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A888F42F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7CD295160
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66828DB3;
	Thu, 28 Mar 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzMKjw6D"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861619479;
	Thu, 28 Mar 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586751; cv=none; b=Ua8Ywi8ScUwa1VfPEWWVnAt/pZztzwZq+ckFig4ylLnlqimjnkQg3K8MdMcV4xH+im9Ujl1AotskxV31pbJMgm6+uyIKHjx9aCLFMgf3ppWVZ7irJCXqPXye0dRCeVkRJi7qz+zSp58HsiTg9aIZEYsjKGQ1nao/k/fMEeCRjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586751; c=relaxed/simple;
	bh=ZT60A2mwFpyTdyfb6cjW6OdhzBClWNMVq24Fogaaf3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAE69v16QRBUzrCpEXBlaeqGRfK6KuQgLvt8feMG38w3/VhIa8Iv1c8t8L6maDb/fPP7e+JAzCYhcI/AM+HTSGHQB0zc6L4vabgQqQslQUYbskBi5U9IyWp2CaFDQyMoicaIfpn9X6/MnDUD+w3a0xzA7HBpgyp/8xEn7hO4yEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzMKjw6D; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ead4093f85so441637b3a.3;
        Wed, 27 Mar 2024 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711586749; x=1712191549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jgFg7/Se2gP2Slxoyf+gmLzNt05ZQGYEDydGAiD2AQ=;
        b=mzMKjw6D65a3hEv1u9ZdTZn9hxzuPqIdcYE+D69/o6bbHzcv0fdSgDm/lgGwfrRc0G
         FInWA0yBch+DyTQIjX8gATsToOJ8BlTyco/e9epKfB4asY4VE19hNWk+dPs//Wn18RSp
         zcqkh/2gCA9bSQw+c/OHcSCuljXAtG2Jicdbekov+CnqecOAkLJeBqLnFJA49ExJIRSB
         lAM/1/womCprSyOWUcvGQhQVKCEKOiI1fMm0m87cepVEOxK8dzQQY5F8k0ha3fvyeVRe
         q0wt/sbK4WEA9Q95ukFDSizoLZAkFP8vE9ITZdyIdgl+G1/FX6Z4n+9zNwL6CUVTJWDf
         zi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586749; x=1712191549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jgFg7/Se2gP2Slxoyf+gmLzNt05ZQGYEDydGAiD2AQ=;
        b=IhdrpNekCgLHteD8vP4iGVkhwsRF5sEC0ci6WtrMT6FhAejF73hUK2AMEgXUF1IQeV
         5Evk5vtliVhTiU66Doxs/rxJmEjug/mCAxV0+qQDnqXrsG1udrZ3Y+wC5wy/dDrcFFLP
         I2A/ufyKg4f3boNdFmBYqTRRVdEkYiLqK42ZSjtSaUPo51Xbwzs5E+si9m1EznK8n585
         aQQckEOmKNSxL/wAR+TBefaT02hSxqFhWB+jvhzT4VD+QIilmKqLfUfnZZy/E7OrISh2
         VV3a69iVyMvpZLpF/gBgsJh9xH3o7HmmNUftlZL0KiwIjJb5Sh7qFW9VCFIvbJW2NV+l
         nsUA==
X-Forwarded-Encrypted: i=1; AJvYcCWXK5lRu6NzdpXeqBP0db+MLBxvkjiBzI5IOLY5pVz3XFCmeAWNGIMP9c/qFKp/WlJ/a4j8TJjOp4j6U+bDMbIipPiksiLMr7Lc24673F/MLepP5q/WiZPJSwaWd+YMZ88gQAhQ2PmNkeAxInxcATJXaoNPyg/EhIO0mvgt7k85wjE8CxalDiHMACrV8RfzLb1+ggFXKwTBwCC7qP8XPVyNfKAap4C0sw==
X-Gm-Message-State: AOJu0YwyjmPq8qz6sgcwlBrfRTIvaq25qyI9c7Ur56v1Pnx2czMVhBnI
	A6KUkh8eeqb4/+6WglDJcy7OUf8LZIYHp6GuUfrn9aPJPQwWJs2XsDM5KxlhPv6qJqpmewMCw+t
	sdhZO0mm8hYjdQ21B3NSPUiarufw=
X-Google-Smtp-Source: AGHT+IFlKICW8fz6iHVeO34uBd3ttW60uqKrvw2Bvh9gRLxr0htA6R2XTOfaVpcr13VrMRzeVaXelEnyPNY9lvIUoZg=
X-Received: by 2002:a05:6a20:af14:b0:1a3:67cb:f7c4 with SMTP id
 dr20-20020a056a20af1400b001a367cbf7c4mr1323907pzb.34.1711586748531; Wed, 27
 Mar 2024 17:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org> <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org> <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
 <20240328091841.ce9cc613db375536de843cfb@kernel.org>
In-Reply-To: <20240328091841.ce9cc613db375536de843cfb@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 17:45:36 -0700
Message-ID: <CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonthan Haslam <jonathan.haslam@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:18=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 27 Mar 2024 17:06:01 +0000
> Jonthan Haslam <jonathan.haslam@gmail.com> wrote:
>
> > > > Masami,
> > > >
> > > > Given the discussion around per-cpu rw semaphore and need for
> > > > (internal) batched attachment API for uprobes, do you think you can
> > > > apply this patch as is for now? We can then gain initial improvemen=
ts
> > > > in scalability that are also easy to backport, and Jonathan will wo=
rk
> > > > on a more complete solution based on per-cpu RW semaphore, as
> > > > suggested by Ingo.
> > >
> > > Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> > > I would like to wait for the next version.
> >
> > My initial tests show a nice improvement on the over RW spinlocks but
> > significant regression in acquiring a write lock. I've got a few days
> > vacation over Easter but I'll aim to get some more formalised results o=
ut
> > to the thread toward the end of next week.
>
> As far as the write lock is only on the cold path, I think you can choose
> per-cpu RW semaphore. Since it does not do busy wait, the total system
> performance impact will be small.

No, Masami, unfortunately it's not as simple. In BPF we have BPF
multi-uprobe, which can be used to attach to thousands of user
functions. It currently creates one uprobe at a time, as we don't
really have a batched API. If each such uprobe registration will now
take a (relatively) long time, when multiplied by number of attach-to
user functions, it will be a horrible regression in terms of
attachment/detachment performance.

So when we switch to per-CPU rw semaphore, we'll need to provide an
internal batch uprobe attach/detach API to make sure that attaching to
multiple uprobes is still fast.

Which is why I was asking to land this patch as is, as it relieves the
scalability pains in production and is easy to backport to old
kernels. And then we can work on batched APIs and switch to per-CPU rw
semaphore.

So I hope you can reconsider and accept improvements in this patch,
while Jonathan will keep working on even better final solution.
Thanks!

> I look forward to your formalized results :)
>
> Thank you,
>
> >
> > Jon.
> >
> > >
> > > Thank you,
> > >
> > > >
> > > > >
> > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > will depend on how much lock contention happens.
> > > > >
> > > > > Thank you,
> > > > >
> > > > > >
> > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > >
> > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > ---
> > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > --- a/kernel/events/uprobes.c
> > > > > > +++ b/kernel/events/uprobes.c
> > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree =3D RB_ROO=
T;
> > > > > >   */
> > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > >
> > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtr=
ee access */
> > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtr=
ee access */
> > > > > >
> > > > > >  #define UPROBES_HASH_SZ      13
> > > > > >  /* serialize uprobe->pending_list */
> > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct in=
ode *inode, loff_t offset)
> > > > > >  {
> > > > > >       struct uprobe *uprobe;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       uprobe =3D __find_uprobe(inode, offset);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return uprobe;
> > > > > >  }
> > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct =
uprobe *uprobe)
> > > > > >  {
> > > > > >       struct uprobe *u;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     write_lock(&uprobes_treelock);
> > > > > >       u =3D __insert_uprobe(uprobe);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     write_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return u;
> > > > > >  }
> > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *up=
robe)
> > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > >               return;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     write_lock(&uprobes_treelock);
> > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     write_unlock(&uprobes_treelock);
> > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active(=
) */
> > > > > >       put_uprobe(uprobe);
> > > > > >  }
> > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode=
 *inode,
> > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > >       max =3D min + (end - start) - 1;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > >       if (n) {
> > > > > >               for (t =3D n; t; t =3D rb_prev(t)) {
> > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode=
 *inode,
> > > > > >                       get_uprobe(u);
> > > > > >               }
> > > > > >       }
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >  }
> > > > > >
> > > > > >  /* @vma contains reference counter, not the probed instruction=
 */
> > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vm=
a, unsigned long start, unsigned long e
> > > > > >       min =3D vaddr_to_offset(vma, start);
> > > > > >       max =3D min + (end - start) - 1;
> > > > > >
> > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > +     read_lock(&uprobes_treelock);
> > > > > >       n =3D find_node_in_range(inode, min, max);
> > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > +     read_unlock(&uprobes_treelock);
> > > > > >
> > > > > >       return !!n;
> > > > > >  }
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

