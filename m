Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A17F45A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjKVMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344035AbjKVMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:18:21 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8058AD47;
        Wed, 22 Nov 2023 04:18:16 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3AMCG3fV024992;
        Wed, 22 Nov 2023 20:16:03 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 22 Nov 2023
 20:16:01 +0800
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
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>,
        <inochiama@outlook.com>
Subject: [PATCH v4 00/13] Support Andes PMU extension
Date:   Wed, 22 Nov 2023 20:12:22 +0800
Message-ID: <20231122121235.827122-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3AMCG3fV024992
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series introduces the Andes PMU extension, which serves
the same purpose as Sscofpmf. To use FDT-based probing the hardware
support of the PMU extension, instead of adding another CPU errata,
we have converted T-Head's PMU alternative along with this series.

Its non-standard local interrupt is assigned to bit 18 in the
custom S-mode local interrupt enable/pending registers (slie/slip),
while the interrupt cause is (256 + 18).

The feature needs the PMU device registered in OpenSBI.
The OpenSBI and Linux patches can be found on Andes Technology GitHub
- https://github.com/andestech/opensbi/commits/andes-pmu-support-v3
- https://github.com/andestech/linux/commits/andes-pmu-support-v4

The PMU device tree node used on AX45MP:
- https://github.com/andestech/opensbi/blob/andes-pmu-support-v3/docs/pmu_support.md#example-3

Tested hardware:
- ASUS  Tinker-V (RZ/Five, AX45MP single core)
- Andes AE350    (AX45MP quad core)

Locus Wei-Han Chen (1):
  riscv: andes: Support symbolic FW and HW raw events

Yu Chien Peter Lin (12):
  riscv: errata: Rename defines for Andes
  irqchip/riscv-intc: Allow large non-standard interrupt number
  irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
  dt-bindings: riscv: Add Andes interrupt controller compatible string
  riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
    INTC
  perf: RISC-V: Eliminate redundant interrupt enable/disable operations
  RISC-V: Move T-Head PMU to CPU feature alternative framework
  perf: RISC-V: Introduce Andes PMU for perf event sampling
  dt-bindings: riscv: Add T-Head PMU extension description
  dt-bindings: riscv: Add Andes PMU extension description
  riscv: dts: allwinner: Add T-Head PMU extension
  riscv: dts: renesas: Add Andes PMU extension

 .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
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
 drivers/irqchip/irq-riscv-intc.c              |  61 +++++++--
 drivers/perf/Kconfig                          |  27 ++++
 drivers/perf/riscv_pmu_sbi.c                  |  47 +++++--
 include/linux/soc/andes/irq.h                 |  17 +++
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 21 files changed, 495 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

-- 
2.34.1

