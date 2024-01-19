Return-Path: <linux-kernel+bounces-30863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BC83253B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04802B23FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85C208A4;
	Fri, 19 Jan 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bL60ujW0"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E51DA44
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650421; cv=none; b=nXbg0GOQ1ftRq9Pl6zT984oojJAcuN0xkjmjtXfJIvQ1ec0Cf7rw2QgJeMlpdhUCDKTpYaqjSKgD3SeNe+pEd8I34H4b2ngxnD32QJg6frzGIp3XyJ7nYU30Tpga/AT1afqdIILoTbCIYIMvRinWrCyZ1J+4am2T8KnURTfBdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650421; c=relaxed/simple;
	bh=8b0OH0xUnUIRqm4g1vnAVHY4vBjzdLIxY+MjcPSp0jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxvHQPUyCLUdX0faRM0jtS1eeDMBDb+9BypAvJv5UA8oYs9HhGObQfFAJaPlygc0CEw7edBHuYiCO1VIykDGloqE7lIT9qcglD3gmgEWNQ18+lgquIo9Y/t2hdU1BI9SoEYfjGNr/W/wAKWGmh6yAUYEROP1SDIdA4AeqQNMR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bL60ujW0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337be1326e3so405374f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705650418; x=1706255218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU1bMRxchSmRgivc/iAZKp78DVFdSvb1675ltw30IVs=;
        b=bL60ujW0DcTmiq77GU+RAoxvktoUtmKWTHwA/hygTgxEBuCTaIsgLctA/zrwx1DtYh
         ZrWIw31Sgu7eae0iVSiPMX1/H6BOaRixPUBn+8jkHlitzJSXhsYledrjU5h1QZRXv6qU
         xmr0bJ/v6398ByRYCf8MSzw7rQL9ekbBbcaA8qGbaJi3Qb+BjROHQQB8vXZD+wCKstph
         ae83zIJ0W8LjsaRcXyuvvfnrxIFMB02W2bBJjuNIxaQczHWudBBn3jYvJ1DJ8CcRr7dU
         gILzi6C8pF7qxdZ2O/f1H7ghmzc3Q3CwNL09Axwva2YIoKg/ByGUxbWR/dCQB+/MGabR
         03rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650418; x=1706255218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU1bMRxchSmRgivc/iAZKp78DVFdSvb1675ltw30IVs=;
        b=b3o8oEQBbbD7j01wLkgPgbmFhZnvsrtFGN/JC+z3OJ/PlyH+yJDGOA3GbPf/EJtjbP
         YGcOHS3fJx7dtE+7jIJSqNYAZbBEZNhD/YQx5nI1j/8N43qh0xMx9IelVE3QOon9ZgQB
         fTUu1FGwOXg+3jFsbZbkLt7ryGJrciH2ca3AVXcbCtYvwQZSU+7rOgNVe3PHAfHiN98Q
         jq0jICi8htbZKooaFlYcrFJ6Y07lsJH35HH+w9ACpiZAb1ND4tEvZ+8Lr8v6RJu0vyfa
         Od0/qd0HHqg0c1kdoPMN8ajp7+YEcGKBy9KdYYStLNrt4YIzRNIVluCPCNLpDZ0c/j09
         qOpw==
X-Gm-Message-State: AOJu0Ywifh5rjaUigzc2oBEVwiz1s85c+WQu6si8a8/vF0dFddvZH+kG
	WpGO0+Z5bA5fD5pIC0kTN2yge1+7C5tQaFjzjFyiCLE7HrfAm+EHiQC7K2/5JSc=
X-Google-Smtp-Source: AGHT+IEhw6s1pS2VfA22BXnpQeWJC5uAZOEj3NPjFPfG9FpToVt7TF8T+6POBzJJ7OClzcaST60Xjg==
X-Received: by 2002:adf:b319:0:b0:336:6d62:7647 with SMTP id j25-20020adfb319000000b003366d627647mr1345275wrd.5.1705650418658;
        Thu, 18 Jan 2024 23:46:58 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i6-20020adfb646000000b00337bc2176f6sm5800237wre.81.2024.01.18.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:46:58 -0800 (PST)
Message-ID: <456eaa3a-7f0c-4b28-aeca-2af60475011a@linaro.org>
Date: Fri, 19 Jan 2024 07:46:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] ASoC: codecs: wcd9335: drop unused gain hack
 remnant
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-6-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The vendor driver appears to be modifying the gain settings behind the
> back of user space but these hacks never made it upstream except for
> some essentially dead code that adds a constant zero to the current gain
> setting on DAPM events.
> 
> Note that the volume registers still need to be written after enabling
> clocks in order for any prior updates to take effect.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

lgtm,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   sound/soc/codecs/wcd9335.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 43c648efd0d9..deb15b95992d 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -3033,7 +3033,6 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
>   {
>   	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
>   	u16 gain_reg;
> -	int offset_val = 0;
>   	int val = 0;
>   
>   	switch (w->reg) {
> @@ -3073,7 +3072,6 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
>   	switch (event) {
>   	case SND_SOC_DAPM_POST_PMU:
>   		val = snd_soc_component_read(comp, gain_reg);
> -		val += offset_val;
>   		snd_soc_component_write(comp, gain_reg, val);
>   		break;
>   	case SND_SOC_DAPM_POST_PMD:
> @@ -3294,7 +3292,6 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
>   	u16 gain_reg;
>   	u16 reg;
>   	int val;
> -	int offset_val = 0;
>   
>   	if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT0 INTERP"))) {
>   		reg = WCD9335_CDC_RX0_RX_PATH_CTL;
> @@ -3337,7 +3334,6 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
>   	case SND_SOC_DAPM_POST_PMU:
>   		wcd9335_config_compander(comp, w->shift, event);
>   		val = snd_soc_component_read(comp, gain_reg);
> -		val += offset_val;
>   		snd_soc_component_write(comp, gain_reg, val);
>   		break;
>   	case SND_SOC_DAPM_POST_PMD:

