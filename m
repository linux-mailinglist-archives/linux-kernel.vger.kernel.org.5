Return-Path: <linux-kernel+bounces-97710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C957E876E40
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E761F21993
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488CE57E;
	Sat,  9 Mar 2024 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FPVeQX8+"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B3567A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945205; cv=none; b=ngOnHRchOBlxLEXrx/dUPTuQp5CU/rNUGW9q0x8nSgcrmSTgMTHGcLyA01lQrQ0Eq54PPEwRLSIARNkPd+b/0HYvVjByLhEUIe9CVGMI2pkljrw/4mkj99WdsqsU2CEiFVDZkhm3ZU/iLm1aPJHQnbOr9br+vfQqYIiMLuo/2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945205; c=relaxed/simple;
	bh=RcxxgpHEmgaPi896Qvphggp91cJd7Jx/qhqG1g1Tgfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1cbUV06kBe7+JKSp9YdBNbrPSB284n4VVgf+uwiXT/vmmnGvcc/bvKurZgAnvbtdw/qUI8EKaMqbwgaJqvqXY6qrIlBHRZLsDCjm859+L/1WVwVyX8qYZsSg8h0it422l6GsViDrDOQmn0aqjnVx0tlQwSrN6cr14SiaPM61cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=FPVeQX8+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78850a904e4so57585785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 16:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709945203; x=1710550003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EptQzLs5FjTlxzBvJQDHQC3FbpMgqXt70xxJFxUgrbs=;
        b=FPVeQX8+8MWpXJy4yXdXbbk2qbjUKsIHIWsN+2rDzNkYa7A4gIoOipOYB/3avs2ToG
         WQaDS27jE0PMCXy9bs0+Sr4mhHYIcCyXpYCOv83UhV97JJpRkjVuem4d2k/t1G7jrNRE
         ZJrvc0fPZn+9AwaYICHrg0XgYfrfPKttvuKDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709945203; x=1710550003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EptQzLs5FjTlxzBvJQDHQC3FbpMgqXt70xxJFxUgrbs=;
        b=cs8KKx2xmogNcXvhzvRpA7H2ti16D8FLWG6DyWOjLM9ggfc/v2B8XDIppM4H2QOTQr
         SsHFxaoEiGO+LLDjGGZyder0W+Q9C/uabgASfhBg3aBwZUEG8dQGEJULokAuw95RMbVJ
         98icWaO+fZseL+0Gyizn+a4DViDiUSl5rrf/Y0OyKn4oRDbfTbgfeTWObtBsAp95xcx1
         bD06HQYmloCKJzB61DPc7NBnQe/q2h7xkqUXCJplObNZtfIIdp9/W64YpkqkrssWiK1E
         fpFDVBujbDJ1+W+PibSeY0bSvSAxaMXvoYdQSZGYlH696PqiXccdjpRxWQ1rLvR/MZK/
         R8Mg==
X-Gm-Message-State: AOJu0YxDX1zgOni7HEm+mXkzUOAGoS8CmkLxPijb0A4jLOu2x8nTRm1m
	GrVfY9iX5h/bvu2pfJ4xfhBfS2Ysu1H8u0WHVBc48rcm8fX6iKROzlQ6lDLtLJo=
X-Google-Smtp-Source: AGHT+IGKvcGBGuT0KohlrTzxMDdmrCuDQSpM3Z/oPlSyBzWIuCA8pCSSGkWBeUsv2VIUiT51mnPhCQ==
X-Received: by 2002:a05:620a:85c:b0:788:5971:ef8a with SMTP id u28-20020a05620a085c00b007885971ef8amr745522qku.67.1709945202794;
        Fri, 08 Mar 2024 16:46:42 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a04e600b007883bee099fsm305020qkh.22.2024.03.08.16.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 16:46:42 -0800 (PST)
Message-ID: <a65bb5d1-8d44-44cd-ba45-d9549fbd870e@joelfernandes.org>
Date: Fri, 8 Mar 2024 19:46:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Content-Language: en-US
To: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <20240307234852.2132637-1-joel@joelfernandes.org>
 <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
 <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>
 <ZespK0CrkVFCu6_p@pc636> <ZetNHb6MrmHkQKJN@pc636>
 <d75fd0b2-f6e0-4102-a5d2-11c7c5487949@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <d75fd0b2-f6e0-4102-a5d2-11c7c5487949@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/8/2024 4:52 PM, Paul E. McKenney wrote:
> On Fri, Mar 08, 2024 at 06:38:37PM +0100, Uladzislau Rezki wrote:
>> On Fri, Mar 08, 2024 at 04:05:15PM +0100, Uladzislau Rezki wrote:
>>> On Thu, Mar 07, 2024 at 04:06:06PM -0800, Paul E. McKenney wrote:
>>>> On Thu, Mar 07, 2024 at 06:52:14PM -0500, Joel Fernandes wrote:
>>>>> On Thu, Mar 7, 2024 at 6:48 PM Joel Fernandes (Google)
>>>>> <joel@joelfernandes.org> wrote:
>>>>>>
>>>>>> In the synchronize_rcu() common case, we will have less than
>>>>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
>>>>>> is pointless just to free the last injected wait head since at that point,
>>>>>> all the users have already been awakened.
>>>>>>
>>>>>> Introduce a new counter to track this and prevent the wakeup in the
>>>>>> common case.
>>>>>>
>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>> ---
>>>>>
>>>>> Forgot to mention, this is based on the latest RCU -dev branch and
>>>>> passes light rcutorture testing on all configs. Heavier rcutorture
>>>>> testing (60 minutes) was performed on TREE03.
>>>>
>>>> Very good, thank you!
>>>>
>>>> Uladzislau, could you please pull this into the next series you send?
>>>> I can then replace your commits in -rcu with the updated series.
>>>>
>>> Absolutely. I will go through it and send out the next version!
>>>
>>
>> Joel, i sent out the v6: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
>>
>> Could you please rework the patch on latest tip once the series i sent is
>> settled on Paul's dev?
> 
> It is there now.

Thanks, I rebased on it and sent a v2 (along with that other comment for the
hotplug race ;-)).

 - Joel


