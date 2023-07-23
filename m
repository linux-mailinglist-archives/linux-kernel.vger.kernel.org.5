Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161D75E4B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGWUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741B1BE;
        Sun, 23 Jul 2023 13:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FBA60E9A;
        Sun, 23 Jul 2023 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE29FC433C8;
        Sun, 23 Jul 2023 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690142768;
        bh=MYDNII/nRbpdhoxLfX/zeWMDQLkBfuAoQG5un5EegG8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i04gOhYl/e9pCTC+Qjr0+IHT70ErCt815FZsNDMNWXOyWLAtfFsG5RRDgy/ifMEYi
         ocuIRDmhrayU0SnG3tshMAydV1PAx5CqH6z636iru4IYvtGpvzPlkrKyAXwVcporwo
         xN7gQ8SSCjeGdg5g3sHi+/+PXffTeKrzQbsJ7Ba1tyxmDeXLPCWXSP7nMhB7Zt21Kb
         xzTthLBnKMf4WlOuXZE2aW4YkWJgrKhkOPlIBw48KjZHkV3U+OUUh7Jgh645JuBoRg
         5pXX9f85FgT316SIJ0WqprfJYTbt/k3S85n2UugXt5ZXSgq3h6aOvObqny3LV/lRzA
         VeVGP5CPUOpmw==
Message-ID: <1703ab6e-8567-8574-f011-af19813f97e8@kernel.org>
Date:   Mon, 24 Jul 2023 05:06:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/15] PM / devfreq: Switch to
 dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-10-manivannan.sadhasivam@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20230720054100.9940-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 7. 20. 14:40, Manivannan Sadhasivam wrote:
> Some devfreq consumers like UFS driver need to work with multiple clocks
> through the OPP framework. For this reason, OPP framework exposes the
> _indexed() APIs for finding the floor/ceil of the supplied frequency of
> the indexed clock. So let's use them in the devfreq driver.
> 
> Currently, the clock index of 0 is used which works fine for multiple as
> well as single clock.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e36cbb920ec8..7686993d639f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -88,7 +88,7 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  	struct dev_pm_opp *opp;
>  	unsigned long min_freq = 0;
>  
> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> +	opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &min_freq, 0);

This patch changed the used function from dev_pm_opp_find_freq_ceil
to dev_pm_opp_find_freq_ceil_indexed even if there are no supporting of the multiple clocks
and then dev_pm_opp_find_freq_ceil is not removed from OPP.

I think that it is better to use dev_pm_opp_find_freq_ceil_indexed
when need to support multiple clocks with real case.

>  	if (IS_ERR(opp))
>  		min_freq = 0;
>  	else
> @@ -102,7 +102,7 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  	struct dev_pm_opp *opp;
>  	unsigned long max_freq = ULONG_MAX;
>  
> -	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
> +	opp = dev_pm_opp_find_freq_floor_indexed(devfreq->dev.parent, &max_freq, 0);
>  	if (IS_ERR(opp))
>  		max_freq = 0;
>  	else
> @@ -196,7 +196,7 @@ static int set_freq_table(struct devfreq *devfreq)
>  		return -ENOMEM;
>  
>  	for (i = 0, freq = 0; i < devfreq->max_state; i++, freq++) {
> -		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
> +		opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &freq, 0);
>  		if (IS_ERR(opp)) {
>  			devm_kfree(devfreq->dev.parent, devfreq->freq_table);
>  			return PTR_ERR(opp);
> @@ -2034,18 +2034,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  
>  	if (flags & DEVFREQ_FLAG_LEAST_UPPER_BOUND) {
>  		/* The freq is an upper bound. opp should be lower */
> -		opp = dev_pm_opp_find_freq_floor(dev, freq);
> +		opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
>  
>  		/* If not available, use the closest opp */
>  		if (opp == ERR_PTR(-ERANGE))
> -			opp = dev_pm_opp_find_freq_ceil(dev, freq);
> +			opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
>  	} else {
>  		/* The freq is an lower bound. opp should be higher */
> -		opp = dev_pm_opp_find_freq_ceil(dev, freq);
> +		opp = dev_pm_opp_find_freq_ceil_indexed(dev, freq, 0);
>  
>  		/* If not available, use the closest opp */
>  		if (opp == ERR_PTR(-ERANGE))
> -			opp = dev_pm_opp_find_freq_floor(dev, freq);
> +			opp = dev_pm_opp_find_freq_floor_indexed(dev, freq, 0);
>  	}
>  
>  	return opp;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

