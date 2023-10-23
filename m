Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B517D2799
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJWAqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjJWAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:46:03 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BE13E;
        Sun, 22 Oct 2023 17:45:58 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39N0iEnR078963;
        Mon, 23 Oct 2023 08:44:14 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 23 Oct 2023
 08:44:13 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>
Subject: [PATCH v3 RESEND 00/13] Support Andes PMU extension
Date:   Mon, 23 Oct 2023 08:40:47 +0800
Message-ID: <20231023004100.2663486-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39N0iEnR078963
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series introduces the Andes PMU extension, which serves
the same purpose as Sscofpmf. In this version we use FDT-based
probing and the CONFIG_ANDES_CUSTOM_PMU to enable perf sampling
and filtering support.

Its non-standard local interrupt is assigned to bit 18 in the
custom S-mode local interrupt enable/pending registers (slie/slip),
while the interrupt cause is (256 + 18).

The feature needs the PMU device registered in OpenSBI.
The OpenSBI and Linux patches can be found on Andes Technology GitHub
- https://github.com/andestech/opensbi/commits/andes-pmu-support-v2
- https://github.com/andestech/linux/commits/andes-pmu-support-v3

The PMU device tree node used on AX45MP:
- https://github.com/andestech/opensbi/blob/andes-pmu-support-v2/docs/pmu_support.md#example-3

Tested hardware:
- ASUS  Tinker-V (RZ/Five, AX45MP single core)
- Andes AE350    (AX45MP quad core)

Locus Wei-Han Chen (1):
  riscv: andes: Support symbolic FW and HW raw events

Yu Chien Peter Lin (12):
  riscv: errata: Rename defines for Andes
  irqchip/riscv-intc: Allow large non-standard hwirq number
  irqchip/riscv-intc: Introduce Andes IRQ chip
  dt-bindings: riscv: Add Andes interrupt controller compatible string
  riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
    INTC
  perf: RISC-V: Eliminate redundant IRQ enable/disable operations
  RISC-V: Move T-Head PMU to CPU feature alternative framework
  perf: RISC-V: Introduce Andes PMU for perf event sampling
  dt-bindings: riscv: Add T-Head PMU extension description
  dt-bindings: riscv: Add Andes PMU extension description
  riscv: dts: allwinner: Add T-Head PMU extension
  riscv: dts: renesas: Add Andes PMU extension

 .../devicetree/bindings/riscv/cpus.yaml       |   7 +-
 .../devicetree/bindings/riscv/extensions.yaml |  13 ++
 arch/riscv/Kconfig.errata                     |  13 --
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   2 +-
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
 arch/riscv/errata/andes/errata.c              |  10 +-
 arch/riscv/errata/thead/errata.c              |  19 ---
 arch/riscv/include/asm/errata_list.h          |  19 +--
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/vendorid_list.h        |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/irqchip/irq-riscv-intc.c              |  63 +++++++--
 drivers/perf/Kconfig                          |  27 ++++
 drivers/perf/riscv_pmu_sbi.c                  |  51 +++++--
 include/linux/irqchip/irq-riscv-intc.h        |  12 ++
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 21 files changed, 499 insertions(+), 79 deletions(-)
 create mode 100644 include/linux/irqchip/irq-riscv-intc.h
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

-- 
2.34.1

