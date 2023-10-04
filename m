Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9C7B7FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJDMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:54:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EDA1;
        Wed,  4 Oct 2023 05:54:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98377c5d53eso373623466b.0;
        Wed, 04 Oct 2023 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424079; x=1697028879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bC74TryHv+J80MOfZq7W8YVW0BJt9KS7QGciFS22VQ=;
        b=F4pPU0t/FvxFVdCKh15m87DNg2MHncmAArLfI3EygQ1eS3FGGM+TCzAm/bu2nc9deZ
         YgvkDxLejN/NwSBQgD2SYWQLH8xb4Eyw2ifiqP+wF5wzMfHlX6xqy+qctbXWhnRItzkf
         jU6zfcmn5QZgmTz+ZUjge+UqSnavvWFmfENAtyzd8lPO0ddF51KnEmf0PC9II/VgQV+b
         7V60NzqlTPEr0WXxE5Zc8LzKs6iq1BCfKKm3P/LyATgKKydX/isYQFT8Sh/zshtkeG0w
         XSsAu6Jl0i2VTdlLXX8IeDTnJ0JPPrKHnuakzacGChK7GQFGZmtiIz/Htp/POPZWIjIG
         BmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424079; x=1697028879;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bC74TryHv+J80MOfZq7W8YVW0BJt9KS7QGciFS22VQ=;
        b=E6pivdemV1zDZtlBjjbMhrNIKRr5DDsStSq6b+EtZ6TS7QweurRkWgys/r5LCR3gmD
         mEHRvBYkmlWLcq3WTeMRlTaT8AaYqMOFKJGA7zxQ5VZZBpakqBcUYlP+N2mNnDh53H/d
         ITipmuuZOQEDY3/jSkSNgoQGa+DJ/j/eqB4G+HiD8cDagpJ2j6dMGuH1LVNyx15KRKYb
         btYvTAFCSQdVQhJC00cxi/SZVJENmlZ0MiGr1LMEILIM8R+fgL7qiXqwn4ma8K10x1pg
         vXLWTMR0H8M/fyyq0PPLn3kstleVIcinJL5bLJZOvXxq5ehJb9WXsGocn9XPOt8IlcAf
         ISvw==
X-Gm-Message-State: AOJu0Yz+5olfemn5B6g/sonJBYNpkBUzpnh5fHdtQ3ay/cQY9mEchxr+
        LaAmwCYBW0ts6Q5ap9EsImTfT4xCuoc=
X-Google-Smtp-Source: AGHT+IECMraJgLOrBHCKmfzZvyl8/4W358Hz44FDzdvBzTNqWeyNxlnZlmBNj7niGD7Br5m6qA/sNg==
X-Received: by 2002:a17:906:76d3:b0:9ae:65a5:b6f4 with SMTP id q19-20020a17090676d300b009ae65a5b6f4mr1837244ejn.20.1696424079365;
        Wed, 04 Oct 2023 05:54:39 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id r13-20020a170906350d00b009a9fbeb15f5sm2740350eja.46.2023.10.04.05.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:54:38 -0700 (PDT)
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
 <1647d018-cb4e-7c4a-c80f-c726b1ea3628@gmail.com>
 <ZR0bqBbvM+hHOPXX@gofer.mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <1c96b6f1-bb88-0027-a7a0-ec85768c6b90@gmail.com>
Date:   Wed, 4 Oct 2023 15:54:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZR0bqBbvM+hHOPXX@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4.10.23 г. 11:00 ч., Sean Young wrote:
> Hi,
> 
> On Mon, Oct 02, 2023 at 09:16:53AM +0300, Ivaylo Dimitrov wrote:
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
>>
>> what about the following patch(not a proper one, just RFC)? It achieves the
>> same (if not better) precision (on n900 at least) without using atomic pwm.
>> What it does is: create a fifo thread in which we swicth pwm on/off, start
>> hrtimer that is used to signal thread when to switch pwm.
>> As signal comes earlier than needed(because hrtimer runs async to the
>> thread), we do a busy loop wait for the precise time to switch the pwm. At
>> least on n900, this busy loop is less than 200 us per switch(worst case,
>> usually it is less than 100 us). That way, even if we have some latency
>> spike, it is covered by not doing busy loop for that particular pwm switch
>> and we keep the precise timing.
> 
> I think this is a good idea.
> 
>> Maybe we shall merge both patches so fifo thread to be used for sleeping
>> pwms and hrtimer for atomic. I can do that and test it here if you think
>> that approach makes sense.
> 
> Let's try and merge this patch for the next merge window, and worry about
> the atomic version after that. We've already queued the ir-rx51 removal
> patches to media_stage so it would be nice to have to revert these patches,
> and improve pwm-ir-tx for the next kernel release.
> 

ir-rx51 is broken without 
https://www.spinics.net/lists/kernel/msg4953300.html, it is also missing 
a call to init_waitqueue_head() in the probe() function. So I have no 
strong opinion on what shall be done with it.

> I'll test your patch, in the mean time would you mind posting this patch
> as a proper patch (with review comments below addressed)?
> 

ok

> Thanks,
> 
> Sean
> 
> 
>>
>> Regards,
>> Ivo
>>
>> PS: I have a patch that converts timer-ti-dm to non-sleeping one, will send
>> it when it comes to it.
>>
>> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
>> index 105a9c24f1e3..e8b620f53056 100644
>> --- a/drivers/media/rc/pwm-ir-tx.c
>> +++ b/drivers/media/rc/pwm-ir-tx.c
>> @@ -4,6 +4,7 @@
>>    */
>>
>>   #include <linux/kernel.h>
>> +#include <linux/kthread.h>
>>   #include <linux/module.h>
>>   #include <linux/pwm.h>
>>   #include <linux/delay.h>
>> @@ -17,8 +18,16 @@
>>
>>   struct pwm_ir {
>>   	struct pwm_device *pwm;
>> +	struct hrtimer timer;
>> +	struct task_struct *tx_thread;
>> +	wait_queue_head_t tx_wq;
>> +	struct completion tx_done;
>> +	struct completion edge;
>>   	unsigned int carrier;
>>   	unsigned int duty_cycle;
>> +	unsigned int *txbuf;
>> +	unsigned int count;
>> +	unsigned int index;
>>   };
>>
>>   static const struct of_device_id pwm_ir_of_match[] = {
>> @@ -48,35 +57,103 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32
>> carrier)
>>   	return 0;
>>   }
>>
>> -static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>> -		     unsigned int count)
>> +static enum hrtimer_restart pwm_ir_timer_cb(struct hrtimer *timer)
>> +{
>> +	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
>> +	ktime_t now;
>> +
>> +	/*
>> +	 * If we happen to hit an odd latency spike, loop through the
>> +	 * pulses until we catch up.
>> +	 */
>> +	do {
>> +		u64 edge;
>> +
>> +		if (pwm_ir->index >= pwm_ir->count)
>> +			goto out;
> 
> Might as well avoid the goto and put the complete and return in the body of
> the if.
> 

right, will fix

>> +
>> +		complete(&pwm_ir->edge);
>> +
>> +		edge = US_TO_NS(pwm_ir->txbuf[pwm_ir->index]);
>> +		hrtimer_add_expires_ns(timer, edge);
>> +
>> +		pwm_ir->index++;
>> +
>> +		now = timer->base->get_time();
>> +
>> +	} while (hrtimer_get_expires_tv64(timer) < now);
>> +
>> +	return HRTIMER_RESTART;
>> +out:
>> +	complete(&pwm_ir->edge);
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +static void _pwm_ir_tx(struct pwm_ir *pwm_ir)
>>   {
>> -	struct pwm_ir *pwm_ir = dev->priv;
>> -	struct pwm_device *pwm = pwm_ir->pwm;
>>   	struct pwm_state state;
>>   	int i;
>>   	ktime_t edge;
>>   	long delta;
>>
>> -	pwm_init_state(pwm, &state);
>> +	pwm_init_state(pwm_ir->pwm, &state);
>>
>>   	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>>   	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
>>
>> +	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
>> +	wait_for_completion(&pwm_ir->edge);
>>   	edge = ktime_get();
>>
>> -	for (i = 0; i < count; i++) {
>> +	for (i = 0; i < pwm_ir->count; i++) {
>>   		state.enabled = !(i % 2);
>> -		pwm_apply_state(pwm, &state);
>> +		pwm_apply_state(pwm_ir->pwm, &state);
>> +
>> +		edge = ktime_add_us(edge, pwm_ir->txbuf[i]);
>> +		wait_for_completion(&pwm_ir->edge);
>>
>> -		edge = ktime_add_us(edge, txbuf[i]);
>>   		delta = ktime_us_delta(edge, ktime_get());
>> +
>>   		if (delta > 0)
>> -			usleep_range(delta, delta + 10);
>> +			udelay(delta);
>>   	}
>>
>>   	state.enabled = false;
>> -	pwm_apply_state(pwm, &state);
>> +	pwm_apply_state(pwm_ir->pwm, &state);
>> +
>> +	pwm_ir->count = 0;
>> +}
>> +
>> +static int pwm_ir_thread(void *data)
>> +{
>> +	struct pwm_ir *pwm_ir = data;
>> +
>> +	for (;;) {
>> +		wait_event_idle(pwm_ir->tx_wq,
>> +				kthread_should_stop() || pwm_ir->count);
>> +
>> +		if (kthread_should_stop())
>> +			break;
>> +
>> +		_pwm_ir_tx(pwm_ir);
>> +		complete(&pwm_ir->tx_done);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>> +		     unsigned int count)
>> +{
>> +	struct pwm_ir *pwm_ir = dev->priv;
>> +
>> +	pwm_ir->txbuf = txbuf;
>> +	pwm_ir->count = count;
>> +	pwm_ir->index = 0;
>> +
>> +	wake_up(&pwm_ir->tx_wq);
>> +	wait_for_completion(&pwm_ir->tx_done);
>>
>>   	return count;
>>   }
>> @@ -91,12 +168,24 @@ static int pwm_ir_probe(struct platform_device *pdev)
>>   	if (!pwm_ir)
>>   		return -ENOMEM;
>>
>> +	platform_set_drvdata(pdev, pwm_ir);
>> +
>> +	pwm_ir->count = 0;
>> +
>>   	pwm_ir->pwm = devm_pwm_get(&pdev->dev, NULL);
>>   	if (IS_ERR(pwm_ir->pwm))
>>   		return PTR_ERR(pwm_ir->pwm);
>>
>> -	pwm_ir->carrier = 38000;
>> +	init_waitqueue_head(&pwm_ir->tx_wq);
>> +	init_completion(&pwm_ir->edge);
>> +	init_completion(&pwm_ir->tx_done);
>> +
>> +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	pwm_ir->timer.function = pwm_ir_timer_cb;
>> +
>>   	pwm_ir->duty_cycle = 50;
>> +	pwm_ir->carrier = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm_ir->pwm),
>> +						NSEC_PER_SEC);
>>
>>   	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
>>   	if (!rcdev)
>> @@ -109,15 +198,38 @@ static int pwm_ir_probe(struct platform_device *pdev)
>>   	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
>>   	rcdev->s_tx_carrier = pwm_ir_set_carrier;
>>
>> +	pwm_ir->tx_thread = kthread_create(pwm_ir_thread, pwm_ir, "%s/tx",
>> +					   dev_name(&pdev->dev));
>> +	if (IS_ERR(pwm_ir->tx_thread))
>> +		return PTR_ERR(pwm_ir->tx_thread);
>> +
>> +	sched_set_fifo(pwm_ir->tx_thread);
>> +	wake_up_process(pwm_ir->tx_thread);
> 
> This means the thread is always around. How about creating the thread
> per-tx?
> 

Yes, that can be done, just not sure what the overhead would be.

Also, I think we shall reconsider the way the driver works:

Imagine we have to pretend we are TV remote that supports NEC protocol 
(for example), especially the "REPEAT CODES" part. Currently, no matter 
what we do, there is no way to get the timings even remotely right, as 
we have no idea what the "warmup" and "complete" delays are. Like, 
starting thread (if needed), hrtimer setup time, completions waiting, 
contexts switching, etc.

So, I think the correct thing to do is to copy txbuf (as a list of 
txbufs) into pwm_ir in tx function, start pulses generation and return 
from pwm_ir_tx() *immediately*, without waiting for tx to finish. If 
userspace requests submission of another set of pulses while we are 
still sending the current one, well, we accept it, add it to the list 
and delay the sending until the current one is finished. When there is 
nothing more to send (the list is empty), stop the hrtimer (and perhaps 
the thread)

I think that way userspace will be able to append as many "repeat" 
pulses with proper timings as it wants (with some sane limits ofc).

Unless we somehow have API restriction that we shall not return until tx 
is finished.

Does that make any sense to you?

Thanks,
Ivo

>> +
>>   	rc = devm_rc_register_device(&pdev->dev, rcdev);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		kthread_stop(pwm_ir->tx_thread);
>>   		dev_err(&pdev->dev, "failed to register rc device\n");
>> +	}
>>
>>   	return rc;
>>   }
>>
>> +static int pwm_ir_remove(struct platform_device *pdev)
>> +{
>> +	struct pwm_ir *pwm_ir = platform_get_drvdata(pdev);
>> +
>> +	if (pwm_ir->tx_thread) {
>> +		kthread_stop(pwm_ir->tx_thread);
>> +		pwm_ir->tx_thread = NULL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static struct platform_driver pwm_ir_driver = {
>>   	.probe = pwm_ir_probe,
>> +	.remove = pwm_ir_remove,
>>   	.driver = {
>>   		.name	= DRIVER_NAME,
>>   		.of_match_table = of_match_ptr(pwm_ir_of_match),
