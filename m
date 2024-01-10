Return-Path: <linux-kernel+bounces-21835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDC829502
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F51F21907
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921A3FB26;
	Wed, 10 Jan 2024 08:25:20 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DC3FB16;
	Wed, 10 Jan 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 40A7ftHr088651;
	Wed, 10 Jan 2024 15:41:55 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 40A7dRfJ086364;
	Wed, 10 Jan 2024 15:39:27 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Jan 2024
 15:39:22 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>, <guoren@kernel.org>,
        <heiko@sntech.de>, <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>, <inochiama@outlook.com>,
        <chao.wei@sophgo.com>, <unicorn_wang@outlook.com>, <wefu@redhat.com>
Subject: [PATCH v7 00/16] Support Andes PMU extension
Date: Wed, 10 Jan 2024 15:39:01 +0800
Message-ID: <20240110073917.2398826-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 40A7ftHr088651

Hi All,

This patch series introduces the Andes PMU extension, which serves
the same purpose as Sscofpmf. To use FDT-based probing for hardware
support of the PMU extensions and introduce Andes PMU alternatives,
we first convert T-Head's PMU to CPU feature alternative.

Its non-standard local interrupt is assigned to bit 18 in the
custom S-mode local interrupt enable/pending registers (slie/slip),
while the interrupt cause is (256 + 18).

Linux patches based on:
- ed5b7cf ("riscv: errata: andes: Probe for IOCP only once in boot stage")
It can be found on Andes Technology GitHub:
- https://github.com/andestech/linux/commits/andes-pmu-support-v7

The PMU device tree node used on AX45MP:
- https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md#example-3

Locus Wei-Han Chen (1):
  riscv: andes: Support specifying symbolic firmware and hardware raw
    events

Yu Chien Peter Lin (15):
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
  riscv: dts: allwinner: Add T-Head PMU extension for sun20i-d1s
  riscv: dts: sophgo: Add T-Head PMU extension for cv1800b
  riscv: dts: sophgo: Add T-Head PMU extension for sg2042
  riscv: dts: thead: Add T-Head PMU extension for th1520
  riscv: dts: renesas: Add Andes PMU extension for r9a07g043f

 .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
 .../devicetree/bindings/riscv/extensions.yaml |  13 ++
 arch/riscv/Kconfig.errata                     |  13 --
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   2 +-
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   2 +-
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 128 +++++++++---------
 arch/riscv/boot/dts/thead/th1520.dtsi         |   8 +-
 arch/riscv/errata/andes/errata.c              |  10 +-
 arch/riscv/errata/thead/errata.c              |  19 ---
 arch/riscv/include/asm/errata_list.h          |  19 +--
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/vendorid_list.h        |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 arch/riscv/kernel/cpufeature.c                |   2 +
 drivers/irqchip/irq-riscv-intc.c              |  88 ++++++++++--
 drivers/perf/Kconfig                          |  27 ++++
 drivers/perf/riscv_pmu_sbi.c                  |  47 +++++--
 include/linux/soc/andes/irq.h                 |  18 +++
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 +++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 24 files changed, 591 insertions(+), 151 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

-- 
2.34.1


