Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A477E4D70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjKGXap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344523AbjKGXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:30:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C22707
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:26:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A71C433C7;
        Tue,  7 Nov 2023 23:26:36 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:26:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 31/86] x86/thread_info: add TIF_NEED_RESCHED_LAZY
Message-ID: <20231107182637.20f71eba@gandalf.local.home>
In-Reply-To: <20231107215742.363031-32-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-32-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:57:17 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Add a new flag, TIF_NEED_RESCHED_LAZY which with TIF_NEED_RESCHED
> gives the scheduler two levels of rescheduling priority:
> TIF_NEED_RESCHED means that rescheduling happens at the next
> opportunity; TIF_NEED_RESCHED_LAZY is used to note that a
> reschedule is needed but does not impose any other constraints
> on the scheduler.

Please add:

Link: https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/

For each of the patches that were based off of Thomas's patch.

Thanks!

-- Steve



> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/include/asm/thread_info.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index d63b02940747..114d12120051 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -81,8 +81,9 @@ struct thread_info {
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>  #define TIF_SIGPENDING		2	/* signal pending */
>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
> -#define TIF_SSBD		5	/* Speculative store bypass disable */
> +#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> +#define TIF_SSBD		6	/* Speculative store bypass disable */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> @@ -104,6 +105,7 @@ struct thread_info {
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SSBD		(1 << TIF_SSBD)
>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)

