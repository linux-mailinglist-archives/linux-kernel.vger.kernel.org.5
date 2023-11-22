Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA57F4B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbjKVPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjKVPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017C1BD;
        Wed, 22 Nov 2023 07:42:49 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AM4unwq021092;
        Wed, 22 Nov 2023 09:42:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=ENxUZV0R/rZuATz
        SLrodorMUMgqY8tBXz0jERmxxfdo=; b=NjTkstEX4XBudA+zTk6iY6FJYdjE5fZ
        jwVDN37Sz1S7Z0ZMme9mJh+31LqJudLoJdGQShe39pOwXklcPDwqooBVLOhcjTAx
        SQQX4GDpWLGVHpvf+ye0fGCrtKHkiYQspjjtsnymtP+3SsFQrWsnIeaA/ElHoAmP
        KtKY0oAWm2WAjXAk2lcKrUUe7uGMvEk9oPqD+J/xfApuV7pePd9U6AGSudZreHcS
        LRhQq0hFDBx/s6YvCAfwYZic8Wu5Dct8BsvCFu1kzaZPAW53SO6RfPx3phSsMMX4
        EoiAe3l8QQGX9Nw8X8fvrSXoKZlAS1GCzf5a6lYjxcGCYdDzqPPSjrw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2cnp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:42:40 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 22 Nov
 2023 15:42:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Wed, 22 Nov 2023 15:42:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 13A38357F;
        Wed, 22 Nov 2023 15:42:38 +0000 (UTC)
Date:   Wed, 22 Nov 2023 15:42:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <20231122154238.GM32655@ediswmail.ad.cirrus.com>
References: <20231122143459.26861-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122143459.26861-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 1IKaSbOnR95wTY7bBNTRX-81kEk0ZyPQ
X-Proofpoint-GUID: 1IKaSbOnR95wTY7bBNTRX-81kEk0ZyPQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:34:59PM +0000, Maciej Strozek wrote:
> Add a polling mechanism that will keep the driver operational even in
> absence of physical IRQ connection. If IRQ line is detected, the driver
> will continue working as usual, in case of missing IRQ line it will
> fallback to the polling mechanism introduced in this change.
> This will support users which choose not to connect an IRQ line as it
> is not critical to part's operation.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Apologies Maciej, should have spotted this when I had a look this
morning but I have just spotted one more thing, we should actually
remove the polling for the hpload detect. The hpload detect can
actually only be triggered by the IRQ handler anyway so that code
will never run, and there would be much more work required to get
the jack detect working without the IRQ.

Thanks,
Charles

> V3 -> V4:
> 	- Removed unnecesary else and indentation
> 	- Changed cs43130_wait_for_completion return codes and updated callers accordingly
> 	- Changed approach for checking for presence of IRQ connection: see if client->irq equals 0
> 	  which seems to be a standard way of checking it used by other drivers (instead of
> 	  inspecting devm_request_threaded_irq error code)
> V2 -> V3: Amended changelog message and subject line
> V1 -> V2: Add changelog message
> 
>  sound/soc/codecs/cs43130.c | 91 +++++++++++++++++++++++++++-----------
>  sound/soc/codecs/cs43130.h |  1 +
>  2 files changed, 65 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
> index 02e7f45b9208..bd51bb5b6f14 100644
> --- a/sound/soc/codecs/cs43130.c
> +++ b/sound/soc/codecs/cs43130.c
> @@ -326,6 +326,40 @@ static int cs43130_set_pll(struct snd_soc_component *component, int pll_id, int
>  	return ret;
>  }
> 
> +static int cs43130_wait_for_completion(struct cs43130_private *cs43130, struct completion *to_poll,
> +					int time)
> +{
> +	int stickies, offset, flag, ret;
> +
> +	if (cs43130->has_irq_line) {
> +		ret = wait_for_completion_timeout(to_poll, msecs_to_jiffies(time));
> +		if (ret == 0)
> +			return -ETIMEDOUT;
> +		else
> +			return 0; // Discard number of jiffies left till timeout and return success
> +	}
> +
> +	if (to_poll == &cs43130->xtal_rdy) {
> +		offset = 0;
> +		flag = CS43130_XTAL_RDY_INT;
> +	} else if (to_poll == &cs43130->pll_rdy) {
> +		offset = 0;
> +		flag = CS43130_PLL_RDY_INT;
> +	} else if (to_poll == &cs43130->hpload_evt) {
> +		offset = 3;
> +		flag = CS43130_HPLOAD_NO_DC_INT | CS43130_HPLOAD_UNPLUG_INT |
> +			CS43130_HPLOAD_OOR_INT | CS43130_HPLOAD_AC_INT |
> +			CS43130_HPLOAD_DC_INT | CS43130_HPLOAD_ON_INT |
> +			CS43130_HPLOAD_OFF_INT;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return regmap_read_poll_timeout(cs43130->regmap, CS43130_INT_STATUS_1 + offset,
> +					stickies, (stickies & flag),
> +					1000, time * 1000);
> +}
> +
>  static int cs43130_change_clksrc(struct snd_soc_component *component,
>  				 enum cs43130_mclk_src_sel src)
>  {
> @@ -364,14 +398,13 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
>  					   CS43130_XTAL_RDY_INT_MASK, 0);
>  			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
>  					   CS43130_PDN_XTAL_MASK, 0);
> -			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
> -							  msecs_to_jiffies(100));
> +			ret = cs43130_wait_for_completion(cs43130, &cs43130->xtal_rdy, 100);
>  			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
>  					   CS43130_XTAL_RDY_INT_MASK,
>  					   1 << CS43130_XTAL_RDY_INT_SHIFT);
> -			if (ret == 0) {
> -				dev_err(cs43130->dev, "Timeout waiting for XTAL_READY interrupt\n");
> -				return -ETIMEDOUT;
> +			if (ret) {
> +				dev_err(cs43130->dev, "Error waiting for XTAL_READY interrupt: %d\n", ret);
> +				return ret;
>  			}
>  		}
> 
> @@ -400,14 +433,13 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
>  					   CS43130_XTAL_RDY_INT_MASK, 0);
>  			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
>  					   CS43130_PDN_XTAL_MASK, 0);
> -			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
> -							  msecs_to_jiffies(100));
> +			ret = cs43130_wait_for_completion(cs43130, &cs43130->xtal_rdy, 100);
>  			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
>  					   CS43130_XTAL_RDY_INT_MASK,
>  					   1 << CS43130_XTAL_RDY_INT_SHIFT);
> -			if (ret == 0) {
> -				dev_err(cs43130->dev, "Timeout waiting for XTAL_READY interrupt\n");
> -				return -ETIMEDOUT;
> +			if (ret) {
> +				dev_err(cs43130->dev, "Error waiting for XTAL_READY interrupt: %d\n", ret);
> +				return ret;
>  			}
>  		}
> 
> @@ -416,14 +448,13 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
>  				   CS43130_PLL_RDY_INT_MASK, 0);
>  		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
>  				   CS43130_PDN_PLL_MASK, 0);
> -		ret = wait_for_completion_timeout(&cs43130->pll_rdy,
> -						  msecs_to_jiffies(100));
> +		ret = cs43130_wait_for_completion(cs43130, &cs43130->pll_rdy, 100);
>  		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
>  				   CS43130_PLL_RDY_INT_MASK,
>  				   1 << CS43130_PLL_RDY_INT_SHIFT);
> -		if (ret == 0) {
> -			dev_err(cs43130->dev, "Timeout waiting for PLL_READY interrupt\n");
> -			return -ETIMEDOUT;
> +		if (ret) {
> +			dev_err(cs43130->dev, "Error waiting for PLL_READY interrupt: %d\n", ret);
> +			return ret;
>  		}
> 
>  		regmap_update_bits(cs43130->regmap, CS43130_SYS_CLK_CTL_1,
> @@ -2048,12 +2079,12 @@ static int cs43130_hpload_proc(struct cs43130_private *cs43130,
>  	regmap_multi_reg_write(cs43130->regmap, seq,
>  			       seq_size);
> 
> -	ret = wait_for_completion_timeout(&cs43130->hpload_evt,
> -					  msecs_to_jiffies(1000));
> +	ret = cs43130_wait_for_completion(cs43130, &cs43130->hpload_evt, 1000);
> +
>  	regmap_read(cs43130->regmap, CS43130_INT_MASK_4, &msk);
> -	if (!ret) {
> -		dev_err(cs43130->dev, "Timeout waiting for HPLOAD interrupt\n");
> -		return -1;
> +	if (ret) {
> +		dev_err(cs43130->dev, "Timeout waiting for HPLOAD interrupt: %d\n", ret);
> +		return ret;
>  	}
> 
>  	dev_dbg(cs43130->dev, "HP load stat: %x, INT_MASK_4: %x\n",
> @@ -2548,13 +2579,19 @@ static int cs43130_i2c_probe(struct i2c_client *client)
>  	init_completion(&cs43130->pll_rdy);
>  	init_completion(&cs43130->hpload_evt);
> 
> -	ret = devm_request_threaded_irq(cs43130->dev, client->irq,
> -					NULL, cs43130_irq_thread,
> -					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -					"cs43130", cs43130);
> -	if (ret != 0) {
> -		dev_err(cs43130->dev, "Failed to request IRQ: %d\n", ret);
> -		goto err;
> +	if (!client->irq) {
> +		dev_dbg(cs43130->dev, "IRQ not found, will poll instead\n");
> +		cs43130->has_irq_line = 0;
> +	} else {
> +		ret = devm_request_threaded_irq(cs43130->dev, client->irq,
> +						NULL, cs43130_irq_thread,
> +						IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +						"cs43130", cs43130);
> +		if (ret != 0) {
> +			dev_err(cs43130->dev, "Failed to request IRQ: %d\n", ret);
> +			goto err;
> +		}
> +		cs43130->has_irq_line = 1;
>  	}
> 
>  	cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
> diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
> index d3f595bbd3ba..dbdb5b262f1b 100644
> --- a/sound/soc/codecs/cs43130.h
> +++ b/sound/soc/codecs/cs43130.h
> @@ -508,6 +508,7 @@ struct	cs43130_private {
>  	struct gpio_desc		*reset_gpio;
>  	unsigned int			dev_id; /* codec device ID */
>  	int				xtal_ibias;
> +	bool				has_irq_line;
> 
>  	/* shared by both DAIs */
>  	struct mutex			clk_mutex;
> --
> 2.34.1
> 
