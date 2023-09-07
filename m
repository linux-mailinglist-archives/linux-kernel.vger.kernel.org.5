Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27B797CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbjIGTeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbjIGTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468821BD7;
        Thu,  7 Sep 2023 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SpYv2F9GuCNC42djvfZFztSGAgqrLyKSLHEQbRhwUj0=; b=fAsRp5j1Qs1zwKnTCP1RH0ZM7Q
        nkwjBmIR3S6SNFMP1Ys5jSENKZ0SujYaWY+X2drfKb8LF6Z+M0IBLZgMPQ+w/FPYbFaSmE25MQpSS
        gWsWZxazrLmIwEFKFdu3SfSSfYCv1xNlqQiDWiXsgUlUosIUDj9cHWxcZ18Z+5q0f7O9nZ9Z/1rNw
        ofg0W1KJvxcJwDtCxY1HrZFcgpBZxNjq/TKUBRty94ivbF3PJ1UKnd0IqhKWUE2is7Hnc5pc5fT+Y
        HRfYOQb6J5zTQNSm/31mC47poT0NpAae87W4Z5uokr6Dc4nBhuSBSetj9UyJ5Go1RfKJexmIcEPVk
        QSlwfL2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeKlJ-00D2hf-CV; Thu, 07 Sep 2023 19:33:57 +0000
Date:   Thu, 7 Sep 2023 20:33:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZPolpUuCiGT/5PLO@casper.infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <2cd975ec-f868-f180-350f-b1b704118777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd975ec-f868-f180-350f-b1b704118777@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:05:54PM -0400, Waiman Long wrote:
> On 9/7/23 13:47, Matthew Wilcox (Oracle) wrote:
> > +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> > +{
> > +	return atomic_long_read(&sem->count) & 1 /* RWSEM_WRITER_LOCKED */;
> > +}
> 
> I would prefer you move the various RWSEM_* count bit macros from
> kernel/locking/rwsem.c to under the !PREEMPT_RT block and directly use
> RWSEM_WRITER_LOCKED instead of hardcoding a value of 1.

Just to be clear, you want the ~50 lines from:

/*
 * On 64-bit architectures, the bit definitions of the count are:
...
#define RWSEM_READ_FAILED_MASK  (RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
                                 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)

moved from rwsem.c to rwsem.h?

Or just these four lines:

#define RWSEM_WRITER_LOCKED     (1UL << 0)
#define RWSEM_FLAG_WAITERS      (1UL << 1)
#define RWSEM_FLAG_HANDOFF      (1UL << 2)
#define RWSEM_FLAG_READFAIL     (1UL << (BITS_PER_LONG - 1))

