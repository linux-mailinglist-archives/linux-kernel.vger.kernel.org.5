Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB55376CAA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjHBKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHBKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:21:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2D2137
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:21:00 -0700 (PDT)
Message-ID: <20230802101635.459108805@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GXI1rxtTlDn076yBDU5q43lJu832PeBcBNlVRoAlR7A=;
        b=lkvb9WpTp3m9eviLXL1u0dyNvIY/VHkDhRcFWa0onoLAD6TLQ64Vgewq59KzalceZbYqTV
        Vm+BmoSYUbFzmr6ot1Dh0zdBc144BSo7stXPxHJkRDBNz4+kxg7ItzC+LkK2vX9rS+ynDt
        sHV/cIzt8Z+RDW9P9G+tOtGOs+HWFp48UtQ9Vp8ua7KqCAkxOZ2OnvRCEMhG1bNYywUG6i
        JCnlMVKRFyumqY+t3KPPSr06QYIggFFBnYZjRLcYIIKLP9nMZCuLmBdsSJnrHGdKjj8P0j
        38bBiN9a6M+wIpOH5ZNa6Hy5ECF/daZ0UUz27r4MLXTCwnKjk3dpkCTxifOHVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GXI1rxtTlDn076yBDU5q43lJu832PeBcBNlVRoAlR7A=;
        b=C/tX3hJTvJdglNVY3bXTpVGy9bEiNQrATUdzsnMgM46/ecyP9NQ/KaFHJEDSpybHR+ZgxO
        W+jBETQiHTwR98Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 00/40] x86/cpu: Rework the topology evaluation
Date:   Wed,  2 Aug 2023 12:20:57 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the follow up to V2:

  https://lore.kernel.org/lkml/20230728105650.565799744@linutronix.de

which addresses the review feedback and some fallout reported on and
off-list.

TLDR:

This reworks the way how topology information is evaluated via CPUID
in preparation for a larger topology management overhaul to address
shortcomings of the current code vs. hybrid systems and systems which make
use of the extended topology domains in leaf 0x1f. Aside of that it's an
overdue spring cleaning to get rid of accumulated layers of duct tape and
haywire.

What changed vs. V2:

  - Decoded and fixed the fallout vs. XEN/PV reported by Juergen. Thanks to
    Juergen for the remote hand debugging sessions!

    That's addressed in the first two new patches in this series. Summary:
    XEN/PV booted by pure chance since the addition of SMT control 5 years
    ago.

  - Fixed the off by one in the AMD parser which was debugged by Michael

  - Addressed review comments from various people

As discussed in:

  https://lore.kernel.org/lkml/BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com
  ....
  https://lore.kernel.org/lkml/87r0omjt8c.ffs@tglx

this series unfortunately brings the Hyper-V BIOS inconsistency into
effect, which results in a slight performance impact. The L3 association
which "worked" so far by exploiting the inconsistency of the Linux topology
code is not longer supportable as we really need to get the actual short
comings of our topology management addressed in a consistent way.

The series is based on V3 of the APIC cleanup series:

  https://lore.kernel.org/lkml/20230801103042.936020332@linutronix.de

and also available on top of that from git:

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v3

Thanks,

	tglx
---
 arch/x86/kernel/cpu/topology.c              |  168 -------------------
 b/Documentation/arch/x86/topology.rst       |   12 -
 b/arch/x86/events/amd/core.c                |    2 
 b/arch/x86/events/amd/uncore.c              |    2 
 b/arch/x86/events/intel/uncore.c            |    2 
 b/arch/x86/hyperv/hv_vtl.c                  |    2 
 b/arch/x86/include/asm/apic.h               |   32 +--
 b/arch/x86/include/asm/cacheinfo.h          |    3 
 b/arch/x86/include/asm/cpuid.h              |   36 ++++
 b/arch/x86/include/asm/mpspec.h             |    2 
 b/arch/x86/include/asm/processor.h          |   60 ++++---
 b/arch/x86/include/asm/smp.h                |    4 
 b/arch/x86/include/asm/topology.h           |   51 +++++
 b/arch/x86/include/asm/x86_init.h           |    2 
 b/arch/x86/kernel/acpi/boot.c               |    4 
 b/arch/x86/kernel/amd_nb.c                  |    8 
 b/arch/x86/kernel/apic/apic.c               |   25 +-
 b/arch/x86/kernel/apic/apic_common.c        |    4 
 b/arch/x86/kernel/apic/apic_flat_64.c       |   13 -
 b/arch/x86/kernel/apic/apic_noop.c          |    9 -
 b/arch/x86/kernel/apic/apic_numachip.c      |   21 --
 b/arch/x86/kernel/apic/bigsmp_32.c          |   10 -
 b/arch/x86/kernel/apic/local.h              |    6 
 b/arch/x86/kernel/apic/probe_32.c           |   10 -
 b/arch/x86/kernel/apic/x2apic_cluster.c     |    1 
 b/arch/x86/kernel/apic/x2apic_phys.c        |   10 -
 b/arch/x86/kernel/apic/x2apic_uv_x.c        |   67 +------
 b/arch/x86/kernel/cpu/Makefile              |    5 
 b/arch/x86/kernel/cpu/amd.c                 |  156 ------------------
 b/arch/x86/kernel/cpu/cacheinfo.c           |   51 ++---
 b/arch/x86/kernel/cpu/centaur.c             |    4 
 b/arch/x86/kernel/cpu/common.c              |  111 +-----------
 b/arch/x86/kernel/cpu/cpu.h                 |   14 +
 b/arch/x86/kernel/cpu/debugfs.c             |   97 +++++++++++
 b/arch/x86/kernel/cpu/hygon.c               |  133 ---------------
 b/arch/x86/kernel/cpu/intel.c               |   38 ----
 b/arch/x86/kernel/cpu/mce/amd.c             |    4 
 b/arch/x86/kernel/cpu/mce/apei.c            |    4 
 b/arch/x86/kernel/cpu/mce/core.c            |    4 
 b/arch/x86/kernel/cpu/mce/inject.c          |    7 
 b/arch/x86/kernel/cpu/proc.c                |    8 
 b/arch/x86/kernel/cpu/topology.h            |   51 +++++
 b/arch/x86/kernel/cpu/topology_amd.c        |  179 ++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_common.c     |  240 ++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_ext.c        |  136 +++++++++++++++
 b/arch/x86/kernel/cpu/zhaoxin.c             |   18 --
 b/arch/x86/kernel/kvm.c                     |    6 
 b/arch/x86/kernel/sev.c                     |    2 
 b/arch/x86/kernel/smpboot.c                 |   97 ++++++-----
 b/arch/x86/kernel/vsmp_64.c                 |   13 -
 b/arch/x86/mm/amdtopology.c                 |   35 +---
 b/arch/x86/mm/numa.c                        |    4 
 b/arch/x86/xen/apic.c                       |   14 -
 b/arch/x86/xen/smp_pv.c                     |    3 
 b/drivers/edac/amd64_edac.c                 |    4 
 b/drivers/edac/mce_amd.c                    |    4 
 b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 
 b/drivers/hwmon/fam15h_power.c              |    7 
 b/drivers/scsi/lpfc/lpfc_init.c             |    8 
 b/drivers/virt/acrn/hsm.c                   |    2 
 b/kernel/cpu.c                              |    6 
 61 files changed, 1077 insertions(+), 956 deletions(-)


