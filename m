Return-Path: <linux-kernel+bounces-27054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8EA82E9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8281C22F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483EE10A21;
	Tue, 16 Jan 2024 07:07:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCB10A18
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8609c28aso688535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705388841; x=1705993641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Zc+m2VJCaa5REGJxJzMj362RVBpUDhMoX6Wo4cY1w=;
        b=rb7CPibDfDui+p3mkXHG2xHBoW1uYbST7JXzHg82AILWjXh91lpXV8edvzR3Ck5SGT
         V7TBEEgyeG+4iTQeRfja3caPp0Ke+5sYOAwsh21/hewQ+SQ2a5QQbEKDJKQvqMOzAlKQ
         A0d+X78hQxuE+uLccsYNRnisznbBfpwAdVqbsL5mEdXEzOm5VZGypkSRbydTWyDJ3jUv
         Q9hM0wfBBXxoF2U4+u0j3tA27wGFvwUkn0jVjCedWXGI0mG8fIwJmqwrG7p82oUR98QZ
         HSclRCWQpoE8dBiwhTFbjx3cRXkJnRz3c4OzYDWD281K7xgldd1Du2ygXT8vtUl43P2H
         TyMg==
X-Gm-Message-State: AOJu0YynoZQZ+5or5I87MWU2/ifKlq1iJQZuktpqz43u5OFKsHB7e/56
	quwvi5s9uucTZJZyubdQJoE=
X-Google-Smtp-Source: AGHT+IHP1wIb06ehlpWRTnQXbM/R/rn3vS0heRhgaoyOkf85dCqO9eZhiKpjVAjzF0iQsYz2jPJR9A==
X-Received: by 2002:a05:600c:3515:b0:40e:614f:3677 with SMTP id h21-20020a05600c351500b0040e614f3677mr3576923wmq.20.1705388841340;
        Mon, 15 Jan 2024 23:07:21 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm21980207wmb.41.2024.01.15.23.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 23:07:20 -0800 (PST)
Message-ID: <9923d643-b363-400b-878a-d99921bc8e2e@kernel.org>
Date: Tue, 16 Jan 2024 08:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
 dietmar.eggemann@arm.com, jstultz@google.com, juri.lelli@redhat.com,
 longman@redhat.com, mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
 swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
 will@kernel.org
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net> <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
 <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
 <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>
 <20240115183338.xW3GS3Ex@linutronix.de>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240115183338.xW3GS3Ex@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 01. 24, 19:33, Sebastian Andrzej Siewior wrote:
> This duct tape at the end waits until the pi-state leaves or we get a
> waiter. So this works but is not a fix.

FWIW, it indeed avoids the problem.

> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -1182,6 +1182,9 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>   		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
>   		if (!rt_waiter) {
>   			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
> +			spin_unlock(&hb->lock);
> +			cpu_relax();
> +			goto retry;
>   			goto do_uncontended;
>   		}

thanks,
-- 
js
suse labs


