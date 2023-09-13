Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9F79F53F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjIMW5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjIMW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AAAF1BCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694645799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlZmFA3mny3eQxGa9tRIBZq7N+QtRNVX8d1cv7/lgp4=;
        b=c4FZ0pf7I/Jm7sbsQ8c+QJBvQ1ilDARczZYNXIlCllXXfSiw5/2KhjuHcgD/4+tv6fkGqj
        G9ZkPcGOurUs6SlnxZxLlgjGu/MfqqxRgB2nAXmG3Eq7HKl7JV85NCU2gw7KjHB9Elqssf
        gJJbOBc8R7t3ejifalG5IGrLD9ywpr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-2c62WKgCP6qrxy-xiLZT3w-1; Wed, 13 Sep 2023 18:56:33 -0400
X-MC-Unique: 2c62WKgCP6qrxy-xiLZT3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23EA881B194;
        Wed, 13 Sep 2023 22:56:33 +0000 (UTC)
Received: from localhost (unknown [10.22.17.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75563403CFA0;
        Wed, 13 Sep 2023 22:56:32 +0000 (UTC)
Date:   Wed, 13 Sep 2023 19:56:30 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     yang.yang29@zte.com.cn
Cc:     catalin.marinas@arm.com, will@kernel.org, bigeasy@linutronix.de,
        linux-arm-kernel@lists.infradead.org, stable-rt@vger.kernel.org,
        linux-kernel@vger.kernel.org, he.he@windriver.com,
        linux-rt-users@vger.kernel.org, wang.yong12@zte.com.cn,
        ran.xiaokai@zte.com.cn, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH 5.10-rt] arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND
Message-ID: <ZQI+HoVcy6ueRXxk@uudg.org>
References: <202309121514283793475@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309121514283793475@zte.com.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:14:28PM +0800, yang.yang29@zte.com.cn wrote:
> From: Wang Yong <wang.yong12@zte.com.cn>
> 
> The ltp test prompts the following bug information under the 5.10 kernel:
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 796, name: cat
> Preemption disabled at:
> [<ffffffe40f433980>] do_debug_exception+0x60/0x180
> CPU: 3 PID: 796 Comm: cat Not tainted 5.10.59-rt52-KERNEL_VERSION #38
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x198
>  show_stack+0x20/0x30
>  dump_stack+0xf0/0x13c
>  ___might_sleep+0x140/0x178
>  rt_spin_lock+0x30/0x90
>  force_sig_info_to_task+0x30/0xe0
>  force_sig_fault_to_task+0x54/0x78
>  force_sig_fault+0x1c/0x28
>  arm64_force_sig_fault+0x48/0x78
>  send_user_sigtrap+0x4c/0x80
>  brk_handler+0x3c/0x68
>  do_debug_exception+0xac/0x180
>  el0_dbg+0x34/0x58
>  el0_sync_handler+0x50/0xb8
>  el0_sync+0x180/0x1c0
> 
> It has been fixed by
> 0c34700de5e7 ("arm64: signal: Use ARCH_RT_DELAYS_SIGNAL_SEND.") in
> higher versions of the kernel. This patch needs to be compatible with 5.10.
> 5.10 kernel does not have signal.h file, so adding signal.h file to
> define ARCH_RT_DELAYS_SIGNAL_SEND.
> 
> Signed-off-by: Wang Yong <wang.yong12@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> ---

Thank you for this fix. I will add it to the release candidate that will
be posted on Friday.

Best regards,
Luis

>  arch/arm64/include/asm/signal.h | 12 ++++++++++++
>  arch/arm64/kernel/signal.c      |  9 +++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 arch/arm64/include/asm/signal.h
> 
> diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
> new file mode 100644
> index 000000000..0fb418cf4
> --- /dev/null
> +++ b/arch/arm64/include/asm/signal.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ARM64_ASM_SIGNAL_H
> +#define __ARM64_ASM_SIGNAL_H
> +
> +#include <uapi/asm/signal.h>
> +#include <uapi/asm/siginfo.h>
> +
> +#if defined(CONFIG_PREEMPT_RT)
> +#define ARCH_RT_DELAYS_SIGNAL_SEND
> +#endif
> +
> +#endif
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index fe94a3e1f..538d4aadb 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -927,6 +927,15 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  		} else {
>  			local_daif_restore(DAIF_PROCCTX);
> 
> +#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
> +			if (unlikely(current->forced_info.si_signo)) {
> +				struct task_struct *t = current;
> +
> +				force_sig_info(&t->forced_info);
> +				t->forced_info.si_signo = 0;
> +			}
> +#endif
> +
>  			if (thread_flags & _TIF_UPROBE)
>  				uprobe_notify_resume(regs);
> 
> -- 
> 2.25.1
> 
---end quoted text---

