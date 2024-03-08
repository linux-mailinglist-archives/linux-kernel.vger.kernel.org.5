Return-Path: <linux-kernel+bounces-96892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B08762A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23CE282D22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3D5E06E;
	Fri,  8 Mar 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M54ZAGHC"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB45E065
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895575; cv=none; b=YNQ/Pw1uCCzAAkAlXJEGbe/HYQvfwSVAfTrOR13B/KNG9eSaAOlq4A2T1B367CtU8RCYKyIcy+BS9sc7xY7Q7/FcjbRmY6EBVUcow/9+MhfHNuUK78kKGb28qzGcpJQEOEqY+4Trj94GVwWsIp67wBiyh82JTG30We65NMbLx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895575; c=relaxed/simple;
	bh=gemIrESpguSYN6OepWccmGb17BJE1nCs+Iub7NEFhbc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C3XZV58XcSHIY72m7PlWMlPeqA9hcxemRrPIvDQZGMcl2NAqgkfqIswcIdktXGlBqpIBObT3cXZisbixr3rrqs+8dvUie3RA7IZ+cee/vuSImWIoalxmnwo/AxKRGHSRfcbvxqMNL2Cta2ZH7hSn4khYLWuvmTNQ1j7TaDQs2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M54ZAGHC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1176437f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709895572; x=1710500372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPNyNWRZu1nwETUpCWarY8zMeCye3qN0o1wbR3I/W7Y=;
        b=M54ZAGHCTytt6+aonD6RL4Zu/GKuOKRvbOMEUcnUYi2QmVbKVp/ASFkcL9W27b67FI
         GRp0nzlaLmfTu5FUQu6LTOoSmS0ds4v7+tsFTO93YUzKm21q/1Ov8CELsjc9OUkC1EHB
         HQz4L5doJGiUWvgUC03D8NJi+d3eeFL2eFxS/axLi6X1/+Q43THRuZwXtz+j29yNFb3s
         0ME0KQoAJBG+Odj8ilL97RUxec4S+RN6CXF6vwczjLnaGHoNOR9cDCR3bL4Z8l9Du3a5
         pAruBzf/T+aJLiYXNqzDHJ2GXeJ0c9gltvki72dkqyZXqLs6LV3VPvcD/ObEwMzXkJ4a
         uRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895572; x=1710500372;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPNyNWRZu1nwETUpCWarY8zMeCye3qN0o1wbR3I/W7Y=;
        b=Qy0zVRFB4tuXnK+EH4Hv1RD8XWv3jD2EyV8D6cgNd42rKUtPSU7UDqPmvzY4Gi2NPO
         F1SBM7LkPB5y286aU9ylDG7YEIsWwnvq+nOUS++6gBTIGkp7V9+BcZzJDKsKI47tVX1f
         3J7ajr7Fce/QaIlVbwekHAt5i8rjysaHqf8BOqAalZbtssr+rYkGW8CEt1XVmwaDAoW1
         ONZoYfJqJXeDx5VcrKRIC9qmqFJ+6SRjkwctdRra7QfqgLvVvNMO22MYWhiIlG5rpL5H
         qaVzW4ZmtbwwBT9Veg4waY9cYIAY745kwLzdElfNOhOBFZU3yZcHnN+AoGR5l+rKhU2m
         6hPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmeI7ZBlCHNEf0DgIS0rx0bJcQXRg5g79h8EqjS9eORPlkHJ1aetr62SaAtxzmbUvU3AjQQ/fiB1drhOqZJNdOepTKEfohj4r6km1b
X-Gm-Message-State: AOJu0Yx5qzQVV9Ke/kV3eEE482J0/sCJ89aUwlOOZluV0KOA5pyAfmPb
	06qz6h+B7DU43iqBxQsSz+bCF3pij1oC1YIV9HN5SDWpqsazeF1piXG9ePzoDmA=
X-Google-Smtp-Source: AGHT+IHZeGISz5BBijJBfDZAHNoLpL5CAxwaU/Dl6mZ/DmniaLPju1ROj/aubPlQlzA2BTZg6QiD8w==
X-Received: by 2002:a5d:5010:0:b0:33e:6612:dfaf with SMTP id e16-20020a5d5010000000b0033e6612dfafmr3687501wrt.1.1709895571857;
        Fri, 08 Mar 2024 02:59:31 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e22341942sm20086822wrb.78.2024.03.08.02.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:59:31 -0800 (PST)
Message-ID: <35a7ad40-aaf4-476e-8582-b83bac284881@linaro.org>
Date: Fri, 8 Mar 2024 10:59:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for
 SM8150
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
 <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
 <83fd1995-a06e-b76a-d91b-de1c1a6ab0ea@quicinc.com>
 <4817a5b0-5407-4437-b94a-fc8a1bfcd25d@linaro.org>
 <e2627a99-307f-1e10-abfd-ce688cc2ec03@quicinc.com>
 <d893e8f8-66a7-4460-9468-0f3a359cece7@linaro.org>
In-Reply-To: <d893e8f8-66a7-4460-9468-0f3a359cece7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 10:58, Bryan O'Donoghue wrote:
> On 08/03/2024 10:46, Satya Priya Kakitapalli (Temp) wrote:
>>>
>>> Not if you mark it critical
>>>
>>
>> Marking the clock as critical keeps the associated power domain 
>> always-on which impacts power. For this reason we are not using 
>> CLK_IS_CRITICAL and instead making them always on from probe.
> 
> How does the clock do anything _useful_ if the power-domain gets 
> switched off ?
> 
> ---
> bod

i.e. the clock can't be running "always-on" if it has no power..

---
bod

