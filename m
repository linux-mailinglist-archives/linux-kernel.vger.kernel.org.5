Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2087E7AC6F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjIXHT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:19:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD63E100
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQog87/EAGD1kuKRgoTr1CslLjKeFhqkq6roBcGXn7U=; b=fYulvVlr29MHtBp/H3NSYcHVp7
        ZQlgDEDnWs+EhrE+v61h5mCrxCqb1oAQb68p3UU4nL2W/FxyRB52IOMzDBos4mg9ovJQhHr5bVSCi
        A3tRJV5s5AmFYqNSCEN6CWxDizZGMslMj1OhMC5avgzs3phHW0+/TJJBo47f6KAofU721Nrc9a1jQ
        81tNZIjKJ43lcPlN2KRcUlH7kPdT/Xc7koFbMkJFVfx5/iw9ro9hlf9eG0Ny78x2cvq/5U7Hys38F
        2ereuHO/zgWdjddDYq+D1tIl1QHm5NU9rV/E281QzHNDUKPVpYiQwZ+tTgX30okeYM+TWFwR/IaoA
        ybqhOyaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkJOS-00Bfih-3a; Sun, 24 Sep 2023 07:19:04 +0000
Date:   Sun, 24 Sep 2023 08:19:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQ/i6CC86PzaYCzw@casper.infradead.org>
References: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <87h6nkh5bw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6nkh5bw.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 12:50:43AM +0200, Thomas Gleixner wrote:
> cond_resched() cannot nest and is obviously scope-less.
> 
> The TIF_ALLOW_RESCHED mechanism, which sparked this discussion only
> pretends to be scoped.
> 
> As Peter pointed out it does not properly nest with other mechanisms and
> it cannot even nest in itself because it is boolean.

We can nest a single bit without turning it into a counter -- we
do this for memalloc_nofs_save() for example.  Simply return the
current value of the bit, and pass it to _restore().

eg xfs_prepare_ioend():

        /*
         * We can allocate memory here while doing writeback on behalf of
         * memory reclaim.  To avoid memory allocation deadlocks set the
         * task-wide nofs context for the following operations.
         */
        nofs_flag = memalloc_nofs_save();

        /* Convert CoW extents to regular */
        if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
                status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
                                ioend->io_offset, ioend->io_size);
        }

        memalloc_nofs_restore(nofs_flag);

I like your other approach better, but just in case anybody starts
worrying about turning a bit into a counter, there's no need to do
that.
