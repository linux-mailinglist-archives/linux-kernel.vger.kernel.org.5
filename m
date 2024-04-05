Return-Path: <linux-kernel+bounces-132673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CD899870
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC521F2186E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1B15F3E0;
	Fri,  5 Apr 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU+vHkfQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E31E898
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306977; cv=none; b=kWXAv3KZcX5ZqLR3sTA1jA9qrPBgm/oKjWvINwhPOjwp4x2X8IHD31hlu0qwPGNb8RvHRVgG3uRozxOytHdFyx/34RI/+xqetUCAUjywnEGlUgz0IemOlxRoQdPsYpIFxJMwF/W1p4QpL+u7gLOsYXlbOkulUQvP4wndiYqOLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306977; c=relaxed/simple;
	bh=CcGWoWhzEExD4MH4WkbMes6Va/FXnq1kW36mXut8klg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIP081G080jQV5ene3GGQY1DOx3e8aNVVgXED7OKoMTFdmTVvYxfbzpIRlBvqIbJXKjuGEyzdSvIhIu9SDL1E0e9qxqTRfVsLuRbYvNK7v51fXfUECPQzVXwCvCSB07J9KiGy2YFDS4dQONPM0li9DKfXD0NhVmEuoBxDe/somI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU+vHkfQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712306975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcM/YTlsSAdLdvSqzygbsbJd0JHZIm14V+q4HXF7Xd4=;
	b=VU+vHkfQzFpEHtdZkaCdYmaG6rLlf++WOjAZmQYBOFMXHQCYuIOiiLOcLN5/vZbjsCq4dw
	jnNgr9ddaQlr0W3kxS6j63I6+XUJufz9gzvEMab1C2ay+RAFM2hNZjoVdgme1AW0exqRJQ
	eeqgHNDEGomHKBAhB6conIuVZPpZ4jI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-s-bORnRvO2aS4LXPyj6Mug-1; Fri, 05 Apr 2024 04:49:33 -0400
X-MC-Unique: s-bORnRvO2aS4LXPyj6Mug-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51abd0d7c6so6722366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306972; x=1712911772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcM/YTlsSAdLdvSqzygbsbJd0JHZIm14V+q4HXF7Xd4=;
        b=PylEap65YMTK7MlF6mYZTMer8XqitT2GNWE3SyD6bAXiNiwHeHgs9bRMpsgVHSWEmZ
         Dl50CBSL2vfaRFQrg8jkUdAnruvlJbMF83zZXsD41s4gLAEY07xHD0e1beOuB0Cy9qMQ
         q171f6xpeApRZuc8MYQs3kZkHQIjsLkdzyNQb0+om1HWzedQ26or224fShz2pOaT4raZ
         3NEdq0OgQ7WhaQMA4JyqwWtlSyvEygEsrsBZM3LrBS+pv8q5Tx1B2tgQLj+0kfsRofX8
         7W4g2v6N+jCYPTyarsBD5c90OLFrG2aHmusf3P6OczcSZlthp6MJMfWraBwH/VRid1AB
         m8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH3l6IiHHA+7jt+6RICZeXKkdy+rEkbzW8KJZXptpH+M3rPs/3G+r+7tgyz3zj4mqrSPbC2T+BLlN/uV/fVPgILaGt/j0rkRTdeZxL
X-Gm-Message-State: AOJu0YyTLIxLJcnEGxrCU5sT//8AxRCNM2nTVm1KcarKLuWBWVaaiBAS
	2RM8VsluWI9DM7Xad8Gvaw3PY836SQHE+SHX0loZoJX6mqbOdmED3ACrMC0lhvFrcfYaNZwzIhk
	tAfig3k8NEiyMlRglLZ6OwsVpVRz1HXeDTJYrJVv19sb/rVBBW82P+djX55L94g==
X-Received: by 2002:a17:906:3791:b0:a4e:9324:8df4 with SMTP id n17-20020a170906379100b00a4e93248df4mr574498ejc.48.1712306972558;
        Fri, 05 Apr 2024 01:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg+C8Hwf/RkhomP7AdWKXe0Ug7DslPby8N9KMJptQ8O6P+kHKFiraUGLdw20NXyZvb+kea1g==
X-Received: by 2002:a17:906:3791:b0:a4e:9324:8df4 with SMTP id n17-20020a170906379100b00a4e93248df4mr574473ejc.48.1712306972182;
        Fri, 05 Apr 2024 01:49:32 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709062e8900b00a45c9945251sm584473eji.192.2024.04.05.01.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:49:31 -0700 (PDT)
Message-ID: <a9dd5c5e-0095-48f9-9628-d5901d469ff3@redhat.com>
Date: Fri, 5 Apr 2024 10:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] sched: server: Don't start hrtick for DL server
 tasks
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-7-joel@joelfernandes.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-7-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> From: Suleiman Souhlal <suleiman@google.com>
> 
> Otherwise, we might start it even for tasks in a sched class that should
> have it off.
> 
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  kernel/sched/deadline.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8fafe3f8b59c..5adfc15803c3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2325,11 +2325,12 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	if (!p)
>  		return p;
>  
> -	if (!p->dl_server)
> +	if (!p->dl_server) {
>  		set_next_task_dl(rq, p, true);
>  
> -	if (hrtick_enabled(rq))
> -		start_hrtick_dl(rq, &p->dl);
> +		if (hrtick_enabled(rq))
> +			start_hrtick_dl(rq, &p->dl);
> +	}

The rational for having hrtick for the dl server too is the following:

This hrtick is reponsible for adding a hr timer for throttling. The throttling
serves as a protection for the other tasks, to avoid them missing their deadlines
because the current task overun for too long. Like, a task with 200us of runtime
actually running for 1 ms because of the non-hr-tick.

For example, let's get the case we have at red hat, where we want to use the
dl server to provide a minimum bandwidth to avoid starvation, keeping the noise
on real-time tasks low.

On this case, we will set the runtime for the fair server with number as low
as 20 us... 40 us. With hrtick, when the fair server is enqueued, it will be
throttle in the us scale... Without the hrtick, the server can run for an entire
tick before being throttled.

here is an example of this scenario using osnoise with/withoutout arming the hrtick
for the server that was set for 20 us of runtime:

There is a kernel compilation in CPU 1. Then osnoise is dispatched as fifo,
on CPU 1.

 # osnoise -c 1 -P f:1

removing hrtick:
 ############
 duration:   0 00:02:00 | time is in us
 CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
   1 #119       119000000         6482    99.99455        1220         1009           0            0          244           59           50
 ############

See max single noise... it when longer than the 20 us i've set...

With hrtick:
 ############
  duration:   0 00:02:30 | time is in us
  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
    1 #149       149000472         3730    99.99749          33           33           0            0          641            3          155
 ############

the max single goes down to 33 us. It is not exactly 20 because there is
one timer to enqueue the server, and another timer to throttle it. Still,
the granularity is in the same order.

So, maybe, what we can do is to get it back to hrtick_enabled_dl() instead
of hrtick_enabled(), to have it only when HRTICK_DL is set.

am I missing a point?

-- Daniel


