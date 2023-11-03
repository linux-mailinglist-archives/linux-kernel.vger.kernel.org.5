Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A63A7E09F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378155AbjKCULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKCULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:11:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B92D61;
        Fri,  3 Nov 2023 13:11:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40308C433C8;
        Fri,  3 Nov 2023 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699042304;
        bh=3LHRc8rww849/6wAkBU/sr464fjAyyToo/wNBBArVDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLV9uboIii2WaWOBW6KVPc7nBjq7UPg4F0/bfPRm2WrzM1B0UQCZAg7yrJ6mghEDJ
         ka7eDHgGCSTM33dWvfWmE9yTtGNDbdvUX3DZLefVVoezOI+bbgEPGaGgh10oRg9oVl
         M1w3CZzdoGJMD+z08Ws67bK9JNpxHj/FBcgGseI3a93Ofr44155ph8W3yHXKe16+ZI
         RnF7d6VjSp9PIouVAxkCsgVLLQ5Rt1WG7v4iLJ0XSTDtH87Na4BZ4Ik5gxQ9g5Wfiy
         SWk0xhEQwVFH0p7e7WX1X9I6+ahg2hQDLrFhRWp7TAqiTwx1SVBIfPdxftosbX0uow
         dEZgmpsCtli+A==
Date:   Fri, 3 Nov 2023 13:15:49 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH RESEND v3 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to
 switch video GDSC to HW mode
Message-ID: <v4dnsawo7s74spccrsvjwmal73tqfq4aptiny25tyyp6ungxha@jlbywvcssqtl>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-gdsc-hwctrl-v3-4-0740ae6b2b04@linaro.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:04:10AM +0200, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> The current HW_CTRL flag switches the video GDSC to HW control mode as
> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
> give consumer drivers more control and switch the GDSC mode as and when
> required.
> 
> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
> 

This states what the code currently does, and what the new code will do.
But I don't find that it adequately describes _why_ this is done.


In the current implementation, the hardware is might collapse the GDSC
anytime between gdsc_enable() and gdsc_disable(). By giving "drivers
more control" the time spent in this state is reduced to some fraction
of that span, which to me implies higher power consumption.

Under the assumption that we don't want to consume more power without
reason, I'm forced to guess that there might be some scenarios that we
want this feature to keep the GDSC non-collapsed against the indication
of the hardware - to avoid some instability somewhere, perhaps?

Regards,
Bjorn

> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/videocc-sc7180.c | 2 +-
>  drivers/clk/qcom/videocc-sc7280.c | 2 +-
>  drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>  drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>  drivers/clk/qcom/videocc-sm8550.c | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
> index 5b9b54f616b8..51439f7ba70c 100644
> --- a/drivers/clk/qcom/videocc-sc7180.c
> +++ b/drivers/clk/qcom/videocc-sc7180.c
> @@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
>  	.pd = {
>  		.name = "vcodec0_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
> index 615695d82319..3d07b1e95986 100644
> --- a/drivers/clk/qcom/videocc-sc7280.c
> +++ b/drivers/clk/qcom/videocc-sc7280.c
> @@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
>  		.name = "mvs0_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc mvsc_gdsc = {
> diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
> index c77a4dd5d39c..dad011c48973 100644
> --- a/drivers/clk/qcom/videocc-sdm845.c
> +++ b/drivers/clk/qcom/videocc-sdm845.c
> @@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
>  	},
>  	.cxcs = (unsigned int []){ 0x890, 0x930 },
>  	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> @@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
>  	},
>  	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
>  	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index ad46c4014a40..c1b73d852f1c 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
>  	.pd = {
>  		.name = "mvs0_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> @@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
>  	.pd = {
>  		.name = "mvs1_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> index f3c9dfaee968..404c6600edae 100644
> --- a/drivers/clk/qcom/videocc-sm8550.c
> +++ b/drivers/clk/qcom/videocc-sm8550.c
> @@ -322,7 +322,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
>  	.parent = &video_cc_mvs0c_gdsc.pd,
> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
>  };
>  
>  static struct gdsc video_cc_mvs1c_gdsc = {
> @@ -347,7 +347,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
>  	.parent = &video_cc_mvs1c_gdsc.pd,
> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
>  };
>  
>  static struct clk_regmap *video_cc_sm8550_clocks[] = {
> 
> -- 
> 2.34.1
> 
