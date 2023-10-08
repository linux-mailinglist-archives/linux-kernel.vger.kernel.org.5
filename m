Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9E7BD031
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjJHVFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJHVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:05:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A7B6;
        Sun,  8 Oct 2023 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uZ6fRJpfdZ02bjnVpPGf7vgCC45VnPxsA0G8Tp1ZP8w=; b=modRTFHngoZgMNIpdoKNI8Xi3i
        1xPnPtKOiLrYfgswU01yZiXdqDCP4FvGOLtsKzoT5hVs2MuEj/3sBvxgLFCCRBYI+brDec62Z3WnM
        OLVQx/uFF0HUcCWzxgZsUGVPSRoIMp+QxHaG0LC32F99y8fRj8LWTcW5ROHCS8tzqTNxJUnAHY2+5
        1UEgC7Nqyh8wvdxRREjmGSCua168vsa7oQopUXTI++4gW96NdFhsYy9Ekn+hQf26ANxqCMic/XmEZ
        LB3x94IzGdpPFfBieT/P4hIxX5eNSRIJROOvpQCdF/x1i5W86erIdxCWK9f9kLYcuyXO5Lt+2o2tj
        AqTxam6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpaxm-00Bw97-7g; Sun, 08 Oct 2023 21:05:22 +0000
Date:   Sun, 8 Oct 2023 22:05:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fs: Add inode_assert_locked() and
 inode_assert_locked_excl()
Message-ID: <ZSMZkuJGgHyyqDWP@casper.infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org>
 <20231007203543.1377452-6-willy@infradead.org>
 <CAGudoHEg7oWG8CuyivWRsWLZZtw51oY0=PjLPRzFZDDZf=kzGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEg7oWG8CuyivWRsWLZZtw51oY0=PjLPRzFZDDZf=kzGg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 10:26:40PM +0200, Mateusz Guzik wrote:
> On 10/7/23, Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> > +static inline void inode_assert_locked_excl(const struct inode *inode)
> > +{
> > +	rwsem_assert_held_write(&inode->i_rwsem);
> > +}
> > +
> >  static inline void inode_lock_nested(struct inode *inode, unsigned
> > subclass)
> >  {
> >  	down_write_nested(&inode->i_rwsem, subclass);
> 
> Why "excl" instead of "write"? Apart from looking weird, it is
> inconsistent with "prior art" in the file: i_mmap_assert_write_locked.

Yes, but that pairs with i_mmap_lock_write() / i_mmap_lock_read().

The problem is that we have inode_lock() / inode_lock_shared()
inode_assert_locked_read/write doesn't make sense with them.  But
inode_assert_locked() doesn't make sense as the assertion for
inode_lock() because you'd expect it to assert whether the inode lock
is held at all.  So I went with inode_assert_locked_excl().

I wouldn't mind if we converted all the inode_lock()/shared to
inode_lock_read() / inode_lock_write(), and then added
inode_assert_read_locked() / inode_assert_write_locked().  That's
a bit of a bigger job than I want to take on today.
