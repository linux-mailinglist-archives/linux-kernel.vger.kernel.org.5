Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1D75FE06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGXRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGXRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:43:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ABC1702;
        Mon, 24 Jul 2023 10:43:52 -0700 (PDT)
Message-ID: <20230724155329.474037902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x0/YxfQ7KycD3cE3OrPXPIszM9wkw+ZpilEoSpWAuFg=;
        b=Jx8F+1qIV/RGTyVkOzfnDcLC62XmPX7bXKtGtISTgk1sG3J2QfAYkjFkCmx3xtdwVQHUM1
        V4RL1ttMTCHXD1oVAPt1xA7mQbIJIx1EZxvQHkTsqY+Pb4Hlv38vbMfxJhiSHN+sqM2wED
        VlyS8y2t7xB4rsifZc7d5WBs0kBzzMk/wbYGEbkwISIIRy1b8S/u4TFervAtBds/1VMtxk
        9N43EGGKJgJP8t2T5entdUybG/5rjk+l2K/uRbm07/vo2paaoFyV2KH2IYJ2i23htM6tN+
        afTyRHRvTaAEh/dxOCVIDauANzXZ+Q9dJSn8T3Ik2wT8PQov/wDCCjjLEywrcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x0/YxfQ7KycD3cE3OrPXPIszM9wkw+ZpilEoSpWAuFg=;
        b=NY6Sj68bJiuzUoSEOZuvhu53pQhB1UEyUse7mVx0GXYydmSIElcW0UW5H9lGjY3V0jXUCU
        MZjKNPMnf7+8SUAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 00/29] x86/cpu: Rework the topology evaluation
Date:   Mon, 24 Jul 2023 19:43:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A recent commit to the CPUID leaf 0xb/0x1f parser made me look deeper at
the way how topology is evaluated. That "fix" is just yet another cure the
sypmtom hack which completely ignores the underlying disaster.

The way how topology evaluation works is to overwrite the relevant
variables as often as possible. E.g. smp_num_siblings gets overwritten a
gazillion times, which is wrong to begin with. The boot CPU writes it 3
times, each AP two times.

What's worse is that this just works by chance on hybrid systems due to the
fact that the existing ones all seem to boot on a P-Core which has
SMT. Would it boot on a E-Core which has no SMT, then parts of the early
topology evaluation including the primary thread mask which is required for
parallel CPU bringup would be completely wrong. Overwriting it later on
with the correct value does not help at all.

What's wrong today with hybrid already is the number of cores per package.
On an ADL with 8 P-Cores and 8 E-cores the resulting number of cores per
package is evaluated to be 12. Which is not further surprising because the
CPUID 0xb/0x1f parser looks at the number of logical processors at core
level and divides them by the number of SMP siblings.

   24 / 2 = 12

Just that this CPU has obviously 16 cores not 12.

It's is even clearly documented in the SDM that this is wrong.

 "Bits 15-00: The number of logical processors across all instances of this
  domain within the next higher- scoped domain relative to this current
  logical processor. (For example, in a processor socket/package comprising
  "M" dies of "N" cores each, where each core has "L" processors, the
  "die" domain subleaf value of this field would be M*N*L. In an asymmetric
  topology this would be the summation of the value across the lower domain
  level instances to create each upper domain level instance.) This number
  reflects configuration as shipped by Intel. Note, software must not use
  this field to enumerate processor topology.

  Software must not use the value of EBX[15:0] to enumerate processor topology
  of the system. The value is only intended for display and diagnostic purposes.
  The actual number of logical processors available to BIOS/OS/Applications
  may be different from the value of EBX[15:0], depending on software and
  platform hardware configurations."

This "_NOT_ to use for topology evaluation" sentence existed even before
hybrid came along and got ignored. The code worked by chance, but with
hybrid all bets are off. The code completely falls apart once CPUID leaf
0x1f enumerates any topology level between CORE and DIE, but that's not a
suprise.

The proper thing to do is to actually evaluate the full topology including
the non-present (hotpluggable) CPUs based on the APICIDs which are provided
by the firmware and a proper topology domain level parser. This can exactly
tell the number of physical packages, logical packages etc. _before_ even
booting a single AP. All of that can be evaluated upfront.

Aside of that there are too many places which do their own topology
evaluation, but there is absolutely no central point which can actually
provide all of that information in a consistent way. This needs to change.

This series implements another piece towards this: sane CPUID evaluation,
which is done at _one_ place in a proper well defined order instead of
having it sprinkled all over the CPUID evaluation code.

At the end of this series this is pretty much bug compatible with the
current CPUID evaluation code in respect to the cores per package
evaluation, but it gets rid of overwriting things like smp_num_siblings,
which is now written once, but is still not capable to work correctly on a
hybrid machine which boots from a non SMT core. These things can only be
fixed up in the next step(s).

When I tried to go further with this I ran into yet another pile of
historical layers of duct tape and haywire with a gazillion of random
variables sprinkled all over the place. That's still work in progress.  It
actually works, but the last step which switches over is not yet in a shape
that can be easily reviewed. Stay tuned.

The series is based on the APIC cleanup series:

  https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de

and also available on top of that from git:

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v1

Thanks,

	tglx
---
 arch/x86/kernel/cpu/topology.c              |  168 --------------------
 b/Documentation/arch/x86/topology.rst       |   12 -
 b/arch/x86/events/amd/core.c                |    2 
 b/arch/x86/events/amd/uncore.c              |    2 
 b/arch/x86/events/intel/uncore.c            |    2 
 b/arch/x86/include/asm/apic.h               |    1 
 b/arch/x86/include/asm/cacheinfo.h          |    3 
 b/arch/x86/include/asm/cpuid.h              |   32 +++
 b/arch/x86/include/asm/processor.h          |   58 ++++--
 b/arch/x86/include/asm/smp.h                |    2 
 b/arch/x86/include/asm/topology.h           |   51 +++++-
 b/arch/x86/include/asm/x86_init.h           |    2 
 b/arch/x86/kernel/amd_nb.c                  |    8 
 b/arch/x86/kernel/apic/apic_flat_64.c       |    7 
 b/arch/x86/kernel/apic/apic_noop.c          |    3 
 b/arch/x86/kernel/apic/apic_numachip.c      |   11 -
 b/arch/x86/kernel/apic/bigsmp_32.c          |    6 
 b/arch/x86/kernel/apic/local.h              |    1 
 b/arch/x86/kernel/apic/probe_32.c           |    6 
 b/arch/x86/kernel/apic/x2apic_cluster.c     |    1 
 b/arch/x86/kernel/apic/x2apic_phys.c        |    6 
 b/arch/x86/kernel/apic/x2apic_uv_x.c        |   63 +------
 b/arch/x86/kernel/cpu/Makefile              |    5 
 b/arch/x86/kernel/cpu/amd.c                 |  156 ------------------
 b/arch/x86/kernel/cpu/cacheinfo.c           |   51 ++----
 b/arch/x86/kernel/cpu/centaur.c             |    4 
 b/arch/x86/kernel/cpu/common.c              |  108 +-----------
 b/arch/x86/kernel/cpu/cpu.h                 |   14 +
 b/arch/x86/kernel/cpu/debugfs.c             |   98 +++++++++++
 b/arch/x86/kernel/cpu/hygon.c               |  133 ---------------
 b/arch/x86/kernel/cpu/intel.c               |   38 ----
 b/arch/x86/kernel/cpu/mce/amd.c             |    4 
 b/arch/x86/kernel/cpu/mce/apei.c            |    4 
 b/arch/x86/kernel/cpu/mce/core.c            |    4 
 b/arch/x86/kernel/cpu/mce/inject.c          |    7 
 b/arch/x86/kernel/cpu/proc.c                |    8 
 b/arch/x86/kernel/cpu/topology.h            |   51 ++++++
 b/arch/x86/kernel/cpu/topology_amd.c        |  179 +++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_common.c     |  233 ++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_ext.c        |  136 ++++++++++++++++
 b/arch/x86/kernel/cpu/zhaoxin.c             |   18 --
 b/arch/x86/kernel/smpboot.c                 |   64 ++++---
 b/arch/x86/kernel/vsmp_64.c                 |   13 -
 b/arch/x86/mm/amdtopology.c                 |   35 +---
 b/arch/x86/xen/apic.c                       |    8 
 b/drivers/edac/amd64_edac.c                 |    4 
 b/drivers/edac/mce_amd.c                    |    4 
 b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 
 b/drivers/hwmon/fam15h_power.c              |    7 
 b/drivers/scsi/lpfc/lpfc_init.c             |    8 
 b/drivers/virt/acrn/hsm.c                   |    2 
 51 files changed, 964 insertions(+), 881 deletions(-)




