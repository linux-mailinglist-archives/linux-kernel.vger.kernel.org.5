Return-Path: <linux-kernel+bounces-106772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C2587F354
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA548B2175A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AAF5B210;
	Mon, 18 Mar 2024 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GBWUvXzh"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C825A0E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802124; cv=none; b=nQCAqvzS0xUcoRl+sLhV/Ch/vKbNP16iQfLR14WCNS2X2ps6rQfXO4Rn/ImzNf4aDt7CC5/4/30Qd9q+tqej/08LNUHmfO5agpEKp/nuBhCB1Gxa73T5uMf1fbgtar8BCiRIJ4H98upZYe17zYnZ4EUVW+ie+/ACVbOM5J9b2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802124; c=relaxed/simple;
	bh=jlF9kBQ6rKq2W2ELdfqYYMhpQURF2D8NP/Wqm50zMWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad/lKLrULtOXwGQPw/WJnV1/5bcp/SzPqRyrUtGTOvOjj0NdDc1EOVGMJetTY0x0so8FUU1qc3TieQ75LVOElJVJF7Vv042ThiPdqVabr+lRL0UM0CtHP1xplOX1nnSdcZi7Pz6j/GCTIHDJVExQWw859ZSycsSkVlEn0bmc5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GBWUvXzh; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a128e202b6so1879091eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710802121; x=1711406921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jludn2bAG9CDnI255xg3vJq/imDA0vVQLTyCX+Hp1+Q=;
        b=GBWUvXzhsEzAmbmxb0ZZFs6l4AiWvRmH6JOk9OmE9aswQF3gbBrsX/srmz2o3LLi6n
         Zx6OvrJzB0HxM3Q7onHVGKU7eZpYbeiiUh51vPBcB7lQcv+a6lr2Zj2to8LEB/ic/6S/
         YuEtDOwE7icAM+zwbBzfIsJS4WK+ybNF7q2S7HZ01rrIh9AyxSXqiAIVX4Fuz0G8m9aV
         +mkQOZqUSlaciAARWc+fotNBH+QwG/3iCtn0ttkNFadg3JNjQc87Q+B9AnH3RwUrd8DU
         GGuHuzJSxxZ+8kcKZRxaPCRwZnUcQhoi2OkLoS/lX2BQA9RoFwlmZq8iFBSkwV/wgG+t
         oq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802121; x=1711406921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jludn2bAG9CDnI255xg3vJq/imDA0vVQLTyCX+Hp1+Q=;
        b=o6wOau8DUAke7yhlYIplm/AoVB9xP6LlPtdVRPcLio4f0kpGNm9ouUIAzX4PLvAv2e
         9D4XYo2ohsWDikfA7sCn3a4HGMgzEWAjQD89JIL090zyN7zG37UMFMSKzp6ToIUBgLG/
         J+mLjHKdHLZ4r7G1W6QPQnGb2Uv1EAwFv3SlF66R+ngamz6aY9I954snNwewmcr08QkK
         0YaCfBk3turG+rUJLV9JVcJfjk0mgunSLO70uVD0CHvWNugvod2UVFQmIG3L7R71Pkax
         /193qD5ET4TcpcsumgU13JMR/LGcoNgJe5VMK4yjoi3BIWg8gWoEsVJPDrsLXvhUeujS
         FSIg==
X-Forwarded-Encrypted: i=1; AJvYcCVdpGJaoByHovX9X+p3DY90eEW/T+3HQQDcdNMSzgs3cc/lNnhePApMDGtM/1/Z6VjKk0irbeL1lkJoJdF8GBRu/r6jgl6g7pkNyVYP
X-Gm-Message-State: AOJu0Yzlvdz6o9EcXwhKjViR6zHjdPxWdTar0Sx6MuZ2rk0RjUkfSlyu
	9WKP2pGSTHRAoR+AJ2NUujxYZ0VxvazIchvX/qGGJ5W3pHTe1NaybwAwhJlXcNGb1TMLugbiG69
	L
X-Google-Smtp-Source: AGHT+IG572b8WoUMjTLxCmZp49k013fssGeR3JqL53yuQr8mSPQRGKSXWXK2Ezesr51EW2P/66YSPA==
X-Received: by 2002:a05:6820:213:b0:5a1:6cb9:d6f0 with SMTP id bw19-20020a056820021300b005a16cb9d6f0mr1014886oob.1.1710802120822;
        Mon, 18 Mar 2024 15:48:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056820248c00b005a11d6d9accsm48094oob.16.2024.03.18.15.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 15:48:40 -0700 (PDT)
Message-ID: <3eeda38b-0bfa-4b46-8088-303f78b5f340@baylibre.com>
Date: Mon, 18 Mar 2024 17:48:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7944: simplify adi,spi-mode property parsing
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com>
 <CAHp75VfKZy45RVJmAAOEPyUFTW7MhxJmOeQHj3YV7p-NPKpkvg@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VfKZy45RVJmAAOEPyUFTW7MhxJmOeQHj3YV7p-NPKpkvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/18/24 5:43 PM, Andy Shevchenko wrote:
> On Mon, Mar 18, 2024 at 11:57 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> This simplifies the adi,spi-mode property parsing by using
>> device_property_match_property_string() instead of two separate
>> functions. Also, the error return value is now more informative
>> in cases where there was problem parsing the property.
> 
> a problem
> 
> ...
> 
>> +       ret = device_property_match_property_string(dev, "adi,spi-mode",
>> +                                                   ad7944_spi_modes,
>> +                                                   ARRAY_SIZE(ad7944_spi_modes));
>> +       if (ret < 0) {
>>                 /* absence of adi,spi-mode property means default mode */
>> -               adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
>> +               if (ret == -EINVAL)
>> +                       adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
>> +               else
>> +                       return dev_err_probe(dev, ret,
>> +                                            "getting adi,spi-mode property failed\n");
> 
> No need to have 'else'
> 
>                if (ret != -EINVAL)
>                        return dev_err_probe(dev, ret, "getting
> adi,spi-mode property failed\n");
> 
>                /* absence of adi,spi-mode property means default mode */
>                adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> 
>> +       } else {
>> +               adc->spi_mode = ret;
>>         }
> 

I agree it is better that way. Will send a v2.

