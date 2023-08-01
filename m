Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF90E76C055
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjHAWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHAWWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:22:04 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98AE57;
        Tue,  1 Aug 2023 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9sTrFCHQqWsza2xTzSry7AISymqFb586BwMoopODqTU=; b=BVkHkqnWEK4FNAwvIBJf5ufwXi
        QF7C6aykpiOfX7QSxPfR1ZlWV4pHZxxAJ54mpYgpLZgd1KvX6mGJfOzZ+r5r8LBJyF35HPjUErlcM
        z/9yl+/G70XV8ot4WelJ311yClB9QvnqHcLtTwGEmlIYAG/FO/3iTP7XL4VEpBJufbBXzRUsmhhlz
        UI1PV5NHjVXzFAB7GSxrzx1nSOo/2QSdydbNb8BfImyaOuk7zHDyK8T6tlbhxFQERNCQ601JwIahI
        r1qyDV8jZQKDkguXCY4zn93bjGdKAhBdOH8Af/uLeQETRvBDzx+TT7R22U4rBX10mUj2ww0kOO8lL
        FP8oMNfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45596)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQxkR-0004eF-1Q;
        Tue, 01 Aug 2023 23:21:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQxkO-00014y-La; Tue, 01 Aug 2023 23:21:44 +0100
Date:   Tue, 1 Aug 2023 23:21:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
Message-ID: <ZMmFeCBxhJOxZ575@shell.armlinux.org.uk>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:10:24AM +0200, Rafał Miłecki wrote:
> Hi,
> 
> Years ago I added support for Broadcom's BCM53573 SoCs. We released
> firmwares based on Linux 4.4 (and later on 4.14) that worked almost
> fine. There was one little issue we couldn't debug or fix: random hangs
> and reboots. They were too rare to deal with (most devices worked fine
> for weeks or months).
> 
> Recently I updated my stable kernel 5.4 and I started experiencing
> stability issues on my own! After some uptime (usually from 0 to 20
> minutes of close to zero activity) serial console hangs. I can't type
> anything and I stop getting any messages. I've to wait about a minute
> for watchdog to kick in and reboot device.
> 
> #####
> 
> I took that great chance and decided to track the regression.
> 
> Linux 5.4 stable branch worked stable up to the release v5.4.197.
> Starting with v5.4.198 I started experiencing those stability issues. I
> bisected it down to the commit 4460066eb248 ("ipv6: fix locking issues
> with loops over idev->addr_list"):
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4460066eb2480b9e203c73755e12e2efc820a27e
> 
> With above commit reverted I was able to use stable 5.4 branch up to the
> release v5.4.207. Starting with v5.4.208 it got unstable again. I
> bisected it down to:
> commit d0d583484d2e ("locking/refcount: Consolidate implementations of
> refcount_t")
> commit dab787c73f6e ("locking/refcount: Consolidate
> REFCOUNT_{MAX,SATURATED} definitions")
> commit 0d3182fbe689 ("locking/refcount: Move saturation warnings out of line")
> commit 809554147d60 ("locking/refcount: Improve performance of generic
> REFCOUNT_FULL code")
> commit 9c9269977f03 ("locking/refcount: Move the bulk of the
> REFCOUNT_FULL implementation into the <linux/refcount.h> header")
> commit 04bff7d7b808 ("locking/refcount: Remove unused
> refcount_*_checked() variants")
> commit 513b19a43bec ("locking/refcount: Ensure integer operands are
> treated as signed")
> commit 68b4ee68e8c8 ("locking/refcount: Define constants for
> saturation and max refcount values")
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=d0d583484d2ed9f5903edbbfa7e2a68f78b950b0
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=dab787c73f6e38d8e7ed3c1e683385e8f0fe28a2
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=0d3182fbe689e3808c03b6cde6be98237f9e0a4a
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=809554147d609163cfbaf815c443c575b538a7ef
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=9c9269977f03ab9c448c8b71581a951e0eb4fb7b
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=04bff7d7b8081c4bb2e8171be31d33df297eee5b
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=513b19a43becee5f7af6d283bb9d3d241a8a21a8
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=68b4ee68e8c8800cf8d6b61cc74b4031a0742a4c
> (I didn't actually check above commits individually).
> 
> Reverting above locking/refcount commits worked fine for few releases:
> up to the v5.4.219. Starting with v5.4.220 I got hangs again. I bisected
> that down to the commit 131287ff833d ("once: add DO_ONCE_SLOW() for
> sleepable contexts").
> 
> Reverting that extra commit from v5.4.238 allows me to run Linux for
> hours again (currently 3 devices x 6 hours and counting). So I need in
> total 10+1 reverts from 5.4 branch to get a stable kernel.
> 
> #####
> 
> I'm clueless at this point. Is that possible kernel has some locking bug
> I can hit only using this specific SoC? BCM53573s have a single ARM
> Cortex-A7 CPU running at 900 MHz. The only unusual thing about this hw I
> can think of is a slow arch timer running at 36,8 kHz.
> 
> I tried compiling kernel with:
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_WQ_WATCHDOG=y
> but it didn't change or report anything.
> 
> Unfortunately enabling *any* of following options:
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> seems to make locksup/hangs go away. I tried for few hours.
> 
> Sadly I don't have access to JTAG or any low level debugging interface.
> 
> Does looking at commits I reported above give anyone a hint on what may
> be going on maybe?

If you suspect locking issues, make sure you have lockdep enabled which
will detect locking errors. You will want CONFIG_PROVE_LOCKING enabled.

I will say that I use IPv6, and I run 32-bit kernels here both on real
ARMv7 hardware (Armada 388 and iMX6 based stuff) and also in KVM based
VMs, and these have run virtually every release of the kernel (not
stable kernels though) and I haven't ever seen the behaviour that you
describe.

If it is specific to stable kernels, then that would be rather
disappointing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
