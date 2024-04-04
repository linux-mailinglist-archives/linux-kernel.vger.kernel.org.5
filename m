Return-Path: <linux-kernel+bounces-130971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF7898157
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CF72814F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B94AEE5;
	Thu,  4 Apr 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBRpsB9L"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17E48CD4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211521; cv=none; b=i6/hMcp7LQKn40kEV03iE5D+jiuFSKOW73Cn9hbM8D9+kI6VeOyw+pHL2ALt+tGqLkpBbiLvOTVVfuLGb6zEsveiKewAP1Ev5Tp1SLvLNn3+c3KUntNnGSiwN08RtSavufy2O3+ICu14+qUKhnxE3kB0Bw6rSpOfT9618+5CoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211521; c=relaxed/simple;
	bh=2J7Re/HyvlV+/ExJlexrUrhdCVIk2oInihJetZ94u+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRTMpSakgpZaz6eQJrl+13cl4jiKvv3/9/haZVv1cdEuEJgvkKTAWqseCQx8Y39ym9U3i67Vrk2mMtrTbuWC8W+upPNRPGtSTCrD1U4mu7/BzQoDwGJdj7lYTog0IY4f52cBbbkNH6Ii4rlr/mFlYUY7ATaZBIF9qu41DULFtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBRpsB9L; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56df87057bbso352349a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712211518; x=1712816318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0qKZ+iYWQHqYn9Rd3HRahOpCkdY1YAxGTET1Vitiv1k=;
        b=uBRpsB9L9MfvKOfuSaSdGho9/DM4FZGlLw281grWQiwYWQd/ifuAgOXf45B9XTo5Xu
         w7zd5VqzWZxsO80KA0VmaXqQA9NYKGyiwtp3hy2l3WCP0vrsIbdKVkkLDGu+WyQagF/n
         V/H/tnLMmHvp/EAo6oCKxLK6+YDSjaDvgnkvzZPR4nxz2J62y0wVycDU11f6E3IeEIs+
         bJLkQjpEA1H9n9EC6QJt/9ToKLY9nXEhnyfwIeq2WQ9uAHw+6u/tD5+jmcwoCnwSGg0S
         RGGLmGKEAa+UVNqo+U19MiygWChq1EDiGsrQ5HokZEQakMoJwk/olHeu08f/DwbjF+nn
         fCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712211518; x=1712816318;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qKZ+iYWQHqYn9Rd3HRahOpCkdY1YAxGTET1Vitiv1k=;
        b=EGTu4q3RD01jWAR8FU9CpIM4AKZlEmHctbIAk1Bl6sdwOY6c8S2rldAPePJj3y8i7N
         SWcoiQLWfS9zo0Vldug8t+iA7wAuD/cakfcfo1WfyGNV4XHv1xwyOByiVvrq41nG62sj
         miulp9tYEJPmX1A1hAynwszPKOpGO5yogJ85e3kA7jTWJ7/yhDRDptvyYdjb/veLrLHL
         2GEBFa84oTPXlKVclFQkoaE5yO9dA0EVLcJ7pD1IFrgH/MEf8//enC828QHNsxMNk9Jz
         fhedoRut9OaTRimsdeaBnXLfsULql+fTL1KM3QCjKZpLHnz8Oats/x/8LDKZonvz0bEJ
         Q4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXUmzoFjmS8omZ4oN82WqTekpwbRueIaBQ0XU7CRyjxqrNNjM4Bc7F3POwEnwtnp/1/nu9/mu08RzDrGbom6BvZNY9Bjs+nXLrGgZOb
X-Gm-Message-State: AOJu0Yz7/FXOAmcKh07dR48R8XxG4KH9yR63qJZE8OsC5J4Z94nyyvHM
	/hMOSDKPyiiP1EPIESVOqFxRV5TELl9WOio7a7nHgmnpwTPVtfbDR0U4+FBVr3c=
X-Google-Smtp-Source: AGHT+IE//YeUlWWl3VoukJKYZwvGoO7B7ADUvRMkhV4WjlUseoXIiGv4d/HSDyWXfteAYqN8TIYTlA==
X-Received: by 2002:a50:9e46:0:b0:56d:fc9e:5143 with SMTP id z64-20020a509e46000000b0056dfc9e5143mr916358ede.14.1712211518504;
        Wed, 03 Apr 2024 23:18:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0056a033fa007sm8745811edb.64.2024.04.03.23.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:18:37 -0700 (PDT)
Message-ID: <8e5fb9c0-fa7a-4691-a9f4-f2b42b66d1e5@linaro.org>
Date: Thu, 4 Apr 2024 08:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
To: mr.nuke.me@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: ansuelsmth@gmail.com, robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-3-mr.nuke.me@gmail.com>
 <bad88189-cf70-4200-9fa3-650ea923b4b8@linaro.org>
 <d35c96ca-24af-fbad-74fe-ad85a433caa2@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d35c96ca-24af-fbad-74fe-ad85a433caa2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 20:05, mr.nuke.me@gmail.com wrote:
> 
> 
> On 4/3/24 02:14, Krzysztof Kozlowski wrote:
>> On 02/04/2024 21:25, Alexandru Gagniuc wrote:
>>> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
>>> The only difference is that the "iface" clock is not required.
>>> Document this difference along with the compatible string.
>>>
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index cf9a6910b542..6eb29547c18e 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -26,6 +26,7 @@ properties:
>>>             - qcom,pcie-ipq8064-v2
>>>             - qcom,pcie-ipq8074
>>>             - qcom,pcie-ipq8074-gen3
>>> +          - qcom,pcie-ipq9574
>>>             - qcom,pcie-msm8996
>>>             - qcom,pcie-qcs404
>>>             - qcom,pcie-sdm845
>>> @@ -383,6 +384,35 @@ allOf:
>>>               - const: axi_s # AXI Slave clock
>>>               - const: axi_bridge # AXI bridge clock
>>>               - const: rchng
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,pcie-ipq9574
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 4
>>> +          maxItems: 4
>>> +        clock-names:
>>> +          items:
>>> +            - const: axi_m # AXI Master clock
>>> +            - const: axi_s # AXI Slave clock
>>> +            - const: axi_bridge # AXI bridge clock
>>> +            - const: rchng
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,pcie-ipq6018
>>> +              - qcom,pcie-ipq8074-gen3
>>> +              - qcom,pcie-ipq9574
>>> +    then:
>>
>> Do not introduce inconsistent style. All if:then: define both clocks and
>> resets, right? And after your patch not anymore?
>>
> I kept the resets in one place because they are the same cross the ipq* 
> variants.
> 
> Do I understand correctly that you wish me to split up the resets as well?
> 
>      if ipq8074 ipq6018
>          clocks
>          resets
> 
>      if ipq9754
>          clocks
>          resets

Yes, keep it consistent with all other cases.

Best regards,
Krzysztof


