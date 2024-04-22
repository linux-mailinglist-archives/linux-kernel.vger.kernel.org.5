Return-Path: <linux-kernel+bounces-153420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7278ACDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAFA1C2136D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702314F124;
	Mon, 22 Apr 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1wZGuSw"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653714F11A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791545; cv=none; b=sYyCII0gOT1PB7Zumr+WPiRvK3pBBGSgGVWln0j+1rcdyksBkEBA1DmxaTOvo7c6vIrQH1jQelEyVcOomJT+wXMJ+RfNBuADKua4JeddFAAFwLOlIhda8YPIZF07KokULy6+UspCtqWGP8e3yzTzq2V9mkmz3IgEqXwDOy6/tmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791545; c=relaxed/simple;
	bh=RAKQq+yi4ITyIq7xd10N0brsRgSTwyy5+Lf/YhlYcFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+ktdXzn3jMYnLzf08rdN8MFwvZ8/pcc98ap6MiqYuOwT3vrDolZESx9MDHub9z0fjb4mPXkCJVxNslMgLvpSfs98U15htUTf6n9mhjqD5K7aXS4c3pWX2emTGcFF5ORV3bNFiLMVLcuGO3LXn9EAcqv38AK9o+q5LAmTegdztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1wZGuSw; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2351c03438cso2190329fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791543; x=1714396343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAKQq+yi4ITyIq7xd10N0brsRgSTwyy5+Lf/YhlYcFo=;
        b=m1wZGuSwhe/hx/xxnjI6HQehpchVOgpWdzGKcPMAgTi42dA/O+73cYV6+eGaby8vVf
         2twnC3/3+LRzO9K3oekDIvFb/+LOePPP5X8s5Q13UqPmKFRTi3Se0QE+5OA4cPdM59UB
         90CorvWXEb1p7O8JmNeZr2lE9+bRrs+mqe0W+8PRtdoo2c9uIOKOg0IAK4+Dgr8eKvPO
         Bff25vJtVYWOPqmd8/qsebaggzl5VvnVnw0Gh7okuQ1D1lhpQTdwOH2wmwDGpPV2bO6J
         cQq/n5cuFvNI1ERlIfWZd6jWu8yFjtbQ2mFcVx1xENAqzDCyCA0QJXdlNjj6zB6VQ46j
         7n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791543; x=1714396343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAKQq+yi4ITyIq7xd10N0brsRgSTwyy5+Lf/YhlYcFo=;
        b=vGxBesOfAGuDsK6huxJyi76hbs0nrbcDQpJgJ8P4ne6Oh0TJiftaJZO3Ip/ARW79Ra
         KmbVH0TSPpD2Ek9QuGEUOA/olz/hJo5C1V/M4sHAvP6L8hc+uCBtfdCxRBng6ix2T3gj
         /DRsdF4nUPSkyiu5/cBJJcBWl5UZ3Kqw47Rwh6VYjSqjGnsYy15OoM5APDvHLxVfHuT5
         ArxX/B5b00ZpxBLrwTLAFsPUgaq7aZVGAnX8TntkyrPGjWn9a06gfSm3npOTFHKoMCc1
         JAEmqLeBu4tJDma0qyf2cTSmq1dZ7Yr1Hf9zI9ll13uoa/tltmByELKd0b+mR/yebPKB
         8+wg==
X-Forwarded-Encrypted: i=1; AJvYcCX3XjxJcMOPMF00uCXjxN+P2H6zT9CrohpJGtmUyNbUiODnaWZs/a1Oqts9/ZDQWjtCHZBE97qzL12Fb8T52RPhFvv/x7AdxIhQfIso
X-Gm-Message-State: AOJu0Yx125oXohlCI/QZAWBG4vF6avtMGSJYzUpbA7RU/olgcyZskKWp
	QGDfPb+I4Dmp+qvg36gKN+mWhaaSPXu6FHo5bL3mUPVp9pKwZCv9L4Phb0Yc1aVc95YCQjYuFsD
	0MDzoV6jk24tjc5kIaCpIuCdFQtc=
X-Google-Smtp-Source: AGHT+IFfgwSdeP+Qrq9yE6C2GY2E9osJzqMw584qlKtYfc9YEN7yIoorzAbiEKyxJkzdGuQB61Nc3p+6sx7pAN5H+B0=
X-Received: by 2002:a05:6870:c7aa:b0:239:7f6a:fb89 with SMTP id
 dy42-20020a056870c7aa00b002397f6afb89mr7864969oab.2.1713791542767; Mon, 22
 Apr 2024 06:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422082238.5784-1-xuewen.yan@unisoc.com> <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net> <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net>
In-Reply-To: <20240422111744.GO30852@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 22 Apr 2024 21:12:12 +0800
Message-ID: <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi peter,

On Mon, Apr 22, 2024 at 7:17=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 22, 2024 at 07:07:25PM +0800, Xuewen Yan wrote:
> > On Mon, Apr 22, 2024 at 5:42=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Apr 22, 2024 at 04:33:37PM +0800, Xuewen Yan wrote:
> > >
> > > > On the Android system, the nice value of a task will change very
> > > > frequently. The limit can also be exceeded.
> > > > Maybe the !on_rq case is still necessary.
> > > > So I'm planning to propose another patch for !on_rq case later afte=
r
> > > > careful testing locally.
> > >
> > > So the scaling is: vlag =3D vlag * old_Weight / weight
> > >
> > > But given that integer devision is truncating, you could expect repea=
ted
> > > application of such scaling would eventually decrease the vlag instea=
d
> > > of grow it.
> > >
> > > Is there perhaps an invocation of reweight_task() missing? Looking at
> >
> > Is it necessary to add reweight_task in the prio_changed_fair()?
>
> I think that's the wrong place. Note how __setscheduler_params() already
> has set_load_weight(). And all other callers of ->prio_changed() already
> seem to do set_load_weight() as well.
>
> But that idle policy thing there still looks wrong, that sets the weight
> very low but doesn't re-adjust anything.

By adding a log to observe weight changes in reweight_entity, I found
that calc_group_shares() often causes new_weight to become very small:

Hardware name: Unisoc UMS-base Board (DT)
Call trace:
dump_backtrace+0xec/0x138
show_stack+0x18/0x24
dump_stack_lvl+0x60/0x84
dump_stack+0x18/0x24
reweight_entity+0x3e8/0x5f4
dequeue_task_fair+0x448/0x948
dequeue_task+0xc4/0x398
deactivate_task+0x1c/0x28
pull_tasks+0x200/0x334
newidle_balance+0x3cc/0x438
pick_next_task_fair+0x58/0x670
__schedule+0x204/0x9a0
schedule+0x128/0x1a8
schedule_timeout+0x44/0x1c8
__skb_wait_for_more_packets+0xd0/0x17c
__unix_dgram_recvmsg+0xdc/0x3a8
unix_seqpacket_recvmsg+0x64/0x74
__sys_recvfrom+0x14c/0x1e4
__arm64_sys_recvfrom+0x24/0x38
invoke_syscall+0x58/0x114
el0_svc_common+0xac/0xe0
do_el0_svc+0x1c/0x28
el0_svc+0x3c/0x70
el0t_64_sync_handler+0x68/0xbc
el0t_64_sync+0x1a8/0x1ac
reweight_entity: the lag=3D-831088603030 vruntime=3D2086205903
limit=3D3071999998 old_weight=3D237238 new_weight=3D2

