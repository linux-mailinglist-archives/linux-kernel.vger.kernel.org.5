Return-Path: <linux-kernel+bounces-137295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E2589E016
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578C82821D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80F13D8A8;
	Tue,  9 Apr 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAFB2s1H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8313D885
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679143; cv=none; b=mqxjSBL9ldX11m+UbLMzdZezRvMWNGMKkz+0sjUHP72iUYu3gpQ99EsUH2nqGPTBs9NyIbhfb4RpQTUOJOKDuyOdclkfbqJTux5Q5+HEz9RcKveZrUlQBjXk8BFYHGDM//wiwAQSR3B2JwFAUCpafw/FBZf2GA6lKhDvzjdP9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679143; c=relaxed/simple;
	bh=pyCA9PFhP2vNX6M5ogJc24Wsfu/upC5dJoGcQKBRYCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGD3/S/97NSaczT+Yf9tWz7gvYcVxznSyGLWhk5ZOvlzsQb/hXGQo9W7Rz1O1hGLLKC74E/8wsuVjgBwp6KJfKg/nGj+Q7aN8yFuqlyCpjVElGHCjsmj/l6qBmz1sSft9bWfAIF6Q98LxWo7hGQJa2ovJRTg4U4y0+LuzfMS0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAFB2s1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712679140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HdnV1A2hXwYk6KWxr2w2PhK8RwChTHZzTIDUEHBWZuI=;
	b=GAFB2s1HMpc6K+u8Do+sTGRSuzWsxuwhZXiZ8hV+Qb3ZYaHZm4uKo1wIo7LuEx+U6dR3WZ
	Cy6N/G0/eiKVnJ6INZXEQwCe+EOedcjKO0YcWzhEmJ6gquQYrv5LGIWgYAkceKmQpJseuj
	kBdIXZ/qaRFdAOLfM3TZwXxpAyptAMk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-qohvQCz-MX2ptOKMN4b38A-1; Tue, 09 Apr 2024 12:12:19 -0400
X-MC-Unique: qohvQCz-MX2ptOKMN4b38A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-434f838ac3dso2148361cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679138; x=1713283938;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdnV1A2hXwYk6KWxr2w2PhK8RwChTHZzTIDUEHBWZuI=;
        b=AP33su/Cp3xzIucrWrvXjZv2u9TFwaFUuxX2cMkNesek7bsNoJe0pczUGiMLsH/brS
         duPYV34YjdR7gpby4AyO4cD5kkBGHkpcIRfrB90AceGAojDA4WeUNdGn4uq9aOWqusVf
         eEWO1FI1yik9dpMkHdkpYfpT44nRqKtFY3gnaNp4uZ1c04y2hkRYU6uQ4lYQOnr3SJOi
         a6HNaLf5fLgiHXpNb30GdWMYhqGMf4SRXa1dXRmHc9heres524hMo7NrxYI0o4MYZwJ2
         qx5As7QXf41CfY3q/7pJJIOxpKrViBy8H3ij4qYyUe+g+NHh+KP/2jLAAVLvdcAntte2
         n4iw==
X-Forwarded-Encrypted: i=1; AJvYcCVeRkTUD75bxDTSUmPOYaKNKug4dVDnPRPzfijjtuI97nDWSCXm9ZlRkbxc/j0pOTb3Kbk7CFT4MlvDME01SmHd5ATHqyRAPKBgmL2L
X-Gm-Message-State: AOJu0Yw2BEUuTmsUsAXkFsADKbZWo0NWsfgxofJ1OvSVmBhjSrmqS9CC
	ySEob6k64f8JBtZRrrBoQ/eitbZw6GbYwQwOqY3i7iDU213I174onW38W7AAArCxEhcZl+urN4B
	cIdV93tT9DQjK5D6nzOnY8ZT49P7mv+ivU6TBPo0c3K3dRqVn8Qt3FkAXfasFRg==
X-Received: by 2002:a05:622a:10e:b0:434:a4dc:b271 with SMTP id u14-20020a05622a010e00b00434a4dcb271mr61634qtw.2.1712679138611;
        Tue, 09 Apr 2024 09:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGZPCE+gu1fW1VnnTVvcZ2y2Y+DItS/XcKXBqMoJE0dEPBo2O1FyDbA62XAZRgARpR3CPGrA==
X-Received: by 2002:a05:622a:10e:b0:434:a4dc:b271 with SMTP id u14-20020a05622a010e00b00434a4dcb271mr61604qtw.2.1712679138294;
        Tue, 09 Apr 2024 09:12:18 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ka2-20020a05622a440200b00434c680abbasm1164463qtb.93.2024.04.09.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:12:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
 <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen
 Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, Davidlohr
 Bueso <dave@stgolabs.net>, John Stultz <jstultz@google.com>
Subject: Re: [RESEND][PATCH v9 1/7] locking/mutex: Remove wakeups from under
 mutex::wait_lock
In-Reply-To: <20240401234439.834544-2-jstultz@google.com>
References: <20240401234439.834544-1-jstultz@google.com>
 <20240401234439.834544-2-jstultz@google.com>
Date: Tue, 09 Apr 2024 18:12:11 +0200
Message-ID: <xhsmhbk6ia52c.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 01/04/24 16:44, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> In preparation to nest mutex::wait_lock under rq::lock we need to remove
> wakeups from under it.
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
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
> 08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
> mutexes")]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [jstultz: rebased to mainline, added extra wake_up_q & init
>  to avoid hangs, similar to Connor's rework of this patch]
> Signed-off-by: John Stultz <jstultz@google.com>

This looks mostly good to me, some preemption questions below.

> @@ -934,6 +942,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		}
>  	}
>  
> +	preempt_disable();
>  	raw_spin_lock(&lock->wait_lock);
>  	debug_mutex_unlock(lock);
>  	if (!list_empty(&lock->wait_list)) {
> @@ -952,8 +961,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		__mutex_handoff(lock, next);
>

(minor nit) Could the preempt_disable() be moved here instead? IMO if it's
closer to the unlock it makes it clearer why it is there
(e.g. sched/core.c::affine_move_task(), rt_mutex_setprio(), __sched_setscheduler().

>  	raw_spin_unlock(&lock->wait_lock);
> -
>  	wake_up_q(&wake_q);
> +	preempt_enable();
>  }
>  

> @@ -1775,8 +1782,9 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
>  	 * irqsave/restore variants.
>  	 */
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> -	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
> +	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> +	wake_up_q(&wake_q);

Shouldn't this also be wrapped in a preempt-disabled region?

>  	rt_mutex_post_schedule();
>  
>  	return ret;

> @@ -122,6 +123,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  	if (!ret)
>  		atomic_inc(&rwb->readers);
>  	raw_spin_unlock_irq(&rtm->wait_lock);
> +	wake_up_q(&wake_q);

Same question wrt preemption.

>  	if (!ret)
>  		rwbase_rtmutex_unlock(rtm);
>  


