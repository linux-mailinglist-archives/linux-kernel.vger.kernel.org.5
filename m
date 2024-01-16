Return-Path: <linux-kernel+bounces-27439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C982F011
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AC41C23385
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBFE1BDDB;
	Tue, 16 Jan 2024 13:58:34 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071311BDC8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b5155e154so120239925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705413511; x=1706018311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNGsbWS1ofax0lsGPZBEPkcDmtzneDQEsM/R+E6zoZk=;
        b=EV3AtxuNojR93RG82kPuEqsIkkbT7dqsMckILhedDaFuF1zdWiZ4YrPu3evg38P9/7
         RNuGMQ7xWR8CSCR1/7eHawVpTnMKYkqRCh8ebvqf7IgbGfyLyKkSDjkAZYxFjcI4e9F3
         0CMNrdm9R4dIl8I38Zfs9tc8hbOI8c7hC4YwgjaLZBZVILl/mtODL7rvdgVgSwSE2Y3p
         OlWI49GMuMxv/lfCr03O0ThzUHcjihcTXlaOswSm5u1dY8M2U+tR2uEcXmlNZYNknPz8
         csvKb56sst608SL5jGlkXr2jGxapSkq5SUJsEoVtcLLF5/BFJABwXdzQMbNlsLOa0lRZ
         b3sQ==
X-Gm-Message-State: AOJu0YwquI6yfQzx18QLY/QbbR+hu7H/++mLltCtSBLOwTi5CXFGzOmH
	9pDgqri9APAJvug29DbKJ3A=
X-Google-Smtp-Source: AGHT+IFTRnIL7G/jTeyP2i2W0silOvALHevLUtz2F3B5g8U7xvrV9e4Pr5p2kLioR2jCLuCSZjz8Jg==
X-Received: by 2002:a05:600c:204f:b0:40e:7610:96e9 with SMTP id p15-20020a05600c204f00b0040e761096e9mr1898250wmg.235.1705413511023;
        Tue, 16 Jan 2024 05:58:31 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm23107790wmn.23.2024.01.16.05.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:58:30 -0800 (PST)
Message-ID: <20acc902-a34b-4289-ae1a-8abf211b11df@kernel.org>
Date: Tue, 16 Jan 2024 14:58:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: Avoid reusing outdated pi_state.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
 bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
 juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
References: <20240116130810.ji1YCxpg@linutronix.de>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240116130810.ji1YCxpg@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16. 01. 24, 14:08, Sebastian Andrzej Siewior wrote:
> Jiri Slaby reported a futex state inconsistency resulting in -EINVAL
> during a lock operation for a PI futex. A requirement is that the lock
> process is interrupted by a timeout or signal:
> 
> T1		T2
> *owns* futex
> 		futex_lock_pi()
>              	*create PI state, attach to it, queue RT waiter*
> 		rt_mutex_wait_proxy_lock() /* -ETIMEDOUT */
> 		rt_mutex_cleanup_proxy_lock()
> 		  remove_waiter()
> 
> futex_unlock_pi()
> spin_lock(&hb->lock);
> top_waiter = futex_top_waiter(hb, &key);
> /* top_waiter is NULL, do_uncontended */
> spin_unlock(&hb->lock);
> 
> To spice things up, player T3 and T4 enter the game:
> 
> 	T3 			T4
> 	*acquires futex in userland*
> 				futex_lock_pi()
> 				futex_q_lock(&q);
> 				futex_lock_pi_atomic()
> 				top_waiter = futex_top_waiter(hb, key);
> 				/* top_waiter is from T1, still */
> 				attach_to_pi_state()
> 				/* Here -EINVAL is returned because uval
> 				 *  points to T3 but pi_state says T1.
> 				 */
> 
> We must not unlock the futex for userland as long as there is still a
> state pending in kernel. It can be used by further futex_lock_pi()
> caller (as it has been observed by futex_unlock_pi()). The caller will
> observe an outdated state of the futex because it was not removed during
> unlock operation in kernel.
> 
> The lock can not be handed over to T1 because it already gave up and
> stared to clean up.
> All futex_q entries point to the same pi_state and the pi_mutex has no
> waiters. A waiter can not be enqueued because hb->lock +
> pi_mutex.wait_lock is acquired (by the unlock operation) and the same
> ordering is used by futex_lock_pi() during locking.
> 
> Remove all futex_q entries from the hb list which point to the futex if
> no waiter has been observed. This closes the race window by removing all
> pointer to the previous in-kernel state.
> The leaving futex_lock_pi() caller can clean up the pi-state once it
> acquires hb->lock. The following futex_lock_pi() caller will create a
> new in-kernel state.
> The optional removal from hb->chain is only needed if the futex was not
> acquired because it might have been done by the unlock path with
> hb->lock acquired.
> 
> Fixes: fbeb558b0dd0d ("futex/pi: Fix recursive rt_mutex waiter state")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> Closes: c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

thanks,
-- 
js
suse labs


