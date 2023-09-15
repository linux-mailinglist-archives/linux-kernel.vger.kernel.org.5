Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6517A25AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbjIOS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjIOS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:27:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC52D60
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f5vxbstncXGDTYF4k8iBAO/uRU8zJv+hlaWNzlrq5m4=; b=fWK/ibyb6ETNzkHlnHyn9gX1RS
        Fmd7YQNPRUfcacHqJp6y9G+nRfF0x6E75zxeHzf95FBuFmoCiiZe1a3cJDq+Gfm8sreTmj3EajlvQ
        JF7/jGs0EwsxeHvQyg4ZySBqsCi2XtlteoDCDTl9bGfG2ophERMZ89K++B9Z7YHXlbCXQobz03emV
        Yy5XRpP3xa/DHm84iSkQcAtBmaAOyjQlyOCrXQuYqLpDROULAcbUJiXNapPCyB6bnhxDndGxG/p7R
        jie1+97gfLzKQQYMkh3q7MRww2A2G78LL5GQ4xtZ0fHnnHCUBvE+jJZawlNIePSdb1jFk9Wm/7gma
        9y8MlWZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDW7-00BJSR-LJ; Fri, 15 Sep 2023 18:26:11 +0000
Date:   Fri, 15 Sep 2023 19:26:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
Message-ID: <ZQShw8lESIBle7GF@casper.infradead.org>
References: <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
 <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com>
 <ZQN58hFWfgn+OfvG@casper.infradead.org>
 <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:26:15PM -0700, Hugh Dickins wrote:
> On Thu, 14 Sep 2023, Suren Baghdasaryan wrote:
> > Yes, I just finished running the reproducer on both upstream and
> > linux-next builds listed in
> > https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023 and the
> > problem does not happen anymore.
> > I'm fine with your suggestion too, just wanted to point out it would
> > introduce change in the behavior. Let me know how you want to proceed.
> 
> Well done, identifying the mysterious cause of this problem:
> I'm glad to hear that you've now verified that hypothesis.
> 
> You're right, it would be a regression to follow Matthew's suggestion.
> 
> Traditionally, modulo bugs and inconsistencies, the queue_pages_range()
> phase of do_mbind() has done the best it can, gathering all the pages it
> can that need migration, even if some were missed; and proceeds to do the
> mbind_range() phase if there was nothing "seriously" wrong (a gap causing
> -EFAULT).  Then at the end, if MPOL_MF_STRICT was set, and not all the
> pages could be migrated (or MOVE was not specified and not all pages
> were well placed), it returns -EIO rather than 0 to inform the caller
> that not all could be done.
> 
> There have been numerous tweaks, but I think most importantly
> 5.3's d883544515aa ("mm: mempolicy: make the behavior consistent when
> MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") added those "return 1"s
> which stop the pagewalk early.  In my opinion, not an improvement - makes
> it harder to get mbind() to do the best job it can (or is it justified as
> what you're asking for if you say STRICT?).

I suspect you agree that it's inconsistent to stop early.  Userspace
doesn't know at which point we found an unmovable page, so it can't behave
rationally.  Perhaps we should remove the 'early stop' and attempt to
migrate every page in the range, whether it's before or after the first
unmovable page?

