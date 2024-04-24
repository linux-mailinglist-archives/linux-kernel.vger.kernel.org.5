Return-Path: <linux-kernel+bounces-156834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A98B08E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DABCB22C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D215AD9E;
	Wed, 24 Apr 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="ks8YkGwZ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB1159919
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960350; cv=none; b=LV69xAXwcWLWTDT4aLYGCiz/OotFZ1L4EPlzPdZMePWX5pbrSBtyTnVHbrXfhFwEDm+1wneDsECjBkk5SDuA+VATT4YhWIIgrnzxJKJQ65a4BXC7QWwhop/KH03DsbvBJ1hXTciOPXqhfSX6RY93AD+vw+tHTt3Zt3qKMD2+5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960350; c=relaxed/simple;
	bh=O9Y9XW9Bf8tQwBetsJd8cr2rhoDDnWiPSv3Wv8RVtfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKXjTRUxpIUheaeagfDN7l8E7hF8IJ+8rTt+j5Z62XPehjZJxcz2gn3pvThPIwtCHe5jKHrh4J3ZmDsnQePAlDm4Wme68BpfvhEu7r61KzgXBnZC+R8u6PPOdO4p4XGHOE/Orc4otgxo4B04epspxAJBG7w2cDsuTItusMD6rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=ks8YkGwZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3f17c64daso44236615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713960347; x=1714565147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+FykyxhMPJPKFfFxIzTojGiVzkxju+/n6mO5lG++54=;
        b=ks8YkGwZ9WesyzVattAimXAcqCXuDwuIXOeyFFfXrHFX1VP/HoVeKcvg3OpNMJsZNX
         8ZQFqtSmLbqNcchZooELgEkTRGJK5r5wiiBUYVPJ16vLJea4DBLGAELveKrAvORdNW1S
         TuH42TSmw7tZSRsAdjOtXOZeqG2FiyV6rxQIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960347; x=1714565147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+FykyxhMPJPKFfFxIzTojGiVzkxju+/n6mO5lG++54=;
        b=F3EtBisRZfLe/JjheknUsgeGQKlz8W2Al9DbYk6X+MsuqD4iXHD02Sx5bdKzxWAe5v
         KJ2+dyCE5J1RyFCpw2X4hDRwxeZMznMLr2AugOm3yoa0ps5idhFKNXF3wGp+a1m+ApY0
         P26QFKFOL/P90n/g8Qa6PrCyqrUQHAkajt5Q78SsjX1HSC4U+D98YyA534gLBRTcgCbc
         dBcj+g8EBHQRaayvFSXQ1yadDO3I6gw2uRTKg4YiF4v3G9RuHmrFu2u4en97f2WEd5IW
         ABSlkoWR6YCznQXyVDlMpV+2JNKzgOtHlbiYgFpYoERbVZWlAIF/0tsk9XvYcEug2Q9C
         5SPA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Hnqhmlt/7mwRM9eEPoFuRX/bkiI0x1N9iRpOBZgGF9rvvN6K9UoO+ulJN9IMC6q/gSdCGsZjrd4mt5yavxR5c3wUgCG+lb8RA1tg
X-Gm-Message-State: AOJu0YyKtAlllaeqGs4oVPpkYarT8fDYpuDmKDdtZ8BPW6MQiYpxZ21O
	N4QjAQ5QLEdOseSNd9h7mhYy1zIXGN7OAwL9Ot2nchTlF+MJsD4qx9Gm6S3Vxw==
X-Google-Smtp-Source: AGHT+IEXVBByB7qMgyM2JwnpcF1ugnJgAAgMtOW169Er0h+ZLNEaK8zxB1N1x9RTjArZnauZ8RRf7A==
X-Received: by 2002:a17:902:e809:b0:1e3:e137:d3af with SMTP id u9-20020a170902e80900b001e3e137d3afmr2745775plg.9.1713960347458;
        Wed, 24 Apr 2024 05:05:47 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm11722255plp.259.2024.04.24.05.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:05:46 -0700 (PDT)
Message-ID: <51a660cc-4562-42d7-a6fa-0f6f7e3f47b6@penguintechs.org>
Date: Wed, 24 Apr 2024 05:05:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
 <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
 <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
 <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 5:01 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 13:59, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 4:53 AM, Bartosz Golaszewski wrote:
>>> This must be your email client wrapping lines over a certain limit.
>>> Try and get the diff from lore[1], it should be fine.
>>>
>>> Bart
>>>
>>> [1]https://lore.kernel.org/lkml/CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com/
>>
>> I don't think it's my client. The extra newlines are right there in the
>> lore link.
>>
>> Look at the line that starts with "@@". That line is wrapped. The
>> following line ("serdev_device *serdev)") should be at the end of the
>> previous line. The same thing happened on the second "@@" line as well.
>>
> 
> Indeed. I just noticed that it applies fine with git apply and figured
> the output must be right. Anyway, this is not a proper patch, I will
> send one once I adapt Zijun's code.
> 
> Bart

Weird. Git apply failed for me. That's how I noticed it.

 From my terminal:
➜  linux git:(my_master) ✗ git apply ../blah.diff
error: corrupt patch at line 6


FWIW, I also tried pasting it into stdin by running `git apply` as well.

wt
-- 
You're more amazing than you think!

