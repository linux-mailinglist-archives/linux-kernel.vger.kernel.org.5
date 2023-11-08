Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A87E54CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjKHLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:15:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005919B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LakYbXR3di9WRqWbciSUdlJrNzr3EZiBAXC/ZMZNW4g=; b=QGsg4EwJgCqNuGRPTI0kL4wSsi
        Y1tiUsZhpALUmcK71iy49kzBVviGpiZqeT0kugcoxjtWU0Wcftc8ra7EGyYo2qD8h72qMne2cej3/
        hHUHjTdbWMGRFqtspUvAE7TNwbeb4RiN6r7al5zsDBjeEsZ1zMWDNCc6WDy3sfKtYC1lAa3mI97EQ
        0iOHM1beg6B0bNmeiuc4Rax3Z0ynIt72v8dGIIXAx2Zp90FWRCpoFvBz8w6R/wZ1D0HeIDH9y9+GC
        vgtrpZSjuuWsXjWfB0yNjp8+hxyteRfgA129LsK6Ue/wIV0B6F4LdJ2SvKdZ8gcfS6IqKIrq9aPs/
        SfeC7WPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0gVj-00DR3j-2x;
        Wed, 08 Nov 2023 11:14:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38A2B30049D; Wed,  8 Nov 2023 12:14:15 +0100 (CET)
Date:   Wed, 8 Nov 2023 12:14:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108111415.GP8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <87leb8ik6b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leb8ik6b.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 03:00:44AM -0800, Ankur Arora wrote:

> Ah now I see what you are saying.
> 
> Quick thought: even if we were running under NONE, eventually you'll

Well, NONE, you get what you pay for etc..

> want to forcibly preempt out a CPU hog. So we will need to have
> at least this one enabled always:
> 
> >  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> 
> These two, it might make sense to toggle them based on model.
> 
> >  *   preempt_schedule           <- preempt_schedule
> >  *   preempt_schedule_notrace   <- preempt_schedule_notrace
> 
> Anyway let me think about this more and respond tomorrow.

That's more or less killing NONE. At that point there's really no point
in having it.

I would really suggest you start with transforming VOLUNTARY into the
LAZY thing, keep it as simple and narrow as possible.

Once you've got that done, then you can try and argue that NONE makes no
sense and try and take it out.

Smaller step etc..
