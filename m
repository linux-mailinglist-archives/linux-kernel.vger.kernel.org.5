Return-Path: <linux-kernel+bounces-103440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A378087BF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DDD28579B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D571733;
	Thu, 14 Mar 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I000Ktnl"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975137172A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428219; cv=none; b=oxhZnJskBWAiVRLc7irfYM5XM3GsrqLq+1Mq7VsovbqiTWIjyEHYECYDyeuRxkUJ5dJZFvB4f7qLu/dRadzP772c7i0iWhLlT9J6tOZpe+bKwRektwKps41VIN4i3S2sZ4C7403g7hEMVUWckxF0U9L3cl8f2jn5NT5CwKNmfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428219; c=relaxed/simple;
	bh=mEjE8q+E2HjRI9XzAhQ/CrCkar6G2FE6iHbSsPc+Gyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjrsueRGDE7N92u9H9ycqTFTEfc3YTO4BpAdbEjuFFhCqh9fzk0sa/yiACT95uZYbHpGusGSr3Ta7ZlJ4Sjhp6eaPZzwubYYjY1HehiGnz55xc2xrdsENAp9JnZdCd1pSSYatseq6dbr0dRONyohOsBg4V5tBNs+q7CGMmCDag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=I000Ktnl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690b24973beso16952486d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710428216; x=1711033016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxoX+O1GlcPWe1RQwrLpQvGT+Ve/nhPsRMUh8z8RZIw=;
        b=I000KtnlC+WQPyt2sorMY+b4lwHBUhE//+e65JTuH3bh7+kKKHwHsplZctFU44KbvN
         MhwUpij8VB2qQ5pTUELjtdJKi9WCtnDIRRLs5jXRXPjM0nzB1NxvhrKybvOs1vITArdE
         /hbcQQyaoJFIglEtcD/4bHRGr78L1/6nxEXfuhv9FW25xuwLd/bY/R9OIFeQj2AvSU33
         QnKhDEm3gHxflRvyIhPJdBtH9yI3MZgPOd4EwqzSJ9qAym/C3xP+q53sTyO0PTAQ3xXd
         U8qkc3mya5+Bd869q3x3skwHmVujYfHbfECs9ABpBht/yg0Hc1aVEN+A2PRW2gNRbfMP
         Mwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428216; x=1711033016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxoX+O1GlcPWe1RQwrLpQvGT+Ve/nhPsRMUh8z8RZIw=;
        b=QLis0jbhpWZl8hWMLdIHUzSyd1mThWeQ0nO9rqlgBGk7McnRB+fcklW+7rdxU59n8v
         YpT2SIGZlMEa1bpOeHXwKpdRR1FHqdPUZp7pud9xZmpaB65x3rgylS9v7Qn37hfPMEL5
         21P4fxPXSNnLjjoqEsCybhIGue033ywKQJV3Py3TBbL5CYp6mtvnpBmiSFkdoqIHA83B
         mPYIqEDZz50vzxJ2bz6idYaRao/jr2UzViv0eAmlF3V6Axha6RRpo6Wepv+Flqb9HSIj
         TdVmk3xdllTLmW/2R/uSRX9LiKKubayn5/E7A3RM6txpPmGkH/gKDisGTfbSLRzVy15U
         g6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXnGcnjF7tKU1nCGYbGr3QzvI7FJjMQn5TTCgDP1jiBfuqT/a3jLrfDafEIBN7EOc3hYJgD0PZhTASmQbaKbIVOx7VyhdeBin/x9oYa
X-Gm-Message-State: AOJu0YwsHIG3cEsKAbqiM+WGd4tuPkQKrE7BnPMYArumqQnSZWH4WSI8
	woHdgcEe6LwPE6R9UIOxVPWwdJrJAOQo1IN+p+8b276KcFYmSsrrvm84wI8AdNY=
X-Google-Smtp-Source: AGHT+IFH2laVemU8OwQ32YK+QaEsKZgxeEvMnGkMRQp09IuyzZ5ZeOZGACdxlplPgoNSEue7cq6fGw==
X-Received: by 2002:ad4:4ea1:0:b0:68f:dde4:fb12 with SMTP id ed1-20020ad44ea1000000b0068fdde4fb12mr4915051qvb.9.1710428216556;
        Thu, 14 Mar 2024 07:56:56 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b0042f068d3d8asm871706qtw.43.2024.03.14.07.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:56:56 -0700 (PDT)
Message-ID: <42c3d591-abe5-4343-9a94-f1705430dcea@sifive.com>
Date: Thu, 14 Mar 2024 09:56:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: starfive: jh7100: Use provided clocks instead of
 hardcoded names
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
 <695ebdde-3dc3-41b1-b20b-f02c4ba1ae5d@sifive.com>
 <CAMuHMdURtL1u-MDXBhiwOfX+zBnuunZYvjt+3GMOp6Y6pj1Efw@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAMuHMdURtL1u-MDXBhiwOfX+zBnuunZYvjt+3GMOp6Y6pj1Efw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 2024-03-14 9:48 AM, Geert Uytterhoeven wrote:
> On Thu, Mar 14, 2024 at 3:32 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>> On 2024-03-14 6:05 AM, Geert Uytterhoeven wrote:
>>> The Starfive JH7100 clock driver does not use the DT "clocks" property
>>> to find its external input clocks, but instead relies on the names of
>>> the actual external clock providers.  This is fragile, and caused
>>> breakage when sanitizing clock names in DT.
>>>
>>> Fix this by obtaining the external input clocks through the DT "clocks"
>>> property, and using their clk_hw objects or corresponding name.
>>>
>>> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
>>> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
>>> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> 
>>> @@ -298,13 +311,23 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>>>       if (IS_ERR(priv->base))
>>>               return PTR_ERR(priv->base);
>>>
>>> +     for (idx = 0; idx < EXT_NUM_CLKS; idx++) {
>>> +             clk = devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
>>> +             if (IS_ERR(clk))
>>> +                     return PTR_ERR(clk);
>>> +
>>> +             priv->ext[idx] = __clk_get_hw(clk);
>>> +     }
>>> +
>>> +     osc_sys = clk_hw_get_name(priv->ext[EXT_CLK_OSC_SYS]);
>>> +
>>>       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
>>> -                                                      "osc_sys", 0, 40, 1);
>>> +                                                      osc_sys, 0, 40, 1);
>>>       if (IS_ERR(priv->pll[0]))
>>>               return PTR_ERR(priv->pll[0]);
>>>
>>>       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
>>> -                                                      "osc_sys", 0, 64, 1);
>>> +                                                      osc_sys, 0, 64, 1);
>>
>> These should use devm_clk_hw_register_fixed_factor_parent_hw(). (Or you could
> 
> Thanks, I didn't know about that function!
> 
>> define a devm_clk_hw_register_fixed_factor_fw_name() and drop the other changes.)
> 
> Sorry, I don't understand what you mean here?

In the loop below, the parents are already referenced via .fw_name. That means
the string is the DT clock-names property value, not the Linux-internal clock
name (see clk_core_get()). These two function calls are the only ones that
depend on the internal clock name. If you change them to use .fw_name as well,
the clk_core_get() will do the right thing, and you don't need to manually call
devm_clk_get().

Regards,
Samuel


