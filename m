Return-Path: <linux-kernel+bounces-32663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AA835E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6211C21012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DC3A264;
	Mon, 22 Jan 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HauJAfF2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6773B783
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916886; cv=none; b=ajmcAHld5zh23u8eIlaWcbq+pN1pIepCntOmwsRX78QrIXFud/tC8PEKEPxa1Mw/qsw28lTsOVxzRocXsH104j6JG6pbntPXmQPPTiA297ojLUHl1680p8pSngJejfUdIXQB5bmJXwwJkbDsfODvs9Euw8Xe3emx0GYMqek2FhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916886; c=relaxed/simple;
	bh=5CqzgLvtLSy8On98r79zHw0T1BKSaoeTGaV2f7m3H3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ71KphXr+7gLZkNFLkUFp2y2i0IrIFfau9EXBqD62y0H2M2Wl3Cdwn/1Td7uxZyfSWpr0xcy/dp+ZPKsgCb3lduHlsJ7RVVzgq13lwgLOMSHzm9JTdIORW4YosLByv2IXtjlExepjz29wUGJr1QR7L28DvfO07l6j2ICTIsdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HauJAfF2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so10477605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705916883; x=1706521683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKFo9+gcWyXSSIE3+PgkR0ECiwezI5MaHJNwR7Qu1YQ=;
        b=HauJAfF2iwL2ILlMDpr37svxRUw3YQYBquts28x+7oLwpJpaEjQvmA1qbtqykQ0rT3
         2riLL3j20WRn69NSS4JZ8DM9r84bO+P5b5MDgdqGN/xiZlruLkJRpdezVHcTpD//lmmx
         qGbWhIwt6F0EsmT6CckA1XhKYCAxSg+P9tu4acJydBQOYN6hAzAFeWpNgidPY9CVg/Lm
         /B3bfQAbgjY+yAKp5X0e/9ku+pzh8lDRX7oqAvHqcMC0TjRuIfATZPcTelwJ3rGP5VNQ
         WszBKSo7NSx7jGvC0wgo5eNKMoj5o+Fi2g+IBwMM2wI0Ah3X9J7Ns1BbkYp0wSLMcWrA
         8kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916883; x=1706521683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKFo9+gcWyXSSIE3+PgkR0ECiwezI5MaHJNwR7Qu1YQ=;
        b=v1xl/6QpD96toEkPK2qRmlyS7My6D/w7NZ62IFepzy3B+XKQpEPM/Pu7wN5coKu0//
         jRvxcxeRvf6io8innCTFONx9JQgfIkc8lNG3gJabGvh+htwSU9hyFXvpKgRualnjB9YQ
         ltwWWpfLh+p1nDm4QZv6NOgQ2w4cOWzF0+qGIUj3uwZqn5VVGF1Pdd/tnTXF6Ncs/NRD
         FWG+/Cdy1fyw6rsiZqzNsfRP2VNd7aXbU2OJWjywghG0aEw482FG0Tyw8Ko7oJxBEOVm
         hY/K/3825EhsItO6Qc0AedNvhJsYgbHzmLfs0YeogqzGAVJi7P5TxigU/gf5ceGqagKB
         oJXw==
X-Gm-Message-State: AOJu0YzJY8BiZl5V+UFBdlFtn86xuRKBByadu/u1IcexrqZc6q8FpCiS
	QGLMcpsNWJkwhqD0xHkrftFW/Bbof7AgNY3jzHESVC6sd6J2ZTD6qskMTnRXxhQ=
X-Google-Smtp-Source: AGHT+IGn7yMWGuO5tqeG5FaAb0ROqU+B5Ne8/dIZdLThjMhGcUVPi+cSi7GB7/EIoaFU8uJ8eWdofA==
X-Received: by 2002:a5d:4bc2:0:b0:339:219e:a049 with SMTP id l2-20020a5d4bc2000000b00339219ea049mr2227946wrt.92.1705916883163;
        Mon, 22 Jan 2024 01:48:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id x16-20020adfcc10000000b00337b47ae539sm3154432wrh.42.2024.01.22.01.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:48:02 -0800 (PST)
Message-ID: <73d75a74-71db-43c7-935a-65423159ce42@linaro.org>
Date: Mon, 22 Jan 2024 10:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974-samsung-klte: Add label on
 /i2c-gpio-led
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240121154010.168440-1-i@rong.moe>
 <20240121154010.168440-2-i@rong.moe>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240121154010.168440-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/01/2024 16:39, Rong Zhang wrote:
> Some variants of klte, e.g., the China edition (kltechn), have minor
> differences to differentiate them from klte. This includes the GPIO pins
> connected to /i2c-gpio-led.
> 
> A label is added on /i2c-gpio-led to allow DT of other variants to
> reference it conveniently. Considering both LEDs and a GPIO expander are
> connected to the node, it is named "i2c_led_gpio".
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> index b93539e2b87e..013946ccda0f 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> @@ -77,7 +77,7 @@ touchkey@20 {
>  		};
>  	};
>  
> -	i2c-gpio-led {
> +	i2c_led_gpio: i2c-gpio-led {

This does not make much sense on its own. 6 commit msg lines just to add
a label. Squash it.

Best regards,
Krzysztof


