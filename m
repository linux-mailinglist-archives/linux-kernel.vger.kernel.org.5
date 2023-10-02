Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A77B51E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjJBL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbjJBL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4994
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:37 -0700 (PDT)
Message-ID: <20231002115506.217091296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BqEDe5JJULg8F/6J5m2oO/d4LtY3PQFxeMN1+3fdG3U=;
        b=FAZXfmT+pePEX5zHjiWOpGl8tnaiTjgaVMAw3CyzNrjxsSMHxUS4nwkkT5FSI0CnJynf3u
        iZ+xpMbJ/0Yr9Iv9HXoKa02Zx10L3SPq94o7rIWb/e3xb28IHBjdrUCmpeWQxAa+Ff1p6o
        LKjvme5Cm/yZjl0nKf8xeF8X35283O6j5MIZtuewVzegFpgadsw4wG/HZ2wXak/d+FrzG2
        8rYbOPlxW1LtqbDAPFPxTwow36562Ce+i/jH6ZGI251CCcWAvMRplF3XuXv+o1AUs5pDd4
        d+thsKnEZA8USjmDupqcQPdbW/AyvXxn3saQzZ4bfP8VfEeUSrEQjMuAIj0a4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BqEDe5JJULg8F/6J5m2oO/d4LtY3PQFxeMN1+3fdG3U=;
        b=jGr9D+FUWoWUBzWK7H0omKIOSDmDYoy6FRUC6tWUIehzS2cd9Qpeq0Se03/AcZOyQ8U7PG
        HAfoPmmw0DL2/dDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 00/30] x86/microcode: Cleanup and late loading enhancements
Date:   Mon,  2 Oct 2023 13:59:34 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up on:

  https://lore.kernel.org/lkml/20230912065249.695681286@linutronix.de

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

Changes vs. V3:

  - Rebased on v6.6-rc1

  - Remove the early load magic which was required for physical address
    mode from the AMD code.

  - Address the review comments from Borislav, which is mostly naming,
    comments and change logs. No functional changes vs. v3

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v4

Thanks,

	tglx
---
 Documentation/admin-guide/kernel-parameters.txt |    5 
 arch/x86/Kconfig                                |   25 
 arch/x86/include/asm/apic.h                     |    5 
 arch/x86/include/asm/cpu.h                      |   20 
 arch/x86/include/asm/microcode.h                |   19 
 arch/x86/kernel/Makefile                        |    1 
 arch/x86/kernel/apic/apic_flat_64.c             |    2 
 arch/x86/kernel/apic/ipi.c                      |    8 
 arch/x86/kernel/apic/x2apic_cluster.c           |    1 
 arch/x86/kernel/apic/x2apic_phys.c              |    1 
 arch/x86/kernel/cpu/common.c                    |   12 
 arch/x86/kernel/cpu/microcode/amd.c             |  129 +---
 arch/x86/kernel/cpu/microcode/core.c            |  637 ++++++++++++++--------
 arch/x86/kernel/cpu/microcode/intel.c           |  682 +++++++-----------------
 arch/x86/kernel/cpu/microcode/internal.h        |   32 -
 arch/x86/kernel/head32.c                        |    6 
 arch/x86/kernel/head_32.S                       |   10 
 arch/x86/kernel/nmi.c                           |    9 
 arch/x86/kernel/smpboot.c                       |   12 
 drivers/platform/x86/intel/ifs/load.c           |    8 
 include/linux/cpuhotplug.h                      |    1 
 21 files changed, 788 insertions(+), 837 deletions(-)
