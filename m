Return-Path: <linux-kernel+bounces-137321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A355389E062
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49851C2103F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F913E41F;
	Tue,  9 Apr 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFHZx1YB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB513E400
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680213; cv=none; b=F++6mC8pr2Ocijshb88fNFy/xY/dJsVP/yYu2TAuUfrbFE/RVY1WTeMv9oKGa+aUNWvKwbODWz/qqKmZwZhDy4Kv0tKS7mCE8tY0aLtbgSERWnWZcAS8dmwPWjhmehXrR4+c74Grz6QyueXNRoyQRk20Xcd+Nw4tDbrwzAwOjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680213; c=relaxed/simple;
	bh=DFOzieDuAL+zwmbA47qxk0Y2Ai2LA/jilIkINPKmX/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKm/xiMZR7fjUtZco4Ty132kULscENrzbFIL6Ah5qmNcL+EF6G3lOLbosn8KYlcYSmZkpW82x46UoyhRx6REs9IMPLYmDHlpIvqsn7q/YXfYqMmbIKjcLO2LKoV6Woro/yqD4Uk2gibbKMMKJFEKp0g/KQmy3VaGfWWfXd07mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFHZx1YB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712680210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2N15/vQsvR0nDOnw1tYJA2j128oangAGgtCd36y2W8=;
	b=JFHZx1YBxnYgStV786aHT6Xz6iHmI623tgaZ1BDgqn3rAH9b2172GpyMD1b5iweIr1+IRZ
	NCyv4CLDRYljNYuQ92X5UAjunHEjrxA/xNrPKTJBW6L2mJPyalrbhrF+ubuznxvWNm1LU2
	BseUcYmEpd2pkL92giPk+eNIcG2++Tg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-dZQJEE6JOke-v5KhCrPbSw-1; Tue, 09 Apr 2024 12:30:07 -0400
X-MC-Unique: dZQJEE6JOke-v5KhCrPbSw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d3352237cso835518085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680204; x=1713285004;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2N15/vQsvR0nDOnw1tYJA2j128oangAGgtCd36y2W8=;
        b=NSW1S7uUw1E3XSXIgHOnAB2uwh5GBk6q2nQRyp2hzP/wV6DPy6ZZn7E5wdB39oFZQt
         afyXMCgwCsKQwxlf+GU0BfF+XWdvlvjqQo7vcYbAjdMK/5ufASTjayEurWm1dJoclkSK
         8irW2RzRGKmaBbtPI5Ilkvd2yyITZDCN4MOlgjqKewYGXiaNtJOGZqWoVfdnYIyaGOJw
         JTKPTQzRd6YFJmxbWRZyQtEv/MYk4rFIlBzvYse0XBjOh4yoRhuV89uhWA6kB74nGP3m
         Z+Z9cu0Gbg0//ZxW/9eMny9pe7Hs7twGgBwC6b4sFoyrJbgUGgBnRBlq/1jIsqN3WRzi
         kN6w==
X-Forwarded-Encrypted: i=1; AJvYcCVQWIICnlmoRGckTUGKvBnn7DkjSWZvPwY6o03MHQL6UIDSHKHNjF0tUpk8iQUyMZwdw4QcMZhZ5MPzCBA7y3hS4VATqec5r6Onvsg9
X-Gm-Message-State: AOJu0YzwnYR7VU2xB//J+1pWTsFIvzmyrsTfBTjn5Y6HxnlP7cFz1JgT
	CILWlNyHaa33NwzJ9YU+9AALu9ASdRrAq3zHfQTShk5Rjo0Xz+JyWgP5CL0XnSAFjL2Mnk85qKt
	dWPmn2La6sKRQ0Yzv6EP33Wt/9szoZhKRck5ywyNdXd6Ki5ipL0m1PJMQXobg4A==
X-Received: by 2002:a05:620a:1a04:b0:78d:5d86:ee3a with SMTP id bk4-20020a05620a1a0400b0078d5d86ee3amr271165qkb.27.1712680203575;
        Tue, 09 Apr 2024 09:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaunIAnuq3r3o5QKqjTq71PbncpgxojMlNuf8undfiMQByOKkHlYoNcgKVeL0cSUpKYTduWA==
X-Received: by 2002:a05:620a:1a04:b0:78d:5d86:ee3a with SMTP id bk4-20020a05620a1a0400b0078d5d86ee3amr271092qkb.27.1712680203193;
        Tue, 09 Apr 2024 09:30:03 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id r30-20020a05620a03de00b0078d679f6efesm1805562qkm.16.2024.04.09.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:30:02 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Connor O'Brien <connoro@google.com>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Youssef
 Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen
 Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, John Stultz
 <jstultz@google.com>
Subject: Re: [RESEND][PATCH v9 4/7] sched: Add do_push_task helper
In-Reply-To: <20240401234439.834544-5-jstultz@google.com>
References: <20240401234439.834544-1-jstultz@google.com>
 <20240401234439.834544-5-jstultz@google.com>
Date: Tue, 09 Apr 2024 18:29:57 +0200
Message-ID: <xhsmh5xwqa48q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 01/04/24 16:44, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
>
> Switch logic that deactivates, sets the task cpu,
> and reactivates a task on a different rq to use a
> helper that will be later extended to push entire
> blocked task chains.
>
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Naming nit below notwithstanding:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch]
> Signed-off-by: John Stultz <jstultz@google.com>

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d2242679239e..16057de24ecd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3472,5 +3472,14 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
>  
>  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
> +#ifdef CONFIG_SMP
> +static inline
> +void do_push_task(struct rq *rq, struct rq *dst_rq, struct task_struct *task)

The naming IMO unfortunately clashes with the hotplug push_task /
balance_push() stuff.

AFAICT this is move_queued_task() but in a double rq lock
context. How about move_queued_task_locked()?

Interestingly, all the patched call sites end up with a resched_curr(), but
move_queued_task() has wakeup_preempt() instead.  

> +{
> +	deactivate_task(rq, task, 0);
> +	set_task_cpu(task, dst_rq->cpu);
> +	activate_task(dst_rq, task, 0);
> +}
> +#endif
>  
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.44.0.478.gd926399ef9-goog


