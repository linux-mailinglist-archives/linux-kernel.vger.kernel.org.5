Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808AD77A221
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjHLUAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjHLUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636126A0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:59:45 -0700 (PDT)
Message-ID: <20230812194003.682298127@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=XhTCWAaSaABFtHV3wJwp8pDmO/6SxKYptyj7IpWiKQs=;
        b=c3IfV6oZYPeTjgp1nCE43Qk4RPaMg1jOAHL1FjtrNGqD8adxAg80JYbj2fec8/WYTzAo3q
        nEa5bQJ0bk1BJwE0R1nFwdR/4yHPyjP+avPKJTogSxBUm44yx66Tbn+c59AKjljmmNyi+v
        pGSB4k++d1vVRrgzA+pyEn1eknvCAjHqkEcltrlpDzHjZkUX24D8Pa8UNX+8b/sMQ14qaN
        p/bphFSOYZ+6istjzJMsAs3JcX1MYbxYlSUJzbzPrcCzZk0gOftkqkiqMV+Hr/keaLfb/L
        EICuu8ZYsiOZDZDQQrm/vwgYmCdRxYrXB+wuqiRJXQ1S+ofHPfW616YGBjph+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=XhTCWAaSaABFtHV3wJwp8pDmO/6SxKYptyj7IpWiKQs=;
        b=OpGoI8cJD243+8e8QblNgfdatuvSwYlPs/Cj7GGSsyBHw+Dv0iKo/73dU2mAEdzJpO15xa
        XgmKocfkY68akIBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 00/37] x86/microcode: Cleanup and late loading enhancements
Date:   Sat, 12 Aug 2023 21:58:36 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up on:

  https://lore.kernel.org/lkml/20230810153317.850017756@linutronix.de

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

   1) Cleanup core code, header files and Kconfig

   2) Cleanup of the Intel specific code

   3) Implementation of proper core control logic to handle the NMI safe
      requirements

   4) Support for minimal revision check in the core and the Intel specific
      parts.

Thanks to Borislav for discussing this with me and helping out with
testing.  Thanks also to Ashok who contributed a few patches and helped
with testing on the Intel side especially with the new minimal revision
mechanism.

Changes vs. V1:

  - Reordered the queue - Nikolay

  - Fixed the bogus condition - Borislav

  - Moved more structs and defines into the source - Arjan

  - Consolidated the exported functions

  - Cleaned up the core initialization

The series applies on:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

and is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v2

Thanks,

	tglx
---
 arch/x86/include/asm/microcode_amd.h              |   56 -
 arch/x86/include/asm/microcode_intel.h            |   88 --
 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/arch/x86/Kconfig                                |   63 -
 b/arch/x86/include/asm/apic.h                     |    5 
 b/arch/x86/include/asm/cpu.h                      |   20 
 b/arch/x86/include/asm/microcode.h                |  160 +---
 b/arch/x86/kernel/apic/apic_flat_64.c             |    2 
 b/arch/x86/kernel/apic/ipi.c                      |    9 
 b/arch/x86/kernel/apic/x2apic_cluster.c           |    1 
 b/arch/x86/kernel/apic/x2apic_phys.c              |    1 
 b/arch/x86/kernel/cpu/common.c                    |    1 
 b/arch/x86/kernel/cpu/intel.c                     |  176 ----
 b/arch/x86/kernel/cpu/microcode/Makefile          |    4 
 b/arch/x86/kernel/cpu/microcode/amd.c             |   68 +
 b/arch/x86/kernel/cpu/microcode/core.c            |  576 ++++++++++----
 b/arch/x86/kernel/cpu/microcode/intel.c           |  847 ++++++++++------------
 b/arch/x86/kernel/cpu/microcode/internal.h        |  125 +++
 b/arch/x86/kernel/nmi.c                           |    9 
 b/arch/x86/mm/init.c                              |    1 
 b/drivers/platform/x86/intel/ifs/load.c           |   15 
 b/include/linux/cpuhotplug.h                      |    1 
 22 files changed, 1124 insertions(+), 1109 deletions(-)


