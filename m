Return-Path: <linux-kernel+bounces-127412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2C894AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0AA1C22217
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB718624;
	Tue,  2 Apr 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdESN32f"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF2CA6F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036895; cv=none; b=bfWggioQ8iNOEc4RvQQqYhazCxBRp+EoA12xh9cIkqLa11aTMTF3Gs4aI5qCmVaWeRT9l3VtafvTE7IVJBTpu5f92In9yuXpRL6m1a71efygY1BI3+QBZzr9O52jnS/95MWJiGvFj+JeQjmT6p8FfP/sl/WHc09FnSAW4Pn4qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036895; c=relaxed/simple;
	bh=Y78rJj8+C6yXAfWJEDvmRi7jXwsL00HBbfbNEJA7KZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePZsVhlGRkxSvrPzRL234dJzgpqNwF8uwrkBhc0IH8IYOCUyLgjkj/eS9R+GJvSLFnkoUEwO+fSOJhdqQ6seVHMsvVpJRXqAr9tjRPMqpgbRlxpDn06n315QiWEWgsOu6+OL2SDPHN70AozIl9+hK53JadZ7cvAyHmMJGlaeARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdESN32f; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a104601dcso49217017b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712036893; x=1712641693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LicSR3wkx45YuxnJnubGsVzsBl0pkMbBOEPlM15UIC8=;
        b=KdESN32fiI69wYH7cOn+QfyL9IMsT5fFtEjO3072n8II2r337rQGjtOCFJ52/NqvE+
         ZJQzKbWYGSf2BPUwWpMaS2W4gGDXoQdewBpC68NMzDPzhlicfCMLP5lsGvuo54CipMmB
         NALNmq6nfNoUNV77jdwvTyetgAFO4wpeok/Cu/avUsQxG7QjiaB9aGO2j1OKEJc8bMpz
         QE36diFKDbKkwDt9L51TfR4Rht/6Bmqp2ifTHOjUdWfTgkY73iHK8peTLBFSYhSjikxB
         Ont3G6hgwqFa1qXG+pA//qtHSrK9XoRnWoi4WuG48Tj0WjX6vO474YEkWZsCWGUTy0wc
         S34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712036893; x=1712641693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LicSR3wkx45YuxnJnubGsVzsBl0pkMbBOEPlM15UIC8=;
        b=Y7bldNNof5F/dVwSvl1lKl/fGTUTWkUN+VZRaEZpvSXNBSNyTxp74N/PnwX3IVYeI4
         2wm+7BTmgaNYMVLVdsTa8zJLBrNrb5cH7WxZers+Khudp+Fu17sZ3/Ifon7FeAOjJAxX
         x2WXgFp6UY+VlKNN4fAYYSgCQiKLMvKxTo2CVmdwJIjp8D/kUO7R2FP93K/x8LO4w9ih
         f/aVjaPTd/24GK+j4K4Nyzlqr2e1RQFNhJmLxVyRT+yJC0328spyS9C3RcClZd1ZmbGw
         qEkNszrsf7ulMeLZIgp1LRGY6PiTCCPogE5EKpQ6CwbLhtTN9wP3wbxfe68uJthiC3Zf
         Qz6w==
X-Forwarded-Encrypted: i=1; AJvYcCUnKiT6LlR6K2BPD/h89FWDlyGsLpVK4PNkcWYzmbSjLFJ5FNSy0PVIZX5+++1SkzXXxTi0m9OKNCWZcC4PG+NRo/9cvlmelhH4a0T1
X-Gm-Message-State: AOJu0YxU+XLkLD2iNibqCTJdrEUC1e1Cn0LYLCiBXdiRtjnThS9uhl8Z
	56H38w7cQOCZ7Xy2xTGdhzLvbfZrbko7vKjvnJGS5B1CbQO4ye6lRGz8zOOcu4/hKqYWb06WSMv
	Aa3PobIJoDAPeuuT6I4uTk/99uu4=
X-Google-Smtp-Source: AGHT+IG5Hprc/YKZPrz9z9DNyqCunX7nvKsdHb6/htJV8OMRfMj0gK1ecgmP6p3JaYSFs6Eu6bT3XrWt/+r3mP1gME8=
X-Received: by 2002:a05:6902:34b:b0:db9:9537:2c39 with SMTP id
 e11-20020a056902034b00b00db995372c39mr9318049ybs.2.1712036893108; Mon, 01 Apr
 2024 22:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315015916.21545-1-daweilics@gmail.com> <ZgqOEJ5sCANkkk5N@linux.ibm.com>
In-Reply-To: <ZgqOEJ5sCANkkk5N@linux.ibm.com>
From: Dawei Li <daweilics@gmail.com>
Date: Mon, 1 Apr 2024 22:47:36 -0700
Message-ID: <CAG5MgCq3GT=CVj7Hz8rUMfNG1c9ypVsTSDKNESHV9tY_qWSt2g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix initial util_avg calculation
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vishal

Thanks for the comment!
Do you suggest using scale_load_down() in place of se_weight()?
It's a soft bug we should fix one way or another before what the
comment mentions really happens.
I am actually confused that we have both se_weight() and
scale_load_down(), and they do the same thing.

Best regards,
Dawei

On Mon, Apr 1, 2024 at 3:36=E2=80=AFAM Vishal Chourasia <vishalc@linux.ibm.=
com> wrote:
>
> On Thu, Mar 14, 2024 at 06:59:16PM -0700, Dawei Li wrote:
> > Change se->load.weight to se_weight(se) in the calculation for the
> > initial util_avg to avoid unnecessarily inflating the util_avg by 1024
> > times.
> >
> > The reason is that se->load.weight has the unit/scale as the scaled-up
> > load, while cfs_rg->avg.load_avg has the unit/scale as the true task
> > weight (as mapped directly from the task's nice/priority value). With
> > CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
> > CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
> > Thus, the current code may inflate the util_avg by 1024 times. The
> > follow-up capping will not allow the util_avg value to go wild. But the
> > calculation should have the correct logic.
> >
> > Signed-off-by: Dawei Li <daweilics@gmail.com>
> > ---
> > Changes in v2:
> > - update the commit message
> > ---
> >  kernel/sched/fair.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a19ea290b790..5f98f639bdb9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_en=
tity *se)
> >   * With new tasks being created, their initial util_avgs are extrapola=
ted
> >   * based on the cfs_rq's current util_avg:
> >   *
> > - *   util_avg =3D cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.=
weight
> > + *   util_avg =3D cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
> > + *           * se_weight(se)
> >   *
> >   * However, in many cases, the above util_avg does not give a desired
> >   * value. Moreover, the sum of the util_avgs may be divergent, such
> > @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct=
 *p)
> >
> >       if (cap > 0) {
> >               if (cfs_rq->avg.util_avg !=3D 0) {
> > -                     sa->util_avg  =3D cfs_rq->avg.util_avg * se->load=
weight;
> > +                     sa->util_avg  =3D cfs_rq->avg.util_avg * se_weigh=
t(se);
> Hi,
>
> The comment above the declaration of se_weight function says we should be
> using full load resolution and get rid of this helper.
>
> Should we be adding new user of the helper?
>
> /*
>  * XXX we want to get rid of these helpers and use the full load resoluti=
on.
>  */
> static inline long se_weight(struct sched_entity *se)
> {
>         return scale_load_down(se->load.weight);
> }
>
>
> >                       sa->util_avg /=3D (cfs_rq->avg.load_avg + 1);
> >
> >                       if (sa->util_avg > cap)
> > --
> > 2.40.1
> >

