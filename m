Return-Path: <linux-kernel+bounces-111558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE8886DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0491B23926
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE6605A6;
	Fri, 22 Mar 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVROYI1v"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39747604DB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114793; cv=none; b=Y/vvQpkXm30drbhFSdZMV23b7c6SQXcZE1LwAqV2s2cEmWxN9le2z/+eeIJlf/Rl5vAohQKjAO4ItmYJFN+z/lbBfiqhOogEscnI1IWJojVvu84I4P6EE5mNyOfN4eaILUnSMPZ6qdFM9+saMs31daUzjo3Gw5RGqXUC59fb3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114793; c=relaxed/simple;
	bh=vRgpQASesDWjf3HIxcAUMYfFe8R0lGVoGSSqkSo7PmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrV89F0Qh8Nu+uXmSQepLdMUXfzsNKWxlagm4QZzqqvgZFCj/q8Y1aepFk9AxzWlsExpBSPBX742rna3l6SwNcrcWo7XPit1+Iyb+JVqFaeAq8q9dAaz9kxSNdX0DVmwD/dhoPd99yyNFeDpsrjurMMg9XLrekVHqy/cJwfytaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVROYI1v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513dc99b709so2691681e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711114789; x=1711719589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSOUe1D1Ck4AK4cXhnMlYCbQiMs6c7j3t9qtjEagchs=;
        b=aVROYI1vmP4ro+9K2zmR3W7EasBe/So2KJhcRDOZtbR5P4LACAspPyRbrX+9n/m1mq
         rlX8r+XWZwFhDsYF0ph+2bsVezm/nm4vjXOGTqYyl4FROGlVX27jwM86+PGlJrJoxE9A
         NBdghgx++/xuFJFCgS8WqWs2TRjyIGypS0prPGQQzlRu0JNlz+Mz0xA/vnsgHy0yIpIi
         f13UGE+ZjFk3yk3Df8ZbvaU7fRLxIoJyO0zXDeYzE9g7p5s6BZJwQtgveIED/538rQhY
         FXduyDZj3IZxaFhfmeHW46ukgbxMvKB4SBq0FbuEfLQmLkP33chRJFAnMo2YzYHxectD
         rp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114789; x=1711719589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSOUe1D1Ck4AK4cXhnMlYCbQiMs6c7j3t9qtjEagchs=;
        b=M1SeAochs7+3NCkSLLcvIQcjfB1TpsvC2GUWmt31j1WlCpDvwMxNOv93Ml8nF3j9Zv
         KSQUc8azn6sPNQYjssN6rJrTpyxzpc/EatK8IOi1408nesQDbv78jWz3W6clAUL0ZrMG
         b2GfISuCJhnoZUsZTZcztIW99WOce8OwkCbH6gfP1eaYmY3QPIYmbZSbv7hUQLGFxZ3P
         w9Alow2RYU7YhYhkAhwfzXvkDqlxJkbEYuX+lo8NpNsBPeTGwQUcqN2TWURcFxJcQPtr
         Aar8Tm80LwUUf8I2UYf9xZZyVp7Hm4+Yyu0sYww+xCQbeZnFVLEIwB36GXe+xzVw6Fvc
         TJyw==
X-Forwarded-Encrypted: i=1; AJvYcCV+/a4fqzE8oVCbHHM++WAUXrQhTvGp3r9FVlzA9OHYDiiGGsdMLM2Um8GHvlD8FA4jBFlOgc9UO1fxiyMb9kgCBfF9P7vyq+OEEEBM
X-Gm-Message-State: AOJu0YyqNpTO/nJnd3YFIrF2RPC6LelXmjsXN2KXrX2DdBlVqnn/600V
	1uwc6gtxLA/ORzvwELE++HfBr7b+fGhSzCHNoSvUmLcGIuDaisfH/kIDzMtneWQ=
X-Google-Smtp-Source: AGHT+IEUzhdTBqSsF7Wik4m8iunociu4UxCn8Yaz1RC1Y+i9IKNHoPf9ooTZEmdJpXscKYxnZx9Qqg==
X-Received: by 2002:a05:6512:54d:b0:515:9aba:7430 with SMTP id h13-20020a056512054d00b005159aba7430mr1260462lfl.13.1711114789248;
        Fri, 22 Mar 2024 06:39:49 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.168.208])
        by smtp.gmail.com with ESMTPSA id og18-20020a1709071dd200b00a4725e4f53asm906510ejc.40.2024.03.22.06.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 06:39:48 -0700 (PDT)
Message-ID: <73ba6104-aa54-444e-b6c5-7f89d1fa0060@linaro.org>
Date: Fri, 22 Mar 2024 13:39:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: define all PERIC USI nodes
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20240307135912.163996-1-tudor.ambarus@linaro.org>
 <073e5ef5-2a2e-4300-93d6-e25552276e13@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <073e5ef5-2a2e-4300-93d6-e25552276e13@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, Krzysztof!

On 3/8/24 16:45, Krzysztof Kozlowski wrote:
> On 07/03/2024 14:59, Tudor Ambarus wrote:
>> Universal Serial Interface (USI) supports three types of serial
>> interface such as UART, SPI and I2C. Each protocol works independently.
>> USI can be configured to work as one of these protocols. Define all the
>> USI nodes from the PERIC blocks (USI0-14), in all their possible
>> configurations. These blocks have the TX/RX FIFO depth of 64 bytes.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>> Please note that:
>> - google,gs101-spi compatible was queued through the SPI tree:
>>   https://lore.kernel.org/linux-arm-kernel/170742731537.2266792.3851016361229293846.b4-ty@kernel.org/
>> - SPI dma properties were marked as not requiered. Queued through the
>>   SPI tree:
>>   https://lore.kernel.org/linux-spi/170967132774.228925.1759895846287455970.b4-ty@kernel.org/
>>
>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 782 +++++++++++++++++++
>>  1 file changed, 782 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> index ee65ed9d2cfc..d7ecfbc7e440 100644
>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> @@ -373,6 +373,398 @@ pinctrl_peric0: pinctrl@10840000 {

cut

>> +
>> +			hsi2c_1: i2c@10900000 {
>> +				compatible = "google,gs101-hsi2c",
>> +					     "samsung,exynosautov9-hsi2c";
>> +				reg = <0x10900000 0xc0>;
>> +				interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> I wonder why we use four cells in GIC...
> 
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;

I'd like to respin this patch. Any preference on coding style for
#address-cells and #size-cells? I guess they shall be above ranges
property if present.

>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&hsi2c1_bus>;
> 
> Please reverse two lines, first pinctrl-0 then pinctrl-names. I know we

Ok.

> did not follow this convention till now, but at least new code can be
> correct. Also clocks should be before pinctrl, so we keep some sort of
> alphabetical order.

Ok.

I guess the order shall be:

1. compatible
2. reg
3. #address-cells (if applicable)
   #size-cells (if applicable)
4. ranges (if applicable)
5. Standard/common properties ordered alphabetically (ex. clocks,
   interrupts, pinctrl)
6. vendor-specific properties
7. status (if applicable)

Please let me know if you have other preference. Thanks!
ta

