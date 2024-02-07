Return-Path: <linux-kernel+bounces-55880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F7F84C2EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E928286DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A23FBE8;
	Wed,  7 Feb 2024 03:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsQE6HfE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5EFF9D6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275130; cv=none; b=lNHRQL5KjLJmNFPVrVnpBDi5ec4wi0NuX66acn3sL+ZPPZ4kVY7vVOpaAgUB7rJS5YkK5jAae/QMPwEPvkp/FE7+XCIdNdNwXLlarRI1/MvmzrIuhtQ0j5GJk9QMxsQ+fmDN/UqScAyvCXWxaNghqN5XshnanuL1eJRZbTb+rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275130; c=relaxed/simple;
	bh=qGhkZQIgQVNp0AZCjdVRVJL7p1vNU4Lb94vZHDmjz70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jfzj+AuYiAdpU/t3xsmOX1zxdtUqFQBOUfhWS4w5gTBAqgalUoERCWkxz9fbDcFwNiVmSXLg+sn9EhNYiOUsATl+Yet1A7P2BfdGUDXncfVyR5R7QjYyV6BV9CLGEWmIUjivyHftXj894VW9A+mvF8hiR9d5wGugddfAJzaepAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsQE6HfE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56061ad3d3dso326924a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707275127; x=1707879927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzJz2VhUqQo6bsWu4ZInY8E3t/UAr4i9VkRJ4+BoPG0=;
        b=dsQE6HfEx+hmAVH/AvQUiRk4GHnp9l251uNXuFHLTYYvYGqqY8bZMG+PMMuqvcKNj2
         E43EtdlAj1bx+KOWhcG2kUbNaKr27tTpR5tldXIJmRjY66I0eVFq6B/2+WZLQJrGytM3
         M+PsX2VsJWMUPCjMUabBZ6lQWw6LwFsshhC+wgRtmtMWahEs76tYQC8cuJeIyaQvOiKJ
         3247RtRGZZywlMnP2gwvOIPVInuiRmdosNRU2DUp8JlpT+MfY8ZYEvvu1MfpE/jppMa3
         BlDWac2pEy/fWOTgKe/4KxDPx2fInaLUYyBjFT6OZNEYtfGOs+raURwWQAbJOT0wj6Tz
         PF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275127; x=1707879927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzJz2VhUqQo6bsWu4ZInY8E3t/UAr4i9VkRJ4+BoPG0=;
        b=pg1WA/O8JRlXfMXIXR3N2tUHWyYS+PisdgvYo8B3pnwu+44FuhlrdMo8w0qhyT7p3a
         qAvPSd8EjW8UeveCyxUZhOXao9JCE5Ebs/pUjIaRd/Gi7P57O/v0hwkNMl3Lp57QfzOJ
         taZFuGs699TD9Liz2tVh+5hofaqq4wFjEqgjOyY4mBV2tNnY1rvv8lSVwNirz+xfKK6F
         DE+vmQAJvxF8DeB1hI+6zFsZfcZ2WN2AyTOCtd3LAvlszI6yRlf+DAxg6ZPxY3uiidlW
         sQ7rc+T6zmrZcPWI2EWZjmZ/APrK+PF+/UKpKjSrVlbpWIoe/2fDwkpigCjkDTd7hjyV
         cvNw==
X-Forwarded-Encrypted: i=1; AJvYcCUUB3CX9eyWLUg8y84IGvIVmzndZvf0bJK5EoTccqbl+fexdpv71eTkrE0ttp40TE5zWi9jtoi/VbFiL73mNwYMosxuswmy7Bw62a/C
X-Gm-Message-State: AOJu0Yxg4DWJfKPahCh3RDxMGKxVbqLtD0MnOTKuySRTCvRCyvRJautx
	FIEvGe5IuP3ktD0svKbkM3ErLBnOGxapmKsvJmbUEL/YWW5T0Uc2NOXYoW0Ut2RLJoFMd0zEuvP
	8r1qyjfr+6kYIb+WGX2429IsBxPY=
X-Google-Smtp-Source: AGHT+IHR8KELzkqPswE+Zbj1LmsGAFkS/tLghwrN4ewDP4p0eb9igGI9OPYGFLo5BbMxda/UYM0MiucKrxLa994RdGc=
X-Received: by 2002:a50:8d52:0:b0:55f:e2ee:6bba with SMTP id
 t18-20020a508d52000000b0055fe2ee6bbamr10543405edt.5.1707275127159; Tue, 06
 Feb 2024 19:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111115745.62813-2-zegao@tencent.com> <d0ab28dd-95e0-446c-9e21-a45680114e5b@arm.com>
In-Reply-To: <d0ab28dd-95e0-446c-9e21-a45680114e5b@arm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 7 Feb 2024 11:05:15 +0800
Message-ID: <CAD8CoPD7CC+i7TTV3Mvm3LJe=P2SMZUyDBnPLuMz7SPv23t6vw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice
 as explicit time quanta
To: Luis Machado <luis.machado@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:09=E2=80=AFPM Luis Machado <luis.machado@arm.com> =
wrote:
>
> Hi,
>
> On 1/11/24 11:57, Ze Gao wrote:
> > AFAIS, We've overlooked what role of the concept of time quanta plays
> > in EEVDF. According to Theorem 1 in [1], we have
> >
> >       -r_max < log_k(t) < max(r_max, q)
> >
> > cleary we don't want either r_max (the maximum user request) or q (time
> > quanta) to be too much big.
> >
> > To trade for throughput, in [2] it chooses to do tick preemtion at
> > per request boundary (i.e., once a cetain request is fulfilled), which
> > means we literally have no concept of time quanta defined anymore.
> > Obviously this is no problem if we make
> >
> >       q =3D r_i =3D sysctl_sched_base_slice
> >
> > just as exactly what we have for now, which actually creates a implict
> > quanta for us and works well.
> >
> > However, with custom slice being possible, the lag bound is subject
> > only to the distribution of users requested slices given the fact no
> > time quantum is available now and we would pay the cost of losing
> > many scheduling opportunities to maintain fairness and responsiveness
> > due to [2]. What's worse, we may suffer unexpected unfairness and
> > lantecy.
> >
> > For example, take two cpu bound processes with the same weight and bind
> > them to the same cpu, and let process A request for 100ms whereas B
> > request for 0.1ms each time (with HZ=3D1000, sysctl_sched_base_slice=3D=
3ms,
> > nr_cpu=3D42).  And we can clearly see that playing with custom slice ca=
n
> > actually incur unfair cpu bandwidth allocation (10706 whose request
> > length is 0.1ms gets more cpu time as well as better latency compared t=
o
> > 10705. Note you might see the other way around in different machines bu=
t
> > the allocation inaccuracy retains, and even top can show you the
> > noticeble difference in terms of cpu util by per second reporting), whi=
ch
> > is obviously not what we want because that would mess up the nice syste=
m
> > and fairness would not hold.
> >
> >                       stress-ng-cpu:10705     stress-ng-cpu:10706
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4934.206                5025.048
> > Switches              58                      67
> > Average delay(ms)     87.074                  73.863
> > Maximum delay(ms)     101.998                 101.010
> >
> > In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
> > in this patch gives us a better control of the allocation accuracy and
> > the avg latency:
> >
> >                       stress-ng-cpu:10584     stress-ng-cpu:10583
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4980.309                4981.356
> > Switches              1253                    1254
> > Average delay(ms)     3.990                   3.990
> > Maximum delay(ms)     5.001                   4.014
> >
> > Furthmore, with sysctl_sched_base_slice =3D 10ms, we might benefit from
> > less switches at the cost of worse delay:
> >
> >                       stress-ng-cpu:11208     stress-ng-cpu:11207
> > ---------------------------------------------------------------------
> > Slices(ms)            100                     0.1
> > Runtime(ms)           4983.722                4977.035
> > Switches              456                     456
> > Average delay(ms)     10.963                  10.939
> > Maximum delay(ms)     19.002                  21.001
>
> Thanks for the write-up, those are interesting results.
>
> While the fairness is restablished (important, no doubt), I'm wondering i=
f the much larger number of switches is of any concern.

This patch should introduce no changes against the status quo, of
course if I understand and implement it correctly,  like I said in the
changelog when custom slices are not supported right now,

If we do the same experiments without setting custom slices,
(for 10 secs with HZ=3D1000 and sysctl_sched_base_slice=3D3ms)
the number of switches is likely to be almost 1253, due to which,
we can conclude that if no regressions are spot w/o this patch,
then there should be none w/ patch, if your concern was about
the throughput it possibly affects.

> I'm planning on giving this patch a try as well.

Cheers!
        -- Ze


> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

