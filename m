Return-Path: <linux-kernel+bounces-89494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EC86F11D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E535A1F21EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B54224EE;
	Sat,  2 Mar 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbV96z/U"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9340210FE
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396005; cv=none; b=vFv3v2Jt2BqzYBVq3cc8HTYZsINvaKlroyhh7x03Qenyy3RBBkCyeONKfNuI8NKlZvIbtndDZ8T6wYk87YUKfsfHfLjWLgVATT7rDDU8JRy11D54mdBGqeO6A6cNFrFDmuMHO5j4skpPvHuutAFibF2OdG9ELwqSenL0wmiP+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396005; c=relaxed/simple;
	bh=JeLgVGxq4GQg42VTNAyIVdsz1jUfH/1+h0YLlwMB8kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ1tKgzeQeJfWRwr0nLwah7r7JSj7dudC8XuVGYhpIhEZZoNEsfeLKpgq1YldjgC4EdY5119PQ7st3qui/c2zaCDNay4Gc9W9EwQj8ttE7/DGjrx1cePOXI0GqBc0iwWRcskxi0UE63Xp6LmAz4AmBLlvICqxrUCOZOOcbifFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbV96z/U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so24760815e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396002; x=1710000802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvQGYtN2vRBi+QYnwAZtvXa2o7whVTvKnKEEFe1E4KQ=;
        b=hbV96z/UID9eG8YgjJCqXW00rt2Ed4n3iUZjJl6k52dlu6n5SWnBQh1L0ZuTahsvjk
         1ba8QTm6KApkvDUH6YTlm7fdvbFWj4apSlorKbNE4Q1Ak1jky7X6q3ScclxagR0lX+Yq
         6JebDQahDpRpnBJOWjdl7n8vWtQJHf1M/GMfWMd/wRmOrqsVApwnEpVvZKnqWUMr9LjH
         JT8ZWYvJdj2sQ4rLa3fqG5oJ++cSwEqZvdbOX7RFr1SWUTbs903ZxwHsGWyBRrQQSYL3
         g22ejuBdfSL9rwz3HpDvIU3NAQGLc3kvjNAQyNWmVsLKmDOr9AgabjtBCliXgqsLsA47
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396002; x=1710000802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvQGYtN2vRBi+QYnwAZtvXa2o7whVTvKnKEEFe1E4KQ=;
        b=rsIKJJZm1fxBMsBUSw0ok/afhLD8VjpRUYDeR+v0DXmT5OWCgEzXROxzJK6OCFqKmz
         OOQDOYcrbWZUe9XvfeAxqq+VR2Xwcz2PHx/eNJq8R/qN0u9ClrX6/z6MZc612n//k4dP
         PtZQA7EWOoGhUJsNHJXAxGdnUE7J00IogQMQpu7+QgeLdgRZpoOnpiJBuKKsK+ZX416/
         lD6nvnZosAhI5pShsyqzZ1R89k4H5aepAF4Xre+xN9eHVSNHwE+uGDPur95tP6Wq4vXx
         5q3Jc7wAfIvsT2M/JdNS7kpK826BA49k3paBb33fM3NkzymqOzozX4TiTEcBY7+I8ppe
         a+zA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+X2AHrxdRWGHbaxEZJoWJrERudw56G6eJ1lJHHPue8ahX9Hp0HL8i6HhMvXqlCy31M1DWVKWgtqz0+18GPanFsRBNEYHa368Exyg
X-Gm-Message-State: AOJu0YwYCg4/sn7Ee1BOfIOYTXI5DoBCJw1+kozF1bDtZNrI4tHCNRg6
	lIBj4i783umqz/fMrKyyA9tcITD3NkEfpgecMJu52WlFbQasrufHuiEQVl717E8=
X-Google-Smtp-Source: AGHT+IEL9BKhdhIVjKmro2+K35KM05pC7dvn53IR+o/01gtD6rpiQa7LHmKF00AWVjh8Nm0NJ+w8Eg==
X-Received: by 2002:adf:d009:0:b0:33e:152a:6b3d with SMTP id t9-20020adfd009000000b0033e152a6b3dmr4871168wrh.31.1709396002115;
        Sat, 02 Mar 2024 08:13:22 -0800 (PST)
Received: from [192.168.0.58] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bu28-20020a056000079c00b0033dc7e50488sm7796549wrb.96.2024.03.02.08.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:13:21 -0800 (PST)
Message-ID: <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
Date: Sat, 2 Mar 2024 16:13:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for
 SM8150
Content-Language: en-US
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 5:38 a.m., Satya Priya Kakitapalli wrote:
> Add support for the camera clock controller for camera clients
> to be able to request for camcc clocks on SM8150 platform.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---

> +static int cam_cc_sm8150_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	regmap = qcom_cc_map(pdev, &cam_cc_sm8150_desc);
> +	if (IS_ERR(regmap)) {
> +		pm_runtime_put(&pdev->dev);
> +		return PTR_ERR(regmap);
> +	}
> +
> +	clk_trion_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
> +	clk_trion_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
> +	clk_regera_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
> +	clk_trion_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
> +	clk_trion_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
> +
> +	/* Keep the critical clock always-on */
> +	qcom_branch_set_clk_en(regmap, 0xc1e4); /* cam_cc_gdsc_clk */

Does this clock need to be specified this way ?

drivers/clk/qcom/camcc-sc8280xp.c::camcc_gdsc_clk specifies the gdsc 
clock as a shared op clock.

Actually it looks to be register compatible, please try defining 
titan_top_gdsc as per the example in 8280xp.

> +
> +	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8150_desc, regmap);
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
> +}

So this is a pattern we keep repeating in the clock probe() functions 
which I am writing a series to address. There's no need to continue to 
replicate the bug in new code though.

Only switch on always-on clocks if probe succeeds.

	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8150_desc, regmap);
	if (ret)
		goto probe_err;

	qcom_branch_set_clk_en(regmap, 0xc1e4); /* cam_cc_gdsc_clk */

	pm_runtime_put(&pdev->dev);

	return 0;

probe_err:
	pm_runtime_put_sync(&pdev->dev);

Alternatively switch on the always-on clocks before the really_probe() 
but then roll back in a probe_err: goto

probe_err:
	remap_bits_update(regmap, 0xc1e4, BIT(0), 0);
	pm_runtime_put_sync(&pdev->dev);

There may be corner cases where always-on has to happen before 
really_probe() I suppose but as a general pattern the above should be 
how we go.

Anyway I suspect the right thing to do is to define a titan_top_gdsc_clk 
with shared ops to "park" the GDSC clock to 19.2 MHz instead of turning 
it off.

You can get rid of the hard-coded always-on and indeed represent the 
clock in /sysfs - which is preferable IMO to just whacking registers to 
keep clocks always-on in probe anyway.

Please try to define the titan_top_gdsc_clk as a shared_ops clock 
instead of hard coding to always on.

If that doesn't work for some reason, then please fix your always-on 
logic in probe() to only make the clock fixed on, if really_probe() 
succeeds.

---
bod

