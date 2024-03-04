Return-Path: <linux-kernel+bounces-91150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D973870A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4491A280EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620379922;
	Mon,  4 Mar 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oJvKdEAR"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CA78B50
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579416; cv=none; b=EP7quAyjaGa+UfUjm44/2RhrfQV2MNZMWBivUmV4oBpEO+lYjYIB+Vs+hAKs0e010NFVMrl4hOBXAWOp/HKIDE097XKiLhDjHGDSvpQ1JJElAoJER0MPJTGKVzcslFtz98eoQeZb+dXDrSL3eHfW7Xa+2VI9Thg8ygr5CwSZidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579416; c=relaxed/simple;
	bh=Hw/ZbeQVMiDbwu0iVTuLsc7vBc40rgkcKS8KKAcH1KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoQ2ZME+AqvXSlPxOdA3OZovbLeTKQWUSRxJujVLT5F6Bkkcv2YOBJbOzxEuKervigxgodyYHNf02SOORQmgt7dRCsUc3ZvVS1Ae4JmJBNjukY7HqCqkifqLqel1u/YWpJ/2Bw2N8SVRAcxxaws6B5yVV0yAiWDzRd2TyP7QUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=oJvKdEAR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787990149edso251354785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709579413; x=1710184213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKUa1+EBAtyJGDdTLiEQrn4ioKCgJdqIXHUpdnAkpJc=;
        b=oJvKdEARfmoTVaugjvQutQxysOz09t4MPaagxug4v0k5DzZlz50H4Gyw6Mv3PpDAca
         IIKpr/1NPBWNiA7SRdtttSujEjmVdkTc9+mk227JWRhQP2QXgzVf+GFylwpD5TvnUEfR
         ph/zL0GPLf1LJRVXtcVVOzw/UHZKhcYoTQJRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579413; x=1710184213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKUa1+EBAtyJGDdTLiEQrn4ioKCgJdqIXHUpdnAkpJc=;
        b=tl6BLZC6gyxsAEcP8gFTgCMb/0CQ/XuxNpR6YVQFv4xG+S3l9be03YNnkZcyVaIVVQ
         7W6W0Pd6x2kWothzw08T5lcP11WRxYBHf/dgCBNKEQ1FxHAJgcb5ZgIPwy8qJfpF8Kin
         xF+Qrn4gXcgNWdebRj8qZZxjt6Ijv6kdUl3iT/j/ZjKs3fcaFjFd5vesM+UtyMj4xLQq
         GN56YVXJxJufgy038nnCiauNuolcWE1imEHnZmv/470Fa15cKgQIt1NH962gjqQ9iBb/
         mfbcRERMHAnAg6QVHO/Q+mb1K9wxljKl8mosy9kiYOJ0Ec8Er0zr4GhQF+fPwQXIw1ak
         4euw==
X-Forwarded-Encrypted: i=1; AJvYcCWCXVPr8O3TuXQr0xm46OaI0hVQf+MxtwucUq73K1LyYFX3TXMdVQ9A4AO85M1iivGoZQmSEif8uHkBpwYkoC2jBEWrIcUjU+jP5vVw
X-Gm-Message-State: AOJu0YwVzJV9ScZ9iSz1/etN14GIRgu/8DiCNcGt/6KvIb6Y423lCN1V
	eiKEsIzt71ybNVDR4w8oihhcUkWxfdUpVw7YvIV1bXrnPIYrlSWCj3pbGbcWZHw=
X-Google-Smtp-Source: AGHT+IE9dGhumWRtZFI/7CXp+JwpK3qDgkcJlEikBCa9J1hSp9fXrBScFgS2X6CdvMMR7i2xdF4YFA==
X-Received: by 2002:a05:620a:231:b0:788:26b5:d59e with SMTP id u17-20020a05620a023100b0078826b5d59emr4177760qkm.29.1709579412805;
        Mon, 04 Mar 2024 11:10:12 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a13dc00b00787d6814c10sm4626326qkl.13.2024.03.04.11.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:10:11 -0800 (PST)
Message-ID: <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>
Date: Mon, 4 Mar 2024 14:10:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Content-Language: en-US
To: paulmck@kernel.org
Cc: linke li <lilinke99@qq.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng
 <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
 <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/2024 12:14 PM, Paul E. McKenney wrote:
> On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
>>
>>
>> On 3/4/2024 5:54 AM, linke li wrote:
>>> Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
>>>
>>>  {
>>>  	int i;
>>>
>>> -	i = rp->rtort_pipe_count;
>>> +	i = READ_ONCE(rp->rtort_pipe_count);
>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>> -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>> +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>>  		rp->rtort_mbtest = 0;
>>>  		return true;
>>>  	}
>>>
>>> But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
>>> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
>>> rcu_torture_writer() concurrently.
>>>
>>> Also, rp->rtort_pipe_count in the next line should be read using
>>> READ_ONCE() because of data race.
>>>
>>> Signed-off-by: linke li <lilinke99@qq.com>
>>> ---
>>>  kernel/rcu/rcutorture.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>> index 7567ca8e743c..00059ace4fd5 100644
>>> --- a/kernel/rcu/rcutorture.c
>>> +++ b/kernel/rcu/rcutorture.c
>>> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>> +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
>>
>> I want to say, I am not convinced with the patch because what's wrong with
>> writing to an old index?
>>
>> You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
>> early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
>> the "incremented i" or "the increment from the latest value of pipe_count".
>>
>> Anyway, a slightly related/different question:
>>
>> Should that:
>> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>
>> Be:
>> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
>>
>> ?
> 
> Thank you both!
> 
> At first glance, I would argue for something like this:
> 
> ------------------------------------------------------------------------
> 
> static bool
> rcu_torture_pipe_update_one(struct rcu_torture *rp)
> {
> 	int i;
> 	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
> 
> 	if (rtrcp) {
> 		WRITE_ONCE(rp->rtort_chkp, NULL);
> 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
> 	}
> 	i = READ_ONCE(rp->rtort_pipe_count) + 1;
> 	if (i > RCU_TORTURE_PIPE_LEN)
> 		i = RCU_TORTURE_PIPE_LEN;
> 	atomic_inc(&rcu_torture_wcount[i]);
> 	WRITE_ONCE(rp->rtort_pipe_count, i);
> 	if (i >= RCU_TORTURE_PIPE_LEN) {
> 		rp->rtort_mbtest = 0;
> 		return true;
> 	}
> 	return false;
> }
> 
> ------------------------------------------------------------------------
> 
> That is, move the increment to the read and replace the re-read with
> the value "i" that was just written.

But that changes the original logic as well? It looks like with the above
change, you're now writing to rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)
+ 1] instead of rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)].

I think that might break rcutorture, because there is an increment outside of
the first 2 entries in rcu_torture_wcount but not sure (need to look more).

Thanks.

