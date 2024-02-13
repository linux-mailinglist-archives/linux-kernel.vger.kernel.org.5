Return-Path: <linux-kernel+bounces-63956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE98536BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C66285BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0A5FB9D;
	Tue, 13 Feb 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACdF1qs7"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65325FBB1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843736; cv=none; b=p4LPsyfCvHy8eK/Tu0pfdcjNKDj92TyZi+1JRTr0foOCInonnuU4DYX6FZj7Q5x3OGDtjiqj0VovkFQaDuP/rTf5iKRWDTYaMUUoyLlHRBLqG1MQFHr/RPC1hA874oJw0AqNeoTRAQcBKg1xp9PLMbJ8VSVc8YIGJ3xivnRa5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843736; c=relaxed/simple;
	bh=sxP/Ct4f/W9RFGGh3BwEvWft+5Z4VN/QwG47SENCDgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeSdA4mqkymHGTRmDIedxBkXC2CL2suODuak+oOyUkw+NsTA282aVz2aN106AT1Ekc+QrvzGSM0f4XO71LkXf/pZ1agE9vJetJH3wVAEmFiPT0fFNTOVBbxMYGHZ7OPILE6Yc5+GBsVeN8EGp3ZL1jXqcKh75ORL5TSHMpvsN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ACdF1qs7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c6b6ec76eso28945611cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707843733; x=1708448533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2C2KajQq1j6C4s2S6XdGXHaXgW6nuYxff7IiM3Mu9Cw=;
        b=ACdF1qs7g2jTtJW5s3oHtzLrkoQYiOnu7cZ4mHhmqbkBzmk6s1q5vme+aFoTSV6BYF
         g9NqfGQ9Y+9rxfHLFgTEB4TqWJd8Yxtp6IX3koRIbPZsqDyMuSDCynehTtVw/IP4qcDi
         IG3KsGo5waSrkYzIh8NdpJHd1niPvHYi9IDRuR9M0H+Cf5PlyXNbdS1B+yc0QaKukQpO
         Ay2Xs1yLeYAwjeR4Qe7OGp9bBjXL2x/INSUIXtm7hbOU4fm66dEfrEA1x88F8G16K4gm
         JmTiBByjpDEJeMuTbztR0aieQJ4oVUdt7IW5vkbC7m6YKSFrlkwcuOxpIi3XF2kyhVTT
         toAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843733; x=1708448533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2C2KajQq1j6C4s2S6XdGXHaXgW6nuYxff7IiM3Mu9Cw=;
        b=gUT4PzYpLJTfa9esDPs2I3UbVDUVXspo1uFqdsVuysPj42uZvEUY3QDqQqH7sCn/qc
         zHdR5w3jDv89QWkhJGfqRskzsxHHXY9CQQR95E498BfI8NrbVWD5yLSK4btrGVbE834o
         MCTBTqHobPs1Fn3kFesIeKfCEATcjPS2qKE1DLMOUL0bG0H8oK7rEd/p+i4u2wiGQyWM
         BuhZ+GnAf0Py1mziGJ1gTVwi16QLz3c+oQkKiuQrhe7EvLvFfzEhrldLqZvAaxFE3mGW
         6EY+wadB+blHvZ+OPPVcWqseyf0kPA0fOjadTXGeXVbmEETwkl2sAhGckPR8jUXQ9Eee
         dCMA==
X-Gm-Message-State: AOJu0YzOFa3nARZcPBONFLrCM+WU7QXtv33vONTWCYdf3ePSwImn6hkY
	GEUuqf4uC6amKOqZrYSuY7kAgUZ0SZ3yZXcuBboTD2SPCcF3jpcLxVLqj08TNG6so+8QyPuvYwt
	31iNu24RmYUUzeychad1vMxjWybh34QepSE2Ruw==
X-Google-Smtp-Source: AGHT+IHxsZGJikhJS2uvvdRhYeJ9Xqd35v/xWvbXcUfog7oNpLTJjMqibdXaOe1XYzx0xaNOoc/u1AOSQteKYzsojNY=
X-Received: by 2002:ac8:6b51:0:b0:42d:b60c:204 with SMTP id
 x17-20020ac86b51000000b0042db60c0204mr415991qts.52.1707843733337; Tue, 13 Feb
 2024 09:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210113924.1130448-1-alexs@kernel.org> <20240210113924.1130448-4-alexs@kernel.org>
In-Reply-To: <20240210113924.1130448-4-alexs@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 18:02:01 +0100
Message-ID: <CAKfTPtDepmenMjBNoquByYSfqRkCLxTwnyVo-4xuLqL8MyHzMg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 12:36, <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> sched_use_asym_prio() checks whether CPU priorities should be used. It
> makes sense to check for the SD_ASYM_PACKING() inside the function.
> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> remove the now superfluous checks for the flag in various places.
>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 426eda9eda57..cd1ec57c0b7b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> +       if (!(sd->flags & SD_ASYM_PACKING))
> +               return false;
> +
>         if (!sched_smt_active())
>                 return true;
>
> @@ -9933,11 +9936,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         sgs->group_weight = group->group_weight;
>
>         /* Check if dst CPU is idle and preferred to this group */
> -       if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> -           env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -           sched_group_asym(env, sgs, group)) {
> +       if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +           sched_group_asym(env, sgs, group))
>                 sgs->group_asym_packing = 1;
> -       }
>
>         /* Check for loaded SMT group to be balanced to dst CPU */
>         if (!local_group && smt_balance(env, sgs, group))
> @@ -11033,9 +11034,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * If balancing between cores, let lower priority CPUs help
>                  * SMT cores with more than one busy sibling.
>                  */
> -               if ((env->sd->flags & SD_ASYM_PACKING) &&
> -                   sched_asym(env->sd, i, env->dst_cpu) &&
> -                   nr_running == 1)
> +               if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
>                         continue;
>
>                 switch (env->migration_type) {
> @@ -11131,8 +11130,7 @@ asym_active_balance(struct lb_env *env)
>          * the lower priority @env::dst_cpu help it. Do not follow
>          * CPU priority.
>          */
> -       return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> -              sched_use_asym_prio(env->sd, env->dst_cpu) &&
> +       return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
>                (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
>                 !sched_use_asym_prio(env->sd, env->src_cpu));
>  }
> --
> 2.43.0
>

