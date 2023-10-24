Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B57D4415
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJXAej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjJXAeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:34:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFB10C;
        Mon, 23 Oct 2023 17:34:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F2CC433C8;
        Tue, 24 Oct 2023 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698107675;
        bh=jm4cUu1Woa9OgzmQ0ndOww8g+k+sCkruBbPjIo/bzSI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cZgLuAbJKNEvWLyOR74XM+R4BpOsqsUlKiwSAyO1Rt/CXI503XfP2CZUH1o9xqXGT
         lcsuSg/4ZslXnZq8UaPmriUnofQ3jt/dL64yJmDHsB3L1cI8t1OpxrexNNOjE91AqX
         Zj3iVm4N1392ZxZfhyLL97wlR7owtPU+FmihSaHRlbd5/UZM8vXnQVm1VkWkp3Brbs
         bPu/1vvGfIjMWk0O5RZkignc2zgB8L8wM4DsqxRo9Kuy0cKFCp8SSS1XgE0VFeBABF
         KPKT5eUZeFUAOTckC2fx4ZtWO3WQqGBxHhI741OlLBUhKo7uH7hDauEclOdrjdwFrb
         j/NX3P5H0MG3A==
Message-ID: <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231023153821.189331-4-bryan.odonoghue@linaro.org>
References: <20231023153821.189331-1-bryan.odonoghue@linaro.org> <20231023153821.189331-4-bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3.1 3/4] clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        dmitry.baryshkov@linaro.org, jonathan@marek.ca,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, quic_tdas@quicinc.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org
Date:   Mon, 23 Oct 2023 17:34:33 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bryan O'Donoghue (2023-10-23 08:38:20)
> diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-s=
c8280xp.c
> new file mode 100644
> index 000000000000..0631bd5fad57
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sc8280xp.c
> @@ -0,0 +1,3048 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>

Is this include used?

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Should be mod_devicetable.h instead?

> +#include <linux/of.h>

Is this include used?

> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

This got included twice.

> +
> +#include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
> +
> +#include "clk-alpha-pll.h"
