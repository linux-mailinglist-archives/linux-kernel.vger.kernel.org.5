Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E167D7705
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYVqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:46:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D436133;
        Wed, 25 Oct 2023 14:46:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB8DC433C7;
        Wed, 25 Oct 2023 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698270359;
        bh=D7K9D5FkQxgI+SxQC2ZWcKW+hmigiiDTP+3F/4Ccoos=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jwAbudX9bC9v0VbbXMfuHgmVqzQuXUqOLU4dWO87PvFwb66c9JF6EgyOGqeih7bFH
         q2p1WxFlZKTO+rZjt6AbBHWETd6deW6TIHCCwSAmXK1kRu8Z8d9vKc57NVM1RFD0nI
         L5uSZMNQyxs4/aZBM+y7/J0HixEBFgODVTU8C9b72h5GFif1AK+AMT9KfNvldB9eWr
         e2PgGWY/WL9bdWHOfmbOlzzGxTQoo1V3sLhkU9fnF/uwSjHIkx6ewHc4Y3znTDQcrB
         yEbKCuKGrzhc17pwd0MoFyzRx/LpCBR5+iWCJNqlZsbJBPSTo3mscgBR/vRo6YVXA6
         z0PblSkximmiw==
Message-ID: <a939ef1a4c2cad763fe484cc943f44d5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-8-c89b59594caf@linaro.org>
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org> <20231025-topic-sm8650-upstream-clocks-v1-8-c89b59594caf@linaro.org>
Subject: Re: [PATCH 08/10] clk: qcom: add the SM8650 Display Clock Controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 Oct 2023 14:45:57 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2023-10-25 00:32:45)
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index c04b6526f4f3..5bf25e8d033c 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -842,6 +842,15 @@ config SM_DISPCC_8550
>           Say Y if you want to support display devices and functionality =
such as
>           splash screen.
> =20
> +config SM_DISPCC_8650
> +       tristate "SM8650 Display Clock Controller"
> +       depends on SM_GCC_8650

selects?

We use selects instead of depends so that the driver can be built-in or
modular regardless of parent clks that provide clks to this device.
Orphan clk handling resolves issues with the driver registering clks
before parents. And with fw_devlink the driver isn't even attempted to
probe before the GCC driver is probed so there's no build dependency
between these drivers.

> +       help
> +         Support for the display clock controller on Qualcomm Technologi=
es, Inc
> +         SM8650 devices.
> +         Say Y if you want to support display devices and functionality =
such as
> +         splash screen.
> +
>  config SM_GCC_4450
>         tristate "SM4450 Global Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-s=
m8650.c
> new file mode 100644
> index 000000000000..7cb91306e895
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sm8650.c
> @@ -0,0 +1,1806 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Is this mod_devicetable.h?

> +#include <linux/of.h>

Is this include used?

> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <dt-bindings/clock/qcom,sm8650-dispcc.h>
> +
> +#include "common.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"

Is this include used?

> +#include "reset.h"
> +#include "gdsc.h"
> +
