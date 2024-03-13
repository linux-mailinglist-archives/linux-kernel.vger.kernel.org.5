Return-Path: <linux-kernel+bounces-102379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970AE87B167
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82AA1C297FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004764A9F;
	Wed, 13 Mar 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNSWUOYi"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912564CC9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355437; cv=none; b=uI5KbVtnxquCBVXJoG1GFAm2L6se/jBlVecUQciyX+6RPWePbXD4qBw+94gIIXcpCATgF3bvI/OH8GDjGLI55SJiQl4+uV0jbwqm3byJquqSj4nTLyvfNUAaOMJz3tAQolxNvmAnqloS7w+gM8ial26ECq6MHl/xSiXLa4xHUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355437; c=relaxed/simple;
	bh=z9AlYfbAmUtA6z5P5Kohp0YliNTO6BPzS029YOmLjwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR2ZOFq5S2Rsq0+p+PECf2WXX0FDWMfBd+zOS6vDVr74UEyVL/RL1KneIzbhU4zw1NTa743Qpf9igIzXB7OgapnoApGH90FnANC0HMay5GTFuSw+RRZtXLSx6gvuZ0xEkv4ihLa2HUkJMPWY2bVTq3VE1nwQjywJ51vWKvvcyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNSWUOYi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d29111272eso1870361fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710355433; x=1710960233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpGKrpN5paH3ViTi6yUI1nlMAIqOAlZcyfrMBQ8cqQs=;
        b=jNSWUOYivQSjL5jGWQoeEkMVBVv5qpvJ4s31Gog0wU01TvaoRgbh909UvL2LxxVLJH
         e6kds7jnZpR/NMkskBHMAgYVl4244OU1F1QtCW9qT5VtU6DkKMjSVofxOiAe5XKxsdUy
         Jw9pikBT/WwzrQDVcFIf8djIgcsAuE/A5kL0IehAeu1xR9tWGxtOibrwdpmUMw9HtKJO
         GsJuT+KjuB+JiH6WrcoO2eJS8O5ovxt0estmAbo/sFXCtDGCKi9lWrP+FfKBiSz0yMpD
         /yeDwaES3sAYcIQSo0TVzMN0c4Q68GhPAzC7Ua+bZHg7O+ntI+dcLv5rAxMJ2R9fj3yo
         1c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355433; x=1710960233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpGKrpN5paH3ViTi6yUI1nlMAIqOAlZcyfrMBQ8cqQs=;
        b=uXt4fzmobKiK859bM/bMpJ1MNPugxxV9A/wrb4VihMQcUGCjayQOkHzaGxYQqS9lQd
         dkccSZV6TahMaiKOKHnyhOA/THp7mU6n4qfJEPZKI/g+w0Q854UU5COSupfMY7Rr4yfi
         jQVkRZfCkR8201ElFVKD46WVXfPduvpKBdoF4ipcWk4M8xZE/LVkodj0O6Avv3Rkl7Od
         vh8ooi8piJkvRcnyf0lBFZ8F53y1OxVfnVdYdgb1TYLC4E5FkU7EEOmky3tEd3hQuf1b
         bCWSLPzZLD25e0DyGavgOZvwnQ+GPNwMDm/nXFY2kxqGXsUOCM6UTHvSLOczNlKCpcL/
         TjmA==
X-Forwarded-Encrypted: i=1; AJvYcCUPju7pr2rP10MCmVvnb3eLUnH/gi79ReQo7tqlgDqD1XtcwOriXsB/kavccH68dp9MI8r4UhsdVP8rMEeizcCNy/yl1UdTXnl0BqwS
X-Gm-Message-State: AOJu0YwJ/RZOVTW/jL9HTWo7asgqHLeYAPk8S4dTOpwbdVj/BIn+fRnQ
	CxGP21rzk41+Hl9qQbtbCWpLzup50ebQt8NVCQQiQEfyMK4q9TVoki9I5SDCOPo=
X-Google-Smtp-Source: AGHT+IEjdyu8wvpt1+RBb/cx7XBcMP8DSSyvktu5V/JuiiC+a4yb2xeKQIditk40t5UATUlsuggVcw==
X-Received: by 2002:a2e:9612:0:b0:2d4:4bec:3c1b with SMTP id v18-20020a2e9612000000b002d44bec3c1bmr3850662ljh.32.1710355433457;
        Wed, 13 Mar 2024 11:43:53 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9603000000b002d21f1f1e82sm2210621ljh.3.2024.03.13.11.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 11:43:53 -0700 (PDT)
Message-ID: <f44840f4-d114-4b19-9948-209e6c9feb7f@linaro.org>
Date: Wed, 13 Mar 2024 19:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: clk-alpha-pll: Add support for Regera PLL
 ops
Content-Language: en-US
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-2-8c28c6c87990@quicinc.com>
 <630bb10a-2197-4573-a6d5-01fa6650c315@linaro.org>
 <1e353c1a-e267-14d0-fdf4-36aea9062ed3@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1e353c1a-e267-14d0-fdf4-36aea9062ed3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/24 09:26, Satya Priya Kakitapalli (Temp) wrote:
> 
> On 3/2/2024 5:26 AM, Konrad Dybcio wrote:
>> On 29.02.2024 06:38, Satya Priya Kakitapalli wrote:
>>> From: Taniya Das <quic_tdas@quicinc.com>
>>>
>>> Regera PLL ops are required to control the Regera PLL from clock
>>> controller drivers, thus add support for the same.
>>>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>> ---
>> [...]
>>
>>
>>> +static int clk_regera_pll_enable(struct clk_hw *hw)
>> This function is 1:1 clk_zonda_pll_enable() logic-wise, except for
>> the `if (val & ZONDA_STAY_IN_CFA)` part. Would it be an issue on
>> Regera?
> 
> 
> Yes, that is only applicable for Zonda PLL, hence we cannot re-use the same code for Regera.
> 
> 
>>> +static void clk_regera_pll_disable(struct clk_hw *hw)
>> This again is clk_zonda_pll_disable(), except the very last value written
>> to PLL_OPMODE is different. Could you commonize them?
>>
> 
> This difference is there between Zonda and regera PLLs as per the HW recommendation, hence we cannot re-use this.

Yes you can, just make the function accept an argument and consume it,
where things differ, so that we won't duplicate the same 80 or so lines
for no reason

Konrad

