Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A071A7E4DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjKHAAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKHAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:00:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE96184
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:00:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A48CC433C8;
        Wed,  8 Nov 2023 00:00:13 +0000 (UTC)
Date:   Tue, 7 Nov 2023 19:00:16 -0500
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
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231107190016.2da8c402@gandalf.local.home>
In-Reply-To: <877cmtxh77.fsf@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107180153.4a02d2ba@gandalf.local.home>
        <877cmtxh77.fsf@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 15:43:40 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> 
> The TIF_NEED_RESCHED flag is evaluated at all three of the preemption
> points. TIF_NEED_RESCHED_LAZY only needs to be evaluated at ret-to-user.
> 
>                   ret-to-user    ret-to-kernel    preempt_count()
> NEED_RESCHED_LAZY    Y              N                N
> NEED_RESCHED         Y              Y                Y
> 
> Based on how various preemption models set the flag they would cause
> preemption at:

I would change the above to say "set the NEED_SCHED flag", as "set the
flag" is still ambiguous. Or am I still misunderstanding the below table?

> 
>                   ret-to-user    ret-to-kernel    preempt_count()
> none                 Y              N                N
> voluntary            Y              Y                Y
> full                 Y              Y                Y
> 

-- Steve
