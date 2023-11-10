Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94F7E81F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjKJStY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbjKJStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:49:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3355E64
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:07:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA365C4167E;
        Fri, 10 Nov 2023 18:00:51 +0000 (UTC)
Date:   Fri, 10 Nov 2023 18:00:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.7-rc1
Message-ID: <ZU5v0Q0ybo8BZ-UH@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below based on top of the previous arm64
pull request. It's mostly PMU fixes and a reworking of the pseudo-NMI
disabling on broken MediaTek firmware (we didn't have time to do it
before the merging window). Thanks.

The following changes since commit 14dcf78a6c042dd9421b11485b394c6273568bca:

  Merge branch 'for-next/cpus_have_const_cap' into for-next/core (2023-10-26 17:10:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f86128050d2d854035bfa461aadf36e6951b2bac:

  arm64/syscall: Remove duplicate declaration (2023-11-09 17:19:14 +0000)

----------------------------------------------------------------
arm64 fixes:

- Move the MediaTek GIC quirk handling from irqchip to core. Before the
  merging window commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo
  NMIs on MediaTek devices w/ firmware issues") temporarily addressed
  this issue. Fixed now at a deeper level in the arch code.

- Reject events meant for other PMUs in the CoreSight PMU driver,
  otherwise some of the core PMU events would disappear.

- Fix the Armv8 PMUv3 driver driver to not truncate 64-bit registers,
  causing some events to be invisible.

- Remove duplicate declaration of __arm64_sys##name following the patch
  to avoid prototype warning for syscalls.

- Typos in the elf_hwcap documentation.

----------------------------------------------------------------
Douglas Anderson (2):
      arm64: Move MediaTek GIC quirk handling from irqchip to core
      Revert "arm64: smp: avoid NMI IPIs with broken MediaTek FW"

Ilkka Koskinen (2):
      perf: arm_cspmu: Reject events meant for other PMUs
      arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers

Kevin Brodsky (1):
      arm64/syscall: Remove duplicate declaration

Marielle Novastrider (1):
      Documentation/arm64: Fix typos in elf_hwcaps

 Documentation/arch/arm64/elf_hwcaps.rst  |  6 ++--
 arch/arm/include/asm/arm_pmuv3.h         | 48 +++++++++++++++-----------------
 arch/arm64/include/asm/arm_pmuv3.h       | 25 ++++-------------
 arch/arm64/include/asm/syscall_wrapper.h |  1 -
 arch/arm64/kernel/cpufeature.c           | 46 ++++++++++++++++++++++++------
 arch/arm64/kernel/smp.c                  |  5 +---
 drivers/irqchip/irq-gic-v3.c             | 24 ++--------------
 drivers/perf/arm_cspmu/arm_cspmu.c       |  3 ++
 drivers/perf/arm_pmuv3.c                 |  6 ++--
 9 files changed, 78 insertions(+), 86 deletions(-)

-- 
Catalin
