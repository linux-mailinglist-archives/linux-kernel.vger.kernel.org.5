Return-Path: <linux-kernel+bounces-103625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC287C218
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058B3B2265B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261D745F0;
	Thu, 14 Mar 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN1Jiaq0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C98745F1;
	Thu, 14 Mar 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437057; cv=none; b=jqXBqGjwDhL++KQ/+FkLhjkqI1oeH85gvVdEe0JDWyD+4KSgdrad/NkWKS+88AtmvH8N0UFR6T5TDXeTYUmrBl+QbdFr8sUJURmKjqAe14AcxTpbPwDJ02xJ5Kw778/rV40IUdJvw4jFDhQC9XhMjZ6QaDXaMiNhXFJlmelJ8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437057; c=relaxed/simple;
	bh=hUYQANzZPU+Zd5O3hvkp/pd5Gw+TRN/zpzfDb8/esSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kgy5ljURs3lo2Kr+gb4TH52sqW/x6DcVw3B7VZr65jZWpS21WH6ZfDI21jkaevTEKZ6/VYGIK+WE2E9CP7kh70+WwzHgI1/KmrR7EnxZ5MjrjjpAzGN1so1P6Mia2At5t6TwlUjybx8ORruimGprr7AHAO5TeJAzgaHdJ7AiwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN1Jiaq0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41312232c7aso14591355e9.0;
        Thu, 14 Mar 2024 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710437054; x=1711041854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHYpQHDVWIEkU9CUR0MvRqU6+tOD2fXJjwYTroSp9es=;
        b=QN1Jiaq03BnAa0DOciOQNLMIfyy2ioQFyohMxDGseaI/VZPLuc5GDpFEZd6kW73jVy
         LAcuDgcVTZY6jNZqbV96FRMAYid4IVZWEhKGH5Y56zFpxHY/5e/tJa8wyXf6VPL7kF8G
         s47r+4UtXFYks8lEvTGhj0mgdpPsrjHpTQS0wVFrqmPmm19+eOqOgCYQRX9MhcAViN4/
         kf6dd6H2V0ngokcsu+IUv5Jsii3NWDtNNeQS8/zB6PIpF55HozHYlWzERYksGeG1dwSo
         ER8XNAuhWRSXM6ZKwzQk4pfADsqgJCMDGxbi9oga00kEkhrLi4VBs4WOyotaPsm3lab4
         dhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710437054; x=1711041854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHYpQHDVWIEkU9CUR0MvRqU6+tOD2fXJjwYTroSp9es=;
        b=j8Cfremgwxmgu5AhGHlwlha4KLOto+ZPLkLqWolThLZawj+uXvgc5Dl7T4ngRW9uCq
         Nvh+yxgzzUy+gUIYZW+nmehZsERGb2pHqYrpI86H/oNhaq0fOYs9JUbLACRjfUNDShms
         FfLFCjeOn/WerKbr4rH+VLaAN2EHrWVPM7cc8AisWmGBZET3P09uxjd76KDKmpDtrEJs
         D7eOf+D518Mpx1fK5nVgn0j/18lCfDUSqI3MIcg3AjHk1qNGy3bCBG0IiJ23HuBxEark
         J/dvkZYMti0tb+2dHIZz+/EfB+I1cwtx54dcu9JWoO9f/9j50ya46VLSWzqceaH4f6EB
         hoJg==
X-Forwarded-Encrypted: i=1; AJvYcCXxiYR1fwWrT7Uqqdti2euh4Q3MIDYQODpfR+UCRElpNzCa9NgfCkoUs2quxxono7RJ0YcW9713rfP/y/STo+6dbXpd/ivdPLyf+uGUAzOvfDFbyiRAPWZvor8++Kx3FHqsB/QdQrQyJ/Uh6fxYfMbIN61Ju7als0lDSPn3Ab+f
X-Gm-Message-State: AOJu0Yy1uxZMA2kUntBs3A+3UeGILED6zFx+mEBCrBW7wuF5QCXjINAc
	TaQFimkkysemS4U1BI0OS9Duqifmu7Qsc70DBioASMmc9UE8PyBZ
X-Google-Smtp-Source: AGHT+IE1m63yzHQ+v/oXeyBNcaSZhNJeuWOk678+29ozFfuMnP5Muv+wpzL0qiJ5FGj7UzkcHJBtIA==
X-Received: by 2002:a05:600c:3b07:b0:412:c379:606 with SMTP id m7-20020a05600c3b0700b00412c3790606mr3228741wms.2.1710437054264;
        Thu, 14 Mar 2024 10:24:14 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id jt23-20020a05600c569700b00412f4afab4csm3115697wmb.1.2024.03.14.10.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:24:13 -0700 (PDT)
Message-ID: <05028fed-2462-4e0b-b686-bbacc23868d9@gmail.com>
Date: Thu, 14 Mar 2024 18:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
 <58f07908-127a-438d-84e2-e059f269859b@linaro.org>
 <2b95a593-225e-47b1-8bda-03240eb0f81e@gmail.com>
 <8affb3d8-6210-43e6-8cbb-de28bdcf326a@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <8affb3d8-6210-43e6-8cbb-de28bdcf326a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 14. 15:00 keltezéssel, Konrad Dybcio írta:

..

>>>> @@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>>>>        },
>>>>    };
>>>>    +static struct clk_alpha_pll ipq_pll_stromer = {
>>>> +    .offset = 0x0,
>>>> +    .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
>>>
>>> CLK_ALPHA_PLL_TYPE_STROMER?
>>
>> I admit that using CLK_ALPHA_PLL_TYPE_STROMER would be less confusing. However
>> 'ipq_pll_offsets' array has no entry for that enum, and given the fact that the
>> CLK_ALPHA_PLL_TYPE_STROMER_PLUS entry uses the correct register offsets it makes
>>   little sense to add another entry with the same offsets.
>>
>> Although the 'clk_alpha_pll_regs' in clk-alpha-pll.c has an entry for
>> CLK_ALPHA_PLL_TYPE_STROMER, but the offsets defined there are not 'exactly' the
>> same as the ones defined locally in 'ipq_pll_offsets'. They will be identical if
>> [1] gets accepted but we are not there yet.
> 
> Oh, I completely overlooked that this driver has its own array.. Hm..
> 
> I suppose it would make sense to rename these indices to IPQ_PLL_x to
> help avoid such confusion..


Yes, that would work. To be honest, I have tried that already a few days ago,
but then I had a better idea.

It will be possible to use the entry from 'clk_alpha_pll_regs' for
'ipq_pll_stromer' and for 'ipq_pll_stromer_plus'. To be precise, it would be
usable already but for correctness it needs the series mentioned in my previous
mail.

Then the local entry can be removed from 'ipq_pll_regs' entirely.

Once it is done, the 'ipq_pll_regs' can be converted to be an one-dimensional
array containing the IPQ Huayra specific offsets only. Alternatively the
remaining sole element can be moved into 'clk_alpha_pll_regs' array.

Additionally, the 'pll_type' field in the match data structure is redundant so
that can be removed as well.

This eliminates the need of a separate enum for IPQ specific indices.


Regards,
Gabor


