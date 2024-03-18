Return-Path: <linux-kernel+bounces-106618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31C87F10C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61BF1F240B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D65786A;
	Mon, 18 Mar 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z3UVBVCZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A72E3F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793073; cv=none; b=EQP9CCC7sL1KcV7NE/c9eUx9NSTCbL+bq5hCY0qMrl0WRR6mlmB70pE+XPqwlSBS00W4gEFw6ODYpJjSXPnSHajCU+BpdJoO0PXsj6seFb5HuV+4GUPCCo6kiE2r0AjNiH1zOXrF7/oMpGt0ZKDDV26M+9shbka4O/pBDwM3DJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793073; c=relaxed/simple;
	bh=2a/s7mDDRqYelu3/00RIsORLQ/R2WRP9RJNEVPTqkgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HXBoflgl7bF2b9U5O1sBPhikfMOGX47h8mqSVhxxnimoM5yMCEDUM2vAzxz45viZMBCGNqehNCBJcqWh7Q2B228P7fb1oAMCd0jfqRk2oOkzE07d2oD5Bl8xBCn8PFsCJCiL5H/kc4PpmeOCt5QejYpKN3PVQU1yUl0aspAja78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z3UVBVCZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56a2b881911so1601293a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710793069; x=1711397869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1VK2UrvRK1GqfS+jZTcmyrPbAehgKhpyQhy7X6GkE8=;
        b=Z3UVBVCZnDJ9Zvrv9Ei/oBLg+jd0/t7RdrbMVcUXIADSX+12Dvrv2GnDbIwme+9NtN
         gcrLhsTCXLGHCwqQUn42Z74vgImQjKGG6pd5edE11i3kVE5SVW7van+dVBMaLxLqc2QQ
         /Rapb3gGffmbxnFu7/9kz0Y37ssoFUoCxo517U4oM/GcWjmmp0rU1qa5kBmj3y3G0aki
         OrU0lyRRLpxZav+NG3jSw4mxyv/HajZFzAkOL/Avcmcvcs1SOnTeJ7FiJAuT3LHt/Pxn
         f0Gu5UmxKGBqP5AVoEuyozZWdUAgiNY8aq5IEQViOpoCMw48Ws2ESVxiLsS0ToNdCqdn
         McnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710793069; x=1711397869;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1VK2UrvRK1GqfS+jZTcmyrPbAehgKhpyQhy7X6GkE8=;
        b=s3oEyo2tLwC65YMMPQtf+enmScFxnmurSIx3dDqU9tRanlz3EmcIGbXR06NKXwcfjN
         coSuyVnfBs2rZk5whNJxPARG/8gNKlJiQXLRvzc2WXFkrROLL7wQwuBdjF/akRDT85db
         RbtuF1irtXQLydj2sIP+zvGGU8aUR4jO69uu0y1IS2QXoVqhRs8lTf6XB0RaBj+TzYR7
         zjB12iHACRkSbu+UAksxTVldfg0+nxB8GeLPegRJSwkR9KHUhDMEsIhdWg0pesCuIH5A
         3rgg6D3Jssr0uhetF8XCoz7tBLkbJqGXpas5GMefmw8pFSZk/wQjXmbbR3b5Icm2nBrN
         IgIg==
X-Forwarded-Encrypted: i=1; AJvYcCU6vC9Rz8OYEHaibIu3oB1rLOnNzbuNzpeKPkwJqLN/v6b3ebJm6+FHSEoKVIgo4VI04jKflk8V3IuBYSBZaTklypLscHTXm9m3qAax
X-Gm-Message-State: AOJu0YwRgVyyhuPTtajg2LdjF14pNFDrA91g24lXeVwWc4tFHB7+Df8R
	8u5FZ/umJdJ3tTxITdJeK4Ziy6uDMkhbHVpLx1vBDUTj0gsnJfxiGBHtrT1msgw=
X-Google-Smtp-Source: AGHT+IF9T4xVGnEMDWOvmebwvh7RSH//MnjXmlytzIKhD9eeivlJmumrE3KnhdTbwCwawu0TsPm8Jg==
X-Received: by 2002:a05:6402:4347:b0:568:1882:651f with SMTP id n7-20020a056402434700b005681882651fmr276209edc.25.1710793069043;
        Mon, 18 Mar 2024 13:17:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402091200b00568b6f73491sm3513123edz.14.2024.03.18.13.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:17:48 -0700 (PDT)
Message-ID: <c6704551-dae1-4536-8da2-ad4764d34503@tuxon.dev>
Date: Mon, 18 Mar 2024 22:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/39] clk: at91: sam9x7: add sam9x7 pmc driver
Content-Language: en-US
To: Varshini.Rajendran@microchip.com, mturquette@baylibre.com,
 sboyd@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172831.672953-1-varshini.rajendran@microchip.com>
 <01e96d4b-3038-498b-a9b2-2acac51f1d80@tuxon.dev>
 <e84994fc-7ec1-4d65-84f6-efc6a47b0c2f@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e84994fc-7ec1-4d65-84f6-efc6a47b0c2f@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.03.2024 11:25, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> On 11/03/24 11:28 am, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 23.02.2024 19:28, Varshini Rajendran wrote:
>>> Add a driver for the PMC clocks of sam9x7 Soc family.
>>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>> Changes in v4:
>>> - Changed variable name alloc_mem to clk_mux_buffer to be more
>>>    suggestive
>>> - Changed description of @f structure member appropriately
>>> ---
>>>   drivers/clk/at91/Makefile |   1 +
>>>   drivers/clk/at91/sam9x7.c | 946 ++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 947 insertions(+)
>>>   create mode 100644 drivers/clk/at91/sam9x7.c
>>>
>>> diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
>>> index 89061b85e7d2..8e3684ba2c74 100644
>>> --- a/drivers/clk/at91/Makefile
>>> +++ b/drivers/clk/at91/Makefile
[ ... ]

>>> +static const struct {
>>> +     const char *n;
>>> +     const char *p;
>>> +     const struct clk_pll_layout *l;
>>> +     u8 t;
>>> +     const struct clk_pll_characteristics *c;
>>> +     unsigned long f;
>>> +     u8 eid;
>>> +} sam9x7_plls[][PLL_ID_MAX] = {
>>> +     [PLL_ID_PLLA] = {
>>> +             {
>>> +                     .n = "plla_fracck",
>>> +                     .p = "mainck",
>>> +                     .l = &plla_frac_layout,
>>> +                     .t = PLL_TYPE_FRAC,
>>> +                     /*
>>> +                      * This feeds plla_divpmcck which feeds CPU. It should
>>> +                      * not be disabled.
>>> +                      */
>>> +                     .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
>>> +                     .c = &plla_characteristics,
>>> +             },
>>> +
>>> +             {
>>> +                     .n = "plla_divpmcck",
>>> +                     .p = "plla_fracck",
>>> +                     .l = &pll_divpmc_layout,
>>
>> You mentioned in "[PATCH v4 24/39] clk: at91: sam9x7: add support for HW
>> PLL freq dividers" that this has div2 but it is registered w/ a layout that
>> has .div2 = 0.
> 
> This is handled in the above plla_fracck fractional part as defined in 
> the plla_frac_layout.

Ah, right. I missed the changes in sam9x60_frac_pll_recalc_rate().


