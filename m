Return-Path: <linux-kernel+bounces-145849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678938A5BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23769282CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF2156C53;
	Mon, 15 Apr 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rse/ptI2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64F15697C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210757; cv=none; b=YfBvdD3T9sMXfPDmbHzZwMl2KFTgOaJlOwaW+IAGjg6WBiKRDxbMcjB6zyKp2eF34H9VQyfNvRH7CRjtF6vE+oGSkYinGI3xEMbmMxdU4zsc7bmaGoPh1RA23ebCvot61iWY9VT2tdHWkigToODQgQoxYhmHE/CwNz+j4A3u1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210757; c=relaxed/simple;
	bh=J7nXo825g2LLNHOTbM+8C1BAkdGVZo0J2e5tsXt1TPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZsccr+JMH2Liyy6FdqIrCKf7yRqud4DrXMFXhvIuqOcs7dfTCMYI9aS/yq12SGYCEZFbT/CkWpVzSwCA3kRmTeS7e5k1X/l4U1oVkFi7g+dxZABhCACUWLzqVKjhB4rQgCvR0qYDS+3FIJ58WZ2VkMu6+TJvHLIinXwkCAVyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rse/ptI2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518f8a69f82so1259072e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713210754; x=1713815554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEXHGjxAhZs0bYA15G3//QkZWLtdxl3JXDF1n5TYCXc=;
        b=Rse/ptI2iG5kSiBOBjsvbH+IiHbN8uzilAGB9aGfs/g2t2M1hVa2jm+4AchE+VS24O
         7saRVuIKM4gxiJNhZlhiNVAd/kcwk4/KuYtfpm7ll6sRtLmebQncyA+dCYo90vX5l6J1
         mmqTv2OS0bBRkMWiuBfAd5IxRNwZ7dpICBxrP+0Qse6ChEuhNlu7ceUGl3iTKqMV2LkD
         4EaZnTqX9nkiCT8e64IQkfajcdL858jSsTQSqA6CwQAfZdPv1dw85QRDKaDSj6KHMPTK
         28eJBIzjGUIOTYFD6//Be0VDNpcHYT4AvXHNv+FNacIolEoqzrETrZVfsaFhL4KjxwWX
         7M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210754; x=1713815554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEXHGjxAhZs0bYA15G3//QkZWLtdxl3JXDF1n5TYCXc=;
        b=hxNdFhpj+OtZV6a6D81w4yr8KxH3/EW93jQObXHQ/7ymzBTq0371FraZnTNYiq5jcX
         p+cOpKa16jCvrj7k2Vj24mzKXxKh9oEbDHSxClBpu+JgNbQdLaetbHU2uhpDZNCsLplL
         AGedHpqyub91Ht03ZEETDH5tzOiCEeQJkh3IflcgzCZHzxC+0fef8bdiz1seKeLwdbDa
         0f5HXd5lxpPDqop2rVuBSC2FrKgvdentTTeOIMQuG9WDQWbQx4AOtsMIu4bkLL7hs2Nt
         2rfHDlzjQybhDvN8g+ExXc147TFfJ5Fz3+xFiBlAULySP8MBfb44MLEtUOr/d2jrDTTl
         tQXw==
X-Forwarded-Encrypted: i=1; AJvYcCVTqV9Mly4t2p4hybjggOgTgVkHmtt1J37YyeI845FLCXYN+6Izeyv8yuI08PxyWluS1N7tN6irR2aL/El1oqt6c9PXG1k2FRKI+vs5
X-Gm-Message-State: AOJu0YzET0voffKv4vNiYPN1xb+5JWF+W1FRHBHi6Nz223CwUJg5wLS2
	LPUmwzYuKZ2q6kY0HSMAQwuXE0oyVtZZ9LnfV9tVftYGmKdQqpObQazxTYhzydjsuT4w9stWZ6w
	numQ=
X-Google-Smtp-Source: AGHT+IEal04PxHzEYGFi8jHEhHfii3wvIFaJa5SsgptPYcD/6a7aBein+xl+JbCkDBh8KNrg33Rtug==
X-Received: by 2002:a05:6512:b92:b0:518:872f:e4d with SMTP id b18-20020a0565120b9200b00518872f0e4dmr9145171lfv.15.1713210753936;
        Mon, 15 Apr 2024 12:52:33 -0700 (PDT)
Received: from [172.30.205.18] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j5-20020ac25505000000b00517374e92ecsm1339725lfk.93.2024.04.15.12.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:52:33 -0700 (PDT)
Message-ID: <daf1d116-5bad-46f6-ae6d-a33913f68506@linaro.org>
Date: Mon, 15 Apr 2024 21:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/4] input: pm8xxx-vibrator: add new SPMI vibrator
 support
To: quic_fenglinw@quicinc.com, kernel@quicinc.com,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240412-pm8xxx-vibrator-new-design-v10-0-0ec0ad133866@quicinc.com>
 <20240412-pm8xxx-vibrator-new-design-v10-4-0ec0ad133866@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240412-pm8xxx-vibrator-new-design-v10-4-0ec0ad133866@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 14:36, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add support for a new SPMI vibrator module which is very similar
> to the vibrator module inside PM8916 but has a finer drive voltage
> step and different output voltage range, its drive level control
> is expanded across 2 registers. The vibrator module can be found
> in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

[...]


>   
> +	if (regs->drv2_mask) {
> +		if (on)
> +			val = (vib->level << regs->drv2_shift) & regs->drv2_mask;

The point of regmap_foo_bits is that you no longer need to mask the
value here.

> +		else
> +			val = 0;
> +

You can also save some LoC without compromising on legibility:

if (regs->drv2_mask) {
	val = vib->level << regs->drv2_shift;

	rc = regmap_write_bits(vib->regmap, vib->drv2_addr,
			       regs->drv2_mask, on ? val : 0)
	if (rc < 0)
		return rc;
}

Konrad

