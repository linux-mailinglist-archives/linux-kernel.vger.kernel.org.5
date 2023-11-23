Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34567F6190
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjKWOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FEA4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:34:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A54C433CA;
        Thu, 23 Nov 2023 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750074;
        bh=UQZtD3/J3EWnFay8ssfBnsqxH7p2amiDhWgYKfTALAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLKhMH45lRed+KJ6STR6/3MFTjtf2H5ttXPl++EXW5oXxN5ZADshoxAH3rjdI/XmN
         FQmAysB71pY/tMhWGAscAyE6GwlsOv3l8MrcZh2s7HDOoiKl3yd6WwgE6yzzEtzq2L
         QICQbbCCR4hklr2qYY7tlPIcrUN1WZ0RC/jTdpWho5iFEtxZGG6ZNmv/6vJmazsiPr
         93Ps2rZnFk+FlIfxhpPRiY6nMcDv+ZzhNZiZMiPtAQQcnudYPS2xnU6p8AJZl5IL4l
         Q1ifqstmNG1GZ7qmfmFghsSRc5yaxRHIzCabLf/E7Fy//Yq1bOQu7RWACDuHHCm8Fn
         xvtLgNDaWA4Kg==
Date:   Thu, 23 Nov 2023 14:34:28 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add driver support for
 DWMAC5 fault IRQ Support
Message-ID: <20231123143428.GH6339@kernel.org>
References: <cover.1700737841.git.quic_jsuraj@quicinc.com>
 <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62eaaace3713751cb1ecac3163e857737107ca0e.1700737841.git.quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:08:15PM +0530, Suraj Jaiswal wrote:
> Add IRQ support to listen HW fault like ECC,DPP,FSM
> fault and print the fault information in the kernel
> log.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 1ffde555da47..bae1704d5f4b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -690,9 +690,25 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  #endif /* CONFIG_OF */
>  EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
>  
> +int stmmac_get_fault_intr_config(struct platform_device *pdev, struct stmmac_resources *res)

Hi Suraj,

stmmac_get_fault_intr_config() appears to only be used in this function.
If so it should be static.

Also, please consider limiting Networking code to 80 columns wide.

static int stmmac_get_fault_intr_config(struct platform_device *pdev,
					struct stmmac_resources *res)

...

-- 
pw-bot: changes-requested
