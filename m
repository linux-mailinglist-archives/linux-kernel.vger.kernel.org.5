Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44E7E5613
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKHMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbjKHMRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:17:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A91BCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bxii0z+MV2u3mm3xGKkp5XDR2KAZdmtoMUXNeRyR2Vc=; b=sDo3fsShfSwz0SN/P5BrWWtJd9
        JRw+FoKOYrkp7NIvQrP5e/ghC93PoIQqRLZlTk19KhLZSho71hHyPS8JnZ89axJGfPWjeql7+sQpe
        xyAsAPFGreT0Ow4ego7fSiItijgxr9yxfx/Kf5eazE5Hds6iDizv6liF8DR2fawyjtHmgh7BlqrEF
        87xMQno36eG6olJ8etZ2MaSAn+b1o5dKcWssFbIvXD3bvCvfi2QZbZ5VbPD8iuZjC40fzjtH0S7fD
        7hXBjpFBbFjOpOOWQyq08rFXuAJGNqGPygPXnqUhTK0FWNLtA5BcI4aVPXkAS1zDQtukp/1M6zkIp
        xj1FIh+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0hU9-000vU8-0w; Wed, 08 Nov 2023 12:16:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E172300585; Wed,  8 Nov 2023 13:16:41 +0100 (CET)
Date:   Wed, 8 Nov 2023 13:16:41 +0100
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
Message-ID: <20231108121641.GC4779@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <87leb8ik6b.fsf@oracle.com>
 <20231108111415.GP8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108111415.GP8262@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 12:14:15PM +0100, Peter Zijlstra wrote:

> I would really suggest you start with transforming VOLUNTARY into the
> LAZY thing, keep it as simple and narrow as possible.

Possibly make it worse first, add LAZY as a fourth option, then show it
makes VOLUNTARY redundant, kill that.

> Once you've got that done, then you can try and argue that NONE makes no
> sense and try and take it out.

This also pushes out having to deal with the !PREEMPT archs until the
very last moment.

And once you're here, cond_resched() should be an obvious no-op function
and you can go delete them.

Anyway, as said, smaller steps more better. Nobody likes 86 patches in
their inbox in the morning (or at any time really).
