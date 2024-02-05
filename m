Return-Path: <linux-kernel+bounces-52429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49B8497FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2154C281DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157F175A1;
	Mon,  5 Feb 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZSEurCt"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A5C17591
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129890; cv=none; b=DV5JaW9M7goG7ytjwNhWvluLb0ED6JPBxTN2B7fVH86/iOvbTsqx3zafJIu9GMs5LWnjkoWk5lBr1J87IYUOFNfTJVJWz1e+4xLK4VDwc1eLjCzg2a4qA5Ae7lvyM7unBx/AXTg5lwbJbXGWDoNAiH5zK7rLoO3chHSiRCcoTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129890; c=relaxed/simple;
	bh=JQN7jYO/E6WmrFyOHcexlnUccGULLAbSEGn7DddIlKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S57sdH3iEcTNg+tEfGFWmNV3eskAkWolboKJ8xigVWUAf0jHg8y0LQfFdE1hriYBLAdJu66h25qjy6skuk02Fl9mCdK0xvSghaETmyTpXRN/G+cUqn1rBu9e31j1o4XuxOaPyS+P14c5PlrsEUtKGYHAA3UfBge4oSeZMVxk7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZSEurCt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so590369566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707129887; x=1707734687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FbyOPtHEY7B83zSwLI9qEcEOzPTzUr8lFmP37WKRLEg=;
        b=ZZSEurCtLh0qsetB7/A/tQp8tNRqEUG/oIvi35yBQ2f7/XPizjAmkenxb1JLXhn/SV
         bNEoC7wMeEcaoCj0qIiGDtEUlVfwlv+fwmoWE5MyoyKTAiOo9HLtBXoeZYmsQKxGu2fK
         Z45m5xd5X24xvJeSBMnsEFGDbz2JB4n9wOW//k4Zck7rhOjvVFQ4P+atiUenjloosiLt
         /aW4tPkvB/wLtIbzym4gwEMy9V2e2HyCHF/QIyHOTgf+Q+dlG2Lc4j760IRpM1FUZY+z
         7XX9dYzMgmsJbmowLwl9wuZTCv5WefRN2+dvI2eNeso158vdrH7fRVVYwkKbuG3fbOfh
         IEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707129887; x=1707734687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbyOPtHEY7B83zSwLI9qEcEOzPTzUr8lFmP37WKRLEg=;
        b=ZrpXgw+F1BNgOp7Tz9RpNZ20qiXU/s4vz3Cznr7oUrKzv8c8Tot7MSbYFQHbAtHnol
         J00eAo5nquDgkjFB9R5oWmPRvtWb4n2zrFGuVv+DRR3Wyh5aFlDmynT86yranb2vO3D9
         XIOg9H9LqRtOYagu3M4VcGe3REFsUz88+8DE3Q1x3PAqUIozmnFBcbao+DhOJ88WSVIR
         xcLni0BxNBGA3+6HTqzUEzn29aTsPvlJkyUajiKWOmWSNSWkiN19RmethlvKwT2vN0F8
         kG2Df4WvcC0EsyHU4ZDadABsX7sTmWSXIQdwpjvScWOEckuHc9wVogrPD56pD0YECveF
         SgEQ==
X-Gm-Message-State: AOJu0YwieaElv+bad4bj+wltNCs87bUZ+RK2e4DEelIz3GaB+8hWb1BY
	mFtnZN2/CL/qfYf93stBUFkuPldZpLEDUKi3zHlnKr0XVTU1kmLY9OK+Pqo7YGs=
X-Google-Smtp-Source: AGHT+IHv3bGmUah9HPCiE3v/Bw116+m4sSE0wUcyB4WylBRIhlp+tXIPPJTDaySdLu6hJ2KTGFVtzQ==
X-Received: by 2002:a17:906:30c3:b0:a37:7fd:9a1e with SMTP id b3-20020a17090630c300b00a3707fd9a1emr6221850ejb.1.1707129886917;
        Mon, 05 Feb 2024 02:44:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJrjuEU31pDEt1WkfrLIqJx3LPAtA1C2I3rG5G/SYV4Quzr7OJjdgzjzA1ecqoW6RScPSNaPFZ9E4Yl3QBUn1o7g3l1gPSM6u8ATx9vEvfaeYAiygzQc94yHmIRrkFPWfuiYglLLhtt6l/yeg7UJsQorMR2QL+uNXHkYlHMSfJSxDf/V0kLxtOKmAy5+9NWFKVdQu3sHUt2kfG43a7HC1jQ7NnwS+/WDKRDgwSfkw5kn6+7dkW5aUQM0zmitmJ2HroQ4enFMFu10s+ZUxQc2I9s9KCTT022KS5SoHtqeJjnasobrkW8j6znGll9VALYd5hzfkctcSb0vGxW+ZR2K4d+5bwaWHWDC6iODpCx6OdhqYW35vvtGbk/BC7aiHg
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu9-20020a170906ba8900b00a37116e2885sm3819603ejd.84.2024.02.05.02.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 02:44:46 -0800 (PST)
Message-ID: <e4288ce2-a8a3-42e0-9f01-765ac7cd1521@linaro.org>
Date: Mon, 5 Feb 2024 11:44:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
To: Tengfei Fan <quic_tengfan@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
 <CAA8EJprpMjK03rKPK6wgfVuDvBikYsKZjMc0Wusa1BxFOBnXhQ@mail.gmail.com>
 <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 11:20, Tengfei Fan wrote:
> 
> 
> On 2/5/2024 12:29 AM, Dmitry Baryshkov wrote:
>> On Fri, 19 Jan 2024 at 11:07, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>
>>> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
>>> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
>>> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
>>> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
>>> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
>>> AIM300 Series is a highly optimized family of modules designed to
>>> support AIoT applications. The module is mounted onto Qualcomm AIoT
>>> carrier board to support verification, evaluation and development. It
>>> integrates QCS8550 SoC, UFS and PMIC chip etc.
>>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 1a5fb889a444..9cee874a8eae 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -49,8 +49,10 @@ description: |
>>>           msm8996
>>>           msm8998
>>>           qcs404
>>> +        qcs8550
>>>           qcm2290
>>>           qcm6490
>>> +        qcm8550
>>
>> Drop
> 
> we want to introduce qcm8550 here.
> 
> qcm8550.dtsi has been introduced and qcs8550-aim300.dtsi include 
> qcm8550.dtsi directly.
> 
> qcs8550 is a QCS version for qcm8550. qcs8550 is a sub-series of 
> qcm8550. qcm8550 will be a firmware release series from qualcomm.
> 
> here is the qcm8550/qcs8550 detailed spec: 
> https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
> 
> here is the sm8550 detailed spec: 
> https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_C_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf

That's 8 gen 3, so SM8650, not SM8550.


Best regards,
Krzysztof


