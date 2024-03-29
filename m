Return-Path: <linux-kernel+bounces-125342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988E89245A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD53284B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5265E20;
	Fri, 29 Mar 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqkdpScG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82181E893
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741019; cv=none; b=imKJy0YaO5keSvsIIJIQNQK/8nU/aSz3qGbwBf8bZWySpe0rY42l0wBn9A1FSnm6S+V2qgZeX/cereGm/TcxTB4NThtDJm0Zo6Ovm1zgImzg/fbzvvQMhUJxBnATSy+XcItBWXNX4c/S5fI/qbJvgR0a9b9VJIf/93ROLqhW4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741019; c=relaxed/simple;
	bh=XWJ5L+9qn4g25NVZSdkkIFHiRao0Rnwp4nYt7BHiXWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhK3gEWM9yHwhhYR6BCilAI0mhKglCOB0l4ufxJGex8xjsBNwj/anThCqzp/+gIu7hT2bgjkwj8uaEGlcUbxocwTeMTvGyS7o4KB54gbDUYG9hbi+kh3DjqmVmyxyXqpsH4h4aOgDNef8azsL/c7BPhOoI8e3FXfYJl7jd5UAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqkdpScG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so20683a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711741016; x=1712345816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG2sdULi0sIh2ro2ngvfwXnPQgm3+COAzlzZGsm+OFA=;
        b=UqkdpScGl1Y2o1Fq8wMY71p9VBqCgP4XKZi3l9VlrbBW3plyKRkTiBAv5hCbH0ZU/F
         +3KJh2vCuJevBEhdga3pBjBQOV8RYJgT+EBVQLLO2jIR4OXTdi+BqzePf/SDSHIm/axf
         Ebp0nfbZ3dMs3x2Zd5yLoMNbFk6wZV/8OvT9iwJjeoaUozj+cHunMNiU+KhL43DkA1BU
         xQGjYmrEel+wqrhsi0RaC9HT9T4m43P/wnpbXVeX3uNiyuT0uwabihgHyzNkRFor+EzY
         1ViqQokwTu5yRQkUA4IsZtiy9cBWiXaRqpbyYFpUWFpOTOuoVHe8q5dj8uLxNdzneEB1
         dN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741016; x=1712345816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG2sdULi0sIh2ro2ngvfwXnPQgm3+COAzlzZGsm+OFA=;
        b=brOuvIgPerOIQ+LBkdX31HDX8Z+zc9W9SwrdPDr/j0LEjpCiFiMINtsOm0FUWYHBEx
         jiVkxhNJj+OayQzoIgfYRQ1n7v6vyvds2FQqKoD5+dtjj8V756G1S7BQ8KplIZz6PjuR
         o2tqEi4ontI+pnLpOJegxCO3qOBMnP3CUc7k/Dbmz2+pI/ErCQGkq9FcJwpwRlmUndhr
         OT5MqmqxFCc9ehc4dx552DhrWNXRfGJx7tmfEME52GbUQRYBsn9ewBsATTFDUnzg2Kmq
         uq05mYqBqxWtaMGFQcVi60ZLRidL4vkLM1vbFtVejdGtboEOim6KQ8v+32diAfhbDElu
         0oAw==
X-Forwarded-Encrypted: i=1; AJvYcCWabIQlgtZEokrznGXLzn5pfzIljvYiKn2uJ31Qu7N3glGA2OdQY7CeHUV3357HA4V15zT2YLN5afunLz52cKs8kusHeJ6Ev4FNGJDe
X-Gm-Message-State: AOJu0YykE+hJPi4bWLhX6qfkBLpmbEoplkyyW1lu3tQv6ex+C1VvLQDv
	OKFzBy6wdTVcFIA4HaGq2ntAYQbmlfDaUk6Qo3H3ltCfzO+ar0leNUyyojbp85S/LY8Ivo1XQN4
	jY1vpZA1PnRoSRP86lAXqf5Zffe94avSPlIM=
X-Google-Smtp-Source: AGHT+IEkuV+rTJvTCWIOBN1gpiKXWkItHvEm4U6jPpj3+9fzrBARDw9iU9zkIBN8ZmFc4XWd4s5xBYxozS8xZ0sqGeY=
X-Received: by 2002:aa7:c752:0:b0:56c:522f:6799 with SMTP id
 c18-20020aa7c752000000b0056c522f6799mr133259eds.5.1711741015944; Fri, 29 Mar
 2024 12:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328062757.29803-1-mingyang.cui@horizon.ai>
In-Reply-To: <20240328062757.29803-1-mingyang.cui@horizon.ai>
From: John Stultz <jstultz@google.com>
Date: Fri, 29 Mar 2024 12:36:42 -0700
Message-ID: <CANDhNCqKR30uD1RDmW7V6VHtdwbGnU5uJEvj_AUwHCsXZv3+Nw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
To: "mingyang.cui" <mingyang.cui@horizon.ai>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org, 
	tkjos@google.com, pjt@google.com, quentin.perret@arm.com, 
	Patrick.Bellasi@arm.com, Chris.Redpath@arm.com, Morten.Rasmussen@arm.com, 
	joaodias@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:21=E2=80=AFAM mingyang.cui <mingyang.cui@horizon.=
ai> wrote:
>
> When rt_mutex_setprio changes a task's scheduling class to RT,
> sometimes the task's vruntime is not updated correctly upon
> return to the fair class.
> Specifically, the following is being observed:
> - task has just been created and running for a short time
> - task sleep while still in the fair class
> - task is boosted to RT via rt_mutex_setprio, which changes
>   the task to RT and calls check_class_changed.
> - check_class_changed leads to detach_task_cfs_rq, at which point
>   the vruntime_normalized check sees that the task's sum_exec_runtime
>   is zero, which results in skipping the subtraction of the
>   rq's min_vruntime from the task's vruntime
> - later, when the prio is deboosted and the task is moved back
>   to the fair class, the fair rq's min_vruntime is added to
>   the task's vruntime, even though it wasn't subtracted earlier.

Just to make sure I am following: since sum_exec_runtime is updated in
update_curr(), if the task goes to sleep, shouldn't it be dequeued and
thus update_curr() would have been run (and thus sum_exec_runtime
would be non-zero)?

Maybe in this analysis is the new task being boosted while it is still
newly running (instead of sleeping)?

> Since the task's vruntime is about double that of other tasks in cfs_rq,
> the task to be unable to run for a long time when there are continuous
> runnable tasks in cfs_rq.
>
> The immediate result is inflation of the task's vruntime, giving
> it lower priority (starving it if there's enough available work).
> The longer-term effect is inflation of all vruntimes because the
> task's vruntime becomes the rq's min_vruntime when the higher
> priority tasks go idle. That leads to a vicious cycle, where
> the vruntime inflation repeatedly doubled.

This is an interesting find! I'm curious how you detected the problem,
as it might make a good correctness test (which I'm selfishly looking
for more of myself :)

> The root cause of the problem is that the vruntime_normalized made a
> misjudgment. Since the sum_exec_runtime of some tasks that were just
> created and run for a short time is zero, the vruntime_normalized
> mistakenly thinks that they are tasks that have just been forked.
> Therefore, sum_exec_runtime is not subtracted from the vruntime of the
> task.
>
> So, we fix this bug by adding a check condition for newly forked task.
>
> Signed-off-by: mingyang.cui <mingyang.cui@horizon.ai>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 73a89fbd81be..3d0c14f3731f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11112,7 +11112,7 @@ static inline bool vruntime_normalized(struct tas=
k_struct *p)
>          * - A task which has been woken up by try_to_wake_up() and
>          *   waiting for actually being woken up by sched_ttwu_pending().
>          */
> -       if (!se->sum_exec_runtime ||
> +       if (!se->sum_exec_runtime && p->state =3D=3D TASK_NEW ||
>             (p->state =3D=3D TASK_WAKING && p->sched_remote_wakeup))
>                 return true;

This looks like it was applied against an older tree? The p->state
accesses should be under a READ_ONCE (and likely consolidated before
the conditional?)

Also, I wonder if alternatively a call to update_curr() if
(cfs_rq->curr =3D=3D se) in switched_from_fair() would be good (ie:
normalize it on the boost to close the edge case rather than handle it
as an expected non-normalized condition)?

thanks
-john

