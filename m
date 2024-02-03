Return-Path: <linux-kernel+bounces-51019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73584851B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C43286486
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E44F1E0;
	Sat,  3 Feb 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5m0WFvI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0933994;
	Sat,  3 Feb 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706954773; cv=none; b=pum1k/0DaTAYvl5agpaoGZCNWzgQETIX5dBkm/UofwovEaKpXJjlY9RZx4kHWpLDXNfNToxFUTACsDaw/U/Ve9RlHKxTm7u5SQiZ/O2vG7V2o5cYbNrl4Z/6v4rfvjOl2fLSd/Yfi6kaeimg+D2Ti8SgpK7Se4y/+G4oKejj0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706954773; c=relaxed/simple;
	bh=oPAEzF8CDVOYqn3t/t5uf+dZKZLWv+Oe87OeIfHZ+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWz2CfzE2/kfB1/dp5ku74NQKhyr4O+6IZTnvcQD67YK7Weha+rRq6Kc+o/8KKN/6kFbTmkbPeMYIFtIzgNHMNTPvx/Ng6rrXnLjjboePK133bIMP6vJ63f4t/Y3beGVcYLiMg0ds7zJCnS3fkoG2R7ZEV3DrgY6XtWj7Cdn/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5m0WFvI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a35b32bd055so365012066b.2;
        Sat, 03 Feb 2024 02:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706954765; x=1707559565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73qJzyiTI8VZIPgsa6gzzVGbxNV07sdBPIz48dmfQNw=;
        b=O5m0WFvIVOtC7PImDgi9sO/4Wn84as6p+uXhTqrf8dXJf2gNjv5oysId2I90Ps2367
         ihL8qQRKQeyM1xWHm46RdOUwy/aVTv+6m9tE/v++VXhp9LmKJ1/uRqpbBWIMS1ttO3Jv
         rZlQIieQjAKLaAij1MB6VaI4O/ilI9wvBtH2Dy6k/Pwbl4uetCD8b/1NvyaTido/SYQU
         Mdpx5pP3/xDn0oKfe3NPgnFiJZXPXjH0kWw2rUQopgDXQNv942l4ZZItJRcQOW1DrhJW
         00TRYZn5//ha0y/8oZh4iHMPOquOiH67Ne30cA0SfDpNjlKA9827hpNmI1zi5BSAlfco
         5mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706954765; x=1707559565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73qJzyiTI8VZIPgsa6gzzVGbxNV07sdBPIz48dmfQNw=;
        b=PKmitJZo7s0O7zsHaaouWhjMCLMJnob0q8I3hG60cVg6zFklkeRoUyFSH5D2q+rFtf
         fDNuW5Qa0oKWP2FDw+nH9jq7OYGLigNXwkffMXI0vwazjpzbWhlmyuF4wfU3oaUh2FhI
         qzwlgm1Z8dhvcccWvLTOeLbnc6n2U2RtLqRKrtdCt2HBojCYYWHfq/1CViTUMuhp5wou
         usFhFB9qzMz516ow99hjsKac+p5QW8e+BW9Yk9Db7erlmw9nHcsNTcPtykwZHznp4j31
         zbolL/LDz3fL2HD7vv0h+dPuMLAtM4QbZa0IqONm8MQlZtAeQCPkqJsMFCEpCDxn+jT7
         GVZQ==
X-Gm-Message-State: AOJu0Yy3w1wdxLTibMHcUXvtiNOO01MtCAm5DCdzCUGggqTTjjP5KscS
	CzXBs39vyuixwOSwSXUaLDYAFrfC4yNISgdFPt2Fns5r0CApYvT0
X-Google-Smtp-Source: AGHT+IHSe2XBq1Y07e+IOL79Dj/DZM03rpIk5JetATiVqzXwcy3kyXwBAO9ASVa3YUwkG3hU3nHdqQ==
X-Received: by 2002:a17:906:43:b0:a35:becf:4320 with SMTP id 3-20020a170906004300b00a35becf4320mr3141355ejg.29.1706954764746;
        Sat, 03 Feb 2024 02:06:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWS0xGpvC/3SrRPsL4T01FfPenSRi8haKAWV3n7bK7tAIKX4ZdBWlDEuLUJDf9uq1PnkNzcUgoWz4EMC4KbH2qKvmt8BtKiSA0IxnzOx69nS/isYtG56oCbJITR906hy1VWi4dqaTrdc/xmVhUIKckOSVKgqlxIOlzQa4oXO3X7V3WfHCvk1LD68MJIzs9/WfH75g7XU6OnboaTeB+bE4Mfqw==
Received: from ?IPV6:2a02:8389:41cf:e200:62e5:c423:15b3:7608? (2a02-8389-41cf-e200-62e5-c423-15b3-7608.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:62e5:c423:15b3:7608])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709061c4800b00a372b8ac53fsm1029668ejg.169.2024.02.03.02.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 02:06:04 -0800 (PST)
Message-ID: <b789eb01-5b5d-4513-88d2-1f14e95969d9@gmail.com>
Date: Sat, 3 Feb 2024 11:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dima.fedrau@gmail.com
Cc: 579lpy@gmail.com, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.02.24 10:58, Christophe JAILLET wrote:
> Le 03/02/2024 à 10:05, Dimitri Fedrau a écrit :
>> Add threshold events support for temperature and relative humidity. To
>> enable them the higher and lower threshold registers must be programmed
>> and the higher threshold must be greater then or equal to the lower
>> threshold. Otherwise the event is disabled. Invalid hysteresis values
>> are ignored by the device. There is no further configuration possible.
>>
>> Tested by setting thresholds/hysteresis and turning the heater on/off.
>> Used iio_event_monitor in tools/iio to catch events while constantly
>> displaying temperature and humidity values.
>> Threshold and hysteresis values are cached in the driver, used i2c-tools
>> to read the threshold and hysteresis values from the device and make
>> sure cached values are consistent to values written to the device.
>>
>> Based on Fix:
>> a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
>> fixes-togreg
>>
>> Signed-off-by: Dimitri Fedrau
>> <dima.fedrau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/iio/humidity/hdc3020.c | 339 +++++++++++++++++++++++++++++++++
>>   1 file changed, 339 insertions(+)

..

>> +    guard(mutex)(&data->lock);
>> +    switch (chan->type) {
>> +    case IIO_TEMP:
>> +        /*
>> +         * Store truncated temperature threshold into 9 LSBs while
>> +         * keeping the old humidity threshold in the 7 MSBs.
>> +         */
>> +        val = (((val + 45) * 65535 / 175) >> HDC3020_THRESH_TEMP_SHIFT);
> 
> Why 175?
> If the span is -40/+120, I guess it should be 160 and if it is -45/+120,
> 165. No?
> 
> Maybe something like:
>   #define MIN_TEMP -45 (or -40)
>   #define MAX_TEMP 120
> in order to avoid hard coded constant?
> 

the 45 and 175 values come from the conversion formula provided in the
datasheet (page 13), even though the sensor range is from –40°C to 125°C.

>> +        val &= HDC3020_THRESH_TEMP_MASK;
>> +        val |= (*thresh & HDC3020_THRESH_HUM_MASK);
>> +        break;
>> +    case IIO_HUMIDITYRELATIVE:
>> +        /*
>> +         * Store truncated humidity threshold into 7 MSBs while
>> +         * keeping the old temperature threshold in the 9 LSBs.
>> +         */
>> +        val = ((val * 65535 / 100) & HDC3020_THRESH_HUM_MASK);
>> +        val |= (*thresh & HDC3020_THRESH_TEMP_MASK);
>> +        break;
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    put_unaligned_be16(val, &buf[2]);
>> +    buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
>> +    ret = hdc3020_write_bytes(data, buf, 5);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Update threshold */
>> +    *thresh = val;
>> +
>> +    return 0;
>> +}
> 
> CJ
> 

Best regards,
Javier Carrasco

