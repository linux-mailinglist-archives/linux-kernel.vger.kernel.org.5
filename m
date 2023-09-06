Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95579360B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjIFHSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:18:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B9CFA;
        Wed,  6 Sep 2023 00:18:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF44C433C8;
        Wed,  6 Sep 2023 07:18:14 +0000 (UTC)
Date:   Wed, 6 Sep 2023 09:18:10 +0200
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
Message-ID: <ZPgnslFTlwImJ+Aq@ls3530>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
 <ZPT2cINsHd+sWJQU@ls3530>
 <78473084-d4d5-685f-9778-4bbe8878a43e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78473084-d4d5-685f-9778-4bbe8878a43e@roeck-us.net>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net>:
> On 9/3/23 14:11, Helge Deller wrote:
> > * Guenter Roeck <linux@roeck-us.net>:
> > > Hi,
> > > 
> > > On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
> > > > On the parisc architecture, lockdep reports for all static objects which
> > > > are in the __initdata section (e.g. "setup_done" in devtmpfs,
> > > > "kthreadd_done" in init/main.c) this warning:
> > > > 
> > > > 	INFO: trying to register non-static key.
> > > > 
> > > > The warning itself is wrong, because those objects are in the __initdata
> > > > section, but the section itself is on parisc outside of range from
> > > > _stext to _end, which is why the static_obj() functions returns a wrong
> > > > answer.
> > > > 
> > > > While fixing this issue, I noticed that the whole existing check can
> > > > be simplified a lot.
> > > > Instead of checking against the _stext and _end symbols (which include
> > > > code areas too) just check for the .data and .bss segments (since we check a
> > > > data object). This can be done with the existing is_kernel_core_data()
> > > > macro.
> > > > 
> > > > In addition objects in the __initdata section can be checked with
> > > > init_section_contains().
> > > > 
> > > > This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
> > > > memory detection").
> > > > 
> > > > Tested on x86-64 and parisc.
> > > > 
> > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > > Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
> > > 
> > > On loongarch, this patch results in the following backtrace.
> > > 
> > > EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
> > > EFI stub: Exiting boot services
> > > [    0.000000] INFO: trying to register non-static key.
> > > [    0.000000] The code is fine but needs lockdep annotation, or maybe
> > > [    0.000000] you didn't initialize this object before use?
> > > [    0.000000] turning off the locking correctness validator.
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0+ #1
> > > [    0.000000] Stack : 0000000000000000 0000000000000000 9000000000223d6c 9000000001df0000
> > > [    0.000000]         9000000001df39a0 9000000001df39a8 0000000000000000 0000000000000000
> > > [    0.000000]         9000000001df39a8 0000000000000001 0000000000000000 900000000154b910
> > > [    0.000000]         fffffffffffffffe 9000000001df39a8 0000000000000000 0000000000000000
> > > [    0.000000]         0000000000000001 0000000000000003 0000000000000010 0000000000000030
> > > [    0.000000]         0000000000000063 0000000000000001 0000000000000000 0000000000000000
> > > [    0.000000]         0000000000000000 0000000000000000 9000000001c60650 9000000001e12000
> > > [    0.000000]         0000000000000000 9000000001560bc0 0000000000000000 9000000002ee6000
> > > [    0.000000]         0000000000000000 0000000000000000 9000000000223d84 0000000000000000
> > > [    0.000000]         00000000000000b0 0000000000000004 0000000000000000 0000000000000800
> > > [    0.000000]         ...
> > > [    0.000000] Call Trace:
> > > [    0.000000] [<9000000000223d84>] show_stack+0x5c/0x180
> > > [    0.000000] [<900000000153e0b4>] dump_stack_lvl+0x88/0xd0
> > > [    0.000000] [<90000000002bc548>] register_lock_class+0x768/0x770
> > > [    0.000000] [<90000000002bc710>] __lock_acquire+0xb0/0x2a18
> > > [    0.000000] [<90000000002bba1c>] lock_acquire+0x11c/0x328
> > > [    0.000000] [<9000000000b34a60>] __debug_object_init+0x60/0x244
> > > [    0.000000] [<9000000000337f94>] init_cgroup_housekeeping+0xe8/0x144
> > > [    0.000000] [<900000000033e364>] init_cgroup_root+0x38/0xa0
> > > [    0.000000] [<90000000017801ac>] cgroup_init_early+0x44/0x16c
> > > [    0.000000] [<9000000001770758>] start_kernel+0x50/0x624
> > > [    0.000000] [<90000000015410b4>] kernel_entry+0xb4/0xc4
> > > 
> > > Reverting it fixes the problem. Bisect log attached.
> > > 
> > > This is also seen in v6.5.y and v6.4.y since the patch has been applied
> > > to those branches.
> > 
> > Does this happens with CONFIG_SMP=n ?
> > If so, I think the untested patch below might fix the issue.
> > 
> 
> No, this is loongarch:defconfig with various debug options enabled.
> That has CONFIG_SMP=y.

Could you apply below patch and verify with the contents of the
System.map file where the lock is located ?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..db0a301f9740 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -969,7 +969,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	else {
 		/* Debug-check: all keys must be persistent! */
 		debug_locks_off();
-		pr_err("INFO: trying to register non-static key.\n");
+		pr_err("INFO: trying to register non-static key at %08lx.\n", addr);
 		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
 		pr_err("you didn't initialize this object before use?\n");
 		pr_err("turning off the locking correctness validator.\n");
