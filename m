Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2B7F655A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbjKWRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjKWRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61900A1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80025C433CB;
        Thu, 23 Nov 2023 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760179;
        bh=XJ7kY1GciSBN8ZVxLG7wgVhOwuwldl8TrXxYyhxZJk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARnpA8sMQbZuhIT+Z/k4mFB5iiosqNIbRQs/7slljkiTk/VdyZ10RTaFGTBpww0MQ
         2zlYhndKiGi8LNsfvLqVuSPqF7k8jy8XciAE7KzwE3KTr2tCC88rO/3MJxqeNINiWj
         Wsmj7MiYWZb38lteGIZjFpGaTdD0PN4n4Ktro2zw=
Date:   Thu, 23 Nov 2023 14:17:52 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [RESEND PATCH v4 1/7] serial: Do not hold the port lock when
 setting rx-during-tx GPIO
Message-ID: <2023112304-cornbread-coping-cdce@gregkh>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
 <20231119112856.11587-2-l.sanfilippo@kunbus.com>
 <a2b54b76-01ce-4aa2-a00b-e65e123ba7e9@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b54b76-01ce-4aa2-a00b-e65e123ba7e9@kunbus.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:55:49PM +0100, Lino Sanfilippo wrote:
> 
> 
> On 19.11.23 12:28, Lino Sanfilippo wrote:
> > Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
> > Since this function is called with the port lock held, this can be an
> > problem in case that setting the GPIO line can sleep (e.g. if a GPIO
> > expander is used which is connected via SPI or I2C).
> > 
> > Avoid this issue by moving the GPIO setting outside of the port lock into
> > the serial core and thus making it a generic feature.
> > 
> > Since both setting the term and the rx-during-tx GPIO is done at the same
> > code place, move it into a common function.
> 
> > -				       const struct serial_rs485 *rs485)
> > +/*
> > + * Set optional RS485 GPIOs for bus termination and data reception during
> > + * transmission. These GPIOs are controlled by the serial core independently
> > + * from the UART driver.
> > + */
> > +static void uart_set_rs485_gpios(struct uart_port *port,
> > +				 const struct serial_rs485 *rs485)
> >  {
> >  	if (!(rs485->flags & SER_RS485_ENABLED))
> >  		return;
> >  
> >  	gpiod_set_value_cansleep(port->rs485_term_gpio,
> >  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> > +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> > +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
> >  }
> >  
> 
> Rasmus is about to add support for another RS485 related GPIO (see 
> https://lore.kernel.org/all/20231120151056.148450-3-linux@rasmusvillemoes.dk/ )
> which has to be configured both before and after port->rs485_config(). This
> does not fit very well with the idea of handling all these GPIOs in
> one function. 
> 
> So I would like to revise this patch and send an updated version in a v5
> of this series in which the suggestion from Hugo
> (see https://lore.kernel.org/all/20231011183656.5111ba32ec0c9d43171662a1@hugovil.com/)
> is implemented to use separate functions for the GPIO configurations.
> 

I'll drop this, thanks for letting me know.

There are WAY too many different "enable 485 in this way" patches that
are all conflicting with each other.  Can you all decide on a common way
to handle this, otherwise none of these are going to be acceptable :(

thanks,

greg k-h
