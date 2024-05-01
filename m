Return-Path: <linux-kernel+bounces-165131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166618B886E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3986D1C2166B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CA52F62;
	Wed,  1 May 2024 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBVBpF5r"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0921105;
	Wed,  1 May 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558569; cv=none; b=mc0GuhKCKF7B9eBTvKIpK0ltO2i7iAZh6K/oxymIpuDeP+8SStlu5GZR2rCiaj4xN/lUji4k2GNei2Ck3uiblGIeGYNcwnd4OKtTtLrsv2E3Qn/521YTMQ47A6lTteDT0hWsD0Vl6M3oQcPG6eLv2xCRXw7cnNwgCy5MzulsmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558569; c=relaxed/simple;
	bh=2YKLdXKY3WYabgWofiZ7LNwtEK96aii1tW1EhuvDOO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw5nSO6d8Lnz9O98dbkviZ9N4XuQOjzNxjbJw9PHRcxFxI8frsKfTn9oq0uB+y/hlycGHOigdz8MSABtA8pD2dD0gQRRwGCQmU5l+f9F50vRc88CVZhgg/C70nHVZ5j5jzZ8tQJmScMwUbOu8pFdIPAvtV8TO4ISmR9e/iAW/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBVBpF5r; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e0a2870bceso38405761fa.2;
        Wed, 01 May 2024 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714558566; x=1715163366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq7RbNXKOWdUKotBojJD+6fzMsL1fuWr60IdHQIDfm8=;
        b=SBVBpF5rXPJolfHruIySGI9dfFx7+yZDVW45YdXyAGkFnBEZAe38Ul0hEkecjEAKrd
         DbPLq2kdV6iTu2ZdMOhb46/2B3WbB+Lr78EI2g+jic+P0kDaxEW+rcQ5aOrOELIwrkOJ
         WXAFwPtIm6oI7o9/Ppm/JPzlJ+gRlXPO5sAK+DB3Beo8uINhao9R3PZ9SMaJqgaqUfIn
         e3PdJL4uknvqdR02GzDWvDDE9ExZUPin+IJt5vKQlZz3rHNN53zfttJWhb7sr7lTOQqe
         vm6ssxvYLj9+jMp+7DHHlRvFfYnc4C9d3owVqQwiFik0dkB4LELvIDwTAcfjyC3pIs5+
         s0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558566; x=1715163366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq7RbNXKOWdUKotBojJD+6fzMsL1fuWr60IdHQIDfm8=;
        b=ap3TgshqAfissEkcYFq0uPYPsIJ/4/u7OD9I+Klgow0ttrf+Ngl3rkJZ77l1UrbLC3
         fULVIAIi7PxFxxS+k/Wq1kIJIuZctF6WAqXq5OGBWruJuYIMxubkT9sn+qPRV1PvcYL7
         G18nmZr7E4B0chJ7GWshRYksezWHxpQwYGSHFJDHiOVlQjQAkQPXvX0tJk+giGdioI2M
         FcHbNw/dWGb3lKCZa+K5Dc91k0IKWs4ymmeRqSxQCMjz+SX8MY0hZihy0BYlbjEhZj5X
         WyGjYvCPi9iihtdMxzZgJ30xuLKQP3R0JoJMpvhyimn8E2bmI804Bwocta1IKrKzqAjD
         +3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWbnL207RweVhP+npSU69/leHMspjtYcJ8n24zi8m16YVbU+7+gOi0XkTtrouG13Yz4YYCD/8fzrnEXkV8FY+hoDx9LJeawzIRP4h+u8mfSfWgWztMAbIiITp3irZRdt1o2Lr/y4QnEEj9QZnbzHKiHSKMjneSG+AcZRMDsmwJyZfVQkkJFPk8A
X-Gm-Message-State: AOJu0YzoJWmrts7I+OWH4zpIm9qyXB1trHlFISAwp4xxwXeCB2i8gWWM
	93wu6h23DMjHkPn8bBCM+gVq4S72LHr0EGIP+uZAFFr3MM9o4xcLtZI3Rw==
X-Google-Smtp-Source: AGHT+IGb7aZ8X/qy0j8MxuPK/sDUbn4cCpe4qJrZbrnt97eokHmgXm19euaUtbve2oEfFsjAExhutw==
X-Received: by 2002:ac2:4439:0:b0:518:91fd:b343 with SMTP id w25-20020ac24439000000b0051891fdb343mr1139617lfl.68.1714558565355;
        Wed, 01 May 2024 03:16:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id y23-20020a196417000000b0051c3aea9c3csm2393209lfb.211.2024.05.01.03.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:16:04 -0700 (PDT)
Message-ID: <86677a82-e91f-45de-89c5-66c1cd82897d@gmail.com>
Date: Wed, 1 May 2024 13:16:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Content-Language: en-US, en-GB
To: Guenter Roeck <linux@roeck-us.net>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <d1d5429e4a34a06af0ceb853d72344cf9b8ae67c.1714478142.git.mazziesaccount@gmail.com>
 <b4c67e76-fad8-47bc-a9f8-29cc5630bc7b@roeck-us.net>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b4c67e76-fad8-47bc-a9f8-29cc5630bc7b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guenter,

Thanks again for the review :) I agree with all of your comments, thanks!

On 4/30/24 19:24, Guenter Roeck wrote:
> On 4/30/24 05:01, Matti Vaittinen wrote:
>> Introduce driver for WDG block on ROHM BD96801 scalable PMIC.
>>
>> This driver only supports watchdog with I2C feeding and delayed
>> response detection. Whether the watchdog toggles PRSTB pin or
>> just causes an interrupt can be configured via device-tree.
>>
>> The BD96801 PMIC HW supports also window watchdog (too early
>> feeding detection) and Q&A mode. These are not supported by
>> this driver.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>> RFCv2 => v1:
>> - Fix watchdog time-outs to match DS4
>> - Fix target timeout overflow
>> - Improve dbg prints
>>
>> RFCv1 => RFCv2:
>> - remove always running
>> - add IRQ handling
>> - call emergency_restart()
>> - drop MODULE_ALIAS and add MODULE_DEVICE_TABLE
>> ---

..

>> +
>> +static int bd96801_set_wdt_mode(struct wdtbd96801 *w, unsigned int 
>> hw_margin,
>> +                   unsigned int hw_margin_min)
>> +{
>> +    int fastng, slowng, type, ret, reg, mask;
>> +    struct device *dev = w->dev;
>> +
>> +    /*
>> +     * Convert to 100uS to guarantee reasonable timeouts fit in
>> +     * 32bit maintaining also a decent accuracy.
>> +     */
>> +    hw_margin *= 10;
>> +    hw_margin_min *= 10;
>> +
>> +    if (hw_margin_min) {
>> +        unsigned int min;
>> +
>> +        type = BD96801_WD_TYPE_WIN;
>> +        dev_dbg(dev, "Setting type WINDOW 0x%x\n", type);
>> +        ret = find_closest_fast(hw_margin_min, &fastng, &min);
>> +        if (ret) {
>> +            dev_err(dev, "bad WDT window for fast timeout\n");
>> +            return ret;
>> +        }
>> +
>> +        ret = find_closest_slow_by_fast(min, &hw_margin, &slowng);
>> +        if (ret) {
>> +            dev_err(dev, "bad WDT window\n");
>> +            return ret;
>> +        }
>> +        w->wdt.min_hw_heartbeat_ms = min / 10;
>> +    } else {
>> +        type = BD96801_WD_TYPE_SLOW;
>> +        dev_dbg(dev, "Setting type SLOW 0x%x\n", type);
>> +        ret = find_closest_slow(&hw_margin, &slowng, &fastng);
>> +        if (ret) {
>> +            dev_err(dev, "bad WDT window\n");
> 
> What is the value of those error messages ? To me they only leave big
> question marks. One would see "bad WDT window" or "bad WDT window for
> fast timeout" and then what ? If the cause is bad values for hw_margin
> and/or hw_margin_min, the message should include the offending values
> and not leave the user in the dark.

Well, at least one can grep the error from module which printed it :) 
But yes, you have a very valid point. I will see how to improve, thanks!

> 
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    w->wdt.max_hw_heartbeat_ms = hw_margin / 10;
>> +
>> +    fastng <<= ffs(BD96801_WD_TMO_SHORT_MASK) - 1;
> 
> Any reason fore not using standard functionality such as FIELD_PREP here ?

A reason, yes. A good reason, no :) Reason is that I wrote this before I 
learned about the FIELD_PREP() and FIELD_GET(). And actually, I have 
always found those two more confusing than the open-coded shift, '|' and 
'&'. Still, I believe the FIELD_GET() and FIELD_PREP() make it obvious 
for a reader that the bit magic is just a standard register field stuff.

So, no good reason. I'll fix this for the next version.

..

>> +extern void emergency_restart(void);
> 
> No. include linux/reboot.h instead.

Hmm.. I am sure I had checked the headers for prototypes before doing 
something like this... I think I must've missed something. I'll fix this 
for the next version, or add a good explanation if there indeed was some 
problem finding the prototype.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


