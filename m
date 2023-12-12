Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D880F766
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376793AbjLLUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:03:11 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B38E;
        Tue, 12 Dec 2023 12:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=GU5bD/tkNbwYE01vFKqUORHlQtxGJUzogaJ4KX5B+SE=; b=VAN/d/JUx6n8DA7SJeL3AgkgOn
        cSxx9y9yZlUFXcC3B6FH4I8KAzxipMdU68Cr7JHARKBZAHpbhqHo8DjQXD1j5HUtWNXuRw8H/xlkF
        j/y+wCxPoLkCNdG5pVGkTNV9YrfvE6ybnNiQGaz2Esrt+XgRIquyvu58/84CEV14giuU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50180 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rD8y6-0003S3-F0; Tue, 12 Dec 2023 15:03:03 -0500
Date:   Tue, 12 Dec 2023 15:03:02 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, hvilleneuve@dimonoff.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org
Message-Id: <20231212150302.a9ec5d085a4ba65e89ca41af@hugovil.com>
In-Reply-To: <CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
References: <20231130191050.3165862-2-hugo@hugovil.com>
        <202312061443.Cknef7Uq-lkp@intel.com>
        <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
        <CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 20:24:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 7, 2023 at 7:52 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Wed, 6 Dec 2023 14:29:39 +0800
> > kernel test robot <lkp@intel.com> wrote:
> 
> ...
> 
> > >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
> > > >> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |                                         ^~
> > >    In function 'sc16is7xx_regmap_name',
> > >        inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7xx.c:1805:17:
> > >    drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in the range [0, 4294967294]
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |                                    ^~~~~~~~
> > >    drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Hi,
> > the only solution I could find is to add this line just before snprintf:
> >
> >     BUG_ON(port_id > MAX310X_MAX_PORTS);
> >
> > it allows us to have the smallest buffer size possible.
> >
> > One other solution would be to change port_id from "unsigned int"
> > to "u8", and increase the buffer by an additional 2 bytes to silence
> > the warning, but then wasting 2 bytes for each channel, like so:
> 
> I didn't get this. It's a buffer that is rewritten on each port (why
> is it even static?). Just make sure it's enough for any given number
> and drop the static.
> 
> ...
> 
> While at it, can you look at the following items to improve?
> - sc16is7xx_alloc_line() can be updated to use IDA framework
> - move return xxx; to the default cases in a few functions
> - if (div > 0xffff) { --> if (div >= BIT(16)) { as it better shows why
> the limit is that (we have only 16 bits for the divider)
> - do {} while (0) in the sc16is7xx_port_irq, WTH?!
> - while (1) { -- do { } while (keep_polling); in sc16is7xx_irq()
> - use in_range() in sc16is7xx_setup_mctrl_ports() ? (maybe not, dunno)
> - for (i--; i >= 0; i--) { --> while (i--) {
> - use spi_get_device_match_data() and i2c_get_match_data()
> - 15000000 --> 15 * HZ_PER_MHZ ?
> - dropping MODULE_ALIAS (and fix the ID tables, _if_ needed)
> - split the code to the core / main + SPI + I2C glue drivers
> 
> * These just come on the first glance at the code, perhaps there is
> more room to improve.

Hi Andy,
just to let you know that I have implemented almost all of the fixes /
improvements. I will submit them once V2 of this current series
lands in Greg's next tree.

However, for sc16is7xx_alloc_line(), I looked at using the IDA framework
but it doesn't seem possible because there is no IDA function
to search if a bit is set, which is a needed functionality.

Hugo Villeneuve
