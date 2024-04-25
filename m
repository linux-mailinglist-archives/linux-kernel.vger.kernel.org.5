Return-Path: <linux-kernel+bounces-158608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEC8B22E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C471C208C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDD149C71;
	Thu, 25 Apr 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBj3zpHJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89103717F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051963; cv=none; b=KABfx/axGf178rCUjk0cfuwfN5HsTMKwGK2PbUo3EmAR3kRlfZhyDCegEuOrBSfA9nfzU23UwmZ5M5oU6Ir8J2kYW/l0Q5uIWM7DJXF9YEgvhJlKJkQtn1lzo9WJcHZtk5zv9dTqqEjHd4mZvXTG40I+4tYCpXGwao7QHdpHV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051963; c=relaxed/simple;
	bh=MMomP/8dwSAVkZZmBgm8ZvgmVuByPf1jQVvMWguKpjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U12eLvi7e+80/4N2ZeFu1AfdnYnxmy46shCBG0WZAFuIXjDTdzGX1rjE/ee4eYHShOlOfCLitghcEoZwr1rC4epBWWoNNAHaAhdghjtZ1kF/X9vVfxmoZvj3QMyT+IJ+V7fA+8cBepRCUtM/BagrUySQGeQQKWDnMTEr70RNf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YBj3zpHJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ced2f94cso226408e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714051960; x=1714656760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSmqypjIS92fFBtdrRSjnycqWl4CLQIjWTtXUnhGY5g=;
        b=YBj3zpHJ6GNgV1MLHMMHWN+2uvNQIJkaFSj24Kj39cgVtRji5fbNj9+zyPj0vgEUWa
         Orza/9xtzFi1Hjc37js7P75xQYEXrUTP11ejGLLvZgMoZDbHd4x9LN7Yh3GBZjNhdaaf
         D/j9+ED4sQK9lS7u6fevupv2znzLhyZfB+YjQ7oKroFp4ywxydbzqIT9z5Wt7A3wJvjX
         qTUiqFXon6wKmMVevmQakRRH8J3NiRJ2hMZU9bma9jeJkXDGF3jmM30n4QOK6DrtQPQG
         jeTVD8Q9ELitj+PcS7Hb0P8KYQWveoE9sVleS0iSzgfDGz/dUQ4uzgjo7FsEz1XrSlaa
         eJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051960; x=1714656760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSmqypjIS92fFBtdrRSjnycqWl4CLQIjWTtXUnhGY5g=;
        b=ToLvj3RRgOMR0lBGP2Nv9RhQU4YioT0ZY0J3xIm6f3QzgKUnCmJYiKBO+zFjFN5/TJ
         x2vGnpj04CvIKx22a0xt015Sqj+oGqEeil/TmdIxTteVWCW48abDfsrn9iLtfJ1O1PA5
         jLekO/CIeqpSYFzSndctSeo3XnX2Wi22psYvzlvmH3XTpnzL6W7jBYxUvyd+WvPamHpj
         XIu1rTgD6si8QCjNtlVcnkOfDPem02jAZ4g2cLmkC1Z6ktJv22fDK/fyCI+i2iZkE0rp
         k3pXeOCwxttOXXvOgKn4/pQdKu+JNeewWuR6dy6Dd1sZZd3SReyRhvgp/81mNd/UFlb1
         hXiw==
X-Forwarded-Encrypted: i=1; AJvYcCUrv7/LZY48KQ0UlBP6WmsnGRO3bY1A/mOTl4OpUwFq4lyU2xzWfTXWejbMU/2fMz+LLIBvLa7B9f9og1Y+w6XR/GaGMEXHHxZbAZ/v
X-Gm-Message-State: AOJu0Yzw2AZL9iW75MDQtEQ0dJWTEAyJY8R4yarhSgFYuEJ1TtoRaIiQ
	coV5pSZaNPj2V1Q7twvdvnqUjU/DhuGXI45VO6TCsMFKyOeVb88CmtLQ3YtCspA=
X-Google-Smtp-Source: AGHT+IESWXmXNjDEZEiQeuKXC4gKNDBYg3AhPm/2TqyqsQYsczc5eWsRrAiQSvYsv18t5BVv2SxY6Q==
X-Received: by 2002:a2e:9855:0:b0:2de:1218:af30 with SMTP id e21-20020a2e9855000000b002de1218af30mr3711383ljj.1.1714051960077;
        Thu, 25 Apr 2024 06:32:40 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id x22-20020a2e7c16000000b002d9e3a525bfsm2362152ljc.41.2024.04.25.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 06:32:39 -0700 (PDT)
Message-ID: <d160289a-d0c7-498e-88b2-89861ab9fa50@linaro.org>
Date: Thu, 25 Apr 2024 16:32:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video
 clock controller
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-2-quic_jkona@quicinc.com>
 <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
 <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
 <c3ea22ed-5750-438f-89d5-e56f908ba835@linaro.org>
 <73c5ffca-9275-437c-a49e-ef3251c8d313@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <73c5ffca-9275-437c-a49e-ef3251c8d313@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jagadeesh,

On 4/22/24 14:00, Jagadeesh Kona wrote:
> 
> On 4/19/2024 2:31 AM, Vladimir Zapolskiy wrote:
>> Hello Jagadeesh,
>>
>> On 3/25/24 08:07, Jagadeesh Kona wrote:
>>>
>>>
>>> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
>>>> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> wrote:
>>>>>
>>>>> Extend device tree bindings of SM8450 videocc to add support
>>>>> for SM8650 videocc. While it at, fix the incorrect header
>>>>> include in sm8450 videocc yaml documentation.
>>>>>
>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>>     .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
>>>>>     include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8
>>>>> +++++++-
>>>>>     2 files changed, 10 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>> b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>> index bad8f019a8d3..79f55620eb70 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>>>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on
>>>>> SM8450
>>>>>
>>>>>     maintainers:
>>>>>       - Taniya Das <quic_tdas@quicinc.com>
>>>>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>
>>>>>     description: |
>>>>>       Qualcomm video clock control module provides the clocks, resets
>>>>> and power
>>>>>       domains on SM8450.
>>>>>
>>>>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>>>>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>
>>>> This almost pleads to go to a separate patch. Fixes generally should
>>>> be separated from the rest of the changes.
>>>>
>>>
>>> Thanks Dmitry for your review.
>>>
>>> Sure, will separate this into a separate patch in next series.
>>>
>>>>>
>>>>>     properties:
>>>>>       compatible:
>>>>>         enum:
>>>>>           - qcom,sm8450-videocc
>>>>>           - qcom,sm8550-videocc
>>>>> +      - qcom,sm8650-videocc
>>>>>
>>>>>       reg:
>>>>>         maxItems: 1
>>>>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>> b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>> index 9d795adfe4eb..ecfebe52e4bb 100644
>>>>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>>>> @@ -1,6 +1,6 @@
>>>>>     /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>     /*
>>>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights
>>>>> reserved.
>>>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All
>>>>> rights reserved.
>>>>>      */
>>>>>
>>>>>     #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>>>>> @@ -19,6 +19,11 @@
>>>>>     #define
>>>>> VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>>>>     #define VIDEO_CC_PLL0                                          10
>>>>>     #define VIDEO_CC_PLL1                                          11
>>>>> +#define
>>>>> VIDEO_CC_MVS0_SHIFT_CLK                                        12
>>>>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>>>>> +#define
>>>>> VIDEO_CC_MVS1_SHIFT_CLK                                        14
>>>>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>>>>> +#define VIDEO_CC_XO_CLK_SRC                                    16
>>>>
>>>> Are these values applicable to sm8450?
>>>>
>>>
>>> No, the shift clocks above are part of SM8650 only. To reuse the
>>> existing SM8550 videocc driver for SM8650 and to register these shift
>>> clocks for SM8650, I added them here.
>>>
>>
>> In such case I'd strongly suggest to add a new qcom,sm8650-videocc.h file,
>> and do #include qcom,sm8450-videocc.h in it, thus the new header will be
>> really a short one.
>>
>> This will add pristine clarity.
>>
> 
> Thanks Vladimir for your suggestion. I believe adding a comment for
> these set of clocks should be sufficient to indicate these clocks are
> applicable only for SM8650, I can add the required comment and post the
> next series. Please let me know if this works?

Well, I didn't get any new information to abandon my suggestion, what is
wrong with it or why is it less preferable?

Even if you add a comment in the header file, it means that for SM8450
platforms you'll begin to define inapplicable/unrelated macro for the
platform, which opens a small risk of the misusage, and which can be
easily avoided. I believe that the clarity is better for maintenance.

--
Best wishes,
Vladimir

