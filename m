Return-Path: <linux-kernel+bounces-154518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BE8ADD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6261C2139A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA50208A0;
	Tue, 23 Apr 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBr3y4v3"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D81CA82
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849122; cv=none; b=n7m1gm+hIj7wOw6AX8sN+WuSzRhEKGFXz9V39VTcKBvUqaZYZ7iKGaeAhG4YLlkQXqyvHjPC28Oa+QTwuhbW/McWuX/tgqC2MQR84++bK/micbNIXFiXmo4X454TKxNXz6Sm5uyiUhFMhrFH3CFaGqnxaWSm1l37RRXzkrltdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849122; c=relaxed/simple;
	bh=deKjbTQrX2Kr2a+JaHlLXbv8YBnP4MnlhZJmmMO6fFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enA8Bejj77pOzNCZtPqtTm8IcTBmhhvjIa7mLXFBY+lpC3HhHmY85gDttiSX93hoHXH5FJr05VxxNF/1EKc1LBPLTIPO6jTEBZzXBNrh8PLUs45PzWF9pbdAwTVDd+Vzn3N5jlrAiyekwbUsZJyp6srAPAJx7DJJlFj1SmNK6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBr3y4v3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so68162311fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713849119; x=1714453919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZ2pAl6U7OSdp/ImmnBqXaV8FpFqgZHPz2bwq5kVVXc=;
        b=SBr3y4v3qyxn4PwlgSnZeu/nvx0ILaSdlqSh1HQVnaYRaGtsVGYkKfhpvXILTazQfF
         eOzbJ4I5svT+6SWwO5HBLLVh0Kz+VEizZ+1MEFpl9+E8E/WwG4sdCvfQhmfHBrdIhdc/
         9JAb2LwcyGMIssCS28Kjbv0oBkrWBp8YAvolF2v5D56AhqkfGolzx3aENMUu/z03QJtd
         /sP92sDwLcJrNdof7aB9L2sOKUW2n/BBY8ik/DxQh7FXd+596E4QenQTTOn4Lpdo7pgY
         2zSyLerZ1lGpdoWQXNWWcp04KZ9zkc2saLiRyT8yzKhkTA9l10pdLmW8JWPI+UMoXRB1
         DPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713849119; x=1714453919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ2pAl6U7OSdp/ImmnBqXaV8FpFqgZHPz2bwq5kVVXc=;
        b=rAbGb5QACY5SCtO607pX6oGHxYInsAjEPA7Ao/cgBohC51y0Ao8uht5fye8QoryQPK
         TVKmNpQyY7LnkCxA8jMszcbOFIlpgz1huZRd78zKvJ7/63iun5wrNG36uqHIkcE58gqh
         FrGDyRmV0tX4Sd5f44cQfKMoO7gMAGYJPnUzFY76cW7nIEDpHbFES9Czm+HyGg42fTpC
         0BRyww4NzHL4/7KDb/oBRN0ExNlkBJvY84pLaQXbIn17MPFZUWTJU6nuSQgRs0jvmq0w
         FeBd2NpKjpe9hREUqLNWXG/pSkn0zc1e1ks+ci0MzCPL0mc8klibSgxA3ksP4B3z7vXo
         KvsA==
X-Forwarded-Encrypted: i=1; AJvYcCV2u947wBj5NV+WNmhKaU4/AOlQIJbZ8Y/Z4YL4H4nkGN6tlyZ4XmTshomGo36qk5esu7VUoZWYibgaPzHv3RIxZ+ndgY+LOTQ6PNsq
X-Gm-Message-State: AOJu0Yz/Yoy/ssor594/5hGi+ICbGrbS8HoT0zPgbKpvnUs5LeQglM50
	KBaSsyLbcXkO9Ky8ghkS6aKdvyW20P1RETk0hUrN/0D+Ep3bndy0
X-Google-Smtp-Source: AGHT+IFJgFMRB9WwbskKeMis0h4clRoakWvs85bvcXXeKC93DPxeLg8zJS48963UCHJSSgRKPneUZw==
X-Received: by 2002:a05:651c:218:b0:2dd:985d:9915 with SMTP id y24-20020a05651c021800b002dd985d9915mr2878323ljn.53.1713849118642;
        Mon, 22 Apr 2024 22:11:58 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id f16-20020a2e9190000000b002d89c1f0d9csm1543685ljg.69.2024.04.22.22.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 22:11:58 -0700 (PDT)
Message-ID: <b8856e9a-1720-4e22-bf97-8cf074983c34@gmail.com>
Date: Tue, 23 Apr 2024 08:11:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: change stubbed devm_regulator_get_enable to
 return Ok
Content-Language: en-US, en-GB
To: Guenter Roeck <linux@roeck-us.net>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Aleksander Mazur <deweloper@wp.pl>
References: <ZiYF6d1V1vSPcsJS@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <18d4811a-7c92-4bd7-b44f-aacf3c1f2f65@roeck-us.net>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <18d4811a-7c92-4bd7-b44f-aacf3c1f2f65@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 16:23, Guenter Roeck wrote:
> On 4/21/24 23:38, Matti Vaittinen wrote:
>> The devm_regulator_get_enable() should be a 'call and forget' API,
>> meaning, when it is used to enable the regulators, the API does not
>> provide a handle to do any further control of the regulators. It gives
>> no real benefit to return an error from the stub if CONFIG_REGULATOR is
>> not set.
>>
>> On the contrary, returning and error is causing problems to drivers when
>> hardware is such it works out just fine with no regulator control.
>> Returning an error forces drivers to specifically handle the case where
>> CONFIG_REGULATOR is not set, making the mere existence of the stub
>> questionalble. Furthermore, the stub of the regulator_enable() seems to
>> be returning Ok.
>>
> 
> Yes, that was the reason why the lm90 driver worked pripr to its conversion
> to use devm_regulator_get_enable() if CONFIG_REGULATOR=n.
> 
>> Change the stub implementation for the devm_regulator_get_enable() to
>> return Ok so drivers do not separately handle the case where the
>> CONFIG_REGULATOR is not set.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reported-by: Aleksander Mazur <deweloper@wp.pl>
>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: da279e6965b3 ("regulator: Add devm helpers for get and enable")
>>
>> ---
>> Please find the report by Aleksander from:
>> https://lore.kernel.org/all/20240420183427.0d3fda27@mocarz/
>>
>> This patch has not received testing. It'd be great to hear if this
>> solves the issue.
>>
>> I see the regulator_get_exclusive() and devm_regulator_get_optional()
>> returning errors. I thus leave the
>> devm_regulator_get_enable_[optional/exclusive]() to do the same while
>> wondering if this is the right thing to do, and why...
>>
> 
> At least one of the callers of devm_regulator_get_enable (exc3000) 
> checks for
> -ENODEV and ignores it. I assume we'll see more of those unless this patch
> is accepted. Many of the callers of devm_regulator_get_enable_optional()
> explicitly check for -ENODEV and ignore it. Others fail if 
> CONFIG_REGULATOR=n.
> My plan for affected hwmon drivers is (was ?) to check for -ENODEV and 
> ignore
> it to match other drivers.

I'd rather fixed the stub than the callers. I suspect same goes with 
other subsystems.

> Returning ERR_PTR(-ENODEV) for [devm_]regulator_get() made sense because
> the returned regulator pointer was often used to obtain a voltage or to
> do other regulator operations. I don't really see the point of returning
> -ENODEV for the _enable APIs if regulator support is disabled.

I agree. I'll send another one for the 
devm_regulator_get_enable_[optional/exclusive]() if Mark accepts this one.

Thanks for the heads up!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


