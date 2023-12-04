Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21E803DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjLDS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjLDS7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:59:23 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790310F;
        Mon,  4 Dec 2023 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=56pO4Svmr6AVJn7qAnmQe61nDF4lPq7pDPdbMfAgwAY=; b=c3EbNhLsrJUg5/7j6/oBpaQ9De
        0jSjRoyLSEophZcLyIbn9knQI74e3eSL8DE8sr/jPahqm4WLrF0ZEovSMeLQJ7zJDxJ+LaH4zPYSd
        eKTcv9Ul0OQBAJCxY9uTeFk1STx8IlpIbseSNk4BUcD19/Ge2kackeZxfWw+NDSYSVPc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37702 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rAEA6-0000rB-Bz; Mon, 04 Dec 2023 13:59:23 -0500
Date:   Mon, 4 Dec 2023 13:59:22 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231204135922.0355f030945920086d21b8b6@hugovil.com>
In-Reply-To: <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
        <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
        <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
        <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
        <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
        <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
        <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
        <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
        <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
        <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 17:19:25 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 12:01:51PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > I don't understand what you mean here - you say that the addresses both
> > > have addresses 0x1 and 0x81 but map to address 0x1.  What does the 0x81
> > > refer to?  The comments in the driver seemed to indicate that there was
> > > a single address which mapped to multiple underlying registers...
> 
> > I was referring to an example in da9063-i2c.c where they have
> > these two registers:
> 
> > #define	DA9063_REG_STATUS_A		0x01
> > #define	DA9063_REG_SEQ			0x81
> 
> > To access one or the other, you must select page 0 or 1 in page config
> > selection register at address 0x00. It makes sense to me for this case.
> 
> That appears to be a bit confused in that they've mapped the window
> through which you view the paged registers on top of the physical
> register map - I suppose that will work but more through luck than
> design.  The window is the physical address range through which the
> actual registers can be accessed, the range is the virtual register
> numbers through which users access the regmap.  It'll make things
> clearer if they don't overlap.

Ok, that was probably not a good example, let's forget about it, for
me at least :)

I found a better example maybe with tas2770.c.

> > But for the sc16is7xx, for example you have these two
> > independent registers, sharing the exact same address:
> 
> > #define SC16IS7XX_IIR_REG		(0x02) /* Interrupt Identification */
> > #define SC16IS7XX_FCR_REG		(0x02) /* FIFO control */
> 
> > I am not sure if regmap range can be used with this configuration.
> > Assuming regmap range would be properly setup, when we call
> > regmap_read(regmap, SC16IS7XX_IIR_REG, &val), how does regmap would
> > know that we want to access SC16IS7XX_IIR_REG and not SC16IS7XX_FCR_REG?
> 
> This is the exact situation this feature is supposed to handle, your
> window is address 2 and then you should pick some random non-physical
> numbers to map the two registers to for access by users.  The core will
> then do appropriate physical accesses transparently to manage the
> window.  The whole point here is to assign new, virtual addresses to the
> two registers you're trying to access.

Ok, I see.

Based on tas2770.c, I am assuming I could redefine the code to look
like this:

/* SC16IS7XX register definitions */
#define SC16IS7XX_REG(page, reg)        ((page * 128) + reg)

#define SC16IS7XX_RHR_REG	SC16IS7XX_REG(0, 0x00) /* RX FIFO */
#define SC16IS7XX_THR_REG	SC16IS7XX_REG(0, 0x00) /* TX FIFO */
#define SC16IS7XX_IER_REG	SC16IS7XX_REG(0, 0x01) /* Interrupt enable */
#define SC16IS7XX_IIR_REG	SC16IS7XX_REG(0, 0x02) /* Interrupt Identification (read) */
#define SC16IS7XX_FCR_REG	SC16IS7XX_REG(0, 0x02) /* FIFO control (write) */
#define SC16IS7XX_MCR_REG	SC16IS7XX_REG(0, 0x04) /* Modem Control */
#define SC16IS7XX_LSR_REG	SC16IS7XX_REG(0, 0x05) /* Line Status */
#define SC16IS7XX_MSR_REG	SC16IS7XX_REG(0, 0x06) /* Modem Status */
#define SC16IS7XX_SPR_REG	SC16IS7XX_REG(0, 0x07) /* Scratch Pad */
...
#define SC16IS7XX_EFR_REG	SC16IS7XX_REG(1, 0x02) /* Enhanced Features */
#define SC16IS7XX_XON1_REG	SC16IS7XX_REG(1, 0x04) /* Xon1 word */
#define SC16IS7XX_XON2_REG	SC16IS7XX_REG(1, 0x05) /* Xon2 word */
#define SC16IS7XX_XOFF1_REG	SC16IS7XX_REG(1, 0x06) /* Xoff1 word */
#define SC16IS7XX_XOFF2_REG	SC16IS7XX_REG(1, 0x07) /* Xoff2 word */
...

static const struct regmap_range_cfg sc16is7xx_regmap_ranges[] = {
	{
		.range_min = 0,
		.range_max = 1 * 128,
		.selector_reg = SC16IS7XX_LCR_REG,
		.selector_mask = 0xff,
		.selector_shift = 0,
		.window_start = 0,
		.window_len = 128,
	},
};

But here, selecting the proper "page" is not obvious,
because to select page 1, we need to write a fixed value of 0xBF to
the LCR register.

And when selecting page 0, we must write the previous value that was
in LCR _before_ we made the switch to page 1...

How do we do that?

Hugo.

 
> > > Searching for struct regmap_range_cfg should show a lot of users in
> > > mainline.
> 
> > Yes, I am trying to find a good example but I must download and read the
> > datasheet for each one. If you could point to an IC/driver that uses
> > regmap_range similar to IC sc16is7xx, it would really help.
> 
> Essentially all of them should be fine.  
