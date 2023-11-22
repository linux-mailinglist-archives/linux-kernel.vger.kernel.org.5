Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC57F49E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjKVPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbjKVPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:10:12 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC792;
        Wed, 22 Nov 2023 07:10:08 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id BEDFA30000CF4;
        Wed, 22 Nov 2023 16:10:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B3E17382C1; Wed, 22 Nov 2023 16:10:06 +0100 (CET)
Date:   Wed, 22 Nov 2023 16:10:06 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
Message-ID: <20231122151006.GB18949@wunner.de>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120151056.148450-3-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:10:55PM +0100, Rasmus Villemoes wrote:
> Add code for handling a rs485-mux-gpio specified in device tree.

Hm, that's a bit terse as a commit message.


> @@ -1457,6 +1466,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
>  	uart_set_rs485_termination(port, &rs485);
> +	/*
> +	 * To avoid glitches on the transmit enable pin, the mux must
> +	 * be set before calling the driver's ->rs485_config when
> +	 * disabling rs485 mode, but after when enabling rs485
> +	 * mode.
> +	 */
> +	if (!(rs485.flags & SER_RS485_ENABLED))
> +		uart_set_rs485_mux(port, &rs485);

Can it happen that the UART's FIFO contains characters such that
suddenly switching the mux causes some of them to appear on the
RS-485 transceiver and some on the RS-232 driver?

Shouldn't we wait for the FIFO to drain before making the switch?
I think that would be closer to the behavior expected by user space.


> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -584,6 +584,7 @@ struct uart_port {
>  	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
>  	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
>  	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
> +	struct gpio_desc	*rs485_mux_gpio;	/* gpio for selecting RS485 mode */

Again, the code comment isn't really helpful as it doesn't add a whole
lot of information to the variable name "rs485_mux_gpio".  How about:
"select between RS-232 and RS-485 transceiver" ?

(I realize I made a typo in my previous e-mail about the DT-binding,
sorry about that: s/connect/connected/)

Thanks,

Lukas
