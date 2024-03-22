Return-Path: <linux-kernel+bounces-111399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BD886BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9D0285FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD33FBAC;
	Fri, 22 Mar 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5iHBY8V"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA23F9DD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109063; cv=none; b=DWGEmuzKpMFHh9Rg47vib8MO0tI1CVR0GVuW9FzDcIeAr9KQrqyEjhY2lzKuosLMGHVYO4ajLUQ1FrOdp/I2ze9BEVgm4kwECqoDIqjyyfa2F1vZ2qw04zgNbpQkah5VAEnTjQisDzwQ9jORX34WYajTaFbE6yp2Nm+hb1xei8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109063; c=relaxed/simple;
	bh=ozlstPZnT67G4t93qFgml5ue6BYtjIpzn6sfzja57vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoWZ4x0ZZqgv6MyMPaHSKz9zYQlChVLndHaLAHVaV+VEFBp8OY77YcbZ6MxVIOErtCTScy7JXvQVgmBHTNGO2AK3SRXHUefAT8oiAT7dK5RPPf9hxBUBYd7IUmfVsJuetuf9BrZ0dVWkNWYWmbrdQBDKd17brllXPwxsBTtKHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5iHBY8V; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso27239211fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711109059; x=1711713859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WICDXs2NPGOqmCrNvqdcZ0UIIiTxf1scmM138aUvNvU=;
        b=v5iHBY8VOsts32yOxa9k1syF9f2j06jTETL5HW4AzvJvUUMGk+CH+DpxPaVrAFIZee
         E60cGLO0oL4d8xMz7LCC5RjsCEMOaIoBcHwfPEROI8HVj3dJiEUY3P7xso7sJNgfTov/
         3h77unyGL8zJZWs9dOBVEbz5B09x2q4ygvNW0HbLG/06+LKjyy+cIGfK/1bML+NdJAi7
         dFYijtbID9aluF2NqAOrknox/NScvzUzNhDSBPIcsYHVB3qkglmUbFYa+5StuG2TNnr1
         1JXShjZ5jIP5f7UjGmm7TYE3PAU40UJa5XHIOAp5gtjRZhvwMQEJKwqEOvZRfWu5qEFl
         dAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109059; x=1711713859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WICDXs2NPGOqmCrNvqdcZ0UIIiTxf1scmM138aUvNvU=;
        b=xFmJjj9WljEoBhTA3dLwpSEOLp20g9ZyfMK4oaP+E7wzTN5dc4TNeRL3JVYW31N38C
         896D3Qq/GQRvcKebXq+EUKy+LlVbjt35Lzbo8SHrG4SWbW1xIvkwNVA8600tU+FK5aan
         U8Ike1PxH9zoKE7HJ1FMZnYP3speDVkLRJQi2ZEGA++GLUKoZXJKZB6MXOKpn55h0t3z
         YYv2UTh97XdWzkEnLO0grOiEhNuuz/gNPmoZyz8YZXEU7flJXoalKqitf8NYjHpiI1Bq
         9rQjmYc3L0ak27rcG3hLiJtAMNZzULYsLZoScp/tcft21JfYYdHk4YDQ6Ffn4RUJA8WL
         C5BA==
X-Forwarded-Encrypted: i=1; AJvYcCWxQN6YhndzvJP6lKj2WcsZfFmN5AmUyY9Je8u5o8OO7C1W88cxjYPHLOSs4wtqml3T+LLqCeR3A5wuSUX3dCOPXk+cPpJARt+UoXY1
X-Gm-Message-State: AOJu0YwqaU+uI4K5WcA4e1HwDbcDeA6vGSahosmwvQZrCXHqU2GYbtP3
	0U2tZ4EVoX78YzrDXWwPYHUxdn1Gk67SSThE2JWqGz5YVRNOYZyqnIqTxZzDOg0=
X-Google-Smtp-Source: AGHT+IE128SN8UjOrd0vAtwBkqgFTxULvcKhrr33MiQn/9XmlyQg+Y9eD+d/cclzTtWcEu78DU8fSw==
X-Received: by 2002:a2e:3312:0:b0:2d4:6e71:59e9 with SMTP id d18-20020a2e3312000000b002d46e7159e9mr1574758ljc.13.1711109059394;
        Fri, 22 Mar 2024 05:04:19 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b0041477f95cf6sm2887639wms.13.2024.03.22.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:04:19 -0700 (PDT)
Message-ID: <13368789-1ee0-49fe-8732-ba170349cec7@linaro.org>
Date: Fri, 22 Mar 2024 12:04:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
 Jagdish Gediya <jagdish.gediya@linaro.org>
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org>
 <ZfRlYnEQUKvwGQ65@gerhold.net>
 <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
 <ZfmdWtoiP4ZF7JRk@gerhold.net>
 <CAFA6WYPzdSHEMmeb_J6LPje8MUkSSq93oN3+O1PMahtZN7hWnA@mail.gmail.com>
 <ZfwM3ZrjTWR_QANd@gerhold.net>
 <CAFA6WYN+Y8qyv9yEMoU1wqpqDN7rwNO5xfHkSUe+H2DdSiBqyA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYN+Y8qyv9yEMoU1wqpqDN7rwNO5xfHkSUe+H2DdSiBqyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi both,

On 22/03/2024 06:29, Sumit Garg wrote:
> On Thu, 21 Mar 2024 at 16:03, Stephan Gerhold <stephan@gerhold.net> wrote:
>>
>> On Wed, Mar 20, 2024 at 12:10:32PM +0530, Sumit Garg wrote:
>>> On Tue, 19 Mar 2024 at 19:43, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>> On Mon, Mar 18, 2024 at 03:20:46PM +0530, Sumit Garg wrote:
>>>>> On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>>>> On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
>>>>>>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
>>>>>>> Box Core board based on the Qualcomm APQ8016E SoC.
>>>>>>>
>>>>>>> Support for Schneider Electric HMIBSC. Features:
>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
>>>>>>> - 1GiB RAM
>>>>>>> - 8GiB eMMC, SD slot
>>>>>>> - WiFi and Bluetooth
>>>>>>> - 2x Host, 1x Device USB port
>>>>>>> - HDMI
>>>>>>> - Discrete TPM2 chip over SPI
>>>>>>> - USB ethernet adaptors (soldered)
>>>>>>>
>>>>>>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
>>>>>>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
>>>>>>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>>>>>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
>>>>>>>  2 files changed, 511 insertions(+)
>>>>>>>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>>>>> index 39889d5f8e12..ad55e52e950b 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>>>>> @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
>>>>>>>
>>>>>>>  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
>>>>>>>  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
>>>>>>> +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
>>>>>>>  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
>>>>>>>  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
>>>>>>>  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..9c79a31a04db
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
>>>>>>> @@ -0,0 +1,510 @@
>>>>>>> [...]
>>>>>>> +
>>>>>>> +&pm8916_resin {
>>>>>>> +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
>>>>>>> +     linux,code = <KEY_POWER>;
>>>>>>> +     status = "okay";
>>>>>>> +};
>>>>>>
>>>>>> What is the goal of overriding the interrupt here? It looks like you are
>>>>>> changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
>>>>>> sounds a bit like you want the driver to receive just button release
>>>>>> events (or just press events, not sure about the polarity). I'm not sure
>>>>>> if the driver will handle this correctly.
>>>>>
>>>>> The use-case here is to just act upon button release events and the
>>>>> driver handles this appropriately. Final use-case of the reset button:
>>>>>
>>>>> - Short press and release leads to normal Linux reboot.
>>>>> - Long press for more than 10 sec or so leads to a hard reset.
>>>>>
>>>>> With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
>>>>> press leads to Linux reboot.
>>>>>
>>>>
>>>> Thanks for explaining your use case. Is the DT really the right place to
>>>> describe this? In the hardware, this is just a button that provides both
>>>> press and release events. Linux typically forwards these events to user
>>>> space, without interpreting them in any way. This means you likely have
>>>> some user space component that listens to the events (e.g. systemd
>>>> logind). Ideally that component should be reconfigured to trigger the
>>>> reboot on release instead of press.
>>>
>>> I am not sure if that's really the case. I only see power key value to
>>> be reported as follows:
>>>
>>> input_report_key(pwrkey->input, pwrkey->code, 1);
>>>                     or
>>> input_report_key(pwrkey->input, pwrkey->code, 0);
>>>
>>> It's not like a press event being a rising edge (0->1) or a release
>>> event being a falling edge (1->0) reported. AFAICS, a reboot is issued
>>> whenever the value of power key is reported as "1".
>>>
>>
>> If you look inside the input_report_key() function you can see that the
>> input subsystem internally tracks the key state. input_get_disposition()
>> returns INPUT_IGNORE_EVENT if the key bit already has the same value.
>> Only when the key changes its state, an event is sent to user space.
>> This means that all events reported to user space are effectively
>> rising/falling edges (an event with value "1" is a rising edge 0->1, an
>> event with value "0" is a falling edge 1->0).
>>
>> The only reason why setting IRQ_TYPE_EDGE_FALLING works here is because
>> of the workaround added in commit be8fc023ef64 ("Input: pm8941-pwrkey -
>> simulate missed key press events") [1]. No event is reported when you
>> start pressing the key. When you release the key, you get a key press
>> event (rising edge) immediately followed by a key release (falling
>> edge). But the workaround was added to handle potentially missed
>> interrupts, not to inhibit reporting key press events.
> 
> I rather see it differently being actually allowing the current
> use-case to support only the IRQ_TYPE_EDGE_FALLING. As per your
> description above, a falling edge can only be an event for user-space
> if we have:
> 
> input_report_key(pwrkey->input, pwrkey->code, 1);
> input_report_key(pwrkey->input, pwrkey->code, 0);
> 
> rather than only
> 
> input_report_key(pwrkey->input, pwrkey->code, 0);
> 
> which won't trigger any event for user-space, right?
> 
>>
>> In my opinion, if you want to perform an action on key release rather
>> than key press then you should adjust the user space program to do so.
>> From the point of view of the hardware DT (and even the kernel), the key
>> press happens when you actually start pressing the key, and not later
>> when you release it.
> 
> The reason why we are discussing it back and forth looks like due to
> lack of clarity as to how HMIBSC board supports this button. The
> common implementation as per db410c DTS is to have two buttons:
> 
> - One button is representing pwrkey(KEY_POWER) which is solely
> consumed by the operating system to cleanly power off/restart the
> db410c.
> - Another button is representing pm8916_resin(KEY_VOLUMEDOWN) which
> apart from normal volume down is also consumed by PMIC hardware to
> perform a hard reset on a long press (if more than 10 sec.).
> 
> However, on HMIBSC board we only have a single power/reset button
> which has to support the dual role of above two buttons on db410c:
> 
> Only one button as pm8916_resin(KEY_POWER), behaviour required:
> - The rising edge (or button press) has to be only consumed by PMIC to
> perform a hard reset of the HMIBSC board if pressed for more than 10
> secs.
> - The falling edge has to be consumed by the operating system to
> cleanly reboot the HMIBSC board.
> 
> So what you are asking here is that the operating system has to be
> notified of the rising edge of the button even if it has to just
> ignore that without any action. Do you really think that would be
> acceptable as a generic solution for systemd logind?

Yes, this does seem to be a bug in systemd-logind. It appears to have
subtly different behaviour depending on if you have
HandlePowerKeyLongPress configured or not. If it is set to any action
then systemd will wait until you release the key to decide whether to
perform HandlePowerKey or HandlePowerKeyLongPress. However if there is
no LongPress action configured then it will immediately perform the
HandlePowerKey action on key down. [2]

As a workaround, try adding HandlePowerKeyLongPress="lock" to
logind.conf and see if that gives you the desired behaviour on short press.
> 
> Also, why DT isn't the right place for correctly describing the
> intended hardware behaviour? Or am I missing any DT policy which says
> hardware has to be described the exact way it is rather than the
> expected way for hardware to behave? BTW, If you want the hardware
> behaviour to be properly commented then I can do that too.

DT is for describing the hardware, not for dictating its behaviour. As
Stephen pointed out, your workaround here only works due to a workaround
in the kernel for a bug... DT isn't just consumed by Linux, and some
other OS might not behave correctly as a result of this hack.

[1]:
https://github.com/systemd/systemd/blob/main/src/login/logind-button.c#L215
> 
> -Sumit
> 
>>
>> Thanks,
>> Stephan
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be8fc023ef64dcb11042aaa4bb0f29f7e0335d85

-- 
// Caleb (they/them)

