Return-Path: <linux-kernel+bounces-90286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C786FCEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6B11C2226E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5221112;
	Mon,  4 Mar 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S7cXE67V"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532B1B95C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543780; cv=none; b=RKu7fbpq/7J+ygfPogDR8CQgyxFhiEMeUDAVDmE4O3yeLKkBRfisaIGoJXpZTIAcwyYOif8WoubdTkutvkzYsDrliDnM0oaLiqwk/mOyxdVvpRW5zCgEy03Y7TH6YoL+/wh7VfidHeErDok5PUFglRiS9dxiLWUIxNydUGMz9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543780; c=relaxed/simple;
	bh=7/Cg7bSkP3P3KzE9IpfjIHLKep/5j0YfikDfAl96988=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q6n8/OxX6p1eY2sxjsg60XFMOBAulFMiYjnr9k/bMLxTQKPFfC7yO8cVRsThMi/xJN+vTLhaSMxbtI9ut4AeHC8ba2u5k5ch5scNSfTN49q19+QnQ4OroGltWtpmhMad4UfBQcHp6G8rl6A395BovTn/FTJpcy9uOPK4IcUisMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=S7cXE67V; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68fb7928970so19836776d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709543778; x=1710148578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWM0i1D+FispfxeIOLK4vZoGix8afRI2zst62UErbPs=;
        b=S7cXE67VDKzOS8oEhk2wOe1+UYaku8agA6xf2gN9Dgis7hG8ysJyI/YR1VOG1ckm0E
         /KgB3L9GeFOmeV/rzKIkN48qvIQNwU7QNz3vDm6xG0Lu1bttYm0m/rLorUbwD9pxXs8l
         ewSL50KVriy9aY4RCmrSDB7OXDfDBmLnhFevU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543778; x=1710148578;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWM0i1D+FispfxeIOLK4vZoGix8afRI2zst62UErbPs=;
        b=XFNsm09AZDSyyKN2knXCEp2v+T3hkRpjNPQ9YXVk1cZpB9AkqfBKmiiUuwgAn80xou
         YBWRbYoxEcm0EYiTdNx8Wx4mblmgkhTt6N8w1AQzAXsfbngPjVNte/tb4xg6lmJI6Osc
         JIzwfbtExEAwBuwy9GUQb+Dls4wSZitgKxf1QWjQMIXRCrsWZbc33F7hROUJ4Sff/14V
         xNLCjdSghioZ+mhotH87tQeHgFHm7qo0P21S/ngPUrBJw3NV0/ii31sRUHNBCKTOzO3C
         f02CTbsLHKpV29/OGGpelYguCvE4gI/ftUYIqDdkTO/j7OHhwN2xOUTWb7qiIORjmq+M
         AP/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoKg2JVY/kHHLL9Cums7T8Iir+oVb5iWFfNC1NT6BRw1LmS1XPA0wOsTRQsVK7m/kNHE4ePau4UZCQ7I26oJiaaTo5LPuR2G4xt6SI
X-Gm-Message-State: AOJu0Ywn7u1Jxd8Zc1uCYl3kwBLY0D5SPBVe6yO71DniiTVhuJOISWX6
	6cq2p/bFFAE4VnpxFDrY280o8gxfeGG2fICa8MCHtrZpo+DC08hWloWAnZNYzLU=
X-Google-Smtp-Source: AGHT+IEm2Vy+25KaOUe7GI3ZHCTzoChFZCEpmhFYzCFLr9pJjidCxyJ165Vuq1Ldu2K64+OPrluirA==
X-Received: by 2002:a0c:c20a:0:b0:68f:43f6:4834 with SMTP id l10-20020a0cc20a000000b0068f43f64834mr8682070qvh.26.1709543777882;
        Mon, 04 Mar 2024 01:16:17 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id b18-20020a0ccd12000000b0068f760929c0sm4898018qvm.71.2024.03.04.01.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:16:17 -0800 (PST)
Message-ID: <f3ed94a9-e50e-4d4b-bede-cc3078d4acab@joelfernandes.org>
Date: Mon, 4 Mar 2024 04:16:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
In-Reply-To: <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul,

On 3/2/2024 8:01 PM, Joel Fernandes wrote:
>> As you noted, one thing that Ankur's series changes is that preemption
>> can occur anywhere that it is not specifically disabled in kernels
>> built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.  This in
>> turn changes Tasks Rude RCU's definition of a quiescent state for these
>> kernels, adding all code regions where preemption is not specifically
>> disabled to the list of such quiescent states.
>>
>> Although from what I know, this is OK, it would be good to check the
>> calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
>> up so as to expect these new quiescent states.  One example where it
>> would definitely be OK is if there was a call to synchronize_rcu_tasks()
>> right before or after that call to synchronize_rcu_tasks_rude().
>>
>> Would you be willing to check the call sites to verify that they
>> are OK with this change in 
> Yes, I will analyze and make sure those users did not unexpectedly
> assume something about AUTO (i.e. preempt enabled sections using
> readers).

Other than RCU test code, there are just 3 call sites for RUDE right now, all in
ftrace.c.

(Long story short, PREEMPT_AUTO should not cause wreckage in TASKS_RCU_RUDE
other than any preexisting wreckage that !PREEMPT_AUTO already had. Steve is on
CC as well to CMIIW).

Case 1: For !CONFIG_DYNAMIC_FTRACE update of ftrace_trace_function

This config is itself expected to be slow. However seeing what it does, it is
trying to make sure the global function pointer "ftrace_trace_function" is
updated and any readers of that pointers would have finished reading it. I don't
personally think preemption has to be disabled across the entirety of the
section that calls into this function. So sensitivity to preempt disabling
should not be relevant for this case IMO, but lets see if ftrace folks disagree
(on CC). It has more to do with, any callers of this function pointer are no
longer calling into the old function.

Case 2: Trampoline structures accessing

For this there is a code comment that says preemption will disabled so it should
not be dependent on any of the preemptiblity modes, because preempt_disable()
should disable preempt with PREEMPT_AUTO.

		/*
		 * We need to do a hard force of sched synchronization.
		 * This is because we use preempt_disable() to do RCU, but
		 * the function tracers can be called where RCU is not watching
		 * (like before user_exit()). We can not rely on the RCU
		 * infrastructure to do the synchronization, thus we must do it
		 * ourselves.
		 */
		synchronize_rcu_tasks_rude();
		[...]
		ftrace_trampoline_free(ops);

Code comment probably needs update because it says 'can not rely on RCU..' ;-)

My *guess* is the preempt_disable() mentioned in this case is
ftrace_ops_trampoline() where trampoline-related datas tructures are accessed
for stack unwinding purposes. This is a data structure protection thing AFAICS
and nothing to do with "trampoline execution" itself which needs "Tasks RCU" to
allow for preemption in trampolines.

Case 3: This has to do with update of function graph tracing and there is the
same comment as case 2, where preempt will be disabled in readers, so it should
be safe for PREEMPT_AUTO (famous last words).

Though I am not yet able to locate that preempt_disable() which is not an
PREEMPT_AUTO-related issue anyway. Maybe its buried in function graph tracing
logic somewhere?

Finally, my thought also was, if any of these thread usages/cases of Tasks RCU
RUDE assume working only on a CONFIG_PREEMPT_NONE=y or
CONFIG_PREEMPT_VOLUNTARY=y kernel, that could be worrying but AFAICS, they don't
assume anything related to that.

thanks,

 - Joel

