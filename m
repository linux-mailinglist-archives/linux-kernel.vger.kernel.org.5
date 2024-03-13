Return-Path: <linux-kernel+bounces-102416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30887B1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA451F21538
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54A59163;
	Wed, 13 Mar 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxworgdJ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA015339D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357644; cv=none; b=ZacE4Cf1ZWJITgg4auEfhtUCpWzWSlbr2rEC9rui9/kTsoHMNs5DTRGZlWkVmYH08UyqGULqkJfhjsj25pkLi95dh/KgB+IURM0CH1zZjP7D2x8p62SSFRkjKKlJIpVCWgTMYVhxO6TaL2hNYskZnjWLms5/zNMXhH4aANrpSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357644; c=relaxed/simple;
	bh=VC3FYxAJ7LoxbZlZBeN1DYkzslCxNHfnh7tRxUYmCO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZy0rrrMJOKt16CKBGLLDxaU53AqEDDa0gDEeaHrybn5BNO21P0Qa1q0N86LIyXJOVrKr5VbzDKi6VXfWYQnOeJsv1CfiZKE8/KkuVWMStg1oQzEgGRInpa7RHmNQM4Pw5ZaYC5rkkWUgnWBn5L4SZfhSfPKBasCdcVIQFaCGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qxworgdJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dd045349d42so99252276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710357642; x=1710962442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMo4BjQfv07Q0PzE5HGh8mM1dLTyhXyrou/joPFvVAU=;
        b=qxworgdJ012HU18lqJoxv83RevI6FEJ/u9+a/X/A0hUulXEepSa5GjUonLxeTv2I6I
         135KFVR2KH0csdXWu7/gFVNzDplMEgLmB9fEhSLBa0UkbSYoNW3Tzx3mtbKEiLTcZ4Hp
         uK0M8lAhCnv6C0nRmnn7yPEw4mP8xYe5bQ9eAZ3As0KbvC78UDDRhmBvAQPKZ4BPnGYA
         /SpbP8nqGzd1bxbvoyzwiY3I7HU0DgWlJs0TjuaMnYnq1RUmAx+tgqaGB5q75fPiro3e
         uF4SqmwBjMe6++RKMJm6jfSNAKmMjs/xgQGZjyBp3njNnqpP5RAqMIqzruAo3sEd4pFZ
         ekHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357642; x=1710962442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMo4BjQfv07Q0PzE5HGh8mM1dLTyhXyrou/joPFvVAU=;
        b=ntd08C21Y21UzsPYPSnI2cXyXI3Ti8FKRiJHpxP0VFUAPVO8ncIkz9MUoxG/gRKeAI
         tmSQ5TEEU952sPrwoTtlb8o/xYuVVbQZVg7xT4Aqqd8MVz6gWXQ+trgpqQqRAmMOJSZq
         aAwyNgvwIcWW+nROu/24NXGoOTYPBqXaofGYx0tNfD+7T1j5AWXnbV86J/MsjaC+MeHY
         EW8FdGXag//g7viM99eondPG5bV9p5UBgtepzA2mpr7vv4WdSpdIuwYOVluHAP1sOmTU
         eehLZJL+wI6/a8U05QcGeydr5mtFRTCl8Hjc2VcktxfS8UdyBoMoFjm2sdTkoOhXGII9
         h38w==
X-Forwarded-Encrypted: i=1; AJvYcCVnw/Y8ncT3ZfqoVzY6MrM3hSqqFcCQd0e11U5TGVCgUyUdIuV9u46h/BmbAj6t8FyfwbQO4cQ7F4sf/ocr5afIEb0jN33atiAdy2X5
X-Gm-Message-State: AOJu0YwqFPoc46IHvL/GotcTXlpVkSExIiAL/jEHS9i/ui4aUxYPmSPK
	uMo3c3UloLD8gRLSxqjycN++VNifn1vb3OfW4iPftHvzVkZedbRsASjzk5w+AxFZpSsRUnEZelW
	7xIzzLCvyq2zSrUwEq5oPyRutPITgqN6EKhooxQ==
X-Google-Smtp-Source: AGHT+IF+pCz+zOs8ZUIs+gSDAT4ZOTitMDi1f/rT/9CPC1qIJVCwncoBoAEkgjvNR2PPBb39YCB5C47IhmON01t+UHE=
X-Received: by 2002:a5b:bc2:0:b0:dcd:59e4:620c with SMTP id
 c2-20020a5b0bc2000000b00dcd59e4620cmr2174398ybr.49.1710357642225; Wed, 13 Mar
 2024 12:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com> <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
In-Reply-To: <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Mar 2024 21:20:35 +0200
Message-ID: <CAA8EJpo63oRA07QNCdzJdHW_hJJWK6aj-LCpp-XwmPJYf0twZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Update SM8150 videocc bindings
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> Update the videocc device tree bindings for sm8150 to align with the
> latest convention.

But why? Bindings already exist. There is nothing wrong with them. And
sm8150 platform in general uses name-based lookup.

>
> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")

It is not a fix, there is no bug that this commit is fixing.

> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 1 +
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml        | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> index bad8f019a8d3..e00fdc8ceaa4 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - qcom,sm8450-videocc
>        - qcom,sm8550-videocc
> +      - qcom,sm8150-videocc
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index 6999e36ace1b..28d134ad9517 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -17,7 +17,6 @@ description: |
>      include/dt-bindings/clock/qcom,videocc-sc7180.h
>      include/dt-bindings/clock/qcom,videocc-sc7280.h
>      include/dt-bindings/clock/qcom,videocc-sdm845.h
> -    include/dt-bindings/clock/qcom,videocc-sm8150.h
>      include/dt-bindings/clock/qcom,videocc-sm8250.h
>
>  properties:
> @@ -26,7 +25,6 @@ properties:
>        - qcom,sc7180-videocc
>        - qcom,sc7280-videocc
>        - qcom,sdm845-videocc
> -      - qcom,sm8150-videocc
>        - qcom,sm8250-videocc
>
>    clocks:
> @@ -75,7 +73,6 @@ allOf:
>            enum:
>              - qcom,sc7180-videocc
>              - qcom,sdm845-videocc
> -            - qcom,sm8150-videocc
>      then:
>        properties:
>          clocks:
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

