Return-Path: <linux-kernel+bounces-165210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E838B898E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BF21C21F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE29D84D35;
	Wed,  1 May 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a02aGNCL"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A050A65
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565226; cv=none; b=O2t2x455mo/Cnd77g0921Z6n4y8ggi5+A/8k2khIfnC7Typl85oAuQOUbv3SLRqjgdgtVQOPc90o9j2Ir53XvqRQQU6unmZwfebpQgBetZxAENNPCIOz52F3ccNwAzoNubwXuy9nv4+RvvQg1kQtM98kW8zTHROrSZvY+YS9Rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565226; c=relaxed/simple;
	bh=u1dlaFlPJ+AaQyl9OQnnDFMsqcgVZH5TuPxFAlJ8bUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4HvBcpsqk3/QOBay7dQoX4lhIH9vztELc5LSHZaPDlZBgtp4j4XCXM2X/HmeReqEgJdw9aOh9MrFRrrGy9cEGwGOn8/rVEnJVCKJkryqX/W2R2o53bygeu9r1REIPKaONejVNyJXt2pAAGdpSWBx5NYhSV4CITlGtW+agVqkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a02aGNCL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de462f3d992so7203537276.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714565220; x=1715170020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mCvDUdkZWf1z1LfPrcItKDo/SV8BQ5Ruhas6l/TQZks=;
        b=a02aGNCLZBPsPZaT8aAzUDLNUmd7BcIv9zedqYB6qHEXSympFfIetGQESk+uZVXfx0
         OSWboePE0B96ENxY+3mgT2uAYbeibeve48w7OFuISq+fvzvWPTmQYY9omctr/um0VRFf
         cKrL2xwLPkx/xWUur/lh9lHjVos5s1DpoK1JnMpFbszxDiNk9VM11WubMHpSX07fN9nr
         sm98t7X1xNEyO2t1Z1dJNgTXRpmmXA33KcCxiNktAIM1zhExV8V7N6yXKAiVw5Yfzg/e
         6JDHzbVY2x3j7/IRNuw/riCCt/P/Q5sBtHtv/KIXUcnkkL9V/mzNMUgtQjJdvpE4LqbF
         x3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565220; x=1715170020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCvDUdkZWf1z1LfPrcItKDo/SV8BQ5Ruhas6l/TQZks=;
        b=JNNtYPcfV8gh8MdqFCFkO1kw6VQ3KvejVl5d3OztrVEMjXKNGU3fmyK5F8NkCFTpzO
         fmMMU6Q00W8feMxBOC84Jo29FTpz4FNwHoAOzLqY0Pd9BRHVPnFLvR5HwfE6knDZIP7G
         IxXwyLakn/dX+hAJZQsKs4bZuoUja/sO7XVrx9qTr1js7GzzdwNyjq9aR0Mih23/URu2
         EcIRXWDdrN4C9nFv+l8tgtSPaYMheYeoefqhuVncyQ+57qyArlLXQLl7VHdeh39atfuT
         TUcognsmPjLdxaWgnbcYympFRh7LpirA5V8vTy1kVAIBNQ0gb4bTHr0WNomCMrsaC8Yu
         hJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC3En4EhrErkRoyqEFIr5d0m1U+qNKX1xoClY6AHvjiQRkClGIGsUfUEzNN3IXdS4ychJpaOZfLNI4K9cjWQMpu576IoRyiFY4S3JT
X-Gm-Message-State: AOJu0YyW7OL0Yjg06x/e8MlVXz9BfKaGdIWGK0Er97MO19EYtXBf0Dud
	7LKRc0HXKEgdSwikZYAVNaxu6JImLeuqJP1ECGpOBzgW9kbqIgSplPdviTZEB6wNkzawEhH5BPb
	lD1MYnAtshlH0wdu0rUGhqMjaqYZ+EHk2LWTaGQ==
X-Google-Smtp-Source: AGHT+IFHeR4+6oPbMDpIgLANFPthRRl3FtDwtWeTDKENSgiYemQbaXFo5PkJ4rVesjVGx/goWAJdI8/djjHv/AbyLf4=
X-Received: by 2002:a25:ac07:0:b0:dcd:3663:b5e5 with SMTP id
 w7-20020a25ac07000000b00dcd3663b5e5mr1751231ybi.25.1714565220205; Wed, 01 May
 2024 05:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-videocc-sm8150-dt-node-v3-0-2c4bd9ef48bd@quicinc.com> <20240501-videocc-sm8150-dt-node-v3-1-2c4bd9ef48bd@quicinc.com>
In-Reply-To: <20240501-videocc-sm8150-dt-node-v3-1-2c4bd9ef48bd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 1 May 2024 15:06:48 +0300
Message-ID: <CAA8EJpotvs3AOYO3ct=_JabBdYDops4Yfdutga9KBAbVPoZ5yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: qcom: Add AHB clock for SM8150
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

On Wed, 1 May 2024 at 11:32, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> SM8150 videocc needs AHB clock, so update the bindings for sm8150
> to add the AHB clock.
>
> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")

The tag is incorrect. The mentioned commit didn't add sm8150 bindings,
so it didn't have a bug.

> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index 6999e36ace1b..68bac801adb0 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -75,7 +75,6 @@ allOf:
>            enum:
>              - qcom,sc7180-videocc
>              - qcom,sdm845-videocc
> -            - qcom,sm8150-videocc
>      then:
>        properties:
>          clocks:
> @@ -101,6 +100,22 @@ allOf:
>              - const: bi_tcxo
>              - const: bi_tcxo_ao
>
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sm8150-videocc

Could you please extend the sm8250 case instead of defining a new one?
Also could you please check if there is a clock (like ahb_clk_src)
that uses bi_tcxo_ao instead of bi_tcxo? If so, we have to add this
clock to the bindings even if the driver doesn't use/model it at this
point.

> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: AHB
> +            - description: Board XO source
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bi_tcxo
> +
>    - if:
>        properties:
>          compatible:
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

