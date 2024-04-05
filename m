Return-Path: <linux-kernel+bounces-133283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F0689A1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D50C1F2348A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90D17106A;
	Fri,  5 Apr 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdT1INvk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275516FF3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332008; cv=none; b=sIvRUWCl0vEwihKL5bOTkTzLV3Y1xkS0M9c4qTqkrIpLElo4QOK/UViiS/mvilMGGys2bSuvzAFx0Y8LMxWaITqCJsL3prLabvgVEA7XCEXuhvH29BopqWMfbSt5aSHAdIBixs1eu0D+qvXPjBYvULmtdygBSmd5fL1c1WNSaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332008; c=relaxed/simple;
	bh=+sYP6mSovvQVh5eaZ4COqHW52CnVHRQXjI7rvGpQ3zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ju1EaIItrjQZ6ArA1HV48YQURFyaDqLRFbbADtmQCI9GytErXSG5QD0sgR7K6a5IsTecQ5DpKub4mHv+Xe7DGgrot5NVi1mfndmW9W88I0aGvSdfKv7JJR+SVT0qrTgX8Pba4fe6sj1q+RD9Wa/CAvBPi2N2oJRY5hKwIAHweSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdT1INvk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712332005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrx4EfBLw5fhhjyFFx6WbCnhxWaGw01fsd0qggFmp/8=;
	b=TdT1INvkO4/bMUbU67X7GlWaEYmvtAYGGbpbN2k28F5n3xSkG5eFqOeKScn7fff7GL5R7n
	HGbEWwpwPvzIl7MpAdLCFyykJ8wYBigSHpQexY+FOzgVZsNfKd3j/yNarJCv6XV8ElIJS1
	JxtBIHj1Be/pZhk6B21884Znpe4Uj5o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-ILwd87wEN2ONWmU8rZcAVQ-1; Fri, 05 Apr 2024 11:46:43 -0400
X-MC-Unique: ILwd87wEN2ONWmU8rZcAVQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516c8697daaso1843216e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332002; x=1712936802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrx4EfBLw5fhhjyFFx6WbCnhxWaGw01fsd0qggFmp/8=;
        b=xA4XNAEAjhEbAjn/XsMPBkw25/lfgBuaxqQfCF3tlrgTufkMZv4Ey6Jzo3N5g2aw82
         tknewp5IZqYSPgcmUBxA3Jg2jBOZsG0uaMxx74Y8FLvOBVt//VvknDCfqy+DUsnbiIyi
         eSD7PvLwONCWRXiC9EjVkbdaWIiSk97T/rbBEBLNhL62UEV1XQHQimwAaluZNBDSWDKI
         xdo3cufLPrjir60lDtlIEL3w+KETe0K8TDFBgI9V+9btqDDW19o4EV/3FlqndvMgkX5h
         3h2zDVgZKnfa1sP7FKJfBndJ77ekdCM65E8B43R7i8/ufVU2IaMmChavErMQgv3Yts94
         gYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWodYAKB4YJghvygk31ewS5F7tGDNy1yIGDxowf2z0TjVGpV5t1dPHY8NLaGsryQzDKivni22Nn4MdetquPUbn2UddH7YDTNg6L1ueF
X-Gm-Message-State: AOJu0Yw27Adje8+2fouG0rfLgX8E2hQaMNV0W7lJvm5rbsAJHg8ONjvZ
	jzPNS4Hhu5eKf9sxzl4q9y/P9M1aQGK7jgtWU08ggv9dbGOkENiCn6EkCM3Fjon4QkK4sVX46iB
	No43gpT9aIQGcb2X4I4NovVgIMIC1Iee+0bcxgjMD6ajyNXGms1vsIAacvjdgjiIKJb5cUQV5Wl
	6WVmAGrJs2E83DrNfwMM7wvC8mtEH243Jn2C+o
X-Received: by 2002:a19:8c45:0:b0:516:cdde:aaa1 with SMTP id i5-20020a198c45000000b00516cddeaaa1mr1281275lfj.18.1712332002037;
        Fri, 05 Apr 2024 08:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh4pJSuAwCjGQTJAiCZbb/yJxIGSoz8CFL2yXksKsLcpPujsolyz6Y8DXg/AcLvUwER3wGdxH6GwEY5AWIbh0=
X-Received: by 2002:a19:8c45:0:b0:516:cdde:aaa1 with SMTP id
 i5-20020a198c45000000b00516cddeaaa1mr1281263lfj.18.1712332001553; Fri, 05 Apr
 2024 08:46:41 -0700 (PDT)
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
 <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
 <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
 <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
 <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com>
 <CAO-hwJLz4ET8Rba-_8icR+7t9T63BPnf97JrSFjviJWG+i8dVQ@mail.gmail.com> <CAADnVQ+MSqf1=FesorSxT63Qh83+4W79HX3HDyOWupajk_rTHg@mail.gmail.com>
In-Reply-To: <CAADnVQ+MSqf1=FesorSxT63Qh83+4W79HX3HDyOWupajk_rTHg@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 5 Apr 2024 17:46:29 +0200
Message-ID: <CAO-hwJJmb3f7y39YqFrt9K0rUdab8ERvA9sU3kNz1qUj7_=BfA@mail.gmail.com>
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

On Thu, Apr 4, 2024 at 8:29=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 10:56=E2=80=AFAM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Thu, Apr 4, 2024 at 6:41=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 4, 2024 at 8:27=E2=80=AFAM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > >
> > > > >
> > > > > So we need something like:
> > > > >
> > > > > struct bpf_hrtimer {
> > > > >   union {
> > > > >     struct hrtimer timer;
> > > > > +   struct work_struct work;
> > > > >   };
> > > > >   struct bpf_map *map;
> > > > >   struct bpf_prog *prog;
> > > > >   void __rcu *callback_fn;
> > > > >   void *value;
> > > > >   union {
> > > >
> > > > Are you sure we need an union here? If we get to call kfree_rcu() w=
e
> > > > need to have both struct rcu_head and sync_work, not one or the oth=
er.
> > >
> > > why? with an extra flag it's one or the other.
> > > In bpf_timer_cancel_and_free()
> > > if (flag & SLEEPABLE) {
> > >     schedule_work() to cancel_work_sync + kfree_rcu
> > > } else {
> > >    hrtimer_cancel
> > >    kfree_rcu
> > > }
> >
> > I thought kfree_rcu required struct rcu_head, and given that we need
> > to initialize sync_work it will be poisoned...
>
> yes. It needs rcu_head.
> But where do you see a conflict?
> INIT_WORK + schedule_work() will use that space,
> then cancel_work_sync() will wait on a different work_struct,
> then kfree_rcu() will reuse that space.

Yeah, sorry, I haven't realized that the memory used by kfree_rcu
wasn't initialized.

>
> In case of hrtimers none of the work_structs will be used.
>
> >
> > >
> > > > >     struct rcu_head rcu;
> > > > > +   struct work_struct sync_work;
> > > > >   };
> > > > > + u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPAB=
LE
> > > >
> > > > If I understand, you want BPF_F_TIMER_SLEEPABLE in bpf_timer_init()
> > > > (like in my v2 or v3 IIRC). But that means that once a timer is
> > > > initialized it needs to be of one or the other type (especially tru=
e
> > > > with the first union in this struct).
> > >
> > > yes. That's an idea.
> > > The code to support wq vs timer seems to be diverging more
> > > than what we expected initially.
> > > It seems cleaner to set it as init time and enforce in
> > > other helpers.
> >
> > OK, works for me.
> >
> > >
> > > Also with two work_struct-s we're pushing the sizeof(bpf_hrtimer)
> > > too far.
> > > It's already at 112 bytes and some people use bpf_timer per flow.
> > > So potentially millions of such timers.
> > > Adding extra sizeof(struct work_struct)=3D32 * 2 that won't be
> > > used is too much.
> > > Note that sizeof(struct hrtimer)=3D64, so unions make everything
> > > fit nicely.
> >
> > Maybe we should do
> > union {
> >   struct hrtimer timer;
> >   struct {
> >     struct work_struct work;
> >     struct work_struct sync_work;
> >   }
> > }
>
> It's also ok, but sharing rcu_head and work_struct seems
> cleaner, since it highlights that they're exclusive.
>
> > (not nice to read but at least we don't change the size at the beginnin=
g)
> >
> > >
> > > > So should we reject during run time bpf_timer_set_callback() for
> > > > sleepable timers and only allow bpf_timer_set_sleepable_cb() for
> > > > those? (and the invert in the other case).
> > >
> > > yes.
> > >
> > > > This version of the patch allows for one timer to be used as softIR=
Q
> > > > or WQ, depending on the timer_set_callback that is used. But it mig=
ht
> > > > be simpler for the kfree_rcu race to define the bpf_timer to be of =
one
> > > > kind, so we are sure to call the correct kfree method.
> > >
> > > I think one or another simplifies the code and makes it easier
> > > to think through combinations.
> > >
> > > I'm still contemplating adding new "struct bpf_wq" and new kfuncs
> > > to completely separate wq vs timer.
> > > The code reuse seems to be relatively small.
> >
> > There is some code reuse in the verifier, but it can be factored out I =
think.
> >
> > Though the biggest reuse might be in the map portion of bpf_timer,
> > which I haven't looked much TBH.
>
> Right. It's all the 'case BPF_TIMER:' in various places.
> New 'struct bpf_wq' would need another entry in btf_field_type.
> But that should be a straightforward addition.
>
> >
> > > We can potentially factor out internals of bpf_timer_* into smaller
> > > helpers and use them from bpf_timer_* and from new bpf_wq_* kfuncs.
> >
> > Yeah, also, given that we are going to enforce delay =3D=3D 0 for
> > sleepable timers (wq), the user api would be much cleaner if we can
> > have a dedicated bpf_wq (and it would make the flags of bpf_timer_init
> > easier to deal with).
>
> It seems so.
> Kinda hard to judge one way or the other without looking at
> the final code, but it seems separation is worth attempting, at least.
>
> Also if we ever do hrtimer+wq we probably will be using
> 'struct delayed_work' instead of rolling our own
> 'struct hrtimer' + 'struct work_struct' combo.
>
> It seems wq logic already made such a combination special enough
> and thought through the races, so we better just follow that path.
> In that case it might be yet another 'struct bpf_delayed_wq'
> and another set of kfuncs.
> Considering that cancel_work() and cancel_delayed_work()
> are separate api in the kernel.
> Multiplexing all of them under bpf_timer_cancel()
> seems wrong.
> In the past we were somewhat limited in terms of helpers.
> We tried not to add them unless absolutely necessary because
> of uapi considerations.
> Now with kfuncs we can add/tweak/remove them at will.
>
> >
> > >
> > > One more thing.
> > > bpf_timer_cancel() api turned out to be troublesome.
> > > Not only it cancels the timer, but drops callback too.
> > > It was a surprising behavior for people familiar with
> > > kernel timer api-s.
> > > We should not repeat this mistake with wq.
> > >
> > > We can try to fix bpf_timer_cancel() too.
> > > If we drop drop_prog_refcnt() from it it shouldn't affect
> > > existing bpf_timer users who are forced to do:
> > > bpf_timer_cancel()
> > > bpf_timer_set_callback()
> > > bpf_timer_start()
> > > all the time.
> > > If/when bpf_timer_cancel() stops dropping the callback
> > > such bpf prog won't be affected. So low chance of breaking any prog.
> > > wdyt?
> > >
> >
> > How would a program know set_callback() is not required after a
> > cancel() because the kernel kept it around? It seems that it's going
> > to be hard for them to know that (unless by trying first a start()),
> > and it will add more code.
> >
> > timer_cancel() would be hard to change but we can always do the change
> > and add a new kfunc timer_cancel_no_drop() which would clearly allow
>
> that works too.
>
> > for new programs to know that set_callback() is not required to be
> > called. In a few kernel releases we could remove it and say that
> > timer_cancel() is the same (and replaced by a #define)
>
> #define won't work, since mechanics of detecting and calling
> helpers vs kfuncs is quite different.
>
> > Anyway, the more I think of it, the more I think the best API would be
> > a dedicated wq API. It's probably going to need a little bit more
> > work, but it'll be more or less this work plus the new bpf_wq type in
> > the map.
>
> It seems to me as well.
>
> Thanks for brainstorming.
>

Alright, as of today (and I'm about to be AFK for the weekend), I got
your changes in and working (I think). I'll review the series on
Monday and send it back so we have a baseline to compare it to with
bpf_wq.

Cheers,
Benjamin


