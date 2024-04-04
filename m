Return-Path: <linux-kernel+bounces-131724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97288898B18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE12833CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8478129E7C;
	Thu,  4 Apr 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXAB0skP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA202C189
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244426; cv=none; b=PFh0RNKrP/+CqSK5S5twu+GryiqBFCMLLr70ZlqjsGa+gcmDdqC67cPFDykqcEZGKIxNep7AzPudptFod3DqO5j97FfrSBi4JOOo0qQgGPtf4N7am/xaAMnzmyTkmplM99gxBIL1eTxtzuco0gfOS6Sd1lLzvAPZQNN7vXhEMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244426; c=relaxed/simple;
	bh=p5Op0dT9T/tw0pGCFGKEF1A6U7RmXYiaja1POYeAK80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgaW85VPvM9OnOkk5prtqmLXes1fpwAoEXla6Gimr2BQFPv+67Jr/IWOT7RCrkDrHu2s3XaLw7g+Xs0b30d23T77jWR0Bi16zjMiXWCWutIZOpqZcU+FPi1kIoOyaO5nhhtMoBxAVvJRZdoHV3LsoroTeo3jzB8vtKaYXMdrTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXAB0skP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712244424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsXAvRQjzL1CZKVA+ILugHBX9nT/LmlG2bAHBvIYHjk=;
	b=DXAB0skPsCZgFJ0EIIgyv9Hf+hIuHEUInU3DPf/X3ioZ1Yh2bhjAdKwGAEzNDkbE/aqYjm
	YxiCeJ0dVKXlY/4xN1qjd04EAabl9A3yKj8R5faT+eHt2ZLKB8tUugzwSVjdlpppj7OPJ4
	SZtvtO6fVYiTeT/Ix/6M19mlgeL9kl8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-mtUq3XY8OAGJUmfkIDlxeA-1; Thu, 04 Apr 2024 11:27:03 -0400
X-MC-Unique: mtUq3XY8OAGJUmfkIDlxeA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4943e972d1so228114466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712244422; x=1712849222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsXAvRQjzL1CZKVA+ILugHBX9nT/LmlG2bAHBvIYHjk=;
        b=dOmCrERA2XdjWGu7fcfVrLFumd0n/IR4+TU23OUci3qOhRqClBYBDUwQAbV/2WF0CP
         upJJ6W49nYiazLXtGXbF4FsuXbIsuhmW2HFvrjX/WoYOUbYehsN5UHQA0VzNVGninlmh
         j8ZNTQW7gOAeHNaPrdHB64yrRrE6ifxVoqN2XVSesaEbK29Z9AsLOihjxYOUuiZem/gG
         JOOmMe3/cbzXX69dRN9angBeKIt0ApEAWthJnuRjsTJmEuxnxqkWkojdXSwpyq36tzbM
         KDR4bDPCe6qzn3qePKLI48RbXhomdVbYZ3GAxe0JdbLPJjKOinEaRdnWyHfl13xjfOrU
         PhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkrtNUvIo+gtiWdjGudAART31SzOEgECyF0S25iix5OCg66ONx8EqcpxVKDlL5x6LSs4Xiyv4vBaDiGmyLUrg0EDAOisz6vsukk0/0
X-Gm-Message-State: AOJu0Yy/hV9n7ccIyK0wvAFg0bsCAgAfantnhRC7YOQy/6VwcbkSOgWm
	YREtQymES6jNUk/pGXMEHd9mYAW40I12qp+3InxCJGE9NyfkTZRXe8Ml0mZwRWapKpUe+vrduhu
	R7NvjTGVoqezWmauiG8shOqBdflIJMvRhJS5KKUFDiIWd/GftN5Hztdaw+BH3WCtuPDwkznjJ2t
	N6NPNxpVj0xr9FKagTcolWIQjddjoorOdpkRuM
X-Received: by 2002:a17:907:94c4:b0:a4e:3841:8da9 with SMTP id dn4-20020a17090794c400b00a4e38418da9mr3266379ejc.23.1712244421922;
        Thu, 04 Apr 2024 08:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ7jPqOWCB3d3Iy2AeUwALn5EKfnv/g4O/tPlYiI57t02Gld3VS7+0r/rVl4x/Vm+ncAGUllSHTfWvxHVsOK0=
X-Received: by 2002:a17:907:94c4:b0:a4e:3841:8da9 with SMTP id
 dn4-20020a17090794c400b00a4e38418da9mr3266348ejc.23.1712244421504; Thu, 04
 Apr 2024 08:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
 <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
 <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com> <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
In-Reply-To: <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 4 Apr 2024 17:26:49 +0200
Message-ID: <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 6:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 11:50=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 10:02=E2=80=AFAM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > > > >                 goto out;
> > > > > >         }
> > > > > > +       spin_lock(&t->sleepable_lock);
> > > > > >         drop_prog_refcnt(t);
> > > > > > +       spin_unlock(&t->sleepable_lock);
> > > > >
> > > > > this also looks odd.
> > > >
> > > > I basically need to protect "t->prog =3D NULL;" from happening whil=
e
> > > > bpf_timer_work_cb is setting up the bpf program to be run.
> > >
> > > Ok. I think I understand the race you're trying to fix.
> > > The bpf_timer_cancel_and_free() is doing
> > > cancel_work()
> > > and proceeds with
> > > kfree_rcu(t, rcu);
> > >
> > > That's the only race and these extra locks don't help.


Thanks a lot for pinpointing the location of the race. Indeed, when I
read your email this morning I said "of course, this was obvious" :(

>
> > >
> > > The t->prog =3D NULL is nothing to worry about.
> > > The bpf_timer_work_cb() might still see callback_fn =3D=3D NULL
> > > "when it's being setup" and it's ok.
> > > These locks don't help that.
> > >
> > > I suggest to drop sleepable_lock everywhere.
> > > READ_ONCE of callback_fn in bpf_timer_work_cb() is enough.
> > > Add rcu_read_lock_trace() before calling bpf prog.
> > >
> > > The race to fix is above 'cancel_work + kfree_rcu'
> > > since kfree_rcu might free 'struct bpf_hrtimer *t'
> > > while the work is pending and work_queue internal
> > > logic might UAF struct work_struct work.
> > > By the time it may luckily enter bpf_timer_work_cb() it's too late.
> > > The argument 'struct work_struct *work' might already be freed.
> > >
> > > To fix this problem, how about the following:
> > > don't call kfree_rcu and instead queue the work to free it.
> > > After cancel_work(&t->work); the work_struct can be reused.
> > > So set it up to call "freeing callback" and do
> > > schedule_work(&t->work);
> > >
> > > There is a big assumption here that new work won't be
> > > executed before cancelled work completes.
> > > Need to check with wq experts.
> > >
> > > Another approach is to do something smart with
> > > cancel_work() return code.
> > > If it returns true set a flag inside bpf_hrtimer and
> > > make bpf_timer_work_cb() free(t) after bpf prog finishes.
> >
> > Looking through wq code... I think I have to correct myself.
> > cancel_work and immediate free is probably fine from wq pov.
> > It has this comment:
> >         worker->current_func(work);
> >         /*
> >          * While we must be careful to not use "work" after this, the t=
race
> >          * point will only record its address.
> >          */
> >         trace_workqueue_execute_end(work, worker->current_func);
> >
> > the bpf_timer_work_cb() might still be running bpf prog.
> > So it shouldn't touch 'struct bpf_hrtimer *t' after bpf prog returns,
> > since kfree_rcu(t, rcu); could have freed it by then.
> > There is also this code in net/rxrpc/rxperf.c
> >         cancel_work(&call->work);
> >         kfree(call);
>
> Correction to correction.
> Above piece in rxrpc is buggy.
> The following race is possible:
> cpu 0
> process_one_work()
> set_work_pool_and_clear_pending(work, pool->id, 0);
>
>     cpu 1
>     cancel_work()
>     kfree_rcu(work)
>
> worker->current_func(work);
>
> Here 'work' is a pointer to freed memory.
> Though wq code will not be touching it, callback will UAF.
>
> Also what I proposed earlier as:
> INIT_WORK(A); schedule_work(); cancel_work(); INIT_WORK(B); schedule_work=
();
> won't guarantee the ordering.
> Since the callback function is different,
> find_worker_executing_work() will consider it a separate work item.
>
> Another option is to to keep bpf_timer_work_cb callback
> and add a 'bool free_me;' to struct bpf_hrtimer
> and let the callback free it.
> But it's also racy.
> cancel_work() may return false, though worker->current_func(work)
> wasn't called yet.
> So we cannot set 'free_me' in bpf_timer_cancel_and_free()
> in race free maner.
>
> After brainstorming with Tejun it seems the best is to use
> another work_struct to call a different callback and do
> cancel_work_sync() there.

Works for me. I should be able to spina v6 soon enough, but I have a
couple of remaining questions below:

>
> So we need something like:
>
> struct bpf_hrtimer {
>   union {
>     struct hrtimer timer;
> +   struct work_struct work;
>   };
>   struct bpf_map *map;
>   struct bpf_prog *prog;
>   void __rcu *callback_fn;
>   void *value;
>   union {

Are you sure we need an union here? If we get to call kfree_rcu() we
need to have both struct rcu_head and sync_work, not one or the other.

>     struct rcu_head rcu;
> +   struct work_struct sync_work;
>   };
> + u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPABLE

If I understand, you want BPF_F_TIMER_SLEEPABLE in bpf_timer_init()
(like in my v2 or v3 IIRC). But that means that once a timer is
initialized it needs to be of one or the other type (especially true
with the first union in this struct).

So should we reject during run time bpf_timer_set_callback() for
sleepable timers and only allow bpf_timer_set_sleepable_cb() for
those? (and the invert in the other case).

This version of the patch allows for one timer to be used as softIRQ
or WQ, depending on the timer_set_callback that is used. But it might
be simpler for the kfree_rcu race to define the bpf_timer to be of one
kind, so we are sure to call the correct kfree method.

>  };
>
> 'work' will be used to call bpf_timer_work_cb.
> 'sync_work' will be used to call cancel_work_sync() + kfree_rcu().
>
> And, of course,
> schedule_work(&t->sync_work); from bpf_timer_cancel_and_free()
> instead of kfree_rcu.
>

Cheers,
Benjamin


