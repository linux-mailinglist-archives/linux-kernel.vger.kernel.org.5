Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875677B2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjHNHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjHNHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7427E73;
        Mon, 14 Aug 2023 00:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433266423C;
        Mon, 14 Aug 2023 07:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB7C433C8;
        Mon, 14 Aug 2023 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998778;
        bh=K1ssrh1C1cpCotV7bPzZb/F45LVd+6cD8e6wcK+CSJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=izUbETfq2qR8HA7QrMmE0buc+2edVKxmaYiBT6A9GUJ+LaDdUT3n6S1XYn+nliXs9
         WXezkm++0vB3TpwcHcYn+xe/B4E3PdWnUsnne0lNb3BDwpfrRJDAfWbj6KaMV0wwbJ
         qwH+57cIaMQPHGkb1UcnSX/IbLXZVtxo2mrTN54Zggq/3r5H7G5OW6+ZZTZ9b+4BP1
         epkjlJrNY1+KyfUzmtXu/RjerZWhM5dgZmDouwbggRXhfNv9wG3pkbO/3DXoLfZuhS
         y7nocbmFRjQ4bfe9nzwB1FQkDwVp4FnAJ0JHobIKdGF6KIXdvbD38PFkwzrjyBuyAG
         Zj+w6XwRJBEXw==
Date:   Mon, 14 Aug 2023 09:39:34 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport
 GPIO on freeing")
Message-ID: <20230814093934.1793961e@dellmb>
In-Reply-To: <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
References: <20230808102828.4a9eac09@dellmb>
        <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 13:16:46 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Aug 08, 2023 at 10:28:28AM +0200, Marek Beh=C3=BAn wrote:
> > Hi,
> >=20
> > the commit b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db0ce9ce408b6
> >=20
> > causes a regression on my mvebu arm board (haven't tested on other
> > systems), wherein if I export a GPIO to sysfs and then unexport it, it
> > does not disasppear from the /sys/class/gpio directory, and subsequent
> > writes to the export and unexport files for the gpio fail.
> >=20
> >   $ cd /sys/class/gpio
> >   $ ls
> >   export       gpiochip0    gpiochip32   gpiochip512  unexport
> >   $ echo 43 >export
> >   $ ls
> >   export       gpio43       gpiochip0    gpiochip32   gpiochip512
> >   unexport
> >   $ cat gpio43/value
> >   1
> >   $ echo 43 >unexport
> >   $ ls
> >   export       gpio43       gpiochip0    gpiochip32   gpiochip512
> >   unexport
> >   $ echo 43 >unexport
> >   ash: write error: Invalid argument
> >   $ echo 43 >export
> >   ash: write error: Operation not permitted =20
>=20
> Can you test the following change (I'll submit a formal patch if it works=
)?
>=20
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 530dfd19d7b5..b10a9b5598b2 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -515,8 +515,9 @@ static ssize_t unexport_store(const struct class *cla=
ss,
>  	 * they may be undone on its behalf too.
>  	 */
>  	if (test_and_clear_bit(FLAG_SYSFS, &desc->flags)) {
> +		gpiod_unexport(desc);
> +		gpiod_free(desc);
>  		status =3D 0;
> -		gpiod_free(desc);
>  	}
>  done:
>  	if (status)
>=20

tested, works.

Please add Fixes tag when sending the patch
