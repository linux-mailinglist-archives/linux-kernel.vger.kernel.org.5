Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAD771CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjHGJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjHGJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:19:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C885E7B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:19:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691399978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=s/zPaS9Z5FLXbNNBcGX5RsYNKU80L6L1pU+cuGQC75s=;
        b=0Co9hz0/oJEiK/ZGH5xWX1TtqD/N4t54kEoeMNL+adKYgg8HzSahcuynNMEB2GwGqCCIiP
        aHf5jJYvzrHVTSBsE9KwqEwkF2MjdW3+KFZmr1Bi/+5rHDTXrmwGx8fHMbKVd1SjCXhBuw
        AiGLI8x09fIUb4pjuAM5n/4xCeKhTCSu8c8i8nseqtoPJdKInNDo7W5mjWCN5gUKAkDT8v
        TryXxDsHI0bUhRJGaKjjFz7g7xbR6wfEM1dlsAMqwgJvg4RiMo+YXWy2aQ89YXEElKWI2n
        jsNFhepV8IJ62fhI94dQsEPJ1+USAMEfIoM5lsMLLFlmQFzZaemNfvUuhzVlJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691399978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=s/zPaS9Z5FLXbNNBcGX5RsYNKU80L6L1pU+cuGQC75s=;
        b=zulpOQEHSPTDDri5elyM+eEkPFHigOFF3+RZX6aKSCfaaxAiIlefgpsGOQ5y+g/lJmBdWV
        v+FcBS/Eqri69EBQ==
To:     Juergen Gross <jgross@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: [BUG] XEN/PV dom0 time management
Date:   Mon, 07 Aug 2023 11:19:38 +0200
Message-ID: <87a5v3us45.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Something in XEN/PV time management seems to be seriously broken:

timekeeping watchdog on CPU9: Marking clocksource 'tsc' as unstable because the skew is too large:
[  152.557154] clocksource:                       'xen' wd_nsec: 511979417 wd_now: 24e4d7625e wd_last: 24c65332c5 mask: ffffffffffffffff
[  152.566197] clocksource:                       'tsc' cs_nsec: 512468734 cs_now: 9a306c9b808c cs_last: 9a302c9e30ba mask: ffffffffffffffff
[  152.572319] clocksource:                       Clocksource 'tsc' skewed 489317 ns (0 ms) over watchdog 'xen' interval of 511979417 ns (511 ms)
[  152.578067] clocksource:                       'tsc' is current clocksource.
[  152.581023] tsc: Marking TSC unstable due to clocksource watchdog
[  152.583751] clocksource: Checking clocksource tsc synchronization from CPU 5 to CPUs 0,3,8,10,12,15.
[  152.590860] clocksource:         CPUs 8 ahead of CPU 5 for clocksource tsc.
[  152.597196] clocksource:         CPU 5 check durations 14197ns - 124761ns for clocksource tsc.
[  152.602675] clocksource: Switched to clocksource xen

This is fully reproducible with variations of the failure report in the
following setup:

  - VM running on KVM on a SKLX machine

  - Debian bookworm install with XEN 4.17

  - Happens with the off the shelf debian 6.1 kernel and with current
    upstream (6.5-rc4)

Why am I convinced that this is a XENPV issue?

Simply because the same kernels booted w/o XEN on the same VM and the
same hardware do not have any issue with using TSC as clocksource. The
TSC on that machine is stable and fully synchronized. The clocksource
watchdog uses kvm-clock to monitor TSC and it never had any complaints.

But with XEN underneath its a matter of minutes after boot to happen. I
tried to make sense out of it, but ran out of steam and patience, so I
decided to report this to the XEN wizards.

Thanks,

        tglx
