Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE27B4F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjJBJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjJBJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:52:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578568E;
        Mon,  2 Oct 2023 02:52:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adca291f99so2228325066b.2;
        Mon, 02 Oct 2023 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696240328; x=1696845128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AGQqmAbDBlfqVHrxBuFwYXzqiiEFup7ewkYUhXNVpA=;
        b=JUy8qycN/B3FitkKY/lXPV862rZaSj+ydB+yyTpmknrkA8+/jnAEyXx/XXqnUHd2GT
         svrdeR5smKpMXi+pXxnB5BlAqnkG1SG/feKeLb3/E8cNH670Oh9V1X1CY2ErXb8+EFqd
         o6JzROXIseiVrNOw/z2SqUy9VEM+FuOfG0FstjVGNPQnZ9rkVs88J83wRTWk36uPXbqO
         QG5yBvIOldmSGk6KIqkZZ0MZIRsgVMQVXLGH11ih+CxHGX7CZXChuie3mdqowok6dig2
         Apxaxl97df8gy9mRGA8rIvueVVxil9C+sqhzGBE1GVXuHBMnolL040m6x/i+cUCdbX8+
         g9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240328; x=1696845128;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AGQqmAbDBlfqVHrxBuFwYXzqiiEFup7ewkYUhXNVpA=;
        b=S1TtGdMRv7CT9T6kQwHv/5gA8EZo4cNSZYrjyCM3zlXWx1+owH9jfnp9s61T33osPn
         JBa5gmU8nL59iSTigpoNjCT4EWV5nGmBM/Hi7zm75nXdpmmoEfE+YgbFIVpyNqEFUhU+
         aWSqSY52D+FNZL2dbdkZYzgwuldLEvS4V8qhNVUrVdBMCklqXCLpGIB7jpQYFB/Sv3IT
         1KOndePkig/GJjPp1USY6RWB+5iPEEKq765WAZNF79bw2+vDaFCBDdkcc7+bqswqM7Ay
         6873we2qZovkHSYVD2Og3lOcWaYoMoFRe/LTt8w5jryByIf8tn/P1C+lxQTxcFvoV+tz
         Xjow==
X-Gm-Message-State: AOJu0YznDV0OM34RAfbQl78X20P/bD5P3dfZawbbFnM4SYYT8p5zTs+H
        4Qx9kM0VToT/kb0cM/5If4BlvMQko7k=
X-Google-Smtp-Source: AGHT+IG01q/TNsAHxo0ISPP1Y6Frl7T0GGwk472rViaxYEIB8TKA2nqzk5zh/IOaarcECC8hwNZ5mQ==
X-Received: by 2002:a17:906:108f:b0:9ae:5202:e611 with SMTP id u15-20020a170906108f00b009ae5202e611mr9708096eju.14.1696240327570;
        Mon, 02 Oct 2023 02:52:07 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id l5-20020a170906a40500b009ae4ead6c01sm16659019ejz.163.2023.10.02.02.52.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:52:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
To:     Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
 <ZRp9RE2jOZdL0+1/@gofer.mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <7075cfd7-847e-8d28-72be-93761b36b0e0@gmail.com>
Date:   Mon, 2 Oct 2023 12:52:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZRp9RE2jOZdL0+1/@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.10.23 г. 11:20 ч., Sean Young wrote:
> Hi,
> 
> On Mon, Oct 02, 2023 at 08:49:47AM +0300, Ivaylo Dimitrov wrote:
>> On 1.10.23 г. 13:40 ч., Sean Young wrote:
>>> The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
>>> from delays as this is done in process context. Make this work in atomic
>>> context.
>>>
>>> This makes the driver much more precise.
>>>
>>> Signed-off-by: Sean Young <sean@mess.org>
>>> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>> ---
>>>    drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
>>>    1 file changed, 63 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
>>> index c5f37c03af9c..557725a07a67 100644
>>> --- a/drivers/media/rc/pwm-ir-tx.c
>>> +++ b/drivers/media/rc/pwm-ir-tx.c
>>> @@ -10,6 +10,8 @@
>>>    #include <linux/slab.h>
>>>    #include <linux/of.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/hrtimer.h>
>>> +#include <linux/completion.h>
>>>    #include <media/rc-core.h>
>>>    #define DRIVER_NAME	"pwm-ir-tx"
>>> @@ -17,8 +19,13 @@
>>>    struct pwm_ir {
>>>    	struct pwm_device *pwm;
>>> -	unsigned int carrier;
>>> -	unsigned int duty_cycle;
>>> +	struct hrtimer timer;
>>> +	struct completion completion;
>>> +	uint carrier;
>>> +	uint duty_cycle;
>>> +	uint *txbuf;
>>> +	uint txbuf_len;
>>> +	uint txbuf_index;
>>>    };
>>>    static const struct of_device_id pwm_ir_of_match[] = {
>>> @@ -55,33 +62,65 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>>>    	struct pwm_ir *pwm_ir = dev->priv;
>>>    	struct pwm_device *pwm = pwm_ir->pwm;
>>>    	struct pwm_state state;
>>> -	int i;
>>> -	ktime_t edge;
>>> -	long delta;
>>> +
>>> +	reinit_completion(&pwm_ir->completion);
>>
>> You should not need that.
> 
> It does not work without it - the process doing the 2nd tx hangs indefinitely.
> 

that means your calls to wait_for_completion() / complete() do not 
match. I think you should check why.

>>>    	pwm_init_state(pwm, &state);
>>>    	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>>>    	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
>>> +	state.enabled = false;
>>> -	edge = ktime_get();
>>> +	pwm_ir->txbuf = txbuf;
>>> +	pwm_ir->txbuf_len = count;
>>> +	pwm_ir->txbuf_index = 0;
>>> -	for (i = 0; i < count; i++) {
>>> -		state.enabled = !(i % 2);
>>> -		pwm_apply_state(pwm, &state);
>>> +	pwm_apply_state(pwm, &state);
>>
>> ditto, first pwm control should be in the timer function
> 
> This requires keeping a copy of pwm_state in pwm_ir but does avoid the extra
> call to pwm_apply_state() here.
> 

not really, you can have pwm_state * pwm_ir member and pass pointer to 
the stack variable.

> Having said that, the extra call to pwm_apply_state() may have benefits,
> see this comment in the pwm-sifive driver:
> 
>   * - When changing both duty cycle and period, we cannot prevent in
>   *   software that the output might produce a period with mixed
>   *   settings (new period length and old duty cycle).
> 
> So setting the duty cycle and period once with enabled = false prevents a
> first period with mixed settings (i.e. bogus).
> 

Who will enable pwm if not in tx? Like, doesn't the driver have 
exclusive ownership of the pwm? Also, every transmission ends up wit pwm 
disabled, so disabling it once again does not make sense to me.


>>> -		edge = ktime_add_us(edge, txbuf[i]);
>>> -		delta = ktime_us_delta(edge, ktime_get());
>>> -		if (delta > 0)
>>> -			usleep_range(delta, delta + 10);
>>> -	}
>>> +	hrtimer_start(&pwm_ir->timer, 1000, HRTIMER_MODE_REL);
>>
>> why not just call it with 0 time?
> 
> Otherwise the timings are a little off for the first edge - hrtimer setup
> time, I think. I can experiment again.
> 

Why is that? Edge start is controlled by the calls in timer function, it 
should not matter when it is called for the first time.

>>> -	state.enabled = false;
>>> -	pwm_apply_state(pwm, &state);
>>> +	wait_for_completion(&pwm_ir->completion);
>>>    	return count;
>>>    }
>>> +static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
>>> +{
>>> +	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
>>> +	ktime_t now;
>>> +
>>> +	/*
>>> +	 * If we happen to hit an odd latency spike, loop through the
>>> +	 * pulses until we catch up.
>>> +	 */
>>> +	do {
>>> +		u64 ns;
>>> +
>>> +		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
>>> +			/* Stop TX here */
>>> +			pwm_disable(pwm_ir->pwm);
>>> +
>>> +			complete(&pwm_ir->completion);
>>> +
>>> +			return HRTIMER_NORESTART;
>>> +		}
>>> +
>>> +		if (pwm_ir->txbuf_index % 2)
>>> +			pwm_disable(pwm_ir->pwm);
>>> +		else
>>> +			pwm_enable(pwm_ir->pwm);
>>> +
>>
>> pwm_ir->pwm->state.enabled = !(pwm_ir->txbuf_index % 2);
>> pwm_apply_state(pwm_ir->pwm, pwm_ir->state);
> 
> Requires a copy of pwm_state in pwm_ir, not a huge difference (copy of 28
> bytes vs keeping it around).

see my previous comment re struct var. Also, look at the overhead: 
https://elixir.bootlin.com/linux/v6.6-rc3/source/include/linux/pwm.h#L349 
- you call pwm_get_state() for every edge.

> 
>>> +		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
>>> +		hrtimer_add_expires_ns(timer, ns);
>>> +
>>> +		pwm_ir->txbuf_index++;
>>> +
>>> +		now = timer->base->get_time();
>>> +	} while (hrtimer_get_expires_tv64(timer) < now);
>>> +
>>> +	return HRTIMER_RESTART;
>>> +}
>>> +
>>>    static int pwm_ir_probe(struct platform_device *pdev)
>>>    {
>>>    	struct pwm_ir *pwm_ir;
>>> @@ -96,8 +135,16 @@ static int pwm_ir_probe(struct platform_device *pdev)
>>>    	if (IS_ERR(pwm_ir->pwm))
>>>    		return PTR_ERR(pwm_ir->pwm);
>>> +	if (pwm_can_sleep(pwm_ir->pwm)) {
>>> +		dev_err(&pdev->dev, "unsupported pwm device: driver can sleep\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>
>> I think we shall not limit, but use high priority thread to support those
>> drivers. I have that working on n900 with current (sleeping) pwm, see my
>> reply on the other mail. Maybe we can combine both patches in a way to
>> support both atomic and sleeping pwm drivers.
> 
> If the ir-rx51 driver uses a sleeping pwm then that's broken and only works
> by accident - the current driver is broken then.
> 

Yes, and I stated that couple of times in my previous emails :)

> Spinning for longer periods (e.g. 100us) does not play well with RT. Would
> make more sense to fix the pwm driver to non-sleeping when a pwm driver
> is used for pwm-ir-tx?
> 

Sure, and I have a patch for n900 that does this, however, for your i2c 
case there is no solution. Also, we may play smart and dynamically 
decrease sleep time (by adjusting edge by lets say 5-10 us every pulse 
until we have some sane value) if we see it is too long. No strong 
preferences here, it is just that I have code that works.

Thanks,
Ivo

> Thanks
> 
> Sean
> 
>>
>>>    	pwm_ir->carrier = 38000;
>>>    	pwm_ir->duty_cycle = 50;
>>> +	init_completion(&pwm_ir->completion);
>>> +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>> +	pwm_ir->timer.function = pwm_ir_timer;
>>>    	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
>>>    	if (!rcdev)
>>>
>>
>> Regards,
>> Ivo
