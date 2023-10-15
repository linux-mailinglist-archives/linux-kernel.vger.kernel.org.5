Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4A7C982E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJOGbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 02:31:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0386D8;
        Sat, 14 Oct 2023 23:31:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso6153241a12.0;
        Sat, 14 Oct 2023 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697351506; x=1697956306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7BjF49jhYcIOnOxtIyZhIJ7GyT/yGc0vCgKZxiCb78=;
        b=SgH8L9GWA7hmfllNyi+XUiEhSvIC1AdQ8xyKp4CO/jQ96TtlsDE8dLLZ+196o3xIyc
         P80H3Jhz1DggDNHTJBC2KkxQVNAZyeV52TNT0++kjubmHUJbx7Qf3ZwxCSTI0wEZwi1v
         K1g9FJDCvI05SV1MqMajtfeXgaIdWCnFCD8WApw1AjZ5aTi8DpbuNUUwyhRIHb0AiRZ4
         vpAhRMf0xxPXlD2muPxG+/GZcC0uk+OLEh7tr/QLhU5UdsDzZ+v7Lyuc2EjU6drO7ioU
         4lNs4bjOYW7hGFHs6G4kKDiAYKdzPN6HBOc7+Ki0BXaXBcWipt6X+AlI6wptnb5JMBrd
         BRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697351506; x=1697956306;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7BjF49jhYcIOnOxtIyZhIJ7GyT/yGc0vCgKZxiCb78=;
        b=R2SQ+YY7BaGv+Hb9FAGS+S9uFmNMv2w6i4pmisIvc6XuWLUyKVshRJntyoEF8OtoNf
         gHLW2JYswrSCTeGxroCE6chb7D3KGsGkTYkRoPUnemjj2hLwuqgWYxF2x/yD+TuztZJ/
         Nn3nzW8YpukNhAhjyLnWLBRLwbHslV+yHel++aCD8uwk1ROSl44IJJNYOOnruOBippCr
         S5kluxSgR8SJXmRiX9UeYki8S1Me0lEwL3jW2M2kew6d63HDk0Hbms+eu25ezz3qAs0Z
         Iy48h+2IxWmEr7UpJ1Bm7hBVGsbcKlb6oPQ01MYH3nMXDFGBGTESE1zHe/bDUoJyRCx8
         hb0A==
X-Gm-Message-State: AOJu0YyZKvJSZuNC0gZBLo7SivZ0zUzcOTfPn9ii03mcBtliyCO47RGR
        v5Hxw5w4yCBHCl9wpg9BPMTOceusQvo=
X-Google-Smtp-Source: AGHT+IG5GU6Vbn9iHhOSKlxeHGHBMvSeePpqmhHFbwMiiUjBMcRLHfjQuUnfIsI+FpGNZ7dQECfxhQ==
X-Received: by 2002:a05:6402:354c:b0:53e:5a90:e57 with SMTP id f12-20020a056402354c00b0053e5a900e57mr4820970edd.37.1697351506027;
        Sat, 14 Oct 2023 23:31:46 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id cx16-20020a05640222b000b0053dbb214d96sm5714642edb.13.2023.10.14.23.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Oct 2023 23:31:45 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <cover.1697193646.git.sean@mess.org>
 <1560b474f7d426bc77100665c14c3a29c3af3e75.1697193646.git.sean@mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <e47d4d33-4689-915d-3169-5c122075df05@gmail.com>
Date:   Sun, 15 Oct 2023 09:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560b474f7d426bc77100665c14c3a29c3af3e75.1697193646.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.10.23 г. 13:46 ч., Sean Young wrote:
> This makes the driver much more precise.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index c5f37c03af9c..3e801fa8ee2c 100644
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
> @@ -17,8 +19,14 @@
>   
>   struct pwm_ir {
>   	struct pwm_device *pwm;
> -	unsigned int carrier;
> -	unsigned int duty_cycle;
> +	struct hrtimer timer;
> +	struct completion completion;

what about 'struct completion tx_done'?

> +	struct pwm_state *state;
> +	uint carrier;
> +	uint duty_cycle;

With my c++ developer hat on, I think either 'u32' or 'unsigned int' is 
more proper type for carrier and duty_cycle. Both s_tx_duty_cycle and 
s_tx_carrier are declared with second parameter of type u32, maybe 
that's what have to be used all over the place if you are to change from 
'unsigned int'. But better leave as it is, pwm_set_relative_duty_cycle() 
takes 'unsigned int' anyway.

> +	uint *txbuf;
> +	uint txbuf_len;
> +	uint txbuf_index;

OTOH, it is (*tx_ir)(struct rc_dev *dev, unsigned *txbuf, unsigned n), 
so maybe you should use 'unsigned' or 'unsigned int' for those.

I know at the end all those will be compiled to same type, but still :)

>   };
>   
>   static const struct of_device_id pwm_ir_of_match[] = {
> @@ -82,6 +90,62 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>   	return count;
>   }
>   
> +static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned int *txbuf,
> +			    unsigned int count)
> +{
> +	struct pwm_ir *pwm_ir = dev->priv;
> +	struct pwm_device *pwm = pwm_ir->pwm;
> +	struct pwm_state state;
> +
> +	pwm_init_state(pwm, &state);
> +
> +	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> +	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> +
> +	pwm_ir->txbuf = txbuf;
> +	pwm_ir->txbuf_len = count;
> +	pwm_ir->txbuf_index = 0;
> +	pwm_ir->state = &state;
> +
> +	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
> +
> +	wait_for_completion(&pwm_ir->completion);
> +
> +	return count;
> +}
> +
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
> +		pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
> +		pwm_apply_state_atomic(pwm_ir->pwm, pwm_ir->state);
> +
> +		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
> +			complete(&pwm_ir->completion);
> +
> +			return HRTIMER_NORESTART;
> +		}
> +
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
> @@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
>   	if (!rcdev)
>   		return -ENOMEM;
>   
> +	if (pwm_is_atomic(pwm_ir->pwm)) {
> +		init_completion(&pwm_ir->completion);
> +		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		pwm_ir->timer.function = pwm_ir_timer;
> +		rcdev->tx_ir = pwm_ir_tx_atomic;
> +	} else {
> +		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not support atomic mode");
> +		rcdev->tx_ir = pwm_ir_tx;
> +	}
> +
>   	rcdev->priv = pwm_ir;
>   	rcdev->driver_name = DRIVER_NAME;
>   	rcdev->device_name = DEVICE_NAME;
> -	rcdev->tx_ir = pwm_ir_tx;
>   	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
>   	rcdev->s_tx_carrier = pwm_ir_set_carrier;
>   
> 
