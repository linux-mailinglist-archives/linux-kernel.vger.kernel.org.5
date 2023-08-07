Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21F772697
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjHGNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjHGNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8110CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:35 -0700 (PDT)
Message-ID: <20230807130108.853357011@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tcLAdFLsW4PUtHOE80f0kO1ua+kPzb3mSbS72PnrT3o=;
        b=SX4+uLBmkOjLZDXuPAlPtn2+MoAVZwrWQpnOj+Va/QAjBQoqngQurKg/+92WDJWb4EuSaW
        uhovPUxbex2bNv4PngOgfHpdhccrw0BJVyjse8zajz2E1pqBU2GSi5ohtqTTCH3xhkMUGW
        9RON3pHnYQdWPuuWK0FXlCH1U7xmoLbVU5WtHzoYB+JlC0n7hMaXXKJW3+zbLQ92BPPw3V
        3fXBjxqOJITaEa92xzVOO9/2z31GviMaPneGbgIkKzMq9iXmnlbUc9kx2tWT8LGNKKmGg8
        3ynWOMvLftjkFhUfo5iyVRn77QGDYSxoj9/JUSqkBFcgzpkLgHDg0EcJbnZo6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tcLAdFLsW4PUtHOE80f0kO1ua+kPzb3mSbS72PnrT3o=;
        b=HIEvSaNuhOL+ToJdwhCgr/QxHrhC+7WUwkdThQzcJw/Uas06kGbaLHi0lgRwhQIGnu3JY/
        ps0b7cuWq0LsbJBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 00/53] x86/topology: The final installment
Date:   Mon,  7 Aug 2023 15:52:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the (for now) last part of reworking topology enumeration and
management. It's based on the APIC and CPUID rework series which can be
found here:

      https://lore.kernel.org/lkml/20230802101635.459108805@linutronix.de

With these preparatory changes in place, it's now possible to address the
real issues of the current topology code:

  - Wrong core count on hybrid systems

  - Heuristics based size information for packages and dies which
    are failing to work correctly with certain command line parameters.

  - Full evaluation fail for a theoretical hybrid system which boots
    from an E-core

  - The complete insanity of manipulating global data from firmware parsers
    or the XEN/PV fake SMP enumeration. The latter is really a piece of art.

This series addresses this by

  - Mopping up some more historical technical debt

  - Consolidating all topology relevant functionality into one place

  - Providing separate interfaces for boot time and ACPI hotplug operations

  - A sane ordering of command line options and restrictions

  - A sensible way to handle the BSP problem in kdump kernels instead of
    the unreliable command line option.

  - Confinement of topology relevant variables by replacing the XEN/PV SMP
    enumeration fake with something halfways sensible.

  - Evaluation of sizes by analysing the topology via the CPUID provided
    APIC ID segmentation and the actual APIC IDs which are registered at
    boot time.

  - Removal of heuristics and broken size calculations

The idea behind this is the following:

The APIC IDs describe the system topology in multiple domain levels. The
CPUID topology parser provides the information which part of the APIC ID is
associated to the individual levels (Intel terminology):

   [ROOT][PACKAGE][DIE][TILE][MODULE][CORE][THREAD]

The root space contains the package (socket) IDs. Not enumerated levels
consume 0 bits space, but conceptually they are always represented. If
e.g. only CORE and THREAD levels are enumerated then the DIE, MODULE and
TILE have the same physical ID as the PACKAGE.

If SMT is not supported, then the THREAD domain is still used. It then
has the same physical ID as the CORE domain and is the only child of
the core domain.

This allows an unified view on the system independent of the enumerated
domain levels without requiring any conditionals in the code.

AMD does only expose 4 domain levels with obviously different terminology,
but that can be easily mapped into the Intel variant with a trivial lookup
table added to the CPUID parser.

The resulting topology information of an ADL hybrid system with 8 P-Cores
and 8 E-Cores looks like this:

 CPU topo: Max. logical packages:   1
 CPU topo: Max. logical dies:       1
 CPU topo: Max. dies per package:   1
 CPU topo: Max. threads per core:   2
 CPU topo: Num. cores per package:    16
 CPU topo: Num. threads per package:  24
 CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
 CPU topo: Thread    :    24
 CPU topo: Core      :    16
 CPU topo: Module    :     1
 CPU topo: Tile      :     1
 CPU topo: Die       :     1
 CPU topo: Package   :     1

This is happening on the boot CPU before any of the APs is started and
provides correct size information right from the start.

Even the XEN/PV trainwreck makes use of this now. On Dom0 it utilizes the
MADT and on DomU it provides fake APIC IDs, which combined with the
provided CPUID information make it at least look halfways realistic instead
of claiming to have one CPU per package as the current upstream code does.

This is solely addressing the core topology issues, but there is a plan for
further consolidation of other topology related information into one single
source of information instead of having a gazillion of localized special
parsers and representations all over the place. There are quite some other
things which can be simplified on top of this, like updating the various
cpumasks during CPU bringup, but that's all left for later.

So another 53 patches later, the resulting diffstat is:

   64 files changed, 830 insertions(+), 955 deletions(-)

and the combo diffstat of all three series combined:

  115 files changed, 2414 insertions(+), 3035 deletions(-)

The current series applies on top of 

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v3

and is available from git here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v1

Thanks,

	tglx
---
 Documentation/admin-guide/kdump/kdump.rst                      |    7 
 Documentation/admin-guide/kernel-parameters.txt                |    9 
 Documentation/arch/x86/topology.rst                            |   24 
 arch/x86/events/intel/cstate.c                                 |    2 
 arch/x86/events/intel/uncore.c                                 |    2 
 arch/x86/events/intel/uncore_nhmex.c                           |    4 
 arch/x86/events/intel/uncore_snb.c                             |    8 
 arch/x86/events/intel/uncore_snbep.c                           |   18 
 arch/x86/events/rapl.c                                         |    2 
 arch/x86/include/asm/apic.h                                    |   17 
 arch/x86/include/asm/io_apic.h                                 |    1 
 arch/x86/include/asm/mpspec.h                                  |   66 -
 arch/x86/include/asm/perf_event_p4.h                           |   11 
 arch/x86/include/asm/processor.h                               |    2 
 arch/x86/include/asm/prom.h                                    |    4 
 arch/x86/include/asm/smp.h                                     |    6 
 arch/x86/include/asm/topology.h                                |   60 -
 arch/x86/include/asm/x86_init.h                                |   10 
 arch/x86/kernel/acpi/boot.c                                    |   59 -
 arch/x86/kernel/apic/apic.c                                    |  207 ----
 arch/x86/kernel/apic/apic_common.c                             |   15 
 arch/x86/kernel/apic/apic_flat_64.c                            |    9 
 arch/x86/kernel/apic/apic_noop.c                               |    2 
 arch/x86/kernel/apic/apic_numachip.c                           |   12 
 arch/x86/kernel/apic/bigsmp_32.c                               |   14 
 arch/x86/kernel/apic/io_apic.c                                 |   85 -
 arch/x86/kernel/apic/local.h                                   |    4 
 arch/x86/kernel/apic/probe_32.c                                |    3 
 arch/x86/kernel/apic/x2apic_cluster.c                          |    3 
 arch/x86/kernel/apic/x2apic_phys.c                             |    6 
 arch/x86/kernel/apic/x2apic_uv_x.c                             |    6 
 arch/x86/kernel/cpu/Makefile                                   |   12 
 arch/x86/kernel/cpu/cacheinfo.c                                |    2 
 arch/x86/kernel/cpu/common.c                                   |   42 
 arch/x86/kernel/cpu/debugfs.c                                  |   15 
 arch/x86/kernel/cpu/mce/inject.c                               |    3 
 arch/x86/kernel/cpu/microcode/intel.c                          |    4 
 arch/x86/kernel/cpu/topology.c                                 |  497 ++++++++++
 arch/x86/kernel/cpu/topology.h                                 |    5 
 arch/x86/kernel/cpu/topology_common.c                          |   57 -
 arch/x86/kernel/devicetree.c                                   |    4 
 arch/x86/kernel/jailhouse.c                                    |   30 
 arch/x86/kernel/mpparse.c                                      |   35 
 arch/x86/kernel/process.c                                      |    2 
 arch/x86/kernel/setup.c                                        |   27 
 arch/x86/kernel/smpboot.c                                      |  229 ----
 arch/x86/kernel/x86_init.c                                     |    5 
 arch/x86/mm/amdtopology.c                                      |    7 
 arch/x86/platform/ce4100/ce4100.c                              |   14 
 arch/x86/platform/intel-mid/intel-mid.c                        |    5 
 arch/x86/xen/apic.c                                            |   21 
 arch/x86/xen/enlighten_hvm.c                                   |    2 
 arch/x86/xen/enlighten_pv.c                                    |    3 
 arch/x86/xen/smp.c                                             |    2 
 arch/x86/xen/smp.h                                             |    2 
 arch/x86/xen/smp_pv.c                                          |   66 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c               |    2 
 drivers/hwmon/coretemp.c                                       |    2 
 drivers/hwmon/fam15h_power.c                                   |    2 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |    2 
 drivers/powercap/intel_rapl_common.c                           |    2 
 drivers/thermal/intel/intel_hfi.c                              |    2 
 drivers/thermal/intel/intel_powerclamp.c                       |    2 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                   |    2 
 64 files changed, 830 insertions(+), 955 deletions(-)
