Return-Path: <linux-kernel+bounces-140292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62E8A1255
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD451C20F97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED41474CA;
	Thu, 11 Apr 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEOUjBIS"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FA146A74
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832980; cv=none; b=rxi/IjWXkcOxChRGeFX/3n+h/LDZhdcAEVexBbMyKE/3XCcLJiWBG+MZ7ZRXzKRD230VM53vrz6Gi/ZFhd6VcXgoyR7Yac5kjhlzmoOoCivPCWN7pgaoV7TXsJLaRjXZd8QDcPGOpJqqVMpHNKe9vIcTZng4E3A60kRzpeoSRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832980; c=relaxed/simple;
	bh=Xq/0joFiXzYqUks+vVl32eEq//+gRKOhLkmx39S+mn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tlr5cn3337oPTrmK1trEG39B+DDe1vFBtP4IrISUDqmYn0SI+WwDAxt626/sfDWW261pV40fB4UEJEH24uM7kw8GEJhWwXMPWa9f3/eUwEirqoaOdQsmmeY9aYLlxS3u+cXSDUXhz8PLWH5O1D/hEAs8iWi1HPFwKvUKwPr9et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BEOUjBIS; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617dfcf80aeso63430457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712832976; x=1713437776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGKOXnPZPzqd2pAhBq9S6tbEuJ6FZt58jgxu5zksa9E=;
        b=BEOUjBIS9K5AaucVXdaGZ1JcAgueDT2qS7i4UchwyFCyQqP/n4mx7kvDXyoR603Mmx
         XuF4tVJ+sXMMqg/6ZoUQ5/4WxcNxTs4Q3CdC3Li27/T+abVdzbtYe/9PmBVAPyR2duDQ
         VlvdQAiUnCfwvxyynA+LSM8OIk5Ole+WKqx10viOHraz57KTg9xH4WWpdSx7VJWQcC1T
         13EkngrIdTsV2/wgjglokJDqU2gTeLKFA7IHK17L41UqNudUXIyHVBypolYR0xLLYXNn
         XuqDhQEDk+dZ+09nq+5VU8a3bJ6wnvpwn0jdcXcQumZ2w8OLVogRZggkQumY4ioyleEW
         myRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832976; x=1713437776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGKOXnPZPzqd2pAhBq9S6tbEuJ6FZt58jgxu5zksa9E=;
        b=kTvWeovJNnHpmCcj8zbuNDNbywKHGSDfAg4RDlTUz7aSZF7/b65Lr5YTTzwvMMj0tw
         +1Bla/wBrSvCMGNaBpQEj4QG7T8ge3Nm12zpDackaeUiZ8/ib3wthimepj5IkQRfUp9E
         M06lYaPT6hEiO2IkYCeuQ1YJ8YSefBFbCUvqCfyNNFwxDWo4UxHvFC2JuCXDbPpRekvm
         ix19bkTvWdMJVFiY37pooSrbDJt70LmYRiOAj1NFpFWDi9ayL8ihEOu9dUFYzNK67eWf
         IcI0wnMLi92uhglfDrxZhqiYZiHTFpUVFOHmzYLTswZv82nt52eHFR7SAFhZHjI8ySmJ
         EVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxK044+xZYvJODtpNBYn5S+1uOz7ISceF7YxKp3wENH/zV5zVGx9b6Wfpx5PRd7kIe2kr00LYlMAEl2d9linF0nLZFG/lYl+6NBab
X-Gm-Message-State: AOJu0Yx5UlRw2S+alNoFa0aBh31y6xRIyKwpMb2WqNp86tkI3kWvbHxn
	5AZh2IRc+Cxp6l/SsNTWK0dpfx1lw4gNYx0M8HFvGdo9hLUM/4ugmqn0y8RAp+01pIBGJvOkqks
	ZrtOUieYZkfE+m9Szfw9dr9VfiBHiSxKrR43FkA==
X-Google-Smtp-Source: AGHT+IEy/8KjCoNQ5WH3BkBtCMtmPO/YjIHT2vwc1O1J5P+X6YoGvSoNRhQvRNcLN0kV94Yiga/Z1ELGCrrfAyrGLFE=
X-Received: by 2002:a05:6902:102e:b0:de0:f74b:25f3 with SMTP id
 x14-20020a056902102e00b00de0f74b25f3mr6033843ybt.60.1712832976450; Thu, 11
 Apr 2024 03:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-1-7bf56cb92b28@quicinc.com>
In-Reply-To: <20240411-pm8xxx-vibrator-new-design-v9-1-7bf56cb92b28@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Apr 2024 13:56:05 +0300
Message-ID: <CAA8EJpobbdUcpvycYYSWaJBmkywhUrPgo=N814ZipBEL9Z_azA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] input: pm8xxx-vibrator: correct VIB_MAX_LEVELS calculation
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
<devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>
> The output voltage is inclusive hence the max level calculation is
> off-by-one-step. Correct it.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Fixes tag?

>
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 04cb87efd799..89f0f1c810d8 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -14,7 +14,8 @@
>
>  #define VIB_MAX_LEVEL_mV       (3100)
>  #define VIB_MIN_LEVEL_mV       (1200)
> -#define VIB_MAX_LEVELS         (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
> +#define VIB_PER_STEP_mV        (100)
> +#define VIB_MAX_LEVELS         (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
>
>  #define MAX_FF_SPEED           0xff
>
> @@ -118,10 +119,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
>                 vib->active = true;
>                 vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
>                                                 VIB_MIN_LEVEL_mV;
> -               vib->level /= 100;
> +               vib->level /= VIB_PER_STEP_mV;
>         } else {
>                 vib->active = false;
> -               vib->level = VIB_MIN_LEVEL_mV / 100;
> +               vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
>         }
>
>         pm8xxx_vib_set(vib, vib->active);
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

