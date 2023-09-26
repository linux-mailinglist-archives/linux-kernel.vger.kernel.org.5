Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF87AF6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjIZXZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIZXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:23:56 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0871D2BE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:26:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f7f2b1036so64729837b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695767194; x=1696371994; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbFIlMORbziITyrsaSLyTK41iB8rjgVNurdwEqb6c0=;
        b=qL0Qmnlzb7+arQVX8tYS+X/q95U2DNC5+mk4laHNhrhh0lOBUFgL+QDsCm+mJe0usP
         xi3jtPEy+mBgLAXjCkUSnR7IdULkIhtxLshJecQIST1UJ54Hnu/nqLnDokMPvlS6ZXqk
         +1RpZBaAH1sufXGJzpNHAQJPkCnf3bmq/lS/ZGl4Hlmj5AVIXjx4Dnz0OBHuXPY5gI5I
         GYudBxciU+fv2t+ScV5OATw38OBFs3yqbpTwWD8aKpEwsfEm6y8Sk5d5NZgbT+Ec/Flw
         OSP/fp3PGzXmBXIVF4Bqi69dFjATon+hlqi3RMftWo31vQpyb79xE9XCfFCSt0PrwdjH
         X/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695767194; x=1696371994;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYbFIlMORbziITyrsaSLyTK41iB8rjgVNurdwEqb6c0=;
        b=R+IQ8tHZz/bjZhxwdImu5cDD8SuMGI4TVZ/X8t/5EvUM657vtosi89pHYd2o3jQt9n
         WfYDSi9GCY/slXTwJFpId2ZIyYj3ypO33WcePNQ0xvhTKc27xU2mYgA+FIcn98UGylo9
         DKcaW4iFpgiuEmspdni4WOX2ZEN12qw/3M4tweCR7FkHjY+u03U3KRWx5UkMEmVh7dR1
         OONGWYQFiL8V2ko2lkSZT57Slj2/6SraZn0gPO8qIu5QSLoCsCJZZwn/QfyhPkO8Ur1n
         n/4IxHoCIjQYuFKh0xxUOuSDOdUy7x2S1DYfFuQisJf2rOdosmPSW9vHNfx5rY0a0o+W
         XZ8w==
X-Gm-Message-State: AOJu0YzFqdkgWHTqvIgyKz1ieWcugPkDUWRNcvKYuaO+XtjxQxUr8fy0
        /6qL7AyT+RHAWg4qXzHuF1cbAA==
X-Google-Smtp-Source: AGHT+IF9jPJKKbPbLozWLtjId6Ao3wXXOxJwCf/sIy78tp0PT65c4W1ooGQqDIcwlOgnemDGDZ/qxQ==
X-Received: by 2002:a81:484f:0:b0:59f:4c3a:711d with SMTP id v76-20020a81484f000000b0059f4c3a711dmr296396ywa.11.1695767194061;
        Tue, 26 Sep 2023 15:26:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r188-20020a0dcfc5000000b00565271801b6sm3271891ywd.59.2023.09.26.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 15:26:33 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:26:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andi Kleen <ak@linux.intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/12] hugetlbfs: drop shared NUMA mempolicy pretence
In-Reply-To: <ZRINx/53KKUibbGb@tassilo>
Message-ID: <45aa39c0-9b14-3e5-a81a-70a6403a8432@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <47a562a-6998-4dc6-5df-3834d2f2f411@google.com> <ZRINx/53KKUibbGb@tassilo>
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

On Mon, 25 Sep 2023, Andi Kleen wrote:
> On Mon, Sep 25, 2023 at 01:21:10AM -0700, Hugh Dickins wrote:
> > hugetlbfs_fallocate() goes through the motions of pasting a shared NUMA
> > mempolicy onto its pseudo-vma, but how could there ever be a shared NUMA
> > mempolicy for this file?  hugetlb_vm_ops has never offered a set_policy
> > method, and hugetlbfs_parse_param() has never supported any mpol options
> > for a mount-wide default policy.
> > 
> > It's just an illusion: clean it away so as not to confuse others, giving
> > us more freedom to adjust shmem's set_policy/get_policy implementation.
> > But hugetlbfs_inode_info is still required, just to accommodate seals.
> > 
> > Yes, shared NUMA mempolicy support could be added to hugetlbfs, with a
> > set_policy method and/or mpol mount option (Andi's first posting did
> > include an admitted-unsatisfactory hugetlb_set_policy()); but it seems
> > that nobody has bothered to add that in the nineteen years since v2.6.7
> > made it possible, and there is at least one company that has invested
> > enough into hugetlbfs, that I guess they have learnt well enough how to
> > manage its NUMA, without needing shared mempolicy.
> 
> TBH i'm not sure people in general rely on shared mempolicy. The
> original use case for it was to modify the numa policy of non anonymous
> shared memory files without modifying the program (e.g. Oracle
> database's shared memory segments)

Ah, "without modifying the program": that makes a lot of sense, but
I had never thought of it that way - I just saw it as the right way to
manage the shared object (though an outlier, since we have so many other
msyscall()s which do not manage the underlying shared object in this way).

> 
> But I don't think that particular usage model ever got any real
> traction: at leas I haven't seen any real usage of it outside my tests.

If the hugetlbfs support had actually gone in, I imagine Oracle would
have managed it that way; but they seem to have survived well without.

> 
> I suspect people either are fine with just process policy or modify the
> program, in which case it's not a big burden to modify every user,
> so process policy or vma based mbind policy works fine.
> 
> Maybe it would be an interesting experiment to disable it everywhere
> with some flag and see if anybody complains.
> 
> On the other hand it might be Hyrum'ed by now.

This is interesting info, Andi, thank you for providing.

I'm torn.  shmem and mempolicy (and struct vm_operations_struct) would
certainly be simpler without shared mempolicy: but I frankly don't have
the time and courage to experiment with deprecating it now; and it is
fundamentally right that such policy should be kept with the object,
not with its mappings.  I've assumed for years that it has to stay.

Hugh
