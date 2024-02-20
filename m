Return-Path: <linux-kernel+bounces-72813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95885B8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1136A1F22ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E2612CD;
	Tue, 20 Feb 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpyJa0+2"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBA612C4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424513; cv=none; b=Z20XIJJGdLwgq4lZvyIDqew5Yb5c7rUjiIxX3J2liKJDgmqbF94QZZIfJg2ute7/tsb1PYR5OHq70/3zYgOKx2dF7Uti1LgW8I+DOuBW7tQJub3Yrr561nFXLSQFvS/q8m3TQrWLkBrj/ASrEyT7XXvg77eND7N3Tkwna+dwYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424513; c=relaxed/simple;
	bh=l+6vL/HseUJabxznTVBBygKWClRYouXRDDHpHVunfw0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E7pj5BBee2vGQftE0sN4l8YTM6zBS1JGFLWTcKhHiaN4XtWJafQ86jIrmCiuF1t97XoXRwZf08hZvoOnRJi8pg9at2tD9WXLrrt6+lqY6otYIPEuXckoGtqj8atPxAAnrsGZiwwLXHv2NLhOS3pLA2ahtWTljTfGjfppebT4JGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpyJa0+2; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c029beb8efso156663439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708424510; x=1709029310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWLyKGf2OzPwpyR/7I3wALj0gwUBfV+6YeWACxu9X0c=;
        b=lpyJa0+2Ipgrt5yIuOBZis3vbJHUU0/+/kB4PTXhEtmnLfPtgNVvndApTU9FwXeDfo
         RwHjtppbx+Ks5tsCyRW/E/g/pZ7UD5N2xxaZRAgMvqfCmeHCBkrQAU9kmiCr2wF4LS3R
         7yraxGHlpAv+oG4eWsMZ+CZhnm3ltXtU6PRgfd/yyPzbclp5O5F7B9GQ31L55cTjjlz8
         Hw/brPmOSx4PD05lfSycQzbJGOydQXORDUDVOomVcKXCD2nDiL47B7L/Uks/l2mS+bcz
         PW7tfqtOn8sIM2xtZM6z/K5MSRhRTtQ2Eqoxu3wmJ+3qCjKJh7Gz+H0ce4jftUNQfGYX
         t33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424510; x=1709029310;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWLyKGf2OzPwpyR/7I3wALj0gwUBfV+6YeWACxu9X0c=;
        b=j6DSKAiF7O2j/8j8/QdXtKVYm8+NjWaC+Bk4y5q2qhDzM5mkywqfEOfegWicZuGxf5
         6i4lqhwBSH+lfQKcuarhoujB7Na6RHfDPqMroStOatoiKgZA4qJhKAmjjzy3qLYbYECu
         oNhq2RRDAW2NiaKrtefciwKqUhHHg1mr1sXDZsu+VBZn9xm0uYRGji5PgpwhPoZe9FpD
         RrTeBrwAbO7En9bSEY2t7xoVlVtrx71QFbCqdTizuL7+rh7TNeSRlH57Bf9KEARs9nvf
         t9P2VmcqvdTeU306DllIrA+Pg5pgNmPJRWiux8JHJdK+eE9fmJ6HEwrmdKkwkymPSyLr
         46JA==
X-Forwarded-Encrypted: i=1; AJvYcCWgsw8zC/Fe1JuH/R4oNj1HSB+M9v9UFp0mPyFBO5SGDHf397bGjKuvdAf1dk2wSEt+mruNp/zgrN7T4cP2YMhAH3O8FubQyhTQ0vYs
X-Gm-Message-State: AOJu0YyfB3MavWL3DNIkR7sm+S1InKmdCPuoxBHfELnVHYquUMZYk128
	bshxeYEKHYJV5kImWZKp+lSLQIealyEz8AAt3AVHAlaNZhNlU0z4ybfonhzos0OQiJg9jCJheSu
	6
X-Google-Smtp-Source: AGHT+IFWbdSsycDqURd5EafZbMqOilJJcmry8aAuOk/pc6GoMhmHtYsNyadnbBjlZIy1WrR3n7X8nQ==
X-Received: by 2002:a5d:938c:0:b0:7c7:29ee:f399 with SMTP id c12-20020a5d938c000000b007c729eef399mr6700246iol.2.1708424510507;
        Tue, 20 Feb 2024 02:21:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id gw22-20020a0566381ef600b004741cd2bcbdsm1447525jab.156.2024.02.20.02.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:21:50 -0800 (PST)
Message-ID: <c0b6dd69-c52f-4da3-8eda-d6eeb544cb25@linaro.org>
Date: Tue, 20 Feb 2024 11:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] w1: Convert to platform remove callback returning
 void
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Rob Herring <robh@kernel.org>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
 <jodslbkntas5fzftwl4llynbvcw5p4pmup3t46euifpvzo36m7@yvlfqcmbkiux>
 <3eb8e209-3d86-41a3-b65c-58f0f24ad6b7@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3eb8e209-3d86-41a3-b65c-58f0f24ad6b7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/02/2024 11:19, Krzysztof Kozlowski wrote:
> On 19/02/2024 21:25, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Mon, Feb 19, 2024 at 11:59:26AM +0100, Uwe Kleine-König wrote:
>>> this series converts all drivers below drivers/w1 to struct
>>> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
>>> Provide a remove callback that returns no value") for an extended
>>> explanation and the eventual goal.
>>>
>>> All four conversations are trivial, because their .remove() callbacks
>>> returned zero unconditionally. 
>>>
>>> There are no interdependencies between these patches, so they could be
>>> picked up individually. However I'd expect them to go in all together
>>> via Krzysztof's tree.
>>
>> This series hit a corner case in my patch sending scripts (because the
>> maintainer entry title has a ' which I failed to properly quote). I'll
>> try to resend the patches that didn't hit the mailing list.
> 
> I don't know what you are referring to. I don't think I ever received
> your patchset and from another patchset - linked here, but not marked as
> resend? - I got only two patches.
> 
> Please make a proper submission. Don't attach your patchsets to some
> other threads. If this is resend, add proper "RESEND PATCH" prefix.
> 

I think I got the rest of patches here, although this is still oddly
threaded.

Best regards,
Krzysztof


