Return-Path: <linux-kernel+bounces-106465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74187EF03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157861F22434
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183355C1E;
	Mon, 18 Mar 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iD7p+ozw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463B54F9C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783290; cv=none; b=DL1paoFIbOvFCKURaV0vUc0iOJrl234NuK+5Xq27ANXtn1IwqWo+rtpFItmYHhStDtwCm8YqLndZV3a2nPEQ8/+sk/nshF9Fl02YlB/LeD+cl2X53fKxdswKytxHUJexvlq3uS42NfumLmOMXSGsFc5ciJ2H/A7Appp+eNdiQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783290; c=relaxed/simple;
	bh=3iaop3a58uHKADlQcfRI1jJ8IYIC7oQNRC98DXDnUV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IgE5WMOV0j7zRIxR0R84ngqsmjlG/eTu7y4l5MzYSQ2ZTZEB167JbxwvzZFdTCyIbQLc5JYpnBDn13m81vbDOXfOA8g27RssWQ3lHrdVnDF8nC6du/n/SppSd65Nc99yWokHU2Mi3wzEh/BqGJ/8x5ZEBqg9QYgoJyYZpeqbx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iD7p+ozw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710783287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kd3/KuROcegeJ4IEXQZcY+p0ull0SaScgtMChZmBUjY=;
	b=iD7p+ozw+I1v+5OGuf5uXcF8CgBd2rTkyo8ssKx83NSC1QVP2GJ5DzrmQz/l59hEgiYzLm
	EtcqdDKnfX4+78LDM5iqHuC2m+MVQtxN03S94eJLviPJJsy7Lc88KJXiIAzR+g2uq79DJ3
	Kgo7defGhCrPFV1HkArff8HB64vdM0o=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-JIk4lx9EMmKRb_xWp1NCGQ-1; Mon, 18 Mar 2024 13:34:44 -0400
X-MC-Unique: JIk4lx9EMmKRb_xWp1NCGQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c385de08aeso1600656b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783282; x=1711388082;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kd3/KuROcegeJ4IEXQZcY+p0ull0SaScgtMChZmBUjY=;
        b=OpUxw0P2hm51lv0RMzYQyrbZDr4KNT+zQ+mR4w2842j8vXUEeQhaQ9b1wvaVSo7sSv
         eB7YcDSyBietmjw3I3Ll5Li00Ob7ByA0NIx0CzsttHq8O+Xwnd2GBEgOf53viKXW2PqL
         1cmXZDyq+Vw5TEjP5nYuUfQi7M0NK88FJKj9CFCy8jkvp1Al8vE7NJL0DJxM8qjH5FXl
         tXkrBA3KZ4cazTtsG1BoJN9ZwPqrNR20nLcA9rdFMDOKQgiKulZew8TpFLuhtkinXqit
         tplBJ1rdZktbHdNmJarB/tWQ7RT/dou3zNMV1dDCNwvASIVaH95NOTFEcq5nM1xU6WC3
         DG3g==
X-Forwarded-Encrypted: i=1; AJvYcCXfBMbQH4ibSisaxfFbXHxPGaUw6Cwkn6SmF0VYnbO68G4m/tKAOhI25g56zhyh1StQUpHd2mxiMEVU6Ke+3+nXi+G7yCz+0aCwEE8W
X-Gm-Message-State: AOJu0YwEFudywxmKKBLxKDzrH7sggRXR06tmHaP5iw7ZbX1tae6qe527
	QuChAHjAVd8woRsP5y4zuWAAikNwJ/1Jl6Gsam1A7VrU85bCaerJ9wWFPrFDnsdFyoKSi+QZE7g
	tL4xWFz0qwVLr7+DZX3RbmmvYuJCngGuxsIaPwSXIKF+hYTcITASdYm19ezqv0zH6RTH48EGYoe
	JKATv4o/T2v+Y5YMGGmSDnmzdm1gKU/e4X1g9AK2jxkhBRSg==
X-Received: by 2002:a05:6808:e85:b0:3c2:52b5:23ab with SMTP id k5-20020a0568080e8500b003c252b523abmr15636593oil.50.1710783282411;
        Mon, 18 Mar 2024 10:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF46gf+0UHB4+cNMdwNpj07RpQnTrUPPq56CQg9XXcWz4a//IkkI11Sz3zKkiE6+1HeUNqjyA==
X-Received: by 2002:a05:6808:e85:b0:3c2:52b5:23ab with SMTP id k5-20020a0568080e8500b003c252b523abmr15636557oil.50.1710783282120;
        Mon, 18 Mar 2024 10:34:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id gg8-20020a056214252800b00690befbe5a5sm5514612qvb.74.2024.03.18.10.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:34:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Daniel Vacek <neelx@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org, Bill Peters
 <wpeters@atpco.net>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix affine_move_task failure case
In-Reply-To: <20240318111750.3097906-1-neelx@redhat.com>
References: <20240318111750.3097906-1-neelx@redhat.com>
Date: Mon, 18 Mar 2024 18:34:37 +0100
Message-ID: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 18/03/24 12:17, Daniel Vacek wrote:
> Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.
>
> Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
> can fail when racing with off-/on-lining resulting in a deadlock waiting for
> the pending migration stop work completion which is never done.
>
> Fix this by correctly handling such a condition.
>

IIUC the problem is that the dest_cpu and its stopper thread can be taken
down by take_cpu_down(), and affine_move_task() currently isn't aware of
that. I thought we had tested this vs hotplug, but oh well...

> Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
> Cc: stable@vger.kernel.org
> Reported-by: Bill Peters <wpeters@atpco.net>
> Tested-by: Bill Peters <wpeters@atpco.net>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  kernel/sched/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc903467..d0ff5c611a1c8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3069,8 +3069,17 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>               preempt_disable();
>               task_rq_unlock(rq, p, rf);
>               if (!stop_pending) {
> -			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> -					    &pending->arg, &pending->stop_work);
> +			stop_pending =
> +				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> +						    &pending->arg, &pending->stop_work);
> +
> +			if (!stop_pending) {
> +				rq = task_rq_lock(p, rf);
> +				pending->stop_pending = false;
> +				p->migration_pending = NULL;
> +				task_rq_unlock(rq, p, rf);
> +				complete_all(&pending->done);
> +			}

This can leave the task @p on a now-illegal CPU; consider a task affined to
CPUs 0-1, migrate_disable(); then affined to CPUs 2-3, then in
migrate_enable() the dest_cpu is chosen as 3 but that's racing with it
being brought down. The stop_one_cpu_nowait() fails, and we leave the task
on CPUs 0-1.

Issuing a redo of affine_move_task() with a different dest_cpu doesn't
sound great, and while very unlikely that doesn't have forward progress
guarantees.

Unfortunately we can't hold the hotplug lock during the affinity change of
migrate_enable(), as migrate_enable() isn't allowed to block.

Now, the CPU selection in __set_cpus_allowed_ptr_locked() that is passed
down to affine_move_task() relies on the active mask, which itself is
cleared in sched_cpu_deactivate() and is followed by a
synchronize_rcu().

What if we made the affinity change of migrate_enable() an RCU read-side
section? Then if a CPU X is observed as active in
  migrate_enable()->__set_cpus_allowed_ptr_locked()
, then its' hotplug state cannot go lower than CPUHP_AP_ACTIVE until the task is
migrated away.

Something like the below. Thoughts?
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 929fce69f555e..c6d128711d1a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2450,8 +2450,11 @@ void migrate_enable(void)
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
 	 */
 	guard(preempt)();
-	if (p->cpus_ptr != &p->cpus_mask)
+	if (p->cpus_ptr != &p->cpus_mask) {
+		guard(rcu)();
 		__set_cpus_allowed_ptr(p, &ac);
+	}
+
 	/*
 	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
 	 * regular cpus_mask, otherwise things that race (eg.


