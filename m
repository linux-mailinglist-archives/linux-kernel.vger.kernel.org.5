Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5057FA036
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjK0NCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjK0NCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:02:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A91DCAA;
        Mon, 27 Nov 2023 05:02:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB75D2F4;
        Mon, 27 Nov 2023 05:03:02 -0800 (PST)
Received: from [10.57.71.110] (unknown [10.57.71.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB393F73F;
        Mon, 27 Nov 2023 05:02:10 -0800 (PST)
Message-ID: <87d7235c-8d3f-42df-b1ed-ea0abe5af3b9@arm.com>
Date:   Mon, 27 Nov 2023 13:02:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, asutoshd@codeaurora.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231121091101.5540-3-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 09:10, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
> 
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
> 
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> —--
> v6 -> v7:
> - Remove reset-names in driver and adjust reset control's code.
> 
> v5 -> v6:
> - Fix linux coding style issues.
> - Drop useless code that is not described in the bindings.
> - Replace devm_clk_get and clk_prepare_enable with devm_clk_get_enabled.
> - Replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL.
> 
> v4 -> v5:
> - Fix linux coding style issues.
> - Fix test robot build errors to make good use of setup_tran_desc
>   call back function.
> - Remove useless function.
> 
> v3 -> v4:
> - Modify dma mode selection and dma addressing bit to statisfy
>   linux coding style.
> 
> v1 -> v2:
> - Remove dw_mci_cqe_set_tran_desc due to the duplicated function.
> - Add ->pre_enable() / ->post_disable()
> 
> v0 -> v1:
> - Seperate different support into single patch.
> - Fix the compiler complains.
> ---
> ---
>  drivers/mmc/host/Kconfig      |   13 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/dw_mmc_cqe.c | 1467 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe.h |  456 ++++++++++
>  4 files changed, 1937 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.h
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 58bd5fe4cd25..06bb4de28cc4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -837,6 +837,19 @@ config MMC_DW_STARFIVE
>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
>  	  for platforms based on StarFive JH7110 SoC.
>  
> +config MMC_DW_CQE
> +	tristate "Synopsys DesignWare Memory Card with CQE Interface"
> +	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +	select MMC_CQHCI
> +	help
> +	 This selects support for the Synopsys DesignWare Mobile Storage IP
> +	 block after JEDEC Standard version 5.1. Select this option for SD and
> +	 MMC interfaces that use command queue.
/after/according to/ ?
Does the hardware actually implement both: SD and MMC CQ?
If so that would be very interesting, but also not currently supported by mmc layer.
