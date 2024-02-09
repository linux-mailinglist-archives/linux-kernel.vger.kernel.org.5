Return-Path: <linux-kernel+bounces-59684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E184FA60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20C0B22A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7084A32;
	Fri,  9 Feb 2024 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+KtmzlJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F778288F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497750; cv=none; b=ap239CpT5lQtBKEpXyzqfUefgktQ6ZWngOfD26L5ACpJwM3MfI+zf2S+jQcOn8EOOJh0dUAQh6vAbLSUyA/ifeC650DLmVpnJf6OqgyCCThs6d9BIi2zgSs+6cDjxd6fVJW/IpYrMaSCPPPiKDaJmH8Vy2QctpYHNy6JxZhHA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497750; c=relaxed/simple;
	bh=B61Rg2x3KZvtDNSY12oX7uGKbJbce5tQZOfpV0DCdtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNV5o+h52nntZKeFGBGjh/pScsEUD2rqmzTMesMJcwtD4dNYHcUxZUhRjC758vtda/YH3NEyrac2zpzpGjw7pceVrNvN4Vd2kY91lTjY0iCJajKXbHRWm+MH1ep9EPTAlG9hQzG5DcNsbwQ5GprMJp73/BhoGNls+JuPBz2PG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f+KtmzlJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410489e1a63so9802505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707497746; x=1708102546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/epRNUqk5bS4B27yS6gbt0yFbjWLwovjSS3KxytHN1E=;
        b=f+KtmzlJh1Ln0Z/mKMt1vqL0AeIjEEGjxpK/95qUkFSSa+0HwgDorrscActzNU0nyS
         CY1aEw127hvTm62FPjZoi3vGAKWE6G3Bg14E3ZSk8IjxGLcvjL3XiIuzJe796S9QLxI3
         Qmqr1h46ov1+JKvJBCUUjS9MjJre+YTiZcZMs9ioSEwOLafzRh0MmH4yAHxLVbi5vTpc
         DTCehGnGAkhnkAMD5ynGKce6/npNikvZ3DE0ek7Lf7uGx7znmm/meUcN7nxTrGng8Znd
         OgU7FZcCYXKguttUyHyy5FpfvB2dSlxB1SHMVaB5B0eV0FqR5RVjtuBuP7KdGq5NxqOE
         S4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497746; x=1708102546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/epRNUqk5bS4B27yS6gbt0yFbjWLwovjSS3KxytHN1E=;
        b=dqWndFvJthB5QUjLxWKSY0fzIvAohpuFtMEfHCEyr4+ElPngTjLeee1CTxyLEyiso3
         j61d5Q8fMjzoZxFuxwc6DGOO4nqE6sGhH3g7olw7pVcd3fZ82YHhCI7gMKgujthird5W
         igH/QYZFAkWy6GxmhN4Z60+Br8tX1s4LWvSojQhaQ/JDGx5oiPSoU+EJ1AjC8q5pC6Ex
         GV1w+Pjc0NpL3FTRAg3WbxV5QqdiabQFQO4tAMbgLqbK3Xul5FnvBCyQetCXbn8NeB6i
         IdpcZ5wVWBe8FjQgkh9jDrdoud7wgM8m/y2H4kdcnzPqyuiKTplq0c2XslsyXXH/GWS4
         1qrQ==
X-Gm-Message-State: AOJu0YxlwUreIeTThluI/8ZaZehahBNzNFSPp5AFU55YNq0/beBkiQYN
	I6onQjgNV9U4kmNIN2Jp71ml3nNHY/f87aX14iqhGzU7KWYxuoap8552DcZJyv4=
X-Google-Smtp-Source: AGHT+IGDz7nT4Hwxrg8DOKvtqArAeRo/nRjYmEWj2rJqTy0Lf8i1frf6JpbdvA41af5doIW8cHQ81Q==
X-Received: by 2002:a5d:4e46:0:b0:33b:65b7:615 with SMTP id r6-20020a5d4e46000000b0033b65b70615mr1735251wrt.49.1707497745976;
        Fri, 09 Feb 2024 08:55:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwhnLUL9UmyZIkCpUXjW5FkEFhj65h0qSQTsUTtF817VZoSsFj9X3pMMYZiPwDP+pWEGWJwZiWGYkC4wtYXuw2jAtdwyAYGMZpJtNWENWJ1BOhoAkekX2adTD1gaVGh7lK9vF/rEdOr6E1LJSKO1GEFIBIhJpUMA8vd0neupmmfKIHStt2L7mqLCkK+JiXach6DRjOfSjvAd6Mz/iTm60+u5+5PxT2oZFjoEWUS8lloImx+CiRE2vp/ByweyqU4TadmUzU/0f3+7dSu2EkAxRUUihUNI/PP877G+f/hmSmDf9NDeeMhdm1VvRmEupd4717iSlFLLQWN6NqMBjW2I5jUL0eq6ddA7A3/ws0270PRuQYPndA5EyQmhvL0P4tcxRQox99XvfNmQJi/jRevWw8U2YLl4epeT1ahQ9dQ+L3/RXqbFb6DIIyLkmAtreN4Jz4eXBSw98MflqaOAc4SlbMJHeM9M9qbb7mMHPh9KZxbyy6IrzJwuVAG3dlAOsHykjjsEvsO4jDRCm119NbPoERI7I2qs9Z/+EixzwBSRpKYLSmiIE4rKzOiqh2ojf/zWzpiYV7YrF7MkDbJK03Gt6eor5+ECUR5J1AOOjwInQKfn4w
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id u7-20020a056000038700b0033b5730d6aasm2329011wrf.10.2024.02.09.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:55:45 -0800 (PST)
Message-ID: <0ac8d573-6486-458d-afb9-090b5f8d4a21@linaro.org>
Date: Fri, 9 Feb 2024 16:55:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, broonie@kernel.org,
 robh@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <20240208-grating-legwarmer-0a04cfb04d61@spud>
 <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org>
 <20240209-chest-sleet-a119fc3d4243@spud>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240209-chest-sleet-a119fc3d4243@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 16:21, Conor Dooley wrote:
> On Fri, Feb 09, 2024 at 01:56:56PM +0000, Tudor Ambarus wrote:
>>
>> + Geert
>>
>> On 2/8/24 18:24, Conor Dooley wrote:
>>> On Thu, Feb 08, 2024 at 01:50:34PM +0000, Tudor Ambarus wrote:
>>>> There are instances of the same IP that are configured by the integrator
>>>> with different FIFO depths. Introduce the fifo-depth property to allow
>>>> such nodes to specify their FIFO depth.
>>>>
>>>> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
>>>> introduce a single property.
>>>
>>> Some citation attached to this would be nice. "We haven't seen" offers
>>> no detail as to what IPs that allow this sort of configuration of FIFO
>>> size that you have actually checked.
>>>
>>> I went and checked our IP that we use in FPGA fabric, which has a
>>> configurable fifo depth. It only has a single knob for both RX and TX
>>> FIFOs. The Xilinx xps spi core also has configurable FIFOs, but again RX
>>> and TX sizes are tied there. At least that's a sample size of three.
>>>
>>> One of our guys is working on support for the IP I just mentioned and
>>> would be defining a vendor property for this, so
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>
>> Thanks, Conor. I had in mind that SPI has a shift register and it's
>> improbable to have different FIFO depths for RX and TX.
> 
> IDK, but I've learned to expect the unexpectable, especially when it
> comes to the IPs intended for use in FPGAs.
> 
>> At least I don't
>> see how it would work, I guess it will use the minimum depth between the
>> two?
> 
> I'm not really sure how it would work other than that in the general
> case, but some use case specific configuration could work, but I do
> agree that it is
> 
>> I grepped by "fifo" in the spi bindings and I now see that renesas is
>> using dedicated properties for RX and TX, but I think that there too the
>> FIFOs have the same depths. Looking into drivers/spi/spi-sh-msiof.c I
>> see that the of_device_id.data contains 64 bytes FIFOs for RX and TX,
>> regardless of the compatible.
>>
>> Geert, any idea if the FIFO depths can differ for RX and TX in
>> spi-sh-msiof.c?
>>
>> Anyway, even if there are such imbalanced architectures, I guess we can
>> consider them when/if they appear? (add rx/tx-fifo-depth dt properties)
> 
> I think so.
> 
>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>> Override the default TX fifo size.  Unit is words.  Ignored if 0.
>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>> renesas,rx-fifo-size:
>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>> Override the default RX fifo size.  Unit is words.  Ignored if 0.
> 
> These renesas ones seemed interesting at first glance due to these
> comments, but what's missed by grep the is "deprecated" marking on
> these. They seem to have been replaced by soc-specific compatibles.

In the driver the renesas,{rx,tx}-fifo-size properties still have the
highest priority:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/tree/drivers/spi/spi-sh-msiof.c#n1350

Maybe something for Geert, as I see he was the one marking these
properties as deprecated. I guess he forgot to update the driver.

Anyway, I think we shall be fine, even if we don't hear from Geert.

Cheers,
ta

