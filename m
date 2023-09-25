Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942E7AD0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjIYHCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjIYHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:02:52 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01CFB8;
        Mon, 25 Sep 2023 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VZVYpjaytBa+/7xMyqxL6b/+NyYxcUr3u+ydrtu5PFs=; b=zywNnXKqiFMjdvg3YXogtbKxho
        KDZo8OGeqC+X+acPs51D7M5YomeEzDzJCA2AZQCiTrwmvrWdwMatTBO7Wt4I15haiMyOMalz0ayMA
        1DVSTqDEietT4I+4KUBSbVupFvlMd8kJHVptOmfcBlYKpLMTTseNCnClpAFCDKhfHGCaVhOWp8hYI
        ZS4tUbsct1Oks/TRTxoQVUbhp47k0QNvoDV8m3n3GVxn7l+ACBcFmW7rM/+YvwckiOyUy3+y8XNbE
        /fTU426B6IYJCjoAj7vEypoHW/ilZhxC8nuqPTn5jalSYXqczuX00SBWwXbZeHWQAIFKkk6kr+13G
        FyBe65AA==;
Received: from [167.98.27.226] (helo=[10.35.4.179])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qkfcA-00Foug-Ev; Mon, 25 Sep 2023 08:02:42 +0100
Message-ID: <52645838-b10d-43d2-88b8-dd723f791f21@codethink.co.uk>
Date:   Mon, 25 Sep 2023 08:02:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/6] pwm: dwc: add PWM bit unset in get_state call
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-4-ben.dooks@codethink.co.uk>
 <20230922173556.qnn5hj5wkxnfckxm@pengutronix.de>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230922173556.qnn5hj5wkxnfckxm@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 18:35, Uwe Kleine-König wrote:
> Hello,
> 
> [dropping William Salmon and Jude Onyenegecha from Cc: as in the other
> mails before]
> 
> I'd change the Subject to:
> 
> 	pwm: dwc: Support DWC_TIM_CTRL_PWM unset in .get_state()
> 
> On Thu, Sep 07, 2023 at 05:12:39PM +0100, Ben Dooks wrote:
>> If we are not in PWM mode, then the output is technically a 50%
>> output based on a single timer instead of the high-low based on
>> the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
>> and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.
>>
>> This may only be an issue on initialisation, as the rest of the
>> code currently assumes we're always going to have the extended
>> PWM mode using two counters.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> v9:
>>   - fixed multi-line comment
>>   - put authour back to codethink email from sifive
>> v8:
>>   - fixed rename issues
>> v4:
>>   - fixed review comment on mulit-line calculations
>> ---
>>   drivers/pwm/pwm-dwc-core.c | 30 +++++++++++++++++++-----------
>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
>> index 4b4b7b9e1d82..3fc281a78c9a 100644
>> --- a/drivers/pwm/pwm-dwc-core.c
>> +++ b/drivers/pwm/pwm-dwc-core.c
>> @@ -122,24 +122,32 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   {
>>   	struct dwc_pwm *dwc = to_dwc_pwm(chip);
>>   	u64 duty, period;
>> +	u32 ctrl, ld, ld2;
>>   
>>   	pm_runtime_get_sync(chip->dev);
>>   
>> -	state->enabled = !!(dwc_pwm_readl(dwc,
>> -				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
>> +	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
>> +	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>> +	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>>   
>> -	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>> -	duty += 1;
>> -	duty *= dwc->clk_ns;
>> -	state->duty_cycle = duty;
>> +	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
>>   
>> -	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>> -	period += 1;
>> -	period *= dwc->clk_ns;
>> -	period += duty;
>> -	state->period = period;
>> +	/*
>> +	 * If we're not in PWM, technically the output is a 50-50
>> +	 * based on the timer load-count only.
>> +	 */
>> +	if (ctrl & DWC_TIM_CTRL_PWM) {
>> +		duty = (ld + 1) * dwc->clk_ns;
>> +		period = (ld2 + 1)  * dwc->clk_ns;
>> +		period += duty;
>> +	} else {
>> +		duty = (ld + 1) * dwc->clk_ns;
>> +		period = duty * 2;
>> +	}
>>   
>>   	state->polarity = PWM_POLARITY_INVERSED;
>> +	state->period = period;
>> +	state->duty_cycle = duty;
>>   
>>   	pm_runtime_put_sync(chip->dev);
> 
> The change looks right,
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Do you intend to address the review feedback for the other patches in
> this series? It would be sad if you efforts didn't result in these
> improvements getting in.

I'm going to try and get through the review comments this week,
I've been ill and then on leave so not had any time to look at
this.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

