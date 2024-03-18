Return-Path: <linux-kernel+bounces-106121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0F487E966
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E586D283A38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253A38DE9;
	Mon, 18 Mar 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3H1r+fcn"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01E381D4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765430; cv=none; b=Z+yC1oehRcUli0quflZ2mriKqI9kWtO2qvuWOTzR7H+6EBUvMs1COpbQz4ZtqjeJdwdqNtlS0c2ewjHtWGRa6DFsJ5+d5RhhHaVM7jQETJbZRaD6p6XkpAcL2hNOEkqQU1ozp6Pm21GRLjuFKz6UHFzsgRINjJ8PcIg1Y8YzztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765430; c=relaxed/simple;
	bh=ffVSz7DOuhkOHsp+hZtUJyFaeYyOmG7SnEA1gJweHr8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=uXhiVG7E3a3ngu+vII+BO2Lv3weXt5DpmEau4INesK/UxQq2C5oY/tHwYo5MD5cTlI8zPXQr5pWyip6HKBEN3TGol+x531O83TG9ms2l6C2TgOnLkA0XBFl/LG40v2GXyiwx74Dk9flwQycPcaNAfpeyWFzjxVxSBN8qKIX4GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3H1r+fcn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2673653f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710765427; x=1711370227; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rOOelAXYkB/aiK2SaiRN9v1LrZq2BMclSsiRMOgV+hM=;
        b=3H1r+fcnra/gm/Xsk+79PZMv5zKsl7ToQOUHMjp2643/bLLbVsoe1nk9I1djcBzljM
         IadEKd3FWf/M/zDloxKzRnXng0veGHo7IRA+HK8EaNzLKHw75ZX5FiVl7XL4qexiLfVv
         8E3SkROWFiLYjAybftrvQ+Smj8bay+x+WvjwfvusMusMgeYNCS/CziCUPMrfUaf3WH0O
         XFB4haA3eSNqTakEHHzWoJ/nk85hqCpF1zxiu1j/k64RpBebZrglJ7QbsrYu8f2ZvuZ6
         GuMI00vL+1cAPuzrKTt3E0ejpb/NCG/oU6OZpj+IPut02GwPHGi/mln878luOEucieGk
         9RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765427; x=1711370227;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOOelAXYkB/aiK2SaiRN9v1LrZq2BMclSsiRMOgV+hM=;
        b=acMEtp1Ug76plm2etFzbL/aZm9V+3gaAPvewJbLftbj4HAtfl9mGpA90oD1rl6OKu8
         KcJ4uEWdxaA5lZeBIlqfYumW7UbJdjD8z3HmpVx+ovO0tXOOkusDm17KL2a/RwQc5P4c
         LEWxmfqc7n+KP8Kn+rjYwm0di1olTC5lb3KHfM7gxrODNF90Ik9ALtoALVBC7gSAoIi1
         0xY0pkK4+viIsUsTQEh9VRtBEdPl/yIAxWZeuC9BF25hxBxIQmko5VZhfHE1QBBSl02n
         cpRggmhnWv0F6wqprYNjhsYu7aBkgE8DcEPzu2TVAW2f+cVWWa/gDrm+t6x4mVvRkpEy
         ofmw==
X-Forwarded-Encrypted: i=1; AJvYcCXa9mCVmDzyfC1mhyNrcptnSfl5apP6TqpKpVXKdvetZKF2DtwRfNp6/xux5OpTB27/Eh3+DtG0u9LKgMUBGAPIQjQ3zNmZNSLBPFJR
X-Gm-Message-State: AOJu0YxKiLxTfuHGrzNEHZJA+vzYbxR2Ipu4261tyUJLIZ9UPfApSOmA
	HCRoue6/fELJ+GbTiqPNC6nhqc7eB3CQz3OOcWomYRO5u6O4GruYjoP0NXrEkdY=
X-Google-Smtp-Source: AGHT+IGH3TE2GhAXJz1wHAYIWwW1VoL15oPzUDNMTpeZ23Nb9XboEbKTQoGyB/c9i7ijddIXELni7w==
X-Received: by 2002:a5d:404a:0:b0:33e:6a81:d8b9 with SMTP id w10-20020a5d404a000000b0033e6a81d8b9mr10519425wrp.20.1710765426924;
        Mon, 18 Mar 2024 05:37:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e4d5:78c0:18b:ad85])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033e79eca6dfsm9665379wrm.50.2024.03.18.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:37:06 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-14-jan.dakinevich@salutedevices.com>
 <ca80caab-2664-4797-a222-e14537eea440@linaro.org>
 <1jil1nhjwd.fsf@starbuckisacylon.baylibre.com>
 <6feba9ff-8bbf-4494-93f0-732679bc4032@salutedevices.com>
 <1j1q87hkq2.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
  Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
  Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 13/25] ASoC: dt-bindings: meson: axg-pdm: document
 'sysrate' property
Date: Mon, 18 Mar 2024 13:19:28 +0100
In-reply-to: <1j1q87hkq2.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jwmpzg1hq.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Mon 18 Mar 2024 at 11:55, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Sun 17 Mar 2024 at 18:52, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>
>> On 3/15/24 13:22, Jerome Brunet wrote:
>>> 
>>> On Fri 15 Mar 2024 at 11:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>> 
>>>> On 15/03/2024 00:21, Jan Dakinevich wrote:
>>>>> This option allow to redefine the rate of DSP system clock.
>>>>
>>>> And why is it suitable for bindings? Describe the hardware, not what you
>>>> want to do in the driver.
>>>>
>>>>>
>>>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> index df21dd72fc65..d2f23a59a6b6 100644
>>>>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
>>>>> @@ -40,6 +40,10 @@ properties:
>>>>>    resets:
>>>>>      maxItems: 1
>>>>>  
>>>>> +  sysrate:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: redefine rate of DSP system clock
>>>>
>>>> No vendor prefix, so is it a generic property? Also, missing unit
>>>> suffix, but more importantly I don't understand why this is a property
>>>> of hardware.
>>> 
>>> +1.
>>> 
>>> The appropriate way to set rate of the clock before the driver take over
>>> is 'assigned-rate', if you need to customize this for different
>>> platform.
>>> 
>>
>> It would be great, but it doesn't work. Below, is what I want to see:
>>
>> 	assigned-clocks =
>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_SEL>,
>> 		<&clkc_audio AUD2_CLKID_PDM_SYSCLK_DIV>;
>> 	assigned-clock-parents =
>> 		<&clkc_pll CLKID_FCLK_DIV3>,
>> 		<0>;
>> 	assigned-clock-rates =
>> 		<0>,
>> 		<256000000>;
>>
>> But regardles of this declaration, PDM's driver unconditionally sets
>> sysclk'rate to 250MHz and throws away everything that was configured
>> before, reparents audio2_pdm_sysclk_mux to hifi_pll and changes
>> hifi_pll's rate.
>>
>> This value 250MHz is declared here:
>>
>> static const struct axg_pdm_cfg axg_pdm_config = {
>> 	.filters = &axg_default_filters,
>> 	.sys_rate = 250000000,
>> };
>>
>> The property 'sysrate' is intended to redefine hardcoded 'sys_rate'
>> value in 'axg_pdm_config'.
>
> What is stopping you from removing that from the driver and adding
> assigned-rate to 250M is the existing platform ?

.. Also, considering how PDM does work, I'm not sure I get the point of
the doing all this to go from 250MHz to 256Mhz.

PDM value is sampled at ~75% of the half period. That clock basically
feeds a counter and the threshold is adjusted based on the clock rate.

So there is no need to change the rate. Changing it is only necessary
when the captured audio rate is extremely slow (<8kHz) and the counter
may overflow. The driver already adjust this automatically.

So changing the input rate from 250MHz to 256MHz should not make any
difference.

>
>>
>>> Then you don't have to deal with it in the device driver.
>>> 
>>>>
>>>> Best regards,
>>>> Krzysztof
>>> 
>>> 


-- 
Jerome

