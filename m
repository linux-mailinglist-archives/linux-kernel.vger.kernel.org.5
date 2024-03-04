Return-Path: <linux-kernel+bounces-90285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D963E86FCE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097941C2220C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F01BDC8;
	Mon,  4 Mar 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rDYzV2TL"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B211B7F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543769; cv=none; b=byhn+nBUR25ywXK4eMf0AQgv//5tE+pZ2FhDMH+COHKCHbtdV8yDOJ36SRnuFa/cJgOP9g/zTqu4PKz2RhplBnKkyDuxsyASv749iSKKDhGLfr9twVrHRIafcMXsRRrFJnk6xd01S+zqqZk9FIyXy6V5MGdUtT8DluHkwU/71ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543769; c=relaxed/simple;
	bh=7/Cg7bSkP3P3KzE9IpfjIHLKep/5j0YfikDfAl96988=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BsYrQiwmoIUmAjqKJ+M9DH8jIxIH5//C/D78tE4lxLur4BAKXT/SMwmnSQPqjRl3ACOqYY2YiGY+MTa5hQ1zHfkZvL2tJ5dLBW0o2/ue/4Gd73xIinq99yZ4wJp0Y/aEC25ZAbJ4YioIyKH3xqH1QPDqts3mQHItjmNFUkgrdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=rDYzV2TL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68f51ba7043so29128576d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709543767; x=1710148567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWM0i1D+FispfxeIOLK4vZoGix8afRI2zst62UErbPs=;
        b=rDYzV2TLx1y2l/44xBbi2rloN3uAyytTyJ3BLccvZ9p3519cGkwmK8pNAj6PqLt9Ag
         RGWFoJ+D/ZO1YpObXtqsYScF84CVIoeUbaiFIXTULcN0G22XBrzCEvQ34spkHg2LkIRl
         Kv/d+ALiRJqrAVbgw+DsyoEbFMTvjop8IjIAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543767; x=1710148567;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWM0i1D+FispfxeIOLK4vZoGix8afRI2zst62UErbPs=;
        b=hiaCuYNYRp7QCPvIGnvASbweidNVzsym581mMGeH+wHG5NH7JArMOmUjx6Yh8kFgwD
         azfwDbyxyw53mESRbw5yK2F7ByiUKl7F4kPtaCLIhK/9jrMu2OOfdDyPcYSFfg7NvTok
         Km3cqw2ZN/RfE/7kMyITYTUaO3lVBIeOkWZbCmNB+UzkVTgnK42rM+5mami3DHwz7qcd
         Z8YqY48E4fUfiD5BAsDXImH/lUpfE4Qv2O0+gHw7p2J9nrD9xD6L/Kk+DMxz97VXyMQc
         j1Msc2WRKhHGLaM0iQadNVUvZ0ZsfgIw7M7mGsgv8hK/bFdk5cIRRTcirm/5oKtlNS36
         gT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVITxjGf5v+gLYmueT4zQhyC88SXxbVAcezAPeVcOV1E3ZVz61mdW9txyVQK1Gn3fcLc5/gb5ag368xwqYYyZP/v+MnxOKbC4mg3jJs
X-Gm-Message-State: AOJu0YxEQAVrcAWPjT4RiyGdKgXh1opW0GovZwBSqylAhfS6EyYbMX8o
	Vb2/seninTqfJl8SYN2c5PTYNb0ylffQRsmVcqzIQFmR2/ecKJhf6cbWXZgHFBY=
X-Google-Smtp-Source: AGHT+IG+Y2v7EYKVufOejhc+r1//YCAbl9GRmef/EobZWtTzDz0WoEMeaAAPF6++0ntNwDKN6wy6hw==
X-Received: by 2002:a0c:e303:0:b0:68f:19a7:cd4e with SMTP id s3-20020a0ce303000000b0068f19a7cd4emr9377247qvl.33.1709543767119;
        Mon, 04 Mar 2024 01:16:07 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id lz4-20020a0562145c4400b0068f4520e42dsm4913063qvb.16.2024.03.04.01.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:16:06 -0800 (PST)
Message-ID: <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
Date: Mon, 4 Mar 2024 04:16:01 -0500
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

