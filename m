Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41D803E95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjLDTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjLDTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:41:38 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE12130;
        Mon,  4 Dec 2023 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=4F8te3CcN8fC7428PEPCneVCtnuvCp7pX/IUd0SB0o8=; b=zLWXwqRE3hH2NY/KPHO4z31E3h
        75P90UMK2QgWyjk7gwEQJ+g//oZZHK4GfETP3oW442iTH8pd+fRdN50sp7XqP16e03ErifjVxpaM6
        BQksZyrMGrwW2Isp/NN8CJZx44x+c0DmProQZiHb2ioXtP7qZ0Kl1kc/kQmlWo+dOjhY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39972 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rAEoy-00018K-IR; Mon, 04 Dec 2023 14:41:37 -0500
Date:   Mon, 4 Dec 2023 14:41:36 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231204144136.89fec6da9be49e3db96994e0@hugovil.com>
In-Reply-To: <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
References: <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
        <ce3eaa82-66e9-404b-9062-0f628dc6164f@sirena.org.uk>
        <20231201163846.a7c1d79daca7c6a2e1416a70@hugovil.com>
        <f5277458-635a-4eca-a37d-c3b2e83eb4b9@sirena.org.uk>
        <20231201171644.6f7ade89d4c2f744fa3556b7@hugovil.com>
        <20231204112905.e58cf1b7bf94440f49188390@hugovil.com>
        <06fa462c-5b48-410e-8656-4d0dbdbfa142@sirena.org.uk>
        <20231204120151.f0afbee2ebc69e93e7977547@hugovil.com>
        <50b24985-cb30-4a75-a15d-9c165a276f1d@sirena.org.uk>
        <20231204135922.0355f030945920086d21b8b6@hugovil.com>
        <66946666-eb33-431d-9870-7046c39ffb4e@sirena.org.uk>
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

On Mon, 4 Dec 2023 19:16:57 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 04, 2023 at 01:59:22PM -0500, Hugo Villeneuve wrote:
> 
> > Based on tas2770.c, I am assuming I could redefine the code to look
> > like this:
> 
> > /* SC16IS7XX register definitions */
> > #define SC16IS7XX_REG(page, reg)        ((page * 128) + reg)
> > 
> > #define SC16IS7XX_RHR_REG	SC16IS7XX_REG(0, 0x00) /* RX FIFO */
> > #define SC16IS7XX_THR_REG	SC16IS7XX_REG(0, 0x00) /* TX FIFO */
> > #define SC16IS7XX_IER_REG	SC16IS7XX_REG(0, 0x01) /* Interrupt enable */
> > #define SC16IS7XX_IIR_REG	SC16IS7XX_REG(0, 0x02) /* Interrupt Identification (read) */
> > #define SC16IS7XX_FCR_REG	SC16IS7XX_REG(0, 0x02) /* FIFO control (write) */
> > #define SC16IS7XX_MCR_REG	SC16IS7XX_REG(0, 0x04) /* Modem Control */
> > #define SC16IS7XX_LSR_REG	SC16IS7XX_REG(0, 0x05) /* Line Status */
> > #define SC16IS7XX_MSR_REG	SC16IS7XX_REG(0, 0x06) /* Modem Status */
> > #define SC16IS7XX_SPR_REG	SC16IS7XX_REG(0, 0x07) /* Scratch Pad */
> > ...
> > #define SC16IS7XX_EFR_REG	SC16IS7XX_REG(1, 0x02) /* Enhanced Features */
> > #define SC16IS7XX_XON1_REG	SC16IS7XX_REG(1, 0x04) /* Xon1 word */
> > #define SC16IS7XX_XON2_REG	SC16IS7XX_REG(1, 0x05) /* Xon2 word */
> > #define SC16IS7XX_XOFF1_REG	SC16IS7XX_REG(1, 0x06) /* Xoff1 word */
> > #define SC16IS7XX_XOFF2_REG	SC16IS7XX_REG(1, 0x07) /* Xoff2 word */
> 
> > static const struct regmap_range_cfg sc16is7xx_regmap_ranges[] = {
> > 	{
> > 		.range_min = 0,
> > 		.range_max = 1 * 128,
> > 		.selector_reg = SC16IS7XX_LCR_REG,
> > 		.selector_mask = 0xff,
> > 		.selector_shift = 0,
> > 		.window_start = 0,
> > 		.window_len = 128,
> > 	},
> > };
> 
> That looks plausible - I'd tend to make the range just completely
> non-physical (eg, start at some unrepresentable value) so there's no
> possible ambiguity with a physical address.  I'm also not clear why
> you've made the window be 128 registers wide if it's just this range

I simply took what was in tas2770.c as a starting point.

> from 2-7 that gets switched around, I'd do something more like
> 
> #define SC16IS7XX_RANGE_BASE 0x1000
> #define SC16IS7XX_WINDOW_LEN 6
> #define SC16IS7XX_PAGED_REG(page, reg) \
> 	(SC16IS7XX_RANGE_BASE + (SC16IS7XX_WINDOW_LEN * page) + reg)
> 
> 	.range_min = SC16IS7XX_RANGE_BASE,
> 	.range_max = SC16IS7XX_RANGE_BASE + (2 * SC16IS7XX_WINDOW_LEN),
> 	.window_start = 2,
> 	.window_len = SC16IS7XX_WINDOW_LEN,
> 
> You could apply a - 2 offset to reg as well to make the defines for the
> registers clearer.  The above means that any untranslated register you
> see in I/O traces should be immediately obvious (and more likely to trip
> up error handling and tell you about it if it goes wrong) and hopefully
> also makes it easier to reason about what's going on.

Ok.

> > But here, selecting the proper "page" is not obvious,
> > because to select page 1, we need to write a fixed value of 0xBF to
> > the LCR register.
> 
> > And when selecting page 0, we must write the previous value that was
> > in LCR _before_ we made the switch to page 1...
> 
> > How do we do that?
> 
> That's one reason why having the range cover all the registers gets
> confusing.  That said the code does have special casing for a selector
> register in the middle of the range since there were some devices that
> just put the paging register in the middle of the range it controls for
> some innovative region, the core will notice that this is a selector
> register and not do any paging for that register.

You are talking about the selector being inside the range, and I
understand that because I have looked at _regmap_select_page()
comments and logic.

But that is not was my question was about. Here a pseudo code
example to select "page" 1:

1. save original value of LCR register.
2. write 0xBF to LCR register
3. access desired register in page 1
4. restore original LCR value saved in step 1

How do you do that with regmap range?

Hugo.
