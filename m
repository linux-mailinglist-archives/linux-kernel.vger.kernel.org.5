Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15827841F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjHVNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHVNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3CFCE2;
        Tue, 22 Aug 2023 06:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA40656A5;
        Tue, 22 Aug 2023 13:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBF6C433C7;
        Tue, 22 Aug 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692710651;
        bh=1H6Ce6imURA+wf6y7Aq3H2FeClk2I0iVXg12l/OrwhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX+8gbkFnBYwtZGPCh3LoDSxBLaem5Wgz5kd6bpIu6Dzqyc/1U05O12CAT8pegC5I
         Bd/nKbs0sjkCrxOeYvRkcmt1isE28JNmOGcIOuFtnALoNApcC2GrLGS96Lw6kE7e0D
         CzuEgPyw/xiRkJEdGMTtjTnb4NXK1v5kN4rBOCdU=
Date:   Tue, 22 Aug 2023 15:24:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty/sysrq: replace smp_processor_id() with get_cpu()
Message-ID: <2023082258-lethargic-hazily-5c7e@gregkh>
References: <20230822102606.2821311-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822102606.2821311-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:26:06PM +0500, Muhammad Usama Anjum wrote:
> The smp_processor_id() shouldn't be called from preemptible code.
> Instead use get_cpu() and put_cpu() which disables preemption in
> addition to getting the processor id. This fixes the following bug:
> 
> [  119.143590] sysrq: Show backtrace of all active CPUs
> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
> [  119.145053] Call trace:
> [  119.145093]  dump_backtrace+0x0/0x1a0
> [  119.145122]  show_stack+0x18/0x70
> [  119.145141]  dump_stack+0xc4/0x11c
> [  119.145159]  check_preemption_disabled+0x100/0x110
> [  119.145175]  debug_smp_processor_id+0x20/0x30
> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
> [  119.145211]  __handle_sysrq+0x8c/0x1a0
> [  119.145227]  write_sysrq_trigger+0x94/0x12c
> [  119.145247]  proc_reg_write+0xa8/0xe4
> [  119.145266]  vfs_write+0xec/0x280
> [  119.145282]  ksys_write+0x6c/0x100
> [  119.145298]  __arm64_sys_write+0x20/0x30
> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
> [  119.145332]  do_el0_svc+0x24/0x8c
> [  119.145348]  el0_svc+0x10/0x20
> [  119.145364]  el0_sync_handler+0x134/0x140
> [  119.145381]  el0_sync+0x180/0x1c0
> 
> Cc: stable@vger.kernel.org
> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")

How has this never shown up before now?  What changed to cause this to
now be triggered?  This feels odd that no one has seen this in the past
20+ years :(


> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - Add changelog and resend
> 
> Changes since v1:
> - Add "Cc: stable@vger.kernel.org" tag
> ---
>  drivers/tty/sysrq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 23198e3f1461a..6b4a28bcf2f5f 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
>  		if (in_hardirq())
>  			regs = get_irq_regs();
>  
> -		pr_info("CPU%d:\n", smp_processor_id());
> +		pr_info("CPU%d:\n", get_cpu());
>  		if (regs)
>  			show_regs(regs);
>  		else
>  			show_stack(NULL, NULL, KERN_INFO);
>  
>  		schedule_work(&sysrq_showallcpus);
> +		put_cpu();

Why are you putting the cpu _after_ you schedule the work?

thanks,

greg k-h
