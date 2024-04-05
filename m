Return-Path: <linux-kernel+bounces-132686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF7899896
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37A01C21040
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B515FA77;
	Fri,  5 Apr 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNpmk22D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FC15F338
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307248; cv=none; b=m2co4QUgKSPLuOOJ38ptxsrebIm4qA4WKKa3ORhRtMJMuCyR3QKRZeNwbX4gHXDj1ww8kqraS3vQH616we9vtL0Eo+sKfebeBZyo76OadSe9vbkOVi2H4xCyNFJPo6S0hlZmU6gbCjobtMDadmd0bSoinpmy5PH+qKDt6r/Dhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307248; c=relaxed/simple;
	bh=6B4qat+yFPdqzb0wEQ2YwmgI6BotASwtMTiHOWlr/PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tb+yFb+zpaKPbPsb8nKcjXo9e0zTT77Tn6xqJAN3EzNdET0P5k6pdXBZi4aImjUxT75UmVXQ80TVbVwJOGYB5Q5x4fHE4PdAD7yDnG9UDzGga2mL7hfODZHPHFc79KOKEpd98LmeA9auZm5qYSDNnaM8RLDXtN5Q4Tf1hrjOVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNpmk22D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712307245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0n4Wf++FQKQw0aWu2Eok5zHZiTJsrQPIZ7GVke1MO8=;
	b=dNpmk22DmZsBXvofHDgtJfVQ8+fwXG5kqzpw/4hX02AL9GrY3GBRSnvcVeJNy1K86v/gXO
	hS6XMIE6rcv58SKhvDtWrJcJT0gu+JI36ZUqqMGrHs0rwZy/qe670vvt16Uv4wUkdhSKse
	zsqbRXgm7w9lNodW09lAO780IL5GQ+E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-AbbBmMbtNi6KAO1YLju_AA-1; Fri, 05 Apr 2024 04:54:03 -0400
X-MC-Unique: AbbBmMbtNi6KAO1YLju_AA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a450265c7b6so95853366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712307243; x=1712912043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0n4Wf++FQKQw0aWu2Eok5zHZiTJsrQPIZ7GVke1MO8=;
        b=p8y2DM0zOuQzs1Z3CC2F3iszqBnomuG7LhOWVqBTelV51xcad1jkEKhpkdI44svgiS
         aIvrftRp/NCTA0PZwHOxJQkh+6hMpLjz9vBFbjTs8kf+AMYbV1Wu3bm1fSDkx6hzv5lb
         ME8uzvXf1Adisg9/IGUy6MbkJBBYaS3W9BLBerBIdufvTgTFbWkYqDOXHX6z7jgsUfsi
         zeV29O1xq9qERQiKQQVeqWAF36+ALY8uj+LVMVdFNrq5YJuaH8KYwGF4sqXycvOI+OWa
         tTfvEaZdjKrVcpecXU3Tp583x+GIJsNtIzDxPseUevzUU8SD5W7FUZvxoqZPePjP1xg4
         SBgA==
X-Forwarded-Encrypted: i=1; AJvYcCUSzS5sXeQuBEmLMffF7cJRA0Ezc7t2A78UvN9aHh5kUBjBYy6orK4WX9+od9MptxuXPudpDOdYQ4Poy+Xat26M/yTn4KQBkXsKgTBC
X-Gm-Message-State: AOJu0YwqE1uq0I9/4Obujr1cu129L55iVVkot3dZoqK62qpG1raMoSjw
	sh2T5A9d0VPvj9bHmAHE9eDTDA83m2kPreZS26FGsIZBAi58WOG1C1LLeXRRrtoNvxgX/e1MUtt
	tzPZzs6n3NtwbX0BqSMxhjvyZuVEFWsuQUjWXsndSfZY2OBH3jszVxwY34puiOQ==
X-Received: by 2002:a17:906:b755:b0:a4e:68bc:a46e with SMTP id fx21-20020a170906b75500b00a4e68bca46emr539257ejb.43.1712307242759;
        Fri, 05 Apr 2024 01:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4AN+4gSC/D8A9pJvRw2rIHSXIa3ZVIWrnDEFBWxJCMya5Tkj7E3swQ/UV0u10dtgfDPJT1Q==
X-Received: by 2002:a17:906:b755:b0:a4e:68bc:a46e with SMTP id fx21-20020a170906b75500b00a4e68bca46emr539233ejb.43.1712307242428;
        Fri, 05 Apr 2024 01:54:02 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090655cc00b00a42f6d17123sm594252ejp.46.2024.04.05.01.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:54:01 -0700 (PDT)
Message-ID: <51540780-580f-47ff-ae0a-7d335c0702f7@redhat.com>
Date: Fri, 5 Apr 2024 10:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] sched/deadline: Mark DL server as unthrottled
 before enqueue
Content-Language: en-US, pt-BR, it-IT
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
 <20240313012451.1693807-12-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-12-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> The DL server may not have had its timer started if start_dl_timer()
> returns 0 (say the zero-laxity time has already passed). In such cases,
> mark the DL task which is about to be enqueued as not throttled and
> cancel any previous timers, then do the enqueue.
> 
> This fixes the following crash:
> 
> [    9.263331] kernel BUG at kernel/sched/deadline.c:1765!
> [    9.282382] Call Trace:
> [    9.282767]  <TASK>
> [    9.283086]  ? __die_body+0x62/0xb0
> [    9.283602]  ? die+0x9b/0xc0
> [    9.284036]  ? do_trap+0xa3/0x170
> [    9.284528]  ? enqueue_dl_entity+0x45e/0x460
> [    9.285158]  ? enqueue_dl_entity+0x45e/0x460
> [    9.285791]  ? handle_invalid_op+0x65/0x80
> [    9.286392]  ? enqueue_dl_entity+0x45e/0x460
> [    9.287021]  ? exc_invalid_op+0x2f/0x40
> [    9.287585]  ? asm_exc_invalid_op+0x16/0x20
> [    9.288200]  ? find_later_rq+0x120/0x120
> [    9.288775]  ? fair_server_init+0x40/0x40
> [    9.289364]  ? enqueue_dl_entity+0x45e/0x460
> [    9.289989]  ? find_later_rq+0x120/0x120
> [    9.290564]  dl_task_timer+0x1d7/0x2f0
> [    9.291120]  ? find_later_rq+0x120/0x120
> [    9.291695]  __run_hrtimer+0x73/0x1b0
> [    9.292238]  hrtimer_interrupt+0x216/0x2c0
> [    9.292841]  __sysvec_apic_timer_interrupt+0x53/0x140
> [    9.293581]  sysvec_apic_timer_interrupt+0x2d/0x80
> [    9.294285]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> 
> The crash can easily be reproduced by adding a 100ms delay as follows:
> 
> +int delay_inject_count;
> +
>  static void
>  enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>  {
> @@ -1827,6 +1830,12 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>                 setup_new_dl_entity(dl_se);
>         }
> 
> +       // 100ms delay every 20 enqueues.
> +       if (delay_inject_count++ > 20) {
> +               mdelay(100);
> +               delay_inject_count = 0;
> +       }
> +
>         /*
>          * If we are still throttled, eg. we got replenished but are a
>          * zero-laxity task and still got to wait, don't enqueue.


Makes sense, I am adding this in the defer patch v6 as it is a fix for it...

-- Daniel


