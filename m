Return-Path: <linux-kernel+bounces-47804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADC845318
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F61C24E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9316615AAC1;
	Thu,  1 Feb 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrQzeCp+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2A15A4BE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777361; cv=none; b=msmZHdYus6nc4j33Rgu07nPnbOJyObGuZXh7MVQR0keGMN+ZJ3eRvOQIpmMcEezfYLcM8WVAVyuWFxhMgp4qo+fj7kwPXSI31VFxg7N6+KqhakoAt3/PunvGqJ4VsOSOi0wE0O49fxIdMXL4EvTvHMEuYoPmM2zMZjr7faViNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777361; c=relaxed/simple;
	bh=FCOuo3whRBAH9fCCbmAfnat5ywEjsHLaGIcxJbOHtIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqOlBTsz6oXTHCVQN8LFVpbX35iedmBMIzAKYD6vTtaPo2dnLyVnZ1N/VRzubqE2qjtlkpOXhngWtWNU8+cR/Vy8PivxAnJou5uK0lF/pIVFeOlG7ZVTcMYwIjSUa5+sYMxyGM8/ioWeSixYQzjLaoVZ7Zv7jdhRPgHzj0DP9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrQzeCp+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso8913971fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777358; x=1707382158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHRSyujypVnylYvtGCOuwW4Y0R5uEJFGjZjMEzXEob0=;
        b=BrQzeCp+/CuxJuMXkoddZWZH8d4NtK9MU/TvpCVd5Wd/fzE/jHCEyBQhQ6Pan5j87J
         cmMoVHL9UYK7D/QYY7sjMZ1Iiig4DGByPqzfFk6X3pXCQGY46s18qdfJ+APYRXPP4km2
         YzYsHbFTv8MHdouGXS5vhs2OkDJ7Sh6VfYkOpgAvUBYKhbhs+To8QqoHng/KlwajdjQm
         znD9SxjLvhHfipL8phOuAgINkQhU973hBZfj0a6xzgvAfEyIoau9l2wK/Mh9W+hQK5o1
         0EHNuTV/gcUSPde0WaGDj6LNuyzibTt8VWhWaF/mHjmvVDumAQ8zFWEJbHdLhdR0LzHP
         X19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777358; x=1707382158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHRSyujypVnylYvtGCOuwW4Y0R5uEJFGjZjMEzXEob0=;
        b=nTpR/nnUd1hkiGob2W9MDf2pzZRrl/qg8rBOcpPxibLGkMMkcJcs7glz7b2X8ds0y7
         VxLBFciBtEAF8cDVSl07xmGtmylPdMo5zrCQ+nujOf9/8xj50AbIS7onm3Ms96m8LKKH
         6+sIzGxbEVmP8joljuu/BM3qFrK273PgSOS4zm+gyQGJt3nLjYSGCgZpw8eNuXgfPi6+
         t404MR0IIL+BQPSYttkir6nDkXH/Rs9Pz4KqzJury/x0UpA+i1Enn8176gkTXwm3Va/l
         OdravhpKUPQ8J4GVdbwlObwSn8XeCalZ0iuAQzvZnJ+dIbV1Fvw7CGwonzvIj1UgAdIt
         JNow==
X-Gm-Message-State: AOJu0YxgJIlrw9cB4tf1Ml+JkhBHo+RuPC3OejaLs3SqLaqu78AxlQwp
	YHesx4lsyethv3j6Egs4meKqRRTlfn/fui0gL7mkFdfyHOI4UHC5rNiHAfZQK8s=
X-Google-Smtp-Source: AGHT+IFT83pDiAtotK+SGsdHL6ockZWWFrbukVH+04w2+HmSL1mSIJgxdDpeNxKXm7FDBl9k22CYkw==
X-Received: by 2002:a2e:bb90:0:b0:2d0:5fa6:5f04 with SMTP id y16-20020a2ebb90000000b002d05fa65f04mr2404704lje.0.1706777357912;
        Thu, 01 Feb 2024 00:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbXjqGGXd0HSp2QJ3mJF6gY9TBIJb5bohlPEDqH9tRr67ry95lzPbAn8JygS7q2Je31rqiVOpYbbdCWs60K6sCNfU1IIRC9DyXZNXmvTs378i961wClLHJ9H8jt6qikaYN6LXRHeDAq0t0S/vWwvScEj/adTAmj7iLKFq7BVnIF1MOpMtD4i3UasUKxImdU4dZL7xxFwlpGnHtwRzipcpO1BxEpEWVKUXXhR5D/eZf6taz1CgRm5lmnROIvLpDQrSx7Sr/0RAUMC5urrIDUiwR2U0QtEGOiWMeHzko9pgQ1ar8qAlhM9UF4FoDPYNtnl4oExm87yv0jl1uZq0/i6zARUPHEYLRAgutU8suJ1dwXOEdsUIC7nn2usUUVRzecVMleSW3R85gy6VTNHT7EJ3+lJKs/+3Z
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005598e3d6d23sm6551798edb.16.2024.02.01.00.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:49:17 -0800 (PST)
Message-ID: <3a352f75-ee92-497f-a988-a7636e84a176@linaro.org>
Date: Thu, 1 Feb 2024 09:49:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] dt-bindings: arm: tegra: Add LG Optimus Vu P895
 and Optimus 4X P880
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-3-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131105153.8070-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 11:51, Svyatoslav Ryhel wrote:
> From: Maxim Schwalm <maxim.schwalm@gmail.com>
> 
> Add a compatible for the LG Optimus Vu P895 and Optimus 4X P880.
> 
> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
> index fcf956406168..9b3c565b21c4 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> @@ -64,6 +64,14 @@ properties:
>        - items:
>            - const: asus,tf700t
>            - const: nvidia,tegra30
> +      - description: LG Optimus 4X P880
> +        items:
> +          - const: lge,p880

NAK, it is not lge, but lg.

Best regards,
Krzysztof


