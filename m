Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315B790E1D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjICVL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjICVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A8E5;
        Sun,  3 Sep 2023 14:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF706115C;
        Sun,  3 Sep 2023 21:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582DDC433C8;
        Sun,  3 Sep 2023 21:11:17 +0000 (UTC)
Date:   Sun, 3 Sep 2023 23:11:12 +0200
From:   Helge Deller <deller@gmx.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-parisc@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Message-ID: <ZPT2cINsHd+sWJQU@ls3530>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net>:
> Hi,
> 
> On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
> > On the parisc architecture, lockdep reports for all static objects which
> > are in the __initdata section (e.g. "setup_done" in devtmpfs,
> > "kthreadd_done" in init/main.c) this warning:
> > 
> > 	INFO: trying to register non-static key.
> > 
> > The warning itself is wrong, because those objects are in the __initdata
> > section, but the section itself is on parisc outside of range from
> > _stext to _end, which is why the static_obj() functions returns a wrong
> > answer.
> > 
> > While fixing this issue, I noticed that the whole existing check can
> > be simplified a lot.
> > Instead of checking against the _stext and _end symbols (which include
> > code areas too) just check for the .data and .bss segments (since we check a
> > data object). This can be done with the existing is_kernel_core_data()
> > macro.
> > 
> > In addition objects in the __initdata section can be checked with
> > init_section_contains().
> > 
> > This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
> > memory detection").
> > 
> > Tested on x86-64 and parisc.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
> 
> On loongarch, this patch results in the following backtrace.
> 
> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> EFI stub: Exiting boot services
> [    0.000000] INFO: trying to register non-static key.
> [    0.000000] The code is fine but needs lockdep annotation, or maybe
> [    0.000000] you didn't initialize this object before use?
> [    0.000000] turning off the locking correctness validator.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0+ #1
> [    0.000000] Stack : 0000000000000000 0000000000000000 9000000000223d6c 9000000001df0000
> [    0.000000]         9000000001df39a0 9000000001df39a8 0000000000000000 0000000000000000
> [    0.000000]         9000000001df39a8 0000000000000001 0000000000000000 900000000154b910
> [    0.000000]         fffffffffffffffe 9000000001df39a8 0000000000000000 0000000000000000
> [    0.000000]         0000000000000001 0000000000000003 0000000000000010 0000000000000030
> [    0.000000]         0000000000000063 0000000000000001 0000000000000000 0000000000000000
> [    0.000000]         0000000000000000 0000000000000000 9000000001c60650 9000000001e12000
> [    0.000000]         0000000000000000 9000000001560bc0 0000000000000000 9000000002ee6000
> [    0.000000]         0000000000000000 0000000000000000 9000000000223d84 0000000000000000
> [    0.000000]         00000000000000b0 0000000000000004 0000000000000000 0000000000000800
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<9000000000223d84>] show_stack+0x5c/0x180
> [    0.000000] [<900000000153e0b4>] dump_stack_lvl+0x88/0xd0
> [    0.000000] [<90000000002bc548>] register_lock_class+0x768/0x770
> [    0.000000] [<90000000002bc710>] __lock_acquire+0xb0/0x2a18
> [    0.000000] [<90000000002bba1c>] lock_acquire+0x11c/0x328
> [    0.000000] [<9000000000b34a60>] __debug_object_init+0x60/0x244
> [    0.000000] [<9000000000337f94>] init_cgroup_housekeeping+0xe8/0x144
> [    0.000000] [<900000000033e364>] init_cgroup_root+0x38/0xa0
> [    0.000000] [<90000000017801ac>] cgroup_init_early+0x44/0x16c
> [    0.000000] [<9000000001770758>] start_kernel+0x50/0x624
> [    0.000000] [<90000000015410b4>] kernel_entry+0xb4/0xc4
> 
> Reverting it fixes the problem. Bisect log attached.
> 
> This is also seen in v6.5.y and v6.4.y since the patch has been applied
> to those branches.

Does this happens with CONFIG_SMP=n ?
If so, I think the untested patch below might fix the issue.

Helge

---

[PATCH] loogarch: Keep PERCPU section in init section even for !CONFIG_SMP

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index b1686afcf876..32d61e931cdc 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -99,9 +99,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#ifdef CONFIG_SMP
 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
-#endif
 
 	.init.bss : {
 		*(.init.bss)
