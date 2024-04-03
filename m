Return-Path: <linux-kernel+bounces-129458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B855A896B16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD221C25B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EA1350CF;
	Wed,  3 Apr 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4CHKIj/"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A716EB73;
	Wed,  3 Apr 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137989; cv=none; b=hdw8smOus0BlWfCV7muVKSiZ2j2lsH0p3q7hYOpucpmm10VpNInb7qfSwXAV/Ayih8QKLEg8C/f/lAQ5eum8TLZDpwbHw9FCphacLCUN6CCOmRLS2ku/mguEJTH3E/tOfbDGfDdYROI6qsX0IPtNwfwUI4hdgwlbQbajrMhg274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137989; c=relaxed/simple;
	bh=nVU7niFzDwvRHhsC91XdjmYYEnpugKgc/2s1l6flgyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUWwC30gYbIlMYkdlxyy9GinJkEGQanDb0FJsAHb4vtIA3b7yy9qKAJFuQ+NQlDMXgdgdolYcCQgJPmVLJfDdsJlUTOKL+IBDFCWW1TZ61NvvgYjcP/nTeTIYWYh9RybbZX6JQXpdd85B73s4xylSw22eQVLIzsANj31xMumV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4CHKIj/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430a25ed4e7so40794221cf.0;
        Wed, 03 Apr 2024 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712137986; x=1712742786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJEtfEgGOvZ4NQDXQ/7+cf0sv8jHi6x8Pc+R36zNRao=;
        b=c4CHKIj/od518Y8ZYB2C4XQMk0FWdxDsjraMHSwBn+JUvc+8Q3W4QP6a6w3DZ2a1JD
         1RFk0v/pF/N3wJB3+gzUZ/jNe+Z45I+Cl8iuqnZ813hex1UcicocpJRvJYoTC3TTGccO
         yyj/DNzjTWW3G/yQ2SeajsUMZsD8HDgUVz3dCURheeDeeKx+vZelMBs5CuRhrdDyd1+y
         V5OhgsTWH3LNiD3PBX6apfn7+j/mwig/H35Tyjdd0y8mx17KpdY00ALsE/UTuWsAE8Y/
         9ZoIKG9D+mCJp/ssUyLJ1wGbtTA0RGQRyeDHkXhnxiru758bF9J6J96HVxu/HOk6cSPP
         EiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137986; x=1712742786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJEtfEgGOvZ4NQDXQ/7+cf0sv8jHi6x8Pc+R36zNRao=;
        b=HPfA4y4/Ta7HXdkqhAHCRo0c2wDhGLPdF2lQx36tT+/zOcjv8PG0HjHel6PYDpz+xS
         /kheD+O2e6CMApyPpxzHPUaMas9140LqhemlT7E9LWV7ZCXt6vDpfzSbwS2YV/RLuWgz
         cr+SFZ/OFjF+iT10vgXpHnleBm7uysJwKdDWs4p1CvLu9Z1/IzUS7ZHrSPLLe7GtTvR/
         Gr7gkn/nc+8Ik6WUUHmqp6BXr8J2LTFNF9obrBxBaek98JBqdpcNo5GJWwJCSRIbHKvi
         BKq7cube8o7YdYWkFU/chDINjGWY7BjIpvbU4lwb5Fipu+uJ4tKq5xZsuOwKvHa+kG7j
         zsoA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrWhaUlyKRSgllM7HgpgKOVgjytzISzlXvBohkH95RqTwO1QCC/KmiRiQGI/Ho/X3FiqvaP47SceWNB6FZZoFDgDPROVAW3pz8I+nfFQ0q/b/g7c6Z2geiwqyIfGkl3nXFKA69kvt6m8QrLf17t5YdEboucdvQIHjdN4K43YKyiNKrg==
X-Gm-Message-State: AOJu0Yz/9xoXQtrflj9kxMAnCA+wXSkmNfGaWW5cozeYj3KlB+wIJRuP
	jIn8SdQ12p7lOGuQdWbioye/Dl6xgEAxiLCgJJze4ufBp+qiVJsa
X-Google-Smtp-Source: AGHT+IGk3Sphsu/CS6tCyXd5ivhB2YIIX7J+CLaAoaRbfEpzUhcezLUU4kLxt4hyV0KYHMfLxSDbcQ==
X-Received: by 2002:a05:622a:491:b0:431:7c36:7f86 with SMTP id p17-20020a05622a049100b004317c367f86mr17090861qtx.59.1712137986137;
        Wed, 03 Apr 2024 02:53:06 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id et16-20020a05622a4b1000b00430b385f721sm6385650qtb.15.2024.04.03.02.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 02:53:05 -0700 (PDT)
Message-ID: <c7c26d36-ab08-420c-b634-8eb6d9cee9b5@gmail.com>
Date: Wed, 3 Apr 2024 12:53:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 01/04/2024 22:45, David Lechner wrote:
> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>

..

>>  #define AD7175_2_ID                    0x0cd0
>>  #define AD7172_4_ID                    0x2050
>>  #define AD7173_ID                      0x30d0
>> +#define AD4111_ID                      0x30d0
>> +#define AD4112_ID                      0x30d0
>> +#define AD4114_ID                      0x30d0
> 
> It might make it a bit more obvious that not all chips have a unique
> ID if we rename AD7173_ID to AD7173_AD4111_AD4112_AD4114_ID rather
> than introducing multiple macros with the same value.
> 
> Or leave it as AD7173_ID to keep it short and add a comment where it
> is used with 411x chips in ad7173_device_info[].
> 

Sure

>> +#define AD4116_ID                      0x34d0
>> +#define AD4115_ID                      0x38d0
>>  #define AD7175_8_ID                    0x3cd0
>>  #define AD7177_ID                      0x4fd0
>>  #define AD7173_ID_MASK                 GENMASK(15, 4)

..

>>  struct ad7173_device_info {
>>         const unsigned int *sinc5_data_rates;
>>         unsigned int num_sinc5_data_rates;
>>         unsigned int odr_start_value;
>> +       unsigned int num_inputs_with_divider;
>>         unsigned int num_channels;
>>         unsigned int num_configs;
>>         unsigned int num_inputs;
> 
> Probably a good idea to change num_inputs to num_voltage_inputs so it
> isn't confused with the total number of inputs.
> 
> Similarly num_voltage_inputs_with_divider instead of num_inputs_with_divider.
> 
> Also could use a comment to make it clear if num_voltage_inputs
> includes num_voltage_inputs_with_divider or not. And that it doesn't
> include VINCOM.
> 

Alright for these 3 statements above.

> Probably also need some flag here to differentiate ADCINxx voltage
> inputs on AD4116.
> 

That is the purpose of num_inputs_with_divider. Mangled some changes
when splitting into individual patches. Will include in V2.
"
if (ain[1] == AD411X_VCOM_INPUT &&
		    ain[0] >= st->info->num_inputs_with_divider)
			return dev_err_probe(dev, -EINVAL,
		"VCOM must be paired with inputs having divider.\n");
"

..

>>
>> +static unsigned int ad4111_current_channel_config[] = {
>> +       [AD4111_CURRENT_IN0P_IN0N] = 0x1E8,
>> +       [AD4111_CURRENT_IN1P_IN1N] = 0x1C9,
>> +       [AD4111_CURRENT_IN2P_IN2N] = 0x1AA,
>> +       [AD4111_CURRENT_IN3P_IN3N] = 0x18B,
>> +};
> 
> As mentioned in the DT bindings review, it would make more sense to
> just use the datasheet numbers for the current input channels in the
> diff-channels DT property, then we don't need this lookup table.
>
Yet, the datasheet does not specify the numbers, just a single bitfield
for each pair. It is too much of a churn to need to decode that bitfield
into individual values when the user just wants to select a single pair.

..

>> +               case IIO_CURRENT:
>> +                       *val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
>> +                       *val /= AD4111_SHUNT_RESISTOR_OHM;
>> +                       *val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
> 
> Static analysis tools like to complain about using bool as int.
> Probably more clear to write it as (ch->cfg.bipolar ? 1 : 0) anyway.
> 
Maybe it does not apply here, but i followed this advice:

Andy Shevchenko V1 of AD7173 (named initially ad717x)
"
> +	return (bool)(value & mask);

This is weird. You have int which you get from bool, wouldn't be better
to use
!!(...) as other GPIO drivers do?

"


>> +               case IIO_CURRENT:
>>                         *val = -BIT(chan->scan_type.realbits - 1);
> 
> Expecting a special case here, at least when ADCIN15 is configured for
> pseudo-differential inputs.
> 

And what configuration would that be?
The only configurable part is the BI_UNIPOLARx bit in the channel
register, which is addressed here.

There seems to be a confusion similar to what we had with single-ended
channels. The ADC is differential. Pseudo-differential in this datasheet
just means that you wired a fixed voltage(higher than 0) to the negative
analog input.

 Which you can also do on the other inputs with a divider.

..

>> -               chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>> +               if (reg >= AD4111_CURRENT_CHAN_CUTOFF) {
>> +                       chan->type = IIO_CURRENT;
>> +                       chan->channel = ain[0];
>> +                       chan_st_priv->ain = ad4111_current_channel_config[ain[0]];
>> +               } else {
>> +                       chan->channel = ain[0];
>> +                       chan->channel2 = ain[1];
>> +                       chan->differential = true;
> 
> Expecting chan->differential = false when ADCIN15 is configured for
> pseudo-differential inputs.
> 
> Also, perhaps missed in previous reviews, I would expect
> chan->differential = false when channels are used as single-ended.
>
Why?
Also, how would one detect if you are using single-ended channels?

The ADC is still differential. Single ended is represented as connecting
AVSS(or another fixed voltage) and only letting the AIN+ input to fluctuate.

In the IIO framework the only difference this makes is in the naming of
the channel:
 voltage0-voltage1 vs just voltage0

All channels are differential. Pseudo differential: still differential.

