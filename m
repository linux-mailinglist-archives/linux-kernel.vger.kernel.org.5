Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583807A2D94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 05:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjIPCyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjIPCyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:54:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9A1BD2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:54:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c26aa19b7so7637437b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694832859; x=1695437659; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRgYEKeBnhc137LJPUJ1YX5jXl/+dvV/D/bsE7EFVFU=;
        b=ruaSHKEQKnnwpWuTTIeLxtcg3C4ijVzzFj7/rAGJGT6xzsobYUlPuZ5VsLKvi1TqWI
         zPPjMa+kR0HW9p3PtE/1eH5MgXgFt0n/GLJh6s3EuOgtqmejdKZPHnYwNXrpwBK3Sw6P
         uPRlb0c+eQUMgrrEUODBgD8KW6yGMI2YTXBcRrZuxmVWFSwSEeTta4mSoX8jF0oQF2TV
         EzT6/xQ/v5/0BjCS1loytBSf6AnzcE4NRezshCbhgrP5QPcROsXwIx4IRg2YbjObfrvo
         G7EZLtb6F62FUdJnWb34U54AR6mAaL00itz3wv9OIp+ba8GVQS2VqSRtoZ+8HtIoGX4N
         C76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694832859; x=1695437659;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRgYEKeBnhc137LJPUJ1YX5jXl/+dvV/D/bsE7EFVFU=;
        b=LF+0vynr1NIVj9ReBwT3oFnYTDmVK9ii6olUTOEBQK79G77T9kj0SAbjREEDAIpmF6
         HWC7RBpL7VLXGNfXwT3sYR20BFWb92POQrmM0pU0fWKd0xMmfO6tU0L+kUxC40W06VkY
         uwvcjj8NbZUy+xkYENXZwYclEB05rYYqjGakmW6Q8ufPmD6jMuE3/jaBtl1qB0jQeyY7
         4O9DeQJ898Ah9i6R+5+7RfdeBcCJN+bi3TOaL+PKA937maeHP8tTQ9tnl1ejT+2A5dVT
         2fFpWHZ4POLG8cfIOAQ0t2mzdCI1MM9Ju9EQx7oDO0L9Hn8aXmOT5F+ZE8dWkaOlI1BH
         naqA==
X-Gm-Message-State: AOJu0Yw81nhUbkBBPZmP1dcJ/T84TMmx2rgW/JvJwQBjAuDq79gX/eyP
        TS/mEU9N5fftKIHHms4Sh93TWA==
X-Google-Smtp-Source: AGHT+IGyKMGHnMEM0WFtSTclUrFRubYqjyVdCHiMGPhbY5XPEn9cF7hIB744pXwvKTtzMGrN/Y+6mQ==
X-Received: by 2002:a81:73d5:0:b0:59c:3f8:b0ab with SMTP id o204-20020a8173d5000000b0059c03f8b0abmr4202510ywc.41.1694832859109;
        Fri, 15 Sep 2023 19:54:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u127-20020a0dd285000000b0059bce30a498sm1196082ywd.139.2023.09.15.19.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 19:54:18 -0700 (PDT)
Date:   Fri, 15 Sep 2023 19:54:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
In-Reply-To: <ZQShw8lESIBle7GF@casper.infradead.org>
Message-ID: <ace766bc-49c1-8399-9548-5faac04e87c8@google.com>
References: <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com> <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com> <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org> <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com> <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <ZQShw8lESIBle7GF@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Matthew Wilcox wrote:
> On Thu, Sep 14, 2023 at 09:26:15PM -0700, Hugh Dickins wrote:
> > On Thu, 14 Sep 2023, Suren Baghdasaryan wrote:
> > > Yes, I just finished running the reproducer on both upstream and
> > > linux-next builds listed in
> > > https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023 and the
> > > problem does not happen anymore.
> > > I'm fine with your suggestion too, just wanted to point out it would
> > > introduce change in the behavior. Let me know how you want to proceed.
> > 
> > Well done, identifying the mysterious cause of this problem:
> > I'm glad to hear that you've now verified that hypothesis.
> > 
> > You're right, it would be a regression to follow Matthew's suggestion.
> > 
> > Traditionally, modulo bugs and inconsistencies, the queue_pages_range()
> > phase of do_mbind() has done the best it can, gathering all the pages it
> > can that need migration, even if some were missed; and proceeds to do the
> > mbind_range() phase if there was nothing "seriously" wrong (a gap causing
> > -EFAULT).  Then at the end, if MPOL_MF_STRICT was set, and not all the
> > pages could be migrated (or MOVE was not specified and not all pages
> > were well placed), it returns -EIO rather than 0 to inform the caller
> > that not all could be done.
> > 
> > There have been numerous tweaks, but I think most importantly
> > 5.3's d883544515aa ("mm: mempolicy: make the behavior consistent when
> > MPOL_MF_MOVE* and MPOL_MF_STRICT were specified") added those "return 1"s
> > which stop the pagewalk early.  In my opinion, not an improvement - makes
> > it harder to get mbind() to do the best job it can (or is it justified as
> > what you're asking for if you say STRICT?).
> 
> I suspect you agree that it's inconsistent to stop early.  Userspace
> doesn't know at which point we found an unmovable page, so it can't behave
> rationally.  Perhaps we should remove the 'early stop' and attempt to
> migrate every page in the range, whether it's before or after the first
> unmovable page?

Yes, that's what I was arguing for, and how it was done in olden days.
Though (after Yang Shi's following comments, and looking back at my
last attempted patch here) I may disagree with myself about the right
behavior in the MPOL_MF_STRICT case.

Hugh
