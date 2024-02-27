Return-Path: <linux-kernel+bounces-83842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39667869F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E954628B9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB8146015;
	Tue, 27 Feb 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avDc06aR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80A3D541
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058540; cv=none; b=RcjfSZMHV7blbIFS2u+1S6l+d/FFtoOJ3tBpKt3KXATWq5cPS2QEMAEf2c4/Lrw3UnoK21gq5h9DrqaWVitxmcF8leHKKrRe99zTTzT7iB9jjRXoI+P5cVDNfMMmCp30hQKqFZtfJWxh3Xr99UoC/WLJgEoqYl22Poj7ELZI8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058540; c=relaxed/simple;
	bh=RWSPVHwB5Dq0Z/lIjJDobhDIPRP8aEV5Wk3poCrZaEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsl0M/Vcfd3Tc4RjR5RmFkB3A8vGUl1ZRdjUq/J9SWL/s5X9cDzNhrU3GJgYp0Oz6Y8XEx+N4wPaLUynnxYLQ+kLqgiF+xGwWa95FpbACLZv5fl8fp6UgBba6wJ/lYrkFoShDnrDQIm6MZt7xqmYrpgnE3A8GM5Tsmpn8QaThdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avDc06aR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709058537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAirFKPVqfCxuOSfdLRYPU9/LUc1bLX2BGDNlapPAr0=;
	b=avDc06aR09uOjBgKTDHr1VLQtJV/8//FIvT8PGdEyahkPDDmuFPXXUpsFM/IW49wgR8CRr
	IIsn0rLq/drUgC5Nc1zypNcTmmRIAsF2HOTR06KEKf2JMfsL1u7mOJQ5TJrfxntfWADJ5d
	VUMK6O/L10WyTNLqLPwWt2ksEgTDXzQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-xnE3zyZwPVWVI0oDFD7czA-1; Tue, 27 Feb 2024 13:28:51 -0500
X-MC-Unique: xnE3zyZwPVWVI0oDFD7czA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5a05c6e6715so3730557eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058530; x=1709663330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAirFKPVqfCxuOSfdLRYPU9/LUc1bLX2BGDNlapPAr0=;
        b=nrKTG1Tep46n5Xo9l1SQ2ifENtEV0mFVDttp/P2lS0L3zRGnt/HM7CRrQas9CdJafk
         udC0WUxBCX4ASK/piBD/DhzKkT/pIcMOUcmJprUL2xr53UQZIbHUnaV66Ve2YlmpO5TU
         Fs75htssdFGW4MOdbm04w4rwZk/LaPJ1wcwz6bbvlr1+i3JMdk7xPn/9MvuQbEjwn04G
         PbCAIETAMwJytD7cEYsiN9TBmOLm/eYv8Dc3jYlBQQNV6HcLM7T5r6GGeFDJbZtQdoe8
         ZQQg5BtK/NJDb02btqNbkQ8VWzzWCvdu4A8k8enZohs2RJMnhtfqj2zJZh0W62Q2oc3C
         YH0A==
X-Forwarded-Encrypted: i=1; AJvYcCWInwZpz/Sg1xj1aSElceqJTkG2dn6IkBfRqkW0TLPRpTcEjYw3Q70Q+EI2mJc3UjnKAsCRZFUR1SxWynHp9NCq1OFL30gf7oS9ZUee
X-Gm-Message-State: AOJu0Yz5+pPLqhe1NrjzRDxdsujxpFfjswrEBhLHBKqyZ/Jy6uz4sM7A
	QMeD5ydMyDnD5FeMHr/QVS8LGToCfFz8d5yImfDI67DF3iECfPWpL+WtwCGJ4p6y5XYILAfqX+q
	+jYe7vdoMvBpFdMo75q76CQ0/x5FQwd/0wbJ2A56oF6m+OhOFcGPQwdTcCajlcA==
X-Received: by 2002:a05:6359:4c0e:b0:17b:af7b:febb with SMTP id kj14-20020a0563594c0e00b0017baf7bfebbmr5069276rwc.1.1709058530707;
        Tue, 27 Feb 2024 10:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgqEXoocghrQ/7CjgIprLgqs1b2AG+6YTCqmF73tfMuRcN0udjDL1Day+68KH+VjEqYYYQJQ==
X-Received: by 2002:a05:6359:4c0e:b0:17b:af7b:febb with SMTP id kj14-20020a0563594c0e00b0017baf7bfebbmr5069250rwc.1.1709058529985;
        Tue, 27 Feb 2024 10:28:49 -0800 (PST)
Received: from [10.0.0.33] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068cdc0a0d42sm4380989qvb.25.2024.02.27.10.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:28:49 -0800 (PST)
Message-ID: <d5000215-68fa-4320-b5ce-639143e8f52c@redhat.com>
Date: Tue, 27 Feb 2024 13:28:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <cover.1708635408.git.luizcap@redhat.com>
 <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
 <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
 <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
 <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
 <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
 <4f6169e5-dee6-2188-f0a5-601b516be5fe@linux.intel.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <4f6169e5-dee6-2188-f0a5-601b516be5fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-27 08:18, Ilpo Järvinen wrote:
> On Mon, 26 Feb 2024, Hans de Goede wrote:
> 
>> Hi Luiz,
>>
>> On 2/26/24 17:10, Luiz Capitulino wrote:
>>> On 2024-02-26 11:04, Ilpo Järvinen wrote:
>>>> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
>>>>
>>>>> On 2024-02-26 08:27, Ilpo Järvinen wrote:
>>>>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
>>>>>>
>>>>>>> The mlxbf-pmc driver fails to load when the firmware reports a new but not
>>>>>>> yet implemented performance block. I can reproduce this today with a
>>>>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
>>>>>>> reports the new clock_measure performance block.
>>>>>>>
>>>>>>> This[1] patch from Shravan implements the clock_measure support and will
>>>>>>> solve the issue. But this series avoids the situation by ignoring and
>>>>>>> logging unsupported performance blocks.
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>>
>>>>>> Thank you for your contribution, it has been applied to my local
>>>>>> review-ilpo branch. Note it will show up in the public
>>>>>> platform-drivers-x86/review-ilpo branch only once I've pushed my
>>>>>> local branch there, which might take a while.
>>>>>
>>>>> Thank you Ilpo and thanks Hans for the review.
>>>>>
>>>>> The only detail is that we probably want this merged for 6.8 since
>>>>> the driver doesn't currently load with the configuration mentioned above.
>>>>
>>>> Oh, sorry, I missed the mention in the coverletter.
>>>>
>>>> So you'd want I drop these from review-ilpo branch as there they end
>>>> up into for-next branch, and they should go through Hans instead who
>>>> handles fixes branch for this cycle?
>>>
>>> If that's the path to get this series merged for this cycle then yes,
>>> but let's see if Hans agrees (sorry that I didn't know this before
>>> posting).
>>
>> Hmm, new hw enablement typically goes through -next and not to
>> the current fixes branch. And AFAICT this is new hw enablement,
>> not a regression / bug-fix.
>>
>> Is there any special reason why this needs to be in 6.8 ?
> 
> To me it sounded like fix to 1a218d312e65 ("platform/mellanox: mlxbf-pmc:
> Add Mellanox BlueField PMC driver") and 423c3361855c ("platform/mellanox:
> mlxbf-pmc: Add support for BlueField-3") although not explicitly marked as
> such.
> 
> But I'm fine with taking these through for-next, it's relatively late into
> the cycle already anyway.
> 
>> For RHEL kernels you can cherry-pick patches from -next
>> as necessary.
> 
> It's also possible to send them later directly to stable folks once
> Linus' tree has them after the next merge window if you feel they're
> useful for stable inclusion.

Fair enough. Let's proceed with the original plan of having them merged
in the for-next branch. Sorry for the noise this discussion may have
caused.

- Luiz

> 
>>> One additional detail is that this series is on top of linux-next, which
>>> has two additional mlxbf-pmc changes:
>>>
>>> * https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com/
>>> * https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com/
>>
>> Hmm, those are not small patches, any other reason
>> why this really should go to -next IMHO.
> 
> Those two linked patches are totally unrelated.
> 
> 


