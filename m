Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733377F336F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKUQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjKUQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:15:31 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004A192;
        Tue, 21 Nov 2023 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=FaJZiiZl+AKs/XpxDxvO0kr9+dO45PgzMu7kHvX6oXA=; b=i4fYPWMgS3xePm17Y/OkT9DGwS
        X9GMzTFNqHk9hZGN9LIOCjdsrpwJd9mtqxAQ8c6ha/2HpUAA7Ga/JvunpwWHuFbnthFLnnUeLnszY
        UJ40Jf9i3tFQ5tZuc09JqW5t67LGaoZUamlwy8gorHKvDNoMuC4k6D7vU2LO+44ZSC8E=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54644 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r5TP0-0000bX-42; Tue, 21 Nov 2023 11:15:07 -0500
Date:   Tue, 21 Nov 2023 11:15:04 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lech.perczak@camlingroup.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20231121111504.6fca4b22bd6d3cc05c6fb668@hugovil.com>
In-Reply-To: <90ba18b8-1a31-498d-a103-5c91b80cea5b@kernel.org>
References: <20231120163931.2872431-1-hugo@hugovil.com>
        <20231120163931.2872431-2-hugo@hugovil.com>
        <90ba18b8-1a31-498d-a103-5c91b80cea5b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2 1/1] serial: sc16is7xx: improve regmap debugfs by
 using one regmap per port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 06:57:56 +0100
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 20. 11. 23, 17:39, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > With this current driver regmap implementation, it is hard to make sense
> > of the register addresses displayed using the regmap debugfs interface,
> > because they do not correspond to the actual register addresses documented
> > in the datasheet. For example, register 1 is displayed as registers 04 thru
> > 07:
> ...
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> ...
> >   #ifdef CONFIG_SERIAL_SC16IS7XX_SPI
> >   static int sc16is7xx_spi_probe(struct spi_device *spi)
> >   {
> >   	const struct sc16is7xx_devtype *devtype;
> > -	struct regmap *regmap;
> > +	struct regmap *regmaps[2];
> 
> IMO, in all places, it would make sense to declare a VLA with 
> devtype->nr_uart.
 
Hi Jiri,
are VLA now allowed in kernel code?

 
> > +	unsigned int i;
> >   	int ret;
> >   
> >   	/* Setup SPI bus */
> > @@ -1732,11 +1736,20 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
> >   		devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
> >   	}
> >   
> > -	regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
> > -			      (devtype->nr_uart - 1);
> > -	regmap = devm_regmap_init_spi(spi, &regcfg);
> > +	for (i = 0; i < devtype->nr_uart; i++) {
> > +		regcfg.name = sc16is7xx_regmap_name(i);
> > +		/*
> > +		 * If read_flag_mask is 0, the regmap code sets it to a default
> > +		 * of 0x80. Since we specify our own mask, we must add the READ
> > +		 * bit ourselves:
> > +		 */
> > +		regcfg.read_flag_mask = sc16is7xx_regmap_port_mask(i) |
> > +			SC16IS7XX_SPI_READ_BIT;
> > +		regcfg.write_flag_mask = sc16is7xx_regmap_port_mask(i);
> > +		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
> 
> As you trip over the array until devtype->nr_uart which is of course up 
> to 2. For now.
> 
> Or at least add an asserion: devtype->nr_uart <= 2 somewhere.

devtype->nr_uart is coming from const struct sc16is7xx_devtype, so it
is always a constant, do we need an assert in this case?

Hugo.


> thanks,
> -- 
> js
> suse labs
> 
> 
