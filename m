Return-Path: <linux-kernel+bounces-102972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15587B94E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A95F28638F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46AF612EF;
	Thu, 14 Mar 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvMf9DPC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFD60EF2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405058; cv=none; b=Bj6yG7eIfOM5QcX/u5ZKjrY/r4rYLUOzcuaEN7JvL7PQ/7y1dUOx7b5K5XeKRzjZWebSjjIUZsHcj8Pj+m7UjUCqGuEpuF4i7CV/kccKja08SG7aAMFyAPia+zf7xUSdPcqOZhdNVdkzFIA5Kv2HvqrV3d6/amWuFT20GewJ0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405058; c=relaxed/simple;
	bh=wSU462xWeV+jb/Fx6lyTfUitOV7Luuama88MauNoHC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvrmc5gdN76dMUiqm/f0F3kk7u3RqaIySUsFhlk81d4/Gwp+YVE1ANlIZTZPFH7CNFQ2oxBO6IGppNTX0mkYccHheOY6VejBAij/zgXBlQmg/CA1TpC6qYVVd0iBSsrwPzjU1pgMyRBQlXB77DygQSwYCFjSVYcAxiAwcJUbZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvMf9DPC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e162b1b71so603719f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710405055; x=1711009855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjDEhlIUtZYugm2VOUzM+DS9b2GCOwIMbK6lToSWDPk=;
        b=PvMf9DPC2SEtBJugr0/n2MngTh6fTVo/3Ao87xjDwforV841FDuYMXWGxy0tInmwUq
         am9INT6ws9F0r/CXACRJB3i8qKPvRExFSv12pCWQOkwZNGivoVmWkYtk/ctUJhkI5XRs
         Umenm8HRT7BEUVkquqQbyvCpdwDGZkvhK2lN1NS1zylY5YRCXLrfwnU9PeyWNpmttgLQ
         JYBKyg9TbCQRoEyuzkcqnFChObeL0tL/KKpu6aUDGyNuL1knhUqDXsm6MeyjBW2W7/wf
         S80Ww7kWPt0GQHiHPqvOa+nnsCUNWtpKyYVeRKF042FL8FQApgUoIC3w6q9IkVJslmbH
         ox/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405055; x=1711009855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjDEhlIUtZYugm2VOUzM+DS9b2GCOwIMbK6lToSWDPk=;
        b=oCkZ2XknVS6TZVSEJvb/tvwGMy1nr5VZYYZL3IojoV7YN9uplRfIbHqTq8UzFe1toU
         KtHGSS9MPB7yIEoImM0C3iADJ/wQ7YB7gUGFlnibmmrDJuRf+MxU/ubmESQ/NP/ugieY
         uqDhWrrTU+nJuUbWorZx85ioF9iSL8AJMqiwniT0pNjC2FeoWSwKF4/hibCBmM5okWIH
         fDA9rJ4ZygxM8Q0ep4kK/T8PCfurvc9+rPDtoQQAXfPPmE84QJrD2BSulpUZSEaWZwAX
         +W+L7njzwFlUt+JGZccAhd52QWfC+SMr2TGClnT5jmgkvIhNqT4m4D0yNB63NknXMeom
         73Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWtw7CSRdKTGhIwNMovORe/Y0/NXCrbKxsLfqXTtwVRcwcrLwjuvoQAbicGJCSaKKwOHOrnRXkGK+04eRMHmDByjyyklErPwXSo16Yl
X-Gm-Message-State: AOJu0YzUjKO66Zh0jSgo87Nn4HEerzbtG4QYwALibuoc8sZfqon14W5M
	T4CW1Ucpuya4pVL9jJG1DTbCoEpSaKDG+GnOP9oE+Db+/DZgn9Nf8o/O2vVmVCA=
X-Google-Smtp-Source: AGHT+IEh0qvHhOac6Zw+EdlhO3mO2dnkKe8dkP6svfw68TaW4c5Lngi9FG22MLXI2RWOUxjq+aq74w==
X-Received: by 2002:a5d:4ec5:0:b0:33e:dd4:ca5c with SMTP id s5-20020a5d4ec5000000b0033e0dd4ca5cmr687400wrv.45.1710405055268;
        Thu, 14 Mar 2024 01:30:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p6-20020adfcc86000000b0033ec072a491sm193303wrj.35.2024.03.14.01.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:30:54 -0700 (PDT)
Message-ID: <9dc0415c-4138-4867-861a-38b45b636182@linaro.org>
Date: Thu, 14 Mar 2024 09:30:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
 Jagdish Gediya <jagdish.gediya@linaro.org>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
 <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
 <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 09:19, Sumit Garg wrote:
>>> +             compatible = "smsc,usb3503";
>>> +             reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
>>> +             initial-mode = <1>;
>>> +     };
>>> +
>>> +     usb_id: usb-id {
>>> +             compatible = "linux,extcon-usb-gpio";
>>> +             id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&usb_id_default>;
>>> +     };
>>> +
>>> +     hdmi-out {
>>> +             compatible = "hdmi-connector";
>>> +             type = "a";
>>> +
>>> +             port {
>>> +                     hdmi_con: endpoint {
>>> +                             remote-endpoint = <&adv7533_out>;
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>> +     gpio-keys {
>>> +             compatible = "gpio-keys";
>>> +             autorepeat;
>>> +
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&msm_key_volp_n_default>;
>>> +
>>> +             button {
>>> +                     label = "Volume Up";
>>> +                     linux,code = <KEY_VOLUMEUP>;
>>> +                     gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
>>> +             };
>>> +     };
>>> +
>>> +     leds {
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&pm8916_mpps_leds>;
>>
>> First property is always compatible. Please apply DTS coding style rules.
> 
> Ack.
> 
>>
>>> +
>>> +             compatible = "gpio-leds";
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>
>> That's not a bus.
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
> 
> I assumed earlier that W=1 is sufficient for DT schema checks but it

W=1 as in make? No, it is not. It's flag changing the build process.
dtbs_check is separate target.

> looks like those are two different entities. However, I added these
> address and size cells properties only to get rid of warnings reported
> by W=1, see below:
> 
> $ make qcom/apq8016-schneider-hmibsc.dtb W=1
>   DTC     arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb
> arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:96.9-103.5:
> Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but
> no reg or ranges property
> arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:105.9-112.5:
> Warning (unit_address_vs_reg): /leds/led@6: node has a unit name, but
> no reg or ranges property

Wait, so you saw the warnings and ignored them? These are legitimate
warnings, although they don't give you full answer.

> <snip>
> 
> So it looks like W=1 is reporting false warnings and we should rather

Warnings were true.

> rely on dtbs_check only.

It's really independent. There is only one case where W=1 produces
warnings you could ignore (ports/port in graphs). At least I am not
aware of anything else.

Although Qualcomm does not use clean-check-maintainer-profile, but
already some archs do (RISC-V, Samsung). For these YOU MUST RUN
DTBS_CHECK and fix ALL new warnings. But even for Qualcomm, you are
expected to run dtbs_check. And why would you not run it? You can
automate checks and save reviewers time with automatic tools, but you
decide to skip it? Srsly, that's huge waste of reviewers time!

..

>>> +
>>> +&blsp_i2c4_default {
>>
>> None of your overrides look like have proper alphabetical order. Please
>> use alphabetical order.
>>
> 
> Although these are already following the same order as
> apq8016-sbc.dts, would you like the two DTS files based on the same
> SoC to follow different orders?

I don't know about Konrad and Bjorn, but to me it does not matter that
some existing board has obvious style issues. What matters to me, that
new code does not have these obvious style issues.

You can wait for Konrad's point of view on that, if you want to be sure.

Best regards,
Krzysztof


