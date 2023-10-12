Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476007C77CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442701AbjJLUTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347375AbjJLUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:19:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB2BB;
        Thu, 12 Oct 2023 13:19:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5FFC433C7;
        Thu, 12 Oct 2023 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697141993;
        bh=1w9tmt3+s2Cw6gjksSzd4+LnjhCxmFxThwc7u2OEO40=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kDq3ZB8Yzrdfi+09U4iPx/0bycBidEiPLQhB7JjcFFAK8Lbgbq+204TE0qvE0geMr
         IsLBuwR4c/WMDO5N5RAsg4OwdhtqKcHRsQ/ch7SUm/v/QrnYfC+KMXKdv8LwaCdqIf
         YfqSm5JzU6xvlezsAlTmUU5rs7GMV+ZS6pO2E7ARPfLJvdvjF2zo6xvewp3k8v/vha
         t52xxy8238rabB9uRmFSyXq/rf0gs7cbOsWYlGx03wowKIHVH2XYIZrEtmQmL5FLZ8
         g39uxc13xMEDPWCyLbIwgSCJVRN24EnK2g8Vj+79UP8F8ZZCSnAyEJNs3xOKti/7Id
         ZPRkOzWbppIEw==
Message-ID: <c656a6b8ac2feefda16e6d1d548a9f80.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011090028.1706653-4-quic_imrashai@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com> <20231011090028.1706653-4-quic_imrashai@quicinc.com>
Subject: Re: [PATCH V2 3/4] clk: qcom: Add ECPRICC driver support for QDU1000 and QRU1000
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Oct 2023 13:19:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Imran Shaik (2023-10-11 02:00:27)
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3194c8beb06d..60a981ff2bac 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -667,6 +667,14 @@ config QDU_GCC_1000
>           QRU1000 devices. Say Y if you want to use peripheral
>           devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
> =20
> +config QDU_ECPRICC_1000
> +       tristate "QDU1000/QRU1000 ECPRI Clock Controller"

This needs a 'depends on ARM64 || COMPILE_TEST' type of line here.

> +       select QDU_GCC_1000
> +       help
> +         Support for the ECPRI clock controller on QDU1000 and
> +         QRU1000 devices. Say Y if you want to support the ECPRI
> +         clock controller functionality such as Ethernet.
> +
>  config SDM_GCC_845
>         tristate "SDM845/SDM670 Global Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpric=
c-qdu1000.c
> new file mode 100644
> index 000000000000..e26912f3dd39
> --- /dev/null
> +++ b/drivers/clk/qcom/ecpricc-qdu1000.c
> @@ -0,0 +1,2466 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights =
reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

What is the of.h include for? Did you mean mod_devicetable.h instead of
of_device_id?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
