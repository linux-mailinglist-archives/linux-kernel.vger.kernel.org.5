Return-Path: <linux-kernel+bounces-88097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72386DD4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44642812D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB669DE8;
	Fri,  1 Mar 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e9HSzudx"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC066996C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282573; cv=none; b=c6CK5C3ZAJBD7Q+XT8LfzE2LnDpZA9OB+NGnXBjzvB0QvDMdq1fQZmFmDutl+Kv1LUvJGvlVlaEukyySYCeWEhJ10ei7Y5p3c6BpljQ58QfEvVnqJjp3bK+wR/P6+e6qqCDECGTRUT17mSa8eUqchrWEcEtFeoMWIu6VB76kUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282573; c=relaxed/simple;
	bh=CVQ/wkJG321HC3Ap/Q78Z7KCGpl3R/NjhgVh+N7LCVM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C0trsK0pc25V7spzCXDnUvIjNgDxcC/eadzaoauUb5k+8xt/yHnaBqKyoJDFb5U6zKLulpEB3DMT7iv7d8noKlRXcgSyhHZwa+VSmB6yxtyjBWFCdNpajV0J0YHUr/i6QmeRnGGJj6LYaUrjdiU/STn8pzmy7aqRgVjiy+QxbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e9HSzudx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e58d259601so1109215b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709282571; x=1709887371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KdNC3oe1WSL+F1IPFbZFbrQMkxS6FkIzXReU84R4k6c=;
        b=e9HSzudxWdyZgQKF/CCF0N3rI+6WZ4Nqln7W5H4iVJTkQpUFQnXwYQYmW7YFTx4SxM
         465EU+cdgmoPf/NXk0lU4hsCooXN/1O3G6Y3yNNqE3XDXOb7AkgGdS9pyeyN3/Ai57gJ
         luo9OfoE4ZoejooM4Mx1sMrxAJCkKtSid9MZMHS9hZKrmzdjZe6oQ26l6e0J99hiu4l2
         uPRShoONbtHRK1zVSkKWcF38r/QVpladG/Xb//IpL81Kn3XuMyKdqo+T6NsppqayReN8
         D9/HdCTtFPrT+2cO+tX2SZFgboCJXQlQiFLBYq1+lTkl4sal8Q2hz6632vin4yeC84CR
         Ba4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282571; x=1709887371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdNC3oe1WSL+F1IPFbZFbrQMkxS6FkIzXReU84R4k6c=;
        b=FntcSmXbW7a8CQaBGkNUjoDgBJjYmrhk1nULWgzu1bULmcIza7/msddm47EYBwEdwx
         yXIt2Jbztj0tKITqihk42KKPfxFDMbU1OAbDXlnsw94qNK6RoEcFxc9LBjvDWIPnhjj+
         Noqo4USAET0CGgxlqGmgTT1jghA36NftQ5QXbSVl3W6o20MUlXyMhgM343CvCG7rPEuy
         K6z1zGG8FvTxIp9P9Pc/Q42LshpI6Z2EmN0JarvvFRTo2DYTCwMO7vclM81/tk3eORmo
         JxNmyOijADYHoH7nZTtJ4EwTJ9Fmyt0MPqjNOz+jJiB3S4jCYDpSs+uA2GOcCrlmLh/k
         8tXw==
X-Forwarded-Encrypted: i=1; AJvYcCWRSIw1myK1RGpUo2k8vBNjIiw01fpOnBTEoBikuGNTZ3Z3QyJiKuFmy2Tgs0jLCEZvyYta7fPaTXINmMDyYJ92mc8q94UiNc87tSkn
X-Gm-Message-State: AOJu0YxZRcQ96Tumm7DEs0nPIOplFVNQjYGZsK2BP97ySFzKVFO4d1b4
	F3rtj/laFXD1n8fgeBwgNCaS/+bp/pQNK8pZhkTrthoYbeCj+kkTLwRnVazfs1s=
X-Google-Smtp-Source: AGHT+IGxmv0CSJLMAeZorgy/5TAaVKdEm10UfEZdJp+HRCXarlwvk/zxh4v/5oEZWnoJfFRRg+VcOQ==
X-Received: by 2002:a05:6a20:9146:b0:1a0:f0a4:8206 with SMTP id x6-20020a056a20914600b001a0f0a48206mr1017606pzc.29.1709282571058;
        Fri, 01 Mar 2024 00:42:51 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id kr16-20020a170903081000b001dcc0e239fesm2869636plb.232.2024.03.01.00.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 00:42:50 -0800 (PST)
Message-ID: <63102e0a-8a16-4b1d-b8f8-d9833079c924@bytedance.com>
Date: Fri, 1 Mar 2024 16:42:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <ZeF+uc/jMohokNRb@chenyu5-mobl2>
Content-Language: en-US
In-Reply-To: <ZeF+uc/jMohokNRb@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 3:07 PM, Chen Yu Wrote:
> On 2024-02-29 at 17:00:18 +0800, Abel Wu wrote:
>> Hi Chen, thanks for detailed analysis.
>>
>> The title of this patch sounds a little weird to me, since any
>> non-empty cfs_rq should have at least one eligible entity.
> 
> My understanding is that, current + cfs_rq's tree has at least one
> eligible entity, as the current running entity is not on the tree.
> In vruntime_eligible() check, we consider all the entities on the
> tree, plus the current running one. So, it could be possible that
> all the entities on the tree are not eligible, while the current is
> eligible, no?

Yes, and I didn't mean only rb-tree when I said "non-empty cfs_rq" :)

> 
>> Besides, choosing the leftmost entity which could be non-eligible can be
>> sub-optimal, anyway this is only a workaround..
>>
> 
> Yes, it is a workaround to show the possible scenario to bring NULL exception,
> and it was not root caused yet.
>   
>> On 2/26/24 4:23 PM, Chen Yu Wrote:
>>> There is occasional report from lkp that the kernel hits the NULL pointer
>>> exception:
>>>
>>> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
>>> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
>>> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
>>> [  512.082337][ T8305] *pde = 00000000
>>> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
>>> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
>>> [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
>>>
>>> This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
>>> After
>>> commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
>>> the NULL candidate would trigger the NULL pointer exception. While before
>>> this commit, there would be warning.
>>>
>>> This NULL entity issue was always there before above commit. With debug
>>> patch to print the cfs_rq and all the entities in the tree, we have the
>>> information when the issue was reproduced:
>>>
>>> [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
>>> [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
>>> 			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
>>> [  514.536772][ T8390] Traverse rb-tree from left to right
>>> [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
>>> [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
>>> [  514.538539][ T8390] Traverse rb-tree from topdown
>>> [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
>>> [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
>>> [  514.540340][ T8390] Found best:0x0
>>> [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074
>>>
>>> We can see that non of the entities in the tree are eligible, neither is
>>> the current entity on this cfs_rq. As a result, curr is set to NULL:
>>> if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>>> 	curr = NULL;
>>>
>>> and the best is set to NULL, which caused the problem:
>>> if (!best || (curr && entity_before(curr, best)))
>>> 	best = curr;
>>>
>>> The cause is that, the curr is eligible, but vruntime_eligible()
>>> returns false. And the false negative is due to the following
>>> code in vruntime_eligible():
>>>
>>> return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
>>>
>>> According to the log, vruntime is 18435852013561943404, the
>>> cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
>>> thus:
>>> s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
>>>       delta * 2677 = 7733399554989275921
>>> that is to say, the multiply result overflow the s64, which turns the
>>> negative value into a positive value, thus eligible check fails.
>>
>> Indeed.
>>
>>>
>>> So where is this insane huge vruntime 18435852013561943404 coming from?
>>> My guess is that, it is because the initial value of cfs_rq->min_vruntime
>>> is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
>>> seldom scheduled in, its vruntime might not move forward too much and
>>> remain its original value by previous place_entity().
>>
>> So why not just initialize to 0? The (unsigned long)(-(1LL << 20))
>> thing is dangerous as it can easily blow up lots of calculations in
>> lag, key, avg_vruntime and so on.
>>
> 
> Usually the min variable is initialized to a very large value, so later
> the real min can overwrite it easily. The 1LL << 20 was introduced decade ago
> in 67e9fb2a39a1, and I don't know why it is this value.

Yes, as the min_vruntime keeps moving forward given the way
update_min_vruntime() does, I don't think it would be a problem.

> 
> 
>> Say during this pre-life, which is about 1ms for 1024-weight entity,
>> there is only one entity running in this cfs_rq. Now another entity
>> with funny lag joins in, being placed somewhere at 0+ vruntime, so
>> cfs_rq->min_vruntime needs to be adjusted accordingly which leads to
>> the breakage of cfs_rq->curr's key as you showed above.
>>
> 
> Yes, this is possible.
> 
>>>
>>> The proper fix should deal with the overflow of entity_key() * load, but
>>> I don't have much clue on that, so propose this conservative method to
>>> restore the previous behavior before the mentioned commit.
>>
>> Inspired by Xuewen's proposal, will it work if limit the key?

After a second thought, this doesn't solve the insane huge vruntime
itself. Since the immediate problem is that 'huge' number actually is
a small one, is it possible to make vruntime s64 at definition?

