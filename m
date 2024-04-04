Return-Path: <linux-kernel+bounces-131912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD0898D82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037FB1F29331
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916112EBDC;
	Thu,  4 Apr 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfWmcbZ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51099127B7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253046; cv=none; b=FakfCvVxQMq39xYD5EEs/hMZTyEMJrHxcSM+Q4KjGX7+a/6z97h0lOwgIJLA8IfjVqWWEt5e648QY3b3SiMsWXQ4+vnRK1BSDalhHF7fxnHFv/l8TX/a56qGL6c3bCo2eeFl3LrRR5hlW8lsCb4U7AQAEzcu9XEwPFFLeA4zOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253046; c=relaxed/simple;
	bh=W21fuAF2rkys7Im4PKJVRHCVBK7AE+eMcJlc2OAzKmY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=qMSdDQkCW4pGg2ajsz6ufN99TAr+mP1IXk/ZvJ+CLQ9ncwMgpEpt1wNo6NHkucJshfFrYenPqAJ1HtqgO/z/yJohnLSNdslpsV8cd6ZJ4X5GwWMm7UXb2/hDEIjPZuG2hbW7RZw6SuyE3BfMmvtUiVtq3E4+ec3+Wuclo4HzcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfWmcbZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712253044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgKEb1rXTdvNH8JDPDJiSaFb25n7WatPE3FFaKX5XuI=;
	b=QfWmcbZ4YGbwov5Rcu5oT+3Fia+Fu6bn2EW+VUGMsiLVhYbZ4ISrqdYqIClgKqytTcimGP
	sz+C7YZxM9qNoRGa8ZHa+FKHl3YkuDv6Ce/3hj1tYFV7zWGs7104ndpCz4KQ32GPw+nEiG
	z3Vjsd1kanUqTrRUPsAXYdt8txFpaBc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-VPivc9aeOTSgzG-XVZC_dg-1; Thu, 04 Apr 2024 13:50:43 -0400
X-MC-Unique: VPivc9aeOTSgzG-XVZC_dg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-698fbfa5815so10694646d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253042; x=1712857842;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgKEb1rXTdvNH8JDPDJiSaFb25n7WatPE3FFaKX5XuI=;
        b=oxQ5DAtlPQgV9CNYxhznkdhtmIE2/fF/bhSCYDZUYfTCpKON51Qz1gXeyd+9dj9bIk
         ATLZblVGYflJXcU9XMum9gc6WKCiu6FJehbKjzmZoHpzeVZj2Ck+dtZvDJwQ2b/s8Xcv
         9N8TuX8YyT3u/vS8NUHC/y0nMIaIo0tK6uIMyq2Uw6Isf4X7iclAXPSTkUECaR6Zzm4t
         IJXYFTCJg0Blkz733fI60neFHK+dFSokT7iRkwpQb4hpKp2Z9o2HN1JhFJqGNQWEsPFN
         kogaMC+xwPh+DfyI+J6PlcaRMBGHA4kJ04RGPuCizenZo/oegQmZD6dTWpoAUGVqTjJQ
         aWcA==
X-Forwarded-Encrypted: i=1; AJvYcCVt+vRz+i5Xcl8iUE7www3aRyYmdpxBUmzulTXxz57cOGTtjJ5fy0d0U063OhVvCTFKDmEtYPoTdUltLLhpNusihOa7aX9vqYr/Hh6g
X-Gm-Message-State: AOJu0YxOvVkHINwqpCSsCTt6I4NStnVz2I2QM4bj2TkNP68u4EUx0w7c
	wY8NdGMXs/uG84sBRhoZtm0QDnbXb4yVRvOatjCGyRm4ND4QaahbEr6aCqE4+92234jKsDInnZq
	CyQEQFuXBug+X6LB4Fq//K/tLD0AhxaaMiISkxd4/o2RDHleE31wuIvJH6Eih+Q==
X-Received: by 2002:a05:6214:c45:b0:699:1b4e:86dd with SMTP id r5-20020a0562140c4500b006991b4e86ddmr355026qvj.46.1712253042652;
        Thu, 04 Apr 2024 10:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfqDyU+xRrhXUQaCFKdFFr5YaWy2EKNCdq89OVDW6wNlJQnyZidYDoNQfj+eQka0PnWuNdSw==
X-Received: by 2002:a05:6214:c45:b0:699:1b4e:86dd with SMTP id r5-20020a0562140c4500b006991b4e86ddmr355009qvj.46.1712253042319;
        Thu, 04 Apr 2024 10:50:42 -0700 (PDT)
Received: from [192.168.1.34] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id a1-20020a0562140c2100b00696804c73c5sm7657214qvd.115.2024.04.04.10.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:50:41 -0700 (PDT)
Message-ID: <4506bb59-5524-8b0e-f97c-a0252d4784ad@redhat.com>
Date: Thu, 4 Apr 2024 13:50:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>, zhangwarden@gmail.com
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402030954.97262-1-zhangwarden@gmail.com>
 <ZgwNn5+/Ryh05OOm@redhat.com> <Zg7EpZol5jB_gHH9@alley>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] livepatch: Add KLP_IDLE state
In-Reply-To: <Zg7EpZol5jB_gHH9@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 11:17, Petr Mladek wrote:
> On Tue 2024-04-02 09:52:31, Joe Lawrence wrote:
>> On Tue, Apr 02, 2024 at 11:09:54AM +0800, zhangwarden@gmail.com wrote:
>>> From: Wardenjohn <zhangwarden@gmail.com>
>>>
>>> In livepatch, using KLP_UNDEFINED is seems to be confused.
>>> When kernel is ready, livepatch is ready too, which state is
>>> idle but not undefined. What's more, if one livepatch process
>>> is finished, the klp state should be idle rather than undefined.
>>>
>>> Therefore, using KLP_IDLE to replace KLP_UNDEFINED is much better
>>> in reading and understanding.
>>> ---
>>>  include/linux/livepatch.h     |  1 +
>>>  kernel/livepatch/patch.c      |  2 +-
>>>  kernel/livepatch/transition.c | 24 ++++++++++++------------
>>>  3 files changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
>>> index 9b9b38e89563..c1c53cd5b227 100644
>>> --- a/include/linux/livepatch.h
>>> +++ b/include/linux/livepatch.h
>>> @@ -19,6 +19,7 @@
>>>  
>>>  /* task patch states */
>>>  #define KLP_UNDEFINED	-1
>>> +#define KLP_IDLE       -1
>>
>> Hi Wardenjohn,
>>
>> Quick question, does this patch intend to:
>>
>> - Completely replace KLP_UNDEFINED with KLP_IDLE
>> - Introduce KLP_IDLE as an added, fourth potential state
>> - Introduce KLP_IDLE as synonym of sorts for KLP_UNDEFINED under certain
>>   conditions
>>
>> I ask because this patch leaves KLP_UNDEFINED defined and used in other
>> parts of the tree (ie, init/init_task.c), yet KLP_IDLE is added and
>> continues to use the same -1 enumeration.
> 
> Having two names for the same state adds more harm than good.
> 
> Honestly, neither "task->patch_state == KLP_UNDEFINED" nor "KLP_IDLE"
> make much sense.
> 
> The problem is in the variable name. It is not a state of a patch.
> It is the state of the transition. The right solution would be
> something like:
> 
>   klp_target_state -> klp_transition_target_state
>   task->patch_state -> task->klp_transition_state
>   KLP_UNKNOWN -> KLP_IDLE
> 

Yes, this is exactly how I think of these when reading the code.  The
model starts to make a lot more sense once you look at it thru this lens :)

> But it would also require renaming:
> 
>   /proc/<pid>/patch_state -> klp_transition_state
> 
> which might break userspace tools => likely not acceptable.
> 
> 
> My opinion:
> 
> It would be nice to clean this up but it does not look worth the
> effort.
> 

Agreed.  Instead of changing code and the sysfs interface, we could
still add comments like:

  /* task patch transition target states */
  #define KLP_UNDEFINED   -1      /* idle, no transition in progress */
  #define KLP_UNPATCHED    0      /* transitioning to unpatched state */
  #define KLP_PATCHED      1      /* transitioning to patched state */

  /* klp transition target state */
  static int klp_target_state = KLP_UNDEFINED;

  struct task_struct = {
      .patch_state    = KLP_UNDEFINED,   /* klp transition state */

Maybe just one comment is enough?  Alternatively, we could elaborate in
Documentation/livepatch/livepatch.rst if it's really confusing.

Wardenjohn, since you're probably reading this code with fresh(er) eyes,
would any of the above be helpful?

-- 
Joe


