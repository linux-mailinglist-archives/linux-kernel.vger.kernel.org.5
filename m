Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0B79D7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjILRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjILRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:50:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99436E59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0d5b16aacso49080295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541018; x=1695145818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yryjvzR9NzNgk6BCUoTtHwzBXt7G8S/d1x5J4L9Bd38=;
        b=JjklqaqkPpnTVcgPqtO/BQWf3HXqa/EGl6bOnWHgLnFo6X1dLpv+QzIZM3n2AWoexm
         P3U7dqymCmX17PVkaB+8tlcuCYTznep9qUGZ/aGT3+eb6M2GXczvuhTfB4Lqs+afcMfA
         bvmLDuXfN/YjLtY7lsdOYZTQNTrbGecJCCGz3eABXwXXBOGQwdpdoYHpnEOxEB0cMUez
         kPnW43yYDYrw1xLYwP5tGha2p7HS4+OFDTpCgPPNAk43ZBidsJ3tXhYueWqefn4NoZ00
         zMz8PFuyd8GICWFGgEYnLsSHO4wTzEWQHyG/z/WcxOy1ucVBYKhd9ao9WQDp+UQ/p3i7
         nCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541018; x=1695145818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yryjvzR9NzNgk6BCUoTtHwzBXt7G8S/d1x5J4L9Bd38=;
        b=qF1dNe2gylKgIAROrobjw/7NtITOFLvA/CzCaQI/lwLdd68xpsetcddz6iYGdHuY6L
         bmKPvpqE92KYcwGJ89Wpl7+na8muOkFktfXld0EkhFbTTC6+e/xdwuJW9knLNffYaz0v
         nIxprvOI7p0aEmMowPGhSx6dqlfr3gStEJd1iCWSTrPiO8I1kzbKnh4WpTDhg10HIemx
         zql0rYZ+v8OSjhDE7yhO1Ipo+hrZxJfnwUgqmr/d8kOk7FJZkKO+lcdq1xolPtwTILwc
         IqHSPwwqciIl32MfEw5EgDQ9zlg54K9UnCQVoS+WQOcKjCOvlwOduBpJZWm3qr21XlFD
         a5Gg==
X-Gm-Message-State: AOJu0YzfTxG/8RwIUW7fw6NGMYw6RIcfyxw2etm5hkOjMy+Q4PnxLGq6
        Bqy8BTI37Q6l0bEqYDUiSN/9Hw==
X-Google-Smtp-Source: AGHT+IG+H8Sqdnh7osuHtdXM7UpcXbzBIpKBjuQyZR+ITOL2ydCy0bljQIGgJzMdT4HoO0BkyNHfhA==
X-Received: by 2002:a17:903:32d0:b0:1c3:6667:5ff1 with SMTP id i16-20020a17090332d000b001c366675ff1mr455370plr.27.1694541017844;
        Tue, 12 Sep 2023 10:50:17 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:50:17 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 00/16] Linux RISC-V AIA Support
Date:   Tue, 12 Sep 2023 23:19:12 +0530
Message-Id: <20230912174928.528414-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V AIA specification is now frozen as-per the RISC-V international
process. The latest frozen specifcation can be found at:
https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf

At a high-level, the AIA specification adds three things:
1) AIA CSRs
   - Improved local interrupt support
2) Incoming Message Signaled Interrupt Controller (IMSIC)
   - Per-HART MSI controller
   - Support MSI virtualization
   - Support IPI along with virtualization
3) Advanced Platform-Level Interrupt Controller (APLIC)
   - Wired interrupt controller
   - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
   - In Direct-mode, injects external interrupts directly into HARTs

For an overview of the AIA specification, refer the AIA virtualization
talk at KVM Forum 2022:
https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
https://www.youtube.com/watch?v=r071dL8Z0yo

To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or higher).

These patches can also be found in the riscv_aia_v8 branch at:
https://github.com/avpatel/linux.git

Changes since v7:
 - Rebased on Linux-6.6-rc1
 - Addressed comments on PATCH1 of v7 series and split it into two PATCHes
 - Use DEFINE_SIMPLE_PROP() in PATCH2 of v7 series

Changes since v6:
 - Rebased on Linux-6.5-rc4
 - Updated PATCH2 to use IS_ENABLED(CONFIG_SPARC) instead of
   !IS_ENABLED(CONFIG_OF_IRQ)
 - Added new PATCH4 to fix syscore registration in PLIC driver
 - Update PATCH5 to convert PLIC driver into full-blown platform driver
   with a re-written probe function.

Changes since v5:
 - Rebased on Linux-6.5-rc2
 - Updated the overall series to ensure that only IPI, timer, and
   INTC drivers are probed very early whereas rest of the interrupt
   controllers (such as PLIC, APLIC, and IMISC) are probed as
   regular platform drivers.
 - Renamed riscv_fw_parent_hartid() to riscv_get_intc_hartid()
 - New PATCH1 to add fw_devlink support for msi-parent DT property
 - New PATCH2 to ensure all INTC suppliers are initialized which in-turn
   fixes the probing issue for PLIC, APLIC and IMSIC as platform driver
 - New PATCH3 to use platform driver probing for PLIC
 - Re-structured the IMSIC driver into two separate drivers: early and
   platform. The IMSIC early driver (PATCH7) only initialized IMSIC state
   and provides IPIs whereas the IMSIC platform driver (PATCH8) is probed
   provides MSI domain for platform devices.
 - Re-structure the APLIC platform driver into three separe sources: main,
   direct mode, and MSI mode.

Changes since v4:
 - Rebased on Linux-6.5-rc1
 - Added "Dependencies" in the APLIC bindings (PATCH6 in v4)
 - Dropped the PATCH6 which was changing the IOMMU DMA domain APIs
 - Dropped use of IOMMU DMA APIs in the IMSIC driver (PATCH4)

Changes since v3:
 - Rebased on Linux-6.4-rc6
 - Droped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT via
   IRQCHIP_DECLARE()
 - Extend riscv_fw_parent_hartid() to support both DT and ACPI in PATCH1
 - Extend iommu_dma_compose_msi_msg() instead of adding iommu_dma_select_msi()
   in PATCH6
 - Addressed Conor's comments in PATCH3
 - Addressed Conor's and Rob's comments in PATCH7

Changes since v2:
 - Rebased on Linux-6.4-rc1
 - Addressed Rob's comments on DT bindings patches 4 and 8.
 - Addessed Marc's comments on IMSIC driver PATCH5
 - Replaced use of OF apis in APLIC and IMSIC drivers with FWNODE apis
   this makes both drivers easily portable for ACPI support. This also
   removes unnecessary indirection from the APLIC and IMSIC drivers.
 - PATCH1 is a new patch for portability with ACPI support
 - PATCH2 is a new patch to fix probing in APLIC drivers for APLIC-only systems.
 - PATCH7 is a new patch which addresses the IOMMU DMA domain issues pointed
   out by SiFive

Changes since v1:
 - Rebased on Linux-6.2-rc2
 - Addressed comments on IMSIC DT bindings for PATCH4
 - Use raw_spin_lock_irqsave() on ids_lock for PATCH5
 - Improved MMIO alignment checks in PATCH5 to allow MMIO regions
   with holes.
 - Addressed comments on APLIC DT bindings for PATCH6
 - Fixed warning splat in aplic_msi_write_msg() caused by
   zeroed MSI message in PATCH7
 - Dropped DT property riscv,slow-ipi instead will have module
   parameter in future.

Anup Patel (16):
  RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
  RISC-V: Add riscv_get_intc_hartid() function
  of: property: Add fw_devlink support for msi-parent
  drivers: irqchip/riscv-intc: Mark all INTC nodes as initialized
  irqchip/sifive-plic: Fix syscore registration for multi-socket systems
  irqchip/sifive-plic: Convert PLIC driver into a platform driver
  irqchip/riscv-intc: Add support for RISC-V AIA
  dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
  irqchip: Add RISC-V incoming MSI controller early driver
  irqchip/riscv-imsic: Add support for platform MSI irqdomain
  irqchip/riscv-imsic: Add support for PCI MSI irqdomain
  dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
  irqchip: Add RISC-V advanced PLIC driver for direct-mode
  irqchip/riscv-aplic: Add support for MSI-mode
  RISC-V: Select APLIC and IMSIC drivers
  MAINTAINERS: Add entry for RISC-V AIA drivers

 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++++
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   2 +
 arch/riscv/include/asm/processor.h            |   4 +-
 arch/riscv/kernel/cpu.c                       |  24 +-
 drivers/irqchip/Kconfig                       |  25 +-
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c      | 326 +++++++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 240 ++++++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  53 ++
 drivers/irqchip/irq-riscv-aplic-msi.c         | 285 ++++++++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 258 +++++++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 328 +++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 523 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       |  67 +++
 drivers/irqchip/irq-riscv-intc.c              |  46 +-
 drivers/irqchip/irq-sifive-plic.c             | 200 ++++---
 drivers/of/property.c                         |   2 +
 include/linux/irqchip/riscv-aplic.h           | 119 ++++
 include/linux/irqchip/riscv-imsic.h           |  86 +++
 21 files changed, 2847 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
 create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
 create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-aplic.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

-- 
2.34.1

