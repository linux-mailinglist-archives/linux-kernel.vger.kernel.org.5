Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC77E2808
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjKFPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjKFPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:02:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E1BD69;
        Mon,  6 Nov 2023 07:01:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE65C433C7;
        Mon,  6 Nov 2023 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282913;
        bh=R/cSiyOAFRrqVhth3W2n5h61tFeVSdShjJRDQj6czH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUTy7kEFxYsF/koXOeL9ejldwPeR/VMnlbzSAsKZczqy5XRzb+OfUaZG3VAlG2kQS
         thRBrISP/mcyuHif2TfZM7A/Yw106zfROyEIZTGQN8Om4RW1Aa8CDTVpzB+bckC+Vp
         yXa7s5lX1p0u2J3AcCTx/nOeNqf0KSkE9Nrm3hkO6YDmcg4gWoQtmoTIZN+LzXMnp1
         YaBoFQohLbxhKyIM+1VaLfnPLwcvsm/7pZRnBKzz0+XsEXQf7UVHPv1J+obnd8Mi8V
         gN7hFzEdjVHwBRekbFUi0iRrUdb5bpiYeNlfb7kpvQIQ4bCormrcd9/Er50Vh/x+zj
         W5RSB+DvZf4Cg==
Date:   Mon, 6 Nov 2023 22:49:33 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] pwm: add driver for T-THEAD TH1520 SoC
Message-ID: <ZUj8/fhitNf8fRMf@xhacker>
References: <20231005130519.3864-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005130519.3864-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:05:17PM +0800, Jisheng Zhang wrote:
> T-HEAD SoCs such as the TH1520 contain a PWM controller used to
> control the LCD backlight, fan and so on. Add the PWM driver support
> for it.
> 
> Since the clk part isn't mainlined, so SoC dts(i) changes are not
> included in this series. However, it can be tested by using fixed-clock.
> 
> since v2:
>  - collect Reviewed-by tag
>  - add CTRL_ prefix for THEAD_PWM_CTRL register bit macros
>  - use pm_runtime_resume_and_get() instead of pm_runtime_get_sync() and
>    check its return value.
>  - remove unnecessary casts
>  - call pm_runtime_put_sync() when pwm channel is disabled
>  - use devm_pm_runtime_enable() and then drop .remove()
>  - properly consider if pwm is programmed by bootloader or other
>    pre-linux env.
>  - simplify thead_pwm_runtime_resume() code as Uwe suggested
>  - bool ever_started -> u8 channel_ever_started since we have 6 channels
>  - use 3 for #pwm-cells 
> 
> since v1:
>  - update commit msg and yaml filename to address Conor's comment
>  - use devm_clk_get_enabled() and devm_pwmchip_add()
>  - implement .get_state()
>  - properly handle overflow
>  - introduce thead_pwm_from_chip() inline function
>  - document Limitations
>  - address pm_runtime_get/put pingpong comment
> 
> 
> Jisheng Zhang (2):
>   dt-bindings: pwm: Add T-HEAD PWM controller
>   pwm: add T-HEAD PWM driver

Hi Thierry, Uwe,

Kind ping, is there any chance for this series to be merged for v6.7?

Thanks
> 
>  .../bindings/pwm/thead,th1520-pwm.yaml        |  44 +++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-thead.c                       | 270 ++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-thead.c
> 
> -- 
> 2.40.1
> 
