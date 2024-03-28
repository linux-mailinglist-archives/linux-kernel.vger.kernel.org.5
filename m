Return-Path: <linux-kernel+bounces-123205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8F890474
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660C51C24172
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB4131BA7;
	Thu, 28 Mar 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Axv+du0e"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D81311B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641768; cv=none; b=h4NtPOpB+vK0PbB5DeoY92Vtl8Pn4u/zmDQWgnNS6NeOl3xzvsEPywS7l75jPFDnYZIktwvvy7qkWG/Uby0dDOIeUCDrKmv/nD+51yCsIpOiCei+rlA97OOvsGhS+7mWuLftkTYIOFErSsHudGlXzXwaCKdU5Lp3EjV+AE91MnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641768; c=relaxed/simple;
	bh=3edFfHGuTgBNAtyipnLKn6bXij3/XaZeoLIupKMiaqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVUSVB/1ysgqyxuxgCXOFgqAQyiz73Xq0C3FIdqVett4PIApKBL3DlI8OETkNtjCh8BXQmaeZij8gBmFlEAAcVDWffBICESbO1czvjSxT+N8C8OU3/PLaNQOELVQ/mVi/IEcE3HaBBn57hQsekjwuMElJlJdTJgGtSAGG7aAF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Axv+du0e; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36899c4e544so95595ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711641766; x=1712246566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBP7eIuQCT3cz5tMBaiLfJfh0r9VLr4sISDdgfizVcc=;
        b=Axv+du0e20K0bEUGJkG0c6h8oCQxsiNH3REaD/MaU+c+6f/kqQUlSU5nB6qPZ/KMn6
         nXZvSnJEz+GOIEDz95dUxrTp9S5nTYYvfXSC6ZhfcS3ifyUmSjxNc7h7B6bWpBDF2vZ2
         N5fUlZ57z1vvli75VtmoGjlMXNnpdEkuVxzmzawY/pgJfJodFYiErakRw5Qo+ic57892
         LXcDEwhKfiixzvfy7Ek7S8VxeDF5mADV4PmkE6mpDFjfCu3IfU+G/j37DEptDZKD8xVP
         j3A0df5eZMfyc7Z+gd+EUQ1atmJYSrZWsWUfxbSR2Pus5i9kryArldHXWLUIHiywZl7l
         xqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641766; x=1712246566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBP7eIuQCT3cz5tMBaiLfJfh0r9VLr4sISDdgfizVcc=;
        b=XaM9XaaiZdK40IYC5rBK44hk/JibOSLX8uRGx+uV35FF/7MBcJdtRkuk2DAEP4+8CS
         QNo2CmHy4zQ3kPC0FggYCP9ct4VUbG24oViSERZ58ju0MKI4eq4uZnh+pqXHL6U/OQAm
         jtKl3o2/5epldNxAwPupUMXfF8PRo32HnCnwMMC2BLO3wYBlrythyMag17x1+NBP3DbB
         mgdgxPLNM3qhmPHxuqyaCgqNuwVZdFkQceIaKG5F7jT2DVeoMsfIo7JspEa3mLUdWkGe
         6rWeSXXmZEgpZZmJ9GC1hMTb42Ufl8VwMBwUJT9RXpKtV1H5HMCIGfgV5MNKggi6KESh
         sNIg==
X-Forwarded-Encrypted: i=1; AJvYcCVcIUIcSTjvPat7B+KVqnzAegL/kdzt1Nm7+UQevc7sVa0sY+glt8QERkre1MMA3H6st5u2LOMMs5jr2mppWpOsRWanFC/TBOF6NPAe
X-Gm-Message-State: AOJu0YwexUqipLRNcRrLbC86K4LM+fHP4gtYBgIyvC/lCp8uspgg12b5
	36/O/M5rjrDehuMxPitp/H9AL1+XjEQr0jixOOSC0PYl1qMd8hpM+EezJAAWTTSsVATgjAd//78
	+CqeYuPithvCkXBNoubjEqHndSS/vD614dCs1
X-Google-Smtp-Source: AGHT+IE5sRRSnP6efrA0k65ve35cCb8jUxUvvFxl3PT4/ywpy6rDE0IK6F6PHTRirrQJFC7P30wEEgmC93Ik8v/WnaU=
X-Received: by 2002:a05:6e02:1647:b0:366:4365:e83d with SMTP id
 v7-20020a056e02164700b003664365e83dmr264174ilu.4.1711641765514; Thu, 28 Mar
 2024 09:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328055857.383180-1-yangjihong@bytedance.com>
In-Reply-To: <20240328055857.383180-1-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 Mar 2024 09:02:31 -0700
Message-ID: <CAP-5=fXms1noWT8PXqBu89QogcwVsvAGpxq3Q_bNUYOYL7PpKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf sched timehist: Fix -g/--call-graph option failure
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:59=E2=80=AFPM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> When perf-sched enables the call-graph recording, sample_type of dummy
> event does not have PERF_SAMPLE_CALLCHAIN, timehist_check_attr() checks
> that the evsel does not have a callchain, and set show_callchain to 0.
>
> Currently perf sched timehist only saves callchain when processing
> sched:sched_switch event, timehist_check_attr() only needs to determine
> whether the event has PERF_SAMPLE_CALLCHAIN.
>
> Before:
>   # perf sched record -g true
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 4.153 MB perf.data (7536 samples) ]
>   # perf sched timehist
>   Samples do not have callchains.
>              time    cpu  task name                       wait time  sch =
delay   run time
>                           [tid/pid]                          (msec)     (=
msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ----=
-----  ---------
>     147851.826019 [0000]  perf[285035]                        0.000      =
0.000      0.000
>     147851.826029 [0000]  migration/0[15]                     0.000      =
0.003      0.009
>     147851.826063 [0001]  perf[285035]                        0.000      =
0.000      0.000
>     147851.826069 [0001]  migration/1[21]                     0.000      =
0.003      0.006
>   <SNIP>
>
> After:
>   # perf sched record -g true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.572 MB perf.data (822 samples) ]
>   # perf sched timehist
>              time    cpu  task name                       wait time  sch =
delay   run time
>                           [tid/pid]                          (msec)     (=
msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ----=
-----  ---------
>     144193.035164 [0000]  perf[277062]                        0.000      =
0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <-=
 __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_=
for_common <- wait_for_completion
>     144193.035174 [0000]  migration/0[15]                     0.000      =
0.003      0.009    __traceiter_sched_switch <- __traceiter_sched_switch <-=
 __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
>     144193.035207 [0001]  perf[277062]                        0.000      =
0.000      0.000    __traceiter_sched_switch <- __traceiter_sched_switch <-=
 __sched_text_start <- preempt_schedule_common <- __cond_resched <- __wait_=
for_common <- wait_for_completion
>     144193.035214 [0001]  migration/1[21]                     0.000      =
0.003      0.007    __traceiter_sched_switch <- __traceiter_sched_switch <-=
 __sched_text_start <- smpboot_thread_fn <- kthread <- ret_from_fork
> <SNIP>

This looks good, should there be a Fixes tag for the sake of backports?

Thanks,
Ian

> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/builtin-sched.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b248c433529a..1bfb22347371 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2963,8 +2963,11 @@ static int timehist_check_attr(struct perf_sched *=
sched,
>                         return -1;
>                 }
>
> -               if (sched->show_callchain && !evsel__has_callchain(evsel)=
) {
> -                       pr_info("Samples do not have callchains.\n");
> +               /* only need to save callchain related to sched_switch ev=
ent */
> +               if (sched->show_callchain &&
> +                   evsel__name_is(evsel, "sched:sched_switch") &&
> +                   !evsel__has_callchain(evsel)) {
> +                       pr_info("Samples of sched_switch event do not hav=
e callchains.\n");
>                         sched->show_callchain =3D 0;
>                         symbol_conf.use_callchain =3D 0;
>                 }
> --
> 2.25.1
>

