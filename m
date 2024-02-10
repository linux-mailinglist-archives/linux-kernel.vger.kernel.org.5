Return-Path: <linux-kernel+bounces-60371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF385041C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859FBB23671
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655D376FD;
	Sat, 10 Feb 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGC/SAai"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0D376E6
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563366; cv=none; b=aTE3ZYPuBxs9wh4XXx/ZA9b17apD/IdvKrys30lv3NBs3S+lI+Aa3hAhUZEuX3D7eUlkHy1sj19gHHgU4hQ+DuFsVMEMs3uztrvPnwMqRAlZ1LSROGXnkhb3QnwNK8PhM2sP0ffoTVYiJ5sjQWYNLHYgfV63f1eMlJmFeMUEo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563366; c=relaxed/simple;
	bh=COtOtkKYIbOOJ7+Wq/bWqgQ2qdXBCUNh1bkqgvYzZNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRbrzNtYwb+CwKYASYpWU5DI8cnmGsqdsVlGp7wM+LIN0XsQrWydsmEOTyHlFi/eppxgT3IPhFDXisBVjiUOoz/+KSfcTvL+lop+mUMKtKx7bE2whXWOiSw4MIRAhPaCtfyyVCnRPBrOJkO7icKIZLEOlVODBFEhu90KMqGfj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGC/SAai; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso24006281fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707563362; x=1708168162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55RoOzZzrdE7x43zEUIFZoJrICBJ4MroOWStmhN2xms=;
        b=WGC/SAaiPrxIc5QptTP86/Rnv2oDUP9Ua+8GUgLoNF+SFjLbxBJqTruNmfDNN+PBfY
         XATipSP/cfF6GVyOCF0UZ/xl6a1w4IF47xsPCnRFCxClLaYxs5AsOC8u4y7h/b7noIrf
         dI/uR61uoZmx08AIN5+xl70v3RMkRbnKEbpXsjLT1wysFtnVPnTKOxNB4C/g/2W5EKZh
         BCfLLRjlIjtfwapEC8zTvUfYU7ZD8vniXB+EgQwvuweCiqdhVOeRIRnVOuaMpiRx6xyc
         lEjXOuV44/aM1FZwkokzr8VslLBVi3I6kqMmXO0M0I2htxxVb0al3Dk9RvJuVbv58+dR
         zsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707563362; x=1708168162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55RoOzZzrdE7x43zEUIFZoJrICBJ4MroOWStmhN2xms=;
        b=hQJOgBV5jpixYFL3tSc/Pxaom8WB/EuwS84SsLDa17tw0Pp/pwpYSVdt8JuXyqsQ9b
         Wk8ZHnet5Oe+TeQrNSdRxHyZzwGe/fhwqj626EvS+HJmh7jqYxinzONrgUMzXbS3Oafl
         GxwvY0Mvn6LMqbljCK/AIUxuMtv6G4syBnmXCl39rbtkqPPBgzIJVjo1ExomTrzOREWr
         0vhB8JIOQXe/XlTVdUqT22e2rL5FlqNuG0rmHMCSuo32/hws1LVMh7bjD86Li0+dwEkw
         XiLMHtatuP1JTHdimuSVNfniDN+3GmeonrFPxiqWTa2Ai7jy3a3eMnmJzeb3rrC13CKz
         ambg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpVDTY7JOmbozpP4ShtP3+Qdr0Q8ilzqI4qGBSP9vqppkUmBF0X0PEQfdPHPTrkSDeev/G+81REMm6I6tznkVI0P40ql0+/wDjGRN
X-Gm-Message-State: AOJu0YxEdWpSfxIfGUY11rcKkVl3mePyAht19fDjKzXu0tMN5droc3sk
	u9ufO6D2ZI/6fe+mdBUoD0f2WgrrWTaBM3iV+uBiT5xMX2MRcom5Q32i+nblDF2r7893oWLjQoQ
	idKYREARnNX/eR94e2svSstUcB2w=
X-Google-Smtp-Source: AGHT+IH6YebZXexoKHQuOpwpOp1wp7blihftBUFJGICK8EtJSQL2dvS899u5rtGbr9JomuVPWG+GvvAgF484cWow9HY=
X-Received: by 2002:a2e:3013:0:b0:2d0:aa28:6f77 with SMTP id
 w19-20020a2e3013000000b002d0aa286f77mr1085899ljw.45.1707563362242; Sat, 10
 Feb 2024 03:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207034704.935774-1-alexs@kernel.org> <20240207034704.935774-4-alexs@kernel.org>
 <20240210011223.GA28896@ranerica-svr.sc.intel.com>
In-Reply-To: <20240210011223.GA28896@ranerica-svr.sc.intel.com>
From: Alex Shi <seakeel@gmail.com>
Date: Sat, 10 Feb 2024 19:08:45 +0800
Message-ID: <CAJy-Am=9R=AwV8Dpu=Pb8ohEKPZGDx2aJR9eH9hfWpTpXdGx9A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ricardo Neri <ricardo.neri-calderon@linux.intel.com> =E4=BA=8E2024=E5=B9=B4=
2=E6=9C=8810=E6=97=A5=E5=91=A8=E5=85=AD 09:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Feb 07, 2024 at 11:47:04AM +0800, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > sched_use_asym_prio() checks whether CPU priorities should be used. It
> > makes sense to check for the SD_ASYM_PACKING() inside the function.
> > Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(=
),
> > remove the now superfluous checks for the flag in various places.
>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>
> Tested on Alder Lake and Meteor Lake, which use asym_packing.
>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

It's the best gift for my lunar new year! :)
Next version with your Tested and Reviewed is coming.

Thanks a lot!
Alex
>
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > To: linux-kernel@vger.kernel.org
> > To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > To: Ben Segall <bsegall@google.com>
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > To: Valentin Schneider <vschneid@redhat.com>
> > To: Daniel Bristot de Oliveira <bristot@redhat.com>
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > To: Juri Lelli <juri.lelli@redhat.com>
> > To: Peter Zijlstra <peterz@infradead.org>
> > To: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/sched/fair.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 942b6358f683..10ae28e1c088 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_=
pct,
> >   */
> >  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> >  {
> > +     if (!(sd->flags & SD_ASYM_PACKING))
> > +             return false;
> > +
> >       if (!sched_smt_active())
> >               return true;
> >
> > @@ -9941,11 +9944,9 @@ static inline void update_sg_lb_stats(struct lb_=
env *env,
> >       sgs->group_weight =3D group->group_weight;
> >
> >       /* Check if dst CPU is idle and preferred to this group */
> > -     if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> > -         env->idle !=3D CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> > -         sched_group_asym(env, sgs, group)) {
> > +     if (!local_group && env->idle !=3D CPU_NOT_IDLE && sgs->sum_h_nr_=
running &&
> > +         sched_group_asym(env, sgs, group))
> >               sgs->group_asym_packing =3D 1;
> > -     }
> >
> >       /* Check for loaded SMT group to be balanced to dst CPU */
> >       if (!local_group && smt_balance(env, sgs, group))
> > @@ -11041,9 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_=
env *env,
> >                * If balancing between cores, let lower priority CPUs he=
lp
> >                * SMT cores with more than one busy sibling.
> >                */
> > -             if ((env->sd->flags & SD_ASYM_PACKING) &&
> > -                 sched_asym(env->sd, i, env->dst_cpu) &&
> > -                 nr_running =3D=3D 1)
> > +             if (sched_asym(env->sd, i, env->dst_cpu) && nr_running =
=3D=3D 1)
> >                       continue;
> >
> >               switch (env->migration_type) {
> > @@ -11139,8 +11138,7 @@ asym_active_balance(struct lb_env *env)
> >        * the lower priority @env::dst_cpu help it. Do not follow
> >        * CPU priority.
> >        */
> > -     return env->idle !=3D CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_P=
ACKING) &&
> > -            sched_use_asym_prio(env->sd, env->dst_cpu) &&
> > +     return env->idle !=3D CPU_NOT_IDLE && sched_use_asym_prio(env->sd=
, env->dst_cpu) &&
> >              (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> >               !sched_use_asym_prio(env->sd, env->src_cpu));
> >  }
> > --
> > 2.43.0
> >

