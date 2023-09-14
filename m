Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E37A0FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjINVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjINVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:24:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A21CEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mZz4t+gdKYS6tcBsbAuh03VOVbJbXzYNs5f6Rm45kBw=; b=AiOe4IK887hUNxiFVqKkg+HuQW
        i3z1RT7BL1F1YNYNpMPfqNP2vIuq7t7QIg18sw1HJrCuX8PDvXyrqhRdbPMyvery+HcEeL2D8phK8
        XGEN9Vq9H8VXiImvdy55ItXT5TZJhDDJmQWnT9sW+dE/th1uVRKRFCc7TSf3blUSJR3u3BKzHaC5I
        dAsl6lfiCtpZirgmkV58mkC/5hoFP5HGzoCHzguzBXajRIr2eutmkdrs7AnACjFKPMSDPvtycFZZ2
        pwx2HfZy/1+R/a73pgF7BqP2Y6wgf3WJXe1LP3WeYlROfO7BUhmu9K5uIJIX0AcjdFy9SSF1hNDBZ
        Tr7HyGFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgtog-005HEe-SZ; Thu, 14 Sep 2023 21:24:02 +0000
Date:   Thu, 14 Sep 2023 22:24:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
Message-ID: <ZQN58hFWfgn+OfvG@casper.infradead.org>
References: <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org>
 <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
 <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:53:59PM +0000, Suren Baghdasaryan wrote:
> On Thu, Sep 14, 2023 at 8:00 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 7:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrote:
> > > > I think I found the problem and the explanation is much simpler. While
> > > > walking the page range, queue_folios_pte_range() encounters an
> > > > unmovable page and queue_folios_pte_range() returns 1. That causes a
> > > > break from the loop inside walk_page_range() and no more VMAs get
> > > > locked. After that the loop calling mbind_range() walks over all VMAs,
> > > > even the ones which were skipped by queue_folios_pte_range() and that
> > > > causes this BUG assertion.
> > > >
> > > > Thinking what's the right way to handle this situation (what's the
> > > > expected behavior here)...
> > > > I think the safest way would be to modify walk_page_range() and make
> > > > it continue calling process_vma_walk_lock() for all VMAs in the range
> > > > even when __walk_page_range() returns a positive err. Any objection or
> > > > alternative suggestions?
> > >
> > > So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > > specified.  That means we're going to return an error, no matter what,
> > > and there's no point in calling mbind_range().  Right?
> > >
> > > +++ b/mm/mempolicy.c
> > > @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, unsigned long len,
> > >         ret = queue_pages_range(mm, start, end, nmask,
> > >                           flags | MPOL_MF_INVERT, &pagelist, true);
> > >
> > > +       if (ret == 1)
> > > +               ret = -EIO;
> > >         if (ret < 0) {
> > >                 err = ret;
> > >                 goto up_out;
> > >
> > > (I don't really understand this code, so it can't be this simple, can
> > > it?  Why don't we just return -EIO from queue_folios_pte_range() if
> > > this is the right answer?)
> >
> > Yeah, I'm trying to understand the expected behavior of this function
> > to make sure we are not missing anything. I tried a simple fix that I
> > suggested in my previous email and it works but I want to understand a
> > bit more about this function's logic before posting the fix.
> 
> So, current functionality is that after queue_pages_range() encounters
> an unmovable page, terminates the loop and returns 1, mbind_range()
> will still be called for the whole range
> (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1345),
> all pages in the pagelist will be migrated
> (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1355)
> and only after that the -EIO code will be returned
> (https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L1362).
> So, if we follow Matthew's suggestion we will be altering the current
> behavior which I assume is not what we want to do.

Right, I'm intentionally changing the behaviour.  My thinking is
that mbind(MPOL_MF_MOVE | MPOL_MF_STRICT) is going to fail.  Should
such a failure actually move the movable pages before reporting that
it failed?  I don't know.

> The simple fix I was thinking about that would not alter this behavior
> is smth like this:

I don't like it, but can we run it past syzbot to be sure it solves the
issue and we're not chasing a ghost here?
