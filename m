Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7131B766C90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjG1MMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjG1MMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB312686;
        Fri, 28 Jul 2023 05:12:45 -0700 (PDT)
Message-ID: <20230728105650.565799744@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kpBOwKlqwb1XdE53agPQsThLBD7jSLVlQL/AIwN2igI=;
        b=kvJ2NkMsyvOj8sVkvCyve2x/YId5ocoexRSrji+7SZojTI499+iG8CIChuyiIoSe/xiNZZ
        91wcgfwfsgoHi4XXd4Tvl9Kz6CsgXN9ORdo+PQMSmJCwyBI8So41UVLPq+a+rKxKgUzmNz
        s/xnYlgrDlOVapxHqDF37YdcDpQnjff3+EcEU9ZyJQVSGIvKXOQUf6PMXNCVk6RRy7tt8O
        rJ8tYVlcxbY2QgP0VTXMTn16Pz0WGIFxz9GhtT1njktRB/dgvLBgf4ERcwT7GI0dZ7yHZH
        AUovWsEneeCS258Y/4H3uD+UdKRbj3tm3WwROhI6hA67IVkaM5fv8jEkrj+SLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kpBOwKlqwb1XdE53agPQsThLBD7jSLVlQL/AIwN2igI=;
        b=9zjv0UN9a0emaZKnIwSq3lSkXNicjb7rqmDR0H+3o6ud5iQkkJwhHFpST3atW2GLL9Z5BK
        QCvax6mVtSnwzlBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 00/38] x86/cpu: Rework the topology evaluation
Date:   Fri, 28 Jul 2023 14:12:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the follow up to V1:

  https://lore.kernel.org/lkml/20230724155329.474037902@linutronix.de

which addresses the review feedback and some minor fallout I observed in my
testing of the work based on top.

TLDR:

This reworks the way how topology information is evaluated via CPUID
in preparation for a larger topology management overhaul to address
shortcomings of the current code vs. hybrid systems and systems which make
use of the extended topology domains in leaf 0x1f. Aside of that it's an
overdue spring cleaning to get rid of accumulated layers of duct tape and
haywire.

What changed vs. V1:

  - Fixed an issue vs. the logical die/pkg management as the current
    code (ab)uses cpuinfo for persistant storage.

  - Consolidated APIC ID usage on u32 and ditched the u16 limitation

  - Addressed the review feedback from Peter and Arjan

  - Added a new patch which gets rid of XENPV fiddling in the cpuinfo
    state. That needs some testing on XENPV obviously. The relevant
    patches are #22 and #37

I did not pick up any of the tested by tags yet. I hope people can run it
once more. Neither did I add the Ack from Peter.

The series is based on the APIC cleanup series:

  https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de

and also available on top of that from git:

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v2

Thanks,

	tglx
---
 Documentation/arch/x86/topology.rst       |   12 -
 a/arch/x86/kernel/cpu/topology.c          |  168 ---------------------
 arch/x86/events/amd/core.c                |    2 
 arch/x86/events/amd/uncore.c              |    2 
 arch/x86/events/intel/uncore.c            |    2 
 arch/x86/hyperv/hv_vtl.c                  |    2 
 arch/x86/include/asm/apic.h               |   32 +---
 arch/x86/include/asm/cacheinfo.h          |    3 
 arch/x86/include/asm/cpuid.h              |   32 ++++
 arch/x86/include/asm/mpspec.h             |    2 
 arch/x86/include/asm/processor.h          |   60 +++++--
 arch/x86/include/asm/smp.h                |    4 
 arch/x86/include/asm/topology.h           |   51 +++++-
 arch/x86/include/asm/x86_init.h           |    2 
 arch/x86/kernel/acpi/boot.c               |    4 
 arch/x86/kernel/amd_nb.c                  |    8 -
 arch/x86/kernel/apic/apic.c               |   14 -
 arch/x86/kernel/apic/apic_common.c        |    4 
 arch/x86/kernel/apic/apic_flat_64.c       |   13 -
 arch/x86/kernel/apic/apic_noop.c          |    9 -
 arch/x86/kernel/apic/apic_numachip.c      |   21 --
 arch/x86/kernel/apic/bigsmp_32.c          |   10 -
 arch/x86/kernel/apic/local.h              |    6 
 arch/x86/kernel/apic/probe_32.c           |   10 -
 arch/x86/kernel/apic/x2apic_cluster.c     |    1 
 arch/x86/kernel/apic/x2apic_phys.c        |   10 -
 arch/x86/kernel/apic/x2apic_uv_x.c        |   67 +-------
 arch/x86/kernel/cpu/Makefile              |    5 
 arch/x86/kernel/cpu/amd.c                 |  156 --------------------
 arch/x86/kernel/cpu/cacheinfo.c           |   51 ++----
 arch/x86/kernel/cpu/centaur.c             |    4 
 arch/x86/kernel/cpu/common.c              |  111 +-------------
 arch/x86/kernel/cpu/cpu.h                 |   14 +
 arch/x86/kernel/cpu/hygon.c               |  133 -----------------
 arch/x86/kernel/cpu/intel.c               |   38 ----
 arch/x86/kernel/cpu/mce/amd.c             |    4 
 arch/x86/kernel/cpu/mce/apei.c            |    4 
 arch/x86/kernel/cpu/mce/core.c            |    4 
 arch/x86/kernel/cpu/mce/inject.c          |    7 
 arch/x86/kernel/cpu/proc.c                |    8 -
 arch/x86/kernel/cpu/zhaoxin.c             |   18 --
 arch/x86/kernel/kvm.c                     |    6 
 arch/x86/kernel/sev.c                     |    2 
 arch/x86/kernel/smpboot.c                 |   97 +++++++-----
 arch/x86/kernel/vsmp_64.c                 |   13 -
 arch/x86/mm/amdtopology.c                 |   35 ++--
 arch/x86/mm/numa.c                        |    4 
 arch/x86/xen/apic.c                       |   14 -
 arch/x86/xen/smp_pv.c                     |    3 
 b/arch/x86/kernel/cpu/debugfs.c           |   97 ++++++++++++
 b/arch/x86/kernel/cpu/topology.h          |   51 ++++++
 b/arch/x86/kernel/cpu/topology_amd.c      |  179 +++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_common.c   |  233 ++++++++++++++++++++++++++++++
 b/arch/x86/kernel/cpu/topology_ext.c      |  136 +++++++++++++++++
 drivers/edac/amd64_edac.c                 |    4 
 drivers/edac/mce_amd.c                    |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2 
 drivers/hwmon/fam15h_power.c              |    7 
 drivers/scsi/lpfc/lpfc_init.c             |    8 -
 drivers/virt/acrn/hsm.c                   |    2 
 60 files changed, 1049 insertions(+), 956 deletions(-)

