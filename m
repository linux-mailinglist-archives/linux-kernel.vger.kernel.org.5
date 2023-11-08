Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67697E5B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKHQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:33:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17AFC1BE5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:33:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3797C1476;
        Wed,  8 Nov 2023 08:34:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8773F64C;
        Wed,  8 Nov 2023 08:33:46 -0800 (PST)
Date:   Wed, 8 Nov 2023 16:33:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <ZUu4Z8a8dPLfW7Ru@FVFF77S0Q05N>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
> What's broken:
>  - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
>    lazily")
>  - Non-x86 architectures. It's trivial to support other archs (only need
>    to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
>    comments on the series.
>    (From some testing on arm64, didn't find any surprises.)

When you say "testing on arm64, didn't find any surprises", I assume you mean
with an additional patch adding TIF_NEED_RESCHED_LAZY?

Applying this series as-is atop v6.6-rc7 and building defconfig (with GCC
13.2.0) blows up with:

| In file included from ./arch/arm64/include/asm/preempt.h:5,
|                  from ./include/linux/preempt.h:79,
|                  from ./include/linux/spinlock.h:56,
|                  from ./include/linux/mmzone.h:8,
|                  from ./include/linux/gfp.h:7,
|                  from ./include/linux/slab.h:16,
|                  from ./include/linux/resource_ext.h:11,
|                  from ./include/linux/acpi.h:13,
|                  from ./include/acpi/apei.h:9,
|                  from ./include/acpi/ghes.h:5,
|                  from ./include/linux/arm_sdei.h:8,
|                  from arch/arm64/kernel/asm-offsets.c:10:
| ./include/linux/thread_info.h:63:2: error: #error "Arch needs to define TIF_NEED_RESCHED_LAZY"
|    63 | #error "Arch needs to define TIF_NEED_RESCHED_LAZY"
|       |  ^~~~~
| ./include/linux/thread_info.h:66:42: error: 'TIF_NEED_RESCHED_LAZY' undeclared here (not in a function); did you mean 'TIF_NEED_RESCHED'?
|    66 | #define TIF_NEED_RESCHED_LAZY_OFFSET    (TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
|       |                                          ^~~~~~~~~~~~~~~~~~~~~
| ./include/linux/thread_info.h:70:24: note: in expansion of macro 'TIF_NEED_RESCHED_LAZY_OFFSET'
|    70 |         RESCHED_lazy = TIF_NEED_RESCHED_LAZY_OFFSET,
|       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
| make[2]: *** [scripts/Makefile.build:116: arch/arm64/kernel/asm-offsets.s] Error 1
| make[1]: *** [/home/mark/src/linux/Makefile:1202: prepare0] Error 2
| make: *** [Makefile:234: __sub-make] Error 2

Note that since arm64 doesn't use the generic entry code, that also requires
changes to arm64_preempt_schedule_irq() in arch/arm64/kernel/entry-common.c, to
handle TIF_NEED_RESCHED_LAZY.

>  - ftrace support for need-resched-lazy is incomplete

What exactly do we need for ftrace here?

Thanks,
Mark.
