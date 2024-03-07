Return-Path: <linux-kernel+bounces-95936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911487551E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3421C21CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF2130ADC;
	Thu,  7 Mar 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ayz90ujO"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CE12FF8C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832385; cv=none; b=a6/jMfIHscBiktxEpAz223hC8Rv9pDmHFJaSox/ijmL2qCPhl805fUF+/jleVCGeTcL47rLhinSnV/Ogq+tfv+M50FkP1rdjYMfzPm+zui7sjDNP8DA3YG61U+2isY0NEq1Hu5x0GkmRBhSRf5vHjR5VeoUL3pihCDkD81WHFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832385; c=relaxed/simple;
	bh=4VKRPFROZxhfecLCGFPUt9H94MPeeXyOxYoh30MmVek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEJffSuzr58em9DZ0gHE0SMoOf0wm3OsS5IK76962wQhMT/74vr/G8rkcTzSERjYAH8b8XgGNc248xsUM1aCbfrVU7iZUDSZH67WLUKK1qCpAvgQlUk64AD8Nc5DaDLFuKMa/vtWP/e68UslsG/KnqGivGwIxwTL4iRQnB/88rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ayz90ujO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49ca7920-d429-434a-aede-1a200e8d5ce8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709832381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=typJzsyCZ7d0N2AWtsRnRkkZEuqyJ1S5uCH3hrAdMlA=;
	b=Ayz90ujO9VGGPBPBUzhJG/0z3frrtSSosfU6bd3HdfMioTtavGW2EUkG1Ej2q8KtTF8siq
	RiawcerkWVH1IqmUaJplOxSyFkFQ6Pu5Pbk+Kpe8G0KcewTfjN36YOsuCYE3oGj2f4d4Q5
	tQ5GrYK9qaIeKxKrjhRKtUdwZsGwHTM=
Date: Thu, 7 Mar 2024 12:26:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND2 PATCH net v4 2/2] soc: fsl: qbman: Use raw spinlock for
 cgr_lock
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roy Pledge
 <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Camelia Groza <camelia.groza@nxp.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240222170749.2607485-1-sean.anderson@linux.dev>
 <20240222170749.2607485-2-sean.anderson@linux.dev>
 <53b401d7-934c-4937-ab83-6732af47668d@csgroup.eu>
 <34da1e7b-029e-410b-8735-a10d6d267e2b@linux.dev>
 <6764b9c5-b61a-4f20-a41a-125d5015a3e6@linux.dev>
 <63ab7b62-853c-4996-a493-465283252d5a@csgroup.eu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <63ab7b62-853c-4996-a493-465283252d5a@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/5/24 17:18, Christophe Leroy wrote:
> 
> 
> Le 05/03/2024 à 19:14, Sean Anderson a écrit :
>> [Vous ne recevez pas souvent de courriers de sean.anderson@linux.dev. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> Hi,
>> 
>> On 2/23/24 11:02, Sean Anderson wrote:
>>> On 2/23/24 00:38, Christophe Leroy wrote:
>>>> Le 22/02/2024 à 18:07, Sean Anderson a écrit :
>>>>> [Vous ne recevez pas souvent de courriers de sean.anderson@linux.dev. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> cgr_lock may be locked with interrupts already disabled by
>>>>> smp_call_function_single. As such, we must use a raw spinlock to avoid
>>>>> problems on PREEMPT_RT kernels. Although this bug has existed for a
>>>>> while, it was not apparent until commit ef2a8d5478b9 ("net: dpaa: Adjust
>>>>> queue depth on rate change") which invokes smp_call_function_single via
>>>>> qman_update_cgr_safe every time a link goes up or down.
>>>>
>>>> Why a raw spinlock to avoid problems on PREEMPT_RT, can you elaborate ?
>>>
>>> smp_call_function always runs its callback in hard IRQ context, even on
>>> PREEMPT_RT, where spinlocks can sleep. So we need to use raw spinlocks
>>> to ensure we aren't waiting on a sleeping task. See the first bug report
>>> for more discussion.
>>>
>>> In the longer term it would be better to switch to some other
>>> abstraction.
>> 
>> Does this make sense to you?
> 
> Yes that fine, thanks for the clarification. Maybe you can explain that 
> in the patch description in case you send a v5.

Hm, I thought I put this description in the commit message already.
Maybe something like

| smp_call_function always runs its callback in hard IRQ context, even on
| PREEMPT_RT, where spinlocks can sleep. So we need to use a raw spinlock
| for cgr_lock to ensure we aren't waiting on a sleeping task.
| 
| Although this bug has existed for a while, it was not apparent until
| commit ef2a8d5478b9 ("net: dpaa: Adjust queue depth on rate change")
| which invokes smp_call_function_single via qman_update_cgr_safe every
| time a link goes up or down.

would be clearer.

--Sean

