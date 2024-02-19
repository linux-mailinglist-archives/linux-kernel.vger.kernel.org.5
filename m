Return-Path: <linux-kernel+bounces-71664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A387E85A8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953E4B256C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCD3FB1C;
	Mon, 19 Feb 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih+JfgFS"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94A3D98F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359578; cv=none; b=P11XfML+qqoeyFSdvAE2HpyTQeHMYflgdwrWk0Zz5NBItCZ9L+byJ0dtuUXnJWXGbeikHADyO62RIAIPPYskGLqcrxJDX9N00uKKy9vlZ4u0EEDALiJqTTkv/GXgMe0mZKbIJumXbKMsY4mOEWpy9d+/p3OITRbSTaA03rEmvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359578; c=relaxed/simple;
	bh=DClpZ40MTNZHw3nDv4Skbkwxx8Xmy6FQUZVUNGGsU3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOO79y/WIA5e/2tTrN8gAc1eBG/PdSJBQUE/zF41+Wl5m7a9gygsrcSN60RnrY9HPab2hRkumNu03aBUSQI+A83ozjm/+LW6RoHHuWdvUgCUBM7h7CrrPUR9DlAT6MLXqJp5mL6Cq60aSLnar0nfTN1vU3iney9MgH9pNFUWaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ih+JfgFS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512bd533be0so881500e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708359574; x=1708964374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DL+oqveQWECDpgQ0VTAyFOqMlMmDEOhr/BFaSUzMz4=;
        b=ih+JfgFSlVEiauNs3n9sy8CkSLP130Y0cxpporXtM3wSKwtnHaPEUvQcyUe8jY1Jaq
         AjjFW5IfI7ml2HkjjvNaq0VW8ICwS76+Q/s1AfxpHWdIrf3BF3pCJQJDhG/1/cXDHAs/
         iVZi5bX/lD3BzMfOrMvIQnHLiuUZ9cs28lxS4AOqyLTnW07VvxStuGWYMPCzVDYgXtz6
         LIu5efGkmPePwzXHIp9ZruOB4q2w4DME60HIGkxdJxaS2DHGJ5pyhOfLrlk41lvG64It
         mhR4XTTdStdtFgMHHW9+ODCwCtxHytPfcW+drYuP6nzhOVPm12ireqvyXLX42zRDgklH
         h0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359574; x=1708964374;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DL+oqveQWECDpgQ0VTAyFOqMlMmDEOhr/BFaSUzMz4=;
        b=rVjy6cmPM3pM+7fTrA3SsYHSCQ40JBqjiyhOMId86VI0Osz/N951vNz0Vbxf8P9Yeh
         jvvJ6AxdJyLk9eE4NArWr4HqpmBbItELZOBSg3+rQbwI7MZS3QR3nUGjdGg6j7DUyENb
         e31vPopsTP/EGAR67+ydMDbRKoYC+u8VZlMp+VQ6LUA9UfAVqQzU89NQ3Mwd71+A4fOL
         0RGizeAgn8fgfOslu3Lro6l6nOMTjT0rNlZWr6amspnD1XHQ8i7G8u3hYnv3lNpsKkhu
         XZhoQErARSKMkrtbwr57VMTVXbsMuyhJdzdLjtlQPGGLQ6FQ7cN/lbabZcvsPz4m52fr
         heAA==
X-Forwarded-Encrypted: i=1; AJvYcCWq++3Kkw8m+dyDV9ZB7i/wdoJMsEPPCp3HWP8fOHHtaAsAhX4AGq1pm1FbCYdJDXfGUmB9oN0B0gji5jgayh0vtx1ECHB0K4LpbMZ1
X-Gm-Message-State: AOJu0YwUTpfXrEm8fPdgJJQz6l8jnjSFxDm+QDkydWuPAwo9cZjpZ/qA
	IwzTEEi3UqeX4CaW/MueZUR2Cd106J4rN/wDopgb59ZDIuosO5RygkN1BUQPpLM=
X-Google-Smtp-Source: AGHT+IFQ2opSuuYTmsOjzFMhCC39iWUgy5X+Db8xLWS/jtRskILGyDr5ahl6E2lb7e15xXUgcbrbRA==
X-Received: by 2002:ac2:546c:0:b0:511:6a0b:1035 with SMTP id e12-20020ac2546c000000b005116a0b1035mr7874145lfn.17.1708359574198;
        Mon, 19 Feb 2024 08:19:34 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906408600b00a3e70fec6a0sm1708761ejj.171.2024.02.19.08.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 08:19:33 -0800 (PST)
Message-ID: <c78db7e1-65b5-4276-bb77-d43b1e22fd84@linaro.org>
Date: Mon, 19 Feb 2024 17:19:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-3-d260fa854707@linaro.org>
 <CAA8EJpq8XvQm9B3RZq9PNMqA5VAqKUyVn5qt8-WEYMQMWniDZA@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpq8XvQm9B3RZq9PNMqA5VAqKUyVn5qt8-WEYMQMWniDZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.02.2024 15:53, Dmitry Baryshkov wrote:
> On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Commit 134b55b7e19f ("clk: qcom: support Huayra type Alpha PLL")
>> introduced an entry to the alpha offsets array, but diving into QCM2290
>> downstream and some documentation, it turned out that the name Huayra
>> apparently has been used quite liberally across many chips, even with
>> noticeably different hardware.
>>
>> Introduce another set of offsets and a new configure function for the
>> Huayra PLL found on QCM2290. This is required e.g. for the consumers
>> of GPUCC_PLL0 to properly start.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/clk/qcom/clk-alpha-pll.c | 45 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/qcom/clk-alpha-pll.h |  3 +++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index 8a412ef47e16..61b5abd13782 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -244,6 +244,19 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>>                 [PLL_OFF_OPMODE] = 0x30,
>>                 [PLL_OFF_STATUS] = 0x3c,
>>         },
>> +       [CLK_ALPHA_PLL_TYPE_HUAYRA_2290] =  {
>> +               [PLL_OFF_L_VAL] = 0x04,
>> +               [PLL_OFF_ALPHA_VAL] = 0x08,
>> +               [PLL_OFF_USER_CTL] = 0x0c,
>> +               [PLL_OFF_CONFIG_CTL] = 0x10,
>> +               [PLL_OFF_CONFIG_CTL_U] = 0x14,
>> +               [PLL_OFF_CONFIG_CTL_U1] = 0x18,
>> +               [PLL_OFF_TEST_CTL] = 0x1c,
>> +               [PLL_OFF_TEST_CTL_U] = 0x20,
>> +               [PLL_OFF_TEST_CTL_U1] = 0x24,
>> +               [PLL_OFF_OPMODE] = 0x28,
>> +               [PLL_OFF_STATUS] = 0x38,
>> +       },
> 
> Can you please move them next to the standard huayra PLL regs?

Sure, no prob

Konrad

