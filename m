Return-Path: <linux-kernel+bounces-109051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077218813FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FD1C22F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC44AEC9;
	Wed, 20 Mar 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Du4D/XRD"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FB3E46D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946797; cv=none; b=OiMEsKcrgMeKRvJ+aUJj41aFgiUY/gQqrcA9pXXDplxoZuenA8XTSBipoliv381FldkrYf+NuoX05ck6OdYW761tEvADA0i7jLrB7oZJDal4cJUexa6+qNkA4QOX6n0bJKEtz8OS8pdo6qQ72192TJbJ3xEVe3kjYaWmcC7+suY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946797; c=relaxed/simple;
	bh=f8Ql61R6HFww77P6kYzWw9QksZwLWDYVdIJJT/aYBV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxeMjoxNTJZv+2KwU4H5QOWoIrDz5SE+mFX7Ac9nmQEEBrc5xlvsx++iF3Oi09m5uI/srb8GwUsD1C5ieq6Bc9N9mr+msvhi4Si4EXUC52EBENH2+NG+oHgVP5Q/A3cr9Eq0sDTs95K68f3kUkzFq1XBgGhGxQVJ+aIQ97uSHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Du4D/XRD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8d2e0e9cfso147858439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710946793; x=1711551593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uu3XrTQnPclK188rbkolek/Ountn/o+HfDpmNTirMmE=;
        b=Du4D/XRDjmNzmL0ksykMcWP6cZZKd/0i9jZSlkQ6VZJHP72aGM+AJtRIy9rykeZ4NZ
         /BZTPERX94PxoufN8Sssf8HVZzoyFgWkx9/CxZBS+dEvC0nQ66LV9Y8iCC9FTzu8hTQI
         3Db2f/dMQhnlDt2PTpmej/MjFz9aVyAUJVddixqOKnETWTCzlLCzyBjKMuZTldgdOKDB
         OUL3U3IvRJX50P9Rx/qIZQFhwMNbcVow0aN2wqg1rUVwVgyeuKQ4/DGiU7azKZAoklCH
         FMeL0zLrKnNlaHL/szrpzsWTSzlnReFVxS6hX8X7TEnuxJnpvaZQVCbPk8EyQYGVCtRf
         cmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946793; x=1711551593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uu3XrTQnPclK188rbkolek/Ountn/o+HfDpmNTirMmE=;
        b=FYmffmkJ6PQFXA1T/5mTTUtDBghUA6sKbrvBO61h/JXOaD2LgH04w7OIYH0m2Rnqui
         ss/bfrqc6hJ+kxF9Bo0ZfMtP5x2dTfr69R+9zn7jaBGKubOpB/8eVPLi6pBpiCZH48yQ
         CSM8QWJ+MzKRorIB5W5snhrb+J8Hw7MthSjE+k6Y+9Mei+LwMPTOv02xI/uMtle0Ir1Q
         7/OWC4hf5zAPHGpJCdPjamT4A3OlfnyNWwCZXDpDgZMnkSJBzE3kv1dNTYtFC+ITsUTs
         PG7jN3qM9PI07EpJs3jPhVFpe5rSKIuXmUqEqpglQUzSDRZpIwZnRmRIzxa8vLz4aVRf
         QHzA==
X-Forwarded-Encrypted: i=1; AJvYcCX/7uoJieyeDiwGLCH+vZjaMiY/vGCgxNViiLJpviYbYfeIDru65lrajhzNKpFE4FFg9qOnlHLogASuYfwCYZvLlJ4WKPKv5rP2NOmq
X-Gm-Message-State: AOJu0YzB4ZfoV1grPDC6yPEzjn4QCKShZdmdcUGUJaWtNvj9hdoYK2oN
	3yv40d6z5IvzPQJm3vtwNFzGoF7gqkmWSMqzpJypSVBn5TpEulfZ00s1JmqkuLo=
X-Google-Smtp-Source: AGHT+IHYs3xz0pWt4lkNcOSOAn3q+vYaOoPxrg3Wre2/j0EachnEDYKI6x8jefgAtnsQtnh4JD77YQ==
X-Received: by 2002:a05:6e02:1a8a:b0:366:c779:f955 with SMTP id k10-20020a056e021a8a00b00366c779f955mr12702751ilv.17.1710946793353;
        Wed, 20 Mar 2024 07:59:53 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id a9-20020a92d109000000b00366895ef367sm3491581ilb.38.2024.03.20.07.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:59:52 -0700 (PDT)
Message-ID: <0a807505-221c-4aa9-ac63-c442417f3030@sifive.com>
Date: Wed, 20 Mar 2024 09:59:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: starfive: jh7100: Use clk_hw for external input
 clocks
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <beb746c7538a4ff720a25fd8f309da20d8d854ef.1710933713.git.geert@linux-m68k.org>
 <47bddec7-953d-4ea4-84f1-b0dcf0641baa@sifive.com>
 <CAMuHMdWP4R6Y6G0qzhMKJy1zJEeHE8a0XEK+Hs_D4wXB2i2BFA@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAMuHMdWP4R6Y6G0qzhMKJy1zJEeHE8a0XEK+Hs_D4wXB2i2BFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 2024-03-20 9:28 AM, Geert Uytterhoeven wrote:
> On Wed, Mar 20, 2024 at 2:31 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>> On 2024-03-20 6:24 AM, Geert Uytterhoeven wrote:
>>> The Starfive JH7100 clock driver does not use the DT "clocks" property
>>> to find the external main input clock, but instead relies on the name of
>>> the actual clock provider ("osc_sys").  This is fragile, and caused
>>> breakage when sanitizing clock node names in DTS.
>>>
>>> Fix this by obtaining the external main input clock using
>>> devm_clk_get(), and passing the returned clk_hw object to
>>> devm_clk_hw_register_fixed_factor_parent_hw().
>>>
>>> While name-based look-up of the other external input clocks works as-is,
>>> convert them to a similar clk_hw-based scheme to increase uniformity,
>>> and to decrease the number of name-based look-ups.
>>>
>>> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
>>> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> 
>>> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
>>> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> 
>>> @@ -284,8 +293,11 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
>>>
>>>  static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>>>  {
>>> +     static const char *jh7100_ext_clk[EXT_NUM_CLKS] =
>>> +             { "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };
>>
>> This should be __initconst. Otherwise:
> 
> With
> 
>     -       static const char *jh7100_ext_clk[EXT_NUM_CLKS] =
>     +       static const char *jh7100_ext_clk[EXT_NUM_CLKS] __initconst =
> 
> I get:
> 
>     drivers/clk/starfive/clk-starfive-jh7100.c: In function
> ‘clk_starfive_jh7100_probe’:
>     drivers/clk/starfive/clk-starfive-jh7100.c:35:37: error:
> ‘jh7100_clk_data’ causes a section type conflict with ‘jh7100_ext_clk’
>        35 | static const struct jh71x0_clk_data jh7100_clk_data[]
> __initconst = {
>           |                                     ^~~~~~~~~~~~~~~
>     drivers/clk/starfive/clk-starfive-jh7100.c:296:28: note:
> ‘jh7100_ext_clk’ was declared here
>       296 |         static const char *jh7100_ext_clk[EXT_NUM_CLKS]
> __initconst =
>           |                            ^~~~~~~~~~~~~~
> 
> which is a bit strange...
> What am I missing?

I think you need to add another "const" covering the array itself:

	static const char *const jh7100_ext_clk[EXT_NUM_CLKS] __initconst =

Regards,
Samuel


