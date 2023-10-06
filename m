Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942797BBBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjJFPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJFPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:24:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD783;
        Fri,  6 Oct 2023 08:24:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A19FC433C7;
        Fri,  6 Oct 2023 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605890;
        bh=AO05v9JmyrA8bcxdjoiJJRByxIdeqJtv5Ylzy/7Dbyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p9vGTePWrtFU5lMs5jv3+Lib2JjCGUs3k+NDvSBNG8z986POaljaM7Gt/FSxlSeOl
         oBopycTLIiDtMegbrwfmKOrWESSU0/rdc/XkigtN+9hKtfqH4/0Fn+r2tuqhD7je3K
         /I3WKkhrM5tUbBO+8SF/zE5A7ipeKaTtoLN2iLMMXGnzr+XcoYta7/VGgQRBMbO0tM
         hlddI2eV60WPR0bFhnP6EwmymZkPXPvM7WpoQi7vdWHwKtXgngsehPddg25WsMS6Jx
         KR+YmMJRKmfGHVXoXUAH/DSeldgYENKzAE5AE6QngrzQnvTz1rb9iKxqbKe/YLTje3
         cSqtYehj2qkyQ==
Message-ID: <53cf6fa8-5325-d9e5-7f89-d97974d53989@kernel.org>
Date:   Sat, 7 Oct 2023 00:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/6] PM / devfreq: Switch to
 dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
Content-Language: en-US
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
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
 <20231003111232.42663-3-manivannan.sadhasivam@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231003111232.42663-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 3. 20:12, Manivannan Sadhasivam wrote:
> Some devfreq consumers like UFS driver need to work with multiple clocks
> through the OPP framework. For this reason, OPP framework exposes the
> _indexed() APIs for finding the floor/ceil of the supplied frequency of
> the indexed clock. So let's use them in the devfreq driver.
> 
> Currently, the clock index of 0 is used which works fine for multiple as
> well as single clock.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/devfreq/devfreq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 474d81831ad3..b3a68d5833bd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -88,7 +88,7 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  	struct dev_pm_opp *opp;
>  	unsigned long min_freq = 0;
>  
> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> +	opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &min_freq, 0);
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
> @@ -2036,18 +2036,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
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

The related OPP patch was already merge. So that applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

