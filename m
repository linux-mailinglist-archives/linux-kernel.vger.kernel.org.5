Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA37BFECF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJJONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJJONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:13:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7C99
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oT8vyW0rcd9dmGUW7gq6FLmT8hw5IrIbn9c99vaOk+A=; b=OmaQV/tP8+GGn+Nwl/ceaJ9lDN
        xnXTNTwHFX5gBNgoCOm704oPcIozMgB643BZJC3PxZwwQ8u+B0jrHKzk9VovmyCK2DDU7pNtPO63Y
        9ljMIeQ5rjXrtfmYgQ0Gprhj7EjWrpjRysRoXEZInM2unJFKsLaNIfLbDlCr3U/1jje+/mR2quocX
        NDeHg6xiSXjCKC3a/tkNreYY0uRB1KtcRfVo9aNINZs9gsXiE5KN/Ei8dbNMT5Zigl+TAmuc1aY94
        PYP0t59ZZhJfXnfVz+SQ5e0GfiqIsh6EnnsAR4rTw9yygQZwJ85tboKrPLx8PuPRFe8//uACoUXsk
        RXK8UiGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqDTX-00GtuQ-36;
        Tue, 10 Oct 2023 14:12:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA283300392; Tue, 10 Oct 2023 16:12:44 +0200 (CEST)
Date:   Tue, 10 Oct 2023 16:12:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] sched/fair: Use printk_deferred instead of printk in
 pick_eevdf()
Message-ID: <20231010141244.GM377@noisy.programming.kicks-ass.net>
References: <20231010032541.339606-1-yu.c.chen@intel.com>
 <20231010075928.GA377@noisy.programming.kicks-ass.net>
 <20231010122600.GA477540@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010122600.GA477540@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:26:00AM -0400, Phil Auld wrote:

> > No.. I detest printk_deferred with a passion. This is effectively a WARN
> > and we don't do silly buggers for them either.
> >
> 
> Sure, printk_deferred is not ideal, but is getting this message in the right
> order worth locking up people's machines?  Not sure you get the message at
> all when that happens.  I have to dig the code location out of the crash
> dump to find which sched warning fired and took down the (usually virtual)
> machine.

Same thing with WARN(), we don't have a silly bugger version of that
either. Just use a sane printk() / console or whatever.

Virt stuff has perfectly functional serial consoles that works just fine
and don't lock up the machine -- mostly. Use my early_printk hacks if
you want something reliable:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=debug/experimental

Boot with: "earlyprintk=serial,ttyS0,115200 force_early_printk". And all
will be well.

The fact that crashdump is more reliable than printk is a *BIG* problem
and the only solution is fixing printk() (people are sorta working on
that). We should not try and work around this problem.

I fundamentally despise the delayed stuff, I've had countless insteances
where delaying output means you have no output because the machine is
dead.
