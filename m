Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D57A2DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjIPD6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 23:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjIPD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 23:57:31 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40119BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:57:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8195078f69so2316263276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 20:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694836645; x=1695441445; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCDJuHGZYWNBYWX3uyxB9QzeHGTQ1OKkFykmHwwuYKs=;
        b=XMe/Gx+Kb0TINAzPhFLUxYNllhsEpkRetuP9veLYbm+Aj8idua7nOrYB0XKLmLDl+x
         9AFHMPJ1XSgEwGOoC0S1fc6v1BB1UWHm1MzrfMXlAsduuyTWmkoPGLwXpcezuXK3LobC
         tZ5JNpMHUh1a30/rOA+0qWiXllFSuDQFGlJmHFCKKrdg5tN8vSMz/bl/vVYefLDRNAhW
         cW60Y5u0ueTFexa6t3dWx9qMX22c9yRqmr3Rtp0IyjiebuAEkq7axUJ65moZuyV45l9l
         ogHH3+uUbtpMpGdXN1jvtvF3z78WY3JhLIab+3DvQweUhiEpsZOmeJaGUImUu1wR++7X
         Lfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694836645; x=1695441445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCDJuHGZYWNBYWX3uyxB9QzeHGTQ1OKkFykmHwwuYKs=;
        b=aNyNVdIQitQIPqGkCUyPCdq4M6H6Kprskk7+t6OuvJkEWso8InX8elOcAEh0GM75RA
         7tQYD+jPm7hedsXalFcuaQBmNYVAvQ6b2uP/jFmcCbwOss6aEt6H+kPqYdFMX0RFHF2O
         +B5d8l9zDVC5IxC09aIvV9RPMOZfiUk8hRf0olKGdCJGuEWFBCyvkGxAW89j96DJrC50
         oE6LFlwrJoeiF/N4R+w98Y9kCzVddyL/957+lOSkL90Xrs0dRqqE/gpHnUu6937DPfv6
         5AfrFQzaJT+JHYxOEoFx2mq5K4obOfuJgNaDQYubtDPAtsQWbagz0R0LZWoFt7U4iCvi
         z5AA==
X-Gm-Message-State: AOJu0YyHKZ15YymODEQABEzNxAfDuciPPqNtkRUEjWyvXAuOTldD+yHo
        6ig6+WURgTOmOpVYtnmeJpMk9Q==
X-Google-Smtp-Source: AGHT+IHdHLhmhEJf9Vc6Bn6ZBhmj6ZjQazOOhDQ39VbDT7h6sHDMEpwsoGzfT5fq1eWhVCIf4sz9+A==
X-Received: by 2002:a25:23d5:0:b0:d7e:dd21:9b16 with SMTP id j204-20020a2523d5000000b00d7edd219b16mr3226387ybj.8.1694836645541;
        Fri, 15 Sep 2023 20:57:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c17-20020a5b0bd1000000b00d3596aca5bcsm1083611ybr.34.2023.09.15.20.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 20:57:24 -0700 (PDT)
Date:   Fri, 15 Sep 2023 20:57:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
In-Reply-To: <CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com>
Message-ID: <fc874e32-2a69-50ae-b1c9-5a982f16e1f1@google.com>
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com> <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com> <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com> <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com> <ZQNaT/3xPxATKJVR@casper.infradead.org>
 <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com> <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com> <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Yang Shi wrote:
> 
> Hi Suren and Hugh,
> 
> Thanks for figuring this out. The mbind behavior is a little bit messy
> and hard to follow. I tried my best to recall all the changes.

Messy and confusing yes; and for every particular behavior, I suspect
that by now there exists some release which has done it that way.

> 
> IIUC, mbind did break the vma iteration early in the first place, then
> commit 6f4576e3687b ("mempolicy: apply page table walker on
> queue_pages_range()") changed the behavior (didn't break vma iteration
> early for some cases anymore), but it messed up the return value and
> caused some test cases failure, also violated the manual. The return
> value issue was fixed by commit a7f40cfe3b7a ("mm: mempolicy: make
> mbind() return -EIO when MPOL_MF_STRICT is specified"), this commit
> also restored the oldest behavior (break loop early). But it also
> breaks the loop early when MPOL_MF_MOVE|MOVEALL is set, kernel should
> actually continue the loop to try to migrate all existing pages per
> the manual.

Oh, I missed that aspect in my description: yes, I think that's the
worst of it: MPOL_MF_STRICT alone could break out early because it had
nothing more to learn by going further, but it was simply a mistake for
the MOVEs to break out early (and arguable what MOVE|STRICT should do).

I thought you and I were going to have a debate about this, but we
appear to be in agreement.  And I'm not sure whether I agree with
myself about whether do_mbind() should apply the mbind_range()s
when STRICT queue_pages_range() found an unmovable - there are
consistency and regression arguments both ways.

(I've been repeatedly puzzled by your comment in queue_folios_pte_range()
		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
			/* MPOL_MF_STRICT must be specified if we get here */
			if (!vma_migratable(vma)) {
Does that commment about MPOL_MF_STRICT actually belong inside the
!vma_migratable(vma) block?  Sometimes I think so, but sometimes I
remember that the interaction of those flags, and the skipping arranged
by queue_pages_test_walk(), is subtler than I imagine.)

> It sounds like a regression. I will take a look at it.

Thanks! Please do, I don't have the time for it.

> 
> So the logic should conceptually look like:
> 
> if (MPOL_MF_MOVE|MOVEALL)
>     continue;
> if (MPOL_MF_STRICT)
>     break;
> 
> So it is still possible that some VMAs are not locked if only
> MPOL_MF_STRICT is set.

Conditionally, I'll agree; but it's too easy for me to agree in the
course of trying to get an email out, but on later reflection come
to disagree.  STRICT|MOVE behavior arguable.

I think the best I can do is send you (privately) my approx-v5.2 patch
for this (which I never got time to put into even a Google-internal
kernel, though an earlier version was there).  In part because I did
more research back then, and its commit message cites several even
older commits than you cite above, which might help to shed more light
on the history (or might just be wrong).  And in part because it may
give you some more ideas of what needs doing: notably qp->nr_failed,
because "man 2 migrate_pages" says "On success migrate_pages() returns
the number of pages that could not be moved", but we seem to have
lost sight of that (from which one may conclude that it's not very
important, but I did find it useful when testing); but of course
the usual doubts about the right way to count a page when compound.

I'll check how easily that patch applies to a known base such as
v5.2, maybe trim it to fit better, then send it off to you.

Hugh
