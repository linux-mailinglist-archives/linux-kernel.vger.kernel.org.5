Return-Path: <linux-kernel+bounces-61671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33793851530
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0329287AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140913D56D;
	Mon, 12 Feb 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cf53r4jR"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790C3A8ED
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743922; cv=none; b=Z04Nk6fbZX9Nc9v4x0m3sF/aVblmQRoA/9jTB1K9NXsKmsW5oXqpIKNvWbxVMk30ZzZtFX4Hn2x7ymseSRyHGOAVpDuyDKAuWblz9fXNEHu3cKCDOubdOIuXfuurRm+9eoCPIkR4/eMbnqSFqZHJ+Xu2wCqDXpea2UfuLgUVt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743922; c=relaxed/simple;
	bh=+WzR0/Plgj4RqrsNGL0DQcCrsC1lpai3jmjW+byx+Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crViclhquEAYgwipiUJSh1VRAtjQenpSaDHuXD5zeJEGqxR8aI2WN30IDGu/t9/Sy9fbayvSo4DYvrTQGStteWMzUq1TnUSjHxTtK9pbw3l5Cc5K+LZZoTrcbEds42YLKiO796b07u4Lm5l0WDERBtXX5u7BHLGkMxXXd9ykx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cf53r4jR; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74aac68a1so3091838276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743919; x=1708348719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+4O7T+QNAB1EyOlytFcAI0HkI63SoJwqZgkRk9iFYU=;
        b=cf53r4jRC52ooiTk7xtkDszEfDqhRLlFHeO9bmjG7WZNEv/2eJT3BZYiP0Nadi5BwP
         BVLKJo6EC0xSOOx7tOSc31DYNLpQETaZbjzBV1jBLVkxe3lPRg6yVioJqy6w7oq7msrJ
         WDunCFOJbKw6AEps4f/AUrS/EolDPYeIhy9lpYOO9nm3gfzBepou43i61assp8bqbrrW
         ohosr3KmYFEdC8F/863+RZCZ+WywzolZR9D0MvAbFfRTiG2IizwMNgqpfKcqZSV11S1c
         i4gN9vo66tFhCKinLluMcDFSYgcsp8ufOq93elxnaq47X2TFVZ2G3Boohv9fXyl0pxeK
         fq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743919; x=1708348719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+4O7T+QNAB1EyOlytFcAI0HkI63SoJwqZgkRk9iFYU=;
        b=hV6aGUZFzx+3Zcxe4Vk0KmyIlWioJkfJu9tH/e9ioDu3G34ssSAUAmIJBUZ6Cr1mid
         VlDa2BP4MIvNoR1U3WISkwhdl69cCl9Sl3ifbTxj7fSVdeOD4b0PbhdpcP/arwQz6dnZ
         mikbCAwvJRQaV7Bkg5EcykO2jiw71VZWVLGV6FAqB1hQdrQgJJDhyHXBV6D7TLtjx0SY
         6uzddyhp6JvahO7XYYH7Yu6e296SjTwajMn6IKTfzMs/Y81NIxFo0USPF6EYxgJl2L6g
         mi8rMc5Hv9weJt7XNvd0tD+XTFpltOas0G+TG6DNIj5J2jtlQvWSQfQ137XR2uLxBTT8
         E3fw==
X-Gm-Message-State: AOJu0Yy+iz4fNJQpTCYuH95w8lQ5IlTKACHuN5d0s8YIHHEpdLO07JAH
	tZBFAU4GPT0OOdeMyAKjg1GG//+8ayO/uV0UcXM4oBYt1+n5irnkPb42oy5/1nr9BMEKimaiOQf
	uzG+45/fbboTx+xHM3cncBF9iYsRA5RM970eQAg==
X-Google-Smtp-Source: AGHT+IEanT3FSaEWgyDfDfpVTZv0Tz/F4vvSuGO1dH8EO7Kuf6Vx7dgNh0AYreub1pylYw0FLpDAoMrr9anLSHhEAz8=
X-Received: by 2002:a25:aaa6:0:b0:dc6:9b89:3f75 with SMTP id
 t35-20020a25aaa6000000b00dc69b893f75mr5912473ybi.40.1707743919225; Mon, 12
 Feb 2024 05:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-3-quic_jkona@quicinc.com> <CAA8EJpqbKQS7Bp28xNZ0twu7BFLdOES9qS5xBvoonux8Ma4q6Q@mail.gmail.com>
 <e90522c1-7a2d-40ff-bf4e-c8f974722ddf@quicinc.com> <CAA8EJpqCDOE_5vg+4ew8H0HbhQM1w8reqU6Pu0MAYJtMw8zXUw@mail.gmail.com>
 <d88f0f42-c9ec-4638-8090-055bc4806574@quicinc.com>
In-Reply-To: <d88f0f42-c9ec-4638-8090-055bc4806574@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:18:27 +0200
Message-ID: <CAA8EJpq9AE_B9rvXRa1Q803yWzmwZxwiF_hwokq8XJZgJy59PA@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: qcom: videocc-sm8550: Add support for SM8650 videocc
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Imran Shaik <quic_imrashai@quicinc.com>, 
	Ajit Pandey <quic_ajipan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 15:07, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
>
>
> On 2/7/2024 12:49 PM, Dmitry Baryshkov wrote:
> > On Wed, 7 Feb 2024 at 08:59, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/6/2024 5:24 PM, Dmitry Baryshkov wrote:
> >>> On Tue, 6 Feb 2024 at 13:39, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
> >>>>
> >>>> Add support to the SM8650 video clock controller by extending the
> >>>> SM8550 video clock controller, which is mostly identical but SM8650
> >>>> has few additional clocks and minor differences.
> >>>
> >>> In the past we tried merging similar clock controllers. In the end
> >>> this results in the ugly source code. Please consider submitting a
> >>> separate driver.
> >>>
> >>
> >> Thanks Dmitry for your review. SM8650 has only few clock additions and
> >> minor changes compared to SM8550, so I believe it is better to reuse
> >> this existing driver and extend it.
> >
> > I'd say, the final decision is on Bjorn and Konrad as maintainers.
> >
> >>
> >>>>
> >>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >>>> ---
> >>>>    drivers/clk/qcom/videocc-sm8550.c | 160 +++++++++++++++++++++++++++++-
> >>>>    1 file changed, 156 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> >>>> index f3c9dfaee968..cdc08f5900fc 100644
> >>>> --- a/drivers/clk/qcom/videocc-sm8550.c
> >>>> +++ b/drivers/clk/qcom/videocc-sm8550.c
> >>>> @@ -1,6 +1,6 @@
> >>>>    // SPDX-License-Identifier: GPL-2.0-only
> >>>>    /*
> >>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>     */
> >>>>
> >>>>    #include <linux/clk-provider.h>
> >>>
> >>> [skipping]
> >>>
> >>>>    static struct gdsc video_cc_mvs0c_gdsc = {
> >>>>           .gdscr = 0x804c,
> >>>>           .en_rest_wait_val = 0x2,
> >>>> @@ -354,15 +481,20 @@ static struct clk_regmap *video_cc_sm8550_clocks[] = {
> >>>>           [VIDEO_CC_MVS0_CLK] = &video_cc_mvs0_clk.clkr,
> >>>>           [VIDEO_CC_MVS0_CLK_SRC] = &video_cc_mvs0_clk_src.clkr,
> >>>>           [VIDEO_CC_MVS0_DIV_CLK_SRC] = &video_cc_mvs0_div_clk_src.clkr,
> >>>> +       [VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr,
> >>>>           [VIDEO_CC_MVS0C_CLK] = &video_cc_mvs0c_clk.clkr,
> >>>>           [VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC] = &video_cc_mvs0c_div2_div_clk_src.clkr,
> >>>> +       [VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr,
> >>>>           [VIDEO_CC_MVS1_CLK] = &video_cc_mvs1_clk.clkr,
> >>>>           [VIDEO_CC_MVS1_CLK_SRC] = &video_cc_mvs1_clk_src.clkr,
> >>>>           [VIDEO_CC_MVS1_DIV_CLK_SRC] = &video_cc_mvs1_div_clk_src.clkr,
> >>>> +       [VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr,
> >>>>           [VIDEO_CC_MVS1C_CLK] = &video_cc_mvs1c_clk.clkr,
> >>>>           [VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC] = &video_cc_mvs1c_div2_div_clk_src.clkr,
> >>>> +       [VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr,
> >>>>           [VIDEO_CC_PLL0] = &video_cc_pll0.clkr,
> >>>>           [VIDEO_CC_PLL1] = &video_cc_pll1.clkr,
> >>>> +       [VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr,
> >>>>    };
> >>>>
> >>>>    static struct gdsc *video_cc_sm8550_gdscs[] = {
> >>>> @@ -380,6 +512,7 @@ static const struct qcom_reset_map video_cc_sm8550_resets[] = {
> >>>>           [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
> >>>>           [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
> >>>>           [VIDEO_CC_MVS1C_CLK_ARES] = { 0x8090, 2 },
> >>>> +       [VIDEO_CC_XO_CLK_ARES] = { 0x8124, 2 },
> >>>
> >>> Is this reset applicable to videocc-sm8550?
> >>>
> >>
> >> SM8550 also has above reset support in hardware, hence it is safe to
> >> model above reset for both SM8550 and SM8650.
> >
> > Then, separate commit, Fixes tag.
> >
>
> Sure, will separate and add Fixes tag in next series.
>
> >>
> >>>>    };
> >>>>
> >>>>    static const struct regmap_config video_cc_sm8550_regmap_config = {
> >>>> @@ -402,6 +535,7 @@ static struct qcom_cc_desc video_cc_sm8550_desc = {
> >>>>
> >>>>    static const struct of_device_id video_cc_sm8550_match_table[] = {
> >>>>           { .compatible = "qcom,sm8550-videocc" },
> >>>> +       { .compatible = "qcom,sm8650-videocc" },
> >>>>           { }
> >>>>    };
> >>>>    MODULE_DEVICE_TABLE(of, video_cc_sm8550_match_table);
> >>>> @@ -410,6 +544,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
> >>>>    {
> >>>>           struct regmap *regmap;
> >>>>           int ret;
> >>>> +       u32 offset;
> >>>>
> >>>>           ret = devm_pm_runtime_enable(&pdev->dev);
> >>>>           if (ret)
> >>>> @@ -425,6 +560,23 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
> >>>>                   return PTR_ERR(regmap);
> >>>>           }
> >>>>
> >>>> +       if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8550-videocc")) {
> >>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = NULL;
> >>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = NULL;
> >>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = NULL;
> >>>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = NULL;
> >>>> +               video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = NULL;
> >>>
> >>> Please invert the logic. Make video_cc_sm8550_clocks reflect SM8550
> >>> and patch in new clocks in the SM8650-specific branch below.
> >>>
> >>
> >> Sure, will add these clocks as NULL in video_cc_sm8550_clocks and patch
> >> in new clocks here for SM8650. Then we can remove above check for SM8550.
> >
> > No need to set them to NULL, it is the default value. Just add them to
> > the sm8650 branch.
> >
>
> The video_cc_sm8550_clocks[] array size is fixed and has memory
> allocated only for current sm8550 clocks. To be able to accommodate
> sm8650 clocks in the same array, we need to initialize the clocks to
> NULL as below snippet to increase the array size.
>
> static struct clk_regmap *video_cc_sm8550_clocks[] = {
> .....
>         [VIDEO_CC_XO_CLK_SRC] = NULL,
> }

The question/comment was regarding video_cc_sm8550_probe() rather than
video_cc_sm8550_clocks.

>
> Thanks,
> Jagadeesh
>
> >>
> >> Thanks,
> >> Jagadeesh
> >>
> >>>> +               offset = 0x8140;
> >>>> +       } else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
> >>>> +               video_cc_pll0_config.l = 0x1e;
> >>>> +               video_cc_pll0_config.alpha = 0xa000;
> >>>> +               video_cc_pll1_config.l = 0x2b;
> >>>> +               video_cc_pll1_config.alpha = 0xc000;
> >>>> +               video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
> >>>> +               video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
> >>>> +               offset = 0x8150;
> >>>> +       }
> >>>> +
> >>>>           clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> >>>>           clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
> >>>>
> >>>> @@ -435,7 +587,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
> >>>>            *      video_cc_xo_clk
> >>>>            */
> >>>>           regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
> >>>> -       regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
> >>>> +       regmap_update_bits(regmap, offset, BIT(0), BIT(0));
> >>>>           regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
> >>>>
> >>>>           ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

