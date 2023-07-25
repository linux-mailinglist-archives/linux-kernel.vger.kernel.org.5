Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF72762292
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGYTnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:43:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0171FF3;
        Tue, 25 Jul 2023 12:43:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9922d6f003cso1000702166b.0;
        Tue, 25 Jul 2023 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690314193; x=1690918993;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4EDHiImAehzxN7ZZoBMLmEOghHlcxby6Ov6sk2XD30=;
        b=JZqhdCJFX+RclnmaiPFowKJ78g9nZjOmX1D0KsDIeNmnJ6YyBB+akIDsa7XDGBsK+G
         1ZOKzArx6GcCliZnefhUXGOsAwcZogulldxn4Rnn6ClD4uIwVbxYoaRCWN4DaU9ueXhC
         WbmgVqMjlQihnlnBsxl3qQA0zF9585dsBF3T+Aps31NV2N3J4zJCsfieq3zsVJyZKUim
         SaegUI7ESAYng7l03hkCvhN7WE8O5SMmfekaUIKRydETSujCHYJg5Wmpxy9Ba4KLgwJA
         NnKOBBpOTVdSRooBB7PrC9577BbDAKRO0E8JygM/soYhYYyIsBWIgwu7nFKBo3hBQgFd
         8vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314193; x=1690918993;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4EDHiImAehzxN7ZZoBMLmEOghHlcxby6Ov6sk2XD30=;
        b=NDHbSgANaBHOVxbNDI6INCDsjh9JsZlwZJ9IubpDoQpESg8I9vy86CaySonD6+MzQa
         i00yx+9TrOwawtkvCVPlfCi3UAPYXGHhwgrbTPxY/qrGrWxqQr5vicTg4UDU13hc8o54
         M6bchsjMEd+aFbOI4mRGH0sOtq9GQ/LTctCEQqm0FWr+GoJRXsc2DJu/2fmHbkQNROxZ
         H7OEu1KxR7/4GCDw9/Y1PUeDrevfFZn9aV1IipqkealQ25D3sCG3mWymRPCne5lPRquO
         +I8WUQjbvzH6bCfUoZlqVu8qX2OCyPrdcgG+WImQtepNy74kWyNFS4fVvcfTzEc03csd
         p8bg==
X-Gm-Message-State: ABy/qLZieIFtziJut7vumVzVUn6mrV38QNL2IdCrf2eneZr9jEnrY0tu
        4uN9Bit+Hb1xLBuiCbpxzEI=
X-Google-Smtp-Source: APBJJlGXd1smXFONtSui/vo+Rqof804etBUukB7DnjvxEGGhLiTQdcbhjPjrCDePRl1HOfjjbBJ4ug==
X-Received: by 2002:a17:907:2e0d:b0:969:93f2:259a with SMTP id ig13-20020a1709072e0d00b0096993f2259amr13091264ejc.73.1690314193005;
        Tue, 25 Jul 2023 12:43:13 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id k27-20020a1709063e1b00b00982842ea98bsm8488557eji.195.2023.07.25.12.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:43:12 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:43:12 +0200
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: tca6416-keypad - switch to using input core's
 polling features
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20230724053024.352054-1-dmitry.torokhov@gmail.com>
 <20230724053024.352054-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20230724053024.352054-5-dmitry.torokhov@gmail.com>
Message-Id: <2KN6Z0RZYGDKU.2GGSSC8MYU6GX@homearch.localdomain>
User-Agent: mblaze/1.2-21-g48dd346 (2023-07-08)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just one question below.

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Instead of rolling custom polling implementation use input core
> facilities.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/tca6416-keypad.c | 46 ++++++++++---------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyb=
oard/tca6416-keypad.c
> index ff665319791e..ebc8b9561266 100644
> --- a/drivers/input/keyboard/tca6416-keypad.c
> +++ b/drivers/input/keyboard/tca6416-keypad.c
> @@ -24,6 +24,8 @@
>  #define TCA6416_INVERT         2
>  #define TCA6416_DIRECTION      3
> =20
> +#define TCA6416_POLL_INTERVAL	100 /* msec */
> +
>  static const struct i2c_device_id tca6416_id[] =3D {
>  	{ "tca6416-keys", 16, },
>  	{ "tca6408-keys", 8, },
> @@ -43,7 +45,6 @@ struct tca6416_keypad_chip {
> =20
>  	struct i2c_client *client;
>  	struct input_dev *input;
> -	struct delayed_work dwork;
>  	int io_size;
>  	int irqnum;
>  	u16 pinmask;
> @@ -85,9 +86,9 @@ static int tca6416_read_reg(struct tca6416_keypad_chip =
*chip, int reg, u16 *val)
>  	return 0;
>  }
> =20
> -static void tca6416_keys_scan(struct tca6416_keypad_chip *chip)
> +static void tca6416_keys_scan(struct input_dev *input)
>  {
> -	struct input_dev *input =3D chip->input;
> +	struct tca6416_keypad_chip *chip =3D input_get_drvdata(input);
>  	u16 reg_val, val;
>  	int error, i, pin_index;
> =20
> @@ -122,33 +123,20 @@ static void tca6416_keys_scan(struct tca6416_keypad=
_chip *chip)
>   */
>  static irqreturn_t tca6416_keys_isr(int irq, void *dev_id)
>  {
> -	struct tca6416_keypad_chip *chip =3D dev_id;
> -
> -	tca6416_keys_scan(chip);
> +	tca6416_keys_scan(dev_id);
> =20
>  	return IRQ_HANDLED;
>  }
> =20
> -static void tca6416_keys_work_func(struct work_struct *work)
> -{
> -	struct tca6416_keypad_chip *chip =3D
> -		container_of(work, struct tca6416_keypad_chip, dwork.work);
> -
> -	tca6416_keys_scan(chip);
> -	schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
> -}
> -
>  static int tca6416_keys_open(struct input_dev *dev)
>  {
>  	struct tca6416_keypad_chip *chip =3D input_get_drvdata(dev);
> =20
> -	/* Get initial device state in case it has switches */
> -	tca6416_keys_scan(chip);
> -
> -	if (chip->use_polling)
> -		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
> -	else
> +	if (!chip->use_polling) {
> +		/* Get initial device state in case it has switches */
> +		tca6416_keys_scan(dev);
>  		enable_irq(chip->client->irq);
> +	}
> =20
>  	return 0;
>  }
> @@ -157,9 +145,7 @@ static void tca6416_keys_close(struct input_dev *dev)=

>  {
>  	struct tca6416_keypad_chip *chip =3D input_get_drvdata(dev);
> =20
> -	if (chip->use_polling)
> -		cancel_delayed_work_sync(&chip->dwork);
> -	else
> +	if (!chip->use_polling)
>  		disable_irq(chip->client->irq);
>  }
> =20
> @@ -232,8 +218,6 @@ static int tca6416_keypad_probe(struct i2c_client *cl=
ient)
>  	chip->pinmask =3D pdata->pinmask;
>  	chip->use_polling =3D pdata->use_polling;
> =20
> -	INIT_DELAYED_WORK(&chip->dwork, tca6416_keys_work_func);
> -
>  	input->phys =3D "tca6416-keys/input0";
>  	input->name =3D client->name;
> =20
> @@ -268,12 +252,20 @@ static int tca6416_keypad_probe(struct i2c_client *=
client)
>  		return error;
> =20
>  	if (!chip->use_polling) {

Sorry for my ignorant question but it seems counterituitive that we set
up polling when chip->use_polling is false. Is this intended?

Cheers,
Silvan

> +		error =3D input_setup_polling(input, tca6416_keys_scan);
> +		if (error) {
> +			dev_err(&client->dev, "Failed to setup polling\n");
> +			return error;
> +		}
> +
> +		input_set_poll_interval(input, TCA6416_POLL_INTERVAL);
> +	} else {
>  		error =3D devm_request_threaded_irq(&client->dev, client->irq,
>  						  NULL, tca6416_keys_isr,
>  						  IRQF_TRIGGER_FALLING |
>  							IRQF_ONESHOT |
>  							IRQF_NO_AUTOEN,
> -						  "tca6416-keypad", chip);
> +						  "tca6416-keypad", input);
>  		if (error) {
>  			dev_dbg(&client->dev,
>  				"Unable to claim irq %d; error %d\n",


