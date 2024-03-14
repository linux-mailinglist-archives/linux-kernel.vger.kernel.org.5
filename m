Return-Path: <linux-kernel+bounces-103100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E487BAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889FF281680
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441B6DCEA;
	Thu, 14 Mar 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnKVCIak"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB76DCE3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410970; cv=none; b=WP1Mx0y3RCMLMBVUhii5b4EJVGgMoI5mGwpSzgmK8eabtZvYwfubnAwtzqbN1DzlM9yYfQoE5xhSmuOdsqusHall31z2oY9TXw1oZJoHF2EgGitq68KZ22LvX7XhcOjJ/KuyL41X1IxBZeNTg5uMShDX8jDz48mY+SVcZ9YryKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410970; c=relaxed/simple;
	bh=MaLnuyy0QVbma0H/5GYP5iigRaszSQE6MJzaZrfY+74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T40g7cM/U1ZEdDxsRGddqvu1xSgRvIZ/eeLADux5mNRAlzSu48inegXWpsrzyDLMD+htbAh8zlPD5ZMSCIm2gQcSIHFUsyl8yv2zwUSGLi7dtEaffcqX17OB0Ik7qG6f/h9KfGPce5rL5OX2DA/hz0rebEJZCEhBCj8Vc8TDz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnKVCIak; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413eede49dbso4564365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710410967; x=1711015767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtdE1O6hl6iAvnjxNMt56KZfrhguRNLx2GpWdQgo1GE=;
        b=QnKVCIak2XKt8KX9u0vMpWH6PwYkgQaMr23or49UhX4rZEHn0L8dfYRB4QSEO5Kjbw
         YyjTXTMX8OhxkVJTKn9tLoDkxmOYV5B2AtbaKz1dqvBv2RotP5fU9fczFe6RzY097w+2
         ZKzg3NaFC9p+cYouxFnMIiNYplDC4Tj2cLzd/GFzj1xu+BHgj2DueDQ/wQgCyom1wIu8
         v5B2dAsNcIwpepJV6+dm73UbQlhLzZKGP4XKLPA8+XAGK7FXI8WcoWyiO1nX03OzU+wC
         sqIeLggfVfFCa6Xete6y3XDrn2u35xMaIaBtk1wl+E1TFCza8obu9xset3r2fXBmP7Vj
         Zlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410967; x=1711015767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtdE1O6hl6iAvnjxNMt56KZfrhguRNLx2GpWdQgo1GE=;
        b=X8VbW9gc/suAcsXV1x9pRzcSivRmudth5AW4ROpfnKrpshTcGU6vjVgLwdtP0RNeXC
         5TwQMABj1Kvb1mt8Sx4CxAZ+SYkFCKRYEHT1v+IYXBbL3jhtyDJ4G5kRtJ6fKD79QEfd
         QGakkCuBVhffESBvUNwcDyBf2S70hRDesgyPnFDPzMTqw7fcPQbDUoMZ8Ej8LnevY8/n
         s4PvVDIq1Dd1I3yOqJN7cWTxYulaMpxAR8ZxtF0ckONqlPbA2ti4sW8RxBhPgO22BJ34
         ibiVR7IsskSx/kcmsqZyrKznh+o/fMRIjM2bIGxObztWSDGekYE042qPPFBlFbWWFx0v
         5+AA==
X-Forwarded-Encrypted: i=1; AJvYcCXVcI4kOoTM6tCaARKqJWyYitlBti04RzyKW33hCXjyhXiz7CePk/qlCBwIdSfG1IwVjoNF4brQThtsQnhoV3VZXv3G6zXjsyNFIuLh
X-Gm-Message-State: AOJu0YyO1JSLa84l3Z1nYnmVjwEC1ZLEcN/QEyMASzfi53JG369Vt2bf
	FR/+ACsE4v65oDSJ3780MRrDP1AnEtlGnh6mAb0zfkSeWPgEs+I0NGpgAdSdR9A=
X-Google-Smtp-Source: AGHT+IG42QU4UgTWjudfl5CoLKEd/CllL6Y/aMBDpyuy4wH3TdY+DWFDJTEY5OUmDkjDPN78KMSQcg==
X-Received: by 2002:a05:600c:4686:b0:412:b42c:8ff1 with SMTP id p6-20020a05600c468600b00412b42c8ff1mr1135911wmo.21.1710410967300;
        Thu, 14 Mar 2024 03:09:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm1921970wmb.46.2024.03.14.03.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:09:26 -0700 (PDT)
Message-ID: <46e90e1f-1c93-4e88-b73c-94c165217d98@linaro.org>
Date: Thu, 14 Mar 2024 11:09:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add three missing
 fastrpc-compute-cb nodes
Content-Language: en-US
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: quic_ekangupt@quicinc.com, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240314063334.31942-1-quic_lxu5@quicinc.com>
 <c7ac2b10-eee3-4269-85e4-a68d24c2337a@linaro.org>
 <88c32ccb-fadd-49e8-a8fc-76f93353d204@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <88c32ccb-fadd-49e8-a8fc-76f93353d204@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2024 11:05, Ling Xu wrote:
> 在 2024/3/14 14:55, Krzysztof Kozlowski 写道:
>> On 14/03/2024 07:33, Ling Xu wrote:
>>> Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.
>>>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 29 ++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> index ba72d8f38420..c238ad1be0d4 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>> @@ -5084,6 +5084,35 @@
>>>  							 <&apps_smmu 0x19c8 0x0>;
>>>  						dma-coherent;
>>>  					};
>>> +
>>> +					/* note: secure cb9 in downstream */
>>> +
>>> +					compute-cb@10 {
>>> +						compatible = "qcom,fastrpc-compute-cb";
>>> +						reg = <12>;
>>> +						iommus = <&apps_smmu 0x196C 0x0000>,
>>> +							 <&apps_smmu 0x0C0C 0x0020>,
>>> +							 <&apps_smmu 0x19CC 0x0000>;
>>
>> Lowercase hex. Please look at the code above, don't copy downstream
>> code. This applies to all your work: don't send us downstream code, but
>> clean it up from all of its problems.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi, sorry, do you mean that I should delete this line: /* note: secure cb9 in downstream */?
> All I sent are upstream codes, I didn't copy cb9 here and I also see this commented line in sm8550.dtsi.

My comment was about the style. If you send "upstream codes", how could
you have there uppercase hex? It is even visible in the diff context
that it should be lowercase!

Best regards,
Krzysztof


