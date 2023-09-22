Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FC7ABBAA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjIVWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIVWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:15:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F619A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:15:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F90C433C9;
        Fri, 22 Sep 2023 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695420918;
        bh=KZAzIlymensHpeS8g6K9kxZZ7WQMm3JO+eEk1l2wXKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecQq/UdFUb3wBQ21d31FdbMsyf+eCk9oROSI2WjBVij9BgmBE+wgzcUmrdM71MMLs
         cajp8iz2/iaXkQ8RS0B9tz3ddv4LV6/rrcbVwqEhQ0cR02NIJgRFqs1CAtbyik97gV
         w89wASj8VnAm72hC4KZwttoACefzfh9AnJeSTgT7zhJc1eRIzEesiwZkQ/L7mu1pPl
         r+PCcle9EkqzU/dKV+l2/jN1vG+snxXJr3VTBf0XpHKFWUTIPthR1QdECtsHJqHUN7
         G1uum3AhRB9OnLDoPOfWV1rexKoZNQBqSDBWNYqIfWsxHQ7tCnH5+rN0IGwe0Mkjsu
         IVxc3nXI+COBA==
From:   SeongJae Park <sj@kernel.org>
To:     =?UTF-8?q?=E6=9D=A8=E6=AC=A2?= <link@vivo.com>
Cc:     "SeongJae Park" <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DATA ACCESS MONITOR" <damon@lists.linux.dev>,
        "open list:DATA ACCESS MONITOR" <linux-mm@kvack.org>,
        "opensource . kernel" <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/2] Damos filter cleanup code and implement workingset
Date:   Fri, 22 Sep 2023 22:15:15 +0000
Message-Id: <20230922221515.66785-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d060083d-ebdd-4966-9f41-87cef0d2c106@vivo.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huan,

On Fri, 22 Sep 2023 02:54:58 +0000 杨欢 <link@vivo.com> wrote:

> HI SJ,
> 
> Thanks for your patient response.

Happy to hear this kind acknowledgement :)

> > [Some people who received this message don't often get email from sj@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Huan,
> >
> >
> > First of all, thank you for this patch.  I have some high level comments and
> > questions as below.
> >
> > On Tue, 19 Sep 2023 17:52:33 +0800 Huan Yang <link@vivo.com> wrote:
> >
> >> Now damos support filter contains two type.
> >> The first is scheme filter which will invoke each scheme apply,
> >> second is scheme action filter, which will filter out unwanted action.
> > IMHO, that's not clear definition of the types.  Conceptually, all the filters
> > are same.  Nonetheless, they are having different behaviors because they are
> > handled in different layer depending on which layer is more efficient to handle
> Thanks for these instructions to help me understand the design idea of 
> damos filter.
> > those[1].
> >
> > I agree this is complicated and a bit verbose explanation, but I don't feel
> > your scheme vs action definition is making it easier to understand.
> >
> >> But this implement is scattered in different implementations
> > Indeed the implementation is scattered in core layer and the ops layer
> > depending on the filter types.  But I think this is needed for efficient
> > handling of those.
> 
> IMO, some simple filter can have a common implement, like anon filter? And,
> for some special type, each layer offer their own?

Do you mean there could be two filter types that better to be handled in
different layer for efficiency, but share common implementation?  Could you
please give me a more specific example?

> 
> >
> >> and hard to reuse or extend.
> >  From your first patch, which extending the filter, the essential change for the
> > extension is adding another enum to 'enum damos_filter_type' (1 line) and
> > addition of switch case in '__damos_pa_filter_out()' (3 lines).  I don't think
> > it looks too complicated.  If you're saying it was hard to understand which
> Yes, indeed.
> > part really need to be modifed, I think that makes sense.  But in the case,
> > we might need more comments rather than structural change.
> >
> >> This patchset clean up those filter code, move into filter.c and add header
> >> to expose filter func.(patch 2)
> > Again, I agree more code cleanup is needed.  But I'm not sure if this is the
> > right way.  Especially, I'm unsure if it really need to have a dedicated file.
> 
> I think the filter code scatter into each layer may make code hard to 
> reuse, other ops
> 
> may need anon filter or something. So, make code into a dedicated file 
> may good?
> 
> (just my opinion.)

Again, I'm not super confident about my understanding.  But sounds like you're
partly worrying about duplication of some code in each ops implementation
(modules in same layer).  Please correct me if I'm wrong, with specific,
detailed and realistic examples.

If my guess is not that wrong, I can agree to the concern.  Nevertheless, we
already have a dedicated source file for such common code between ops
implementaions, namely ops-common.c.

That said, we don't have duplicated DAMOS filters implementation code in
multipe ops implementation at the moment.  It could have such duplication in
the future, but I think it's not too late to make such cleanup after or just
before such duplication heppen.  IOW, I'd suggest to not make changes for
something that _might_ happen in future.

> 
> > To my humble eyes, it doesn't look like making code clearly easier to read
> > compared to the current version.  This is probably because I don't feel your
> > scheme vs action definition is clear to understand.  Neither it is
> Yes, indeed, current code not clean, the idea didn't take shape.
> > deduplicating code.  The patch adds lines more that deleted ones, according to
> > its diffstat.  For the reason, I don't see clear benefit of this change.
> In this code, maybe just a little benefit when other ops need to filter 
> anon page? :)

As mentioned above, it's unclear when, how, and for what benefit we will
support anon pages filter from vaddr.  I'd again suggest to not make change
only for future change that not clear if we really want to make for now.

> >    I
> > might be biased, having NIH (Not Invented Here) sindrome, or missing something.
> > Please let me know if so.
> >
> >> And add a new filter "workingset" to protect workingset page.
> > Can you explain expected use cases of this new filter type in more detail?
> > Specifically, for what scheme action and under what situation this new filter
> 
> IMO, page if marked as workingset, mean page in task's core 
> workload(maybe have
> 
> seen the refault, and trigger refault protect). So, for lru sort or reclaim,
> 
> we'd better not touch it?(If any wrong, please let me know.)

Still unclear to me.  Could I ask you more specific and detailed case?

> 
> > type will be needed?  If you have some test data for the use case and could
> > share it, it would be very helpful for me to understand why it is needed.
> 
> Sorry, this type just from my knowledge of MM, have no test data.
> 
> For futher learn of DAMON, I'll try it.

Yes, that will be very helpful.

And from this point, I'm getting an impression that the purpose of this RFC is
not for making a real change for specific use case that assumed to make real
benefits, but just for getting opinions about some imaginable changes that
_might_ be helpful, and _might_ be made in future.  If so, making the point
more clear would be helpful for me to give you opinion earlier.  If that's the
case, my opinion is this.  I agree DAMON code has many rooms of improvement in
terms of readability, so cleanup patches are welcome.  Nevertheless, I'd prefer
to make changes only when it is reasonable to expect it's providing _real_
improvement just after be applied, or at least very near and specific future.


Thanks,
SJ

> 
> >
> >> Do we need this and cleanup it?
> > I think I cannot answer for now, and your further clarification and patient
> > explanation could be helpful.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/Documentation/mm/damon/design.rst?h=mm-everything-2023-09-20-19-38#n400
> >
> >
> > Thanks,
> > SJ
> 
> Thanks,
> 
> Huan
> 
> >
> >> Huan Yang (2):
> >>    mm/damos/filter: Add workingset page filter
> >>    mm/damos/filter: Damos filter cleanup
> >>
> >>   include/linux/damon.h    |  62 +-----------------
> >>   mm/damon/Makefile        |   2 +-
> >>   mm/damon/core-test.h     |   7 ++
> >>   mm/damon/core.c          |  93 ++++-----------------------
> >>   mm/damon/filter.c        | 135 +++++++++++++++++++++++++++++++++++++++
> >>   mm/damon/filter.h        | 119 ++++++++++++++++++++++++++++++++++
> >>   mm/damon/paddr.c         |  29 +++------
> >>   mm/damon/reclaim.c       |  48 +++++++++++---
> >>   mm/damon/sysfs-schemes.c |   1 +
> >>   9 files changed, 325 insertions(+), 171 deletions(-)
> >>   create mode 100644 mm/damon/filter.c
> >>   create mode 100644 mm/damon/filter.h
> >>
> >> --
> >> 2.34.1
> >>
> >>
> 
