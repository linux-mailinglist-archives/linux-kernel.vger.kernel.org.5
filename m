Return-Path: <linux-kernel+bounces-76022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A085F209
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F391C21236
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9D1799F;
	Thu, 22 Feb 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnRwR1ol"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1F17BB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587930; cv=none; b=PcJUqi4TIHU3olTwtUfgZZoBfHgenyKIxIA5jiv6mwkC41MzogZ3boTU9n1q6tVFl81kdSb01ZxycuYTUjMVN+nyTIGvZnFJD/AHe/J2Tr8UkiZS2SvzrHxB5vxRciArwkRZRt+nHrUjxYmB8Pli73gvMMFspqy/akP2K7YPKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587930; c=relaxed/simple;
	bh=l/IxJaf6axaZ8FVwz2ZxTwzuFtamRHPtqYYDgO0NVNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyive7z/9S1ITjz82mCtLEjTe5gJtfeZVtnnfYuDBXyfB91TuIjb67XNWHDqsIhpbSPey000k4X1aF8Yo4iyIWjgB+hlB/U3s5lVVSab+ikEMvPErfF9HziFc4EwsFngFWrr2VnFwzDpjirIIQmwnhYvBsKTRaQ99cN3x9MnAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnRwR1ol; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so1045354a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708587927; x=1709192727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mG6Y8+7RSXjF1YaOJSoZA9NONPBkQg/FIATIqJdfjJ4=;
        b=YnRwR1olqB2ye9gqb5IHP0z7TK/8QBH41WDU0eHLhaRhlS0Xdu8TbZrsJS1kcE8U7h
         YKELw6mcJGk8y3yqk/PNrU3yKt1xMXRqMqR4rUjS43bZQKkrklCjwjdoOr1L2AzHWk+/
         Ry/rteWdq0MeaqINFJ71w+jDc5hEWcN116lT8a7BJhMDPKEY3dqlCVEKqCRCBFf1INv+
         dOPNc2H4dvXI/4jDmJVivT18NwDUwjduN26Ys1mtFftXgZaRC0DcUc7+QeXsyeZu+0zd
         +lbqQUCj34p+ESdgXjGzVdqv8lUeKmGe56yp6+cm27aq0xOs5h2idubYAhxUihLOvZdW
         Sr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708587927; x=1709192727;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG6Y8+7RSXjF1YaOJSoZA9NONPBkQg/FIATIqJdfjJ4=;
        b=DU3+Z+n9HN/wjPpo4gGuITw+LAsuyL91TDgGXr/MOyxz9+dfATs18Q0yKHn/TwviMR
         BsFUTP4SgadFfNLx3Z0KfvgCxBc1I6Pf9UKXOPqaCqzYJ48armVXp2KyoqPUKq+pKHfX
         69VgXbwmFW5+KQ8GOOAdvNGzJO/eiV+7J3CD8+XLocwQl2IpwroN/YNPc8AJsdCwlbpP
         4Jx1ExYd/Jl+0vxsKkXccM2SzTuGCUyOc0iTx9pSoHrRLI+3gGsOtC0ngxUps4rRBGX6
         lYe3M7ErXnBNkN4tyDLe9btnvnC3QEG/QWTEc2QFIOs8Shpzne3qL4k5wivldwuE0N61
         HPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyk2Sp5waDAdw6XipFVwVLp/lGk4aXTbFWhb8K2+idTdJ/gzs72PBZqA+KVG/QnNw4b0ASYomrZ/rWL8/x+bqm2oLXsf3Sw74M8R3r
X-Gm-Message-State: AOJu0YyDJVCXagwfUYrK/3ef76BJyhHQOf00I1RPbNkUFRtzYLeRYA2y
	o6t6LVUDbJt9YOC1diJMK/6cN3NnwHk+AS1NWsNnZfaw5DPvEJoYYaS8VkbkfdY=
X-Google-Smtp-Source: AGHT+IFp3KlRLOquDS1qON7clUS013o+eb1EjJhials6/XFA+NM4rtzRhmwqRusKggKPATo3V+cTpQ==
X-Received: by 2002:aa7:ca53:0:b0:565:cf:2566 with SMTP id j19-20020aa7ca53000000b0056500cf2566mr1514539edt.12.1708587927070;
        Wed, 21 Feb 2024 23:45:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h10-20020a0564020e0a00b005641bab8db3sm5128141edh.86.2024.02.21.23.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 23:45:26 -0800 (PST)
Message-ID: <5f1ae281-7b81-49a6-82a6-37be20ea43e3@linaro.org>
Date: Thu, 22 Feb 2024 08:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] clk: samsung: Add CPU clocks for Exynos850
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
 <29090d97-9118-4765-a4fd-3bbe271a39bd@linaro.org>
 <CAPLW+4kmoCoqO=+zXbVw7VsGc-VB2At91ZnJfyTDRtVFmN4aiQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPLW+4kmoCoqO=+zXbVw7VsGc-VB2At91ZnJfyTDRtVFmN4aiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 00:07, Sam Protsenko wrote:
> On Tue, Feb 20, 2024 at 5:07 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/02/2024 23:32, Sam Protsenko wrote:
>>> The series implements CPU clock support for Exynos850, adds CPU CMUs to
>>> the clock driver and enables those in dts. This is the first step
>>> towards cpufreq implementation.
>>>
>>> The breakup by patch:
>>>
>>>   * Patch 01: Add bindings
>>>   * Patches 02..12: Prepare clk-cpu.c for Exynos850 support
>>>   * Patch 13: Add Exynos850 support
>>>   * Patch 14: Init PLLs to be in manual mode
>>>   * Patch 15: Add CPU CMUs in Exynos850 clock driver
>>>   * Patch 16: Add CPU CMUs and clocks in Exynos850 dtsi
>>
>> This crossed the threshold for a patch bomb, which is in general fine
>> for me, but then please put v2 changelog in each patch's changelog. If
>> the patch did not change, annotate it as well. It's not possible to keep
>> jumping between cover letter and individual patches.
>>
> 
> The above list is not a change log, I just tried to show that patches
> 02..12 are cleanups. I'll reword this in v2 to make it less confusing.
> And as usual I'll keep the changelog for each patch separately. Thanks
> for the review!

I know. I just wanted to clarify my expectations for v2.

Best regards,
Krzysztof


