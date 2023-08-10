Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6F778057
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjHJSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjHJSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B426BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:28 -0700 (PDT)
Message-ID: <20230810153317.850017756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UokI+w5bD9vUcMSFnaXSpgjbgC5/EVsUA75GVMUW0B8=;
        b=RMvHAUryYhy9kk1EU0Sen3r+3dzOUKpfyznSvzd8W4eJUZhOeQC7U//xhvOywGq2hDvi39
        hBYXZiK77mDXdwu5l93l6TQDZP5xNlENccyVbGIGr4WF9FjGQjVrqo6J6VgxDIgtuknmM2
        C0EjsowMCRmbWDvCaPe/zGmNUK44KujMxEGFyUVAfO7m4spml0DYAI+0dxiGz99zSIWZlL
        kQZQ9h7kx1BXWA67ZAYXXVPxGoyF0dtTVwbw2DYqJvs8rU7GNiVclMCaThctFj1aY27igs
        UUKSgzC2AhvvSGxBCTELQD44pTqcw6lZ9hvG7wbKBAb97BpdmzM1QNhFUyWysA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UokI+w5bD9vUcMSFnaXSpgjbgC5/EVsUA75GVMUW0B8=;
        b=7zQNNfI6ADnT1jQLLzmF3j0FcY/eJNWccLjD0XZvbbCvTMbiV7Ypo/iKY+D8Q810FPt1iA
        nPzIgfMbvY8aspBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 00/30] x86/microcode: Cleanup and late loading enhancements
Date:   Thu, 10 Aug 2023 20:37:26 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

The series applies on:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

and is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v1

Thanks,

	tglx
---
 arch/x86/include/asm/microcode_amd.h              |   56 -
 arch/x86/include/asm/microcode_intel.h            |   88 --
 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/arch/x86/Kconfig                                |   63 -
 b/arch/x86/include/asm/apic.h                     |    5 
 b/arch/x86/include/asm/microcode.h                |  162 +---
 b/arch/x86/kernel/apic/apic_flat_64.c             |    2 
 b/arch/x86/kernel/apic/ipi.c                      |    9 
 b/arch/x86/kernel/apic/x2apic_cluster.c           |    1 
 b/arch/x86/kernel/apic/x2apic_phys.c              |    1 
 b/arch/x86/kernel/cpu/common.c                    |    1 
 b/arch/x86/kernel/cpu/intel.c                     |  176 ----
 b/arch/x86/kernel/cpu/microcode/Makefile          |    4 
 b/arch/x86/kernel/cpu/microcode/amd.c             |   25 
 b/arch/x86/kernel/cpu/microcode/core.c            |  518 +++++++++++---
 b/arch/x86/kernel/cpu/microcode/intel.c           |  807 ++++++++++------------
 b/arch/x86/kernel/cpu/microcode/internal.h        |  190 +++++
 b/arch/x86/kernel/nmi.c                           |    9 
 b/arch/x86/mm/init.c                              |    1 
 b/drivers/platform/x86/intel/ifs/load.c           |    4 
 20 files changed, 1109 insertions(+), 1018 deletions(-)


