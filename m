Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E835B77CF49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbjHOPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjHOPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1001BF8;
        Tue, 15 Aug 2023 08:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CCD765B81;
        Tue, 15 Aug 2023 15:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E811C433C8;
        Tue, 15 Aug 2023 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692113760;
        bh=L16qJr+cFxC8bq6xHZ74yo7NYUNzP7Haus3/eItPbts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=la6rSjDL1f4g5Zmbr3A10iwxtMj2mVfTXuYlO81tgA2Rkns7gdsiaYgk970dq2UCd
         IBuerixPe5n6fWDzhVfXjfW5PSI+jNW2wygb9AJxAmN2Ifx/YDDlQ2BORgl3VzVPRW
         VtgI3f7BwffxYlqa2VSgYKNGa5U3Wg7HVuk2HZdUGoLek07KxrIIM9pgngAZ++8p4z
         I84uxug8xnyyaN7nwYGKk6nJGrBXlwHkcx/MDCDWRbLxuWXv72hESAZWjOAY61YkR2
         jNrD4GF7VD6eF9F8kA+ZPPT8L9C/tmkWagzmyLpypLF1iv4kdH6ORM5HWaeZNLiIqZ
         vG1W50lFFq7Kw==
Date:   Tue, 15 Aug 2023 08:38:44 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Message-ID: <vt2ma5qiqv4uvzdhhouvxo6ykvfcwlqjjvctcsorfy6dfh2efp@g4viqt2rqvz4>
References: <20230814235918.10396-1-quic_amelende@quicinc.com>
 <20230814235918.10396-5-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814235918.10396-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:59:15PM -0700, Anjelique Melendez wrote:
> In some PMICs like pmi632, the LUT pattern and LPG configuration can be
> stored in a single SDAM module instead of LUT peripheral. This feature is
> called PPG.
> 

You also introduce the abbreviation PBS in the driver, I think it would
be useful to mention what that is as well.

It would also be preferred if you expanded (some of) these abbreviations
in this description, to make the TLA-soup taste better.

> Add support for configuring and using LUT pattern from SDAM.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 309 ++++++++++++++++++++++++++++---
>  1 file changed, 283 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
[..]
> @@ -65,7 +83,12 @@ struct lpg_data;
>   * @lut_base:	base address of the LUT block (optional)
>   * @lut_size:	number of entries in the LUT block
>   * @lut_bitmap:	allocation bitmap for LUT entries
> - * @triled_base: base address of the TRILED block (optional)
> + * @pbs_dev:	PBS device
> + * @lpg_chan_nvmem:	LPG nvmem peripheral device
> + * @pbs_en_bitmap:	bitmap for tracking PBS triggers
> + * @lut_sdam_base:	offset where LUT pattern begins in nvmem
> + * @ppg_en:	Flag indicating whether PPG is enabled/used

Looking at its usage, it doesn't feel so much "is PPG enabled" as "does
this instance use PPG", it's not a thing that can be enabled/disabled in
runtime.

So "has_ppg" seems like a better name, or perhaps even "use_sdam" and
avoid "PPG" completely and make it clearer to the average reader?

[..]
> @@ -192,21 +229,87 @@ struct lpg_channel_data {
>   * @lut_base:		base address of LUT block
>   * @lut_size:		number of entries in LUT
>   * @triled_base:	base address of TRILED
> + * @lut_sdam_base:	base address where LUT pattern begins in nvmem device
>   * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
>   * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
>   * @num_channels:	number of channels in LPG
> + * @nvmem_count:	number of nvmems used for LUT and PPG config
>   * @channels:		list of channel initialization data
>   */
>  struct lpg_data {
>  	unsigned int lut_base;
>  	unsigned int lut_size;
>  	unsigned int triled_base;
> +	unsigned int lut_sdam_base;
>  	bool triled_has_atc_ctl;
>  	bool triled_has_src_sel;
>  	int num_channels;
> +	int nvmem_count;

I can't think of a reason for this to ever be negative, so please mark
it unsigned.

(It seems to have been an oversight to make this num_channels signed,
when the two other instances are unsigned. But that's an unrelated
change)

>  	const struct lpg_channel_data *channels;
>  };
>  
> +static int lpg_sdam_write(struct lpg *lpg, u16 addr, u8 val)
> +{
> +	int rc;
> +
> +	rc = nvmem_device_write(lpg->lpg_chan_nvmem, addr, 1, &val);
> +	if (rc < 0)
> +		dev_err(lpg->dev, "writing %u to SDAM addr %#x failed, rc=%d\n",
> +			val, addr, rc);
> +
> +	return rc > 0 ? 0 : rc;

Suggestion. It's idiomatic to deal with the error path first in the
kernel, so writing this as "if it's an error propagate that, otherwise
return 0" would feel more natural. It would have also saved me from
wondering if you consider 0 to be an error or not.

> +}
> +
> +#define SDAM_REG_PBS_SEQ_EN		0x42

It seems I choose to sprinkle the bit defines throughout the driver, but
all other register definitions are gathered at the top of the file. So
please put this one there as well (and keep the PBS_SW_TRIG_BIT here).

> +#define PBS_SW_TRIG_BIT		BIT(0)
> +
[..]
> +static void lpg_sdam_configure_triggers(struct lpg_channel *chan)
> +{
> +	if (!chan->lpg->ppg_en)
> +		return;
> +
> +	if (chan->enabled && chan->pattern_set) {
> +		lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 1);
> +		lpg_set_pbs_trigger(chan);
> +		chan->pattern_set = false;

Forgive me if I'm confused, but doesn't this mean that if I configure a
pattern and then set the brightness twice the pattern will be disabled
again?

> +	} else {
> +		lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 0);
> +		lpg_clear_pbs_trigger(chan);
> +	}
> +}
> +
[..]
>  static void lpg_apply_lut_control(struct lpg_channel *chan)
>  {
>  	struct lpg *lpg = chan->lpg;
> @@ -476,6 +634,9 @@ static void lpg_apply_lut_control(struct lpg_channel *chan)
>  	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
>  		return;
>  
> +	if (lpg->ppg_en)
> +		return lpg_sdam_apply_lut_control(chan);

Perhaps cleaner to just call lpg_sdam_apply_lut_control() directly from
lpg_apply() instead of bouncing in this function?

> +
>  	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
>  	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, step);
>  
> @@ -632,7 +793,7 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
>  		} else {
>  			lpg_calc_freq(chan, NSEC_PER_MSEC);
>  
> -			duty = div_u64(brightness * chan->period, cdev->max_brightness);
> +			duty = div_u64(brightness * chan->period, LPG_RESOLUTION_9BIT);

This changes the divisor for the non-ppg case from LPG_RESOLUTION_9BIT
- 1 to LPG_RESOLUTION_9BIT.

Please perform any modifications to the non-ppg behavior in a separate
commit, so that any potential regression can be easily identified as
coming from refactoring, intentional changes or the introduction of new
the new support.



>  			lpg_calc_duty(chan, duty);
>  			chan->enabled = true;
>  			chan->ramp_enabled = false;
[..]
> +static int lpg_parse_sdam(struct lpg *lpg)
> +{
> +	int rc = 0;
> +
> +	if (lpg->data->nvmem_count == 0)
> +		return 0;
> +
> +	/* get the nvmem device for LPG/LUT config */
> +	lpg->lpg_chan_nvmem = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
> +	if (IS_ERR(lpg->lpg_chan_nvmem)) {
> +		rc = PTR_ERR(lpg->lpg_chan_nvmem);
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(lpg->dev, "Failed to get nvmem device, rc=%d\n", rc);
> +		return rc;

return dev_err_probe(lpg->dev, "PTR_ERR(lpg->lpg_chan_nvmem, "Failed
to...") will handle the EPROBE_DEFER conditioning and make the error
message show up in /sys/kernel/debug/devices_deferred after boot.

> +	}
> +
> +	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
> +	if (IS_ERR(lpg->pbs_dev)) {
> +		rc = PTR_ERR(lpg->pbs_dev);
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(lpg->dev, "Failed to get PBS client device, rc=%d\n", rc);
> +		return rc;

Same here.

> +	}
> +
> +	lpg->ppg_en = true;
> +
> +	return rc;

rc is 0 here. return 0 would make that obvious to the reader, and save
you from having to zero-initialize the variable.

> +}
> +
> +static int lpg_init_sdam(struct lpg *lpg)
> +{
> +	struct lpg_channel *chan;
> +	int i, rc;
> +
> +	if (!lpg->ppg_en)

This is effectively checking if the previous function also bailed.
Perhaps it would be cleaner to just string these two together?

> +		return 0;
> +
> +	for (i = 0; i < lpg->num_channels; i++) {
> +		chan = &lpg->channels[i];
> +		if (chan->sdam_offset) {
> +			rc = lpg_sdam_write(lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 0);
> +			if (rc < 0)
> +				break;
> +
> +			rc = lpg_sdam_write(lpg,
> +					SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
> +			if (rc < 0)
> +				break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  static int lpg_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> @@ -1348,6 +1595,14 @@ static int lpg_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = lpg_parse_sdam(lpg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lpg_init_sdam(lpg);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = lpg_init_lut(lpg);
>  	if (ret < 0)
>  		return ret;
> @@ -1363,7 +1618,9 @@ static int lpg_probe(struct platform_device *pdev)
>  	for (i = 0; i < lpg->num_channels; i++)
>  		lpg_apply_dtest(&lpg->channels[i]);
>  
> -	return lpg_add_pwm(lpg);
> +	ret = lpg_add_pwm(lpg);
> +
> +	return ret;

I'm failing to see the usefulness of this change.

Regards,
Bjorn
