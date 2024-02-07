Return-Path: <linux-kernel+bounces-56526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1E84CB3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719A21C2662E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688A7D3F2;
	Wed,  7 Feb 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaN4izum"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CF7CF24
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311481; cv=none; b=Jsq4gXGDy3lydIPEHvBhSFia2ger5yKD8Ojw0ARL888nHC3dMAxcxp/7IKZjwIb5lvTTEiqCxGPIIanPiBko3CEyEdyP7GzkyLZDuvq3cv30sOq4CFCgAvVDi8XNW9HVT5PM9DSRLkjOTpLqarUBhyg87O5pEYbJL5//a+Un2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311481; c=relaxed/simple;
	bh=R0QoTkpqrfbEypqfuVgfcQUAGnbIyMTkH94BvCYKsms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1rmI2Kjb+8XXxMRzy2xRYD5k0x8BwKv8u5L3Fe1+zHYpX/0sCmxO/HOA3sOpa8TzmPGyCeYZRU83KbLebeS1Ru5xuK6oKb8MUV124bFepCZL1P2b3p323bzzQ3ABf4Kb+eGPmozhdrF73Qb66tKXoD5SxU7QGpnOsyFo3KZDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qaN4izum; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so364688f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707311477; x=1707916277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBFC04ajuUywX7zgVv37Mz+xT5BCyZWN/G5H45gUkes=;
        b=qaN4izumts6yIkcMeGa8EJhyI3e1Rf4xXR1/1YPZmp5HvqG/pUSGHJ8N135RdjvOqA
         rI7p4QCSneKUoRInwqcQs5ZiJt50YJQemC8JRwRECiRzmKN+m1hf2bNCz+j2t8CIFEku
         2Wq2hnJWM2GKVUX1R03oGsvFCnWBMWjAsqXmGjsGu4MDgr3/xTC3HCj0KhVXEXXOHTCe
         Jv8UyTwMLiZVR0MTzT6tKsOhP6xzW050Nd1hvrFBqyYh/PjhyEa2AKiN1cfVSfQHwKLg
         T4ISD0jTx5TualijHxj/Uki1vY7I/4aMNd6JZhPsJrxHhOmUPTzG31xmy5GoQg8SSlAy
         EI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311477; x=1707916277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBFC04ajuUywX7zgVv37Mz+xT5BCyZWN/G5H45gUkes=;
        b=LNYnQiu3m9TF7NBXsS6XjRJCS1Ocr+UgfqFSj9f4ni7/da6qkLf4YiXsG5bfK4rw6y
         4hw//DybX9v5uwbjMNK3ZC8uN+XQ0HKX2AnT+wiAqZlu0jePauMaDFpvxPx+MwKcUnUq
         ra3BQyaHYDrwPKiI4IBMzV82YNz8t4/uQ8GPxRdriEBjsufF6XK2PNxPVOjadnb/yT0N
         8QTuo+tB54ggYlzeRgbkxifAM1YDgEynQzyd6nlX9CeoNQm8toWq/i/v+4lPFJUQsXbI
         t6F/8fYOKSRxllVeCY1UycLXClUz78uOX8PvEpoT66ujhtqz3wXtDZpU3DaOwWS/yFc0
         4chA==
X-Forwarded-Encrypted: i=1; AJvYcCX/E0W5nKtH+qQO7Z+4iJMfpfCUh3KQY8jMa6Ya9PCGIcLXWUW2ZkATm5X4vJIs8Ln3wsakr0hzJTSQf0AdDUx2DP+OR+bypvNeFYVO
X-Gm-Message-State: AOJu0Yyvd36y6+nUf1NWX2IkVoKWaAVCT3tEoRZraBBosGK9Pu8yxDg/
	DYswoMNnN5DFH2jXO8SdFzVFUyzCUnz7b4VYiKy58vt+xw/C3rOd9e2vIILRC+k=
X-Google-Smtp-Source: AGHT+IGYUuPxP7ZShydeLhw9wd/LEQodOHgyXLq7S8S1YAq9mW/Fj0ja93heYUm4O9Os21mPDsHSeg==
X-Received: by 2002:a5d:55d0:0:b0:33a:ff6f:815e with SMTP id i16-20020a5d55d0000000b0033aff6f815emr3801177wrw.8.1707311477518;
        Wed, 07 Feb 2024 05:11:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvJFqVFkOE0CT7NM1P3ByTvsuELdsidzrJi3hCKofPEptwr0hGdqfS8Zv44GFyKLbdZUWraMHTbqnjWD6twPOS4+Ph2JioCcYQReZA43qGGmifHPDO5Q2iarcSpCDjkZgJPp0mtgKiVL1H3Y/d9Ct019mUeTXC/eG2zwPxbAtGKqddigtLuEN3dlKTNS5WC6bEGcWNDFmOoaKykuWmvLKq8wEvrfoGPaZjtKnWO5xCyZNF1grNw1BHL3krqVW6EpLrSVs1HwgJjkcc4+2Q2QOdrUzGsae5e5JbFS57B5ZT7/h9em8LH8RRIyYHyLejhHjoAjphUXZu9gfGjzYh2dR1AYhk716gKswarAPuHDwwuMC6UvTidE7O4wvCIQGJ2v1lBI3Lvv6jlpFC8DMJxhy+pf8Wx1XO931qgeKT9tnLC3Mc3MSr/A8S+M2N0AYwQqf7DaNixNFT9FvP58rCrjudcNo5QVD0ro9M0iTEPuuptiS67bnIES6J1rthB4zb/YQ8qD/3babkPeQsEW3hPR0axg==
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0033b525dbc70sm222811wrb.79.2024.02.07.05.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 05:11:16 -0800 (PST)
Message-ID: <edc9fa59-5f39-4f47-8647-242a9b0a8cb4@linaro.org>
Date: Wed, 7 Feb 2024 13:11:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: camcc-sm8650: Add camera clock controller
 driver for SM8650
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-5-quic_jkona@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240206113145.31096-5-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2024 11:31, Jagadeesh Kona wrote:
> Add support for the camera clock controller for camera clients to be
> able to request for camcc clocks on SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

> +static struct clk_rcg2 cam_cc_mclk1_clk_src = {
> +	.cmd_rcgr = 0x1501c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = cam_cc_parent_map_1,
> +	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "cam_cc_mclk1_clk_src",
> +		.parent_data = cam_cc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,

Nice.

I compared this to WIP for x1e80100 which looks nearly register 
compatible. Use of the shared_ops indicates to me you've thought about 
which clocks should not be switched all the way off.

> +static struct platform_driver cam_cc_sm8650_driver = {
> +	.probe = cam_cc_sm8650_probe,
> +	.driver = {
> +		.name = "cam_cc-sm8650",

That said .. please fix the name here "cam_cc-sm8650". The title of your 
series is "camcc-sm8650" which IMO is a much more appropriate name.

The admixture of hyphen "-" and underscore "_" is some kind of 
tokenisation sin.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

