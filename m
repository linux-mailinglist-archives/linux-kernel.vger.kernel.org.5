Return-Path: <linux-kernel+bounces-119957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F888CF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FDB1C676E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5983811F9;
	Tue, 26 Mar 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQ0vf9yz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1AB74429
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486290; cv=none; b=JIyjmI4DC3uNDJTotvwR7vCZi5uqnMsHWeQiNkWZITAJhdjIGPbprCAsptDvsqcyTUCtEKdtPQmreWvoZiSK9tbmXiWEwWqLmVV83kzpb1SvsdkNjTiGiOp6yahn2xhvhjaKmvqVxP5Z75OUe/toT8UyvellVcLDy77LsdDe68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486290; c=relaxed/simple;
	bh=LxOyp0NjGeH5uTcpz5vFvBjens4zOm830JN4rXrjxM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvpBBX65z2J4R/plfCnrrGQY6R1jxRh9Tuav6AXz7NR3n5QFWm0a9DxtXHKcSksGJIFW+nKk4KXZu6od1BYRdFTQHCTvQPa7jdqjJxDRMePckyr3b32vzLvfFbPthy1RYErP+3sPDOtxioQm1YcCMCbCBGjoh1i79JK0JU/TBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQ0vf9yz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso719372466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711486287; x=1712091087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHOe/G5KYN7b17DIn2VPfNGGBUH/PrZyNCw0MGfKBTw=;
        b=EQ0vf9yzxxV0jGL4q77k1dJmgBJkHryUgwawP/d+7xjGsW68fldEKTR2x8JNZlX9BX
         9KsARVTWfRhrmkaTFPuFtcyCxXXvWKbBA3AavQiZ9WsexBrk3ZTaSQLyHSPzhUDzElET
         TQTeYoNhbM6urDp4QiNsayCNviLZY05iqe1ygNrWlsgU1zSnDtwywFBcdbsnafHwHeAM
         TdDI1h9GdAvOomjg0sSuIMSsAy5Ib1DvyOzTdKPf9Tt+a7Z+XzHq+Fpywn+utQVqdiuy
         DNH+T+0uXLMpyVKjGEykS6EZ5FmthB9YlDf8Bzh+NFq8Vr1SqRidpiUbQ6SK0DnXr9Co
         hKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486287; x=1712091087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHOe/G5KYN7b17DIn2VPfNGGBUH/PrZyNCw0MGfKBTw=;
        b=L1mHjhpbIr82YlQrLsCEoNzMlpY0Yth+M+RAeRbfo/KAMJCdoaG2CyhVhxs6cLUkex
         EEVFgKGroKoMQG4DP6RtkscIxPu19cJfpkA7FrBoBqm5NKigzIzV23IksV/nYy9qwn8j
         +dpLG1RXu8to3D3840XqVewIAMbxbJELA4t1WPzhCWzJd+ot9wqBBY4JQoc/Hw+jxI4T
         rlgoN6rUgq8swnt8GVeoS5wQNbvejWuOwuVtcDgxkGLzetEt4iPBZjwXgfPr9AgOuKq6
         EjXpVu2RiieAdPy1dpffVpEs0MWw6cPLHawb5F32Fc5MHbFvYxXnfgeVEQXMJFyekJae
         YRkg==
X-Forwarded-Encrypted: i=1; AJvYcCXcWUHxi38Ft4myiEHb/ltGc/ZsulU+b2AmiJ4CnalldwVdX7MtQNlH6kXnNAjT2iKRK7k3QB+eAv8L4mH1S9QytwaQSpQf7UpRCipR
X-Gm-Message-State: AOJu0YwpBPUGM7BnZpMGOqWze+IEt9fclhge3VvzzMQnoOJiJIgiY9JO
	5x1buNMNhVkmisBP8AiSZIK5o19auTnnzQkeTQQ3BntdrJfaPmOwr6Lc19vU+9eFdhf537y9Qoh
	u
X-Google-Smtp-Source: AGHT+IEO6x339HcRMWYEWkSqK1A87Ti6i1dy4IluQnQL8ERZxsmTGhD7CN2Lj/e5gSaomLWEVvgZBw==
X-Received: by 2002:a17:906:1d53:b0:a47:1f9d:8f17 with SMTP id o19-20020a1709061d5300b00a471f9d8f17mr9012058ejh.32.1711486286876;
        Tue, 26 Mar 2024 13:51:26 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b00a4da28f42f1sm1746091ejc.177.2024.03.26.13.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:51:26 -0700 (PDT)
Message-ID: <87af7b7e-9c2f-41e1-af97-01d3f29f5970@linaro.org>
Date: Tue, 26 Mar 2024 21:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: clk-alpha-pll: fix rate setting for Stromer
 PLLs
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan R <quic_srichara@quicinc.com>,
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240326-alpha-pll-fix-stromer-set-rate-v2-1-48ae83af71c8@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326-alpha-pll-fix-stromer-set-rate-v2-1-48ae83af71c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 1:15 PM, Gabor Juhos wrote:
> The clk_alpha_pll_stromer_set_rate() function writes inproper
> values into the ALPHA_VAL{,_U} registers which results in wrong
> clock rates when the alpha value is used.
> 
> The broken behaviour can be seen on IPQ5018 for example, when
> dynamic scaling sets the CPU frequency to 800000 KHz. In this
> case the CPU cores are running only at 792031 KHz:
> 
>   # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
>   800000
>   # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>   792031
> 
> This happens because the function ignores the fact that the alpha
> value calculated by the alpha_pll_round_rate() function is only
> 32 bits wide which must be extended to 40 bits if it is used on
> a hardware which supports 40 bits wide values.
> 
> Extend the clk_alpha_pll_stromer_set_rate() function to convert
> the alpha value to 40 bits before wrinting that into the registers
> in order to ensure that the hardware really uses the requested rate.
> 
> After the change the CPU frequency is correct:
> 
>   # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
>   800000
>   # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>   800000
> 
> Cc: stable@vger.kernel.org
> Fixes: e47a4f55f240 ("clk: qcom: clk-alpha-pll: Add support for Stromer PLLs")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>   - fix subject prefix
>   - rebase on v6.9-rc1
>   - Link to v1: https://lore.kernel.org/r/20240324-alpha-pll-fix-stromer-set-rate-v1-1-335b0b157219@gmail.com
> 
> Depends on the following patch:
>   https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 8a412ef47e163..8e98198d4b4b6 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2490,6 +2490,10 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
>  	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
>  
>  	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +
> +	if (ALPHA_REG_BITWIDTH > ALPHA_BITWIDTH)
> +		a <<= ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH;

Uh.. that's not right, this is comparing two constants

Did you mean to use pll_alpha_width()?

Konrad

