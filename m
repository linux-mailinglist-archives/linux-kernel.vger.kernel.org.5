Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47C7A8D86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjITUK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjITUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:10:53 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B13CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=kBFMB175NoIB33
        tUumJsDoFOA+ejFSobf6NIE+jj4Ug=; b=Uc733YxYosbjm/XEn89UsBRFOBGt1D
        wtaJ/BXK403VVpQDNaEHxKrKojSA4FFSKMYLOgDdfhsKJ/fLaQUl6oYWSgL0kjxP
        TjgQp1ebp9cnXOFYCGu92pW1/uFVDDjD92SyXcYt7CH+IEiDDo7JY7lZPY/W5kgV
        K/WjWWafTRpNlvZysZM+Ey7us60jP/Qx1+1CLzQ0qWGr9L0UlEDWpY6jXTg0e4E2
        VK6WuEnnj4ecYOJ8G5U+ks86MJOx3wyAEDrOt9aNEZJz7/pTzLfI81YT2opm3aha
        Sn+CPpC43sMqQqmLNTySIY29gMgvxKQJW48ogG6E3SOz+QL/P6C2joyw==
Received: (qmail 720124 invoked from network); 20 Sep 2023 22:10:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:40 +0200
X-UD-Smtp-Session: l3s3148p1@Nuf9988FxNgujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/6] remove AR7 platform and associated drivers
Date:   Wed, 20 Sep 2023 22:10:26 +0200
Message-Id: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to get rid of the obsolete VLYNQ bus, Jonas and Florian
pointed out that its only user, the AR7 platform can probaly go entirely
[1]. This series does exactly that. Even OpenWRT has removed support
because these devices are "stuck with 3.18" [2].

It removes the drivers first, because watchdog and network include
platform specific headers. Once the drivers are gone, we remove the
platform. The patches are based on 6.6-rc2 and created with
"--irreversible-delete" to save some space.

My suggestion is that everything is merged via the MIPS tree in one go,
so we don't have broken drivers because of missing platform headers. But
maybe there are reasons for a two-cycle removal with the drivers first
and the platform later?

Looking forward to comments.

Happy hacking,

   Wolfram


[1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.com
[2] https://openwrt.org/docs/techref/targets/ar7


Wolfram Sang (6):
  serial: 8250: remove AR7 support
  mtd: parsers: ar7: remove support
  vlynq: remove bus driver
  watchdog: ar7_wdt: remove driver to prepare for platform removal
  net: cpmac: remove driver to prepare for platform removal
  MIPS: AR7: remove platform

 MAINTAINERS                             |   13 -
 arch/arm/configs/pxa_defconfig          |    1 -
 arch/mips/Kbuild.platforms              |    1 -
 arch/mips/Kconfig                       |   22 -
 arch/mips/ar7/Makefile                  |   11 -
 arch/mips/ar7/Platform                  |    5 -
 arch/mips/ar7/clock.c                   |  439 --------
 arch/mips/ar7/gpio.c                    |  332 ------
 arch/mips/ar7/irq.c                     |  165 ---
 arch/mips/ar7/memory.c                  |   51 -
 arch/mips/ar7/platform.c                |  722 -------------
 arch/mips/ar7/prom.c                    |  256 -----
 arch/mips/ar7/setup.c                   |   93 --
 arch/mips/ar7/time.c                    |   31 -
 arch/mips/boot/compressed/uart-16550.c  |    5 -
 arch/mips/configs/ar7_defconfig         |  119 ---
 arch/mips/include/asm/mach-ar7/ar7.h    |  191 ----
 arch/mips/include/asm/mach-ar7/irq.h    |   16 -
 arch/mips/include/asm/mach-ar7/prom.h   |   12 -
 arch/mips/include/asm/mach-ar7/spaces.h |   22 -
 drivers/Kconfig                         |    2 -
 drivers/Makefile                        |    1 -
 drivers/mtd/parsers/Kconfig             |    5 -
 drivers/mtd/parsers/Makefile            |    1 -
 drivers/mtd/parsers/ar7part.c           |  129 ---
 drivers/net/ethernet/ti/Kconfig         |    9 +-
 drivers/net/ethernet/ti/Makefile        |    1 -
 drivers/net/ethernet/ti/cpmac.c         | 1251 -----------------------
 drivers/tty/serial/8250/8250_port.c     |    7 -
 drivers/vlynq/Kconfig                   |   21 -
 drivers/vlynq/Makefile                  |    6 -
 drivers/vlynq/vlynq.c                   |  799 ---------------
 drivers/watchdog/Kconfig                |    6 -
 drivers/watchdog/Makefile               |    1 -
 drivers/watchdog/ar7_wdt.c              |  315 ------
 include/linux/vlynq.h                   |  149 ---
 include/uapi/linux/serial_core.h        |    1 -
 37 files changed, 1 insertion(+), 5210 deletions(-)
 delete mode 100644 arch/mips/ar7/Makefile
 delete mode 100644 arch/mips/ar7/Platform
 delete mode 100644 arch/mips/ar7/clock.c
 delete mode 100644 arch/mips/ar7/gpio.c
 delete mode 100644 arch/mips/ar7/irq.c
 delete mode 100644 arch/mips/ar7/memory.c
 delete mode 100644 arch/mips/ar7/platform.c
 delete mode 100644 arch/mips/ar7/prom.c
 delete mode 100644 arch/mips/ar7/setup.c
 delete mode 100644 arch/mips/ar7/time.c
 delete mode 100644 arch/mips/configs/ar7_defconfig
 delete mode 100644 arch/mips/include/asm/mach-ar7/ar7.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/irq.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/spaces.h
 delete mode 100644 drivers/mtd/parsers/ar7part.c
 delete mode 100644 drivers/net/ethernet/ti/cpmac.c
 delete mode 100644 drivers/vlynq/Kconfig
 delete mode 100644 drivers/vlynq/Makefile
 delete mode 100644 drivers/vlynq/vlynq.c
 delete mode 100644 drivers/watchdog/ar7_wdt.c
 delete mode 100644 include/linux/vlynq.h

-- 
2.35.1

