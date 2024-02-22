Return-Path: <linux-kernel+bounces-77397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965008604BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DAA1C21813
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E773F33;
	Thu, 22 Feb 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+wikRIw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E273F2A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637062; cv=none; b=AvQxtdxbBYJClltFD4EDvgjTkWpafhJO3fLMim58LBmtPvOQdRTRC77w/YZlki0hwXih9b65jpG3eotT5zWMy5o1M+hQb7yCsd8K/NJOzu6clr2HK7PRVZu/1Cu9Ompxddc/5qHVb5592vmkKyuwjByr+vuAaopEA9rCyOcr3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637062; c=relaxed/simple;
	bh=8fZNkjIZSzhwgzqBA1AdsWBnlzPg9DfiMiZDXJh/8cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZL9V8VKzz6qd/E82zh73RFiuS7pBwYpWZ7CrN01AyfSOnf4kO2CzZUT4GYOJ7jBzo60RVRnERzI7t1SQtaDIDNLM71aShhthGwDr+iQM58Sv9AbZPY7FjxWRKuK6JO9BWT3hmH3MJP4J4qDLfrvru6LW/YA7MKMjTOQTz/Wt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+wikRIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708637059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBl1UBDYmWdAWb21oW2JNBv7BuAopKYaRX/Qul+JHAs=;
	b=R+wikRIwc9NKzIACNqtMyP8dsUO/9P6YOpA2z2FHwALC9cdL00QVOlS6cVO609aBOnIqFT
	8/Je2hiZP5RTUPdudmEJhindlB/gB6hSL0kXMFtb/hbwfjRyeZfVutYazl1dRl3XaxDgA9
	HFwTVMSGyP00lZJy14Ltq1kIZtymaaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609--j8eIzWAPu64LCS_4AbaJg-1; Thu,
 22 Feb 2024 16:24:13 -0500
X-MC-Unique: -j8eIzWAPu64LCS_4AbaJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DAFA2812FF7;
	Thu, 22 Feb 2024 21:24:13 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 99D112166AEE;
	Thu, 22 Feb 2024 21:24:11 +0000 (UTC)
Date: Thu, 22 Feb 2024 16:24:09 -0500
From: Phil Auld <pauld@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com,
	Zimuzo Ezeozue <zezeozue@google.com>
Subject: Re: [PATCH] [RFC] sched: Add trace_sched_waking() tracepoint to
 sched_ttwu_pending()
Message-ID: <20240222212409.GA396872@lorien.usersys.redhat.com>
References: <20240222204917.1719153-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222204917.1719153-1-jstultz@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Feb 22, 2024 at 12:49:03PM -0800 John Stultz wrote:
> Zimuzo reported seeing occasional cases in perfetto traces where
> tasks went from sleeping directly to trace_sched_wakeup()
> without always seeing a trace_sched_waking().
> 
> Looking at the code, trace_sched_wakeup() is only called in
> ttwu_do_wakeup()
> 
> The call paths that get you to ttwu_do_wakeup() are:
> try_to_wake_up() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeup()
> sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()
> 
> where trace_sched_waking() is currently called only in
> try_to_wake_up().
> 
> So this patch adds a trace_sched_waking() call to
> sched_ttwu_pending(), so we see the same state machine
> transitions.
> 
> With this change, the number of unexpected state transitions
> in perfetto was greatly reduced.
> 
> This has been in my drafts for awhile, so I wanted to send
> this out for thoughts/feedback.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: kernel-team@android.com
> Reported-by: Zimuzo Ezeozue <zezeozue@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..233f06360d6a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3894,6 +3894,7 @@ void sched_ttwu_pending(void *arg)
>  		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
>  			set_task_cpu(p, cpu_of(rq));
>  
> +		trace_sched_waking(p);
>  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
>  	}
>  
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 
> 

This looks okay to me.

Maybe s/this patch adds/add/. Otherwise the changelog is nice and
complete.

Reviewed-by: Phil Auld <pauld@redhat.com>

Cheers,
Phil
-- 


