Return-Path: <linux-kernel+bounces-101630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8787A9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE95B23151
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC054A07;
	Wed, 13 Mar 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUubTyAb"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AD446AC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340917; cv=none; b=sq022DKl/LxBZZk3vzuarpAzMrw//StMiEuzMmVG85chSIOagazjhQ/xpj7Xufealv3t+HIVxtelvuKjOg2XOsjFGo3PvXONw+4VZnR57kmLFy/gYG4empE2L+3MROA5FoT3uCnnjBZlgiH6ahuzNj/h6fayUAR7I7zYyWRDbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340917; c=relaxed/simple;
	bh=TCxTim0JhN978rqo31dYi0sXMJZtVVHuwFfXWTUdTjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSnEEGh4edAjBWv5QjRP1YEQye6pzyOxVvT7QBjjHovolR9g+zog8DdFxztXdVUP48cEMZTl91mBZQ8q5cSN+xWmNBKshG2Ec+h87Lsx15J9Nx2Vq32vpqhk/iu/mjHctTRolLwkgrZkBwy4oLeLPL1FVx4b6J0spViiDSk5Rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUubTyAb; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-473ac7bbe64so648331137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710340914; x=1710945714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyza15vzLpvyPMhUd5jAdze5xBbHjlf2omLucHJ3cjY=;
        b=uUubTyAbv2g2vBvJhM6oyr62KonL0dPwyNe+DI1FqNGZO4B2zgcohktBRRqP/KNc5Q
         I99og0N0S5yrCBAIjQkZgSSPzZKxa5y35+R7+28l3eMKmMSQpDm0FCuEBUkD8oj7FuAp
         D4oLL27rspOfDCAbFpuUuWmOvtoLE2pUq7qN8Iw3dVfSZffMAoDAejOhJFlDmkOvTJze
         zz4DmbQO3KIDaUPHEZhMHERKFTWArAgW7Y6KDVEYWnqqvObCJlfKlmUOCjfKKp30ixZ2
         TPAwyyuMHpOKM5P6fCOTZiC++vtY26Gn5LhXJvPj5ptm9HguYYOXI1oTYz0Tg+g4iuTO
         wgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340914; x=1710945714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qyza15vzLpvyPMhUd5jAdze5xBbHjlf2omLucHJ3cjY=;
        b=jZdq9Qe4O29s1V4kOGSndymJkGaNdlZP5vNmPm9R6/HbHtAvFwE6Ed6vfB0d7z5Fvw
         sT1MZy2FEQsuCaaPG0kuNX7P3yo7tcbh8akBWDc26WBOxQKxRbGeFEzpr5RC7Bw1KmUa
         tcWfu97HYyH1XF1aq6WCE32BF7YqjGudTqM3F1onjPFb4hwEslN+wTh7RxOS6T9sEb9B
         kAujQm1/xl7myMh3uQYj2EOICSjzVisgFO1//185TG7DiBSm7GWrQfQhl3gZ/FRr9Ssm
         K/g0GhJLKtYL4x5PutJ9DhxR1GbKmIWF2MyO8C21LwYDbbsjX/Aeu85PkeUKJgqiwF8u
         AzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE/V3cY6qgIV7nWTY1teifDJqUQkDRvFn/Jwfw6577BNJ+9SCJ37gMPM66yQOp76LjuBH1WGWCtsIvJQ91RAU1yJrIkV8TjXXcpbwq
X-Gm-Message-State: AOJu0YwccHVOuIKrFJD4sdY2kMGMUunLfK2QBLBOh2FGd942FdXJ/wYQ
	B3sqJnqk7Pyoh4uan0BEeNbBTjo3GtM0CrsJ6q0M1fBBnTESfuBMW5HjId8ZshnJYBCliBCJM5m
	CXp+afSjogiu9u0i8lLAssxUTt6yujdbyc4pf
X-Google-Smtp-Source: AGHT+IFUGJ7RGIpI/SpKlWXEVN+GnmAYmOYpP6RBV02YK44qzupP1X+wIECLxOlLIv5k2iX8BPoAuVGSQrmR/RNycu0=
X-Received: by 2002:a05:6102:3714:b0:473:ed7:fbc with SMTP id
 s20-20020a056102371400b004730ed70fbcmr102731vst.5.1710340914104; Wed, 13 Mar
 2024 07:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312180814.3373778-1-bigeasy@linutronix.de> <20240312180814.3373778-3-bigeasy@linutronix.de>
In-Reply-To: <20240312180814.3373778-3-bigeasy@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Mar 2024 15:41:18 +0100
Message-ID: <CANpmjNNYNxMMSdWFiPiT3i888fi8--k_H0xMX7i17VCT97vARg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf: Enqueue SIGTRAP always via task_work.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 19:08, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> A signal is delivered by raising irq_work() which works from any context
> including NMI. irq_work() can be delayed if the architecture does not
> provide an interrupt vector. In order not to lose a signal, the signal
> is injected via task_work during event_sched_out().
>
> Instead going via irq_work, the signal could be added directly via
> task_work. The signal is sent to current and can be enqueued on its
> return path to userland instead of triggering irq_work. A dummy IRQ is
> required in the NMI case to ensure the task_work is handled before
> returning to user land. For this irq_work is used. An alternative would
> be just raising an interrupt like arch_send_call_function_single_ipi().
>
> During testing with `remove_on_exec' it become visible that the event
> can be enqueued via NMI during execve(). The task_work must not be kept
> because free_event() will complain later. Also the new task will not
> have a sighandler installed.
>
> Queue signal via task_work. Remove perf_event::pending_sigtrap and
> and use perf_event::pending_work instead. Raise irq_work in the NMI case
> for a dummy interrupt. Remove the task_work if the event is freed.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/perf_event.h |  3 +--
>  kernel/events/core.c       | 45 +++++++++++++++++---------------------
>  2 files changed, 21 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a9..24ac6765146c7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -781,7 +781,6 @@ struct perf_event {
>         unsigned int                    pending_wakeup;
>         unsigned int                    pending_kill;
>         unsigned int                    pending_disable;
> -       unsigned int                    pending_sigtrap;
>         unsigned long                   pending_addr;   /* SIGTRAP */
>         struct irq_work                 pending_irq;
>         struct callback_head            pending_task;
> @@ -959,7 +958,7 @@ struct perf_event_context {
>         struct rcu_head                 rcu_head;
>
>         /*
> -        * Sum (event->pending_sigtrap + event->pending_work)
> +        * Sum (event->pending_work + event->pending_work)
>          *
>          * The SIGTRAP is targeted at ctx->task, as such it won't do changing
>          * that until the signal is delivered.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c7a0274c662c8..e9926baaa1587 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2283,21 +2283,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>                 state = PERF_EVENT_STATE_OFF;
>         }
>
> -       if (event->pending_sigtrap) {
> -               bool dec = true;
> -
> -               event->pending_sigtrap = 0;
> -               if (state != PERF_EVENT_STATE_OFF &&
> -                   !event->pending_work) {
> -                       event->pending_work = 1;
> -                       dec = false;
> -                       WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -                       task_work_add(current, &event->pending_task, TWA_RESUME);
> -               }
> -               if (dec)
> -                       local_dec(&event->ctx->nr_pending);
> -       }
> -
>         perf_event_set_state(event, state);
>
>         if (!is_software_event(event))
> @@ -6741,11 +6726,6 @@ static void __perf_pending_irq(struct perf_event *event)
>          * Yay, we hit home and are in the context of the event.
>          */
>         if (cpu == smp_processor_id()) {
> -               if (event->pending_sigtrap) {
> -                       event->pending_sigtrap = 0;
> -                       perf_sigtrap(event);
> -                       local_dec(&event->ctx->nr_pending);
> -               }
>                 if (event->pending_disable) {
>                         event->pending_disable = 0;
>                         perf_event_disable_local(event);
> @@ -9592,14 +9572,17 @@ static int __perf_event_overflow(struct perf_event *event,
>
>                 if (regs)
>                         pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> -               if (!event->pending_sigtrap) {
> -                       event->pending_sigtrap = pending_id;
> +               if (!event->pending_work) {
> +                       event->pending_work = pending_id;
>                         local_inc(&event->ctx->nr_pending);
> -                       irq_work_queue(&event->pending_irq);
> +                       WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> +                       task_work_add(current, &event->pending_task, TWA_RESUME);
> +                       if (in_nmi())
> +                               irq_work_queue(&event->pending_irq);

Some brief code comments here would help having to dig through git
history to understand this.

>                 } else if (event->attr.exclude_kernel && valid_sample) {
>                         /*
>                          * Should not be able to return to user space without
> -                        * consuming pending_sigtrap; with exceptions:
> +                        * consuming pending_work; with exceptions:
>                          *
>                          *  1. Where !exclude_kernel, events can overflow again
>                          *     in the kernel without returning to user space.
> @@ -9609,7 +9592,7 @@ static int __perf_event_overflow(struct perf_event *event,
>                          *     To approximate progress (with false negatives),
>                          *     check 32-bit hash of the current IP.
>                          */
> -                       WARN_ON_ONCE(event->pending_sigtrap != pending_id);
> +                       WARN_ON_ONCE(event->pending_work != pending_id);
>                 }
>
>                 event->pending_addr = 0;
> @@ -13049,6 +13032,13 @@ static void sync_child_event(struct perf_event *child_event)
>                      &parent_event->child_total_time_running);
>  }
>
> +static bool task_work_cb_match(struct callback_head *cb, void *data)
> +{
> +       struct perf_event *event = container_of(cb, struct perf_event, pending_task);
> +
> +       return event == data;
> +}
> +
>  static void
>  perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  {
> @@ -13088,6 +13078,11 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>                  * Kick perf_poll() for is_event_hup();
>                  */
>                 perf_event_wakeup(parent_event);
> +               if (event->pending_work &&
> +                   task_work_cancel_match(current, task_work_cb_match, event)) {

Brief comment which case this covers would be good.

> +                       put_event(event);
> +                       local_dec(&event->ctx->nr_pending);
> +               }
>                 free_event(event);
>                 put_event(parent_event);
>                 return;
> --
> 2.43.0
>

