Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8A7AE8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjIZJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjIZJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:16:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4984E6;
        Tue, 26 Sep 2023 02:16:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD6F340004;
        Tue, 26 Sep 2023 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695719809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62i6jKle2TrQicZgJBk/autmG/K7qzxoSj1CVO2zc+w=;
        b=LEwU4lFeHRNnHHEVD100Q7J4C1swRhuGuU9sigjtpACm+bhaLpArGlAqMfJspzhIFeBUcQ
        Fy0WS340DGTFyJUi/5F11vXu7qXVai/0vdRLqMjDus8oOWW6TsnYmI6JLOYYJrkTxUVyN+
        L/Doi05uXxgBshAo9saucTBogZODomazcwPZrv4yilbcs0gpHDXCh0FieUi+yPF/X9EyRo
        0TBaCFbp+RRBEiA0PizTbjdhxhpH6kR/E4qpYgsgoYeBrFEr5Klv1FRX+1n4wtzAZ1Q9BE
        MgEn1anNzShjL0OKx7LrlOdmM4sFqwLAZmIFGnUPPyO/jcAmrCJVni9GjFAQfA==
Date:   Tue, 26 Sep 2023 11:16:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] mtd: rawnand: ingenic: move the GPIO quirk to
 gpiolib-of.c
Message-ID: <20230926111643.58ee4587@xps-13>
In-Reply-To: <20230926090623.35595-1-brgl@bgdev.pl>
References: <20230926090623.35595-1-brgl@bgdev.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

brgl@bgdev.pl wrote on Tue, 26 Sep 2023 11:06:23 +0200:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> We have a special place for OF polarity quirks in gpiolib-of.c. Let's
> move this over there so that it doesn't pollute the driver.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This is an alternative to the previous patch that instead of replacing
> one active-low setter with another, just moves the quirk over to
> gpiolib-of.c
>=20
>  drivers/gpio/gpiolib-of.c                       |  9 +++++++++
>  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 12 ------------
>  2 files changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 5515f32cf19b..58c0bbe9d569 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -192,6 +192,15 @@ static void of_gpio_try_fixup_polarity(const struct =
device_node *np,
>  		 */
>  		{ "himax,hx8357",	"gpios-reset",	false },
>  		{ "himax,hx8369",	"gpios-reset",	false },
> +		/*
> +		 * The rb-gpios semantics was undocumented and qi,lb60 (along with
> +		 * the ingenic driver) got it wrong. The active state encodes the
> +		 * NAND ready state, which is high level. Since there's no signal
> +		 * inverter on this board, it should be active-high. Let's fix that
> +		 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
> +		 * helper, and be consistent with what other drivers do.
> +		 */
> +		{ "qi,lb60",		"rb-gpios",	true },

I didn't know about such a list, interesting. Better be aware when
debugging :)

IIRC Linus was fine, so if Paul also agrees I guess this is better
taking through the gpio tree? I don't have any ingenic related changes
queued right now so feel free to take it.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
