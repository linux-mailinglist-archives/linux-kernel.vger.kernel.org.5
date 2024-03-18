Return-Path: <linux-kernel+bounces-106691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E690B87F1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E02281B82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AE5916A;
	Mon, 18 Mar 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2XMD9NR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B458AC3;
	Mon, 18 Mar 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797019; cv=none; b=RmLWJaPND1MnX4dHP6OUr+6yQrJyZ/Z9UVq0KbXH9nEmpH3fNnYIydfrA7M8lzdx0kH3epz6nLUDqv5HS2LAji0JrpKceUSXr/Cod4lxEgYY6Z7ZFo5XmJAPUsXAWcS+m1InxOv0VZ7M851nXcapt5IMR+HH81UMieI3I84m5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797019; c=relaxed/simple;
	bh=jXUjOX54Xb1FBNE9JdYUTQzq4trLE3UQuafL1UqQCaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsuOxPTMjZsElLwHF7u05/eUV+01AA/UAD8j86sbVKyLqAsaaWnpY9iU6QkVWAOFjZ1hsFomHv/3q+4V83D33h5OCITt2M4aHgJs8VaNASQh4as166MM/lJwMGnCWBwTs4f8Eid8AE2DTPu0VsM5WjUMYqecJbHTP4u3f1S2WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2XMD9NR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-414633f7a52so1343615e9.0;
        Mon, 18 Mar 2024 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710797016; x=1711401816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUmaePLvv7eXQ5vSkHddOGOBZwbf9kgfdDc4phHSI68=;
        b=X2XMD9NRJGYoI2whqSN7lfDNHarxOrNz5HV+dKWbzcRaXmOFawJerR3VDXAOc90R79
         Xdfz8dn9K7KWwLU2CFPjb1/ArTJWNC/OFeI+3mgDLtY8FwoA48sujdmRuVK9cccQiVx1
         Pwwi8YmLNjFwcLrfSGnftGmOBKX4J/iK6Xcx+3kADqboGDOAEcWdFN8aaiBx1veK20uY
         A2Ucxc4cDmBasxCGuRneHV2YIk3xclbozjCFi/r5+6+OeBAFBYKZ3QHCj8ybAbBLPsR/
         cZsLTpLRj6rz8NlIwsrMMyxTvGSJMMzZddA3F6hcOqB37HoRnNYRtqpBwa1aa78GpZgQ
         8QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797016; x=1711401816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUmaePLvv7eXQ5vSkHddOGOBZwbf9kgfdDc4phHSI68=;
        b=mSboJYXuvpTOiqHB3jzgc9jqX2gwLKAhwhZkofVawv+QjP9zaH8/9nhf2uTygmSoSA
         fosXJUE4fcIt+JKHOTx5sDOT3HFf0fL6EaxgFzDdjcs8kKKqHsBDTUNhkRpQpa8P2goa
         028fntr/y9LsNzao51u3guM8NNX68Oye3fSryoPuIvO/e6TlGeKCergwID7hJjkOB+5U
         DeSuh6NteV17mSLHhxm3luhqX+X+r8BE7rIclpW6G9G2uzginiOK5p8jW+UwzMNxjDke
         aNWykfoFg+qDSjGivAzpIKY6HJ9hDftgFvx2LCAqN/aA6K9Pxz2eeXrOpDmcPHD+afYj
         dkcg==
X-Forwarded-Encrypted: i=1; AJvYcCVZKbAuou/gdLzJRqya2WBEb/z42zgXTiRXj4Fj/hA0nNgrtqTLAGbJKxOBAZHuPi8eW91xkXJk6SZPoawS2kpzlO3/koqSGqxginpHmCy/cPmseJVqKZg3e+XnjGORf/2WOQMZZQCd+MQUYdDSTO/yBy7FdTkjqmS+M9hzrcSP1wbmpeTQ9w==
X-Gm-Message-State: AOJu0YzGWXbtPzs1qc/pCEW+J85tPxKKSFfjHCYOQBzx47GLbeDdQKa2
	TeWE17zTkGBVfmdUVrHyBI/rV6FEb7hfld1wMxh6n2MLg76kJYYA
X-Google-Smtp-Source: AGHT+IHLRh0Pg+JUcUwocj9n1tMEzUsGeZil7WG3Hn91sbwpo0LSq+i23Clj/ttNpfiAAVhl+OvQnw==
X-Received: by 2002:adf:f292:0:b0:33d:1eea:4346 with SMTP id k18-20020adff292000000b0033d1eea4346mr6825996wro.37.1710797016137;
        Mon, 18 Mar 2024 14:23:36 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id hz13-20020a1709072ced00b00a46a9cdcfa5sm2948714ejc.162.2024.03.18.14.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:23:35 -0700 (PDT)
Message-ID: <09c91419-8bce-49dc-86d1-3ed1b9f28ee6@gmail.com>
Date: Mon, 18 Mar 2024 22:23:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: apss-ipq-pll: use an 1-D array for Huayra
 pll register offsets
Content-Language: hu
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
 <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
 <CAA8EJpo2Vo-XqstNk69dWW8pqNkGi0tz3UmHY7j6LLKd-yH22w@mail.gmail.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAA8EJpo2Vo-XqstNk69dWW8pqNkGi0tz3UmHY7j6LLKd-yH22w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 18. 15:16 keltezéssel, Dmitry Baryshkov írta:

..

>> +static const u8 ipq_pll_huayra_regs[PLL_OFF_MAX_REGS] = {
>> +       [PLL_OFF_L_VAL] = 0x08,
>> +       [PLL_OFF_ALPHA_VAL] = 0x10,
>> +       [PLL_OFF_USER_CTL] = 0x18,
>> +       [PLL_OFF_CONFIG_CTL] = 0x20,
>> +       [PLL_OFF_CONFIG_CTL_U] = 0x24,
>> +       [PLL_OFF_STATUS] = 0x28,
>> +       [PLL_OFF_TEST_CTL] = 0x30,
>> +       [PLL_OFF_TEST_CTL_U] = 0x34,
>>  };
> 
> Can you please move this to clk_alpha_pll? We can then drop it from
> clk-cbf-8996.c too.

Sure, I can do that. By any chance, do you have a suggestion for the name of the
new enum value to be used in the clk_alpha_pll_regs array?

CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ seems too generic, and it would be a bit
misleading using that for MSM8996 CBF.

CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ6018_A53 is quite long and it is also misleading.

Maybe we could use CLK_ALPHA_PLL_TYPE_IPQ6018_A53 which is short and unique
enough and we could add an alias for that like CLK_ALPHA_PLL_TYPE_MSM8996_CBF or
something similar.

Regards,
Gabor


