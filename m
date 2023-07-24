Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A532375F7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGXNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGXNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:01:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FA59CC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:59:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 220B720711;
        Mon, 24 Jul 2023 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690203560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Do0e7CJ1pEJxzOlIViZWaPiINUggsNuXBk5LNvIqq60=;
        b=Pcy15HP/bXyocS+tbovirI84IkT9LW1wlzmnRcwmesdI7WEhTmg57kUDIh1SqMj3ild5cn
        OXXD0U3PjIy2MSFnHdtwqo8U5wb6aaRnJV3msSu0pAVd7KcibA9rc1BgsCn0mWfh00ngy0
        ra5fMTcZAsgmA6P9dmefWLIBvsC/+PQ=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 810AD2C142;
        Mon, 24 Jul 2023 12:59:19 +0000 (UTC)
Date:   Mon, 24 Jul 2023 14:59:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rong Tao <rtoax@foxmail.com>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     prasad@linux.vnet.ibm.com, ast@kernel.org, frederic@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mbenes@suse.cz, qperret@google.com, rongtao@cestc.cn,
        tglx@linutronix.de, will@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH] samples/hw_breakpoint: Fix kernel BUG 'invalid opcode:
 0000'
Message-ID: <ZL51o59_yYS_3Yal@alley>
References: <tencent_E626A858BED28C4E21C219780BC566015D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E626A858BED28C4E21C219780BC566015D0A@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-24 18:47:58, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Macro symbol_put() is defined as __symbol_put(__stringify(x))
> 
>     ksym_name = "jiffies"
>     symbol_put(ksym_name)
> 
> will be resolved as
> 
>     __symbol_put("ksym_name")
> 
> which is clearly wrong. So symbol_put must be replaced with __symbol_put.
> 
> When we uninstall hw_breakpoint.ko (rmmod), a kernel bug occurs with the
> following error:
> 
> [11381.854152] kernel BUG at kernel/module/main.c:779!
> [11381.854159] invalid opcode: 0000 [#2] PREEMPT SMP PTI
> [11381.854163] CPU: 8 PID: 59623 Comm: rmmod Tainted: G      D    OE      6.2.9-200.fc37.x86_64 #1
> [11381.854167] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B360M-HDV, BIOS P3.20 10/23/2018
> [11381.854169] RIP: 0010:__symbol_put+0xa2/0xb0
> [11381.854175] Code: 00 e8 92 d2 f7 ff 65 8b 05 c3 2f e6 78 85 c0 74 1b 48 8b 44 24 30 65 48 2b 04 25 28 00 00 00 75 12 48 83 c4 38 c3 cc cc cc cc <0f> 0b 0f 1f 44 00 00 eb de e8 c0 df d8 00 90 90 90 90 90 90 90 90
> [11381.854178] RSP: 0018:ffffad8ec6ae7dd0 EFLAGS: 00010246
> [11381.854181] RAX: 0000000000000000 RBX: ffffffffc1fd1240 RCX: 000000000000000c
> [11381.854184] RDX: 000000000000006b RSI: ffffffffc02bf7c7 RDI: ffffffffc1fd001c
> [11381.854186] RBP: 000055a38b76e7c8 R08: ffffffff871ccfe0 R09: 0000000000000000
> [11381.854188] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [11381.854190] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [11381.854192] FS:  00007fbf7c62c740(0000) GS:ffff8c5badc00000(0000) knlGS:0000000000000000
> [11381.854195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11381.854197] CR2: 000055a38b7793f8 CR3: 0000000363e1e001 CR4: 00000000003726e0
> [11381.854200] DR0: ffffffffb3407980 DR1: 0000000000000000 DR2: 0000000000000000
> [11381.854202] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [11381.854204] Call Trace:
> [11381.854207]  <TASK>
> [11381.854212]  s_module_exit+0xc/0xff0 [symbol_getput]
> [11381.854219]  __do_sys_delete_module.constprop.0+0x198/0x2f0
> [11381.854225]  do_syscall_64+0x58/0x80
> [11381.854231]  ? exit_to_user_mode_prepare+0x180/0x1f0
> [11381.854237]  ? syscall_exit_to_user_mode+0x17/0x40
> [11381.854241]  ? do_syscall_64+0x67/0x80
> [11381.854245]  ? syscall_exit_to_user_mode+0x17/0x40
> [11381.854248]  ? do_syscall_64+0x67/0x80
> [11381.854252]  ? exc_page_fault+0x70/0x170
> [11381.854256]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have already seen and acked this patch few months ago, see
https://lore.kernel.org/all/ZD0TfQHWQftNvFNA@alley/#t

symbol_put() is in module loader code, so this might go via
the module loaded tree. Adding Luis into Cc.

Best Regards,
Petr

---
>  samples/hw_breakpoint/data_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
> index 418c46fe5ffc..9debd128b2ab 100644
> --- a/samples/hw_breakpoint/data_breakpoint.c
> +++ b/samples/hw_breakpoint/data_breakpoint.c
> @@ -70,7 +70,7 @@ static int __init hw_break_module_init(void)
>  static void __exit hw_break_module_exit(void)
>  {
>  	unregister_wide_hw_breakpoint(sample_hbp);
> -	symbol_put(ksym_name);
> +	__symbol_put(ksym_name);
>  	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
>  }
>  
> -- 
> 2.39.3
