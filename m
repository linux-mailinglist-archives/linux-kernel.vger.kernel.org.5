Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95582792917
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350879AbjIEQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbjIEK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:29:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A31DB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:29:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3859uhur020341;
        Tue, 5 Sep 2023 05:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=6kc2aldLwrIdGx9
        TyCjTXTosICz2XkDQIf02yIQXdbA=; b=ct9rUv8LF/0LONZ7Sziid0S+SWLfqjz
        6r87wRTZRT/2cRgZgzsMk+pWDqrIZGfti6yxopVYesPMdIAtYuaqK9XgiY9/YLXj
        APP3jBEQ1wj2mtZ/M3dfYjnpCEm2NaIhupbH7tN1D+/mZW+f+BixIvboT5i9OSk0
        RlvnHsr7ZFl/pjevyOcTW0luXy6iZ2uaPRAP+af7gaUv2zKI77zl9QycVZKu/DqT
        nZFJXcbdIADHHKoh/HXq8vEKD/cYaWRfs/sLl20K2j+jZRfev39N1nk4MefFrjGa
        iNy7FkApA9JCEV95O82XBkd+gE8/wz5EXkNuBekf3V4r0TTnlqf19Rg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhttb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:29:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 11:29:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 11:29:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5039A15B9;
        Tue,  5 Sep 2023 10:29:33 +0000 (UTC)
Date:   Tue, 5 Sep 2023 10:29:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 4/9] ASoC: cs35l41: Fix broken shared boost activation
Message-ID: <20230905102933.GL103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-5-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-5-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: JQz0yJ7GH6ivtELRql7s8igYTZ3obR2w
X-Proofpoint-GUID: JQz0yJ7GH6ivtELRql7s8igYTZ3obR2w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:16AM +0300, Cristian Ciocaltea wrote:
> Enabling the active/passive shared boosts involves writing the MDSYNC UP
> register sequence, which cannot be performed before receiving the PLL
> lock signal.
> 
> Due to improper error handling, it was not obvious the wait operation
> times out and, consequently, the shared boost gets never enabled.
> 
> Further investigations revealed the signal is triggered while
> snd_pcm_start() is executed, right after receiving the
> SNDRV_PCM_TRIGGER_START command, which happens long after the
> SND_SOC_DAPM_PRE_PMU event handler is invoked as part of
> snd_pcm_prepare().  That is where cs35l41_global_enable() is called
> from.
> 
> Increasing the wait duration doesn't help, as it only causes an
> unnecessary delay in the invocation of snd_pcm_start().  Moving the wait
> and the subsequent regmap operations to the SNDRV_PCM_TRIGGER_START
> callback is not a solution either, since they would be executed in an
> IRQ-off atomic context.
> 
> Solve the issue by deferring the processing to a workqueue task, which
> allows to correctly wait for the signal and then safely proceed with
> the required regmap operations.
> 
> Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Thanks for looking at this apologies this was missed in the
initial review of the patch.

> +int cs35l41_mdsync_up(struct regmap *regmap)
> +{
> +	struct reg_sequence cs35l41_mdsync_up_seq[] = {
> +		{CS35L41_PWR_CTRL3, 0},
> +		{CS35L41_PWR_CTRL1, 0x00000000, 3000},
> +		{CS35L41_PWR_CTRL1, 0x00000001, 3000},
> +	};
> +	unsigned int pwr_ctrl3, int_status;
> +	int ret;
> +
> +	regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
> +	pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
> +	cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
> +
> +	ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
> +				     ARRAY_SIZE(cs35l41_mdsync_up_seq));
> +	if (ret < 0)
> +		return ret;

Is this now safe? By pulling this out into a worker thread, it is
no longer under the DAPM lock, which makes me worry this can race
with the other uses of PWR_CTRL3 which could theoretically change
state between when you read the reg and when you write it.

> @@ -1243,33 +1289,27 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
>  		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
>  		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
>  					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
> -		if (ret || !enable)
> +		if (ret)
>  			break;
>  
> -		if (!pll_lock)
> -			return -EINVAL;
> -
> -		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
> -		if (ret == 0) {
> -			dev_err(dev, "Timed out waiting for pll_lock\n");
> -			return -ETIMEDOUT;
> +		if (enable) {
> +			if (mdsync_up_work) {
> +				/* Call cs35l41_mdsync_up() after receiving PLL lock signal */
> +				schedule_work(mdsync_up_work);
> +			} else {
> +				dev_err(dev, "MDSYNC UP work not provided\n");
> +				ret = -EINVAL;
> +			}
> +			break;

One question I might also have would be does a worker thread make
more sense or would it be simpler to do the mdsync power up
directly in response to the PLL lock IRQ?

Thanks,
Charles
