Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D675704B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGQXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGQXOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE3EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:37 -0700 (PDT)
Message-ID: <20230717223049.327865981@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5/aEfz8FwQW/WscwUpCcmnMqu/tdZBfYnArirN78Lzw=;
        b=n2msV8E0Do+6NbcpwA/iqMrBe9DM7U1OzOlRb9LDfOD2+NQ1vBhQNQovUfMzDImOy8cGx7
        Dw4T/0wb8nIugrVgFFctq4ybCghamYUdQd0//9srtHPdXSk8BhhBMdbNFhzvBvaq6sKows
        cW9iP8ylnod3BAOmvoSMNybxwj/6aWIEwn1p1uFgRs0wEFhAfg0Zmu9E1t096z/oBe1ZRX
        ILorgydRTe1vaRoW6LrkQw+YV7iq6QSBaMakYEPeYS80VIgYB1I/MT02KUwaoTggFASIpc
        YCNFlqlRf2WNSXNh5nG3SKCsdarbV6H4v0iXFNrgqHAcCu5srO1OT+HBRui8dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5/aEfz8FwQW/WscwUpCcmnMqu/tdZBfYnArirN78Lzw=;
        b=OSNU4HKYIwcUS4bPJmVb2ZpIdapR6YLwbTHH4YRQp+bnVGLcGl+djFgmZ26lPZXVdJh8+Y
        61J7dzRIL4zB1RCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 00/58] x86/apic: Decrapification and static calls
Date:   Tue, 18 Jul 2023 01:14:33 +0200 (CEST)
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

While working on a sane topology evaluation mechanism, which addresses the
short-comings of the existing tragedy held together with duct-tape and
hay-wire, I ran into the issue that quite some of this tragedy is deeply
embedded in the APIC code and uses an impenetrable maze of callbacks which
might or might not be correct at the point where the CPUs are registered
via MPPARSE or ACPI/MADT.

This made me look deeper and the findings were anything but pretty.
Redundant per CPU variables, completely unused code, needless complexity
all over the place. The most amazing gem was:

	   physid_mask_t tmp;  	    // 32bytes on stack

	   apic->magic(&tmp, bit);  // Zeros tmp and sets bit
	   physids_or(real_map, real_map, tmp);

Definitely hard to come up with a more complex way of setting a bit in a
bitmap. Followed suit by the evaluation of the boot cpu APIC ID which
consists of more hacks than sensible code.

So I stopped working on the topology stuff and decided to do an overhaul of
the APIC code first. Cleaning up old gunk which dates back to the early SMP
days, making the CPU registration halfways understandable and then going
through all APIC callbacks to figure out what they actually do and whether
they are required at all. There is also quite some overhead through the
indirect calls and some of them are actually even pointlessly indirected
twice. At some point Peter yelled static_call() at me and that's what I
finally ended up implementing.

This builds and boots on 32bit and 64bit, but obviously needs a larger test
base especially on those old 32bit systems which are just museum pieces.

I have neither evaluated whether this has a measurable impact, but that's
something I leave to the perfomance teams. Definitely less indirect calls
in hotpaths are a win by definition.

Talking about those museums pieces and the related historic maze, I really
have to bring up the question again, whether we should finally kill support
for the museum CPUs and move on.

Ideally we remove 32bit support alltogether. I know the answer... :(

But what I really want to do is to make x86 SMP only. The amount of
#ifdeffery and hacks to keep the UP support alive is amazing. And we do this
just for the sake that it runs on some 25+ years old hardware for absolutely
zero value. It'd be not the first architecture to go SMP=y.

Yes, we "support" Alpha, PARISC, Itanic and other oddballs too, but that's
completely different. They are not getting new hardware every other day and
the main impact on the kernel as a whole is mostly static. They are
sometimes in the way of generalizing things in the core code. Other than
that their architecture code is self contained and they can tinker on it as
they see fit or let it slowly bitrot like Itanic.

But x86 is (still) alive and being extended and expanded. That means that
any refactoring of common infrastructure has to take the broken hardware
museum into account. It's doable, but it's not pretty and of really
questionable value. I wouldn't mind if there were a bunch of museum
attendants actively working on it with taste, but that's obviously wishful
thinking. We are even short of people with taste who work on contemporary
hardware support...

While I cursed myself at some point during this work for having merged
i386/x86_64 back then, I still think that it was the correct decision at
that point in time and saved us a lot of trouble. It admittedly added some
trouble which we would not have now, but it avoided the insanity of having
to maintain two trees with different bugs and "fixes" for the very same
problems. TBH quite some of the horrors which I just removed came out of
the x86/64 side. The oddballs of i386 early SMP support are a horror on
their own of course.

As we made that decision more than 15 years [!] ago, it's about time to make
new decisions.

Vented enough.

I'm sure that I broke things on the way, but we can't just continue with
the current mess and add duct tape over hay-wire over duct-tape over
hay-wire forever. At some point we need to bite the bullet and get rid
of the historical nonsense even if it's painful. That point is now.

So 58 patches and a lot of cursing later:

 58 files changed, 744 insertions(+), 1348 deletions(-)

Despite adding the new static call mechanics this endeavour deletes 600
lines of hilarities. There are more of those, but they need to be addressed
separately. Quite some of them in course of the topology evaluation rework,
which so far sports a negative diffstat too.

Now I need a break and a stiff drink to get rid of the bad taste and the
nightmares caused by this.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/apic

Thanks,

	tglx
---
 hyperv/hv_apic.c             |   26 +-
 hyperv/hv_init.c             |    2 
 hyperv/hv_spinlock.c         |    2 
 hyperv/hv_vtl.c              |    2 
 include/asm/apic.h           |  250 +++++++++++++----------
 include/asm/io_apic.h        |    7 
 include/asm/mpspec.h         |   28 --
 include/asm/processor.h      |    1 
 include/asm/smp.h            |   11 -
 kernel/acpi/boot.c           |   12 -
 kernel/apic/Makefile         |    2 
 kernel/apic/apic.c           |  453 +++++++++++++------------------------------
 kernel/apic/apic_common.c    |   21 +
 kernel/apic/apic_flat_64.c   |   80 +------
 kernel/apic/apic_noop.c      |   91 +-------
 kernel/apic/apic_numachip.c  |   50 ----
 kernel/apic/bigsmp_32.c      |   89 +-------
 kernel/apic/hw_nmi.c         |    4 
 kernel/apic/init.c           |  101 +++++++++
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
 kernel/kvm.c                 |   12 -
 kernel/mpparse.c             |    6 
 kernel/nmi_selftest.c        |    2 
 kernel/setup.c               |    6 
 kernel/setup_percpu.c        |   10 
 kernel/sev.c                 |    2 
 kernel/smp.c                 |   10 
 kernel/smpboot.c             |  115 ----------
 kernel/vsmp_64.c             |    2 
 kvm/vmx/posted_intr.c        |    2 
 kvm/vmx/vmx.c                |    2 
 mm/srat.c                    |    5 
 pci/xen.c                    |    2 
 platform/uv/uv_nmi.c         |    2 
 xen/apic.c                   |   76 ++-----
 xen/enlighten_hvm.c          |    2 
 xen/smp_pv.c                 |    2 
 58 files changed, 744 insertions(+), 1348 deletions(-)

