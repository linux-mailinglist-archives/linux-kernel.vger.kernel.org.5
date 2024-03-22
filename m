Return-Path: <linux-kernel+bounces-111288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC99886A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296932822C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744138DFC;
	Fri, 22 Mar 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lg/BHtze"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DF2E822
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103076; cv=none; b=Ps5mL24D4UZwITrYz2OUgqKFBNrSCM1mclt3U0/qJn4i5yHysJVmk03JEg9IOPrqNQwGjiElb4DQPnWWBJPxmYSfp4Xz7g9CR+9AB5fqj5HwZ1jeI3HNjjpAON2I9BJO0ls/vPpRTz7Zx7lnYb7Q+jv6Mgo9M+waZrM11lQZr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103076; c=relaxed/simple;
	bh=LdraHFKkYxsoFAQsnK5xaReIIh1bnT+H6G/1KbOLhyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf2s/259spktJZpDWUsH8vYX36Rl/F/73XFinrtEac2MsW9lt8iQ/XJXKDIR4yYREl3TYdXI6wP4Wkcdz9nDso+9cP2xLc6Eq4zm612uImBY1Xuu1qqKrheGwFJghOBOKWesLe2zIRM4oAE77iVXhLesmKQrXvXtS7baS83arf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lg/BHtze; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d717269fso2514080e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711103071; x=1711707871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbU84KSOwnLxXUjDH60L4m12voWSvWaFGV7NZhED0mY=;
        b=lg/BHtzeA/KHPPcljScts4CsixnZl76gpq9JZj5ZkU7bzJMm48s/26GhY+Pvxjsv9P
         1tnYDHbd61gxMDnNQI6t32TRhzk8CquEZLI2gN1UKMAfqISTcVavL/8Xx7ro88AuXa5e
         TmlThLO2fHWouenruEgoqBR1DIAAYlFwpM55wIWw8DD7YI2xXD1E0Uy9dSslNU82WeFR
         yjEU00t7wecaQ0057KzvvJcawdRbHH6oDtADJxnhBoNrGk6ib7jwuaoZPExJF3+Z+Un8
         DfvESBDX6UjwDtK/0wnb5SNjFl91CyxxH4WxcYBhhaP3d90hSYHsSPTLqVVMfv1KCxtk
         j8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103071; x=1711707871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbU84KSOwnLxXUjDH60L4m12voWSvWaFGV7NZhED0mY=;
        b=qG5fY3qXqP6kapjlQRXBVhh+e87aLt5IWHkuumkaqC8eqIvRZK98AnkKRobDadQCi5
         gperZtrCQAHpCYd/K4j+7Yelfz8aCl6nMyGOuUdRLwj6cIsvmZBcOkTWWRR/oQkJHI1k
         pA+50ybw7sMONnuvqKJtVkCfWMr1q8xxQH2P1t7wt2WMKIUMUbwsAFMIoPpsgPVPOAqc
         Iiap9iJV02GlTClc0hD8YA5Pz59+5bPxu2AyJFYtP0e62ovRyjFTHttvmXu7DG982J1P
         YFhsF2fZJbuHk2d4gB/XRr90VTQRGnkklsy6w1r/912Ztsk0oRKSc8kRRdBzR4oMtlVx
         5Y3w==
X-Forwarded-Encrypted: i=1; AJvYcCVapfgmPBIXCV8tVo9Jjj24zW/I/cchm9wKa+9sBwPvbjE+NGrTjhGrfyavhCRiYuUkefwEFBMz/5q525E/642W/IdQE/vCEg4RCNn0
X-Gm-Message-State: AOJu0YzS7fMiDZN9C6PSAD5YOumk62rq60FCn9ksqNWIHvolAR0b4K7a
	6TLxPLHjUUMKQDYCLPQB0MUxlLP7eg09L/SLD+EhnrJCpvYmNJVnuQoTFdfawzg=
X-Google-Smtp-Source: AGHT+IEIVG8bh+X4Ju2UJR3vnr0XfmzR3ZjVuy71x8WHH0+8JMVoyLDvz2/SChZ+zaLCYvb5BdxISA==
X-Received: by 2002:ac2:44cf:0:b0:513:eba9:46c8 with SMTP id d15-20020ac244cf000000b00513eba946c8mr1213314lfm.35.1711103071691;
        Fri, 22 Mar 2024 03:24:31 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b0041468961233sm8440421wmq.35.2024.03.22.03.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:24:31 -0700 (PDT)
Message-ID: <f5dafde0-03d6-4693-b263-adf19984fa64@linaro.org>
Date: Fri, 22 Mar 2024 10:24:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: regulator: qcom,usb-vbus-regulator: Add
 PM7250B compatible
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
 <20240322-fp4-tcpm-v1-1-c5644099d57b@fairphone.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240322-fp4-tcpm-v1-1-c5644099d57b@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2024 08:01, Luca Weiss wrote:
> The VBUS register block on the PM6150 PMIC shares the design with the
> PM8150B one. Define corresponding compatible string, having the
> qcom,pm8150b-vbus-reg as a fallback.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> index 33ae1f786802..fcefc722ee2a 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> @@ -26,6 +26,7 @@ properties:
>             - enum:
>                 - qcom,pm4125-vbus-reg
>                 - qcom,pm6150-vbus-reg
> +              - qcom,pm7250b-vbus-reg
>                 - qcom,pmi632-vbus-reg
>             - const: qcom,pm8150b-vbus-reg
>   
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

