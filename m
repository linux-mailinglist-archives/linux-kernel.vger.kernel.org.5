Return-Path: <linux-kernel+bounces-30840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60358324F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A1D1C23362
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397DCA4E;
	Fri, 19 Jan 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lL+8NVOT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5096FB0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648538; cv=none; b=IjHycfavks65aNmVzAR018HG8sAYsR4/UvirVH7NfodGLxF6JfP5kyi9ZZZGqMFwD91Oc//fqHnX6VJRun/2fBKR47tRmUpD0CD0CqaWAjYvvgWHUNYZ4io2LeUuaY1Rf/EbrFlLqA0WS95seDzJLXzN6znR3cwRM83eV1SycfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648538; c=relaxed/simple;
	bh=bu6TtoDHXYj08cbRRnS9+PBQHmEtpwdovbn9SIGetKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bvwp0VJbeOT4WgP0I85wXSBVYyYarfEii29fkcmw1tKBZrZC4F8mP9CQX7bS1WR1OVpy+NuRv5lfoesS26uKZ8kHboESDF/z8aWj37dwrryGtnQj1LrxP7N13+yjkiDKqZh1t+tvGb6qC1BE/hbl6QKP3Z0/GzoY3Z4pwDX46xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lL+8NVOT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so5096095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705648535; x=1706253335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHFKB+KTysp6kwejewof3DWQa8w1eNlV5qVrsykVh5c=;
        b=lL+8NVOT2DoyAECiwYaZdY4tyi9WitC3A/pdglurzXyAlNpLK5z8JxX+Cr5H56bNuN
         kbaoRjdj63Scat/VgeC6B2S8TMT2+BkardZvgx5bBenFDYlRmztjij1wIjftqQcT8kkP
         GaW7DP5whohr5nymAxh/W3hhhY8evCi4HMuabnztJvzGE14dxLdFwXk6QNZvKNnzuULP
         e6gTBBH+vBBDtquAxFwiwSCZQYb4EwqREnY/x+KECitnNn3KTAho6CRsFjNewsxGRHCk
         M5N05lBamJuYqt8mfR8L9XS4trf6SFQxhb+u85zwyLvjkkqHiMftmdsV+dYQO5z94WFO
         EOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705648535; x=1706253335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHFKB+KTysp6kwejewof3DWQa8w1eNlV5qVrsykVh5c=;
        b=sAWsTgw36K/jFjtqB79fP6ZHGKURFR85m4w0Rsu52ifnKruz7zweRZq3SgOTlZdW1k
         uNnwpqxnvwTJHsRH+LidKQ6rVygrkR/wohgXqaQmfXgg6RNRySCS/rjCWK8qcuv4B0MX
         X7tZIUxNt7IDPObNLSrUnp/Na1whWiI02jF4avqtJbpxJSTNCMWQH09CBZRrgNurOcae
         0dgF4zrau6SYIW19bD9BQzEBQW6omwOZQkDofHrfAKypwWzsKXO6tUVJ4F97zZuY7jTy
         Rtsm1//QzVAxASzqx1M7XCJ/M7s5qdKU8s1IsavKpuwb8Sq9irBEaTGqTf9v1KLI/9ZR
         n7mQ==
X-Gm-Message-State: AOJu0YxmhypsIUsY8kbrnZAnlE3pKqWln5fdrunDjCMEATlxbPnoMW/o
	55cOzmdvRUESyXFOS8ENnXszD5rSnwFcUursZ3OyqdKO73tmYI9FnDtN76tVTwI=
X-Google-Smtp-Source: AGHT+IF+flK3TANqdZk9xzA4fDQ608SzAK+XwelcQRt5520BMqyeOX3b4lxpmwKeq2jytRjqDhs2ug==
X-Received: by 2002:a05:600c:54d2:b0:40d:5d07:55d3 with SMTP id iw18-20020a05600c54d200b0040d5d0755d3mr849828wmb.177.1705648535092;
        Thu, 18 Jan 2024 23:15:35 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 2-20020a05600c020200b0040ea00a0b75sm14034wmi.0.2024.01.18.23.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:15:34 -0800 (PST)
Message-ID: <63e000c7-deae-44df-8d82-a74ffe303e9a@linaro.org>
Date: Fri, 19 Jan 2024 07:15:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-3-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The default PA gain is set to a pretty high level of 15 dB. Initialise
> the register to the minimum -3 dB level instead.
> 
> This is specifically needed to allow machine drivers to use the lowest
> level as a volume limit.
> 
> Cc: stable@vger.kernel.org      # 6.5
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/wsa883x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index 32983ca9afba..8942c88dee09 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] = {
>   	{ WSA883X_WAVG_PER_6_7, 0x88 },
>   	{ WSA883X_WAVG_STA, 0x00 },
>   	{ WSA883X_DRE_CTL_0, 0x70 },
> -	{ WSA883X_DRE_CTL_1, 0x08 },

this is hw default value.

> +	{ WSA883X_DRE_CTL_1, 0x1e },
>   	{ WSA883X_DRE_IDLE_DET_CTL, 0x1F },
>   	{ WSA883X_CLSH_CTL_0, 0x37 },
>   	{ WSA883X_CLSH_CTL_1, 0x81 },

