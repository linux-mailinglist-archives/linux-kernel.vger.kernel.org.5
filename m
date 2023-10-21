Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92F7D1E73
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjJURCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJURCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F6124;
        Sat, 21 Oct 2023 10:02:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA79C433C8;
        Sat, 21 Oct 2023 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697907762;
        bh=ZR0ckwmKzr4OchS2lwegZntLrbRhjuWKJprTwNRlhKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzx55b4erPsj7YZNMNfFtL2EtmGTBx0Bp8qXeeztQVL8bzemR3zSoIF3OqMZBWbVy
         TKGFpCdKi1sb9UX1yXAEWGoFIdo7ftlaHaZahg/CvnyYEf6+MgJ73glavxb/S2a5Ug
         ZDAIJqhM9BGAtQ2ipnOOIME9F6CNOGlX9qsRlrfE=
Date:   Sat, 21 Oct 2023 19:02:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <2023102105-outfit-legroom-1633@gregkh>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020160027.3663772-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note, your subject line needs to change.

On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> In typical embedded Linux systems, UART consoles require at least two pins,
> TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> present, we can save these two pins by using this driver. Pins is crucial

"Pins are crucial"

> resources, especially in small chip packages.
> 
> This introduces support for using the I3C bus to transfer console tty data,
> effectively replacing the need for dedicated UART pins. This not only
> conserves valuable pin resources but also facilitates testing of I3C's
> advanced features, including early termination, in-band interrupt (IBI)
> support, and the creation of more complex data patterns. Additionally,
> it aids in identifying and addressing issues within the I3C controller
> driver.

But where is the serial data ending up at?  Not a normal uart, what is
on the other end?  And do line settings mean anything here?

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     This patch depend on
>     https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t

Let's wait for those to be accepted first, right?

> +static DEFINE_IDR(i3c_tty_minors);
> +static DEFINE_MUTEX(i3c_tty_minors_lock);

I thought idr didn't need a mutex anymore, are you sure this is still
needed?

> +static struct tty_driver *i3c_tty_driver;
> +
> +#define I3C_TTY_MINORS		256

Do you really need 256 minors?

> +#define I3C_TTY_TRANS_SIZE	16
> +#define I3C_TTY_RX_STOP		0
> +#define I3C_TTY_RETRY		20
> +#define I3C_TTY_YIELD_US	100
> +
> +struct ttyi3c_port {
> +	struct tty_port port;
> +	int minor;
> +	spinlock_t xlock; /* protect xmit */
> +	char tx_buff[I3C_TTY_TRANS_SIZE];
> +	char rx_buff[I3C_TTY_TRANS_SIZE];
> +	struct i3c_device *i3cdev;
> +	struct work_struct txwork;
> +	struct work_struct rxwork;
> +	struct completion txcomplete;
> +	unsigned long status;
> +	int buf_overrun;

You set buf_overrun but never do anything with it.  Why care about it?

Other than these minor things, looks sane, nice work.

thanks,

greg k-h
