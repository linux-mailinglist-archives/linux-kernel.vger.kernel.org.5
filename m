Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8640C7E008F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347148AbjKCJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347134AbjKCJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:30:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8AD46
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OucduKe3do9JjkGIoFVFJ8LJOWYEah2/DkTkX62AbB8=; b=Bqq/p3sFcacB8uurIhbxgJxjqz
        jtRHAil5rYRvhUFJBhuxv3+d8VitU7VclnXK69WgvqPC8PBhDzB8O+0Vtqfy3qcapmdXOqvYR4lI9
        tqyoSPIZ3yRPZzOmdLaoVNyDqUjZSnOKKAiuB3L0ppOjqFFJYZSE6EwLMpnNDGJIEtDPvpBlIPLDb
        CgMdVrD0/WMShyUXMVHMelfWL6n70EuZ644bGcPjdJbg/g5zzGfizQsDBlA31zPgsmO/bPd6vQmPm
        qoNq9ROYCOHNnyrTo9W2EUjbR9Hu1W64PqA37qeC4HsvIclisEP4uXuQ9q1ri/bFZVGzXXt5e51QC
        Vd6g8HYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyqVT-004and-5C; Fri, 03 Nov 2023 09:30:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 831E130027B; Fri,  3 Nov 2023 10:30:23 +0100 (CET)
Date:   Fri, 3 Nov 2023 10:30:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] cleanup: Add conditional guard support
Message-ID: <20231103093023.GA8262@noisy.programming.kicks-ass.net>
References: <20231102104429.025835330@infradead.org>
 <20231102110706.460851167@infradead.org>
 <20231102144009.GA9680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102144009.GA9680@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 03:40:11PM +0100, Oleg Nesterov wrote:
> On 11/02, Peter Zijlstra wrote:
> >
> >  include/linux/cleanup.h  |   52 ++++++++++++++++++++++++++++++++++++++++++++---
> 
> interesting... I don't know anything about cleanup.h, will
> read this code and the patch later, but I guess I understand
> the idea.
> 
> Stupid/offtopic question... Can't we change guard()
> 
> 	-#define guard(_name) \
> 	-	CLASS(_name, __UNIQUE_ID(guard))
> 	+#define guard(_name, args...) \
> 	+	CLASS(_name, __UNIQUE_ID(guard))(args)
> 
> and update the current users?
> 
> To me
> 
> 	guard(rcu);
> 	guard(spinlock, &lock);
> 
> looks better than
> 
> 	guard(rcu)();
> 	// doesn't match scoped_guard(spinlock, &lock)
> 	guard(spinlock)(&lock);
> 
> And this will make guard() consistent with scoped_guard().
> 
> No?

Yes (and you're not the only one to have noticed), I think an earlier
version actually had that. The current form came about in a fairly long
thread with Linus. Most notably here:

  https://lkml.kernel.org/r/CAHk-%3DwgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A%40mail.gmail.com

And I don't actually dislike the current guard form, I've been reading
it like:

  guard<mutex>(&my_mutex);

But that is arguably because I've done a fair few years of C++ systems
programming before I got involved with this kernel thing. Also, we use a
very similar syntax for the static_call thing:

  static_call(x86_pmu_enable)(event);


That said; if we were to do this, then something like:

#define __cond_guard(_name, _inst, _fail, args...) \
	CLASS(_name, _inst)(args); \
	if (!__guard_ptr(_name)(&_inst)) _fail

#define cond_guard(_name, _fail, args...) \
	__cond_guard(_name, __UNIQUE_ID(guard), _fail, args)


  cond_guard(spinlock_try, return -EBUSY, &my_lock);


Becomes possible.

Linus, do you like that enough to suffer a flag day patch as proposed by
Oleg?
