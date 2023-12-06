Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8E806D43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378032AbjLFLEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378062AbjLFLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:04:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125E268B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSYlxXqYrJTRv96VW6+MysBZoWRii4OIQnWqLMrQnEI=; b=EfzA3J4PnDms+Gx8LZcjukNC7/
        oQZLXyNarq3qXGfcgjjOZzkualSeOBaFPk8IgRkjZoe/E3v+mQBIOeLXStF57ll4f0fPVfOqTJtNt
        NtpZvpvXIzmurgYmsQUL/RnnpXG1q4goNXia9WJixL4/FxeeQZ5Itj2TFv2qqv8qwP1kTEDxIrX2+
        TIXrgHCWsFNYs+iVegAtKu3U0QJ/ywTH6j8kUQilB59n5J5f3+LHOl4jImRhO5ozCZ9tvvUbeCYfC
        9WuLw0a70tMcxOL2FhsGJCu53PBk31Tj+gUZc5ZagLvpT8lh0Z957m6VGTYRSyYVB6roROUw7PhNS
        iiCQFIYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rApfG-00596Y-2O;
        Wed, 06 Dec 2023 11:02:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 321C0300451; Wed,  6 Dec 2023 12:02:02 +0100 (CET)
Date:   Wed, 6 Dec 2023 12:02:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 0/3] entry: inline syscall enter/exit functions
Message-ID: <20231206110202.GD30174@noisy.programming.kicks-ass.net>
References: <20231205133015.752543-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205133015.752543-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:30:12PM +0100, Sven Schnelle wrote:
> Hi List,
> 
> looking into the performance of syscall entry/exit after s390 switched
> to generic entry showed that there's quite some overhead calling some
> of the entry/exit work functions even when there's nothing to do.
> This patchset moves the entry and exit function to entry-common.h, so
> non inlined code gets only called when there is some work pending.

So per that logic you wouldn't need to inline exit_to_user_mode_loop()
for example, that's only called when there is a EXIT_TO_USER_MODE_WORK
bit set.

That is, I'm just being pedantic here and pointing out that your
justification doesn't cover the extent of the changes.

> I wrote a small program that just issues invalid syscalls in a loop.
> On an s390 machine, this results in the following numbers:
> 
> without this series:
> 
> # ./syscall 1000000000
> runtime: 94.886581s / per-syscall 9.488658e-08s
> 
> with this series:
> 
> ./syscall 1000000000
> runtime: 84.732391s / per-syscall 8.473239e-08s
> 
> so the time required for one syscall dropped from 94.8ns to
> 84.7ns, which is a drop of about 11%.

That is obviously very nice, and I don't immediately see anything wrong
with moving the lot to header based inlines.

Thomas?
