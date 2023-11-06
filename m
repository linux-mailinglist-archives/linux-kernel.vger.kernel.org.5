Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041427E2500
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjKFN1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjKFN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:27:14 -0500
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A5EA;
        Mon,  6 Nov 2023 05:27:07 -0800 (PST)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
        Mon, 6 Nov 2023 14:27:04 +0100
MIME-Version: 1.0
Date:   Mon, 06 Nov 2023 14:27:04 +0100
From:   m.brock@vanmierlo.com
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v7 6/6] leds: ledtrig-tty: add additional line state
 evaluation
In-Reply-To: <20231106123415.3365732-7-fe@dev.tdt.de>
References: <20231106123415.3365732-1-fe@dev.tdt.de>
 <20231106123415.3365732-7-fe@dev.tdt.de>
Message-ID: <bc94f31e965be6f640c286f8c8a2cf38@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Eckert wrote on 2023-11-06 13:34:
> Add an invert flag on LED blink, so that the LED blinks in the correct 
> order.
> * LED was 'on' in the previous round, then it should first go 'off' and
>   then 'on' again when it should blink (data has been transferred).
> * LED was 'off' in the previous round, then it should first go 'on' and
>   then 'off' again when it should blink (data has been transferred).
> 
> In order to also evaluate the LED 'state' form the previous round, so 
> we
> could blink in the correct order, the 'state' must be saved in the 
> trigger
> data struct.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> diff --git a/drivers/leds/trigger/ledtrig-tty.c
> b/drivers/leds/trigger/ledtrig-tty.c
> index 1a40a78bf1ee..107fbbca96de 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -17,19 +17,29 @@ struct ledtrig_tty_data {
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
> +	int state;

I don't think you need to remember the state here.

>  	bool mode_rx;
>  	bool mode_tx;
> +	bool mode_cts;
> +	bool mode_dsr;
> +	bool mode_dcd;
> +	bool mode_rng;
>  };
> @@ -167,16 +201,27 @@ static ssize_t ledtrig_tty_attr_store(struct
> device *dev, const char *buf,
> 
>  DEFINE_TTY_TRIGGER(rx, TRIGGER_TTY_RX);
>  DEFINE_TTY_TRIGGER(tx, TRIGGER_TTY_TX);
> +DEFINE_TTY_TRIGGER(cts, TRIGGER_TTY_CTS);
> +DEFINE_TTY_TRIGGER(dsr, TRIGGER_TTY_DSR);
> +DEFINE_TTY_TRIGGER(dcd, TRIGGER_TTY_DCD);
> +DEFINE_TTY_TRIGGER(rng, TRIGGER_TTY_RNG);
> 
>  static void ledtrig_tty_work(struct work_struct *work)
>  {
>  	struct ledtrig_tty_data *trigger_data =
>  		container_of(work, struct ledtrig_tty_data, dwork.work);
>  	struct led_classdev *led_cdev = trigger_data->led_cdev;
> -	enum led_trigger_tty_state state = TTY_LED_DISABLE;

Keep this one.

>  	unsigned long interval = LEDTRIG_TTY_INTERVAL;
> +	int invert = 0;

bool invert = false;

> +	int status;
>  	int ret;
> 
> +	if (trigger_data->state == TTY_LED_ENABLE)
> +		invert = 1;

Drop the above.

> +
> +	/* Always disable the LED if no evaluation could be done */
> +	trigger_data->state = TTY_LED_DISABLE;
> +
>  	if (!trigger_data->ttyname)
>  		goto out;
> 
> @@ -202,6 +247,33 @@ static void ledtrig_tty_work(struct work_struct 
> *work)
>  		trigger_data->tty = tty;
>  	}
> 
> +	status = tty_get_tiocm(trigger_data->tty);
> +	if (status > 0) {
> +		if (trigger_data->mode_cts) {
> +			if (status & TIOCM_CTS)
> +				trigger_data->state = TTY_LED_ENABLE;
> +		}
> +
> +		if (trigger_data->mode_dsr) {
> +			if (status & TIOCM_DSR)
> +				trigger_data->state = TTY_LED_ENABLE;
> +		}
> +
> +		if (trigger_data->mode_dcd) {
> +			if (status & TIOCM_CAR)
> +				trigger_data->state = TTY_LED_ENABLE;
> +		}
> +
> +		if (trigger_data->mode_rng) {
> +			if (status & TIOCM_RNG)
> +				trigger_data->state = TTY_LED_ENABLE;
> +		}
> +	}
> +
> +	/*
> +	 * The evaluation of rx/tx must be done after the evaluation
> +	 * of TIOCM_*, because rx/tx has priority.
> +	 */
>  	if (trigger_data->mode_rx || trigger_data->mode_tx) {
>  		struct serial_icounter_struct icount;
> 
> @@ -211,19 +283,22 @@ static void ledtrig_tty_work(struct work_struct 
> *work)
> 
>  		if (trigger_data->mode_tx && (icount.tx != trigger_data->tx)) {
>  			trigger_data->tx = icount.tx;

invert = state == TTY_LED_ENABLE;

> -			state = TTY_LED_BLINK;

Keep this line.

> +			trigger_data->state = TTY_LED_BLINK;

And drop this one.

>  		}
> 
>  		if (trigger_data->mode_rx && (icount.rx != trigger_data->rx)) {
>  			trigger_data->rx = icount.rx;

invert = state == TTY_LED_ENABLE;

> -			state = TTY_LED_BLINK;
> +			trigger_data->state = TTY_LED_BLINK;
>  		}
>  	}
> 
>  out:
> -	switch (state) {
> +	switch (trigger_data->state) {
>  	case TTY_LED_BLINK:
> -		led_blink_set_oneshot(led_cdev, &interval, &interval, 0);
> +		led_blink_set_oneshot(led_cdev, &interval, &interval, invert);
> +		break;
> +	case TTY_LED_ENABLE:
> +		led_set_brightness(led_cdev, led_cdev->blink_brightness);
>  		break;
>  	case TTY_LED_DISABLE:
>  		fallthrough;

Maarten

