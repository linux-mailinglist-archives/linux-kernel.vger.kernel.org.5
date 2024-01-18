Return-Path: <linux-kernel+bounces-30448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6449E831ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1371C22632
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB32D60F;
	Thu, 18 Jan 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLLwigjV"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB02D608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600710; cv=none; b=LnmeHh15FoNrdU1EXhDT0A6Pf2+G2C6l3lpMxLqeMnQ/u7YgDejoGcVaNE69yrY1njdmXyhJ5Qmb/dsMpZhNhhfyg6Dl7FYJunB3q7V4dB0eFL1qkaoz7z/X8sbCSiAQrtgFnjM/d5VGPIuJrpfF5u53H57IyYFubpiyp77ThrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600710; c=relaxed/simple;
	bh=QVF+n5V+O+hXfuYnJEtJo6fru3J22c12jHPTEEHaopc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gul2xsrMB1eD027CML3HR4SpuvtP4DXAJth0wlhKqLPxwUw9Qo1GBcNv+P4O3m4UyC5qkVi6t4TXP0sTLjVuk13M8n8E5oS/L/cp11MHjcu4greHCa3l00KsutCFaml6y6BbFn1562Wim+kLxmKj+W9bJONcA9X11pxbgjj+QxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLLwigjV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so159634731fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600707; x=1706205507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrlV4jgpWCJfzB/7NzgqxnwjrFZnXY4okb0+G7cWf8A=;
        b=VLLwigjVLLWhIbwEUpD3weBJKWQ1Qv5LCLFHpwDO0XO+dKXo4KGoh/s40jnB6S/NhF
         ryPJvItm+GlSFfzIs2yxYMiOhJR54OPayNtoPUlMYUFtM458oJymhqJHX8U+mQbp6MSF
         Arkwsjd3ZHGKWMRTKF1QkagN1sC8bEhl63A0cJw64wIy3jCNcpaWorUGweCpPsyLMqp2
         QgCie7nsOdg4/le5W3WfGPRLLwZtFOzEAZ/5wcXbH0524RNho1O3YP9E5qjVWjMzNGoy
         anAPxVH49/evX9Ds9YHGVndkBSujazjuEqdJOCR5t/mnT83WGajXDqiBdDRYnD+LQrPr
         Dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600707; x=1706205507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrlV4jgpWCJfzB/7NzgqxnwjrFZnXY4okb0+G7cWf8A=;
        b=kCdXnqiLhxMm1v/MsEVfdAgpaTKpKQYJ7hUs36Gn5qukYfR3j4bEDyCbPPeczgT2w9
         sUXO5vKaaAwuqaPcHmRRIp4EOZRoUr8LNk3/pRbIaYQPXZQ5vdbHDnY65cdlHAyXZhnt
         I8TU5wDnvJIW5mZrUXBiUu5SVLyDr+1eI50CorGM/VdP34GJ1NS5E9Ak2u7acDxsImQT
         sQkZgxdLUa7ZlHAbFLvAdrGXP6q0RHJUiLGJS9fEGOyz1k+Ae3x6pTu2HWVGzNSqLCzp
         46jY3qI80TyXT/Tn3+L8b21ih9v/3/w18X/7KmcAXBQ80k/9XOHtlX4AXh17QFNW52xr
         yTGw==
X-Gm-Message-State: AOJu0YwazLVPjO00zIsfr0K69WGlc82SRZldbFHVR2GsOcnHRTbM8udp
	X8jU1GsAD2VPZCMBY3xj/KPEcLaX1SiCBun/6/FKfY5k2D+nkl8sV63cXnmS7Jw=
X-Google-Smtp-Source: AGHT+IHA3nsf2QxBjJzDDsSCfuzn2I5E9MPsp1wzSuINFGRlDEcs7im02+W9DqUrmxZ7PrDqlAUQ8w==
X-Received: by 2002:a2e:a555:0:b0:2cd:23a7:a346 with SMTP id e21-20020a2ea555000000b002cd23a7a346mr1045547ljn.83.1705600706894;
        Thu, 18 Jan 2024 09:58:26 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x43-20020a2ea9ab000000b002cdb6a40096sm1507098ljq.131.2024.01.18.09.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:58:26 -0800 (PST)
Message-ID: <7d012b9f-b1ca-4633-8dc2-03d90c418e7d@linaro.org>
Date: Thu, 18 Jan 2024 18:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
 <20240116150411.23876-5-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240116150411.23876-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 16:04, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

[...]

> +static const struct actlr_variant sm8550_actlr[] = {
> +	{ .io_start = 0x15000000, .actlrcfg = sm8550_apps_actlr_cfg,
> +			.num_actlrcfg = ARRAY_SIZE(sm8550_apps_actlr_cfg) },
> +	{ .io_start = 0x03da0000, .actlrcfg = sm8550_gfx_actlr_cfg,
> +			.num_actlrcfg = ARRAY_SIZE(sm8550_gfx_actlr_cfg) },
> +};
Just a nit again, but if struct definitions need to be wrapped, this looks
better:

{
	.io_start = 0...,
	.aclrcfg = ...,
	.num_actlrcfg = ARR..,
}, {
	.io_start = 0..,
	.aclrcfg = ...,
	.num_actlrcfg = ARR..,
};

Konrad

