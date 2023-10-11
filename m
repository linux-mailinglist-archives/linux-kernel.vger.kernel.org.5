Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE77C50F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbjJKLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjJKLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:05:26 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC189D;
        Wed, 11 Oct 2023 04:05:23 -0700 (PDT)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by ex01.ufhost.com (Postfix) with ESMTP id E9ADA24E2BC;
        Wed, 11 Oct 2023 19:05:16 +0800 (CST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A98CC24DEED;
        Wed, 11 Oct 2023 19:05:16 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:16 +0800
Received: from ubuntu.localdomain (183.27.96.95) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Oct
 2023 19:05:15 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v8 0/22] Refactoring Microchip PCIe driver and add StarFive PCIe
Date:   Wed, 11 Oct 2023 19:04:52 +0800
Message-ID: <20231011110514.107528-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.95]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
same IP and have commit their codes, which are mixed with PLDA
controller codes and Microchip platform codes.

For re-use the PLDA controller codes, I request refactoring microchip
codes, move PLDA common codes to PLDA files.
Desigware and Cadence is good example for refactoring codes.

----------------------------------------------------------
The refactoring patches total number is 17,(patch 1-17)
which do NOT contain changing logic of codes.

These patches just contain three type basic operations.
(rename, modify codes to support starfive platform, and moving to common file)
If these patched are all be reviewed. They can be accepted first.

Refactoring patches can be devided to different groups
1. (patch 1- 3 is the prepare work of refactoring)
patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
       docs from microchip,pcie-host.yaml
patch2 is move PolarFire codes to PLDA directory.
patch3 is move PLDA IP register macros to plda-pcie.h

2. (patch4 - 6 is processing and re-use PCIe host instance)
patch4 is add bridge_addr field to PCIe host instance.
patch5 is rename data structure in microchip codes.
patch6 is moving two data structures to head file

3. (patch 7 - 9 are for re-use two PCIe setup function)
patch7 is rename two setup functions in microchip codes, prepare to move
to common file.
patch8 is change the arguments of plda_pcie_setup_iomems()
patch9 is move the two setup functions to common file pcie-plda-host.c

4.(patch 10 - 17 are for re-use interupt processing codes)
patch10 add a plda default event handler function.
patch11 is rename the IRQ related functions, prepare to move to
pcie-plda-host.c
patch 12 - 16 is modify the interrupt event codes, preparing for support starfive
and microchip two platforms.
patch17 is move IRQ related functions to pcie-plda-host.c

------------------------------------------------------------
The remainder patches (patch 18 -22) are not refactoring patch.
They are for adding StarFive codes and dont modify the microchip's
codes.

patch18 is set plda_event_handler to static.
patch19 is Add PLDA event interrupt codes and IRQ domain ops.
patch20 is add StarFive JH7110 PCIe dt-binding doc.
patch21 is add StarFive JH7110 Soc PCIe codes.
patch22 is Starfive dts config

This patchset is base on v6.6-rc5

previous version:
v3:https://patchwork.kernel.org/project/linux-pci/cover/20230814082016.104181-1-minda.chen@starfivetech.com/
v4:https://patchwork.kernel.org/project/linux-pci/cover/20230825090129.65721-1-minda.chen@starfivetech.com/
v5:https://patchwork.kernel.org/project/linux-pci/cover/20230907091058.125630-1-minda.chen@starfivetech.com/
v6:https://patchwork.kernel.org/project/linux-pci/cover/20230915102243.59775-1-minda.chen@starfivetech.com/
v7:https://patchwork.kernel.org/project/linux-pci/cover/20230927100802.46620-1-minda.chen@starfivetech.com/

change:
  v8:
    The patch description in cover-letter has been changed.

    v7 patch 4 split to v8 patch 4 - 6.
        (It is patches about re-use pcie host data structure, new patches just contain one
	function modification. It is more reguluar and easier to review).

    patch 7- 9: modify the commit messages and add reason of
		modifcation.
    patch10 : just new add a default event handler.
              The PLDA event interrupt codes has been moved to patch19.
    patch11- 17 :
             Add review tag and add more commit messages to declear the
	     reason of modifying the codes.
    patch19: plda_handle_events() using bit mask macro. The function are
	     easier to read.

  v7:
    patch19: fix the build warning.
    patch21: Some format changes (Emil's comment)
    patch22: change the pcie node sequences by alphabetical
             delete the "interupt-parent" in pcie node.

  v6:
    v5 patch 4 split to patch 4 -9. New patches just contain one
function modification. It is more reguluar.
    patch 9: Just move the two setup functions only
    patch 19 : draw a graph of PLDA local register, make it easier to
review the codes.
    v5 patch 7 split to patch 11- 17. Each patch just contain one
function modification. It is more regular.
    patch 11: rename IRQ related functions.
    patch 12 - 16 : modify the events codes, total five patch.
    patch 17: move IRQ related functions to pcie-plda-host.c
    patch 18: Add new patch 18.
    patch 21- 22 using "linux,pci-domain" dts setting.

  v5:
    patch 10 -17:
    	- Some variables names changed (evt->event).
    	- plda_handle_event() using a unify callback function to get events
num.
	- Add plda_event_ops data structure.
    patch 21:
	Add plda_event_ops instances.

  v4:
    patch 3:
    	Copy the interrupt events macros to pcie-plda-host.c
    patch 15:
    	get_events() change in patch 7. Patch 8 is just move the codes.
    other change:
	All the functions in commit message add (). 
  v3:
    patch 2- 19:
      - splite refactoring patches to multiple patch.
      - rename plda_pcie to plda_pcie_rp. Maybe other vendor will
        upstream PLDA ep codes.
    patch 20:
      - Remove the redundant reference.
      - move the offset value to codes in starfive,stg-syscon
      - change reset-gpio to prest-gpio.
    patch 21:
      - Add 100ms delay after preset for PCIe 6.0 spec.
      - stg-syscon related modification.
    patch 22:
      - Add dts configure.


Minda Chen (22):
  dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  PCI: microchip: Move pcie-microchip-host.c to plda directory
  PCI: microchip: Move PLDA IP register macros to pcie-plda.h
  PCI: microchip: Add bridge_addr field to struct mc_pcie
  PCI: microchip: Rename two PCIe data structures
  PCI: microchip: Move PCIe host data structure to plda-pcie.h
  PCI: microchip: Rename two setup functions
  PCI: microchip: Change the argument of plda_pcie_setup_iomems()
  PCI: microchip: Move the setup functions to pcie-plda-host.c
  PCI: plda: Add PLDA default event IRQ handler
  PCI: microchip: Rename interrupt related functions
  PCI: microchip: Add num_events field to struct plda_pcie_rp
  PCI: microchip: Add request_event_irq() callback function
  PCI: microchip: Add INTx and MSI event num to struct plda_event
  PCI: microchip: Add get_events() callback function
  PCI: microchip: Add event IRQ domain ops to struct plda_event
  PCI: microchip: Move IRQ functions to pcie-plda-host.c
  PCI: plda: Set plda_event_handler() to static
  PCI: plda: Add event interrupt codes and IRQ domain ops
  dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  PCI: starfive: Add JH7110 PCIe controller
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  75 ++
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
 MAINTAINERS                                   |  19 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
 drivers/pci/controller/Kconfig                |   9 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/plda/Kconfig           |  30 +
 drivers/pci/controller/plda/Makefile          |   4 +
 .../{ => plda}/pcie-microchip-host.c          | 602 ++--------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 657 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       | 268 +++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 448 ++++++++++++
 14 files changed, 1835 insertions(+), 604 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
-- 
2.17.1

