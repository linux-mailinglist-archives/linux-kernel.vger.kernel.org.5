Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A378DEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjH3TTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjH3Rco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:32:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC326193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693416760; x=1724952760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=perKzTfKzQv+Vr8bc1qp9qjvUzyKJSPHxP5rO5pXRjM=;
  b=Cn55mCEA5IVnCORuBVNH9qVR8KpP4IiWp8NRFPU7POLa0YYTsVyDKO9h
   lsXqY8CL8Lq2yqFvmsqQ2gedloe0GmJt2Sj8rEdMRA2rOxUoHR2t9/3gM
   Qtk08j3izgViGHYF6b2c81GAn7PnQ1EeJCDAU9U6WH9YUewnlyRLbKHA9
   JMlc6iw4Gku/853koQSTC+92xNjG34MWdUm+3RUjPkNG0F0EyA3w25AAJ
   6QuDrgoPW9C5gnNExzKE2pI2INuoY+qWS40SvlpPmMW2/Wo+DJrKGLQNj
   nNKUXVGy7R656XFBrJEzyAgrn+7tpOHEIoaSemAJJ/pLdFEcAomR7Zoqy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462083449"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="462083449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="715992637"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="715992637"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2023 10:32:38 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/apic for 6.6-rc1
Date:   Wed, 30 Aug 2023 10:32:32 -0700
Message-Id: <20230830173232.2520518-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/apic changes for 6.6-rc1.  This includes a very
thorough rework of the 'struct apic' handlers.  Quite a variety of
them popped up over the years, especially in the 32-bit days when odd
apics were much more in vogue.

The end result speaks for itself, which is a removal of a ton of code
and static calls to replace indirect calls.

If there's any breakage here, it's likely to be around the 32-bit
museum pieces that get light to no testing these days.

There is an oddity in the authorship/SoB chains I wanted to point out.
When sticking this series on top of the x86/apic pile, I managed to
replace Thomas's "Author:" with mine for a pair of patches:

	28b8235238fa ("x86/apic: Wrap IPI calls into helper functions")
	670c04add6e1 ("x86/apic: Nuke ack_APIC_irq()")

This was noticed after sitting in the public tree for a week or two
and I figured you'd rather have slightly wonky authorship than
something that looked like a fresh rebase close to the merge window.

--

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.6-rc1

for you to fetch changes up to f8542a55499a69a859c84866b66f0df43933e563:

  x86/apic: Turn on static calls (2023-08-09 12:00:55 -0700)

----------------------------------------------------------------
 * Rework apic callbacks, getting rid of unnecessary ones and
   coalescing lots of silly duplicates.
 * Use static_calls() instead of indirect calls for apic->foo()
 * Tons of cleanups an crap removal along the way

----------------------------------------------------------------
Dave Hansen (3):
      x86/apic: Remove mpparse 'apicid' variable
      x86/apic: Nuke ack_APIC_irq()
      x86/apic: Wrap IPI calls into helper functions

Juergen Gross (1):
      x86/xen/apic: Use standard apic driver mechanism for Xen PV

Thomas Gleixner (59):
      x86/vector: Rename send_cleanup_vector() to vector_schedule_cleanup()
      x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback
      x86/cpu: Make identify_boot_cpu() static
      x86/cpu: Remove unused physid_*() nonsense
      x86/apic: Rename disable_apic
      x86/apic/ioapic: Rename skip_ioapic_setup
      x86/apic: Remove pointless x86_bios_cpu_apicid
      x86/apic: Get rid of hard_smp_processor_id()
      x86/apic: Remove unused max_physical_apicid
      x86/apic: Nuke unused apic::inquire_remote_apic()
      x86/apic: Consolidate boot_cpu_physical_apicid initialization sites
      x86/apic: Register boot CPU APIC early
      x86/apic: Remove the pointless APIC version check
      x86/of: Fix the APIC address registration
      x86/apic: Make some APIC init functions bool
      x86/apic: Split register_apic_address()
      x86/apic: Sanitize APIC address setup
      x86/xen/pv: Pretend that it found SMP configuration
      x86/apic: Sanitize num_processors handling
      x86/apic: Nuke another processor check
      x86/apic: Remove check_phys_apicid_present()
      x86/apic: Get rid of apic_phys
      x86/apic/32: Sanitize logical APIC ID handling
      x86/apic/32: Remove x86_cpu_to_logical_apicid
      x86/apic/ipi: Code cleanup
      x86/apic: Mop up early_per_cpu() abuse
      x86/apic/32: Remove pointless default_acpi_madt_oem_check()
      x86/apic/32: Decrapify the def_bigsmp mechanism
      x86/apic/32: Remove bigsmp_cpu_present_to_apicid()
      x86/apic: Nuke empty init_apic_ldr() callbacks
      x86/apic: Nuke apic::apicid_to_cpu_present()
      x86/ioapic/32: Decrapify phys_id_present_map operation
      x86/apic: Mop up *setup_apic_routing()
      x86/apic: Mop up apic::apic_id_registered()
      x86/apic/ipi: Tidy up the code and fixup comments
      x86/apic: Consolidate wait_icr_idle() implementations
      x86/apic: Allow apic::wait_icr_idle() to be NULL
      x86/apic: Allow apic::safe_wait_icr_idle() to be NULL
      x86/apic: Move safe wait_icr_idle() next to apic_mem_wait_icr_idle()
      x86/apic/uv: Get rid of wrapper callbacks
      x86/apic/x2apic: Share all common IPI functions
      x86/apic/64: Uncopypaste probing
      x86/apic: Wrap APIC ID validation into an inline
      x86/apic: Add max_apic_id member
      x86/apic: Simplify X2APIC ID validation
      x86/apic: Prepare x2APIC for using apic::max_apic_id
      x86/apic: Sanitize APIC ID range validation
      x86/apic: Remove pointless NULL initializations
      x86/apic/noop: Tidy up the code
      x86/apic: Remove pointless arguments from [native_]eoi_write()
      x86/apic: Wrap apic->native_eoi() into a helper
      x86/apic: Provide common init infrastructure
      x86/apic: Provide apic_update_callback()
      x86/apic: Replace acpi_wake_cpu_handler_update() and apic_set_eoi_cb()
      x86/apic: Convert other overrides to apic_update_callback()
      x86/xen/apic: Mark apic __ro_after_init
      x86/apic: Mark all hotpath APIC callback wrappers __always_inline
      x86/apic: Provide static call infrastructure for APIC callbacks
      x86/apic: Turn on static calls

Xin Li (1):
      tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools

 arch/x86/hyperv/hv_apic.c                          |  26 +-
 arch/x86/hyperv/hv_init.c                          |   2 +-
 arch/x86/hyperv/hv_spinlock.c                      |   2 +-
 arch/x86/hyperv/hv_vtl.c                           |   2 +-
 arch/x86/include/asm/apic.h                        | 239 ++++++-----
 arch/x86/include/asm/hw_irq.h                      |   4 +-
 arch/x86/include/asm/idtentry.h                    |   1 -
 arch/x86/include/asm/io_apic.h                     |   7 +-
 arch/x86/include/asm/irq_vectors.h                 |   7 -
 arch/x86/include/asm/mpspec.h                      |  31 +-
 arch/x86/include/asm/processor.h                   |   1 -
 arch/x86/include/asm/smp.h                         |  11 -
 arch/x86/kernel/acpi/boot.c                        |  12 +-
 arch/x86/kernel/apic/Makefile                      |   2 +-
 arch/x86/kernel/apic/apic.c                        | 454 +++++++--------------
 arch/x86/kernel/apic/apic_common.c                 |  21 +-
 arch/x86/kernel/apic/apic_flat_64.c                |  80 +---
 arch/x86/kernel/apic/apic_noop.c                   |  91 +----
 arch/x86/kernel/apic/apic_numachip.c               |  50 +--
 arch/x86/kernel/apic/bigsmp_32.c                   |  89 +---
 arch/x86/kernel/apic/hw_nmi.c                      |   4 +-
 arch/x86/kernel/apic/init.c                        | 110 +++++
 arch/x86/kernel/apic/io_apic.c                     |  30 +-
 arch/x86/kernel/apic/ipi.c                         | 176 ++++----
 arch/x86/kernel/apic/local.h                       |  30 +-
 arch/x86/kernel/apic/msi.c                         |   2 +-
 arch/x86/kernel/apic/probe_32.c                    | 117 ++----
 arch/x86/kernel/apic/probe_64.c                    |  18 +-
 arch/x86/kernel/apic/vector.c                      | 116 ++++--
 arch/x86/kernel/apic/x2apic_cluster.c              |  23 +-
 arch/x86/kernel/apic/x2apic_phys.c                 |  74 ++--
 arch/x86/kernel/apic/x2apic_uv_x.c                 |  51 +--
 arch/x86/kernel/cpu/acrn.c                         |   2 +-
 arch/x86/kernel/cpu/amd.c                          |   2 +-
 arch/x86/kernel/cpu/common.c                       |   2 +-
 arch/x86/kernel/cpu/hygon.c                        |   3 +-
 arch/x86/kernel/cpu/mce/amd.c                      |   2 +-
 arch/x86/kernel/cpu/mce/inject.c                   |   3 +-
 arch/x86/kernel/cpu/mce/threshold.c                |   2 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   4 +-
 arch/x86/kernel/devicetree.c                       |  21 +-
 arch/x86/kernel/idt.c                              |   1 -
 arch/x86/kernel/irq.c                              |  14 +-
 arch/x86/kernel/irq_work.c                         |   4 +-
 arch/x86/kernel/jailhouse.c                        |   6 +-
 arch/x86/kernel/kvm.c                              |  14 +-
 arch/x86/kernel/mpparse.c                          |  20 +-
 arch/x86/kernel/nmi_selftest.c                     |   2 +-
 arch/x86/kernel/setup.c                            |   7 +-
 arch/x86/kernel/setup_percpu.c                     |  10 -
 arch/x86/kernel/sev.c                              |   4 +-
 arch/x86/kernel/smp.c                              |  10 +-
 arch/x86/kernel/smpboot.c                          | 115 +-----
 arch/x86/kernel/vsmp_64.c                          |   2 +-
 arch/x86/kvm/vmx/posted_intr.c                     |   2 +-
 arch/x86/kvm/vmx/vmx.c                             |   2 +-
 arch/x86/mm/srat.c                                 |   5 +-
 arch/x86/pci/xen.c                                 |   2 +-
 arch/x86/platform/uv/uv_irq.c                      |   2 +-
 arch/x86/platform/uv/uv_nmi.c                      |   2 +-
 arch/x86/xen/apic.c                                |  85 +---
 arch/x86/xen/enlighten_hvm.c                       |   2 +-
 arch/x86/xen/enlighten_pv.c                        |   4 +-
 arch/x86/xen/smp_pv.c                              |   5 +-
 drivers/iommu/amd/iommu.c                          |   2 +-
 drivers/iommu/hyperv-iommu.c                       |   4 +-
 drivers/iommu/intel/irq_remapping.c                |   2 +-
 tools/arch/x86/include/asm/irq_vectors.h           |   7 -
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |   2 +-
 69 files changed, 841 insertions(+), 1420 deletions(-)
 create mode 100644 arch/x86/kernel/apic/init.c
