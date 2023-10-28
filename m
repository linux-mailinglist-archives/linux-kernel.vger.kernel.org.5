Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240A47DA693
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJ1Knv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJ1Kns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:43:48 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA71C1;
        Sat, 28 Oct 2023 03:43:43 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Sat, 28 Oct 2023 12:43:40 +0200
MIME-Version: 1.0
Date:   Sat, 28 Oct 2023 12:43:40 +0200
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
In-Reply-To: <20231023094205.2706812-3-fe@dev.tdt.de>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
Message-ID: <ddf9439a092576cd18c6e025d0b61602@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Eckert wrote on 2023-10-23 11:42:

> @@ -16,6 +16,28 @@ struct ledtrig_tty_data {
>      const char *ttyname;
>      struct tty_struct *tty;
>      int rx, tx;
> +     unsigned long ttytrigger;
> +};

ttytriggers ?

[...]

>  static void ledtrig_tty_work(struct work_struct *work)
>  {
>  	struct ledtrig_tty_data *trigger_data =
>  		container_of(work, struct ledtrig_tty_data, dwork.work);
> +	struct led_classdev *led_cdev = trigger_data->led_cdev;
> +	unsigned long interval = LEDTRIG_TTY_INTERVAL;
>  	struct serial_icounter_struct icount;
> +	enum led_trigger_tty_state state;
> +	int current_brightness;
> +	int status;
>  	int ret;
> 
> +	state = TTY_LED_DISABLE;
>  	mutex_lock(&trigger_data->mutex);
> 
>  	if (!trigger_data->ttyname) {
> @@ -115,22 +218,74 @@ static void ledtrig_tty_work(struct work_struct 
> *work)
>  		trigger_data->tty = tty;
>  	}
> 
> -	ret = tty_get_icount(trigger_data->tty, &icount);
> -	if (ret) {
> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
> polling\n");
> -		mutex_unlock(&trigger_data->mutex);
> -		return;
> +	status = tty_get_tiocm(trigger_data->tty);
> +	if (status > 0) {
> +		if (test_bit(TRIGGER_TTY_CTS, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_CTS)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_DSR, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_DSR)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_CAR, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_CAR)
> +				state = TTY_LED_ENABLE;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_RNG, &trigger_data->ttytrigger)) {
> +			if (status & TIOCM_RNG)
> +				state = TTY_LED_ENABLE;
> +		}
> +	}
> +
> +	/* The rx/tx handling must come after the evaluation of TIOCM_*,
> +	 * since the display for rx/tx has priority
> +	 */
> +	if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) ||
> +	    test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger)) {
> +		ret = tty_get_icount(trigger_data->tty, &icount);
> +		if (ret) {
> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped 
> polling\n");
> +			mutex_unlock(&trigger_data->mutex);
> +			return;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_RX, &trigger_data->ttytrigger) &&
> +		    (icount.tx != trigger_data->tx)) {

You check for TRIGGER_TTY_RX and then compare icount.tx, is that 
correct?

> +			trigger_data->tx = icount.tx;
> +			state = TTY_LED_BLINK;
> +		}
> +
> +		if (test_bit(TRIGGER_TTY_TX, &trigger_data->ttytrigger) &&
> +		    (icount.rx != trigger_data->rx)) {

You check for TRIGGER_TTY_TX and then compare icount.rx, is that 
correct?

> +			trigger_data->rx = icount.rx;
> +			state = TTY_LED_BLINK;
> +		}
>  	}
> 
> -	if (icount.rx != trigger_data->rx ||
> -	    icount.tx != trigger_data->tx) {
> -		unsigned long interval = LEDTRIG_TTY_INTERVAL;
> +	current_brightness = led_cdev->brightness;
> +	if (current_brightness)
> +		led_cdev->blink_brightness = current_brightness;
> 
> +	if (!led_cdev->blink_brightness)
> +		led_cdev->blink_brightness = led_cdev->max_brightness;

Is it OK to override the chosen brightness here?

> +
> +	switch (state) {
> +	case TTY_LED_BLINK:
>  		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
>  				      &interval, 0);

Change trigger_data->led_cdev to simply led_cdev

Shouldn't the led return to the line controlled steady state?
Set an invert variable to true if state was TTY_LED_ENABLE before it got 
set
to TTY_LED_BLINK

How do interval and the frequency of ledtrig_tty_work() relate?

> -
> -		trigger_data->rx = icount.rx;
> -		trigger_data->tx = icount.tx;
> +		break;
> +	case TTY_LED_ENABLE:
> +		led_set_brightness(led_cdev, led_cdev->blink_brightness);
> +		break;
> +	case TTY_LED_DISABLE:
> +		fallthrough;
> +	default:
> +		led_set_brightness(led_cdev, LED_OFF);
> +		break;
>  	}

Maarten

