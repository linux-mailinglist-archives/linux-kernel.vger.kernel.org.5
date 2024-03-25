Return-Path: <linux-kernel+bounces-116575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AE88A35C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337EDB62466
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937296EB4C;
	Mon, 25 Mar 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMnjZA/Q"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964536E61C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348707; cv=none; b=hRWdM0PL5gO4ZnMZ2ag+j1q0dI4PLXi9XgmvKOYG/kYGjI5cnuR/VCh4fLENryM5kGVs1VfHG30soqJ/zvo1/td4WI9j6y1YYwGiOgamAbNAzATdzh9XD01eR5Xg+kAF1YE1aoUlXemx01pn+6ildGl3EnQkNgIaLkHUO7mYStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348707; c=relaxed/simple;
	bh=4i0LrcqQfdxh0wBkrbGzcOqHsBS9Fzn/wjjrEd4d4cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lW8o6waHp3IHuLY+n0zHIfGL0sc0SQ8c40bjqmt+6qs8F+z7YC9CzuGmswhyle8QuaENU9GOyMuwn53aZe88watw3HxZEl6Pau8gCl/G1agK+BMWTNw2WVOFcFBWWxeGTZkASdTGIbcuUs3nWWxlabjDT7E6lbFVU0zWNsbtDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMnjZA/Q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a434ea806so42845137b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711348703; x=1711953503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P94WpazcthFHooNXweOqRe4bZaBx4ZOjrA7P4ZyrdQg=;
        b=vMnjZA/Q00ASci/vz6dj2/ptPTqAD5xLRMXPo/oAaGYdW4Ge3ZyYXNWdIRaSUwF2pB
         2d6rkdBEusloyrrUMDJKRrrj4jNH0xA2vipb5uciIPTDCErSq8MjgQxuWNS5CtxcW0UV
         dN6zCrIG1szm3s/oL9Y3127g1XPMZLj8wDGHg1BwfGuHhBT6Me+H07hfCnPA1d0GIrSv
         7XvzDoEHYdchGxqQAzuC0pP4DIftVExrJ1UVNxwuVSw7kHdJmipITZzJbWnh0a6a5svb
         j4sbJCjLHjDDZfsB84N9lOo6wI/ebRzHX90xXzWCd80Fo9PqoNvnhG8A0yqgkeXKZiQX
         RH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348703; x=1711953503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P94WpazcthFHooNXweOqRe4bZaBx4ZOjrA7P4ZyrdQg=;
        b=byD/7Ts8rjO1aGJkuvSk250whOUojF00STYfTHJ0fYn0oQT1Gglu1hYs3VqPBmgSHV
         QyKDpOC1MC8489hNVOyGhQ34P7eQ/yU+eUvz8XbFM9CGXch5j6VR57Nnzv3K+CQIyN2+
         QeFQujdReR58roj/FA/pdjT/t2DacA92v2lqk2cRyxaD+liEso0pbre24Dd46oJOcS4a
         W6kqg5RZZcZNMOttLS9ZvlnnXREpDxJMXzSI9tVIb1OxIsxB6W3K+L5uZ7dJ4+HtFZvE
         CYXakosdgLvLGNn+wtzgXTTzb/zMNCfueuL682JIlq2GrZQPIaqYXRaEEIC3eob3qyVb
         B4rw==
X-Forwarded-Encrypted: i=1; AJvYcCWET5GX1E0iFheg41lBsEgl2DTl+Bc82rX17zTz8qTUl3nuM5N1RSn0L8islTryxkqS9HZMFiDjQCc9ecNRK6oXYI71myWOaG6TE10W
X-Gm-Message-State: AOJu0YyuiHLhsqWeF5cdbswCcIachSOW28suKwdfcMnxwC7NIL9LrFNm
	IoXcORqhmgvY5zrAm1X+kzUbHGx5ZVIVS5ngqhkCvpPpAVQsVTSX/YTpprRZoy9S8iqeCh5A7jT
	iWpzM4gePMKF/CszePes+Zs/BcjeL05NGgOTHCA==
X-Google-Smtp-Source: AGHT+IEqOvejSD4Lf2NcHEah77Yv4NuieZDiNHekky+PlOMm9ykOXP/rgEnUhYuUsqZXUkpTNQlaRLJBbXBbXb1XAsI=
X-Received: by 2002:a05:6902:103:b0:dcf:a4a9:98bd with SMTP id
 o3-20020a056902010300b00dcfa4a998bdmr4232188ybh.20.1711348703619; Sun, 24 Mar
 2024 23:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-2-quic_jkona@quicinc.com> <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
 <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
In-Reply-To: <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 25 Mar 2024 08:38:12 +0200
Message-ID: <CAA8EJpqUdEXYFaqH3HZKsx0iucq3pLe3HoMNRLWhsBs27W16PA@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video
 clock controller
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 08:08, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
> > On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>
> >> Extend device tree bindings of SM8450 videocc to add support
> >> for SM8650 videocc. While it at, fix the incorrect header
> >> include in sm8450 videocc yaml documentation.
> >>
> >> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
> >>   include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 +++++++-
> >>   2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> index bad8f019a8d3..79f55620eb70 100644
> >> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
> >>
> >>   maintainers:
> >>     - Taniya Das <quic_tdas@quicinc.com>
> >> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
> >>
> >>   description: |
> >>     Qualcomm video clock control module provides the clocks, resets and power
> >>     domains on SM8450.
> >>
> >> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
> >> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
> >
> > This almost pleads to go to a separate patch. Fixes generally should
> > be separated from the rest of the changes.
> >
>
> Thanks Dmitry for your review.
>
> Sure, will separate this into a separate patch in next series.
>
> >>
> >>   properties:
> >>     compatible:
> >>       enum:
> >>         - qcom,sm8450-videocc
> >>         - qcom,sm8550-videocc
> >> +      - qcom,sm8650-videocc
> >>
> >>     reg:
> >>       maxItems: 1
> >> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
> >> index 9d795adfe4eb..ecfebe52e4bb 100644
> >> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
> >> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
> >> @@ -1,6 +1,6 @@
> >>   /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>   /*
> >> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >>    */
> >>
> >>   #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
> >> @@ -19,6 +19,11 @@
> >>   #define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
> >>   #define VIDEO_CC_PLL0                                          10
> >>   #define VIDEO_CC_PLL1                                          11
> >> +#define VIDEO_CC_MVS0_SHIFT_CLK                                        12
> >> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
> >> +#define VIDEO_CC_MVS1_SHIFT_CLK                                        14
> >> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
> >> +#define VIDEO_CC_XO_CLK_SRC                                    16
> >
> > Are these values applicable to sm8450?
> >
>
> No, the shift clocks above are part of SM8650 only. To reuse the
> existing SM8550 videocc driver for SM8650 and to register these shift
> clocks for SM8650, I added them here.

At least it deserves a comment.

>
> Thanks,
> Jagadeesh
>
> >>
> >>   /* VIDEO_CC power domains */
> >>   #define VIDEO_CC_MVS0C_GDSC                                    0
> >> @@ -34,5 +39,6 @@
> >>   #define CVP_VIDEO_CC_MVS1C_BCR                                 4
> >>   #define VIDEO_CC_MVS0C_CLK_ARES                                        5
> >>   #define VIDEO_CC_MVS1C_CLK_ARES                                        6
> >> +#define VIDEO_CC_XO_CLK_ARES                                   7
> >>
> >>   #endif
> >> --
> >> 2.43.0
> >>
> >>
> >
> >



-- 
With best wishes
Dmitry

