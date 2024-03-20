Return-Path: <linux-kernel+bounces-108248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CF88085F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5835283F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645D29A5;
	Wed, 20 Mar 2024 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dhybEj/D"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2F1FA5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893042; cv=none; b=oz7ahmPNI5rdpaVLaU8vw95bO45B8V6clbqiT4aLiEs811TeqrCvEqwawxqyOI3YGcXsYViEJP08ROzuoM39oMegq8QKlqN9XUUWNk96KLmOgG+Fo6l4BBmWtmXc4kFc5CFZpKAzIlI06ubgKnPjwEozNYpZVcqlQ5KImEO5U7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893042; c=relaxed/simple;
	bh=LuszNrHNE3olo3sZitMiZZw0/T2Z59F2VU/B8FMRwHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQxlxd3laE442MhH/0RBdqHQXJVqtQw0PWBE+PrUMh/Yv8upiSoLwRZqgeIJPia4YWdZIYd2Kh2MAJFyxVwu/vGoTRH4rlYVzNrbxwM8WCB05emsMaEXWBQeMO3yEsgKvot+rI6Ck0Gl08HPcEJt27PKqJn4kxlcO0oOaqv9li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dhybEj/D; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc649c275so3080886b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710893040; x=1711497840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Qbceb+lLt0Ip+LsSuu3qrpAY4FihlRVRuRE1aZQsbA=;
        b=dhybEj/D1xUYc0IjsRCb45bEJswVZ/rHbHj57joPd/Lq57hVmghidGHOVJ4YspzCIj
         lI3/yQsv/y63rafMC/Ud3kHPb5irVlIryyguzyDgIU3n8+DXR4ETqUxk5bLVcUj4mWPK
         YPTWP76WX238BQjZL8mLQGhiqdgWv326z5oA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710893040; x=1711497840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Qbceb+lLt0Ip+LsSuu3qrpAY4FihlRVRuRE1aZQsbA=;
        b=dE0NddFfrnhQ5NRZjCierfbSeN+AzyWsuirTPNASkD5RBCzCorx8AGDXSndLn4LLdP
         +RnVI82+MsBZz0Zkh7d3TRdcTYojPfJo4WJ3qYYUJ9r9AZjna3bF+fnpN65K4d43P7Z6
         mXVbGNyiHb8hkBjdkDqfnXFNpSkNdbVYYLpMNteTuho2Pl47+wUq8lck69EzbnVkzhQO
         BBSxq/R8x+jg0EWTAoIUWQLWs7zZ9heczyo2Y6TeLpEqRyvZueQuzctADChxe8G8GGCX
         ERYKKVzN5VdoxnFU7YZH6qAARgj/RK2Dcs7xsf9uQPoBSCLfH4QlayishsX9EeZVH6o/
         gUug==
X-Forwarded-Encrypted: i=1; AJvYcCUnXSkPDqQgPkkZSQujudgrAByzd45yB7LOVqDQToeIdzWXT2H2wfK51dOojn/nb23f3RybmsDc4hk87bURdxgPwCfz2DR4Rb5zWAJ6
X-Gm-Message-State: AOJu0Yy3+KO6PH5G1KowI9gjORsM0EwY7c/1IyQcdilLDr/fzGnCnVBg
	0MiVXaAizmfIPL6LapWOC0aawFnBfPCUBfedO57ogvsYur4XSXUbLN0/J41jsKY=
X-Google-Smtp-Source: AGHT+IGQNavc3elhq3ZEquvGluzRYpuOA0aTVN3ZvVgPCt5X8K9P56sw35hditqzCJJiDqlIhpIVgA==
X-Received: by 2002:a05:6808:3a08:b0:3c3:9980:d5fa with SMTP id gr8-20020a0568083a0800b003c39980d5famr978030oib.28.1710893039552;
        Tue, 19 Mar 2024 17:03:59 -0700 (PDT)
Received: from [10.5.0.2] ([185.195.59.198])
        by smtp.gmail.com with ESMTPSA id cg11-20020a05622a408b00b00430dbd6edf9sm2129289qtb.68.2024.03.19.17.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 17:03:58 -0700 (PDT)
Message-ID: <1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
Date: Tue, 19 Mar 2024 20:03:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
> Among the motivations for the DL servers is the real-time throttling
> mechanism. This mechanism works by throttling the rt_rq after
> running for a long period without leaving space for fair tasks.
> 
> The base dl server avoids this problem by boosting fair tasks instead
> of throttling the rt_rq. The point is that it boosts without waiting
> for potential starvation, causing some non-intuitive cases.
> 
> For example, an IRQ dispatches two tasks on an idle system, a fair
> and an RT. The DL server will be activated, running the fair task
> before the RT one. This problem can be avoided by deferring the
> dl server activation.
> 
> By setting the zerolax option, the dl_server will dispatch an
> SCHED_DEADLINE reservation with replenished runtime, but throttled.
> 
> The dl_timer will be set for (period - runtime) ns from start time.
> Thus boosting the fair rq on its 0-laxity time with respect to
> rt_rq.
> 
> If the fair scheduler has the opportunity to run while waiting
> for zerolax time, the dl server runtime will be consumed. If
> the runtime is completely consumed before the zerolax time, the
> server will be replenished while still in a throttled state. Then,
> the dl_timer will be reset to the new zerolax time
> 
> If the fair server reaches the zerolax time without consuming
> its runtime, the server will be boosted, following CBS rules
> (thus without breaking SCHED_DEADLINE).
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Hi, Daniel,
We have one additional patch (other than the 15 I just sent). Since I have just
3 more working days for the next 3 weeks, I thought I might as well reply inline
here since it might be unnecessary to resend all 15 patches so soon just for the
one new addition below. I am replying to this patch here, because the new patch
is related (to 0-laxity).  But once I am back from holiday, I can resend it with
the set I have unless you've applied it.

So, Vineeth and me came up with a patch below to "max cap" the DL server 0-lax
time (max cap is default off keeping the regular behavior). This is needed to
guarantee bandwidth for periodic CFS runners/sleepers.

The example usecase is:

Consider DL server params 25ms / 50ms.

Consider CFS task with duty cycle of 25ms / 76ms (run 25ms sleep 51ms).

         run 25ms                    run 25ms
         _______                     _______
        |       | sleep 51          |       |  sleep 51
-|------|-------|---------|---------|-------|----------|--------|------> t
 0     25      50       101        126      151       202      227
                          \ 0-lax /                    \ 0-lax /

Here the 0-lax addition in the original v5's zero-lax patch causes lesser bandwidth.

So the task runs 50ms every 227ms, instead of 50ms every 152ms.

A simple unit test confirms the issue, and it is fixed by Vineeth's patch below:

Please take a look at the patch below (applies only to v5.15 but Vineeth is
rebase on mainline as we speak), thanks.

-----8<--------
From: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Subject: [PATCH] sched/deadline/dlserver: sysctl for dlserver maxdefer time

Inorder to avoid dlserver preempting RT tasks when it wakes up, dlserver
is throttled(deferred) until zero lax time. This is the farthest time
before deadline where dlserver can meet its deadline.

Zero lax time causes cfs tasks with sleep/run pattern where the cfs
tasks doesn't get the bandwidth promised by dlserver. So introduce a
sysctl for limiting the defer time of dlserver.

Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 include/linux/sched/sysctl.h | 2 ++
 kernel/sched/deadline.c      | 6 ++++++
 kernel/sysctl.c              | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 4939e6128840..a27fba6fe0ab 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,6 +41,8 @@ extern unsigned int sysctl_iowait_apply_ticks;
 extern unsigned int sysctl_sched_dl_period_max;
 extern unsigned int sysctl_sched_dl_period_min;
 +extern unsigned int sysctl_sched_dlserver_maxdefer_ms;
+
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d638cc5b45c7..69c9fd80a67d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1071,6 +1071,11 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
 	if (dl_se->dl_defer_armed) {
 		WARN_ON_ONCE(!dl_se->dl_throttled);
 		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+		if (sysctl_sched_dlserver_maxdefer_ms) {
+			ktime_t dlserver_maxdefer = rq_clock(rq) +
ms_to_ktime(sysctl_sched_dlserver_maxdefer_ms);
+			if (ktime_after(act, dlserver_maxdefer))
+				act = dlserver_maxdefer;
+		}
 	} else {
 		act = ns_to_ktime(dl_next_period(dl_se));
 	}
@@ -3099,6 +3104,7 @@ void __getparam_dl(struct task_struct *p, struct
sched_attr *attr)
  */
 unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
 unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+unsigned int sysctl_sched_dlserver_maxdefer_ms = 2;
  /*
  * This function validates the new parameters of a -deadline task.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 39f47a871fb4..027193302e7e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1842,6 +1842,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "sched_dlserver_maxdefer_ms",
+		.data		= &sysctl_sched_dlserver_maxdefer_ms,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
-- 
2.40.1



