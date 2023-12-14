Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B368128C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjLNHJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:09:11 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E668E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:09:17 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db548da6e3bso247679276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702537756; x=1703142556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9O1GnUq4pw6hl4a/GhVKNLNjzNzEUMAMJcd0utEyLiE=;
        b=Jrg0onkEW7cZmLkXpgpixdbps3bf+3816C8u1ryDdu8/S6ggiSXCSaFC6mMW8w0mRq
         UCcapzzEQkiotnyscr46KOGVMADBNQB8Lk0O4I3sPvYR42qwV2NiiTCYUHIyDSOcTj5J
         KX67eBXfhmTtxwdOYnl58EhYT6avc+qjXpC8Lc6lidtfiTh31pPeBoZSAeblwtB8ienX
         D7n7IPRZXu3ERL9Ux/PnxTgMeiQKctPlssDqgCrNd80J91KRbtFFuEjbnPOEHugVglUe
         SPoqk+sChWeCYtEb89exiKxuTfeNxPHlG/ZNy83rxHQUcsWUPgu+fbnKQtjyMoLrYAO/
         cqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537756; x=1703142556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O1GnUq4pw6hl4a/GhVKNLNjzNzEUMAMJcd0utEyLiE=;
        b=tH77feORu5oYv0RC5m3zi2z2XFMTDkmEF7IKwLd/1tm2J9qjGLYp/7WX2Wq2kRpbH/
         McFAZb2BZqhImIdoNnE1g7PdlYKLd3tt3yi9ber/mFJLIPApnh6/ksvihLrFrFwTCZ/1
         tiOLqgihOnSpyH9x090qo/gKa6dSsS3LABhuh0JLLM61zAQ79iXFjmEpNddQ9AyhlmEg
         jOZzAE0GyEU8Iqa0E5H3/zhQ3wpMZUiY5hLI+ZfhFYC1sM51YfiT+6iCf6WWk6E2ckg7
         SIS/1vJKDMURBWvP78yaqxHdWUx8qOTA0v93ORy8H+jhK54BkF86U1dBDfUSAD83IfKe
         6cJg==
X-Gm-Message-State: AOJu0YyFeEwpm1CaO8NvvUdpv9WFyleQ2Sonfm/D9Nus7GBHBodjIwgO
        4ECBS7QUjcxNSaJmcPHA3fxrcUpLUFiX5a7OGcZhHw==
X-Google-Smtp-Source: AGHT+IG078aMdmbmisgdnRLiC9BHttQaRKTw1dmngc8Uzuyuor0vsPrA1eyS3c5KPIlT0ZUu4886PyAXYBHaW+v9aKM=
X-Received: by 2002:a25:8041:0:b0:dbc:ddf4:4b14 with SMTP id
 a1-20020a258041000000b00dbcddf44b14mr1157789ybn.50.1702537756642; Wed, 13 Dec
 2023 23:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-3-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-3-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:09:05 +0200
Message-ID: <CAA8EJpr61JuznqfdMG96mjrqquf2Qbfe=potB5vzk43XexWj2w@mail.gmail.com>
Subject: Re: [PATCH 02/10] clk: qcom: ipq5332: Add separate clocks for PCIe
 and USB for Combo PHY
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
> interface (PCIe/USB) can use this combo PHY and the PHY drivers are
> different for PCIe and USB. Hence separate the PCIe and USB pipe clock
> source from DT, and individual driver node can be used as a clock source
> separately in the gcc. Add separate enum for PCIe and USB pipe clock and
> change the parent in corresponding structures.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

Please use your full name for the git authorship and or the S-o-B
tags. This applies to the whole series.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index f98591148a97..aa0f616c3b1b 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -25,7 +25,8 @@ enum {
>         DT_SLEEP_CLK,
>         DT_PCIE_2LANE_PHY_PIPE_CLK,
>         DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
> -       DT_USB_PCIE_WRAPPER_PIPE_CLK,
> +       DT_PCIE_WRAPPER_PIPE_CLK,
> +       DT_USB_WRAPPER_PIPE_CLK,
>  };
>
>  enum {
> @@ -728,7 +729,7 @@ static struct clk_regmap_phy_mux gcc_pcie3x1_0_pipe_clk_src = {
>                 .hw.init = &(struct clk_init_data) {
>                         .name = "gcc_pcie3x1_0_pipe_clk_src",
>                         .parent_data = &(const struct clk_parent_data) {
> -                               .index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
> +                               .index = DT_PCIE_WRAPPER_PIPE_CLK,
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_regmap_phy_mux_ops,
> @@ -1072,7 +1073,7 @@ static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
>                 .hw.init = &(struct clk_init_data) {
>                         .name = "gcc_usb0_pipe_clk_src",
>                         .parent_data = &(const struct clk_parent_data) {
> -                               .index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
> +                               .index = DT_USB_WRAPPER_PIPE_CLK,
>                         },
>                         .num_parents = 1,
>                         .ops = &clk_regmap_phy_mux_ops,
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
