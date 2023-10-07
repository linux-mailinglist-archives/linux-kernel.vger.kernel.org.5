Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF407BC773
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJGMUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjJGMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFFBC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C93C433C9;
        Sat,  7 Oct 2023 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696681204;
        bh=Fdn3tz63vLHyeTcy6EquZ9ay7sCNEZCgKYfZvFrfkeo=;
        h=From:To:Cc:Subject:Date:From;
        b=cAei7um3AcNp+LXdDJ7tePs+pbZGgVg8oH7caEgQnvCsOb+0ooxx4kLqHZQ3Qj6h3
         tBpTI1Dzj5JZxtKGMkBebC3891av8c0sZNgDJ73VMQ6iQpFKpiYwZCEDWaFDYEl5wM
         LDaHAe3qbGA/YU7bAt12I0boFWe7pm0fuxOhtYr2vTOEwqDBjaeQECM4nRQtRd+Hf2
         oRlEnVyekyk31E0Jk2BIC5XXl+wPjFri4JYMgxmIDeqtIUQlnSDqXskIrcCnRDgZZE
         oj1XgKUz9QuWbb0QJVdXu0bm1AQJ6l/Am5CPddi4wH6/QKSmvujJGEETCDxxfOWCzn
         QB9VdRYTyKuaw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qp6Hp-001yiy-9f;
        Sat, 07 Oct 2023 13:20:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dmitry Dunaev <dunaev@tecon.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Zenghui Yu <zenghui.yu@linux.dev>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 6.6, take  #2
Date:   Sat,  7 Oct 2023 13:19:33 +0100
Message-Id: <20231007121933.3840357-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, apatel@ventanamicro.com, ben.wolsieffer@hefring.com, conor.dooley@microchip.com, dunaev@tecon.ru, geert+renesas@glider.be, kieran.bingham+renesas@ideasonboard.com, prabhakar.mahadev-lad.rj@bp.renesas.com, lpieralisi@kernel.org, mark.rutland@arm.com, robh@kernel.org, robin.murphy@arm.com, yoshihiro.shimoda.uh@renesas.com, zenghui.yu@linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the second batch of irqchip fixes for 6.6.

On the menu this time are 3 interesting fixes: the RISC-V INTC marking
all of its nodes as initialised, allowing per-CPU device to correctly
probe, GICv3 needing some help to work with some integrations that
don't describe to SW how to deal with cacheable attributes, and STM32
not really knowing how to translate interrupts from DT. The rest is a
small set of DT binding updates.

Finally, something that is only important to me: I am removing myself
from the bulk of the IRQ subsystem maintenance. Not that I have done
much in terms of the core code in a while, and my reviewing bandwidth
is pretty much non-existent these days. I'll still keep maintaining
the ARM GICs though. Hopefully this will give me time for some actual
contributions instead of watching patches passing by.

I'd like to thank you for having trusted me with this code over the
years, as it has been quite an experience.

Please pull,

	M.

The following changes since commit 9b8df572ba3f4e544366196820a719a40774433e:

  irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source (2023-09-24 10:18:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.6-2

for you to fetch changes up to b673fe1a6229a49be5394f4e539055d9ce685615:

  MAINTAINERS: Remove myself from the general IRQ subsystem maintenance (2023-10-07 12:47:13 +0100)

----------------------------------------------------------------
irqchip fixes for 6.6, take #2

- DT binding updates for Renesas r8a779f0 and rzg2l

- Let GICv3 honor the "dma-non-coherent" attribute for systems that
  rely on SW guessing what the HW supports

- Fix the RISC-V INTC probing by marking all devices as initialised
  at once

- Properly translate interrupt numbers from DT on stm32-exti

- Use irq_data_get_irq_chip_data() in the rzg2l driver instead of
  blindly dereferencing the irq_data structure

- Add a MAINTAINERS entry for the various ARM GIC irqchip drivers

- Remove myself as the top-level irqchip/irqdomain maintainer

----------------------------------------------------------------
Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Geert Uytterhoeven (2):
      dt-bindings: interrupt-controller: renesas,irqc: Add r8a779f0 support
      irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC

Lorenzo Pieralisi (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property
      irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing

Marc Zyngier (3):
      irqchip/gic-v3-its: Split allocation from initialisation of its_node
      MAINTAINERS: Add myself as the ARM GIC maintainer
      MAINTAINERS: Remove myself from the general IRQ subsystem maintenance

 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  12 ++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../interrupt-controller/renesas,rzg2l-irqc.yaml   | 225 ++++++++++++++++-----
 MAINTAINERS                                        |  14 +-
 drivers/irqchip/irq-gic-common.h                   |   4 +
 drivers/irqchip/irq-gic-v3-its.c                   | 170 ++++++++++------
 drivers/irqchip/irq-gic-v3.c                       |  13 ++
 drivers/irqchip/irq-renesas-rzg2l.c                |   2 +-
 drivers/irqchip/irq-riscv-intc.c                   |  10 +-
 drivers/irqchip/irq-stm32-exti.c                   |   1 +
 10 files changed, 329 insertions(+), 123 deletions(-)
