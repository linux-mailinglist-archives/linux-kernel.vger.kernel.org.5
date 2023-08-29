Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43778C9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjH2QnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbjH2Qm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:42:57 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8A19A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:42:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c79b:b256:edee:805c])
        by laurent.telenet-ops.be with bizsmtp
        id fUio2A00927hkyq01UioRU; Tue, 29 Aug 2023 18:42:50 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qb1nk-002041-8E;
        Tue, 29 Aug 2023 18:42:48 +0200
Date:   Tue, 29 Aug 2023 18:42:48 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <20230819004356.1454718-2-Liam.Howlett@oracle.com>
Message-ID: <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com> <20230819004356.1454718-2-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Liam,

On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> The current implementation of append may cause duplicate data and/or
> incorrect ranges to be returned to a reader during an update.  Although
> this has not been reported or seen, disable the append write operation
> while the tree is in rcu mode out of an abundance of caution.
>
> During the analysis of the mas_next_slot() the following was
> artificially created by separating the writer and reader code:
>
> Writer:                                 reader:
> mas_wr_append
>    set end pivot
>    updates end metata
>    Detects write to last slot
>    last slot write is to start of slot
>    store current contents in slot
>    overwrite old end pivot
>                                        mas_next_slot():
>                                                read end metadata
>                                                read old end pivot
>                                                return with incorrect range
>    store new value
>
> Alternatively:
>
> Writer:                                 reader:
> mas_wr_append
>    set end pivot
>    updates end metata
>    Detects write to last slot
>    last lost write to end of slot
>    store value
>                                        mas_next_slot():
>                                                read end metadata
>                                                read old end pivot
>                                                read new end pivot
>                                                return with incorrect range
>    set old end pivot
>
> There may be other accesses that are not safe since we are now updating
> both metadata and pointers, so disabling append if there could be rcu
> readers is the safest action.
>
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
("maple_tree: disable mas_wr_append() when other readers are
possible") in v6.5, and is being backported to stable.

On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
following warning:

      clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
      sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
      /soc/timer@e803b000: used for clocksource
      /soc/timer@e803c000: used for clock events
     +------------[ cut here ]------------
     +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
     +Interrupts were enabled early
     +CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rza2mevb-10197-g99b80d6b92b5 #237
     +Hardware name: Generic R7S9210 (Flattened Device Tree)
     + unwind_backtrace from show_stack+0x10/0x14
     + show_stack from dump_stack_lvl+0x24/0x3c
     + dump_stack_lvl from __warn+0x74/0xb8
     + __warn from warn_slowpath_fmt+0x78/0xb0
     + warn_slowpath_fmt from start_kernel+0x2f0/0x480
     + start_kernel from 0x0
     +---[ end trace 0000000000000000 ]---
      Console: colour dummy device 80x30
      printk: console [tty0] enabled
      Calibrating delay loop (skipped) preset value.. 1056.00 BogoMIPS (lpj=5280000)

Reverting this commit fixes the issue.

RCU-related configs:

     $ grep RCU .config
     # RCU Subsystem
     CONFIG_TINY_RCU=y
     # CONFIG_RCU_EXPERT is not set
     CONFIG_TINY_SRCU=y
     # end of RCU Subsystem
     # RCU Debugging
     # CONFIG_RCU_SCALE_TEST is not set
     # CONFIG_RCU_TORTURE_TEST is not set
     # CONFIG_RCU_REF_SCALE_TEST is not set
     # CONFIG_RCU_TRACE is not set
     # CONFIG_RCU_EQS_DEBUG is not set
     # end of RCU Debugging

CONFIG_MAPLE_RCU_DISABLED is not defined (and should BTW be renamed,
as CONFIG_* is reserved for kernel configuration options).

I do not see this issue on any other platform
(arm/arm64/risc-v/mips/sh/m68k), several of them use the same
RCU configuration.

Do you have a clue?
Thanks!

> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4107,6 +4107,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>  * mas_wr_append: Attempt to append
>  * @wr_mas: the maple write state
>  *
> + * This is currently unsafe in rcu mode since the end of the node may be cached
> + * by readers while the node contents may be updated which could result in
> + * inaccurate information.
> + *
>  * Return: True if appended, false otherwise
>  */
> static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
> @@ -4116,6 +4120,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
> 	struct ma_state *mas = wr_mas->mas;
> 	unsigned char node_pivots = mt_pivots[wr_mas->type];
>
> +	if (mt_in_rcu(mas->tree))
> +		return false;
> +
> 	if (mas->offset != wr_mas->node_end)
> 		return false;
>
> -- 
> 2.39.2

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
