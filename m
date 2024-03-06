Return-Path: <linux-kernel+bounces-94353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A92873DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E26284408
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458613C9C9;
	Wed,  6 Mar 2024 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OVO+pVEx"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320C5D48F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747851; cv=none; b=bzM+xUa0VmYUV9MaL0S8nWJFImAU8j/LAkkzbvpmpZ9dQxAFJyJh9/DR/PmkyZmvRJDN/Vi8YMe3iIl+4WOdMpySVdeAj05fqSjMeM6qTIslrFEjW4TE3YyD3Z/I0Qv1v65L6Y1S0hsLPxB3ddKZrPX86rJB/HwIroqRZDuavzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747851; c=relaxed/simple;
	bh=DoLZ73UQ2sYr922EjiFb/8hKJ/WS5OtlQihqq3Ilgks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r57sTr+lJnLJlkg+WSL4VYy8dm5bcn1f8VEjZQkpVvE+ZYNUJVigMsUUcmqW8ClgXVBQxvQyKICfBox4aBu5n6AYMaOOICBiQR13P80N8QeG460zrfeBtbMJcusgb2n0eF9PTt6hMsZwaJW1C0ezli+aL/GddWhJo91yytN0iJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=OVO+pVEx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-788451c9b39so120285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709747848; x=1710352648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxvsCK9smmdnLvgdOu7MnGblD5Q3xTi7tR97NRw7gKg=;
        b=OVO+pVExAxY1bM9+5hREGAwF86HaujtYA0evK8xlQMfLwjb/cAZqhG7wjpPzNpuYJk
         dobuQ1WoddvHZcr+xRDyIaTdM73vRE0BGgGA8KAZE8KSHLp11zmfKMQEvTLKyQ3VvJkA
         T9wp0tqHXkTPedv0lf1DV4CGZfUjM94TOCfYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709747848; x=1710352648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxvsCK9smmdnLvgdOu7MnGblD5Q3xTi7tR97NRw7gKg=;
        b=LWZ0opiJ5Nkg48J9PbAlF4VbzWWu7lxuAFXXfSBIzNmPZDPD37CK72PmW6cu7ko8tF
         eNq5BkWv4OlFGim2OS7ryfU3JMLS4S7+QF50wmJiE5N5IjImuKsoff2vsyrV7Eo2myiT
         SidoiLOlE5K0KDGKnLwkgUSaXfU/9zRrBaL+xRTUTQBCWz/e7Ktr4IIlUSml6DdJBBQX
         PUCZzUh919BWeT8wJj2fCbL1ErdnJyVDJTrnlECycbIvPLM4cssLCCtLQNpE0ZoBCy2v
         uiFu6QD1ii05wK8sdMhtFLbGqPAz9MtUJs4pGyZX0GD3nH/+NCVJTkPVKdOi78Q3CCMl
         HUGA==
X-Forwarded-Encrypted: i=1; AJvYcCWF3s1agyEVTGDbwcnFrkD0XG7i3VIqH0TOjz5/Ch2iQx9/yWImkbh4Hk/HT0MbrhL77A1VxYSxMCxMTctghc5SVjnUs8KoFCuDLXsW
X-Gm-Message-State: AOJu0Yx4Xepd8+APnglUT7oQZA4fLRfGwB+G4WXZWr9qskt5l0hwMkWR
	6d635sNKv35w9lIhki+9ydpB4oOV1AsorQXtcWzMNRKPNlWvk/gYUAF0RL0yGto=
X-Google-Smtp-Source: AGHT+IHZ/f852118jg9L107pjZpuQhswgcnlCoZ5h6KU543SroWPfn4eMaDEOJNVNfW29yzzJ2cQbQ==
X-Received: by 2002:ae9:f709:0:b0:788:2ab7:2a62 with SMTP id s9-20020ae9f709000000b007882ab72a62mr5216638qkg.77.1709747847911;
        Wed, 06 Mar 2024 09:57:27 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b007882b4cecf8sm3123212qkb.57.2024.03.06.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 09:57:27 -0800 (PST)
Message-ID: <ae0475d7-fcfa-4d6f-9bb0-03479e6bf83b@joelfernandes.org>
Date: Wed, 6 Mar 2024 12:57:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>, Z qiang <qiang.zhang1211@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng
 <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240305195720.42687-1-urezki@gmail.com>
 <20240305195720.42687-2-urezki@gmail.com>
 <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>
 <ZehZ7Ef3DW2mT9fc@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZehZ7Ef3DW2mT9fc@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/2024 6:56 AM, Uladzislau Rezki wrote:
> On Wed, Mar 06, 2024 at 10:15:44AM +0800, Z qiang wrote:
>>>
>>> synchronize_rcu() users have to be processed regardless
>>> of memory pressure so our private WQ needs to have at least
>>> one execution context what WQ_MEM_RECLAIM flag guarantees.
>>>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>  kernel/rcu/tree.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 475647620b12..59881a68dd26 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>>>  /* Disabled by default. */
>>>  static int rcu_normal_wake_from_gp;
>>>  module_param(rcu_normal_wake_from_gp, int, 0644);
>>> +static struct workqueue_struct *sync_wq;
>>>
>>>  static void rcu_sr_normal_complete(struct llist_node *node)
>>>  {
>>> @@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>          * of outstanding users(if still left) and releasing wait-heads
>>>          * added by rcu_sr_normal_gp_init() call.
>>>          */
>>> -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>> +       queue_work(sync_wq, &rcu_state.srs_cleanup_work);
>>>  }
>>>
>>>  /*
>>> @@ -5584,6 +5585,9 @@ void __init rcu_init(void)
>>>         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
>>>         WARN_ON(!rcu_gp_wq);
>>>
>>> +       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>>
>> Why was WQ_HIGHPRI removed?
>>
> I would like to check perf. figures with it and send out it as a
> separate patch if it is worth it.

I guess one thing to note is that there are also other RCU-related WQ which have
WQ_MEM_RECLAIM but not WQ_HIGHPRI (such as for expedited RCU, at least some
configs). So for consistency, this makes sense to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org).

thanks,

 - Joel

