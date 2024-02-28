Return-Path: <linux-kernel+bounces-85275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E332D86B351
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F0A1C22172
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3315CD60;
	Wed, 28 Feb 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g49UoDnh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFE15AAAC;
	Wed, 28 Feb 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134725; cv=none; b=PSCsluoawcmWBp2NY2tlyFqeM5bW8bDZ/FibpA2i0YQbRM3ZH7v217XTaj8BHxJn4BqnvNZRUKl0eoZGnh3RNod6FQwYJvwHNrcGYxHmbVFZHQ+8PJypsT+sIDHzB2jqDO+X0ev4xMW+JPlPJwCPdrbjcDxdYKsNNMcZEsJY35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134725; c=relaxed/simple;
	bh=iJeUJi/luH9JIXda5+DINsauQvK/VukwffetB/vSorc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fodKHBC/DjA7fi7x4ktv90jMGkMwqB/k4rlqvmNzqQ4jac7fuo6SHniInGVaOxYrHeB2N9ZORSoVpBOiH3IMpbzsPVIUkLg4yfr74z/jc3eYPPmQPSYFqTzmdQF/Z8bHmhQIQboJatvG76SeebImk4ztPUlthHk2ige9RLmLyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g49UoDnh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SFce6j119434;
	Wed, 28 Feb 2024 09:38:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709134720;
	bh=dwlqjsbOKohax9+3cUFztzE/P5qLwn8+RnjCD3aEjVo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g49UoDnhEETvI2UULxrMYz325EE1mjiTwQLcxbMZYDgK5Mq8IbMh+5ZULyTkY1O2K
	 5pDeKfPWBHsw9EvB7bd6HTy7b4+jVtyIpiO+Udi10XQSasvYgq+9G/EZ+QKDEExFhm
	 mEPxz6sv8mzlj7g5QdMGziiusjTE4NHtqDY3o20o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SFceN0076040
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 09:38:40 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 09:38:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 09:38:39 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SFcdwR055557;
	Wed, 28 Feb 2024 09:38:39 -0600
Message-ID: <1f5c1533-5c9f-4cc2-b40b-6e9b22374640@ti.com>
Date: Wed, 28 Feb 2024 09:38:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-2-jm@ti.com>
 <461a19cd-36ce-4c34-890e-655a05a81c58@intel.com>
 <6d939482-9a3a-4923-b74b-ceb31b0ba7e9@ti.com>
 <4618f19d-0b7d-4844-83f7-ff2f4be083d9@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <4618f19d-0b7d-4844-83f7-ff2f4be083d9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Adrian,

On 2/28/24 7:21 AM, Adrian Hunter wrote:
> On 20/02/24 22:10, Judith Mendez wrote:
>> On 2/16/24 11:09 AM, Adrian Hunter wrote:
>>> On 7/02/24 03:15, Judith Mendez wrote:
>>>> +
>>>> +    if (!num_fails)
>>>> +        return ITAPDLY_LAST_INDEX >> 1;
>>>> +
>>>> +    if (fail_window->length == ITAPDLY_LENGTH) {
>>>> +        dev_err(dev, "No passing ITAPDLY, return 0\n");
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    first_fail_start = fail_window->start;
>>>> +    last_fail_end = fail_window[num_fails - 1].end;
>>>> +
>>>> +    for (i = 0; i < num_fails; i++) {
>>>> +        start_fail = fail_window[i].start;
>>>> +        end_fail = fail_window[i].end;
>>>> +        pass_length = start_fail - (prev_fail_end + 1);
>>>> +
>>>> +        if (pass_length > pass_window.length) {
>>>> +            pass_window.start = prev_fail_end + 1;
>>>> +            pass_window.length = pass_length;
>>>> +        }
>>>> +        prev_fail_end = end_fail;
>>>> +    }
>>>> +
>>>> +    if (!circular_buffer)
>>>> +        pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
>>>> +    else
>>>> +        pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
>>>> +
>>>> +    if (pass_length > pass_window.length) {
>>>> +        pass_window.start = last_fail_end + 1;
>>>> +        pass_window.length = pass_length;
>>>> +    }
>>>> +
>>>> +    if (!circular_buffer)
>>>> +        itap = pass_window.start + (pass_window.length >> 1);
>>>> +    else
>>>> +        itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
>>>> +
>>>> +    return (itap < 0 || itap > ITAPDLY_LAST_INDEX ? 0 : itap);
>>>
>>> Parentheses are not needed where they are but putting
>>> them around the condition would make it more readable e.g.
>>>
>>>      return (itap < 0 || itap > ITAPDLY_LAST_INDEX) ? 0 : itap;
>>>
>>> However (itap < 0) is not possible because itap is an unsigned type
>>> and if (itap > ITAPDLY_LAST_INDEX) then maybe it would be better
>>> to return ITAPDLY_LAST_INDEX
>>
>> You are right about itap < 0, thanks will fix.
>>
>> About itap > ITAPDLY_LAST_INDEX, this is an error. Why
>> return ITAPDLY_LAST_INDEX instead of 0?
> 
> It doesn't matter.  Just if a value has a better chance to work
> if the calculation fails, like maybe ITAPDLY_LAST_INDEX / 2, but
> presumably it should not fail.

Ok, ITAPDLY_LAST_INDEX / sounds good to me, I will add this instead.

Thanks,
~ Judith



