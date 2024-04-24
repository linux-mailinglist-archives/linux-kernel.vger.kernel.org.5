Return-Path: <linux-kernel+bounces-156419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080168B029D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41F62854AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DED158217;
	Wed, 24 Apr 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4cAqKB5"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7115667D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941653; cv=none; b=sLoxFdSswl5+rhsAtsH1OPtQhTF09vsdkmiYN1E29tubesOihzePNdQLsAHTkNx0P7tM73RLiapERyn+3TjBa/DJUIvkaf4oVjFOKPEnC50I8v5JLBmgTmch7807fgSVoJctVodfDHf8grqrWisWAbcbHyAa8/lerO6C3E1cZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941653; c=relaxed/simple;
	bh=tN3xGdvpOebKvhqjyvdHhJXLe8z4Riqv3R95vxxSXpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmBHQf2TnhQNx/GOQullQo9GQshzGaJQoVXFsfUccX/Aeb+FtJM5OUedz+JNbkY4bswod6XnByvU7R1l6RBfUN1Fychf3LBRIDTY8xK2O73cv/piywI7yl1jiR4iQqgcqcOKdtnBAFWsPaVr3ikDpMcne1AGpuIQS/HnDj2+cxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4cAqKB5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea2ac4607aso3057548a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713941651; x=1714546451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgR49zR6ty/YN6URwbI1ia4am21R9HACnCsXNHHFEdE=;
        b=N4cAqKB5r9+ZtIzJ0CvAuUTs48ZWGhgsmnQ4+0P/UqKu10FWieWvSmm75HcAV4qcVb
         q9/2bSXXZJIDKmafp+MUYdyEWwRu4WpiIAz+zDilXoUZm22gOXgIukdp83EZbGupQABt
         2BuWbaT+jY79IYENyOgo+zbx90/YVTzFwoHMzKVosshZkS3lXk19ID7ERJyMXSKTVPIW
         jbe5WdEObx+NZyJm8pzTJtj+iRqPCBfj9hSUdB2Vm77NjFdUlcwmZvL2PhU5Fjde440c
         rgdoP2WrPkvs/Dj9ugi208VZeTXZ1KmEipCUIHFY5uD7H9dx8w98nrEDVV1aeHP69sbK
         J1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941651; x=1714546451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgR49zR6ty/YN6URwbI1ia4am21R9HACnCsXNHHFEdE=;
        b=DZUUYji55ynPiIEP7OYIgSCXh/LhwIrbLakedXyb64wb5gByvUzSvwbefbp4W5WRRR
         q4DZSH0Yfhw9ZFi+BeDho3rt5ILVKaj1yOe535qoL/8MsvlZLvjhQBNiZ8MSwN7TbWED
         fNcHlVIy6fPTaVJWtty7oNdfASaXbOIFBLLEG92va67LwpJ7juWixJTsQMHMNTwhq821
         v57RHViG4jtFi2T8waKmM7QF4hmi6UC6XsUUY0RElQoF4cLZVMrUa8Gqn4AW03+wOcvh
         xqom4UoBrOU5ntUdZdowWEiVikivzAD+00sHy0+1RxaWDHU0Rr1Cg+uZb26CgQd3DLKa
         q6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkiRpOpOGd3IsgyPmSmdkkq2DQNd2FrO8ZlrccjL8LbikzQJf0/OMwAp6JtgMJf29W2id58kBPomQdXvRim6mv00f3n0/zDqyBIO/d
X-Gm-Message-State: AOJu0YzpCIzOvzpJKZfplLPhUYjaXp/BbIaIK0tyOePdV6nNw0uramkL
	h8G2ms1yhThQywo9WUnM5vrt6W/ZvB8nLCCpaNdGBzVX4JjrpQwq35Qqk+BxVsAStn1ELl4XjoQ
	676ST3rDouG4X6lp+1i0FQnphERw=
X-Google-Smtp-Source: AGHT+IEFAC3+XkmcPIzRE2RAA+839jbfsYcOVpGbPMEm7EiK1ZcKQ9lspEK9d67xeQgkVqp6fnG3u0aylvvnIapV5TQ=
X-Received: by 2002:a05:6870:3853:b0:235:489d:cea2 with SMTP id
 z19-20020a056870385300b00235489dcea2mr1634250oal.7.1713941650584; Tue, 23 Apr
 2024 23:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422082238.5784-1-xuewen.yan@unisoc.com> <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net> <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net> <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
 <20240422155937.GP30852@noisy.programming.kicks-ass.net> <CAB8ipk-WYVLsRi1_wnm2vF3M4RDnV1cSomb4MkJ83ef2GY0gzg@mail.gmail.com>
 <20240423114836.GA24704@noisy.programming.kicks-ass.net>
In-Reply-To: <20240423114836.GA24704@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 24 Apr 2024 14:53:59 +0800
Message-ID: <CAB8ipk96fCVa_9j5Ye0qiVOsnveDsO1ffu6PQoA18EpaRKOCjQ@mail.gmail.com>
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

On Tue, Apr 23, 2024 at 7:48=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Apr 23, 2024 at 11:05:20AM +0800, Xuewen Yan wrote:
> > On Mon, Apr 22, 2024 at 11:59=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Mon, Apr 22, 2024 at 09:12:12PM +0800, Xuewen Yan wrote:
> > >
> > > > By adding a log to observe weight changes in reweight_entity, I fou=
nd
> > > > that calc_group_shares() often causes new_weight to become very sma=
ll:
> > >
> > > Yes, cgroups do that. But over-all that should not matter no?
> > >
> > > Specifically, the whole re-weight thing turns into a series like:
> > >
> > >             w_0   w_1         w_n-1   w_0
> > >         S =3D --- * --- * ... * ----- =3D ---
> > >             w_1   w_2          w_n    w_n
> > >
> > > Where S is our ultimate scale factor.
> > >
> > > So even if w_m (0 < m < n) is 2, it completely disappears. But yes, i=
t
> > > will create a big term, which is why the initial vlag should be limit=
ed.
> >
> > Okay, I understand what you mean. Even if the weight during dequeue is
> > very small, the weight will be eliminated during enqueue.
> > In this case, the necessity of the !on_rq case does not seem to be
> > very important.
> >
> > On the other hand, the following case:
> > place_entity()
> > {
> > ...
> >  5244                 load =3D cfs_rq->avg_load;
> >  5245                 if (curr && curr->on_rq)
> >  5246                         load +=3D scale_load_down(curr->load.weig=
ht);
> >  5247
> >  5248                 lag *=3D load + scale_load_down(se->load.weight);
> >  5249                 if (WARN_ON_ONCE(!load))
> >  5250                         load =3D 1;
> >  5251                 lag =3D div_s64(lag, load);<<<<
> > ...
> > }
>
> So this plays games with scale_load_down() because this is W, the sum of
> all w, which can indeed grow quite large and cause overflow.
>
> > reweight_eevdf()
> > {
> > ...
> >                  if (avruntime !=3D se->vruntime) {
> >  3770                 vlag =3D entity_lag(avruntime, se);
> >  3771                 vlag =3D div_s64(vlag * old_weight, weight); <<<<
> >  3772                 se->vruntime =3D avruntime - vlag;
> >  3773         }
> > .....
> > }
>
> While here we're talking about a single w, which is much more limited in
> scope. And per the above, what we're trying to do is:
>
>   vlag =3D lag/w
>   lag/w * w/w' =3D lag/w'
>
> That is, move vlag from one w to another.
>
> > There is no need to clamp the above two positions because these two
> > calculations will not theoretically cause s64 overflow?
>
> Well, supposedly, if I didn't get it wrong etc.. (I do tend to get
> things wrong from time to time :-).
>
> I would think limited vlag would stay below 1 second or about 30 bits
> this leaves another 30 bits for w which *should* be enough.
>
> Anyway, if you're unsure, sprinkle some check_mul_overflow() and see if
> you can tickle it.

Okay, Thank you for your patient answer:)

BR
---
xuewen

