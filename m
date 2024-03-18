Return-Path: <linux-kernel+bounces-106122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C496587E96F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6081F2303F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0A381DD;
	Mon, 18 Mar 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjaGvWzg"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5152C1B6;
	Mon, 18 Mar 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765459; cv=none; b=badohQ4TjGSg1Vfmv46Os1RraS663vcnz0ToFGoiGNcEXoofkZhEqszSJRevlca8Dq5F4/vkFX9aiQ5kXrTepJeJXEUqrPHJK/VahzXZet0SZHYm73UNdskKjeW1oimoax9O4CVj6D7r66YbHAEETaMBn78VrJas0ThNYFcp04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765459; c=relaxed/simple;
	bh=n3nj14kJhGQoVcDiuHhUwEg8Bhy8pR2tKc0A0QnHthE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjScqa2I29sFSTlT5gziY93jey+1EwUegMCHwJgscrYLIz/a5j5rOpUSuyov93fZknfQY7HHF9SFMDTwhn/ONAoIEZiAUZLnoeV+JoGpizYgkae7+9ABNMv3rd+o7Mzhl00AoLdIuafCB2A7BqyiNCnVtq6kwWIDzFaCM3UtyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjaGvWzg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso3586116b3a.1;
        Mon, 18 Mar 2024 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710765457; x=1711370257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HanPhs+5pxNZQ2UN6SW5+54Ajhvbvl08qcxZF5kLZJw=;
        b=AjaGvWzgD0D8RqccSYzLOshHEUSJ07UHw5HPwdoN+C9LTD7yqnK70vTglzCqrM47sg
         e0sGpWjEOXA00kzAyvhKFMNqlc3YGisi9j7kAhujCgIcCDRXSs2bflx1lfu2u2ZeFwLx
         xEU51nBf4w9J6D+VjFP2+EKYkHi/Z5zZLuXm3kcuQuBoEkYFCptIOQSgPUpwHE27fjT6
         AIdHa5K1MSGYWfUV5RpP+t1HeVgqQcZ6BOIiBqQWm6kriN4XS7hQCqfaI0cMYxirkEu1
         Su86IQ3etAFF+tyxSjmZZmu4WLdlq3w9adWSJ3KuuUiHH8dzFZYX9Tuih+KwetGDwToS
         t/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765457; x=1711370257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HanPhs+5pxNZQ2UN6SW5+54Ajhvbvl08qcxZF5kLZJw=;
        b=gkpqj9PJDI2iacZNaqZZ2/YScAeg0oGqfDrb7zgRJrKlLlw4vWkIJJNZxCLTXiq2S+
         gd9Y2wc7XT4M9vX6riDeOiDmaMXQEyYjMRfaHn3YGZCz/4SSpQVbmse7iFPlNX6zdngj
         NnH7Gqbsd2zsP/vnivYeoHUsBmTC3x/AkpNbb6VtBK3iH3cYrVBUNgJI2y63Jq3RxUiO
         xcflQx36BNuOgtvqltEuJFJW7DpI48uYyQPvv7K+Ee1RHz7ZzUmpHnntWDwhqcAGpjUW
         vhYnVKc9nxJ7aaA8qlDS5iWLVGRFaMbolcdpHsyRrFCO0EchjzurFm5C+cgGurwkLqrR
         45ig==
X-Forwarded-Encrypted: i=1; AJvYcCXXZ1G54m/kCM7wMRKSDfuya8a6RUjRKOZo9ywdZ/goWyPPOtptpPmHIu9wg5qwwjeaJdHIs7P12rbqBx1BT8ENqKdYUJWyDkaG4H9FScO/0pDg3+ow7bxxOWMBCkGIdh+5E+gaxjgNgC19td3cv0VUWSjVY9AxGeSeL6wRffX6i7VQYw==
X-Gm-Message-State: AOJu0YzKCpqTDwfWhZY63ePrAjBaGKDQWtrZYekifCS+aRvD9p7/yFKC
	KTd9qGacb7EQxhKsVn98U1edy/xxaE6FWKKE3zqvr4ijXXlo6tQ4
X-Google-Smtp-Source: AGHT+IE28j3JMcgmkhIHT5C2xjMBKmVzdMK31Wr/3TQ9SLPD+hsnPLfW9CeJ8hkB4t35V3ofHy0FWQ==
X-Received: by 2002:a05:6a20:9185:b0:1a3:6b98:9a84 with SMTP id v5-20020a056a20918500b001a36b989a84mr852665pzd.10.1710765456826;
        Mon, 18 Mar 2024 05:37:36 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id r3-20020a17090ad40300b0029c68206e2bsm7569501pju.0.2024.03.18.05.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 05:37:36 -0700 (PDT)
Message-ID: <c3f5aa60-61e1-46df-8c3c-864e0acc750e@gmail.com>
Date: Mon, 18 Mar 2024 18:07:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, Vaishnav M A <vaishnav@beagleboard.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-2-ayushdevel1325@gmail.com>
 <20240317205927.GA2178147-robh@kernel.org>
Content-Language: en-US
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <20240317205927.GA2178147-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new version of the patch is up and can be found here: 
https://lore.kernel.org/lkml/20240317193714.403132-1-ayushdevel1325@gmail.com/


On 3/18/24 02:29, Rob Herring wrote:

> On Sat, Mar 16, 2024 at 12:18:59AM +0530, Ayush Singh wrote:
>> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
>> developed by MikroElektronika for connecting add-on boards to
>> microcontrollers or microprocessors.
>>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../bindings/misc/mikrobus-connector.yaml     | 110 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 116 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
>> new file mode 100644
>> index 000000000000..6eace2c0dddc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
>> @@ -0,0 +1,110 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/mikrobus-connector.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: mikroBUS add-on board socket
>> +
>> +maintainers:
>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: mikrobus-connector
>> +
>> +  pinctrl-0: true
>> +  pinctrl-1: true
>> +  pinctrl-2: true
>> +  pinctrl-3: true
>> +  pinctrl-4: true
>> +  pinctrl-5: true
>> +  pinctrl-6: true
>> +  pinctrl-7: true
>> +  pinctrl-8: true
>> +
>> +  pinctrl-names:
>> +    items:
>> +      - const: default
>> +      - const: pwm_default
>> +      - const: pwm_gpio
>> +      - const: uart_default
>> +      - const: uart_gpio
>> +      - const: i2c_default
>> +      - const: i2c_gpio
>> +      - const: spi_default
>> +      - const: spi_gpio
>> +
>> +  mikrobus-gpios:
>> +    minItems: 11
>> +    maxItems: 12
> What is each GPIO entry?




>
>> +
>> +  i2c-adapter:
> We already have i2c-bus and i2c-parent properties. Neither of those work
> for you?

I think i2c-bus should work. Although I could only find information 
about what it is supposed to be in some old kernel i2c.txt so is there a 
general place for such properties to be discovered?

>> +    description: i2c adapter attached to the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  spi-controller:
>> +    description: spi bus number of the spi-master attached to the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  uart:
> Nice and consistent. In 3 properties, we have 'adapter', 'controller'
> and <null>...

Right. So the names I am currently using are from v2 of the patch and 
are based on Linux kernel names for this. But yes, they probably need to 
be changed since dt-bindings are not supposed to be tied to Linux. Not 
sure if `spi-bus` and `serial-bus` are appropriate though, so maybe 
`{spi, serial}-controller` is fine?

To explain why these are here in the first place, mikroBUS addon boards 
are free to only use a few of these buses or multiple of these 
simultaneously. Also, some of the properties of spi, i2c etc device 
needs to be changed depending on the mikroBUS board (mostly described by 
mikroBUS manifest). This means, the driver needs access to i2c adapter, 
spi controller, serdev-controller, pwm associated with the mikroBUS 
connector to configure them (or not use them in case of Not Connected) 
and register the board.

> Also, DT generally uses 'serial' rather than 'uart'.
Noted
>> +    description: uart port attached to the mikrobus socket
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  pwms:
>> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
>> +    maxItems: 1
>> +
>> +  spi-cs:
>> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    items:
>> +      - description: chip select corresponding to CS pin
>> +      - description: chip select corresponding to RST pin
> How would someone handle any of the properties defined in
> spi-peripheral-props.yaml?
>
>
> Rob

After taking a look at `spi-peripheral-props.yaml`, the properties 
described here will actually be specified by mikroBUS manifest and thus 
will be set by the driver after parsing the manifest.

If you are referring to keeping `spi-cs` in sync with `reg`, well I'm 
not quite sure how to do it better than the current implementation.

Ayush Singh


