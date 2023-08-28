Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87B78A89F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjH1JQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjH1JPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1283103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FD616136E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93CBC433C7;
        Mon, 28 Aug 2023 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693214149;
        bh=nS1Mcz8KKIrm9eyrKAODKV11Trvz24XeL+B52mUe620=;
        h=From:To:Cc:Subject:Date:From;
        b=szrXOR/vQd7OgJ39tsQtyzNmzSBO45dfKEMHKGeUHvbv2CAFNpU3ywlAoPJ4zTPGR
         JaG6EZ8jbR862zwlv6Sj900Af4PUj3qCUR4T4OV5j/79Ek7QIOQ8u8lEFzcpV4+2Qr
         ZQjLUk9oqbqLW/AEnzuaUXUa54ePBvlR/LK+5NjHPOWCHGVwnmsN+vyXkEiOWqXxV4
         vWkNx0fe/+TH+O3H+MKvJBpXLb2bgoKIFjfDrjN+Yc8gH0ZcCpuUY9NltnQ/B5+e73
         IyApAvnTUXZNUxSGB2svz/R5CTZiFYKYiXef+/9wVSyWKhFb5JqBfn2+1uien1nmHJ
         /Z9kgWyLwnU0w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qaYLb-008fpo-3F;
        Mon, 28 Aug 2023 10:15:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bibo Mao <maobibo@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yangtao Li <frank.li@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux v6.6
Date:   Mon, 28 Aug 2023 10:15:43 +0100
Message-Id: <20230828091543.4001857-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, andrew@lunn.ch, arnd@arndb.de, maobibo@loongson.cn, conor.dooley@microchip.com, huqiang.qin@amlogic.com, martin.blumenstingl@googlemail.com, jcmvbkbc@gmail.com, philmd@linaro.org, robh@kernel.org, ruanjinjie@huawei.com, fancer.lancer@gmail.com, frank.li@vivo.com, yangyingliang@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a tiny set of very minor irqchip updates for v6.6. Hardly
anything has a functional impact, and it is mostly a set of cleanups.
I guess that most people were on holiday, and I'm not going to
complain about the lack of activity on that front.

Please pull,

	M.

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-6.6

for you to fetch changes up to 19b5a44bee16518104e8a159ab9a60788292fbd4:

  irqchip: Add support for Amlogic-C3 SoCs (2023-08-21 17:49:12 +0100)

----------------------------------------------------------------
irqchip updates for v6.6

- Fix for Loongsoon eiointc init error handling

- Fix a bunch of warning showing up when -Wmissing-prototypes is set

- A set of fixes for drivers checking for 0 as a potential return
  value from platform_get_irq()

- Another set of patches converting existing code to the use of helpers
  such as of_address_count() and devm_platform_get_and_ioremap_resource()

- A tree-wide cleanup of drivers including of_*.h without discrimination

- Added support for the Amlogic C3 SoCs

----------------------------------------------------------------
Arnd Bergmann (3):
      irqchip/xtensa-pic: Include header for xtensa_pic_init_legacy()
      irqchip/mips-gic: Mark gic_irq_domain_free() static
      irqchipr/i8259: Mark i8259_of_init() static

Bibo Mao (1):
      irqchip/loongson-eiointc: Fix return value checking of eiointc_index

Huqiang Qin (2):
      dt-bindings: interrupt-controller: Add support for Amlogic-C3 SoCs
      irqchip: Add support for Amlogic-C3 SoCs

Rob Herring (1):
      irqchip: Explicitly include correct DT includes

Ruan Jinjie (2):
      irqchip/imx-mu-msi: Do not check for 0 return after calling platform_get_irq()
      irqchip/irq-pruss-intc: Do not check for 0 return after calling platform_get_irq()

Yang Yingliang (1):
      irqchip/orion: Use of_address_count() helper

Yangtao Li (2):
      irqchip/ls-scfg-msi: Use devm_platform_get_and_ioremap_resource()
      irqchip/irq-mvebu-sei: Use devm_platform_get_and_ioremap_resource()

 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml      | 1 +
 drivers/irqchip/irq-bcm6345-l1.c                                    | 1 -
 drivers/irqchip/irq-bcm7038-l1.c                                    | 1 -
 drivers/irqchip/irq-brcmstb-l2.c                                    | 1 -
 drivers/irqchip/irq-gic-pm.c                                        | 2 +-
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c                         | 2 --
 drivers/irqchip/irq-i8259.c                                         | 2 +-
 drivers/irqchip/irq-imx-intmux.c                                    | 3 ++-
 drivers/irqchip/irq-imx-irqsteer.c                                  | 3 ++-
 drivers/irqchip/irq-imx-mu-msi.c                                    | 4 ++--
 drivers/irqchip/irq-keystone.c                                      | 2 +-
 drivers/irqchip/irq-loongson-eiointc.c                              | 2 +-
 drivers/irqchip/irq-loongson-htvec.c                                | 1 -
 drivers/irqchip/irq-loongson-pch-pic.c                              | 2 +-
 drivers/irqchip/irq-ls-scfg-msi.c                                   | 3 +--
 drivers/irqchip/irq-madera.c                                        | 4 +---
 drivers/irqchip/irq-meson-gpio.c                                    | 5 +++++
 drivers/irqchip/irq-mips-gic.c                                      | 2 +-
 drivers/irqchip/irq-mvebu-sei.c                                     | 3 +--
 drivers/irqchip/irq-orion.c                                         | 3 +--
 drivers/irqchip/irq-pruss-intc.c                                    | 6 +++---
 drivers/irqchip/irq-qcom-mpm.c                                      | 2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c                           | 1 -
 drivers/irqchip/irq-st.c                                            | 2 +-
 drivers/irqchip/irq-stm32-exti.c                                    | 3 ++-
 drivers/irqchip/irq-sunxi-nmi.c                                     | 1 -
 drivers/irqchip/irq-tb10x.c                                         | 1 -
 drivers/irqchip/irq-ti-sci-inta.c                                   | 4 ++--
 drivers/irqchip/irq-ti-sci-intr.c                                   | 4 ++--
 drivers/irqchip/irq-uniphier-aidet.c                                | 1 -
 drivers/irqchip/irq-xtensa-pic.c                                    | 1 +
 drivers/irqchip/irqchip.c                                           | 2 +-
 drivers/irqchip/qcom-pdc.c                                          | 1 -
 33 files changed, 35 insertions(+), 41 deletions(-)
