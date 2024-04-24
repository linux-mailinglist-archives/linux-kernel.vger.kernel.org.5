Return-Path: <linux-kernel+bounces-156795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA878B0845
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C686D1F23380
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2A15A4A7;
	Wed, 24 Apr 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="auA/amJD"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7D15991B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957936; cv=none; b=SNWjDjOs4aezJ1ZqQ2uZ65Gnl4lhMKmtJXzp29EhARWQ0jhwfjIYaC3MTJhVBD9cZ8OIs1xbaDgEQoHw/lw0Rz0O0wIcWp+7CFiG4Ws/8o8lR2qrSVb7/kX4FJSqIF9kaibOUUB6E1yA6LpXDurus/H8d1BDk6fpwZLh2QZmjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957936; c=relaxed/simple;
	bh=OlyK9/DbJhCC0o4KxXv7H04VN0viztFvzGysswMOuuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe7LtHm8UzgyTc6HE7Hgmkh5VXStlb/N0a5krIyEGGtVPr7KBjZFpjezsWcFMJv665o6JY1fW1FTHFVFSrCiZF2ZI00YaU7WFdKmeZEbOqlzbj2pFaN+fLnZo+1zgW43UXkuqOwihQW6blYTtHytBiBsWBY6/40n74CW7G8YJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=auA/amJD; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c709e5e4f9so4407578b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713957934; x=1714562734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGYk9Mcks7zTmG6tyorPBUsdyDA+s6DwHQvlengwj5I=;
        b=auA/amJDS37Mx0ZNKy8JdpsChdzB259U1l/8sViKismJMoEEJ6+ucQNSHm0AD5Z1De
         y6lc2LPxjmA2jirrqYmOKnGscSGoJGKYxGpWyilSx7dGeUEuVw9/se2UC3TY+A/5d3wT
         PO8rTn7RECgtVQV4u/0D/bpMRaiSQY4G5vees=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957934; x=1714562734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGYk9Mcks7zTmG6tyorPBUsdyDA+s6DwHQvlengwj5I=;
        b=TjYu9XEDkoua9ZXzAjDtn4pIqnv2sYv5onfKApH/3Jyol/ALItblUuFqu4RFJ27RCa
         nF3Y/qpC0/bN5b6LLWgK+0DBuhXeUgaFzx9dqTytbPBOxWQ5FGHWT6xLk4vXRuylYs2d
         YHl3fheynCDg1YSVTOQQmzUk2xzx+Y9OnQD8QJd+PpWcODwUHyFq8UtE/yT3HfmLn7yi
         eK/w0JQUCr3QYUFMCBR1o/9Ht6wFYVxokwucvFbpZq29/e51q72GXM+TfEqfrLA8tS7M
         TPtylmI/32186AlkAT5838e5fKTooK0xpvskOXMltkyJkha9NHpacVqya6TJjcZvJGZW
         7MyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaVpSAuz9ge993gyV3Z9OKUmDLUKfDI7yUFXRErFRTu2Z/QhazMAQ7Ooj1T9VVKT6C8RpKQ823QSixTr37vzhNEWRq54ei1mMGDUnR
X-Gm-Message-State: AOJu0YzpZZgI4f2Wv+U7GluNs6Xxl5sxPUiamSEifQnLBbpnhSU06rS5
	hptxvSLFs7EtTBsHw1EvAOWCPo+HlbOHY0Au3i2iOzpj3BH6exixEtAq8jx0MLvVt9nVQRuRRTW
	YqTY9
X-Google-Smtp-Source: AGHT+IHMaNpYNCLYU19bb65Coe5+3npsynVlSpQTCGi9nNN32qNQeLePNCdm5WrLJclKqYdC+F1XBA==
X-Received: by 2002:a05:6871:5b12:b0:23a:fb32:85a9 with SMTP id op18-20020a0568715b1200b0023afb3285a9mr1888757oac.47.1713957934339;
        Wed, 24 Apr 2024 04:25:34 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id v26-20020a62a51a000000b006e647059cccsm11250356pfm.33.2024.04.24.04.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:25:33 -0700 (PDT)
Message-ID: <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
Date: Wed, 24 Apr 2024 04:25:31 -0700
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
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  said:
>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> Nack. This patch does fixes neither the disable/re-enable problem nor
>> the warm boot problem.
>>
>> Zijun replied to this patch also with what I think is the proper
>> reasoning for why it doesn't fix my setup.
>>
> Indeed, I only addressed a single issue here and not the code under the
> default: label of the switch case. Sorry.
> 
> Could you give the following diff a try?

I am compiling a kernel the patch right now, but I did want to let you 
know that the patch got corrupted by extra line wrapping. I'm not sure 
how you're sending it, but I thought you might want to know.

wt
-- 
You're more amazing than you think!

