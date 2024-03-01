Return-Path: <linux-kernel+bounces-88235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C397286DEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EE71F21DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91A6BB27;
	Fri,  1 Mar 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lMKD6+g8"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4C482C1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287486; cv=none; b=lkU7YjAa2BDSh6FTFoNLVEQk7LXGdcAQaBSQNXb1zN6Eius6pWpa8ch5xRaqNw4wihJfryKHGV5PNMT66LLdCFJ5mjlO0797zcADdg1fB5tSvWXO6dNuMetJDGGrjSjwaR0iw8r3cBQv6jyl3xsE9gVAd8AocLqLrrynPyH1N+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287486; c=relaxed/simple;
	bh=Ywr521iUJfSrn2SrLrM5UvKDcsEi9DKyoi9OA0sjxV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxwZe4CaW11PKKc78z1vbQMBUMb6eLB8EqqKAiBBOhYxQ2k93w9s+RS1VKtQyu2P5w/YUyoBgYvnUqrnvxJBTgunYSOx/cU15Yh1eX3vyrwrVYkJD5NmRwHH6D/jhHRAEz8E0QZhQ+fDGKUs82TbGB12T9PFBednGP31XGQ24UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lMKD6+g8; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709287481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SZgTfC1fKx1O4M9nIhdIuFaeCZVB+kk+ad6JzpNSi/g=;
	b=lMKD6+g8nc+bUmFYwwRIiNtMVgKP2wFBLc9StN1N9fV7fjjVcjAmCnyjFTu+uGo2zyufzAvoi3YRS9y06JfpXJlP/KAlv4c6plxg356sxHlLG1D5OVSQgtZSj1ozbrbcLCPCqatTQ0z/Jjq1+BshyEQdL+kEAtAw69ItIpSVNXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W1bTuTN_1709287477;
Received: from 30.97.48.218(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1bTuTN_1709287477)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 18:04:39 +0800
Message-ID: <72d3352e-e0dc-4527-bc50-a18d00d5195c@linux.alibaba.com>
Date: Fri, 1 Mar 2024 18:04:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Barry Song <21cnbao@gmail.com>, Benjamin Segall <bsegall@google.com>,
 Chen Yu <yu.c.chen@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mike Galbraith <efault@gmx.de>,
 Qais Yousef <qyousef@layalina.io>, Tim Chen <tim.c.chen@linux.intel.com>,
 Yicong Yang <yangyicong@huawei.com>,
 Youssef Esmat <youssefesmat@chromium.org>, linux-kernel@vger.kernel.org
References: <c2ceff07-e1b4-4dbc-b945-f91a9076375e@linux.alibaba.com>
 <59585184-d13d-46e0-8d68-42838e97a702@bytedance.com>
 <9b58ef1d-0d45-4fbb-b154-abcbb10211c9@linux.alibaba.com>
 <38a69b11-d6bb-4f0b-8080-7a051ad58206@bytedance.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <38a69b11-d6bb-4f0b-8080-7a051ad58206@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/1 16:30, Abel Wu wrote:
> On 3/1/24 2:41 PM, Tianchen Ding Wrote:
>> On 2024/2/29 22:25, Abel Wu wrote:
>>> Good catch. And to the best of my knowledge, the answer is YES. The
>>> above Equation in the paper, which is Eq. (20), is based on the
>>> assumption that:
>>>
>>>      "once client 3 leaves, the remaining two clients will
>>>       proportionally support the eventual loss or gain in the
>>>       service time"  -- Page 10
>>>
>>>      "by updating the virtual time according to Eq. (18,19) we
>>>       ensure that the sum over the lags of all active clients
>>>       is always zero"  -- Page 11
>>>
>>> But in Peter's implementation, it is the competitors in the new group
>>> that client 3 later joins in who actually support the effect. So when
>>> client 3 leaves competition with !0-lag in Linux, the rq's sum(lag_i)
>>> is no longer zero.
>>>
>>
>> I've different opinions. According to the comments above avg_vruntime_add(), V
>> is calculated exactly to satisfy sum(lag_i)=0. This is guaranteed by math.
> 
> Yes, you are right. I mixed another fairness issue with this. What I
> was thinking is that considering multiple competition groups (e.g.
> runqueues), the latency bound could be violated, that is someone could
> starve a bit. Say one entity even with positive lag could become less
> competitive if migrated to a higher competitive group.
> 
> Staring at Eq. (20) again, what if we do a fake reweight? I mean let
> the client leave and rejoin at the same time without changing weight?
> IMHO it should have no effects, but according to Eq. (20) the V will
> change to:
> 
>      V' = V + lag(j)/(W - w_j) - lag(j)/W != V
> 
> Have I missed anything?
> 

Good point! I've not ever noticed this conflict.

I tried to modify reweight_entity() to run dequeue_entity() -> adjust se->vlag ->
enqueue_entity(). And I found V do not changed.

The difference is, when doing enqueue_entity(), Peter enlarges the lag in place_entity().
Because after enqueue, the lag will evaporate.
In order to keep the same lag after enqueue, during place_entity(),
the new lag(t) will be enlarged with (W+w_i)/W.

So the Eq. (20) should be:


     V' = V + lag(j)/(W - w_j) - lag'(j)/(W - w_j + w'_j)

     lag'(j) = lag(j) * (W - w_j + w'_j)/(W - w_j)

So we can get

     V' = V + lag(j)/(W - w_j) - lag(j) * (W - w_j + w'_j)/(W - w_j)/(W - w_j + w'_j) = V

So COROLLARY #2 is correct.

