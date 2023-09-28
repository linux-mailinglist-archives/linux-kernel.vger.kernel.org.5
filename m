Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E47B1587
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjI1ICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjI1ICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:02:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B2BE;
        Thu, 28 Sep 2023 01:02:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47DE240004;
        Thu, 28 Sep 2023 08:02:23 +0000 (UTC)
Message-ID: <d0f12692-f0df-9535-922a-f0578c713547@ghiti.fr>
Date:   Thu, 28 Sep 2023 10:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
To:     Edward AD <twuufnxlz@gmail.com>, conor@kernel.org
Cc:     syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        alexghiti@rivosinc.com, liushixin2@huawei.com,
        linux-riscv@lists.infradead.org
References: <0000000000000170df0605ccf91a@google.com>
 <20230926114343.1061739-2-twuufnxlz@gmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230926114343.1061739-2-twuufnxlz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

On 26/09/2023 13:43, Edward AD wrote:
> Increase the check on the frame after assigning its value. This is to prevent
> frame access from crossing boundaries.
>
> Closes: https://lore.kernel.org/all/20230926105949.1025995-2-twuufnxlz@gmail.com/
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Reported-and-tested-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/T/
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>   arch/riscv/kernel/stacktrace.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 64a9c093aef9..53bd18672329 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -54,6 +54,8 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>   			break;
>   		/* Unwind stack frame */
>   		frame = (struct stackframe *)fp - 1;
> +		if (!virt_addr_valid(frame))
> +			break;
>   		sp = fp;
>   		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
>   			fp = frame->ra;


virt_addr_valid() works on kernel linear addresses, not on vmalloc 
addresses, which is the case here  (0xff20000006d37c38 belongs to the 
vmalloc region: see 
https://elixir.bootlin.com/linux/latest/source/Documentation/riscv/vm-layout.rst#L125). 
So this fix can't work.

I'm a bit surprised though of this out-of-bounds access since 
CONFIG_FRAME_POINTER is enabled, so there may be a real issue here (the 
console output is horrible, lots of backtraces, which is weird), so it 
may be worth digging into that.

Thanks,

Alex


