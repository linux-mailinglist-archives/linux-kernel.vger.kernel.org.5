Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC07B2C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjI2GFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:05:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8E92;
        Thu, 28 Sep 2023 23:05:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895CBC433C9;
        Fri, 29 Sep 2023 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695967533;
        bh=ApOaP/9oDp2rTN1MoBE5BwHQoNPxIFZOt3ooiC/inEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bj2RVsFRjqIrzSw1UWOT77b0SUWLKRghuoHYc/LJkFyuxYQVcBkatPheuVq18y/Jc
         nkbREEB5jsx8AAW4g6M7mbMKp0FHO0/Z1w4jLZ9nZelNp9z6lX01GcHsI6sGbCHN3q
         2EiVWKFdzMkCx8/rQSDwWOKs014FI+QVSjXI+dCs=
Date:   Fri, 29 Sep 2023 08:05:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        conor@kernel.org, guoren@kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, liushixin2@huawei.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
Message-ID: <2023092907-anybody-irregular-a30e@gregkh>
References: <f74665d1-4d28-01a2-5694-b06fde202d39@ghiti.fr>
 <20230928231239.2144579-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928231239.2144579-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 07:12:40AM +0800, Edward AD wrote:
> Add vmalloc and kernel addresses check to prevent invalid access.
> 
> Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Reported-and-test-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 64a9c093aef9..031a4a35c1d0 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -54,6 +54,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			break;
>  		/* Unwind stack frame */
>  		frame = (struct stackframe *)fp - 1;
> +		if ((is_vmalloc_addr(frame) && !pfn_valid(page_to_pfn(vmalloc_to_page(frame)))) || 
> +		     !virt_addr_valid(frame))
> +			break;
>  		sp = fp;
>  		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
>  			fp = frame->ra;
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
