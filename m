Return-Path: <linux-kernel+bounces-117841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E388B5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8B9BA43B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA43FBA0;
	Mon, 25 Mar 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX6Gs62G"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB444C86
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395747; cv=none; b=NYE3GcBFvS+OFWVKUma75gEz/yb/5FM70nNTIrXfwV0k62S6NekKT7bg/k5Pvbb0hDWgUm8BjXZ0l1NvmWYGQLRTj8UngAfSsRsoELL3i7HzKxkJ6emMIb1XBhP1INSLX8AKaISQhhcTRZjwQln+5Ayh5i8fxsWor5d97h67CGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395747; c=relaxed/simple;
	bh=ypsRzg0nnFkRf2RJcsIZnCo0butaUzeBoZjGQ2DzBBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qD27SfmAP/xHNQUIh7I7UXR45IUaXJVnEtyQfgJPNzCnV+YC8NvSdvP1HueCUTXmrnC/DmW7ZYLMDyoZqedmsLuH7EmHG401TgpTznjDxr7B635E4oynf4wOZ4c8ttFtqd7mymYiNtnjB1rMC6t3mSNSzXuMfRtmxbSLOTqm+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gX6Gs62G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso4651519a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711395743; x=1712000543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HyXt8Nh1cqgfrrfN6pydYm+s3xY97iTFX20FlWEUsGE=;
        b=gX6Gs62G0bh1kD9gzPL88M5NcmmiW6HHq0R2tPIrPQQCgfwWwUKupmRuNgNmXJHcVT
         XwCWtA5pI9BraXP9TUs1sPLiuUg6RxHwzhdi9544JtVJ+kGonBNH+FsNl9sNYZd+jiJk
         ygwMRE+c5c52OADoOGhmgXq2diWLFEu2wFNhji0ZYdCPeZqXFrRv+Y85phfOT+Yu8pe8
         TMDjZq1e+7o+m9oHYy5raW058HdjttTo7dATKG9DCq1m9wpyYNOLeRyEdCJLrihz+ude
         T2iL90MDOfF6sDBSY8SQZK2dnpYB30H1f4/hPMcOlj4TvuSvYM61yeKEfiC1/wowMNlT
         8G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395743; x=1712000543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyXt8Nh1cqgfrrfN6pydYm+s3xY97iTFX20FlWEUsGE=;
        b=skV6/r2HU0PQ4Im3fsHg3KZlywtBJwD1bp51Hytv+iOjzZUNR+WiLXfunVT0Hk2nWn
         SVBwZowqUvR6953EvJ0T8W9ir7dgixRspoHrmkftghn3gNf+MSC6ZVL4VgXJsIMUGSDq
         4ANP6NINmpueJwVvpw8mkXV3tKnKbr4C9f/57QlvKLkA6uVTtPGMx152yGsN8fK3g9oR
         VR6w39WPEjtI/Q58f4R6K4oULz3Sszv9iGyFLI6GqIrMZnt7AiA9muNJ5IsBIHTNtpqD
         geSmaO4XHYogGK3oh/YrTYmJ3fxOONzirSPEiPAz0/4S/GpZ6kp+OscXoz5r21el7Ym5
         DqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3YYYg+u3VNZUqBMsjWHIBvmwQ3UkpZYxhnh706/2Mf20HuAzvRz68+6mzAFTE/PVov8TNTkoymTuvryTg+zut/l0fdhleVe01Hp0E
X-Gm-Message-State: AOJu0YxvR3vYaSJnHQh5/ZUIaOb2M5Cf4DAl0zuJ7EYmoXyYnJvqmPLA
	flk+rwwO/k+PDx37Z3wTcZFOKIFqIOByqPvh3W5TPhM9Ui9K83b17iOGCjgtvCE=
X-Google-Smtp-Source: AGHT+IHtQkqTFclZnmQ9QgOD9sPLdODVgukMjlmtIWofka5bajjQgmQ0lFZxgyrGm1UK1nW5E7yilw==
X-Received: by 2002:a50:a45b:0:b0:568:9936:b2e with SMTP id v27-20020a50a45b000000b0056899360b2emr5305945edb.24.1711395743606;
        Mon, 25 Mar 2024 12:42:23 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id fg15-20020a056402548f00b0056bff5bc492sm2514539edb.8.2024.03.25.12.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:42:23 -0700 (PDT)
Message-ID: <fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org>
Date: Mon, 25 Mar 2024 20:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: qcom: add IPQ9574 interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, djakov@kernel.org,
 quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240325102036.95484-1-quic_varada@quicinc.com>
 <20240325102036.95484-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240325102036.95484-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 11:20 AM, Varadarajan Narayanan wrote:
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.
> 
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs. Though exposing these as normal clocks would work,
> having a minimalistic interconnect driver to handle these clocks
> would make it consistent with other Qualcomm platforms resulting
> in common code paths.  This is similar to msm8996-cbf's usage of
> icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

>  
> +
> +static struct icc_clk_data *icc_ipq9574;
> +

What does this help achieve?

[...]

> +static int noc_clks[] = {

We could probably use indexed identifiers here to avoid confusion:
[ICC_BINDING_NAME] = CLK_BINDING_NAME

>  static int gcc_ipq9574_probe(struct platform_device *pdev)
>  {
> -	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> +	int ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> +	struct icc_provider *provider;
> +	struct icc_clk_data *icd;
> +	int i;
> +
> +	if (ret)

I'd personally prefer if you left ret uninitialized and assigned it
above the if-statement.

> +		return dev_err_probe(&pdev->dev, ret, "%s failed\n", __func__);

Please avoid the use of __func__ throughout your change and write
a more useful error message.

> +
> +	icd = devm_kmalloc(&pdev->dev, ARRAY_SIZE(noc_clks) * sizeof(*icd),
> +			   GFP_KERNEL);

devm_kcalloc

> +
> +	if (IS_ERR_OR_NULL(icd))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(icd),
> +				     "%s malloc failed\n", __func__);

ditto

> +
> +	icc_ipq9574 = icd;
> +
> +	for (i = 0; i < ARRAY_SIZE(noc_clks); i++, icd++) {
> +		icd->clk = gcc_ipq9574_clks[noc_clks[i]]->hw.clk;
> +		if (IS_ERR_OR_NULL(icd->clk)) {
> +			dev_err(&pdev->dev, "%s: %d clock not found\n",
> +				__func__, noc_clks[i]);
> +			return -ENOENT;

return dev_err_probe

> +		}
> +		icd->name = clk_hw_get_name(&gcc_ipq9574_clks[noc_clks[i]]->hw);
> +	}
> +
> +	provider = icc_clk_register(&pdev->dev, IPQ_APPS_ID,
> +				    ARRAY_SIZE(noc_clks), icc_ipq9574);
> +	if (IS_ERR_OR_NULL(provider))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
> +				     "%s: icc_clk_register failed\n", __func__);

ditto

On a second thought, since I'm assuming you're going to expand this to other
IPQ SoCs, it might be useful to factor this out into drivers/clk/qcom/common.c

Konrad

