Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94147E3AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKGLSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjKGLSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:18:48 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA111D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:18:45 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a90d6ab962so64672837b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699355925; x=1699960725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQGe6mNztA93E1vhMaP9OoY2/CZNCEpDDK/s+WkFPnI=;
        b=EnFiixIytwk3XoCxhb3yPTrknvALwow6D5TsvQnzBJwNpCecBOyzkhJ337yXvCXdvX
         vHzjxIJnCUmIy9HpxrFhtKQoJ783iHCkUmF0OlOpZBHcyd6yXdW4J8528FIBO242Y0wR
         pwW1GUbPVplxMJ1ZyITIyPqjZt6vKRC+H1fXUJrqU7PWXkasbD2iF2M8WM+HrqDBGaE/
         7JEZ3D9QW1DLXzDUsWntDgAiyNK2VHaMLp2wTVOxvqSIcsugqlOHLxNw31ka+Jn09oCe
         +GJI0e2a+87rIqUnOIhY64ThY1FbbWd+C+CTJjsCe/CtLnrvRONVFV4oc9iikj2HS+RH
         eAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355925; x=1699960725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQGe6mNztA93E1vhMaP9OoY2/CZNCEpDDK/s+WkFPnI=;
        b=Tg/Gm3rtJ7oDd4AgvJkVYkLg9AqwqBq/shps+gA/dq+vQZxrYqTQ0TAYPS7Rahl+PU
         7zaOUQpQmpNIHz7UUA2VdgvdNjIdj9ooFli4lNjCCUfU0sd3TRISsJ9cglce+6la+HKj
         f4FYLgnnrogs5HOtUkSGfUDEnhN0L4CejrAffoe2gjtwlTXRoHghvCCSfO9F3X1sdj8B
         uxMRvznXv84VIEtjheDRP7wIgBoSoxkT0SYM/9zKsu7Hg7Ru3VmLq99p8PWL0Tv1KF0g
         F4QBSA9HqBGQCm9Hkqa2oWh1WKwX0F36uHi5W+nUWbrM/6MfSnISMT9G1l50C5M5YMlx
         xHrA==
X-Gm-Message-State: AOJu0YxmEzDby4576YR/s/D1OCdGPRe4pff9xnbvLZIM/bWno2nlEiBS
        1yOPRwkJduMEoKdCF8XI8q+N3hSSX+3KU7+qL9u7Fw==
X-Google-Smtp-Source: AGHT+IFFsEhPnerAY8XwonvVxogJKJiZC9RcaEADdZ7gCKoSrkvwJ/ancft1LPF0r9cwbvoXEpKqianptNR/KAZyYJU=
X-Received: by 2002:a25:900b:0:b0:d9a:e129:92a1 with SMTP id
 s11-20020a25900b000000b00d9ae12992a1mr31802617ybl.54.1699355924917; Tue, 07
 Nov 2023 03:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20231107064545.13120-1-quic_jkona@quicinc.com>
In-Reply-To: <20231107064545.13120-1-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 13:18:33 +0200
Message-ID: <CAA8EJpoLaXgxue-+pry8VK4Ln00Dk-jXG_Ev9ot5k8bbonP3Qw@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Fix SM_CAMCC_8550 dependencies
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 08:46, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> SM_GCC_8550 depends on ARM64 but it is selected by
> SM_CAMCC_8550, which should have the same dependencies
> as SM_GCC_8550 to avoid the below Kconfig warning reported
> by kernel test robot.
>
> WARNING: unmet direct dependencies detected for SM_GCC_8550
>   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
>   Selected by [y]:
>   - SM_CAMCC_8550 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]
>
> Fixes: ccc4e6a061a2 ("clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..dbc3950c5960 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -767,6 +767,7 @@ config SM_CAMCC_8450
>
>  config SM_CAMCC_8550
>         tristate "SM8550 Camera Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
>         select SM_GCC_8550
>         help
>           Support for the camera clock controller on SM8550 devices.
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
