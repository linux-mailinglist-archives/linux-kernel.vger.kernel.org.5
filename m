Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4A79C8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjILH5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjILH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:57:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6426310C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:45 -0700 (PDT)
Message-ID: <20230912065249.695681286@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=AJw1wx6YPuzaZhvYGTfk54O9w+U0r7o+iwnk/Je3HJs=;
        b=IOD0lYYwGmgzv3nD4SUAMPlshas3CHBw0PElNpSBV0G/pJL/FeV1R8/Cfxk78uvibLQQUE
        4kbrcUvzwpgS2hWqbEDgpDb8OpUkjD+QAOyIk9d8a1ilty6z1R37Q0jn2mCEIYiWUybMaz
        s/1XHE4PVQSl3U8pJuHFNpvz3O1dTxc0BKd1H4NF1FcZuYN3z7mUjF5aC+wItlYnGA7kfP
        gjdhsxsvAruGrf/1QVPvaocokP04EdOBEqAS0PrxzpYl3R88dGcHCVwjqno5QWeCDgEKed
        lAsaDw7gjF0eTu1wi+p0MR+/CtfABsv34PyHu7mC84KQUutLiheFsUw6FvZI1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=AJw1wx6YPuzaZhvYGTfk54O9w+U0r7o+iwnk/Je3HJs=;
        b=QsEQK975y5S1rul1ukUb6TKuSlENYV0iOnMCxQZf4vQoooPb90SaKQjrIEEGVzLwQeK0P0
        88jgn0Fxuh4MR6CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 00/30] x86/microcode: Cleanup and late loading enhancements
Date:   Tue, 12 Sep 2023 09:57:43 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up on:

  https://lore.kernel.org/lkml/20230812194003.682298127@linutronix.de

Late microcode loading is desired by enterprise users. Late loading is
problematic as it requires detailed knowledge about the change and an
analysis whether this change modifies something which is already in use by
the kernel. Large enterprise customers have engineering teams and access to
deep technical vendor support. The regular admin does not have such
resources, so the kernel has always tainted the kernel after late loading.

Intel recently added a new previously reserved field to the microcode
header which contains the minimal microcode revision which must be running
on the CPU to make the load safe. This field is 0 in all older microcode
revisions, which the kernel assumes to be unsafe. Minimal revision checking
can be enforced via Kconfig or kernel command line. It then refuses to load
an unsafe revision. The default loads unsafe revisions like before and
taints the kernel. If a safe revision is loaded the kernel is not tainted.

But that does not solve all other known problems with late loading:

    - Late loading on current Intel CPUs is unsafe vs. NMI when
      hyperthreading is enabled. If a NMI hits the secondary sibling while
      the primary loads the microcode, the machine can crash.

    - Soft offline SMT siblings which are playing dead with MWAIT can cause
      damage too when the microcode update modifies MWAIT. That's a
      realistic scenario in the context of 'nosmt' mitigations. :(

Neither the core code nor the Intel specific code handles any of this at all.

While trying to implement this, I stumbled over disfunctional, horribly
complex and redundant code, which I decided to clean up first so the new
functionality can be added on a clean slate.

So the series has several sections:

   1) Move the 32bit early loading after paging enable

   2) Cleanup of the Intel specific code

   3) Implementation of proper core control logic to handle the NMI safe
      requirements

   4) Support for minimal revision check in the core and the Intel specific
      parts.

Changes vs. V2:

  - Rebased on v6.5-rc1

  - Removed the 32bit oddity of invoking the microcode loader before
    paging is enabled.

  - Some minor improvements.

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v3

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |    5 
 arch/x86/Kconfig                                |   25 
 arch/x86/include/asm/apic.h                     |    5 
 arch/x86/include/asm/cpu.h                      |   20 
 arch/x86/include/asm/microcode.h                |   16 
 arch/x86/kernel/Makefile                        |    1 
 arch/x86/kernel/apic/apic_flat_64.c             |    2 
 arch/x86/kernel/apic/ipi.c                      |    8 
 arch/x86/kernel/apic/x2apic_cluster.c           |    1 
 arch/x86/kernel/apic/x2apic_phys.c              |    1 
 arch/x86/kernel/cpu/common.c                    |   12 
 arch/x86/kernel/cpu/microcode/amd.c             |   57 --
 arch/x86/kernel/cpu/microcode/core.c            |  643 +++++++++++++++--------
 arch/x86/kernel/cpu/microcode/intel.c           |  659 ++++++------------------
 arch/x86/kernel/cpu/microcode/internal.h        |   32 -
 arch/x86/kernel/head32.c                        |    6 
 arch/x86/kernel/head_32.S                       |   10 
 arch/x86/kernel/nmi.c                           |    9 
 arch/x86/kernel/smpboot.c                       |   12 
 drivers/platform/x86/intel/ifs/load.c           |    8 
 include/linux/cpuhotplug.h                      |    1 
 21 files changed, 740 insertions(+), 793 deletions(-)

