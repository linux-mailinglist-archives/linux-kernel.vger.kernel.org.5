Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB08774BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjHHVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHHU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:59:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9935A65
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:57:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691528251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcmwHB0uNjVv/lm6S21elMYEdgLqXoiQ7egkXKs2U4E=;
        b=woZmw7RgImpZPYgKX0LnJW3l71X9T+NmRk1N1liv7gHpyb6ddlwg43SNaccf8W3jW9ziYu
        ekcvBY/dWmH4uEysTSCqqJwq24mwbK+NlCDmeEl4SlSHnPmwbLAphdMwJBxVPznSPliT+G
        bg1t4z/2aJG/WjtzNM9sm6qN5rPkQvxd3u4EXtSYtbR+2vfaHexbDepKcWfj3v068SxoEM
        aqv+8fMULi+vGJpV9SQVsNSX8AOVOaimchs4ha3PApw/pEb2sttP4OAHle2DfM9px5i3et
        bMb2+ktRccCV6IggxN/3pUMF/Zneq+xYXFIwgTpfdv/ri5vW5tU/PGlbJhqWVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691528251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcmwHB0uNjVv/lm6S21elMYEdgLqXoiQ7egkXKs2U4E=;
        b=9FxM7KC3sFc6RAqyrWrDHEcuqk4hQo1c+QKzZv442DDU9WBFFQfQdcoawjW4Rwv10tIA8L
        8sbFoAn7DggnuFDw==
To:     Sohil Mehta <sohil.mehta@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 00/53] x86/topology: The final installment
In-Reply-To: <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com>
Date:   Tue, 08 Aug 2023 22:57:31 +0200
Message-ID: <87bkfhl0as.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 13:30, Sohil Mehta wrote:
> On 8/8/2023 12:10 PM, Thomas Gleixner wrote:

> domain: Thread     shift: 1 dom_size:     2 max_threads:     2
> domain: Core       shift: 5 dom_size:    16 max_threads:    32
> domain: Module     shift: 5 dom_size:     1 max_threads:    32
> domain: Tile       shift: 5 dom_size:     1 max_threads:    32
> domain: Die        shift: 5 dom_size:     1 max_threads:    32
> domain: Package    shift: 5 dom_size:     1 max_threads:    32
>
> CPU 0:
>    0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000000
>    0x0000000b 0x01: eax=0x00000005 ebx=0x00000014 ecx=0x00000201 edx=0x00000000

Ok. So this is consistent.

> Also, I see a warning message that only seems to show up with the final
> installment series applied. I attached the complete dmesg as well (just
> in case):
>
> unchecked MSR access error: WRMSR to 0xe44 (tried to write
> 0x0000000000000003) at rIP: 0xffffffff8d2a6698 (native_write_msr+0x8/0x30)
>  uncore_box_ref.part.0+0xa6/0xe0
>  uncore_event_cpu_online+0x6e/0x1c0
>  ? __pfx_uncore_event_cpu_online+0x10/0x10
>  cpuhp_invoke_callback+0x165/0x4b0

That's probably a consequence of the inconsistency.

> [    0.187210] CPU topo: Register 000 1
> [    0.187211] CPU topo: Register 002 1
> [    0.187212] CPU topo: Register 004 1
> [    0.187213] CPU topo: Register 006 1
> [    0.187214] CPU topo: Register 008 1
> [    0.187215] CPU topo: Register 010 1
> [    0.187216] CPU topo: Register 012 1
> [    0.187217] CPU topo: Register 014 1
> [    0.187218] CPU topo: Register 016 1
> [    0.187219] CPU topo: Register 018 1

The first package (primary threads)

> [    0.187219] CPU topo: Register 020 1
> [    0.187220] CPU topo: Register 022 1
> [    0.187221] CPU topo: Register 024 1
> [    0.187222] CPU topo: Register 026 1
> [    0.187223] CPU topo: Register 028 1
> [    0.187223] CPU topo: Register 030 1
> [    0.187224] CPU topo: Register 032 1
> [    0.187225] CPU topo: Register 034 1
> [    0.187226] CPU topo: Register 036 1
> [    0.187227] CPU topo: Register 038 1

The second package (primary threads)

> [    0.187228] CPU topo: Register 001 1
> [    0.187228] CPU topo: Register 003 1
> [    0.187229] CPU topo: Register 005 1
> [    0.187230] CPU topo: Register 007 1
> [    0.187230] CPU topo: Register 009 1
> [    0.187231] CPU topo: Register 011 1
> [    0.187232] CPU topo: Register 013 1
> [    0.187233] CPU topo: Register 015 1
> [    0.187233] CPU topo: Register 017 1
> [    0.187234] CPU topo: Register 019 1

The second package (secondary threads)

> [    0.187235] CPU topo: Register 021 1
> [    0.187235] CPU topo: Register 023 1
> [    0.187236] CPU topo: Register 025 1
> [    0.187237] CPU topo: Register 027 1
> [    0.187238] CPU topo: Register 029 1
> [    0.187238] CPU topo: Register 031 1
> [    0.187239] CPU topo: Register 033 1
> [    0.187240] CPU topo: Register 035 1
> [    0.187241] CPU topo: Register 037 1
> [    0.187241] CPU topo: Register 039 1

The second package (secondary threads)

> [    0.187244] CPU topo: Register 000 0
> [    0.187244] CPU topo: Register 001 0

... PKG 0

> [    0.187266] CPU topo: Register 01e 0
> [    0.187267] CPU topo: Register 01f 0

Ah. that's indeed the issue which the ACPI patch addresses. So that
table claims that the packages are truly filled up to capacity, i.e. 32
threads. The old code did not notice because they are all marked
non-present, but with the new approach these are rightfully accounted as
pluggable and show up in the bitmaps accordingly. Sigh...

> [    0.187268] CPU topo: Register 020 0
... PKG 1
> [    0.187291] CPU topo: Register 03f 0

> [    0.187292] CPU topo: Register 040 0
... PKG 2
> [    0.187304] CPU topo: Register 05f 0

> [    0.187305] CPU topo: Register 060 0
... PKG 3
> [    0.187335] CPU topo: Register 077 0

This one is funny as it stops at 0x77, i.e 8 CPUs short of the full
range.

So this:

> [    0.187412] CPU topo: Max. logical packages:   4

_IS_ correct according to the above.

I bet that the ACPI patch cures it.

Thanks,

        tglx
