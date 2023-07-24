Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE02D75F855
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjGXNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FAD90
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:48 -0700 (PDT)
Message-ID: <20230724131206.500814398@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Ne+FRgh1C9oYdBRFkjIzJHYBCNMifQqV8MKwhsJbB38=;
        b=oEKbzwro2s++ARFT9bx7tld425W+cuRvpJE9b9S+Ki/cQvmBOY6zesGHs+KonRPMiBWhBG
        TselefkABqVUsK5X0e7V5GCJApYmCiZoN6QF9lZD5c+Q11YDiPknI3DEXzUT3cU0gpdJU7
        BDqdPMt7uhXmO3iiBh6Adgw53jTSVXyGN/cwQkz5xB1ldocY6nQUnPIIVnnQ0iO/BlmxJS
        iWycOemnCuev+vvuWaILjPO+sjYmUbR+Lqqg2/ct457K+XHeMZHOwCMF4D0b4LddZms9Qo
        KPU9BugTPwJKRFrpE2nsPKs6zUCDMbAihL3Oyja+OvprBTAfHUoDT21Cj+fnnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Ne+FRgh1C9oYdBRFkjIzJHYBCNMifQqV8MKwhsJbB38=;
        b=e8w1BBoqOmy5n9LJS8L7h0NcXHQrtnsz153l/NQb4MmzIcIKlIP/irv7hGim5FCsARo50X
        tT3DF32kbae4LXBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 00/58] x86/apic: Decrapification and static calls
Date:   Mon, 24 Jul 2023 15:33:44 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the follow up to:

  https://lore.kernel.org/lkml/20230717223049.327865981@linutronix.de

which addresses the review feedback and some minor 0day-robot fallout.

TLDR: This cleans up accrued and partially unused gunk in order to convert
the APIC callbacks to static calls.

The changes vs. V1:

  - Fixed the minor fallout reported by Michael and Peter

  - Mopped up XEN/PV even more - Juergen

  - Fixed up a place which still wrote into mp_lapic_addr directly in
    mpparse

  - Addressed 0day fallout on 32bit with KVM guest enabled and local APIC
    disabled. Sigh!

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git apic-static-call-v2

Thanks,

	tglx
---
 hyperv/hv_apic.c             |   26 +-
 hyperv/hv_init.c             |    2 
 hyperv/hv_spinlock.c         |    2 
 hyperv/hv_vtl.c              |    2 
 include/asm/apic.h           |  239 +++++++++++++---------
 include/asm/io_apic.h        |    7 
 include/asm/mpspec.h         |   31 --
 include/asm/processor.h      |    1 
 include/asm/smp.h            |   11 -
 kernel/acpi/boot.c           |   12 -
 kernel/apic/Makefile         |    2 
 kernel/apic/apic.c           |  454 +++++++++++++------------------------------
 kernel/apic/apic_common.c    |   21 +
 kernel/apic/apic_flat_64.c   |   80 +------
 kernel/apic/apic_noop.c      |   91 +-------
 kernel/apic/apic_numachip.c  |   50 ----
 kernel/apic/bigsmp_32.c      |   89 +-------
 kernel/apic/hw_nmi.c         |    4 
 kernel/apic/init.c           |  110 ++++++++++
 kernel/apic/io_apic.c        |   30 +-
 kernel/apic/ipi.c            |  176 +++++++---------
 kernel/apic/local.h          |   30 ++
 kernel/apic/msi.c            |    2 
 kernel/apic/probe_32.c       |  117 ++---------
 kernel/apic/probe_64.c       |   18 -
 kernel/apic/vector.c         |   16 -
 kernel/apic/x2apic_cluster.c |   23 --
 kernel/apic/x2apic_phys.c    |   74 ++-----
 kernel/apic/x2apic_uv_x.c    |   51 ----
 kernel/cpu/acrn.c            |    2 
 kernel/cpu/amd.c             |    2 
 kernel/cpu/common.c          |    2 
 kernel/cpu/hygon.c           |    3 
 kernel/cpu/mce/amd.c         |    2 
 kernel/cpu/mce/inject.c      |    3 
 kernel/cpu/mce/threshold.c   |    2 
 kernel/cpu/mshyperv.c        |    4 
 kernel/devicetree.c          |   21 -
 kernel/irq.c                 |   14 -
 kernel/irq_work.c            |    4 
 kernel/jailhouse.c           |    6 
 kernel/kvm.c                 |   14 -
 kernel/mpparse.c             |   17 -
 kernel/nmi_selftest.c        |    2 
 kernel/setup.c               |    7 
 kernel/setup_percpu.c        |   10 
 kernel/sev.c                 |    4 
 kernel/smp.c                 |   10 
 kernel/smpboot.c             |  115 ----------
 kernel/vsmp_64.c             |    2 
 kvm/vmx/posted_intr.c        |    2 
 kvm/vmx/vmx.c                |    2 
 mm/srat.c                    |    5 
 pci/xen.c                    |    2 
 platform/uv/uv_nmi.c         |    2 
 xen/apic.c                   |   78 ++-----
 xen/enlighten_hvm.c          |    2 
 xen/smp_pv.c                 |    2 
 58 files changed, 753 insertions(+), 1359 deletions(-)


