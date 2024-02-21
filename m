Return-Path: <linux-kernel+bounces-74316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C367385D2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B34B24A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA293C499;
	Wed, 21 Feb 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFfFOmAT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264E23C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504809; cv=none; b=Jcdp7qtibLClEEarh/G8lV8XFEE/3dgx+4EQkUqPvyghKJEgvfkBphxv3eK5wX1uOT/7IqFNKy5ccmtTGABYYpRjlqfmXQKz7QoHIQrcjt9g1Cd+g4PTjK9M+ylqcHFwHqbAVbB1cvskIYoibDmsBY5fcVU/B11orQ9ixgHD3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504809; c=relaxed/simple;
	bh=pUEl11BcCsOIEWi6Mzedew/TXQso5EQeV2AjKG2VvmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB1e03MZ9IxR6j6/uJXt1QfyLPCp+ZlK85fkI7IaWA1ldo/qFwKj7FkM2lNpLAWFFZOQ4xCDeTEKIMQR4A6uVAwBhvxsg3FLtQhYJqYpXexZuDjiYCInyghcwqi7Fp8u7gLVqhsp2FsunIlhWcLyA0Ggs1HHC1kDBkUS2v3JSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFfFOmAT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708504806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOO1jn5FlcHLjD2SbjQR7wjrXAyZAgfcEkviPlszCt8=;
	b=VFfFOmATsyNcraA/hw0gwSZrbBtYnFKgJtm5r2IGK1k9esugXL6P3TAK2n5s/oHZwyk08+
	UGrxIpB4vEWT8YKfPe2xMSmzOeIriFS9gyG1wImai6sF3lif8zMq8Ar9zpNmUEp9XO2wW5
	DJ7/4ti8AvTCWuAesX82OymbPdqZx1k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-B8GAVw51PcWyN7lDy9uLCQ-1; Wed, 21 Feb 2024 03:40:03 -0500
X-MC-Unique: B8GAVw51PcWyN7lDy9uLCQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3f3c382ba9so22468966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504802; x=1709109602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOO1jn5FlcHLjD2SbjQR7wjrXAyZAgfcEkviPlszCt8=;
        b=nDs/Lw7wEFQ8iiG+lj8CWGEwjjGRf7SiiEjdJAaT2Jb+bKEPAq4cW6+ZX65HuQYACK
         8bvhpmYX0B/i59qzNk2qSfQiUYVQSgO2pl5iry6eVjt37qd9qpf41QMn0+3DrFoJqDZE
         VYz7p+6HsfN7Y8NyipEhy1ptQT94a+JnWmCw6G0IwU7JpDtwXh0v4+UVVO7AXx3VDU+q
         Zfrk0d2ODOFdQZsubuZGf8wCsgjlO0RZfcdXhGyRZZ/UnFrZPeXAFxuYyGma8WZPtg14
         uOpHhu/TaefYI+DW8lKEdriomJBqDTAXZGdN36DCvVwthIy8jqTlp4YWNQjCRpFQzm7z
         LclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUysFRFraskZK4xEh5RtMpwY7wrQvRVBBruVqint6x+KGiMtcaOuNWce0NA44fslYPuwIRo+tDZU8eGYx8xc1lJv0LAIqjN5gDDkDge
X-Gm-Message-State: AOJu0YyD3VuiGhaLixU4mq/o9MpHzIDfMMq1sAsv9djiGKs2QO1tiRVj
	HDa6RyNtl9in56jeSHdbfU8wtMbPsprDlldxdRVKB9yDdshe4Kb1WV0YlEgVxn1BYDgkHr40G/6
	ULHIjRVlXcWSUa4Ioqyk1dqSRjcvIJ+DNs4yBtOSQ03wwSHoeXJQgJiutQokioA==
X-Received: by 2002:a17:906:3d3:b0:a3e:e3a9:57e5 with SMTP id c19-20020a17090603d300b00a3ee3a957e5mr3605800eja.58.1708504802252;
        Wed, 21 Feb 2024 00:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRY7+uiFt4jmpKBWMcdOXnDVCsKIe4LVER7pFJELWhzV29YlI2Ik6LZYhjgk6lB6EQ2AKJtQ==
X-Received: by 2002:a17:906:3d3:b0:a3e:e3a9:57e5 with SMTP id c19-20020a17090603d300b00a3ee3a957e5mr3605786eja.58.1708504801857;
        Wed, 21 Feb 2024 00:40:01 -0800 (PST)
Received: from [192.168.0.214] (host-79-42-200-4.retail.telecomitalia.it. [79.42.200.4])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090699c600b00a3efe1a2878sm1329238ejn.137.2024.02.21.00.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 00:40:01 -0800 (PST)
Message-ID: <4acce183-b486-44d0-b9e5-affb957ee366@redhat.com>
Date: Wed, 21 Feb 2024 09:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] sched: server: Don't start hrtick for DL server
 tasks
Content-Language: en-US, pt-BR, it-IT
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-7-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240216183108.1564958-7-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/24 19:31, Joel Fernandes (Google) wrote:
> From: Suleiman Souhlal <suleiman@google.com>
> 
> Otherwise, we might start it even for tasks in a sched class that should
> have it off.

If the task is fair, but it is running inside a DL reservation, we want the
hrtick for the dl reservation.

This is one of the reasons why we are moving to the DL server, having microseconds
granularity for the boost duration (runtime).

-- Daniel

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
>  
>  	return p;
>  }


