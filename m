Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B507675FF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGXSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:53:16 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85B10E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:53:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id O0gBqLUHmRQxjO0gBqj7iM; Mon, 24 Jul 2023 20:53:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690224792;
        bh=oljbd7XDZ9hHN81Af8q06t6IIPGygtd8E5UbWRmCNUY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XN5nVEopSR2NdBmrIjpfHFih/5tI9SpMG4MEFSYQtYyzLHXkCavBlGAY9G38+v/5X
         riw4ATDWVYVyE+Var/aE8WZXkZoIvhrXhjKT9VP91jJNsJh5BMlktqWHKkrXLUYemZ
         /3q4R7rm8Yu/DnRESxc77Urs+aL6dAQyG8KPf3gBJAzHW1dAPdZVkXq+bp5YVpOwup
         Krw3H+KkJrlFgZ+5+nJsx5ZwCzk2MC6CqG9bpjkXgWZE2acgKEdYOgZWj5GRJoJIMO
         8JQc49hL/ZbFD1f/ATj0sVDtF3YEOtzY/azAilJF1Yn58L52nKSR47nOMbeJMHoumG
         1sD1ql1Yjes1w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jul 2023 20:53:12 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b83df292-6f7a-a8bf-895e-6df80a17029f@wanadoo.fr>
Date:   Mon, 24 Jul 2023 20:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] Input: lm8323 - convert to use devm_* api
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
References: <20230724052901.350240-1-dmitry.torokhov@gmail.com>
 <20230724052901.350240-2-dmitry.torokhov@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230724052901.350240-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/07/2023 à 07:29, Dmitry Torokhov a écrit :
> From: Yangtao Li <frank.li@vivo.com>
> 
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/keyboard/lm8323.c | 77 +++++++++++----------------------
>   1 file changed, 26 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index d5195415533a..7bee93e9b0f5 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -556,6 +556,7 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
>   		    const char *name)
>   {
>   	struct lm8323_pwm *pwm;
> +	int err;
>   
>   	BUG_ON(id > 3);
>   
> @@ -575,9 +576,11 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
>   		pwm->cdev.name = name;
>   		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
>   		pwm->cdev.groups = lm8323_pwm_groups;
> -		if (led_classdev_register(dev, &pwm->cdev) < 0) {
> -			dev_err(dev, "couldn't register PWM %d\n", id);
> -			return -1;
> +
> +		err = devm_led_classdev_register(dev, &pwm->cdev);
> +		if (err) {
> +			dev_err(dev, "couldn't register PWM %d: %d\n", id, err);
> +			return err;
>   		}
>   		pwm->enabled = true;
>   	}
> @@ -585,8 +588,6 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
>   	return 0;
>   }
>   
> -static struct i2c_driver lm8323_i2c_driver;
> -
>   static ssize_t lm8323_show_disable(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
> @@ -648,12 +649,13 @@ static int lm8323_probe(struct i2c_client *client)
>   		return -EINVAL;
>   	}
>   
> -	lm = kzalloc(sizeof *lm, GFP_KERNEL);
> -	idev = input_allocate_device();
> -	if (!lm || !idev) {
> -		err = -ENOMEM;
> -		goto fail1;
> -	}
> +	lm = devm_kzalloc(&client->dev, sizeof(*lm), GFP_KERNEL);
> +	if (!lm)
> +		return -ENOMEM;
> +
> +	idev = devm_input_allocate_device(&client->dev);
> +	if (!idev)
> +		return -ENOMEM;
>   
>   	lm->client = client;
>   	lm->idev = idev;
> @@ -669,8 +671,10 @@ static int lm8323_probe(struct i2c_client *client)
>   
>   	lm8323_reset(lm);
>   
> -	/* Nothing's set up to service the IRQ yet, so just spin for max.
> -	 * 100ms until we can configure. */
> +	/*
> +	 * Nothing's set up to service the IRQ yet, so just spin for max.
> +	 * 100ms until we can configure.
> +	 */
>   	tmo = jiffies + msecs_to_jiffies(100);
>   	while (lm8323_read(lm, LM8323_CMD_READ_INT, data, 1) == 1) {
>   		if (data[0] & INT_NOINIT)
> @@ -690,15 +694,14 @@ static int lm8323_probe(struct i2c_client *client)
>   	/* If a true probe check the device */
>   	if (lm8323_read_id(lm, data) != 0) {
>   		dev_err(&client->dev, "device not found\n");
> -		err = -ENODEV;
> -		goto fail1;
> +		return -ENODEV;
>   	}
>   
>   	for (pwm = 0; pwm < LM8323_NUM_PWMS; pwm++) {
>   		err = init_pwm(lm, pwm + 1, &client->dev,
>   			       pdata->pwm_names[pwm]);
> -		if (err < 0)
> -			goto fail2;
> +		if (err)
> +			return err;
>   	}
>   
>   	lm->kp_enabled = true;
> @@ -722,14 +725,16 @@ static int lm8323_probe(struct i2c_client *client)
>   	err = input_register_device(idev);
>   	if (err) {
>   		dev_dbg(&client->dev, "error registering input device\n");
> -		goto fail2;
> +		return err;
>   	}
>   
> -	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
> -			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, lm8323_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					"lm8323", lm);
>   	if (err) {
>   		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
> -		goto fail3;
> +		return err;
>   	}
>   
>   	i2c_set_clientdata(client, lm);
> @@ -738,35 +743,6 @@ static int lm8323_probe(struct i2c_client *client)
>   	enable_irq_wake(client->irq);
>   
>   	return 0;
> -
> -fail3:
> -	input_unregister_device(idev);
> -	idev = NULL;
> -fail2:
> -	while (--pwm >= 0)
> -		if (lm->pwm[pwm].enabled)
> -			led_classdev_unregister(&lm->pwm[pwm].cdev);

This and...

> -fail1:
> -	input_free_device(idev);
> -	kfree(lm);
> -	return err;
> -}
> -
> -static void lm8323_remove(struct i2c_client *client)
> -{
> -	struct lm8323_chip *lm = i2c_get_clientdata(client);
> -	int i;
> -
> -	disable_irq_wake(client->irq);
> -	free_irq(client->irq, lm);
> -
> -	input_unregister_device(lm->idev);
> -
> -	for (i = 0; i < 3; i++)
> -		if (lm->pwm[i].enabled)
> -			led_classdev_unregister(&lm->pwm[i].cdev);

this look wrong.
What you left for lm8323 looks correct.

CJ

> -
> -	kfree(lm);
>   }
>   
>   /*
> @@ -827,7 +803,6 @@ static struct i2c_driver lm8323_i2c_driver = {
>   		.dev_groups	= lm8323_groups,
>   	},
>   	.probe		= lm8323_probe,
> -	.remove		= lm8323_remove,
>   	.id_table	= lm8323_id,
>   };
>   MODULE_DEVICE_TABLE(i2c, lm8323_id);

