Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D73797D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjIGUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:46:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A11990;
        Thu,  7 Sep 2023 13:46:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49D621BF206;
        Thu,  7 Sep 2023 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694119606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fsrneogx9cLLBU5XROqIMVQkJeeWHh1Bnc6l8AutE/o=;
        b=SCbSoKK9zHvP6xeuswxo9ClIj3BmrOHaSB0x/2MbkQIW41V9ODS8coUFyP4ZBv1sthyMhA
        eSIWuo4Ul0NwAcEbBcowuMEwyuc07F5dy+jaGKrjnCtOMsQQEfRShU7u9hPUZXeAICED76
        1rcERzCFAIbEGGHHckvB+HW5az5AtSaExQa2k7U9BWTa+LfmWFK1bLfmeVGB/NS9KssEab
        bsEMy3ahzCyeYcvM275SFVFBLAOVk5AT+rN+jJKxdgLAFHiqsMYJl7Cv9jghM8n5PdY/aP
        Kq8ADpMsBqWjj45DQ73qQ+H8/+c5vsFJdGraZZ2Y+w/NuK/cklHqLBviLRtxxw==
Date:   Thu, 7 Sep 2023 22:46:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.6
Message-ID: <20230907204645b1480693@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.6. The pcf2127 driver was
reworked heavily to add support for the pcf2131. This also introduces a
way for drivers to report the alarm range which is going to be used to
fix a related alarmtimer issue in the next release.

I extended the expiration date of my signing subkey so you will have to
update my key to be able to verify the tag signature.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.6

for you to fetch changes up to ce413486c9a0d735d86cc7d88660abeac99c2501:

  dt-bindings: rtc: ds3231: Remove text binding (2023-09-06 01:28:24 +0200)

----------------------------------------------------------------
RTC for 6.6

Subsystem:
 - Add a way for drivers to tell the core the supported alarm range is smaller
   than the date range. This is not used yet but will be useful for the
   alarmtimers in the next release.
 - fix Wvoid-pointer-to-enum-cast warnings
 - remove redundant of_match_ptr()
 - stop warning for invalid alarms when the alarm is disabled

Drivers:
 - isl12022: allow setting the trip level for battery level detection
 - pcf2127: add support for PCF2131 and multiple timestamps
 - stm32: time precision improvement, many fixes
 - twl: NVRAM support

----------------------------------------------------------------
Alexandre Belloni (5):
      rtc: pcf2127: remove useless check
      rtc: stop warning for invalid alarms when the alarm is disabled
      rtc: sun6i: remove unnecessary message
      rtc: twl: remove unnecessary messages
      rtc: wm8350: remove unnecessary messages

Andrej Picej (1):
      rtc: rv3028: Add support for "aux-voltage-chargeable" property

Antonio Borneo (2):
      rtc: stm32: use the proper register sequence to read date/time
      rtc: stm32: don't stop time counter if not needed

Arnd Bergmann (2):
      rtc: bq4802: add sparc dependency
      rtc: stm32: remove incorrect #ifdef check

Biju Das (4):
      rtc: isl1208: Simplify probe()
      rtc: pcf85063: Simplify probe()
      rtc: pcf85063: Drop enum pcf85063_type and split pcf85063_cfg[]
      rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()

Chen Jiahao (1):
      rtc: sunplus: Clean up redundant dev_err_probe()

Christophe Guibout (1):
      rtc: stm32: improve rtc precision

Dan Carpenter (1):
      rtc: pcf2127: fix error code in pcf2127_enable_ts()

Fabio Estevam (1):
      dt-bindings: rtc: ds3231: Remove text binding

Gabriel Fernandez (1):
      rtc: stm32: change PM callbacks to "_noirq()"

Guenter Roeck (6):
      rtc: Add support for limited alarm timer offsets
      rtc: cros-ec: Detect and report supported alarm window size
      rtc: cmos: Report supported alarm limit to rtc infrastructure
      rtc: tps6586x: Report maximum alarm limit to rtc core
      rtc: ds1305: Report maximum alarm limit to rtc core
      rtc: rzn1: Report maximum alarm limit to rtc core

Hugo Villeneuve (19):
      rtc: pcf2127: improve rtc_read_time() performance
      rtc: pcf2127: improve timestamp reading performance
      rtc: pcf2127: lower message severity if setting time fails
      rtc: pcf2127: remove superfluous comments
      rtc: pcf2127: add variant-specific configuration structure
      rtc: pcf2127: adapt for time/date registers at any offset
      rtc: pcf2127: adapt for alarm registers at any offset
      rtc: pcf2127: adapt for WD registers at any offset
      rtc: pcf2127: adapt for CLKOUT register at any offset
      rtc: pcf2127: add support for multiple TS functions
      rtc: pcf2127: add support for PCF2131 RTC
      rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
      rtc: pcf2127: adapt time/date registers write sequence for PCF2131
      rtc: pcf2127: support generic watchdog timing configuration
      rtc: pcf2127: add flag for watchdog register value read support
      rtc: pcf2127: add UIE support for PCF2131
      dt-bindings: rtc: pcf2127: add PCF2131
      rtc: pcf2127: add error checking when disabling POR0
      rtc: pcf2127: remove unused function argument

Krzysztof Kozlowski (4):
      rtc: ds1307: fix Wvoid-pointer-to-enum-cast warning
      rtc: rv8803: fix Wvoid-pointer-to-enum-cast warning
      rtc: jz4740: fix Wvoid-pointer-to-enum-cast warning
      rtc: rs5c372: fix Wvoid-pointer-to-enum-cast warning

Ladislav Michl (1):
      rtc: twl: add NVRAM support

Linus Walleij (1):
      rtc: ds2404: Convert to GPIO descriptors

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM section

Mike Looijmans (1):
      rtc: pcf85363: Allow to wake up system without IRQ

Nathan Chancellor (1):
      rtc: stm32: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()

Nikita Shubin (2):
      dt-bindings: rtc: Add ST M48T86
      rtc: m48t86: add DT support for m48t86

Rasmus Villemoes (8):
      rtc: isl12022: remove wrong warning for low battery level
      dt-bindings: rtc: Move isil,isl12022 from trivial-rtc.yaml into own schema file
      dt-bindings: rtc: isl12022: add bindings for battery alarm trip levels
      rtc: isl12022: add support for trip level DT binding
      rtc: isl12022: implement RTC_VL_READ ioctl
      rtc: isl12022: trigger battery level detection during probe
      dt-bindings: rtc: isl12022: add #clock-cells property
      rtc: isl12022: implement support for the #clock-cells DT property

Rob Herring (1):
      rtc: Explicitly include correct DT includes

Ruan Jinjie (2):
      rtc: omap: Do not check for 0 return after calling platform_get_irq()
      rtc: tps65910: Remove redundant dev_warn() and do not check for 0 return after calling platform_get_irq()

Samuel Holland (1):
      rtc: da9063: Mark the alarm IRQ as a wake IRQ

Uwe Kleine-König (1):
      rtc: isl12026: Drop "_new" from probe callback name

Valentin Caron (3):
      rtc: stm32: don't print an error on probe deferral
      rtc: stm32: fix issues of stm32_rtc_valid_alrm function
      rtc: stm32: fix unnecessary parentheses

Varshini Rajendran (1):
      dt-bindings: rtc: at91rm9200: add sam9x7 compatible

Zhu Wang (1):
      rtc: remove redundant of_match_ptr()

 .../bindings/rtc/atmel,at91rm9200-rtc.yaml         |  18 +-
 .../devicetree/bindings/rtc/intersil,isl12022.yaml |  64 ++
 .../devicetree/bindings/rtc/maxim,ds3231.txt       |  38 -
 .../devicetree/bindings/rtc/nxp,pcf2127.yaml       |   1 +
 .../devicetree/bindings/rtc/st,m48t86.yaml         |  38 +
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 -
 MAINTAINERS                                        |   1 -
 drivers/rtc/Kconfig                                |   5 +-
 drivers/rtc/interface.c                            |   2 +-
 drivers/rtc/rtc-abx80x.c                           |   2 +-
 drivers/rtc/rtc-armada38x.c                        |   5 +-
 drivers/rtc/rtc-aspeed.c                           |   2 +-
 drivers/rtc/rtc-at91rm9200.c                       |   3 +-
 drivers/rtc/rtc-at91sam9.c                         |   2 +-
 drivers/rtc/rtc-cmos.c                             |  11 +
 drivers/rtc/rtc-cros-ec.c                          |  38 +-
 drivers/rtc/rtc-da9063.c                           |   7 +
 drivers/rtc/rtc-ds1305.c                           |   5 +-
 drivers/rtc/rtc-ds1307.c                           |   2 +-
 drivers/rtc/rtc-ds1742.c                           |   1 -
 drivers/rtc/rtc-ds2404.c                           | 169 ++--
 drivers/rtc/rtc-fsl-ftm-alarm.c                    |   5 +-
 drivers/rtc/rtc-isl12022.c                         | 126 ++-
 drivers/rtc/rtc-isl12026.c                         |   5 +-
 drivers/rtc/rtc-isl1208.c                          |  19 +-
 drivers/rtc/rtc-jz4740.c                           |   4 +-
 drivers/rtc/rtc-lpc24xx.c                          |   3 +-
 drivers/rtc/rtc-m41t80.c                           |   2 +-
 drivers/rtc/rtc-m48t86.c                           |   8 +
 drivers/rtc/rtc-mpc5121.c                          |   4 +-
 drivers/rtc/rtc-mt6397.c                           |   2 +-
 drivers/rtc/rtc-mt7622.c                           |   4 +-
 drivers/rtc/rtc-mxc.c                              |   1 -
 drivers/rtc/rtc-nct3018y.c                         |   2 +-
 drivers/rtc/rtc-omap.c                             |   8 +-
 drivers/rtc/rtc-pcf2127.c                          | 872 ++++++++++++++++-----
 drivers/rtc/rtc-pcf85063.c                         | 107 ++-
 drivers/rtc/rtc-pcf85363.c                         |  31 +-
 drivers/rtc/rtc-pxa.c                              |   1 -
 drivers/rtc/rtc-rs5c372.c                          |   5 +-
 drivers/rtc/rtc-rv3028.c                           |  82 +-
 drivers/rtc/rtc-rv3032.c                           |   2 +-
 drivers/rtc/rtc-rv8803.c                           |   5 +-
 drivers/rtc/rtc-rx6110.c                           |   1 -
 drivers/rtc/rtc-rx8581.c                           |   1 -
 drivers/rtc/rtc-rzn1.c                             |   5 +-
 drivers/rtc/rtc-s3c.c                              |   1 -
 drivers/rtc/rtc-stm32.c                            | 143 ++--
 drivers/rtc/rtc-stmp3xxx.c                         |   1 -
 drivers/rtc/rtc-sun6i.c                            |   3 -
 drivers/rtc/rtc-sunplus.c                          |   2 +-
 drivers/rtc/rtc-sunxi.c                            |   2 -
 drivers/rtc/rtc-ti-k3.c                            |   2 +-
 drivers/rtc/rtc-tps6586x.c                         |   1 +
 drivers/rtc/rtc-tps65910.c                         |   7 +-
 drivers/rtc/rtc-twl.c                              |  43 +-
 drivers/rtc/rtc-wm8350.c                           |   9 +-
 include/linux/platform_data/rtc-ds2404.h           |  20 -
 include/linux/rtc.h                                |   1 +
 59 files changed, 1337 insertions(+), 619 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/st,m48t86.yaml
 delete mode 100644 include/linux/platform_data/rtc-ds2404.h

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
