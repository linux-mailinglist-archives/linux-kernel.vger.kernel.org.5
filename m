Return-Path: <linux-kernel+bounces-86826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C686CB56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD771F22F07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7A1361D6;
	Thu, 29 Feb 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TbyqMLjB"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484767D060
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216514; cv=none; b=BMNrBcvY7yz1wBoKeOEZHXfRvhNcOkNjz0NGcSrGppwW8WhNxXlzWU4ExtmIWt+RVRE6KqAAfNuqFVCNRQ6MWfjlKgOrogqclz4b3qhpl3CcTakghogKdjMCtzFFkVoDLpEQEi/a1b1ARLQ2lp7TD+rlg+jsUxgp4PG8jEbzSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216514; c=relaxed/simple;
	bh=s9koWyBOH5kffAk/ctMX8vICzTEVqUgQIoSQO1DAJ1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvyRRvTzAN/q0770C9QYCU+dtlF8bGgxuEZ+Zcew4vezrthijL1IZSPCU3J+WJPVEKVgfj42s1cAPacholLEuBHpm7aBbHXGTIePWQmOILM6Q5MilZe6/RiKZbVMsgH4FKBdkTa6kPIVDEWSuEq5ZLaNkzuObEbMo6ldOuSiWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=TbyqMLjB; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c810b04bc0so26790039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709216512; x=1709821312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7QQf86WBSLlT/8W/ge7tfKbRHIzhxvhjanWb4LCZ2Q=;
        b=TbyqMLjBGFbW1XYlgjVchNT8LUCoGp061bxAeusS9ycHO17B69pk9QuQEIqVi7WC0X
         Dop1CM197ycc7ib2kiUp7R8DuZcUDT67qc9LprKNzsVz4XpwfpGKFb6wEWqwgX9MTTJq
         gDwqVGEzpcbftbs9iqIUAPuH8dbaOtFXJrE84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216512; x=1709821312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7QQf86WBSLlT/8W/ge7tfKbRHIzhxvhjanWb4LCZ2Q=;
        b=KPkR/PnawkqTvAQ4ES9EXJm4wJQ5/zMQevRt+lWJkUWB4qXBwKe9lTen7uHs5u8EF0
         zFAk4OgVA8VRJHAh7K5PtDMUrOmuzIPUcvWUzzX+FZ7b7WlouqOnr8QQScbzE9g+OKqR
         /ugFT4/N+GDw793QmGzgZJeeohpjNIkylDAjOm7d0wAmdvfNllnYSa03j7P7wmNGyiHS
         emkGtMjrQJfoxhAiTsvY6/oxKtnWX5FTDckvUVf/kFzkq12TvXJovbCiXe41zhEuOpho
         aWtf6xSR0M3+tl71wv8mSigrbGg4fcXRoFKltLcCqNFwECd0b4R5pn/wo+EXutR6lnBI
         z2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcgKwVW2stc61V5Qs07TEOvvgVnCwzsa7srES0VfvygM0NwmIZcyU+iYY1wx1yMDHY/J6wFjpnJY05mxLSXX/P0PXH9AN2m3e9X7R
X-Gm-Message-State: AOJu0Yw0R8Gp2VIFoVe+QOPdA+7ueGRgPhKLXSQNTsYrXLoshevkvlG1
	PLFw7LciDABNFDw8qK8NZIZKgg0bP5bjNJufNS5UqzMZNHtZbNDcJBGYVWvKwew=
X-Google-Smtp-Source: AGHT+IGocqJwt9KmmMr7A2O/6M57M/JbaCMv0luN5qeZx+9pAylTJ9Tny6UR5Td+4D66YZVFB9CTBQ==
X-Received: by 2002:a05:6602:3b97:b0:7c7:9c58:c970 with SMTP id dm23-20020a0566023b9700b007c79c58c970mr2398006iob.4.1709216512347;
        Thu, 29 Feb 2024 06:21:52 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id a14-20020a5d9ece000000b007c8197e8473sm86044ioe.5.2024.02.29.06.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 06:21:51 -0800 (PST)
Message-ID: <888d2f90-6d2f-4d4f-a9f6-fbf2f2611821@joelfernandes.org>
Date: Thu, 29 Feb 2024 09:21:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Content-Language: en-US
To: paulmck@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Yan Zhai <yan@cloudflare.com>,
 Eric Dumazet <edumazet@google.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
 bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Mark Rutland <mark.rutland@arm.com>
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
 <3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
 <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
 <20240228173307.529d11ee@gandalf.local.home>
 <CAADnVQ+szRDGaDJPoBFR9KyeMjwpuxOCNys=yxDaCLYZkSkyYw@mail.gmail.com>
 <8ae889cb-ee1d-4c72-9414-e21258118ce3@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <8ae889cb-ee1d-4c72-9414-e21258118ce3@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
>> On Wed, Feb 28, 2024 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> On Wed, 28 Feb 2024 14:19:11 -0800
>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>
>>>>>>
>>>>>> Well, to your initial point, cond_resched() does eventually invoke
>>>>>> preempt_schedule_common(), so you are quite correct that as far as
>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent state.
>>>>>
>>>>>  Thanks for confirming. :-)
>>>>
>>>> However, given that the current Tasks RCU use cases wait for trampolines
>>>> to be evacuated, Tasks RCU could make the choice that cond_resched()
>>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
>>>> .rcu_urgent_qs accordingly.
>>>>
>>>> But this seems less pressing given the chance that cond_resched() might
>>>> go away in favor of lazy preemption.
>>>
>>> Although cond_resched() is technically a "preemption point" and not truly a
>>> voluntary schedule, I would be happy to state that it's not allowed to be
>>> called from trampolines, or their callbacks. Now the question is, does BPF
>>> programs ever call cond_resched()? I don't think they do.
>>>
>>> [ Added Alexei ]
>>
>> I'm a bit lost in this thread :)
>> Just answering the above question.
>> bpf progs never call cond_resched() directly.
>> But there are sleepable (aka faultable) bpf progs that
>> can call some helper or kfunc that may call cond_resched()
>> in some path.
>> sleepable bpf progs are protected by rcu_tasks_trace.
>> That's a very different one vs rcu_tasks.
> 
> Suppose that the various cond_resched() invocations scattered throughout
> the kernel acted as RCU Tasks quiescent states, so that as soon as a
> given task executed a cond_resched(), synchronize_rcu_tasks() might
> return or call_rcu_tasks() might invoke its callback.
> 
> Would that cause BPF any trouble?
> 
> My guess is "no", because it looks like BPF is using RCU Tasks (as you
> say, as opposed to RCU Tasks Trace) only to wait for execution to leave a
> trampoline.  But I trust you much more than I trust myself on this topic!

But it uses RCU Tasks Trace as well (for sleepable bpf programs), not just
Tasks? Looks like that's what Alexei said above as well, and I confirmed it in
bpf/trampoline.c

        /* The trampoline without fexit and fmod_ret progs doesn't call original
         * function and doesn't use percpu_ref.
         * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
         * Then use call_rcu_tasks() to wait for the rest of trampoline asm
         * and normal progs.
         */
        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);

The code comment says it uses both.

Thanks,

 - Joel

