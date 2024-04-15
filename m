Return-Path: <linux-kernel+bounces-144609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93468A4862
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161741C209BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97F1EEE3;
	Mon, 15 Apr 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvBy/GlB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7B1DA22;
	Mon, 15 Apr 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163914; cv=none; b=bLPP3JmgD1zfCra6ZpK2FgS/ZQhmXkAtuSsaUhD6CchdRswsiQiCRB8RanLkMzzpVETcMvWzvb3tvzJbCVW9GHsei2GrXO6Dngq+kP/J4j0dK0Xd/pCFaNjEWgt7EHlovZ57w2/ubkrJM9mMUAjm/QObhh6KjXgYvkQPol0zWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163914; c=relaxed/simple;
	bh=Hh9PTpuRQn7JZ3hF1MpGnhNpj1yN1wqNoX+oD+I7S2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fti5aM3BVhpdJYiIirGqQTF8CI7i4VGOjRx6kSQmmcTKnTCHZaO+5CAP7rPynbB5sOM8oiMm3MOsSnuLgA4UV2kDx7fPlY8G8U/zwZUV4Du4SLvIAYyPc1e8Z4tjKECmRlAuKYN15iGcDeF3saMRMRh7/9+iZ4+VZKMnweRNx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvBy/GlB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso2442495e87.2;
        Sun, 14 Apr 2024 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713163910; x=1713768710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgAxRM0uLhD0mOXJ7L1+6YMjRhV96ZGhjbSVbLLbg7k=;
        b=CvBy/GlBADVrmzVZdbn58S7Lq6li2afQwfW6wBRi/u2dk1D5/j3wHjsUMjZPFzHTlH
         4CQA8irmXdQHA83ttuFSE0q9qghPwtSN8x7A+cRQMyK+66319NBn1W4AXWRDkAH9IgK7
         DJMdR+fQZXyblZSrvCw/vmlgYl5yCekqldhyJ0q1y02mTWEPLcOfYu0hP1BKeisLDH9Z
         hoYJi/qd7XK63L6Ki9V6AjJLiwYkA6Mh5yFa80Ve4nNdxajGFV2SkoZNYJWe+lDmjOeV
         a7Mc9H5FbTgE+GGYsdbYgq3VLsPzpFwkTwNNdTT8gWKF4EbPvb0g6inRxjMSdxJEXdGL
         ex5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163910; x=1713768710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgAxRM0uLhD0mOXJ7L1+6YMjRhV96ZGhjbSVbLLbg7k=;
        b=f5TsDntztYBJXrOXKtZyyLWToaAcRv/6Tm9G7Ri8zIYe6gXJOgj4XGyjMN7xUR0Svx
         RcOhBeEw+NsyzzD1qz32nccu2nficjpSQw4UHupucC1Ht7ZrvU9dHZ7jptZFcKu8csYc
         sjO71qpLT8KvNUuWWmZ5IjbXjkLupRdOEJar7y5iI6KwNts5Kt3wGi9OKwMBWYFf1beB
         fH4rXPSO7tllei50NVL4j1zZGBFpAP1aNQD7K90X9k/NmMIoY1psuF+UDhVPRyAHMK7B
         l3AzebE2sqTTa3iXRMi9MHL8pNAkOb0iQPsZcl5ksYi+G54n5RbTfu8TBsnqZWKvgkAw
         W/LA==
X-Forwarded-Encrypted: i=1; AJvYcCWhC5LVuWpKsNugpnm4O5WB7Zl5EG11gHussfBVmopVAzjuChpu+Bc0ADxf7QKHEjR0AW47IpOyIyWA6qV9BNFg7vjKQOI5idoA3EaAiT7LZNRT0fxuBnyzOHn0jrfLHVd3ykMollc34DACLVQD5na/SHA9zFCrzeJcVdTRGkFpnxy+QKHHNBrk
X-Gm-Message-State: AOJu0YyA8ZRxBPIds2l3iY60D66gSXFZHkUrGFjWyk12zeWj+5NP13s7
	QvfrpxpU5vJbSZoHqhnEH+h/J8hyF7kp1EUrb0WQt2KBvpsRleQGut2uuQ==
X-Google-Smtp-Source: AGHT+IEX/Td2rDlkP352j14Yi4m1XJz1Sb6L5pS2w9sbBBYX+fOnL+xQ4qv0TRiJuKgNXJJVJB+j3w==
X-Received: by 2002:a19:5f44:0:b0:516:d232:2516 with SMTP id a4-20020a195f44000000b00516d2322516mr6333043lfj.6.1713163910316;
        Sun, 14 Apr 2024 23:51:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b0051585d5edb8sm608336lff.42.2024.04.14.23.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 23:51:50 -0700 (PDT)
Message-ID: <5994ff29-c916-4b5d-a634-8521e79e2417@gmail.com>
Date: Mon, 15 Apr 2024 09:51:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <27a1c489f62e46a80643fe86cca101fb5aadb7f4.1712920132.git.mazziesaccount@gmail.com>
 <72cf2a5d-55d2-4117-8b80-b3e517a7a9eb@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <72cf2a5d-55d2-4117-8b80-b3e517a7a9eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 00:27, Krzysztof Kozlowski wrote:
> On 12/04/2024 13:21, Matti Vaittinen wrote:
>> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
>> DT bindings for the BD96801 regulators.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> - No changes since RFCv1
> 
> Subject: missing "regulator" prefix, as first.
> 
>>
>>   .../regulator/rohm,bd96801-regulator.yaml     | 69 +++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>> new file mode 100644
>> index 000000000000..4015802a3d84
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/rohm,bd96801-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BD96801 Power Management Integrated Circuit regulators
>> +
>> +maintainers:
>> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>> +
>> +description: |
>> +  This module is part of the ROHM BD96801 MFD device. For more details
>> +  see Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml.
>> +
>> +  The regulator controller is represented as a sub-node of the PMIC node
>> +  on the device tree.
>> +
>> +  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
>> +  The valid names for BD96801 regulator nodes are
>> +  BUCK1, BUCK2, BUCK3, BUCK4, LDO5, LDO6, LDO7
>> +
>> +patternProperties:
>> +  "^LDO[5-7]$":
> 
> lowercase
> 
>> +    type: object
>> +    description:
>> +      Properties for single LDO regulator.
>> +    $ref: regulator.yaml#
> 
> Missing unevaluatedProperties: false
> 
>> +
>> +    properties:
>> +      regulator-name:
>> +        pattern: "^ldo[5-7]$"
>> +        description:
>> +          Name of the regulator. Should be "ldo5", ..., "ldo7"
> 
> Why do you enforce the name? The name should match board schematics, not
> regulator datasheet.

If my memory serves me right, the slightly peculiar thing with the 
regulator core is it does matching of the regulators based on the names 
of the nodes. There was the regulator-compatible property, but I think 
it has been deprecated long ago.

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/of_regulator.c#L380

Hence the regulators tend to have fixed names for the nodes. Unless 
there has been some recent changes I am not aware of...

>> +      rohm,initial-voltage-microvolt:
>> +        description:
>> +          Initial voltage for regulator. Voltage can be tuned +/-150 mV from
>> +          this value. NOTE, This can be modified via I2C only when PMIC is in
>> +          STBY state.
>> +        minimum: 300000
>> +        maximum: 3300000
> 
> Hm, regulator min/max microvolts properties don't work for you? The
> initial will be just middle?

I had not even thought of this!

I think this is a good idea. The problem I see is if the system where 
the PMIC is used will need to have 'initial power level' at start-up, 
which is near the one end of the allowed voltage area. (This because the 
"tuning"-range is quite narrow after the initial voltage is set). Wide 
allowed voltage range may be needed if the PMIC is reconfigured using 
the PMIC STBY state during the runtime.

Eg, sequence would look like:

Bootup:
PMIC STBY:
  - initial value 'A' from DT
=> PMIC ACTIVE
  - desired (early) voltages 'A' + 'tune'

..

Voltage state differing more than the 'tune' needed due to some runtime 
use-case:
=> PMIC STBY
  - initial value 'B'
=> PMIC ACTIVE
  - desired voltages 'B' + 'tune'

Now, if the 'A' can be 'far' from the mid point of the 'allowed 
voltages' -range.

I have no idea how valid this use-case is though. Once again, I work for 
a component vendor and don't get to see the forest from the trees... But 
sure I would like to enable as many possible use-cases as, well, possible :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


