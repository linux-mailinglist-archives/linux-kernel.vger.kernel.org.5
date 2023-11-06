Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706ED7E1FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjKFLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:11:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39226BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vUpyzL3z2/C5RrFQiyOF3f2JCk8iw10/Zg7NgkeCw/E=; b=Jm/0eX5XG+QccwGne3HBFtqhrU
        10Q6vmKKfAMRz0hNIwIUexTPMf8YXBciHhbYi9nGyExHExOSTAYXeB4MeyKPLcwgPYdpPGch3p0ro
        VfYf1cDs/9WsASgvvzfHX8+sy90Hxvs2xw7Rwaxm1Q4NF2TuckCW0Chfh1ce4Ea0tc4xlW1UQDP8v
        XCZrdLVP/7sS1s6YsHF6P5n/L4nuLcXpVIVlTnwhqk5TnTGvW3BCwai99KrQdr6rauhyo8T4ud8Oh
        ZurA3r9gCyKQMhngIYtn4nSsQC+p61meKsLzTeya9R7XbLXjfG/kqKzpsbl3sNqv4d5s6Su659qyH
        q38D5haw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzxVY-005ZUp-Ac; Mon, 06 Nov 2023 11:11:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A899430049D; Mon,  6 Nov 2023 12:11:04 +0100 (CET)
Date:   Mon, 6 Nov 2023 12:11:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
Message-ID: <20231106111104.GK8262@noisy.programming.kicks-ass.net>
References: <20231103161635.1902667-1-aahringo@redhat.com>
 <20231103185414.GD8262@noisy.programming.kicks-ass.net>
 <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 03:20:08PM -0400, Alexander Aring wrote:
> Hi,
> 
> On Fri, Nov 3, 2023 at 2:54 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:
> >
> > > diff --git a/lib/refcount.c b/lib/refcount.c
> > > index a207a8f22b3c..e28678f0f473 100644
> > > --- a/lib/refcount.c
> > > +++ b/lib/refcount.c
> > > @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
> > >  }
> > >  EXPORT_SYMBOL(refcount_dec_not_one);
> > >
> > > +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
> > > +                           void (*unlock)(void *lockptr),  void *lockptr)
> > > +{
> > > +     if (refcount_dec_not_one(r))
> > > +             return false;
> > > +
> > > +     lock(lockptr);
> > > +     if (!refcount_dec_and_test(r)) {
> > > +             unlock(lockptr);
> > > +             return false;
> > > +     }
> > > +
> > > +     return true;
> > > +}
> > > +EXPORT_SYMBOL(refcount_dec_and_lockptr);
> >
> > This is terrible, you're forcing indirect calls on everything.
> >
> 
> Okay, I see. How about introducing a macro producing all the code at
> preprocessor time?

__always_inline should work, then you get constant propagation for the
function pointer.

But indeed, perhaps a macro is more convenient vs the irq flags
argument. You'll then end up with something like:

#define __refcount_dec_and_lock(_ref, _lock, _unlock) \
({ 	bool _ret = false; \
	if (!refcount_dec_not_one(_ref)) { \
		_lock; \
		if (!refcount_dec_and_test(_ref)) { \
			_unlock; \
		} else { \
			_ret = true; \
		} \
	} \
	_ret; \
})


bool refcount_dec_and_spinlock_irqsave(refcount_t *r, spinlock_t *lock, 
				       unsigned long *flags)
{
	return __refcount_dec_and_lock(r, spin_lock_irqsave(*lock, *flags),
					  spin_unlock_irqrestore(*lock, *flags));
}
