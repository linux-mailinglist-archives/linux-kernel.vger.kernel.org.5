Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078997E4DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjKHAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKHAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:07:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3210C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:07:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8114AC433C8;
        Wed,  8 Nov 2023 00:07:20 +0000 (UTC)
Date:   Tue, 7 Nov 2023 19:07:23 -0500
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
Subject: Re: [RFC PATCH 45/86] preempt: ARCH_NO_PREEMPT only preempts lazily
Message-ID: <20231107190723.2512d900@gandalf.local.home>
In-Reply-To: <20231107215742.363031-46-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-46-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:57:31 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Note: this commit is badly broken. Only here for discussion.
> 
> Configurations with ARCH_NO_PREEMPT support preempt_count, but might
> not be tested well enough under PREEMPTION to support it might not
> be demarcating the necessary non-preemptible sections.
> 
> One way to handle this is by limiting them to PREEMPT_NONE mode, not
> doing any tick enforcement and limiting preemption to happen only at
> user boundary.
> 
> Unfortunately, this is only a partial solution because eager
> rescheduling could still happen (say, due to RCU wanting an
> expedited quiescent period.) And, because we do not trust the
> preempt_count accounting, this would mean preemption inside an
> unmarked critical section.

Is preempt_count accounting really not trust worthy?

That is, if we preempt at preempt_count() going to zero but nowhere else,
would that work? At least it would create some places that can be resched.

What's the broken part of these archs? The assembly? If that's the case, as
long as the generic code has the preempt_count() I would think that would
be trust worthy. I'm also guessing that in_irq() and friends are still
reliable.

-- Steve
