Return-Path: <linux-kernel+bounces-158479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E688B20B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78811F261A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334D12AAEC;
	Thu, 25 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="luR1IsIF"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427912AAD5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045795; cv=none; b=tIR4ULVpaLcCLXYoVPN+yarAExYJjq4sXFx4HkHXGJ1keTbC1KYB9ZOPimC1PWHRZCqIi0gw37boNRhtQ8vs4IN9N6PBLIyPj3/nMl+aviKCP8w3lapPoM6A4H1NEErfA3H5R8hZ/oCtYwLn4FmxWA/Xck+Gzfue++T/v7RSN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045795; c=relaxed/simple;
	bh=QMwi5pZTWg2gTDWDgL+t923p+F1W347CVXo4YkprfRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1MNH9ZOlZRnYS3RODPeDiEBetSUUvXlhP9JCh97pTcAZOP3n9EUPlL+qA9jMj19V2XVrK3UFyvOMpJKtVDYLJoN2TSTcqxa7bGu+Uo7JGJFERYkmaOtJ/AdRAN3g+TBShCjZEZkKIgYrR8CTI9Z743AWri7HJghoyPhUviKTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=luR1IsIF; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id zxYmr07EK9WDgzxYmrAmWg; Thu, 25 Apr 2024 13:46:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714045601; bh=QMwi5pZTWg2gTDWDgL+t923p+F1W347CVXo4YkprfRU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=luR1IsIFMbvuZG8STGHbiG12/Gm5idza8AOQNj+nWamWQpnFqsqQdQ2CVgN8a5UUx
	 gKpTTeaaIo0oxuZK4BiVpsRdzc6gQ01TWOCrCUvbUeqwFPtYFyg/9GPrmWwL6xVp7D
	 hcpXi4fuHbL3/QiC8bShQRVx+JiwEHYuH1guFPa7PbLIFZAtArZa93oDgoi6pY1Y6s
	 OtakJwC1q3Jwxe+g02hyewCrY86o5r38ZYCfBdJQy6oQknrVPfbp1IP5ZwSdxJt8o6
	 vgTWzzov/U31NgTY1yX7HlXQdoYNqd28J9TgGZv07CB65n+dp6wFsF0b3+dCBvoFo2
	 ayV4mZGqy/7QA==
Message-ID: <80e759c4-8016-488b-859a-25a07cc2094f@enneenne.com>
Date: Thu, 25 Apr 2024 13:46:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240410113502.73038-1-bastien.curutchet@bootlin.com>
 <1f7f5b2f-54d4-4dc1-90ff-b896c930faed@enneenne.com>
 <5bda0980-2373-4284-bda4-89f0c6944e76@bootlin.com>
 <eb64ec08-2ae3-48bb-9f84-3cec362280b2@enneenne.com>
 <27196117-32bc-4892-b545-d9cf43a89f0a@bootlin.com>
 <c1e93cfe-371c-4855-9a13-b4b453bb9e88@enneenne.com>
 <28c5456d-535c-4ed9-b13a-fab7f50412be@bootlin.com>
 <9255124b-958e-4ab4-a812-67ad5d36e16d@enneenne.com>
 <6f064bd8-7937-4634-8a39-13ee5bcd6193@bootlin.com>
 <d4b4fb72-79e7-4e06-a038-4645574a799b@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US, it, it-IT
In-Reply-To: <d4b4fb72-79e7-4e06-a038-4645574a799b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDkMftp2TQYyrHaggmTqYI9eOZJm2I4Vimahe+nP4783IdLFNvvgOlhrle9cEWUyd7/cR6wCVacqrsNOZ42bk+ezmvvIkTR2lqJJfSd5QESH7d2jdNxn
 cHQxdM2LxXh+VNP+yySDLnL8QQgNSLi0oLiuO0ki7skzN6VD2DK8GochIb7B80Yum95Fa83JZxcwjCO5MxzEGOXsIYmMvcm8Q416u0mNpxl+R7Rg+mljCvcJ
 epUuKrdkJce1jtxivzj+mA+rTIPBx4v7gP3RDij9VeXtI5vqqOp7TGr1I16vye6Qbr6EXh62cZ/ZUyphMRapMudSHSYMnh20qIGYhE1mXKpjQiYgQ13QzCTI
 I32mTE4CVw2LVFpjp1IAZDNwCF8UIA==

On 25/04/24 08:11, Bastien Curutchet wrote:
> Hi Rodolfo,
> 
> 
> On 4/12/24 14:20, Bastien Curutchet wrote:
>> Hi Rodolfo,
>>
>> On 4/12/24 08:44, Rodolfo Giometti wrote:
>>> On 11/04/24 14:44, Bastien Curutchet wrote:
>>>>>
>>>>> However we should think very well about this modification since it could be 
>>>>> the case where we have a device sending both assert and clear events but we 
>>>>> wish to catch just the asserts... in this case we will get doubled asserts!
>>>>>
>>>>
>>>> My understanding is that clear events are to be captured only when this
>>>> capture_clear boolean is set. If it is not set, the PPS_CAPTURECLEAR
>>>> flag is not added to pps_source_info->mode and get_irqf_trigger_flags()
>>>> will return only one edge flag (rising or falling depending on
>>>> assert-falling-edge DT property).
>>>
>>> Yes. You are right.
>>>
>>>> By the way, I see that the capture_clear is never set since the legacy
>>>> platform data support has been dropped (commit ee89646619ba).
>>>
>>> I see, but it can be re-enabled in the future... In this scenario, I think we 
>>> should add a DT entry to enable this special behavior. Maybe we can also add 
>>> a warning as below: >
>>> static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>>> {
>>>          ...
>>>          if ((rising_edge && !info->assert_falling_edge) ||
>>>                          (!rising_edge && info->assert_falling_edge))
>>>                  pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>>          else if (info->capture_clear &&
>>>                          ((rising_edge && info->assert_falling_edge) ||
>>>                          (!rising_edge && !info->assert_falling_edge)))
>>>                  pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
>>>      else
>>>          dev_warn_ratelimited(dev, "no ASSERT or CAPTURE event? "
>>>              "Maybe you need support-tiny-assert-pulse?");
>>>
>>>          return IRQ_HANDLED;
>>> }
>>>
>>
>> I'm not sure a DT entry is needed. IMO there are two cases:
>>   1) capture_clear is unset. We need to capture only assert events,
>>      interrupt will be triggered by assert edge only so there is no need
>>      to check GPIO state: we can use the bypass.
>>   2) capture_clear is set. We need to capture assert and/or clear
>>      events, interrupt will be triggered by both assert and clear edges
>>      so we can't avoid the GPIO state checking to distinguish clear
>>      events from assert events: we can't use the bypass.
>>
>> So if we bypass the GPIO's state check when capture_clear is unset and
>> leave current behavior when capture_clear is set:
>>   - case 1) will be more efficient and we won't lose tiny pulses anymore
>>   - case 2) is unchanged: we still might lose tiny pulses but as bypass
>> can't be done here, I think that we can't do better.
>>
>> I agree that adding warning when the handler is left without triggering
>> a pps event can be useful, I can add it in a V3 version.
>>
> 
> Would this be OK for you ? If yes, I'll send a V3 version without DT
> entry but with an additional warning.

Sorry, I completely missed this e-mail! :(

OK, I agree.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


