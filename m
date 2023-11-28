Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28007FB4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjK1Ixo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjK1Ixm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:53:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE20A7;
        Tue, 28 Nov 2023 00:53:47 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 725A866072B4;
        Tue, 28 Nov 2023 08:53:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701161626;
        bh=lqU97J14dyNbQfuGPI3DBzSk5f6hhk3SdPRlrhwNnpc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RfJ+7KZ662HMfIPZPO7Y5WjUIokD0yE16fjwmp+LiVgmrZecWbgK6gs3IVmKYQ7tD
         D8OXxcPyrt8+uTjKJN8sMz1s1TPLwQLZ0IMbr8TVgO+MTE17oSCWf4ZHwP045XVkyg
         gza0sTU5XWpXxiiCFoej+kbptGxCGkNeHvqGWHr527PbfhgSYyldRglm8ijH59/SdI
         V8FOsHg+EEsrvcQXMWx3jr+KQqA7dYmjWJA+WO8I7OCK4lc7idnXDd2LBdhivmO9pa
         tLnSGLHOauyrMuZI22hqxc8glV0522yvzym8yMMf/4ebP+5eyoCNerdhzB5M1HqQ89
         GU88w/2EKiL6A==
Message-ID: <207c2f89-b1e7-448d-966f-0c403a9f9e8b@collabora.com>
Date:   Tue, 28 Nov 2023 09:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
To:     Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231128070127.27442-1-axe.yang@mediatek.com>
 <20231128070127.27442-3-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231128070127.27442-3-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/11/23 08:01, Axe Yang ha scritto:
> Previously, during the MSDC calibration process, a full clock cycle
> actually not be covered, which in some cases didn't yield the best
> results and could cause CRC errors. This problem is particularly
> evident when MSDC is used as an SDIO host. In fact, MSDC support
> tuning up to a maximum of 64 steps, but by default, the step number
> is 32. By increase the tuning step, we are more likely to cover more
> parts of a clock cycle, and get better calibration result.
> 
> To illustrate, when tuning 32 steps, if the obtained window has a hole
> near the middle, like this: 0xffc07ff (hex), then the selected delay
> will be the 6 (counting from right to left).
> 
> (32 <- 1)
> 1111 1111 1100 0000 0000 0111 11(1)1 1111
> 
> However, if we tune 64 steps, the window obtained may look like this:
> 0xfffffffffffc07ff. The final selected delay will be 44, which is
> safer as it is further away from the hole:
> 
> (64 <- 1)
> 1111 ... (1)111 1111 1111 1111 1111 1100 0000 0000 0111 1111 1111
> 
> In this case, delay 6 selected through 32 steps tuning is obviously
> not optimal, and this delay is closer to the hole, using it would
> easily cause CRC problems.
> 
> You will need to configure property "mediatek,tuning-step" in MSDC
> dts node to 64 to extend the steps.
> 

If we can run 64 tuning steps, why should we run 32?

Why isn't it just better to *always* run 64 tuning steps, on SoCs supporting that?

Thanks,
Angelo

> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 135 +++++++++++++++++++++++++++-----------
>   1 file changed, 97 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 97f7c3d4be6e..c8297f501a1e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -252,12 +252,16 @@
>   
>   #define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/* RW */
>   #define MSDC_PAD_TUNE_DATRRDLY	  GENMASK(12, 8)	/* RW */
> +#define MSDC_PAD_TUNE_DATRRDLY2	  GENMASK(12, 8)	/* RW */
>   #define MSDC_PAD_TUNE_CMDRDLY	  GENMASK(20, 16)	/* RW */
> +#define MSDC_PAD_TUNE_CMDRDLY2	  GENMASK(20, 16)	/* RW */
>   #define MSDC_PAD_TUNE_CMDRRDLY	  GENMASK(26, 22)	/* RW */
>   #define MSDC_PAD_TUNE_CLKTDLY	  GENMASK(31, 27)	/* RW */
>   #define MSDC_PAD_TUNE_RXDLYSEL	  BIT(15)   /* RW */
>   #define MSDC_PAD_TUNE_RD_SEL	  BIT(13)   /* RW */
>   #define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
> +#define MSDC_PAD_TUNE_RD2_SEL	  BIT(13)   /* RW */
> +#define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
>   
>   #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
>   #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
> @@ -325,7 +329,8 @@
>   
>   #define DEFAULT_DEBOUNCE	(8)	/* 8 cycles CD debounce */
>   
> -#define PAD_DELAY_MAX	32 /* PAD delay cells */
> +#define PAD_DELAY_HALF	32 /* PAD delay cells */
> +#define PAD_DELAY_FULL	64
>   /*--------------------------------------------------------------------------*/
>   /* Descriptor Structure                                                     */
>   /*--------------------------------------------------------------------------*/
> @@ -461,6 +466,7 @@ struct msdc_host {
>   	u32 hs400_ds_dly3;
>   	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
>   	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
> +	u32 tuning_step;
>   	bool hs400_cmd_resp_sel_rising;
>   				 /* cmd response sample selection for HS400 */
>   	bool hs400_mode;	/* current eMMC will run at hs400 mode */
> @@ -1615,7 +1621,7 @@ static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
>   	}
>   
>   	if (cmd_err || dat_err) {
> -		dev_err(host->dev, "cmd_err = %d, dat_err =%d, intsts = 0x%x",
> +		dev_err(host->dev, "cmd_err = %d, dat_err = %d, intsts = 0x%x",
>   			cmd_err, dat_err, intsts);
>   	}
>   
> @@ -1780,10 +1786,20 @@ static void msdc_init_hw(struct msdc_host *host)
>   				     DATA_K_VALUE_SEL);
>   			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
>   				     PAD_CMD_RD_RXDLY_SEL);
> +			if (host->tuning_step > PAD_DELAY_HALF) {
> +				sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +					     PAD_DAT_RD_RXDLY2_SEL);
> +				sdr_set_bits(host->top_base + EMMC_TOP_CMD,
> +					     PAD_CMD_RD_RXDLY2_SEL);
> +			}
>   		} else {
>   			sdr_set_bits(host->base + tune_reg,
>   				     MSDC_PAD_TUNE_RD_SEL |
>   				     MSDC_PAD_TUNE_CMD_SEL);
> +			if (host->tuning_step > PAD_DELAY_HALF)
> +				sdr_set_bits(host->base + tune_reg + 4,
> +					     MSDC_PAD_TUNE_RD2_SEL |
> +					     MSDC_PAD_TUNE_CMD2_SEL);
>   		}
>   	} else {
>   		/* choose clock tune */
> @@ -1925,24 +1941,24 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   		msdc_set_mclk(host, ios->timing, ios->clock);
>   }
>   
> -static u32 test_delay_bit(u32 delay, u32 bit)
> +static u64 test_delay_bit(u64 delay, u32 bit)
>   {
> -	bit %= PAD_DELAY_MAX;
> +	bit %= PAD_DELAY_FULL;
>   	return delay & BIT(bit);
>   }
>   
> -static int get_delay_len(u32 delay, u32 start_bit)
> +static int get_delay_len(u64 delay, u32 start_bit)
>   {
>   	int i;
>   
> -	for (i = 0; i < (PAD_DELAY_MAX - start_bit); i++) {
> +	for (i = 0; i < (PAD_DELAY_FULL - start_bit); i++) {
>   		if (test_delay_bit(delay, start_bit + i) == 0)
>   			return i;
>   	}
> -	return PAD_DELAY_MAX - start_bit;
> +	return PAD_DELAY_FULL - start_bit;
>   }
>   
> -static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
> +static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u64 delay)
>   {
>   	int start = 0, len = 0;
>   	int start_final = 0, len_final = 0;
> @@ -1950,28 +1966,28 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
>   	struct msdc_delay_phase delay_phase = { 0, };
>   
>   	if (delay == 0) {
> -		dev_err(host->dev, "phase error: [map:%x]\n", delay);
> +		dev_err(host->dev, "phase error: [map:%llx]\n", delay);
>   		delay_phase.final_phase = final_phase;
>   		return delay_phase;
>   	}
>   
> -	while (start < PAD_DELAY_MAX) {
> +	while (start < PAD_DELAY_FULL) {
>   		len = get_delay_len(delay, start);
>   		if (len_final < len) {
>   			start_final = start;
>   			len_final = len;
>   		}
>   		start += len ? len : 1;
> -		if (len >= 12 && start_final < 4)
> +		if (!upper_32_bits(delay) && len >= 12 && start_final < 4)
>   			break;
>   	}
>   
>   	/* The rule is that to find the smallest delay cell */
>   	if (start_final == 0)
> -		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
> +		final_phase = (start_final + len_final / 3) % PAD_DELAY_FULL;
>   	else
> -		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
> -	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> +		final_phase = (start_final + len_final / 2) % PAD_DELAY_FULL;
> +	dev_dbg(host->dev, "phase: [map:%llx] [maxlen:%d] [final:%d]\n",
>   		delay, len_final, final_phase);
>   
>   	delay_phase.maxlen = len_final;
> @@ -1984,30 +2000,68 @@ static inline void msdc_set_cmd_delay(struct msdc_host *host, u32 value)
>   {
>   	u32 tune_reg = host->dev_comp->pad_tune_reg;
>   
> -	if (host->top_base)
> -		sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> -			      value);
> -	else
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      value);
> +	if (host->top_base) {
> +		if (value < PAD_DELAY_HALF) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      value);
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2,
> +				      0);
> +		} else {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      PAD_DELAY_HALF - 1);
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2,
> +				      value - PAD_DELAY_HALF);
> +		}
> +	} else {
> +		if (value < PAD_DELAY_HALF) {
> +			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> +				      value);
> +			sdr_set_field(host->base + tune_reg + 4, MSDC_PAD_TUNE_CMDRDLY2,
> +				      0);
> +		} else {
> +			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> +				      PAD_DELAY_HALF - 1);
> +			sdr_set_field(host->base + tune_reg + 4, MSDC_PAD_TUNE_CMDRDLY2,
> +				      value - PAD_DELAY_HALF);
> +		}
> +	}
>   }
>   
>   static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
>   {
>   	u32 tune_reg = host->dev_comp->pad_tune_reg;
>   
> -	if (host->top_base)
> -		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> -			      PAD_DAT_RD_RXDLY, value);
> -	else
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
> -			      value);
> +	if (host->top_base) {
> +		if (value < PAD_DELAY_HALF) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, value);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY2, 0);
> +		} else {
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, PAD_DELAY_HALF - 1);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY2, value - PAD_DELAY_HALF);
> +		}
> +	} else {
> +		if (value < PAD_DELAY_HALF) {
> +			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
> +				      value);
> +			sdr_set_field(host->base + tune_reg + 4, MSDC_PAD_TUNE_DATRRDLY2,
> +				      0);
> +		} else {
> +			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
> +				      PAD_DELAY_HALF - 1);
> +			sdr_set_field(host->base + tune_reg + 4, MSDC_PAD_TUNE_DATRRDLY2,
> +				      value - PAD_DELAY_HALF);
> +		}
> +	}
>   }
>   
>   static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>   {
>   	struct msdc_host *host = mmc_priv(mmc);
> -	u32 rise_delay = 0, fall_delay = 0;
> +	u64 rise_delay = 0, fall_delay = 0;
>   	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
>   	struct msdc_delay_phase internal_delay_phase;
>   	u8 final_delay, final_maxlen;
> @@ -2023,7 +2077,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>   			      host->hs200_cmd_int_delay);
>   
>   	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_cmd_delay(host, i);
>   		/*
>   		 * Using the same parameters, it may sometimes pass the test,
> @@ -2047,7 +2101,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>   		goto skip_fall;
>   
>   	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_cmd_delay(host, i);
>   		/*
>   		 * Using the same parameters, it may sometimes pass the test,
> @@ -2082,7 +2136,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>   	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
>   		goto skip_internal;
>   
> -	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		sdr_set_field(host->base + tune_reg,
>   			      MSDC_PAD_TUNE_CMDRRDLY, i);
>   		mmc_send_tuning(mmc, opcode, &cmd_err);
> @@ -2121,7 +2175,8 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
>   		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>   	else
>   		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +
> +	for (i = 0; i < PAD_DELAY_HALF; i++) {
>   		sdr_set_field(host->base + PAD_CMD_TUNE,
>   			      PAD_CMD_TUNE_RX_DLY3, i);
>   		/*
> @@ -2151,7 +2206,7 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
>   static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>   {
>   	struct msdc_host *host = mmc_priv(mmc);
> -	u32 rise_delay = 0, fall_delay = 0;
> +	u64 rise_delay = 0, fall_delay = 0;
>   	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
>   	u8 final_delay, final_maxlen;
>   	int i, ret;
> @@ -2160,7 +2215,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>   		      host->latch_ck);
>   	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>   	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_data_delay(host, i);
>   		ret = mmc_send_tuning(mmc, opcode, NULL);
>   		if (!ret)
> @@ -2174,7 +2229,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>   
>   	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>   	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_data_delay(host, i);
>   		ret = mmc_send_tuning(mmc, opcode, NULL);
>   		if (!ret)
> @@ -2206,7 +2261,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>   static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>   {
>   	struct msdc_host *host = mmc_priv(mmc);
> -	u32 rise_delay = 0, fall_delay = 0;
> +	u64 rise_delay = 0, fall_delay = 0;
>   	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
>   	u8 final_delay, final_maxlen;
>   	int i, ret;
> @@ -2217,7 +2272,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>   	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_Ron the supported SoCsSPL);
>   	sdr_clr_bits(host->base + MSDC_IOCON,
>   		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_cmd_delay(host, i);
>   		msdc_set_data_delay(host, i);
>   		ret = mmc_send_tuning(mmc, opcode, NULL);
> @@ -2233,7 +2288,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>   	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>   	sdr_set_bits(host->base + MSDC_IOCON,
>   		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < host->tuning_step; i++) {
>   		msdc_set_cmd_delay(host, i);
>   		msdc_set_data_delay(host, i);
>   		ret = mmc_send_tuning(mmc, opcode, NULL);
> @@ -2346,7 +2401,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
>   	}
>   
>   	host->hs400_tuning = true;
> -	for (i = 0; i < PAD_DELAY_MAX; i++) {
> +	for (i = 0; i < PAD_DELAY_HALF; i++) {
>   		if (host->top_base)
>   			sdr_set_field(host->top_base + EMMC50_PAD_DS_TUNE,
>   				      PAD_DS_DLY1, i);
> @@ -2601,6 +2656,10 @@ static void msdc_of_property_parse(struct platform_device *pdev,
>   	else
>   		host->hs400_cmd_resp_sel_rising = false;
>   
> +	if (of_property_read_u32(pdev->dev.of_node, "mediatek,tuning-step",
> +				 &host->tuning_step))
> +		host->tuning_step = PAD_DELAY_HALF;
> +
>   	if (of_property_read_bool(pdev->dev.of_node,
>   				  "supports-cqe"))
>   		host->cqhci = true;



