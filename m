Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2047601A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGXV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2D194;
        Mon, 24 Jul 2023 14:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0247961451;
        Mon, 24 Jul 2023 21:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5430AC433C9;
        Mon, 24 Jul 2023 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690235838;
        bh=0h+dePu6rfFOElRcgVsU297/GZNJnUly0bCMrw5Ff18=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NAC8ciK8rb0/RL1BJPLjTRLBt6CasWW+075WiQWKFXy6eZ2E5q3ZUapb8BwtSOo3q
         N/goKsGuxq4Rm09bmtYeV3g2v9OqYskyaX1al35QnIvYWziPH5CX/EmB3b3sSsARL2
         jZC8hJ4G0LXNIGGO90UMBMvCMdpeE/2DKURXwdY6Sn7q3Wa+haJSMPfr1Vbzt1N46b
         CqTrFR/79fT8N6Uxa4GG4QglPOWvZwaB2b3E5ndOQTgh+Yr8cjAOShvBHIsfk6fy32
         3KGk0WCIXSNq8Z/S7HHUgn9KAogSruWSkCCFtxkYCclEaeewf540LgBDG2VWe7RgYu
         JoO9robSErv9A==
Message-ID: <f95c78d8-2baa-edde-39bb-8341cde2d63f@kernel.org>
Date:   Tue, 25 Jul 2023 06:57:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/15] PM / devfreq: Switch to
 dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
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
 <1703ab6e-8567-8574-f011-af19813f97e8@kernel.org>
 <20230724054611.GA2370@thinkpad>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20230724054611.GA2370@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 24. 14:46, Manivannan Sadhasivam wrote:
> On Mon, Jul 24, 2023 at 05:06:04AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 23. 7. 20. 14:40, Manivannan Sadhasivam wrote:
>>> Some devfreq consumers like UFS driver need to work with multiple clocks
>>> through the OPP framework. For this reason, OPP framework exposes the
>>> _indexed() APIs for finding the floor/ceil of the supplied frequency of
>>> the indexed clock. So let's use them in the devfreq driver.
>>>
>>> Currently, the clock index of 0 is used which works fine for multiple as
>>> well as single clock.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/devfreq/devfreq.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index e36cbb920ec8..7686993d639f 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -88,7 +88,7 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
>>>  	struct dev_pm_opp *opp;
>>>  	unsigned long min_freq = 0;
>>>  
>>> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
>>> +	opp = dev_pm_opp_find_freq_ceil_indexed(devfreq->dev.parent, &min_freq, 0);
>>
>> This patch changed the used function from dev_pm_opp_find_freq_ceil
>> to dev_pm_opp_find_freq_ceil_indexed even if there are no supporting of the multiple clocks
>> and then dev_pm_opp_find_freq_ceil is not removed from OPP.
>>
>> I think that it is better to use dev_pm_opp_find_freq_ceil_indexed
>> when need to support multiple clocks with real case.
>>
> 
> There is the user for dev_pm_opp_find_freq_ceil_indexed() which is the UFS
> driver and since UFS is using devfreq, we need this change. I've added this info
> in the commit message as well. What am I missing?


I found out the difference of them. 
- dev_pm_opp_find_freq_ceil() used the 'assert_single_clk' which check the count of clock.
                                                               

(snip)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

