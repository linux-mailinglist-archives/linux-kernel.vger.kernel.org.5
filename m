Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA87E4FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjKHEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHEIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:08:07 -0500
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FD1B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 20:08:04 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id 8A7C048F45; Tue,  7 Nov 2023 20:08:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 87CFF48F41;
        Tue,  7 Nov 2023 20:08:03 -0800 (PST)
Date:   Tue, 7 Nov 2023 20:08:03 -0800 (PST)
From:   Christoph Lameter <cl@linux.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Message-ID: <549c1cba-5cad-7706-de85-d61376db25cc@linux.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is not preemptible???? What are you smoking?

On Tue, 7 Nov 2023, Ankur Arora wrote:

> In voluntary models, the scheduler's job is to match the demand
> side of preemption points (a task that needs to be scheduled) with
> the supply side (a task which calls cond_resched().)

Voluntary preemption models are important for code optimization because 
the code can rely on the scheduler not changing the cpu we are running on. 
This allows removing code for preempt_enable/disable to be removed from 
the code and allows better code generation. The best performing code is 
generated with defined preemption points when we have a guarantee that the 
code is not being rescheduled on a different processor. This is f.e. 
important for consistent access to PER CPU areas.

> To do this add a new flag, TIF_NEED_RESCHED_LAZY which allows the
> scheduler to mark that a reschedule is needed, but is deferred until
> the task finishes executing in the kernel -- voluntary preemption
> as it were.

That is different from the current no preemption model? Seems to be 
the same.

> There's just one remaining issue: now that explicit preemption points are
> gone, processes that spread a long time in the kernel have no way to give
> up the CPU.

These are needed to avoid adding preempt_enable/disable to a lot of 
primitives that are used for synchronization. You cannot remove those 
without changing a lot of synchronization primitives to always have to 
consider being preempted while operating.

