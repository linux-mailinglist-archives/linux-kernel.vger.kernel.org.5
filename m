Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9C77B4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjHNIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHNIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:53:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B1910B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:53:36 -0700 (PDT)
Message-ID: <20230814085006.593997112@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RrWoeKrZ/NO0qApWBihUZhOqJGZfHQhd3kYlrDwyiJg=;
        b=KxYI4Em3Y21e8Tp6f2rNllwuZ8CouDtqRgQCNTUKY3U5FaHybqLrRwMFNfgcTz3XIR0uyq
        c6i8y0XJbeRvqmY1FexcDLED4bi7zL615EbafX35C7tmLpHnSVqanIMJlBqNO8HjbxJer6
        N4gDu8+wsG1HzkzAdVtxNT+DWly0p3nrkLSKYh2zYA8wnxp2Sv6wcyXBUscKrOSo05dCrr
        6GElT7iYVHKfAA5qrH8dYSXgZM6YLzuKCQ3r6jn8G24TyUwDsrOMqf8O+auHZg8oA4V67X
        89j6ZK9T2Cru0Pu1+27gnULssrC2vhtR5iJJXSo9Jlz9sBWwea4bB1p4rdYMFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RrWoeKrZ/NO0qApWBihUZhOqJGZfHQhd3kYlrDwyiJg=;
        b=8tMot9Xm11qKar12ufXnk405cW/a8RUrPU3ALSMu095K/7LAbc1d88TL3yz6atUy7YrrW9
        hj7cH+/K9OhbGPAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [patch V4 00/41] x86/cpu: Rework the topology evaluation
Date:   Mon, 14 Aug 2023 10:53:33 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the follow up to V3:

  https://lore.kernel.org/lkml/20230802101635.459108805@linutronix.de

which addresses the review feedback.

TLDR:

This reworks the way how topology information is evaluated via CPUID
in preparation for a larger topology management overhaul to address
shortcomings of the current code vs. hybrid systems and systems which make
use of the extended topology domains in leaf 0x1f. Aside of that it's an
overdue spring cleaning to get rid of accumulated layers of duct tape and
haywire.

What changed vs. V3:

  - Added the Hygon fix from Pu Wen and adjusted the new code accordingly

  - Fixed the off by one in the AMD parser for real - Michael

  - Reworked the unknown domain type handling in the 0xb/01f parser - Rui

  - Made core ID package relative - Rui

  - Folded the missing u32 conversions - Qiuxu

  - Folded the fake_topology() fixup from the full topology series

  - Small cleanups and enhancements

  - Picked up Tested-by tags

The series is based on the the APIC cleanup series in tip:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic

and also available on top of that from git:

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v4

Thanks,

	tglx
---
 arch/x86/kernel/cpu/topology.c              |  168 -------------------
 b/Documentation/arch/x86/topology.rst       |   12 -
 b/arch/x86/events/amd/core.c                |    2 
 b/arch/x86/events/amd/uncore.c              |    2 
 b/arch/x86/events/intel/uncore.c            |    2 
 b/arch/x86/hyperv/hv_vtl.c                  |    2 
 b/arch/x86/include/asm/apic.h               |   38 +---
 b/arch/x86/include/asm/cacheinfo.h          |    3 
 b/arch/x86/include/asm/cpuid.h              |   36 ++++
 b/arch/x86/include/asm/mpspec.h             |    2 
 b/arch/x86/include/asm/processor.h          |   60 ++++--
 b/arch/x86/include/asm/smp.h                |    4 
 b/arch/x86/include/asm/topology.h           |   51 +++++
 b/arch/x86/include/asm/x86_init.h           |    2 
 b/arch/x86/kernel/acpi/boot.c               |    4 
 b/arch/x86/kernel/amd_nb.c                  |    8 
 b/arch/x86/kernel/apic/apic.c               |   29 ++-
 b/arch/x86/kernel/apic/apic_common.c        |    4 
 b/arch/x86/kernel/apic/apic_flat_64.c       |   13 -
 b/arch/x86/kernel/apic/apic_noop.c          |    9 -
 b/arch/x86/kernel/apic/apic_numachip.c      |   21 --
 b/arch/x86/kernel/apic/bigsmp_32.c          |   10 -
 b/arch/x86/kernel/apic/ipi.c                |    5 
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
 b/arch/x86/kernel/cpu/hygon.c               |  135 ---------------
 b/arch/x86/kernel/cpu/intel.c               |   38 ----
 b/arch/x86/kernel/cpu/mce/amd.c             |    4 
 b/arch/x86/kernel/cpu/mce/apei.c            |    4 
 b/arch/x86/kernel/cpu/mce/core.c            |    4 
 b/arch/x86/kernel/cpu/mce/inject.c          |    7 
 b/arch/x86/kernel/cpu/proc.c                |    8 
 b/arch/x86/kernel/cpu/topology.h            |   56 ++++++
 b/arch/x86/kernel/cpu/topology_amd.c        |  182 +++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_common.c     |  241 ++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_ext.c        |  132 +++++++++++++++
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
 b/kernel/cpu.c                              |   16 +
 62 files changed, 1095 insertions(+), 970 deletions(-)
