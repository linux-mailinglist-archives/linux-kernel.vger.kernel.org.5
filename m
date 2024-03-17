Return-Path: <linux-kernel+bounces-105447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327E87DDF6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983CDB21002
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B741C6BD;
	Sun, 17 Mar 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEE4L9kZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589E1C6A4;
	Sun, 17 Mar 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689522; cv=none; b=fAVSI1beTjAOzHinmPaBRKYDBxDZSQyq7S1St26Co9JcGRciu1Qaof53Hqjg//xXoLQydn7K8GavoiEW983QOZuRdtV7xcQbsJxa/9H+SA/hkF00rt0wj9FSSvW2DY/8OP+pswJVfJi2JtGwMkynnRxF8C+/9zR2uP1hi3mfSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689522; c=relaxed/simple;
	bh=aCYFY/11lppuG/k/2U8haJIK+dIQGr4XGZfbv1NLwUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=I9+QHVO/dMsR0iFmrEJwVUCTRfbkIijSx6Ihh/96e4ruDdxXK2OVHkrdqVrn2Xtqz+cbpVQu2qtgrHPWbBveGBkdMR07UxHgvBdjkBQnUSdazzYjFM8XxqQlffGk9pSZE9NcJy9qjmOqQfaO4PE4dfYfhxxVKjENPvSXpj8tPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEE4L9kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CFC433C7;
	Sun, 17 Mar 2024 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710689521;
	bh=aCYFY/11lppuG/k/2U8haJIK+dIQGr4XGZfbv1NLwUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=hEE4L9kZT8zfLRt5F2baOwmW1D9Ggghq9Q2fJ1um2zpSmmwD4Y9VvtNk88rIj7+w4
	 gn6EgTLE3ER2QYQWUm9kaA7O21Wtd60duvdnMwEoc5vFfPu9+CSsDhkAHxiOOAnKU8
	 1/48GZbGsSiUZ/YwgQ3R4IURVjGnTdVVu8P4fhD5Mbp9YVAuJiulM42RjVwIL7Kmnf
	 aE3HIv6FCUQOzvKqWQnYEkC4Lm9GXm07nbljKNrbfVOaedyH8R1JfUA7YfON+eVXwF
	 RaeKdDpzKh8vGvpb6JnzFH9W6K9IJJ9s2TuZ9ibb++mk0QuUqTKQ2N2P09gWRDafw3
	 1RQ70y0IGzB3A==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Sun, 17 Mar 2024 08:31:44 -0700
Message-Id: <20240317153144.11931-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240317083635.2085-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Honggyu,

On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks for the confirmation.  I have a few comments on young filter so
> please read the inline comments again.
> 
> On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > Hi Honggyu,
> > 
> > > > -----Original Message-----
> > > > From: SeongJae Park <sj@kernel.org>
> > > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > > >
> > > > Hi Honggyu,
> > > >
> > > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > > >
> > > > > Hi SeongJae,
> > > > >
> > > > > I've tested it again and found that "young" filter has to be set
> > > > > differently as follows.
> > > > > - demote action: set "young" filter with "matching" true
> > > > > - promote action: set "young" filter with "matching" false
> > > >
> > > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > > the condition.  Hence in your setup, young pages are not filtered out from
> > > > demote action target.
> > > 
> > > I thought young filter true means "young pages ARE filtered out" for demotion.
> > 
> > You're correct.
> 
> Ack.
> 
> > > 
> > > > That is, you're demoting pages that "not" young.
> > > 
> > > Your explanation here looks opposite to the previous statement.
> > 
> > Again, you're correct.  My intention was "non-young pages are not ..." but
> > maybe I was out of my mind and mistakenly removed "non-" part.  Sorry for the
> > confusion.
> 
> No problem.  I also think it's quite confusing.
> 
> > > 
> > > > And vice versa, so you're applying promote to non-non-young (young) pages.
> > > 
> > > Yes, I understand "promote non-non-young pages" means "promote young pages".
> > > This might be understood as "young pages are NOT filtered out" for promotion
> > > but it doesn't mean that "old pages are filtered out" instead.
> > > And we just rely hot detection only on DAMOS logics such as access frequency
> > > and age. Am I correct?
> > 
> > You're correct.
> 
> Ack.  But if it doesn't mean that "old pages are filtered out" instead,

It does mean that.  Here, filtering is exclusive.  Hence, "filter-in a type of
pages" means "filter-out pages of other types".  At least that's the intention.
To quote the documentation
(https://docs.kernel.org/mm/damon/design.html#filters),

    Each filter specifies the type of target memory, and whether it should
    exclude the memory of the type (filter-out), or all except the memory of
    the type (filter-in).

> then do we really need this filter for promotion?  If not, maybe should
> we create another "old" filter for promotion?  As of now, the promotion
> is mostly done inaccurately, but the accurate migration is done at
> demotion level.

Is this based on your theory?  Or, a real behavior that you're seeing from your
setup?  If this is a real behavior, I think that should be a bug that need to
be fixed.

> To avoid this issue, I feel we should promotion only "young" pages after
> filtering "old" pages out.
> 
> > > 
> > > > I understand this is somewhat complex, but what we have for now.
> > > 
> > > Thanks for the explanation. I guess you mean my filter setup is correct.
> > > Is it correct?
> > 
> > Again, you're correct.  Your filter setup is what I expected to :)
> 
> Thanks.  I see that it works fine, but I would like to have more
> discussion about "young" filter.  What I think about filter is that if I
> apply "young" filter "true" for demotion, then the action applies only
> for "young" pages, but the current implementation works opposite.
> 
> I understand the function name of internal implementation is
> "damos_pa_filter_out" so the basic action is filtering out, but the
> cgroup filter works in the opposite way for now.

Does memcg filter works in the opposite way?  I don't think so because
__damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
contained in the given memcg.  'young' filter also simply sets 'matches' as
'true' only if the given folio is young.

If it works in the opposite way, it's a bug that need to be fixed.  Please let
me know if I'm missing something.

> 
> I would like to hear how you think about this.
> 
> > > 
> > > > > Then, I see that "hot_cold" migrates hot/cold memory correctly.
> > > >
> > > > Thank you so much for sharing this great news!  My tests also show no bad
> > > > signal so far.
> > > >
> > > > >
> > > > > Could you please upload the "damon_folio_mkold" patch to LKML?
> > > > > Then I will rebase our changes based on it and run the redis test again.
> > > >
> > > > I will do that soon.
> > > 
> > > Thanks a lot for sharing the RFC v2 for DAMOS young filter.
> > > https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org/
> > > 
> > > I will rebase our work based on it and share the result.
> > 
> > Cool, looking forward to it!  Hopefully we will make it be merged into the
> > mainline by v6.10!
> 
> I hope so.  Thanks for your help!
> 
> Honggyu


Thanks,
SJ

