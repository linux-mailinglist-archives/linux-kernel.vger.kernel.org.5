Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546279BB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358886AbjIKWOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjIKJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:15:34 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 02:15:28 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2939CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x7EQntpORruDbHu73j/wMqHGD7q5uvm3F6D92MHR0oo=; b=eYq89mQAS1QqauVzJc1IGH7A1n
        oyVV8bbVlj36fgloV4BoAgw5trQ9ZNPuUzM4AKaPNnZgr9WZPY7GgUeN+4So/wz0TbpnDzFoWH17S
        TR9+F4oMSsuMWf6qyT8Y+1vDOov+cwcTGvzpJoE3V3CZLUWcLzLDB5tGZnA8zOd3rq7OWZMnwx+dn
        S+N3GVOS0hX76Hyq397+UCO+joB9Pkm6Hf6PF3fW8VS2F2Th6AXXXvTCTQIcqWNCFmyEUMX48onrV
        4KD1GAZIJBcbidsw/4UrD7Y+RA/sTe9ASJa4FotYxW7Td8luvjzPF8thvsoofUBk2NjPVQGJhmAYx
        hj6vItMQ==;
Received: from [134.238.52.102] (helo=[10.8.4.124])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qfbPs-006Iyd-U7; Mon, 11 Sep 2023 08:33:05 +0100
Message-ID: <d45c3d25-13ca-474f-a3e3-c295d3cea866@codethink.co.uk>
Date:   Mon, 11 Sep 2023 08:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] pwm: dwc: use clock rate in hz to avoid rounding
 issues
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-5-ben.dooks@codethink.co.uk>
 <20230907213419.aqzwoppznj5tx7w6@pengutronix.de>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230907213419.aqzwoppznj5tx7w6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 22:34, Uwe Kleine-König wrote:
> Hello,
> 
> [Dropped William Salmon and Jude Onyenegecha from the list of recipents,
> their email addresses don't seem to work any more.]
> 
> On Thu, Sep 07, 2023 at 05:12:40PM +0100, Ben Dooks wrote:
>> As noted, the clock-rate when not a nice multiple of ns is probably
>> going to end up with inacurate calculations, as well as on a non pci
>> system the rate may change (although we've not put a clock rate
>> change notifier in this code yet) so we also add some quick checks
>> of the rate when we do any calculations with it.
>>
>> Signed-off-by; Ben Dooks <ben.dooks@codethink.co.uk>
>> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>> v9:
>>   - fixed commit spelling
>>   - changed to use codethink email instead of sifive
>> v8:
>>   - fixup post rename
>>   - move to earlier in series
>> ---
>>   drivers/pwm/pwm-dwc-core.c | 24 +++++++++++++++---------
>>   drivers/pwm/pwm-dwc.h      |  2 +-
>>   2 files changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
>> index 3fc281a78c9a..3b856685029d 100644
>> --- a/drivers/pwm/pwm-dwc-core.c
>> +++ b/drivers/pwm/pwm-dwc-core.c
>> @@ -49,13 +49,14 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
>>   	 * periods and check are the result within HW limits between 1 and
>>   	 * 2^32 periods.
>>   	 */
>> -	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
>> +	tmp = state->duty_cycle * dwc->clk_rate;
> 
> This might overflow. You can prevent this by asserting that clk_rate is
> <= NSEC_PER_SEC and using mul_u64_u64_div_u64.
> 
>> +	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
>>   	if (tmp < 1 || tmp > (1ULL << 32))
>>   		return -ERANGE;
>>   	low = tmp - 1;
>>   
>> -	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
>> -				    dwc->clk_ns);
>> +	tmp = (state->period - state->duty_cycle) * dwc->clk_rate;
>> +	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
>>   	if (tmp < 1 || tmp > (1ULL << 32))
>>   		return -ERANGE;
>>   	high = tmp - 1;
>> @@ -121,11 +122,14 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   			     struct pwm_state *state)
>>   {
>>   	struct dwc_pwm *dwc = to_dwc_pwm(chip);
>> +	unsigned long clk_rate;
>>   	u64 duty, period;
>>   	u32 ctrl, ld, ld2;
>>   
>>   	pm_runtime_get_sync(chip->dev);
>>   
>> +	clk_rate = dwc->clk_rate;
>> +
>>   	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
>>   	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>>   	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>> @@ -137,17 +141,19 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	 * based on the timer load-count only.
>>   	 */
>>   	if (ctrl & DWC_TIM_CTRL_PWM) {
>> -		duty = (ld + 1) * dwc->clk_ns;
>> -		period = (ld2 + 1)  * dwc->clk_ns;
>> +		duty = ld + 1;
>> +		period = ld2 + 1;
>>   		period += duty;
>>   	} else {
>> -		duty = (ld + 1) * dwc->clk_ns;
>> +		duty = ld + 1;
>>   		period = duty * 2;
>>   	}
>>   
>> +	duty *= NSEC_PER_SEC;
>> +	period *= NSEC_PER_SEC;
> 
> A comment that/why this cannot overflow would be nice. (I didn't check,
> maybe it can?)

I /think/ that as long as NSEC_PER_SEC  2^32 then this shouldn't
overflow.

> 
>> +	state->period = DIV_ROUND_CLOSEST_ULL(period, clk_rate);
>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(duty, clk_rate);
> 
> Without having thought deeply about this, I think you need to round up
> here. Hmm, but given that .apply() uses round-closest, too, this needs
> to be addressed separately.
> 
> (The ugly thing about round-closest is that .apply(mypwm,
> .get_state(mypwm)) isn't idempotent in general. Consider a PWM that can
> implement period = 41.7ns and period = 42.4 ns. If it's configured with
> 42.4, .get_state will return period = 42. Reapplying this will configure
> for 41.7ns. This won't happen with the PCI clkrate, but it might in the
> of case. Another reason to use rounding-down in .apply is that
> mul_u64_u64_div_u64 doesn't have a round-nearest variant.)
> 
>>   	state->polarity = PWM_POLARITY_INVERSED;
>> -	state->period = period;
>> -	state->duty_cycle = duty;
>>   
>>   	pm_runtime_put_sync(chip->dev);
>>   
>> @@ -168,7 +174,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>>   	if (!dwc)
>>   		return NULL;
>>   
>> -	dwc->clk_ns = 10;
>> +	dwc->clk_rate = NSEC_PER_SEC / 10;
>>   	dwc->chip.dev = dev;
>>   	dwc->chip.ops = &dwc_pwm_ops;
>>   	dwc->chip.npwm = DWC_TIMERS_TOTAL;
>> diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
>> index 64795247c54c..e0a940fd6e87 100644
>> --- a/drivers/pwm/pwm-dwc.h
>> +++ b/drivers/pwm/pwm-dwc.h
>> @@ -42,7 +42,7 @@ struct dwc_pwm_ctx {
>>   struct dwc_pwm {
>>   	struct pwm_chip chip;
>>   	void __iomem *base;
>> -	unsigned int clk_ns;
>> +	unsigned long clk_rate;
> 
> Given that clk_ns was only introduced in patch #2 I think it would be
> cleaner to squash these two patches together.

I'll have a look at how much work re-ordering the patches would
be.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

