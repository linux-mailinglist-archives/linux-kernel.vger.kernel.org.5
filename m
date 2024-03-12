Return-Path: <linux-kernel+bounces-99712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ACE878C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A559BB2175C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30117F7;
	Tue, 12 Mar 2024 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvOtp4xx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5497E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205511; cv=none; b=a84ADCOVVBg4fiEY/NRp2S2GyJ4UqVxKtfvE94Ok7p2nL0Wn1/UzdTN3cCp8bWjF2V2PIqQ9QUmqp/xsWNx5wjbT6xSloU+Ox9JB+hC/5zWWUb3LQr5H5rUR5SYP3INjEAoSmm8D/INNH8e30IVCXxJLhyglr99jfkSZAYxS+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205511; c=relaxed/simple;
	bh=kiqq5+7qC6lpslO5kWCW11x3kemUPM6htnwZ29MLvMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/wk00XjtJOfvYDJbFsHHF/ZXIUYmoGfRVOnUxBmoryUubzC4kX8IQGL7Cdg1+N5RMdvxQKJQ0dEgzrrl4RXJllZ5DyT7ViPOwZpCPSFEn2v2N13O/E3hlqbXP3KLy2MyGG6xqBA4EFINRyK0ZxMRrmGN/RXS5I4THhqXaofEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvOtp4xx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512ed314881so4400960e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710205507; x=1710810307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWlUlgD54M+Av91gLdkhwyiioJ08F7sqNreLTDCTGKg=;
        b=fvOtp4xx/6hZ9oR5/ceHPtTYHRKatuauXWtLgj3YTkqDyb77NPaP7CQTw7h6LFhKxK
         ItXKi4rzLICL0VqWhYv3p2UMnvFZS0G6U6HJuOhJuvu8Uje+JENhIfsxQfU3AsAvSrA6
         1oCRgVokImXWRqxIGIZXV8LlBU0z7bHlUrJi5jLl8hJqFq3Mu5SB0s6AYdCO0nDqPyGU
         yIb4pPALLhnz4YQHEGlVSpiU48Doo+kxXRt/vnD0p4PGDv8OsG3mbmLRlj+FHkrVPfiW
         4Z4GwOeWL03oBBp55HsxSxCfkdou5B8nbTzD0HnE4jjpXaDabmZb/5Ek7BG7sqdmJzKB
         Ud/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710205507; x=1710810307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWlUlgD54M+Av91gLdkhwyiioJ08F7sqNreLTDCTGKg=;
        b=qI3h0xK3S6o9OnHLJ5MN40ixIcDmpCtYmpBcYYQGcJg8WCvIAzYNpYY4lC+56BJuPn
         mntMsh1i2ssGEq8HAb3EEL+QxnfqzZ0YKZlOCuFt9M9S3zJQk4uBzFJAeUOMEwID9rhG
         RzAxEnB4vMNFEeSXoz+sap6fcCv5eOWUhr9sh6oncCvi1s2Q3bqCtfdLnYqpyPRFnLd7
         o0k0js9L2gVW5+qzaTybSgt7d5zlAmzPFA1g1vSMg88Cl9gHHHk+KVQ6bx0cBsGDezBg
         Jfy2Bufhy1pp8a4hEBtJ3N5WDDIIbXu151y3XY8cFVXVKti9Cuvyg86EXoOubhXVADHR
         FxRw==
X-Forwarded-Encrypted: i=1; AJvYcCXI7skBbb440/rpwgifIE3UbLqckS40ri9OM1oKJqP3MCeOerL/G2fWOcUeBZaHtP9fPq3i6vhmiic5dh5mZwWBomtOaMjEZXsED5Sa
X-Gm-Message-State: AOJu0YzmAE4IBRO/2uM4gg6mztr/Sgyahxp62tmhBxqPX3P/umxzwSN9
	MKAJx1mASYE1ekZB34LyVm7TQRDxRFP5jn1TFN8LGLOVFYTumxEO777F2p/KwCU=
X-Google-Smtp-Source: AGHT+IEjePFbUnyVdjlPN5OqGXrY110eXs/oog493hVp9iq9plQNBgZbCsCUqoOBrnsfBdW9+r8XcQ==
X-Received: by 2002:a05:6512:4896:b0:513:57fe:97b8 with SMTP id eq22-20020a056512489600b0051357fe97b8mr4992132lfb.26.1710205506953;
        Mon, 11 Mar 2024 18:05:06 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b00513a1fe7767sm1040883lfb.209.2024.03.11.18.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:05:06 -0700 (PDT)
Message-ID: <61232fd6-2b76-4ab0-af64-2d49ae405610@linaro.org>
Date: Tue, 12 Mar 2024 02:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <cover.1708551850.git.quic_uchalich@quicinc.com>
 <c3456b3d182f5139339400e49b228fa4840ae0e2.1708551850.git.quic_uchalich@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c3456b3d182f5139339400e49b228fa4840ae0e2.1708551850.git.quic_uchalich@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 00:07, Unnathi Chalicheemala wrote:
> Define new regmap structure for Broadcast_AND region and initialize
> this regmap when HW block version is greater than 4.1, otherwise
> initialize as a NULL pointer for backwards compatibility.
> 
> Switch from broadcast_OR to broadcast_AND region (when defined in DT)
> for checking status bit 1 as Broadcast_OR region checks only for bit 0.
> 
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c       | 15 ++++++++++++++-
>   include/linux/soc/qcom/llcc-qcom.h |  4 +++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..cfdc7d9d7773 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -826,6 +826,7 @@ static int llcc_update_act_ctrl(u32 sid,
>   	u32 status_reg;
>   	u32 slice_status;
>   	int ret;
> +	struct regmap *regmap;
Reverse-Christmas-tree, please

>   
>   	if (IS_ERR(drv_data))
>   		return PTR_ERR(drv_data);
> @@ -849,7 +850,9 @@ static int llcc_update_act_ctrl(u32 sid,
>   		return ret;
>   
>   	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
> -		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
> +		regmap = (!drv_data->bcast_and_regmap) ? drv_data->bcast_regmap
> +			: drv_data->bcast_and_regmap;

<raised eyebrow emoji>

regmap = drv_data->bcast_and_regmap ?: drv_data->bcast_regmap

Konrad

