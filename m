Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA257FAE89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjK0XlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjK0XlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B81B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:41:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75224C433C8;
        Mon, 27 Nov 2023 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701128486;
        bh=weP+2DgJBx1dYZy08M9yhRAGupDOCwbQuosE0EUyWV8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a7rXnkcZC0eEvflSMXIq1b0VcYoXkkWXq7OxnUI3DSeFDFGx+J/xGScO0HjQZfmMe
         LqYpPyoLGy2r+5CHC6aiamz5sN4VcghqVZvgYwctTYV2gTK3RlcyemaLO7XVfCZdsX
         e3faqKi6gg4r+yKlUMjZuo08wMW7AOwvfxjpa7z1LkXR1SHAXT9mMf6mgHJwCm6coh
         QTIrRv6awIasaqIatl+jqQiP9RYv+ySszOgyI6ZbeIO1Mnhlv2H7PLeR/tv9Duq0Eh
         h3P7/evhc5HEy5y1At1XjPkCfXOXXdN7Prv/qJh6g7aig9avY2WHIRtOKGnTZvfr4g
         HHOsRFJNAYLmw==
Message-ID: <729bbf75faad7c3a4ed74fffc3d84007.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231122-x1e80100-clk-tcsrcc-v1-2-43078c6d6452@linaro.org>
References: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org> <20231122-x1e80100-clk-tcsrcc-v1-2-43078c6d6452@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: Add TCSR clock driver for x1e80100
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Nov 2023 15:41:24 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-11-22 05:42:13)
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..6ed9c89d9070 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1116,4 +1116,12 @@ config SM_VIDEOCC_8450
>           SM8450 devices.
>           Say Y if you want to support video devices and functionality su=
ch as
>           video encode/decode.
> +
> +config X1E_TCSRCC_80100

Is the config symbol intentionally namespaced for X1E prefix to group
one SoC? Why not X1E80100_TCSRCC then?

> +       tristate "X1E80100 TCSR Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
> +       select QCOM_GDSC
> +       help
> +         Support for the TCSR clock controller on X1E80100 devices.
> +         Say Y if you want to use peripheral devices such as SD/UFS.
>  endif
> diff --git a/drivers/clk/qcom/tcsrcc-x1e80100.c b/drivers/clk/qcom/tcsrcc=
-x1e80100.c
> new file mode 100644
> index 000000000000..2ec142c3d1f9
> --- /dev/null
> +++ b/drivers/clk/qcom/tcsrcc-x1e80100.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,x1e80100-tcsr.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "common.h"
> +#include "reset.h"
> +
> +enum {
> +       DT_BI_TCXO_PAD,
> +};
> +
> +static struct clk_branch tcsr_edp_clkref_en =3D {
> +       .halt_reg =3D 0x15130,
> +       .halt_check =3D BRANCH_HALT_DELAY,
> +       .clkr =3D {
> +               .enable_reg =3D 0x15130,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(const struct clk_init_data) {
> +                       .name =3D "tcsr_edp_clkref_en",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch tcsr_pcie_2l_4_clkref_en =3D {
> +       .halt_reg =3D 0x15100,
> +       .halt_check =3D BRANCH_HALT_DELAY,

Why are these all branch halt delay but still have a halt_reg?

> +       .clkr =3D {
> +               .enable_reg =3D 0x15100,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const?

> +                       .name =3D "tcsr_pcie_2l_4_clkref_en",
> +                       .parent_data =3D &(const struct clk_parent_data){
> +                               .index =3D DT_BI_TCXO_PAD,
> +                       },
