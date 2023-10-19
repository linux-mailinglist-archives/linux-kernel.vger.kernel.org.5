Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E77CF344
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjJSIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJSIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:52:27 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FDEEAB;
        Thu, 19 Oct 2023 01:52:22 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qtOlP-0004JJ-00; Thu, 19 Oct 2023 10:52:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 81227C0198; Thu, 19 Oct 2023 10:50:05 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:50:05 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/6] remove AR7 platform and associated drivers
Message-ID: <ZTDtvR732kzchtxF@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:15:21AM +0200, Wolfram Sang wrote:
> Changes since v1:
> * kept uapi define for for serial port type
> * added acks
> 
> Still valid cover letter from v1:
> 
> When trying to get rid of the obsolete VLYNQ bus, Jonas and Florian
> pointed out that its only user, the AR7 platform can probaly go entirely
> [1]. This series does exactly that. Even OpenWRT has removed support
> because these devices are "stuck with 3.18" [2].
> 
> It removes the drivers first, because watchdog and network include
> platform specific headers. Once the drivers are gone, we remove the
> platform. The patches are based on 6.6-rc2 and created with
> "--irreversible-delete" to save some space.
> 
> My suggestion is that everything is merged via the MIPS tree in one go,
> so we don't have broken drivers because of missing platform headers. But
> maybe there are reasons for a two-cycle removal with the drivers first
> and the platform later?
> 
> Looking forward to comments.
> 
> Happy hacking,
> 
>    Wolfram
> 
> 
> [1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.com
> [2] https://openwrt.org/docs/techref/targets/ar7
> 
> 
> Wolfram Sang (6):
>   serial: 8250: remove AR7 support
>   mtd: parsers: ar7: remove support
>   vlynq: remove bus driver
>   watchdog: ar7_wdt: remove driver to prepare for platform removal
>   net: cpmac: remove driver to prepare for platform removal
>   MIPS: AR7: remove platform
> 
>  MAINTAINERS                             |   13 -
>  arch/arm/configs/pxa_defconfig          |    1 -
>  arch/mips/Kbuild.platforms              |    1 -
>  arch/mips/Kconfig                       |   22 -
>  arch/mips/ar7/Makefile                  |   11 -
>  arch/mips/ar7/Platform                  |    5 -
>  arch/mips/ar7/clock.c                   |  439 --------
>  arch/mips/ar7/gpio.c                    |  332 ------
>  arch/mips/ar7/irq.c                     |  165 ---
>  arch/mips/ar7/memory.c                  |   51 -
>  arch/mips/ar7/platform.c                |  722 -------------
>  arch/mips/ar7/prom.c                    |  256 -----
>  arch/mips/ar7/setup.c                   |   93 --
>  arch/mips/ar7/time.c                    |   31 -
>  arch/mips/boot/compressed/uart-16550.c  |    5 -
>  arch/mips/configs/ar7_defconfig         |  119 ---
>  arch/mips/include/asm/mach-ar7/ar7.h    |  191 ----
>  arch/mips/include/asm/mach-ar7/irq.h    |   16 -
>  arch/mips/include/asm/mach-ar7/prom.h   |   12 -
>  arch/mips/include/asm/mach-ar7/spaces.h |   22 -
>  drivers/Kconfig                         |    2 -
>  drivers/Makefile                        |    1 -
>  drivers/mtd/parsers/Kconfig             |    5 -
>  drivers/mtd/parsers/Makefile            |    1 -
>  drivers/mtd/parsers/ar7part.c           |  129 ---
>  drivers/net/ethernet/ti/Kconfig         |    9 +-
>  drivers/net/ethernet/ti/Makefile        |    1 -
>  drivers/net/ethernet/ti/cpmac.c         | 1251 -----------------------
>  drivers/tty/serial/8250/8250_port.c     |    7 -
>  drivers/vlynq/Kconfig                   |   21 -
>  drivers/vlynq/Makefile                  |    6 -
>  drivers/vlynq/vlynq.c                   |  799 ---------------
>  drivers/watchdog/Kconfig                |    6 -
>  drivers/watchdog/Makefile               |    1 -
>  drivers/watchdog/ar7_wdt.c              |  315 ------
>  include/linux/vlynq.h                   |  149 ---
>  36 files changed, 1 insertion(+), 5209 deletions(-)
>  delete mode 100644 arch/mips/ar7/Makefile
>  delete mode 100644 arch/mips/ar7/Platform
>  delete mode 100644 arch/mips/ar7/clock.c
>  delete mode 100644 arch/mips/ar7/gpio.c
>  delete mode 100644 arch/mips/ar7/irq.c
>  delete mode 100644 arch/mips/ar7/memory.c
>  delete mode 100644 arch/mips/ar7/platform.c
>  delete mode 100644 arch/mips/ar7/prom.c
>  delete mode 100644 arch/mips/ar7/setup.c
>  delete mode 100644 arch/mips/ar7/time.c
>  delete mode 100644 arch/mips/configs/ar7_defconfig
>  delete mode 100644 arch/mips/include/asm/mach-ar7/ar7.h
>  delete mode 100644 arch/mips/include/asm/mach-ar7/irq.h
>  delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h
>  delete mode 100644 arch/mips/include/asm/mach-ar7/spaces.h
>  delete mode 100644 drivers/mtd/parsers/ar7part.c
>  delete mode 100644 drivers/net/ethernet/ti/cpmac.c
>  delete mode 100644 drivers/vlynq/Kconfig
>  delete mode 100644 drivers/vlynq/Makefile
>  delete mode 100644 drivers/vlynq/vlynq.c
>  delete mode 100644 drivers/watchdog/ar7_wdt.c
>  delete mode 100644 include/linux/vlynq.h

applied to mips-next, minus patch 5, which is already applied to net-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
