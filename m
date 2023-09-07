Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C341796EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjIGCd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjIGCdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:33:24 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDB19B5;
        Wed,  6 Sep 2023 19:33:19 -0700 (PDT)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
        by Atcsqr.andestech.com with ESMTP id 3872JA7c025828;
        Thu, 7 Sep 2023 10:19:10 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3872I5eM024097;
        Thu, 7 Sep 2023 10:18:05 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Sep 2023
 10:18:00 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 0/4] Support Andes PMU extension
Date:   Thu, 7 Sep 2023 10:16:31 +0800
Message-ID: <20230907021635.1002738-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3872JA7c025828
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces the Andes PMU errata, which
adds support for perf sampling and mode filtering with
the Andes PMU extension. 

The custom PMU extension serves the same purpose as Sscofpmf.
Its non-standard local interrupt is assigned to bit 18 in the
custom S-mode local interrupt pending CSR (slip), while the
interrupt cause is (256 + 18).

This series is dependent on the series from Prabhakar,
- https://patchwork.kernel.org/project/linux-riscv/cover/20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

The feature needs the PMU device callbacks in OpenSBI.
The OpenSBI and Linux patches can be found on Andes Technology GitHub
- https://github.com/andestech/opensbi/commits/andes-pmu-support
- https://github.com/andestech/linux/commits/andes-pmu-support

The PMU device tree node of AX45MP:
- https://github.com/andestech/opensbi/blob/andes-pmu-support/docs/pmu_support.md#example-3

Tested hardware:
- ASUS  Tinker-V (RZ/Five, AX45MP single core)
- Andes AE350    (AX45MP quad core)

Locus Wei-Han Chen (1):
  riscv: andes: Support symbolic FW and HW raw events

Yu Chien Peter Lin (3):
  riscv: errata: Rename defines for Andes
  irqchip/riscv-intc: Support large non-standard hwirq number
  riscv: errata: Add Andes PMU errata

 arch/riscv/Kconfig.errata                     |  13 ++
 arch/riscv/errata/andes/errata.c              |  55 +++++++-
 arch/riscv/include/asm/errata_list.h          |  45 ++++++-
 arch/riscv/include/asm/vendorid_list.h        |   2 +-
 arch/riscv/kernel/alternative.c               |   2 +-
 drivers/irqchip/irq-riscv-intc.c              |  10 +-
 drivers/perf/riscv_pmu_sbi.c                  |  20 ++-
 .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
 .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
 .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
 .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 12 files changed, 453 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json

-- 
2.34.1

