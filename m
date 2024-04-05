Return-Path: <linux-kernel+bounces-132724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345589994E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B5A1C20F60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFC15FCEE;
	Fri,  5 Apr 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIK//uAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2415FA77
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308777; cv=none; b=pB8JaaUj+wA/eAnfvxuY5zZEio68k/rBSBCg/p4LYF2FtH5I8ZS1XKo+ZtsRqz/EKMl8PO5TMz4rYQokcmWhOrp5UIfaqRNe/kJoncRKM7UkFFS9Wy9s6hoO0v1wz26IcRb2y9K8+YoF1hVA54yprDiiFtxI8LNs4Tqlw9aRDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308777; c=relaxed/simple;
	bh=7zpeqsTw2ybJk5WKNIO6H9jrOkXWGBa8NGKvCtwHyXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBxwzYUHlgbf8uToRS/yleNhTjpKlXqVSDkWyBsI+aUnIOK/zFK/tfpeeZn1Y4J93iL1i/j2xJRfokxEaWHbHO6qVIzlYRAIn9I6VlJenC145miurljSbmXCvyz1vLwMs8weIigXJGtOWdRlseZxMpgHBttFlJVgF7VaLhzOLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIK//uAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712308774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pI5qdPk/l0jjU8NOys3hTJUuEzbEX6dND3AGMEIXVE=;
	b=aIK//uAmVOgndXA5UEtSaVFsK4nT5zRmZrpPtOs5jxHz1J0xHpXrUXkaRywVUNMGeANZ9a
	/YpBszVE8Ol+hIeQ6C6aSadrucDJf3lxOH1runuqmcK7Ha+26ttYtzD2GQf0mdaHupeOQg
	fV5ulfh6faA4QxGbkijcw+p6vsPWy/Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-USgNp2-VPWmmjHfjZZiaFQ-1; Fri, 05 Apr 2024 05:19:33 -0400
X-MC-Unique: USgNp2-VPWmmjHfjZZiaFQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4747f29e19so82931166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308772; x=1712913572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pI5qdPk/l0jjU8NOys3hTJUuEzbEX6dND3AGMEIXVE=;
        b=XlmHqd9wSPrPtxie0IJbpWWHHm143G8eeBEMEtYpjqELWKbW1aO3leYLUTM30yshCy
         2Yltc4a7Yv4h9OsBvn3PG2nEHoiof2uno/TG0bB5GA+OV+duk33OESyneTmI1XCjqYR7
         iX66Aiq16EyQ58hM3+C+sQHq2IJh6qvLc3HDsxX0/PsIDZEEDn0D0zWgN7IhWmHPe7Ao
         vAF6ENWFqKsJXSBtrrdvywvkNrPDNU9TdLi47CCc1ZIqVXGbsX5kC35hXBKFPMhJCZP3
         /XHwedpJ7Ps7GQdqIrk5sVUoARg53XPpKuRnTqsoTvQLfwELSuoooEBLj/hFS8ua+LNq
         J/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW+xORNX31+MbyEyRO3Zo6++qyxdilM4EctQv24iKTpMVtIWfOhdyXlbJRz6gCOtsjUYh1ZSvCKErxlkDgNtcF3Y7bxgL8Lr0laVvps
X-Gm-Message-State: AOJu0Yz6DiFLupk6CTfmt4Hcis66KDgf1rciyiM6hNJ3N/mTPiAIlYfM
	qgmqhZbWHc5cETPdA25pnhNcawDjTaR50GIkL8ppxaFWizMP3+Jh943BcqNXEjOLEwkvoZAfg06
	CRBzm+dckclAw1TMwWeH/6ZNIKIWP5ihjQ3ugqYK1kx8xmpONPe0payFS5Xvm7A==
X-Received: by 2002:a17:906:4ecf:b0:a51:a259:a5e4 with SMTP id i15-20020a1709064ecf00b00a51a259a5e4mr609393ejv.54.1712308772124;
        Fri, 05 Apr 2024 02:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/EYKWKTnQNY3A29BA/mOEhDJUj21PcZMDkPx8vESgT6qLGQgtgQUltYzELaXkPQi2l74vOw==
X-Received: by 2002:a17:906:4ecf:b0:a51:a259:a5e4 with SMTP id i15-20020a1709064ecf00b00a51a259a5e4mr609380ejv.54.1712308771797;
        Fri, 05 Apr 2024 02:19:31 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id ao11-20020a170907358b00b00a51aa517076sm241442ejc.74.2024.04.05.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:19:31 -0700 (PDT)
Message-ID: <fda31cb5-2297-4559-a462-124fb459e263@redhat.com>
Date: Fri, 5 Apr 2024 11:19:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] sched/deadline: Always start a new period if CFS
 exceeded DL runtime
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
 <20240313012451.1693807-16-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-16-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> We believe that this is the right thing to do. The unit test
> (cs_dlserver_test) also agrees. If we let the CFS run without starting a
> new period, while the server is regularly throttled, then the test fails
> because CFS does not appear to get enough bandwidth.
> 
> Intuitively, this makes sense to do as well. If CFS used up all the CFS
> bandwidth, while the DL server was in a throttled state, it got the
> bandwidth it wanted and some. Now, we can start all over from scratch to
> guarantee it a minimum bandwidth.

So, this part of the code is not actually fundamental for the defer part, it was
added as an optimization... but it has a problem...


> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/deadline.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 179369d27f66..a0ea668ac1bf 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1454,23 +1454,6 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	 * starting a new period, pushing the activation to the zero-lax time.
>  	 */
>  	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
> -		s64 runtime_diff = dl_se->runtime + dl_se->dl_runtime;
> -
> -		/*
> -		 * If this is a regular throttling case, let it run negative until
> -		 * the dl_runtime - runtime > 0. The reason being is that the next
> -		 * replenishment will result in a positive runtime one period ahead.
> -		 *
> -		 * Otherwise, the deadline will be pushed more than one period, not
> -		 * providing runtime/period anymore.
> -		 *
> -		 * If the dl_runtime - runtime < 0, then the server was able to get
> -		 * the runtime/period before the replenishment. So it is safe
> -		 * to start a new deffered period.
> -		 */
> -		if (!dl_se->dl_defer_armed && runtime_diff > 0)
> -			return;

The idea was to reduce the frequency in which the timer is reset, aiming to avoid
regressions in the regular case in which the dl server never actually fires. It works
fine *if* the runtime is relatively low to the period... like 5%.... as it gets bigger,
it starts breaking things. In the case of > 50% of runtime, it breaks. That is
the case you guys seem to have.

At LPC, I actually expressed the concern to Vincent about resetting this timer. But
he mentioned that it was not a big of deal because it does not happen that often
to cause problems.

so, yeah, it is better to remove... one can always get back to this and think
on a logic that postpones the reset depending on the % of runtime of the dl server.

Removed on v6

-- Daniel

>  		hrtimer_try_to_cancel(&dl_se->dl_timer);
>  
>  		replenish_dl_new_period(dl_se, dl_se->rq);


