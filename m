Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E47D9DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbjJ0P75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346247AbjJ0P7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:59:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB14CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6o4rbLFYNUp9YJOxgeaoUrnihGTZ1EBKCFaYlv7pvHU=; b=LeKd3dZSt3bfsY/3NaA8gkWnHj
        SeZYAPIQtkWwGBuFPrSBKrIkCsQAa8ub/tbnVKF6RFCcBsU4w7Vs6KDHOSpe4/ZjXTSRQRqMBJbAR
        KwGHFDyEvmUiahxUhpOMqhGdQuMCgx2ZkOY2yrLMN3lliJS2NP+fSGq3+w6BcspFeW8QDB3pW2Y9C
        0KeZ3wd00h4+EFw0Ng8HsKH8m+1RGtNM58+5VRiI129jhIk+LEJWCkM6m9M+Y5fbrN2PUH2dZAnvR
        xTmzUQLwr26u4BtQx2Fc82EjMB+LlL8f/TkX0U18XB8u//kLq3BRxfobuVUbmQ0mrmhC2Wbd09dcI
        V/i9Hhwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwPFW-004FZK-BM; Fri, 27 Oct 2023 15:59:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07CB9300392; Fri, 27 Oct 2023 17:59:50 +0200 (CEST)
Date:   Fri, 27 Oct 2023 17:59:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: lockdep: holding locks across syscall boundaries
Message-ID: <20231027155949.GA26550@noisy.programming.kicks-ass.net>
References: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:14:53AM -0600, Jens Axboe wrote:
> Hi,
> 
> Normally we'd expect locking state to be clean and consistent across
> syscall entry and exit, as that is always the case for sync syscalls.

> We currently have a work-around for holding a lock from aio, see
> kiocb_start_write(), which pretends to drop the lock from lockdeps
> perspective, as it's held from submission to until kiocb_end_write() is
> called at completion time.

I was not aware of this, the only such hack I knew about was the
filesystem freezer thing.

The problem with holding locks past the end of a syscall is that you'll
nest whatever random lock hierarchies possibly by every other syscall
under that lock.

> This is a bit of an ugly work-around, and defeats the purpose of
> lockdep.
> 
> Since I've now got another case where I want to hold a resource across
> syscalls, is there a better way to do this?
> 
> This is for inode_dio_start(), which increments an inode int count, and
> inode_dio_end() which decrements it. If a task is doing
> inode_dio_start() and then inode_dio_wait(), I want to trigger this. I
> have a hack that does this, but it disables lockdep_sys_exit() as
> otherwise I just get that warning rather than the more useful one.

Suppose syscall-a returns with your kiocb thing held, call it lock A
Suppose syscall-b returns with your inode thing held, call it lock B

Then userspace does:

	syscall-a
	syscall-b

while it also does:

	syscall-b
	syscall-a

and we're up a creek, no?
