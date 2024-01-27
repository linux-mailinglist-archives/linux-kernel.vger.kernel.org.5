Return-Path: <linux-kernel+bounces-41043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2DB83EAAA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9170DB21BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051C1173E;
	Sat, 27 Jan 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bc7Sxgsr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E01170A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327070; cv=none; b=I7sdZZzWDId7Se79syw0xFvi2OHVneZ8oLGKzqjNvq8TM5/VsJru3a5ADywKbFeHm7GSP1mjvwWjTPvTgoNpigRQix/syuo6ahc5fyDyAgO8lczWabZXv8otAVG1xwb8brKvYfAISpQ8ZKWD2ao8ko5zqnrgmGj0/SFWcEqwuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327070; c=relaxed/simple;
	bh=7hT3+dI5V/0o0Qr0KNiAl1/GrwBe4JNpldb7NWGpaus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOSHv8Z3RYG/xaBfv0x5yN5LptIYl+L03x+9JtPBcLRWRofpMQoNg7WqTu71eyHdOQ9LT9SaYEKCyz9cN6fC1hghy7ALsuUbVCOM97zV6dEAUS4nV1Kt9PmA8eA6oeTqiXFCI6NwZ64E8ZMIhBYqicQRP7GFcWON1kemtWQoWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bc7Sxgsr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so508995a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706327067; x=1706931867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeyDcxP6HezAwDjv69G6j/rFie9KDKnEIL+n0uKd+54=;
        b=Bc7Sxgsrn8PnTTwnrEOqbV1M7XomLilzpb9HFGa1eFhMXafAMfcB7sDBcklfemqePF
         kXDKIdOl/UAgKPJXX1QMmUUPG4XDyBzaIxCuiytUQOCbMmVac9E4tyNPgeZDs/4WD+b4
         K4colMLr+v4oCt+QKkQH2Ub9DPA7Zdf5uiLF7zl5mSlG4JCbFWv7/imAAr6C6D45z54o
         Jq6hd9XUh6LCFBMZN5TDL7N9TUdpowquZWv9DDBktLP5CHQH+ov0bGZpbP+SGuDu3OZ+
         7CUUtk5EbZdQJuOp143/QTmN7qkhYGFNBnXksii0+TH7pyn7EstjsLnJJE/pO1WnstHv
         TSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706327067; x=1706931867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeyDcxP6HezAwDjv69G6j/rFie9KDKnEIL+n0uKd+54=;
        b=A3+0uPzXW/J+oPnLYv/4Va2PckXd/YbEPW20vkIqbNsKpMg1Bw4Agv1liGQogs8hkd
         w5Ho9Wvl6TnHQuaRw9m4t06vb2tL+5Rv9GhL3uChx/xsFf7rUd97pvEsljQuwUY25wjK
         JThrTOEQPDTpZSirdspTwU89GA4lgQN7G8hU6/7WBo6eb8Wu2xwgj2E55GiTYjR0nEjo
         eyPpdisUjZ5BpoISV3Zuhc5HTLYY/neUrZJyllowCMidxBBLbZg3+BSJ++S9r9m2UTrI
         7sKhdUo/H35DT0q9Kusv1h7FEmbmPA4Be0ohm589l/sbfdQkAcmdEWJl4dTHpFaz7NCm
         dAEg==
X-Gm-Message-State: AOJu0YzYrxe5chMj7bC5zU0RL3VqQwIuFkLNJSNydScsyISqZ05G9Eqm
	X6nglofOAFUBbrHujDTYr0rr03DvXPPDQdBXndo6stZQ7Eaz4qj4iS6P4M/zpD0=
X-Google-Smtp-Source: AGHT+IEqEpvJIp0hz18eU80/3j5GvnMIeJRDqKNwNDOPA41ttbS9nchooX1lMIHwAbWkeNZsKpsEeA==
X-Received: by 2002:aa7:d7cf:0:b0:55d:2bea:a858 with SMTP id e15-20020aa7d7cf000000b0055d2beaa858mr247114eds.41.1706327067034;
        Fri, 26 Jan 2024 19:44:27 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id y65-20020a50bb47000000b0055ebc7066e8sm17699ede.88.2024.01.26.19.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 19:44:26 -0800 (PST)
Message-ID: <facbcbf3-7dba-43a1-b4fe-ac77b5bef545@linaro.org>
Date: Sat, 27 Jan 2024 03:44:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 jassi.brar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-18-tudor.ambarus@linaro.org>
 <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
 <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
 <CAPLW+4nN--gG9XsOu6a-mo5vcM-GycRrhPQFOtNidfVTM=KonQ@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4nN--gG9XsOu6a-mo5vcM-GycRrhPQFOtNidfVTM=KonQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/24 03:38, Sam Protsenko wrote:
>>>> -               val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
>>>> -               val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
>>>> +               val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
>>>> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
>>>> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
>>>> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
>>> Two people complained it makes the code harder to read. Yet it's not
>>> addressed in v3. Please see my comments for your previous submission
>>> explaining what can be done, and also Andi's comment on that matter.
>> I kept these intentionally. Please read my reply on that matter or the
>> cover letter to this patch set.
>>
> I read it. But still don't like it 🙂 I'm sure it's possible to do
> this modification, but at the same time keep the code clean an easy to
> read. The code above -- I don't like at all, sorry. It was much better
> before this patch, IMHO.

Yeah, I guess Mark will tip the scale.

Cheers,
ta

