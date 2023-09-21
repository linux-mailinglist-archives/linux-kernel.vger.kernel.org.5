Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3127AA114
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjIUU56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjIUU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A804066A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=70cLdlRlQ6wmrVb+lO5G5T5n9IGtfTiJYwHW+xMgyWs=; b=jLdH+cnqRr5ViVdt6JoCr7dBTH
        A8fXI6yDoy3NVMaj96gwpb8+Hbe6wAdWZUjYr6dag/E1NUKi7DULxm8Wr3bxpETzcVcssNr9LmKqy
        +cxDjNFh8u2+9fJ9g59VzSH/qM0BIJmVEjy7nqtrNud9cdZ9MtYyjlLSIrVT637FKkv+2h4PEWwPE
        zzJeNrcTx+Wx6cUoHv9a0z/txjTW96OtamblWo/GOOlBkGpPvk2wMGss8KtX5sm4AtqFRuPBHIqjx
        H38zktMy7dBpwbPqnEBU5fCJ/GZFWvJVavitL0rmF32nmQ4FinocWhwE3r5rbIoqjmhnE9eG+Rc8A
        5D7PPX6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjENX-00Acj0-Fd; Thu, 21 Sep 2023 07:45:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97F8C3002E3; Thu, 21 Sep 2023 09:45:38 +0200 (CEST)
Date:   Thu, 21 Sep 2023 09:45:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <20230921074538.GD14803@noisy.programming.kicks-ass.net>
References: <20220909192848.963982-1-longman@redhat.com>
 <CANDhNCpsDbz9ZT+h4Zcq-7QMJ-uqs3rW+MXCVcbi2A2hnTjBpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpsDbz9ZT+h4Zcq-7QMJ-uqs3rW+MXCVcbi2A2hnTjBpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:05:56PM -0700, John Stultz wrote:
> On Fri, Sep 9, 2022 at 12:28 PM Waiman Long <longman@redhat.com> wrote:
> >
> > It was found that a circular lock dependency can happen with the
> > following locking sequence:
> >
> >    +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
> >    |                                                         |
> >    +---------------------------------------------------------+
> >
> > The &p->pi_lock --> &rq->__lock sequence is very common in all the
> > task_rq_lock() calls.
> 
> Thanks for sending this out! I've been hitting these lockdep warningns
> a lot recently, particularly if I have any debug printks/WARN_ONs in
> the scheduler that trip, so I'm eager to get a fix for this!

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=debug/experimental

and use with: earlyprintk=serial,ttyS0,115200 force_early_printk, or
somesuch.

I could not have done perf or much of the sched patches without it.

