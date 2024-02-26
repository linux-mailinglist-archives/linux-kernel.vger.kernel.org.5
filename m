Return-Path: <linux-kernel+bounces-80683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD21866B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05B01C22327
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62D2D056;
	Mon, 26 Feb 2024 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3ENP322"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3B2D048;
	Mon, 26 Feb 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933128; cv=none; b=HE7LczsbgZergtUWzfvyLQMCIe/c2L+FDwUOT4QmNBrmucqDp18LTPctHYQbd0fJfWFitKYAqu/bfD1IApZIsejKTIl8hdcf7AkOYbcs9IC/Hvbd0HpZglVOWEZ7eRuPJEuvSi/F4JjaQcugbABXINSfPA4qhqEtKC+Yu6lXb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933128; c=relaxed/simple;
	bh=1ggclRD1djvxmGmT8E2XQWUaxTLSJFfuYRhMG5jSVS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNAP4woBkRB8NMsmgCtAesod7t0Y2aKQAx7hpt57W8g8HPaFfriXVplkRvb3GsoWJE6uipzWKKTLLM2++4bL7r9bGX02sep12wJD1yPzfNtBCj64yItRTpN8ozrr+f8rb5jmyG1LFkdc2DmGQB9VOkJJGf8ChQPSBn+0W8PUhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3ENP322; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412a87d5666so569205e9.3;
        Sun, 25 Feb 2024 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708933124; x=1709537924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZmcmpNn19gMD5RLlKzvJyidK9zbXyq1tNlIBH8kQTY=;
        b=X3ENP322A/eunHqmddmeX8FAO5bvWXnK5Z8SLOzXlSRU6Z3AamdWUFZWX6i1i0i2QD
         JtU1JslYUx0yyDux25ngIlYz10m/a72XQQhGj1Ju5Wuk5RplfGw7xoJ1j9ez4Hd43wMX
         8r1FwXXTmQYKVxd6HtK9J3MbllKvOYsSwZAjjo2HEDbTPR/41AYEyvK3/IIH4wHttoxO
         hHWapboEa1mELtEtB5YhWueuqtjDlMddR543x7+tICS7uQgStf+NAzHKxLKP60x1j7y3
         SHaKYu/Kfv7cJVzeBVimTHp4ML8C9TSsu3P5bgp6rFMAjBkFGD7VsGv7k/+U4w/ZbMms
         9T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933124; x=1709537924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZmcmpNn19gMD5RLlKzvJyidK9zbXyq1tNlIBH8kQTY=;
        b=e86d+dEEKCcWsT8FnFs6jFmFY6pmxVcIDRe3qeIIuDiQ+yFi3kAHad6MJD5bYcoTeQ
         FmkE7G+AZru/A/m7OCJDVnADUyLIvFlOCNh+9xn8DHaTsMiBSQBMmAZeudynZUS1IIGH
         OZopEFGOgxxrBv4/y2UgQtj+toI404PNYcd6s9jNQmcMvfCxwoEwdfZxF0el/F5zqhhP
         sziaghMxgR9i68Y913VF28gmIwDX5rEKPMLpsewZCu9yoStgMr9Aeo81CxyMd0OT2Fnx
         AYRG2ET3M3MKhyyNQQx8Oekh0CsJchigSUdNw1LGylwcAycCLSLq/7L1SzFSx7jtqSs+
         jmlw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQun1KEX9zZJA9umbwiHrHcQYVkCKjDcUv07MpuH8M+qG3Qrb2DhQgJqwbtbwsQnjOcpeQqe5w3fDWjULrXJD6yob8QE5HoXD+BqSkNlfrxBb/5JYieZUd3aCf3RfoMXj8BCukCmjPA==
X-Gm-Message-State: AOJu0Ywe94zxEwXmrMHfV5XRTMnvyeabmLUUb2m2Yi3VPElRyxPf1G9d
	BKOndbcq3IHNOWky0mknWjqDxUBXdlMUP5ZH0TTBqgQp1AXoopWyBr/kdzD8
X-Google-Smtp-Source: AGHT+IGtZBJfgssesLpExwIgvHWKPnBv28kAeC96tIDQFsQtRDAuA0aWBGTSPSOx+Xug9zTSUtfAVQ==
X-Received: by 2002:a5d:5b85:0:b0:33d:87e9:5900 with SMTP id df5-20020a5d5b85000000b0033d87e95900mr4089815wrb.62.1708933124367;
        Sun, 25 Feb 2024 23:38:44 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id bh3-20020a05600005c300b0033d640c8942sm7599142wrb.10.2024.02.25.23.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:38:44 -0800 (PST)
Message-ID: <4a1504d4-6c64-4385-bb52-43d39a017215@gmail.com>
Date: Mon, 26 Feb 2024 08:38:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: convert st,asc to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240225100336.34122-1-rgallaispou@gmail.com>
 <174b85c4-107b-44ea-af81-4564101aa5ec@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <174b85c4-107b-44ea-af81-4564101aa5ec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,


Le 25/02/2024 à 16:42, Krzysztof Kozlowski a écrit :
> On 25/02/2024 11:03, Raphael Gallais-Pou wrote:
>> Converts st,asc binding to DT schema format and update example.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   .../devicetree/bindings/serial/st,asc.yaml    | 57 +++++++++++++++++++
>>   .../devicetree/bindings/serial/st-asc.txt     | 18 ------
>>   2 files changed, 57 insertions(+), 18 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/serial/st,asc.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/serial/st-asc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/st,asc.yaml b/Documentation/devicetree/bindings/serial/st,asc.yaml
>> new file mode 100644
>> index 000000000000..b26e1d247346
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/st,asc.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/st,asc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STi SoCs Serial Port
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +
>> +allOf:
>> +  - $ref: serial.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: st,asc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
> 
> This wasn't here before and your commit msg does not explain it.

Looking at the device-tree I found that every instance of this device 
refers to a phandle of a clock.

Moreover in the driver of the device, the probe fails if it does not 
find a clock, hence this addition.

cf. drivers/tty/serial/st-asc.c:701
> 
>> +
>> +  uart-has-rtscts: true
> 
> Drop, not needed.

Ack
> 
>> +
>> +  st,hw-flow-ctrl:
>> +    description: When set, enable hardware flow control.
>> +    type: boolean
>> +
>> +  st,force-m1:
>> +    description: When set, force asc to be in Mode-1. This is recommended for
>> +      high bit rates above 19.2K.
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
> 
> Also something new.

This is linked to the addition above.

If you agree with this change I will send a v2 explaining this.

Regards,
Raphaël
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 

