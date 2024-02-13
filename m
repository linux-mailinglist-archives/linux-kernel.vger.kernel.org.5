Return-Path: <linux-kernel+bounces-63472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47F852FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365271F23DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A3C383B4;
	Tue, 13 Feb 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVpNZtfk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3303D0BA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825442; cv=none; b=CwDz8vn4nQpAxHBJx+CbBhJ6dL0Mw4ClbWSa+5SaKkVOaFIBVFY7Z50/xH/JnBPtjmK7/ysfX/Vvdxiy8vxrvICRGy6zjV5rKv9iqtXVnvVhayTUA7EvGuGrBOHvJq6HqXvC0WERRm3/okD7AmQN1gG63zNHippvCTJOstD7jCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825442; c=relaxed/simple;
	bh=uRBwHX4V2+oCebTDAkdjB3RqXaHDG0QopeD7+97cStQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tk+uHWk78vDTAsdjtgB4IPo8RvZbdLsl+NiuZbmW4rMcz6nKrJ1mdzAIvWAE2pCe/1Jfr59Z2EPGY0Pp10laEP9w9GgU/oTJWUvotEdTfZx0NHy50UwuBw59tB6otXD8UYAHyXtzRJ3xd00c2yi/zVCZl0wIQhzPJl3DbuxlayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVpNZtfk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410ee8ed659so12039005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707825439; x=1708430239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzVXtifKzoPWvWy41F1BsusB4MNouwO00+RoQRAIJ5Y=;
        b=HVpNZtfkcF5X2BCdFjMXtoACYGWHwuuwl6CqDHz1Gs1lsAZeS9JER3n7FOYJ5F+E2m
         32kNBU0vOrS6Tv93iLVCMLEvv2CeN9IZBzmOlVbmLitWBH/dghNYXZz0NbbB43eBJGL9
         ThOoPOUXkEClP8kLnHE8mQJFlamCOmdgaEDu6GzlBcSVkCOFt14Pg3D/6bQYLo65dBe9
         Cnj9DGJtdUF+tQs0/JYpyjHtN/MK4we7mJrRMz8lAddYumDK/CTh0nFigRR+bShGYXG7
         f8uCKh5ZK2JjD327G2FHb6dSGlVirx4wXQm443oeIwVIeNpIlvBmA+4omIj8i95ZJ1oV
         el8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825439; x=1708430239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzVXtifKzoPWvWy41F1BsusB4MNouwO00+RoQRAIJ5Y=;
        b=UnnDxj8Nqd5/s1QZ8bk/PAPwm362x6dNcgPvFatFp88HFaz2FgPC0WHsqO8JpeyWe6
         6PSPpiKFn5SFU02dPZxEDpGafF+kYZqXUzvZmbCFXd3gqOtZo8S8lIhZhYE/UlEvMpN1
         hlyPpM6LYTzMkY7Zqpb9Sr/fo7E+A+D8Sv06Zpq1KbEQH6gr4PxRnpD9RDjAZjiZspiI
         Z65fcNyO9UcH9DmbFcorpPi8Ce7ckJaaLTRTd5yLZpWMOvmY60p3YkXGA+FOmpmuNHQF
         YzLiZy6UzNsBGx6MGvjZVVD9cdwBKs7X0+1bFiiwqC0TKkqE6091O9fzHBKHZ4cHCoP+
         Vk8w==
X-Forwarded-Encrypted: i=1; AJvYcCWqjWLwOgfMJRicv4QA8E/BWW/4oLqwF+PN5eymDhFCJ7Iu4/L5V/Gd2OwUf14+tEyJDQWHB1KsPpauEdzEuB2Hg3A250Pt3IM4HdJa
X-Gm-Message-State: AOJu0YyUx2/QBVUu6TtYgic51WHR4FJPnf56v+qvuyIDplYB/GAJERpo
	SHU0UGsDWImlBCI3wfx458+tcbSPvgYRtcYd9coA7JItkVxJ0bOqvN+GeljP4RQ=
X-Google-Smtp-Source: AGHT+IETAhWvQ9h2qIadjb+qX83sI5DVgMIQNalwTbdC8iHZrouroIKy/6rN8jqyiiWN2waevlnb8Q==
X-Received: by 2002:a5d:4983:0:b0:33b:4197:75dc with SMTP id r3-20020a5d4983000000b0033b419775dcmr7289673wrq.14.1707825438827;
        Tue, 13 Feb 2024 03:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnD18s7ldMUMwENNepv0AJKymSbCZ9AVBAZbedzUiU0fuahInWmxqrmvXt0ZUDculRqMFO4Vfr+wZAB6x4Bq3DPk0Dol7P/Xy+3HON7exw0lX7On1ASfFLq/oQ56Rd9tY5Qg20ijmn9lQil/ew6R1E0dzLJ8PV9wJnZaW4gwtKWpQ7AvB5BJ5yq8jJBzgqQSXe3yMqQsH/9sNtLHwtdXl/mUKNiGnxUWhhy3qycXgplBe62qCkXaiTM2b9aHQ3QFYEnjl6no3ehsurabtjxx6rldQH+cXDfT1cFtIDRz+SYsk0IW+COlPFzI2kJFf/9MErB6+7GoZpkewejSgGOOP8079Sa30n8X+c1DlRHVG+M98zgifp/k9p+8KZXco2qfjvqui1bVRqVTUlOLSvg78M55ePdBXm0jg9UGvwEZaQosy8jOq0awDzNXsEP9xZ
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6504000000b0033cda80f54dsm1268569wru.83.2024.02.13.03.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:57:18 -0800 (PST)
Message-ID: <52be1d88-51a1-4ec7-8aaf-6046f5a469f4@linaro.org>
Date: Tue, 13 Feb 2024 12:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add
 'power-domains' property
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 Conor Dooley <conor@kernel.org>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-3-christophe.kerello@foss.st.com>
 <20240212-chemicals-skinny-18eda1cfe781@spud>
 <c57b8094-be08-4ae4-ba85-f48522e5d2a8@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c57b8094-be08-4ae4-ba85-f48522e5d2a8@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 11:57, Christophe Kerello wrote:
> 
> 
> On 2/12/24 19:33, Conor Dooley wrote:
>> On Mon, Feb 12, 2024 at 06:48:12PM +0100, Christophe Kerello wrote:
>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>
>>> On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
>>> Allow a single 'power-domains' entry for STM32 FMC2.
>>
>> This should be squashed with patch 1, since they both modify the same
>> file and this power-domain is part of the addition of mp25 support.
> 
> Hi Conor,
> 
> Ok, I will squash this patch with patch 1.
> 
>>
>> If the mp1 doesn't have power domains, shouldn't you constrain the
>> property to mp25 only?
>>
> 
> As this property is optional, I do not see the need to constrain the
> property to MP25 only, but if you think that it should be the case, I
> will do it.

The question is: is this property valid for the old/existing variant?

Best regards,
Krzysztof


