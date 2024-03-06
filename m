Return-Path: <linux-kernel+bounces-94560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4C874164
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998782867EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D014006;
	Wed,  6 Mar 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8KXzs44"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B779C4;
	Wed,  6 Mar 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757324; cv=none; b=kCr7HmPxwKnUE+26dG00qyZB/x6WSqH9Z06c6ndU+kINW/9WSLYKaPIr+a3xziwaqD+2PMoy7bgFpcWHspJkBMt2Mv7O23bt+OmsXFa9q8f7CFR0La4iGAeXbstsFpqdjz3vW4vq7WpBFgSR4w4AUIv+G3AZOQtYsx3DrzQUEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757324; c=relaxed/simple;
	bh=86gHzZzy3H6KCUOxByUGfAgnamLF0drA8Bx0TvaZVdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVJKXZvAhFnKRmuSP2+SovK+GPNwxSRwzIUUXyCUEwRkotxkq0gZjgbWv1zeGtD1m/KZdpZfp45R5CwsbkpzBY2ztG+vmBwqplnqWM75H7uEwoaftL1QxbgK9WetQ1I7q8eeJwr8990f1c8Ygi+Il6YmKu6hJJbiWwgxlvwho3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8KXzs44; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56759dc7ea6so177429a12.1;
        Wed, 06 Mar 2024 12:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709757321; x=1710362121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmv5uFCir5+7gqntDVJqRRqIOCeHH0PvtHKmIdkEfg0=;
        b=A8KXzs44L/gJyR+SwEkqMk4h42pIckopGqeSTUX+A1AMtqEKeigoICcIvMKjbd6UJ3
         uoUur4a1KvTJ0qUH1+dfnrztjYQgi/ueVZYpT0Iw1rnaerZjw7uS3LIsv28jaqCXU17J
         vNF0lU95WGwYL7crU09aYkbt2DwNz1Mr1pwlSw10Yr5x4nfnf6afKuNHTZ1FbjE1gYZM
         t83xyholvovw9SB6ZQZLnkzLKBpJ2bsGq2Plkl4wiUFmKEef3UeNdzp0LArc8KFQezdc
         /iBSIguxGFAl69gREkz86zFvrwOjRgeelGrSAUkRXUfkYTzcme3/FeKe0W6xhI8YEou6
         POiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709757321; x=1710362121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmv5uFCir5+7gqntDVJqRRqIOCeHH0PvtHKmIdkEfg0=;
        b=hEDwntBrOoVSOpuBZPkSI/9R0DO/0V5kA6dDauZdR87hOwXMcWici0HHAS2XamEUKZ
         89WsPA7ifZMbXcJM/oy2HUkK4+x0SL0qPAKbqGGTSW4yQwkng0LTjti2K3v1nkEFgMtg
         Fcf2WSCKAVgLXUzwvD88atsab/ouxGf3QllJhGdKSNUybGDgyxH9AHx9F2xxmBwf6wAV
         uG1XY4KuuOQFtGsb9TQGOyNB7UYa3AtUk92z2Kh+Pz+39lFjeG2vk2To7I9xmohF3LBB
         H1SGCyBm4/EN6roBTNMo3jZH1PuP8vXnVwf91a7At9JTf9rRRxLdqyimrtVLtSwPNeAV
         CyQg==
X-Forwarded-Encrypted: i=1; AJvYcCWasrrIjc7gLNdAHIyoQkBq0WwSU4Mx9M9f4mxHdf3SpKRG1fRXdW+3yiFmh+6s2PV6cMAgHrjh1j2cGw93L/s3ldznHC+Vx0DH2juoagFPjNuuNPYAP/N5ON0ZzRt+FG3jjSgs0vf8vIMOGxRrIi94AE/CkTttKpqTDT0HMyRYGaG2guVo6I8=
X-Gm-Message-State: AOJu0YwKGFvFpUKgV0599La+GXAksDBe9m9oIa9bTdWBoC1ZrS+WEP7j
	QcMTF9/XOu43Rdh7irBxRvA7kII5nG87WZy2uHELqKjJFosLlTarbP0TkHv7
X-Google-Smtp-Source: AGHT+IG3lGMEqbO9JWIyWGDBD2ROiHc2d7ew2TuR3OLZeIpp4/05XGU+c1OiDjinAtyT+1ZnWcNZMQ==
X-Received: by 2002:a05:6402:2315:b0:565:6c72:40a9 with SMTP id l21-20020a056402231500b005656c7240a9mr11458055eda.28.1709757320770;
        Wed, 06 Mar 2024 12:35:20 -0800 (PST)
Received: from [192.168.3.32] (d-zg1-234.globalnet.hr. [213.149.36.248])
        by smtp.gmail.com with ESMTPSA id fg5-20020a056402548500b005679143295fsm2041404edb.58.2024.03.06.12.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:35:20 -0800 (PST)
Message-ID: <78b1a1a2-a9fa-4b28-9d96-d65bb5517199@gmail.com>
Date: Wed, 6 Mar 2024 21:35:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] arm64: dts: qcom: ipq6018: add sdhci node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240306123006.724934-1-amadeus@jmu.edu.cn>
 <20240306123006.724934-2-amadeus@jmu.edu.cn>
 <CAA8EJpqYjutM1Kh6QxysB6XNAmXywtOtRJ7KP0LbY5E36kCPvA@mail.gmail.com>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <CAA8EJpqYjutM1Kh6QxysB6XNAmXywtOtRJ7KP0LbY5E36kCPvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06. 03. 2024. 20:43, Dmitry Baryshkov wrote:
> On Wed, 6 Mar 2024 at 14:31, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>> Add node to support mmc controller inside of IPQ6018.
>> This controller supports both eMMC and SD cards.
>>
>> Tested with:
>>    eMMC (HS200)
>>    SD Card (SDR50/SDR104)
>>
>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 322eced0b876..420c192bccd9 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -441,6 +441,25 @@ dwc_1: usb@7000000 {
>>                          };
>>                  };
>>
>> +               sdhc: mmc@7804000 {
>> +                       compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
>> +                       reg = <0x0 0x07804000 0x0 0x1000>,
>> +                             <0x0 0x07805000 0x0 0x1000>;
>> +                       reg-names = "hc", "cqhci";
>> +
>> +                       interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +                       clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +                                <&gcc GCC_SDCC1_APPS_CLK>,
>> +                                <&xo>;
>> +                       clock-names = "iface", "core", "xo";
>> +                       resets = <&gcc GCC_SDCC1_BCR>;
>> +                       max-frequency = <192000000>;
> If I understand correctly, GCC_SDCC1_APPS_CLK support frequencies up
> to 384 MHz, but here you are limiting it to 192 MHz. Why is it so?
>
> I am not sure that 384MHz is actually supported as IPQ6018 datasheet
> clearly indicates that HS400 mode is not supported.
>
> Regards,
> Robert
>
>> +                       status = "disabled";
>> +               };
>> +
>>                  blsp_dma: dma-controller@7884000 {
>>                          compatible = "qcom,bam-v1.7.0";
>>                          reg = <0x0 0x07884000 0x0 0x2b000>;
>> --
>> 2.25.1
>>
>>
>

