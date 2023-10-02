Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36317B4B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjJBFuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:49:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DAAC;
        Sun,  1 Oct 2023 22:49:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so21154149a12.1;
        Sun, 01 Oct 2023 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696225793; x=1696830593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmoOR/EI2utIi1unwoyCX1pbMVDR6URKEDRCZKsU5aU=;
        b=ni8BC8KHQicdxEH7htgdD2NVqb9L+fVtp2DErs6p/4ZJ7I+WNnCGzxNmmPqfMyDa6L
         BmlMzfr12XCearN85L7UW05OoMB5pG3GS2vM6Zk5UWhxDOFOJ+6tyM9XZs+X6XKOjU1D
         PQiKhvVYAoWek/+sYUkpUKk00NwuRA6N2eutia7lhrGEhvrg4kixyADoc77qjeQdCh+b
         RIpXp18p31pZmyQA9d0V+o6UMY2JirBOT1kXovKmu909dhdaCLtJjgopg8ZGYb5C5SFe
         R4AwazBZ4K+NdT/VBg0SR0QloY5qWdsrpHvKw9QGxweMBHhRhkn25lTC3nuY3Q0BNr9V
         AfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696225793; x=1696830593;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmoOR/EI2utIi1unwoyCX1pbMVDR6URKEDRCZKsU5aU=;
        b=IZA3vnwZikAJa5nCTgWZwBORjpNW3MtlIcbdNy3TtdaQhdzgcvF7BmhPgFfzDPLxxG
         zSgR+NMtAokLov0lvDxKaL9FQO80SCunI1fnjWEbdEY6YRkqmu7NMer9ZNKGreQBQzb0
         QuU+nBEa9LZhRS6jt+omgP62PyBvsiIglKPHj9EudvSMOvD7Q+SXJqJDkvc1dnunmTi2
         AKp9eYYIndcK1xS+4tRivg2QlklZ14xcrnrZOYlgm/P59QP8uNwAGKsvAVVbLvrLLC75
         9oEvkwePH3ZHKE3i0q7S/EXLcmLEkbwk6gu024tuN5fU/7YG3loxA8zCoeh7ogqRyt5W
         5W5Q==
X-Gm-Message-State: AOJu0Yytl+tYYVDLMoNS2qlFcqynE0+BWd6bMCJix+fkx5UvIHsK778F
        bK0T96dYxVRdOaLayEO3kVuO7pUbi4I=
X-Google-Smtp-Source: AGHT+IH2kTlGJPH8c+oazo+iqk8M0z2UzLkF9QWbY7H6r7SayPfUiceMx/QyM/Yx0jTWGefcpsaobQ==
X-Received: by 2002:aa7:d6d2:0:b0:52f:6641:4ecd with SMTP id x18-20020aa7d6d2000000b0052f66414ecdmr9194592edr.37.1696225793294;
        Sun, 01 Oct 2023 22:49:53 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id x62-20020a50bac4000000b0053443c8fd90sm9901062ede.24.2023.10.01.22.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2023 22:49:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
Date:   Mon, 2 Oct 2023 08:49:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1.10.23 г. 13:40 ч., Sean Young wrote:
> The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> from delays as this is done in process context. Make this work in atomic
> context.
> 
> This makes the driver much more precise.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index c5f37c03af9c..557725a07a67 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -10,6 +10,8 @@
>   #include <linux/slab.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/completion.h>
>   #include <media/rc-core.h>
>   
>   #define DRIVER_NAME	"pwm-ir-tx"
> @@ -17,8 +19,13 @@
>   
>   struct pwm_ir {
>   	struct pwm_device *pwm;
> -	unsigned int carrier;
> -	unsigned int duty_cycle;
> +	struct hrtimer timer;
> +	struct completion completion;
> +	uint carrier;
> +	uint duty_cycle;
> +	uint *txbuf;
> +	uint txbuf_len;
> +	uint txbuf_index;
>   };
>   
>   static const struct of_device_id pwm_ir_of_match[] = {
> @@ -55,33 +62,65 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>   	struct pwm_ir *pwm_ir = dev->priv;
>   	struct pwm_device *pwm = pwm_ir->pwm;
>   	struct pwm_state state;
> -	int i;
> -	ktime_t edge;
> -	long delta;
> +
> +	reinit_completion(&pwm_ir->completion);

You should not need that.

>   
>   	pwm_init_state(pwm, &state);
>   
>   	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>   	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> +	state.enabled = false;
>   
> -	edge = ktime_get();
> +	pwm_ir->txbuf = txbuf;
> +	pwm_ir->txbuf_len = count;
> +	pwm_ir->txbuf_index = 0;
>   
> -	for (i = 0; i < count; i++) {
> -		state.enabled = !(i % 2);
> -		pwm_apply_state(pwm, &state);
> +	pwm_apply_state(pwm, &state);
>   

ditto, first pwm control should be in the timer function

> -		edge = ktime_add_us(edge, txbuf[i]);
> -		delta = ktime_us_delta(edge, ktime_get());
> -		if (delta > 0)
> -			usleep_range(delta, delta + 10);
> -	}
> +	hrtimer_start(&pwm_ir->timer, 1000, HRTIMER_MODE_REL);
>   

why not just call it with 0 time?

> -	state.enabled = false;
> -	pwm_apply_state(pwm, &state);
> +	wait_for_completion(&pwm_ir->completion);
>   
>   	return count;
>   }
>   
> +static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
> +{
> +	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
> +	ktime_t now;
> +
> +	/*
> +	 * If we happen to hit an odd latency spike, loop through the
> +	 * pulses until we catch up.
> +	 */
> +	do {
> +		u64 ns;
> +
> +		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
> +			/* Stop TX here */
> +			pwm_disable(pwm_ir->pwm);
> +
> +			complete(&pwm_ir->completion);
> +
> +			return HRTIMER_NORESTART;
> +		}
> +
> +		if (pwm_ir->txbuf_index % 2)
> +			pwm_disable(pwm_ir->pwm);
> +		else
> +			pwm_enable(pwm_ir->pwm);
> +

pwm_ir->pwm->state.enabled = !(pwm_ir->txbuf_index % 2);
pwm_apply_state(pwm_ir->pwm, pwm_ir->state);

> +		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
> +		hrtimer_add_expires_ns(timer, ns);
> +
> +		pwm_ir->txbuf_index++;
> +
> +		now = timer->base->get_time();
> +	} while (hrtimer_get_expires_tv64(timer) < now);
> +
> +	return HRTIMER_RESTART;
> +}
> +
>   static int pwm_ir_probe(struct platform_device *pdev)
>   {
>   	struct pwm_ir *pwm_ir;
> @@ -96,8 +135,16 @@ static int pwm_ir_probe(struct platform_device *pdev)
>   	if (IS_ERR(pwm_ir->pwm))
>   		return PTR_ERR(pwm_ir->pwm);
>   
> +	if (pwm_can_sleep(pwm_ir->pwm)) {
> +		dev_err(&pdev->dev, "unsupported pwm device: driver can sleep\n");
> +		return -ENODEV;
> +	}
> +

I think we shall not limit, but use high priority thread to support 
those drivers. I have that working on n900 with current (sleeping) pwm, 
see my reply on the other mail. Maybe we can combine both patches in a 
way to support both atomic and sleeping pwm drivers.

>   	pwm_ir->carrier = 38000;
>   	pwm_ir->duty_cycle = 50;
> +	init_completion(&pwm_ir->completion);
> +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	pwm_ir->timer.function = pwm_ir_timer;
>   
>   	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
>   	if (!rcdev)
> 

Regards,
Ivo
