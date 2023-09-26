Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4A7AEBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjIZLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjIZLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:49:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC9DE;
        Tue, 26 Sep 2023 04:49:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDFEC433C9;
        Tue, 26 Sep 2023 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695728971;
        bh=BDIUttsZQQFkLvxRNL0OyVkQfC2FmRbuUcsXNdRp1pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kW0wi9LEkIMVJnvXmXp+torrf3YvFpAzeV7qP8iLknnUYyG3mXazThOmML5lS+zg5
         deyni9oM3UNTFP71+6qqIheiTpN2SKneXqjLO6TQ2vvn+eyLvzkEI953nC2qXEQt+I
         dR+tZnHfXMfwDhD4DJ92hqFzCS7BoixKb8h7RHeQ=
Date:   Tue, 26 Sep 2023 13:49:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     conor@kernel.org,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, alexghiti@rivosinc.com,
        liushixin2@huawei.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
Message-ID: <2023092617-polish-modify-3acb@gregkh>
References: <0000000000000170df0605ccf91a@google.com>
 <20230926114343.1061739-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926114343.1061739-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 07:43:44PM +0800, Edward AD wrote:
> Increase the check on the frame after assigning its value. This is to prevent 
> frame access from crossing boundaries.
> 
> Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Reported-and-tested-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 64a9c093aef9..53bd18672329 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -54,6 +54,8 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			break;
>  		/* Unwind stack frame */
>  		frame = (struct stackframe *)fp - 1;
> +		if (!virt_addr_valid(frame))
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
