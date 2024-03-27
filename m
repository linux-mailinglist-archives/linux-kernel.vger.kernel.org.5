Return-Path: <linux-kernel+bounces-120569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48F88D979
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8428298798
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF47374DD;
	Wed, 27 Mar 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq5zoPr2"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F882C1A0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529410; cv=none; b=JRSBV0LtY1jpYTpLO8Ip//kIpWhMcjNvhT97Ynm2AUunhC55+aHv+VUiEzUNqxPqSBFyXRsMr6A6fPcvjFflDbLH3ehhY4Wr8g7Z1l2ddduoDEsOT7hB7S6FNUqYZfFMUBO9SH3E15ud0Bo8cs7sZE3rhO/aTC+epzn5ZhooTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529410; c=relaxed/simple;
	bh=G1T8j6kmbh5YKnwus41DkuQV/P9KjTNsZ6i0EFzmw3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi/aIZkCg6pzh8uE6kIAVaL+wLN5mjj64pIJIS6nKjz2cT0FdrwnfCU40Mq7PetyKpA94ihYJFhCo3rnFVTdmSsbUV0JXZF09FOAlQ1KGgYYXGG01ICDdo/4IynKYKq+teX3Y5uJmH2PeQzYciVwSfNv7UfzSIyTor8151ZEjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rq5zoPr2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6048635276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711529407; x=1712134207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pLYlN16RyWsxEwBzjLz8ThQC9SQHV7u2gPr9C5zHFq8=;
        b=Rq5zoPr2vFNS3kDEmj8NfosnY1yFn+nDuLgPdtu3u8ogbcqnfAT4xNf5v8J35D53QF
         E1S+NKtzbm0ovV34T9i/NJvNg+3zhxNeSD1D5jGci6ltHW0rcmhqs8qzUtCl5f2rgL8b
         f9VblLDCChd1kM1RPXHmBLc8zcPnqQENBUG9c4yRuNW9AgjMW30uoFFQHNwDOpr1bFnb
         z3WnK9WheVbFJcciKmqFkUqTVeG/PWmxXqADYzo/FLLV4QJuqppFn8sR80dPcn3zqgei
         MoBO2VRCz4xuhB6k2Elgajc/TZS8fjzQEADpysiuug6vyZdcVbIIuK78ARo2duZGsDDy
         bKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529407; x=1712134207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLYlN16RyWsxEwBzjLz8ThQC9SQHV7u2gPr9C5zHFq8=;
        b=e5+kDrE5NLyM8TV9NBw0/ALmTlzpvlXyKf3dPi9oosVolfmRtdQ+SIyTAHl/X0hgbo
         0jmVN/vTqWcH8iIWh83wZBt8I/S0kvjYrkopc8KyiOFLfJcpPzXnRrx6hJcpvbO1G0ZG
         FJCAsmh+AvOmp/x7mFvPWs5oLvLWIbFIuJ/Ej0q197XujMf7+Y2aGL4WoteujAHT2i+G
         kMzXGxj+vfJsXBKVkl71cdG/HtqdzSKXONajDQ7J5jndojjZeGX0+NjMgmnRzMg0PAOT
         0wEoKRQQrRmk6UPCW8qdPAR8fBCjeOxkN/9on7tYSjeD1nsRMnk6BYKvPFWi9EqgK6Jp
         /E4A==
X-Forwarded-Encrypted: i=1; AJvYcCXrrW0KSMWAGTZF1hHiiJYeyFUu5bMcTGuuQVVVlSKdeiHkZoakBzO7TmoQVI99KOo2mc01wfzd/HYSHc4vxZ9IRgRx+IdD+AW6j0C3
X-Gm-Message-State: AOJu0Ywq9zEJ4FLQDdDbBZ8igO5TIP4m4Sm+vpUDIHKpMd32Ox/RmSls
	AaIu/wvbrSqV2cvtSHPKXDPLuQ9KFGibr73bxaNDBGDvpHmN0xQ8b0QpmUrVysMdveaIs8BS3em
	RCYLXMvIbg1s249OJHE6uW10qDtFHbKCSFwrHPw==
X-Google-Smtp-Source: AGHT+IEABw9Q0JdmDvKgiS8uA31+HMp3kqLbyi2CuT4KgMzzWprj2LtLDfwFy6/eU3DS2O0M+a/cPSxeZju9nn66sIY=
X-Received: by 2002:a25:aa4b:0:b0:dc7:3166:ad25 with SMTP id
 s69-20020a25aa4b000000b00dc73166ad25mr414150ybi.25.1711529407085; Wed, 27 Mar
 2024 01:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327081850.2924870-1-quic_varada@quicinc.com> <20240327081850.2924870-3-quic_varada@quicinc.com>
In-Reply-To: <20240327081850.2924870-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 27 Mar 2024 10:49:56 +0200
Message-ID: <CAA8EJpoFw3Qyq+NRffe5HBUbCfdYv03oWgoUwkB6pbdVrF6LEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] clk: qcom: add IPQ9574 interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 10:21, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.
>
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs. Though exposing these as normal clocks would work,
> having a minimalistic interconnect driver to handle these clocks
> would make it consistent with other Qualcomm platforms resulting
> in common code paths. This is similar to msm8996-cbf's usage of
> icc-clk framework.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Use clk_hw instead of indices
>     Do icc register in qcom_cc_probe() call stream
>     Add icc clock info to qcom_cc_desc structure
> v3: Use indexed identifiers here to avoid confusion
>     Fix error messages and move to common.c
> v2: Move DTS to separate patch
>     Update commit log
>     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> ---
>  drivers/clk/qcom/Kconfig       |  2 ++
>  drivers/clk/qcom/common.c      | 34 ++++++++++++++++++++-
>  drivers/clk/qcom/common.h      |  4 ++-
>  drivers/clk/qcom/gcc-ipq9574.c | 54 ++++++++++++++++++++++++++++++++++

These changes must be separate.

>  4 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8ab08e7b5b6c..af73a0b396eb 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -243,6 +243,8 @@ config IPQ_GCC_8074
>
>  config IPQ_GCC_9574
>         tristate "IPQ9574 Global Clock Controller"
> +       select INTERCONNECT
> +       select INTERCONNECT_CLK
>         help
>           Support for global clock controller on ipq9574 devices.
>           Say Y if you want to use peripheral devices such as UART, SPI,
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..523d30d0ccbc 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -8,6 +8,8 @@
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
> +#include <linux/interconnect-provider.h>
>  #include <linux/reset-controller.h>
>  #include <linux/of.h>
>
> @@ -234,6 +236,36 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>  }
>
> +static int qcom_cc_icc_register(struct device *dev,
> +                               const struct qcom_cc_desc *desc)
> +{
> +#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)

General recommendation is to avoid #ifs inside function code. Please
move them outside and add an empty stub.

> +       struct icc_provider *provider;
> +       struct icc_clk_data *icd;
> +       int i;
> +
> +       if (!desc->icc_hws)
> +               return 0;
> +
> +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> +       if (!icd)
> +               return dev_err_probe(dev, -ENOMEM, "malloc for icc clock data failed\n");

No need to.

> +
> +       for (i = 0; i < desc->num_icc_hws; i++) {
> +               icd[i].clk = devm_clk_hw_get_clk(dev, desc->icc_hws[i], "");

Passing an empty string is not correct from the CCF point of view.

> +               if (IS_ERR_OR_NULL(icd[i].clk))
> +                       return dev_err_probe(dev, -ENOENT, "icc clock not found\n");

No, just IS_ERR and PTR_ERR. Don't throw away the resulting code.
In most of the case IS_ERR_OR_NULL is not correct. The function either
returns NULL or returns an error pointer. It can not be both.

> +               icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
> +       }
> +
> +       provider = icc_clk_register(dev, desc->first_id, desc->num_icc_hws, icd);
> +       if (IS_ERR_OR_NULL(provider))

just use PTR_ERR_OR_ZERO

Also note that there is no qcom_cc_remove, so please add
devm_icc_clk_register() and use it here:

return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, ...));

> +               return dev_err_probe(dev, PTR_ERR(provider),
> +                                    "icc_clk_register failed\n");
> +#endif
> +       return 0;
> +}
> +
>  int qcom_cc_really_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc, struct regmap *regmap)
>  {
> @@ -303,7 +335,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>         if (ret)
>                 return ret;
>
> -       return 0;
> +       return qcom_cc_icc_register(dev, desc);
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..3c3a07f6dcb9 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -29,6 +29,9 @@ struct qcom_cc_desc {
>         size_t num_gdscs;
>         struct clk_hw **clk_hws;
>         size_t num_clk_hws;
> +       struct clk_hw **icc_hws;
> +       size_t num_icc_hws;
> +       unsigned int first_id;
>  };
>
>  /**
> @@ -65,5 +68,4 @@ extern int qcom_cc_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc);
>  extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
>                                   const struct qcom_cc_desc *desc);
> -
>  #endif
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 0a3f846695b8..187fd9dcdf49 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -12,6 +12,7 @@
>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/interconnect/qcom,ipq9574.h>
>
>  #include "clk-alpha-pll.h"
>  #include "clk-branch.h"
> @@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
>         [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
>  };
>
> +#define IPQ_APPS_ID                    9574    /* some unique value */
> +
> +enum {
> +       ICC_ANOC_PCIE0,
> +       ICC_SNOC_PCIE0,
> +       ICC_ANOC_PCIE1,
> +       ICC_SNOC_PCIE1,
> +       ICC_ANOC_PCIE2,
> +       ICC_SNOC_PCIE2,
> +       ICC_ANOC_PCIE3,
> +       ICC_SNOC_PCIE3,
> +       ICC_SNOC_USB,
> +       ICC_ANOC_USB_AXI,
> +       ICC_NSSNOC_NSSCC,
> +       ICC_NSSNOC_SNOC_0,
> +       ICC_NSSNOC_SNOC_1,
> +       ICC_NSSNOC_PCNOC_1,
> +       ICC_NSSNOC_QOSGEN_REF,
> +       ICC_NSSNOC_TIMEOUT_REF,
> +       ICC_NSSNOC_XO_DCD,
> +       ICC_NSSNOC_ATB,
> +       ICC_MEM_NOC_NSSNOC,
> +       ICC_NSSNOC_MEMNOC,
> +       ICC_NSSNOC_MEM_NOC_1,
> +};
> +
> +static struct clk_hw *icc_ipq9574_hws[] = {
> +       [ICC_ANOC_PCIE0] = &gcc_anoc_pcie0_1lane_m_clk.clkr.hw,
> +       [ICC_SNOC_PCIE0] = &gcc_anoc_pcie1_1lane_m_clk.clkr.hw,
> +       [ICC_ANOC_PCIE1] = &gcc_anoc_pcie2_2lane_m_clk.clkr.hw,
> +       [ICC_SNOC_PCIE1] = &gcc_anoc_pcie3_2lane_m_clk.clkr.hw,
> +       [ICC_ANOC_PCIE2] = &gcc_snoc_pcie0_1lane_s_clk.clkr.hw,
> +       [ICC_SNOC_PCIE2] = &gcc_snoc_pcie1_1lane_s_clk.clkr.hw,
> +       [ICC_ANOC_PCIE3] = &gcc_snoc_pcie2_2lane_s_clk.clkr.hw,
> +       [ICC_SNOC_PCIE3] = &gcc_snoc_pcie3_2lane_s_clk.clkr.hw,
> +       [ICC_SNOC_USB] = &gcc_snoc_usb_clk.clkr.hw,
> +       [ICC_ANOC_USB_AXI] = &gcc_anoc_usb_axi_clk.clkr.hw,
> +       [ICC_NSSNOC_NSSCC] = &gcc_nssnoc_nsscc_clk.clkr.hw,
> +       [ICC_NSSNOC_SNOC_0] = &gcc_nssnoc_snoc_clk.clkr.hw,
> +       [ICC_NSSNOC_SNOC_1] = &gcc_nssnoc_snoc_1_clk.clkr.hw,
> +       [ICC_NSSNOC_PCNOC_1] = &gcc_nssnoc_pcnoc_1_clk.clkr.hw,
> +       [ICC_NSSNOC_QOSGEN_REF] = &gcc_nssnoc_qosgen_ref_clk.clkr.hw,
> +       [ICC_NSSNOC_TIMEOUT_REF] = &gcc_nssnoc_timeout_ref_clk.clkr.hw,
> +       [ICC_NSSNOC_XO_DCD] = &gcc_nssnoc_xo_dcd_clk.clkr.hw,
> +       [ICC_NSSNOC_ATB] = &gcc_nssnoc_atb_clk.clkr.hw,
> +       [ICC_MEM_NOC_NSSNOC] = &gcc_mem_noc_nssnoc_clk.clkr.hw,
> +       [ICC_NSSNOC_MEMNOC] = &gcc_nssnoc_memnoc_clk.clkr.hw,
> +       [ICC_NSSNOC_MEM_NOC_1] = &gcc_nssnoc_mem_noc_1_clk.clkr.hw,
> +};
> +
>  static const struct of_device_id gcc_ipq9574_match_table[] = {
>         { .compatible = "qcom,ipq9574-gcc" },
>         { }
> @@ -4323,6 +4374,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
>         .num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
>         .clk_hws = gcc_ipq9574_hws,
>         .num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
> +       .icc_hws = icc_ipq9574_hws,
> +       .num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
> +       .first_id = IPQ_APPS_ID,
>  };
>
>  static int gcc_ipq9574_probe(struct platform_device *pdev)
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

