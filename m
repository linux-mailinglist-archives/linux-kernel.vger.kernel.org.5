Return-Path: <linux-kernel+bounces-88081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19B86DD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD9A1F21F11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031569D38;
	Fri,  1 Mar 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UQWev8oe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1148CDC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281824; cv=none; b=o6eyU7BfeYMKK3Bd3KcrhYj3r3Fy+/8f6oU0LnZ0ds1NY7KnIp/ezMTcfx1W6Fuam4F5ReHhdIzhj9ZXW7RluMIeepuZDM6Lm6gz2PGe37LOixLtowQFjBVRH3NTDWn1FJn+grRmlJWB/NSpcW4VV1XJHm17d/ec777LVbhNAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281824; c=relaxed/simple;
	bh=TfKIBc/iRqHtax+39Bv2LfsB+xrqonMZIkQsFhN5oMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR9hLeX30MYIQ+LnmDvlqsSBDUkPIFo5C6DHSNCD7OrGMhelapymRvwLsCbyRHkBRIS3YABjcn0yB45Mb1XwSUMXVH/nMdGCd38Wpa7FXvvQnANSaFYz3JKk0NlzCly9wenirf9ni5IrDubF/ryDkXHpGz/bEMOsfaT+YZC2wVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UQWev8oe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1434941a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709281822; x=1709886622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnAe6NaXIcHyl5242tMjeLqLzA8OFKi+GWbu0EaffXk=;
        b=UQWev8oeoVAV+NxcusqcKFFHRUhD0yjeyvPKpABFc6y1uDamSWgO/cSz7V99k+V8BZ
         ETh+uycp6s8I8DORwFnj1mZe32kSpXVdxeo9957WmO7bQcnSjiM6QQKlPjiTPmi13JzD
         ZN7lQz0wgmhihXa8k8sUyOB900ick81eHjTUuYYGsg61uLp9rMjhOGPjbtuKyuRUitHy
         mkAGH4q0xlYE9qM3xYR/vVRaAzEeRzDKlnOkshZI8p2o5sypGONueGt/WkByyqFHm3p4
         +3RObTwt892Y2kIcvI+A3xQrMRY5GXCjWd0d7IZUpvcKTfWtNon8lSq4sHCFX8qO1b5z
         hKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281822; x=1709886622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnAe6NaXIcHyl5242tMjeLqLzA8OFKi+GWbu0EaffXk=;
        b=euV018/c3d3hafO9uhQ5APErOBU199Zd26FiaCPrLZZKxYR4vI/jHovcunjgW8FO04
         VxTIXVwKC+HtAiq+UwZfneL8GDg97OTfhzcJl9qd5Zc8f+dNr/48WmUbUiGVKdMN+nwT
         SoBUnoYOX+klu2Fp/XaUAY4WgcIhXRa7sEEh+NsHx+meSny6u2tP8kDXwK6Er5nFHnpy
         1MfPrqINGA+YlMO4qxHHHFZ4HE/Mqkq9I3hp2y0trxVuRLMKjQRA7vngEZ6XAph6sJ/N
         FO5FP+/1yE2onNPXqHZlk7TljXb+ikN9dGkWwkmYayXDJSnjGBifzzRKIXTmxTUCXk83
         xI2g==
X-Forwarded-Encrypted: i=1; AJvYcCXbS3aJrxvPJegcW8DoATyIyVZrsFmOaZlEbNLygzQH/Zp5ThstOIjCSf/z5qlsNvXzx23r2GGaUSD7LhUtU4nfo6HOFg4R2USszQN3
X-Gm-Message-State: AOJu0Ywkx2Zl2Ma2FtHunMfF5bk0qlXJrrQzG5NQRMWfLkEj5Dx3qWb/
	69pPrlt3thtDtIE79MXEcO+PEI0HKCfNVoXbHxnxq8eBeZGRvZg4PBEmxjubdTU=
X-Google-Smtp-Source: AGHT+IGbzM9wpjNCWQIQ/m5Cf7V33ESVJMMgereQ6xXOsxnTfiohp9ooo/ZBqYT5kcM4ALBYYPtBaQ==
X-Received: by 2002:a05:6a20:3d02:b0:1a1:19f8:d2a0 with SMTP id y2-20020a056a203d0200b001a119f8d2a0mr999941pzi.27.1709281821800;
        Fri, 01 Mar 2024 00:30:21 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b00299be0e00c1sm5238144pjc.33.2024.03.01.00.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 00:30:21 -0800 (PST)
Message-ID: <38a69b11-d6bb-4f0b-8080-7a051ad58206@bytedance.com>
Date: Fri, 1 Mar 2024 16:30:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To: Tianchen Ding <dtcccc@linux.alibaba.com>
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
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <9b58ef1d-0d45-4fbb-b154-abcbb10211c9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/1/24 2:41 PM, Tianchen Ding Wrote:
> On 2024/2/29 22:25, Abel Wu wrote:
>> Good catch. And to the best of my knowledge, the answer is YES. The
>> above Equation in the paper, which is Eq. (20), is based on the
>> assumption that:
>>
>>      "once client 3 leaves, the remaining two clients will
>>       proportionally support the eventual loss or gain in the
>>       service time"  -- Page 10
>>
>>      "by updating the virtual time according to Eq. (18,19) we
>>       ensure that the sum over the lags of all active clients
>>       is always zero"  -- Page 11
>>
>> But in Peter's implementation, it is the competitors in the new group
>> that client 3 later joins in who actually support the effect. So when
>> client 3 leaves competition with !0-lag in Linux, the rq's sum(lag_i)
>> is no longer zero.
>>
> 
> I've different opinions. According to the comments above avg_vruntime_add(), V
> is calculated exactly to satisfy sum(lag_i)=0. This is guaranteed by math.

Yes, you are right. I mixed another fairness issue with this. What I
was thinking is that considering multiple competition groups (e.g.
runqueues), the latency bound could be violated, that is someone could
starve a bit. Say one entity even with positive lag could become less
competitive if migrated to a higher competitive group.

Staring at Eq. (20) again, what if we do a fake reweight? I mean let
the client leave and rejoin at the same time without changing weight?
IMHO it should have no effects, but according to Eq. (20) the V will
change to:

	V' = V + lag(j)/(W - w_j) - lag(j)/W != V

Have I missed anything?

> 
> Actually I print some logs in enqueue_entity() and dequeue_entity() to verify this:
> 
> [  293.261236] before dequeue: V=2525278131 W=3072 v=2526243139 w=1024 lag_sum=0
> [  293.261237] after dequeue: V=2524795627 W=2048 v=2526243139 w=1024 lag_sum=0
> [  293.262286] before enqueue: V=2525319064 W=2048 v=2526766576 w=1024 lag_sum=0
> [  293.262287] after enqueue: V=2525801568 W=3072 v=2526766576 w=1024 lag_sum=0
> 
> For the first 2 lines, we have 2524795627 = 2525278131 + (2525278131 - 2526243139) * 1024 / 2048.
> Which is Eq. (18)
> 
> For the last 2 lines, we have 2525801568 = 2525319064 - (2525319064 - 2526766576) * 1024 / 3072.
> Which is Eq. (19)
> 
> So whatever client 3 leave or join competition with !0-lag in Linux, V is handled properly.
> 
>> Good catch again! It smells like a bug. Since this @se is still on_rq,
>> it should be taken into consideration when calculating avg_runtime(),
>> but in fact it isn't because __dequeue_entity() will remove its share.
>>
>> And I seem to spot another bug, although not relate to this problem,
>> that we actually need to call update_curr() unconditionally if curr is
>> available, because we need to commit curr's outstanding runtime to
>> ensure the result of avg_runtime() is up to date.
>>
> 
> I've tried to record avg_vruntime before __dequeue_entity() and pass it to
> reweight_eevdf(). Then the issue is fixed. The V keeps the same during the whole
> reweight_entity().
> 
> I could send these two bugfix patches (one for this bug and one you sugguested

That would be appreciated!

Thanks,
	Abel

