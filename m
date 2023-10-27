Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3507D9DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjJ0QMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjJ0QMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:12:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC7CCC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MWapjC5/22w3JpTeWUjTU9uR0zKJf+f7+IluKDDUnbs=; b=HdSAFWnGYUInvvpe+2Th0WtQ9J
        2gDhOPLsUVxRcBNzHA1T82VsWzRYanpUhd/vEo5249bTOW6grVsR98mADri30kmI89fRMVdrpsInE
        YvAqAoXYRkD32VIg77zOup1lAOwcwixKVBcDuWcpxMUv6OX0UTpExVgc/fSI2lyWiETzQ5jJ4v5L7
        ioINTR8ZNniupoDDyO+4hzEfBvKLLB13DFV+sqhIKgzeoDESin5xw4YQOMojxuvTHjZ44d/6RHfXx
        7JUFfrwIf1mbH/NYEUHwYRo2miM6A1GwmBwBav1UBCUOXc2C8fZl288aZ4OX6wrNWfzaGPLNOIBua
        MtkWrxtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwPRs-004KXq-R0; Fri, 27 Oct 2023 16:12:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73D7B300392; Fri, 27 Oct 2023 18:12:35 +0200 (CEST)
Date:   Fri, 27 Oct 2023 18:12:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: lockdep: holding locks across syscall boundaries
Message-ID: <20231027161235.GB26550@noisy.programming.kicks-ass.net>
References: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
 <20231027155949.GA26550@noisy.programming.kicks-ass.net>
 <ed3c5450-3dce-4f6a-9a8c-04fcdba1cbf2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3c5450-3dce-4f6a-9a8c-04fcdba1cbf2@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:06:33AM -0600, Jens Axboe wrote:
> On 10/27/23 9:59 AM, Peter Zijlstra wrote:
> > On Fri, Oct 27, 2023 at 09:14:53AM -0600, Jens Axboe wrote:
> >> Hi,
> >>
> >> Normally we'd expect locking state to be clean and consistent across
> >> syscall entry and exit, as that is always the case for sync syscalls.
> > 
> >> We currently have a work-around for holding a lock from aio, see
> >> kiocb_start_write(), which pretends to drop the lock from lockdeps
> >> perspective, as it's held from submission to until kiocb_end_write() is
> >> called at completion time.
> > 
> > I was not aware of this, the only such hack I knew about was the
> > filesystem freezer thing.
> > 
> > The problem with holding locks past the end of a syscall is that you'll
> > nest whatever random lock hierarchies possibly by every other syscall
> > under that lock.
> 
> Can you expand on that bit, not quite sure I follow. Do we reset the
> locking dependencies between syscalls?

What I'm saying is that if syscall-a (see below) returns with lock-A
held, and userspace goes on and does syscall-b syscall-c ... syscall-z
before the lock gets released. Then all the lock chains of
syscall-[b..z] will be under lock-a.

This very easily leads to inversions, and is thus a strong reason to not
allow syscalls to 'leak' locks.

> >> This is a bit of an ugly work-around, and defeats the purpose of
> >> lockdep.
> >>
> >> Since I've now got another case where I want to hold a resource across
> >> syscalls, is there a better way to do this?
> >>
> >> This is for inode_dio_start(), which increments an inode int count, and
> >> inode_dio_end() which decrements it. If a task is doing
> >> inode_dio_start() and then inode_dio_wait(), I want to trigger this. I
> >> have a hack that does this, but it disables lockdep_sys_exit() as
> >> otherwise I just get that warning rather than the more useful one.
> > 
> > Suppose syscall-a returns with your kiocb thing held, call it lock A
> > Suppose syscall-b returns with your inode thing held, call it lock B
> > 
> > Then userspace does:
> > 
> > 	syscall-a
> > 	syscall-b
> > 
> > while it also does:
> > 
> > 	syscall-b
> > 	syscall-a
> > 
> > and we're up a creek, no?
> 
> Should this not get caught by the usual lock ordering rules? Because

Well, yes, lockdep will yell, and a machine without lockdep will
deadlock.

This is bad syscall design if you can deadlock like this. We must assume
userspace is out to get us, if possible it will do this.

> that is obviously a bug, ordering would have to be consistent, just like
> if we have:
> 
> 	syscall-a
> 		lock(a);
> 		lock(b);
> 
> 	syscall-b
> 		lock(b);
> 		lock(a)

The difference is that in this case the full lock order is determined by
kernel code (under our full control), while in the earlier example, the
lock order is determined by syscall order -- out of our control.

