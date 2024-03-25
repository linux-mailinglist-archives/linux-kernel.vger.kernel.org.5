Return-Path: <linux-kernel+bounces-118144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291F88B48B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF51F63C97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD480C0D;
	Mon, 25 Mar 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Keb4PkxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FF7FBDC;
	Mon, 25 Mar 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407187; cv=none; b=GrIB/w+qzTsixucdAKPgO/goil5nosYkwQA2ds/fmckWtoPxOGqnLxvKt2FvsjK5X6MZcd9PC3OMZfIDKkNMTWGCqXR0kEuecJ6EeWx/xo40G85/zjGwLeEFmkkcEvGDgEQAXVFF1aI9wqXlr6FYyXDqtQLWF7FcFTc3HMFold8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407187; c=relaxed/simple;
	bh=ljVYVSahgnqQzJ4KwzCiQ0uzQsg+xQTx/hr9gGB+Iug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNV+j5cXX+dG+f+Kq/EBVJWC+gyGzokLr2ODtqscc0UfOJOrE8YBmJDS1ywCrjncpTeIh1ohkSS/uoza0Kvn/ZjNHmaXe0luGjgiiG2MYb7OJLIQmZsl5miupGdWdzm8RZPldXak6sG02tsfdOb+QmsS6RJ2RgAUJMH5EKUaryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Keb4PkxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C6C433F1;
	Mon, 25 Mar 2024 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711407186;
	bh=ljVYVSahgnqQzJ4KwzCiQ0uzQsg+xQTx/hr9gGB+Iug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Keb4PkxST0YJtRTWJGR3/6IYV4hiyPQbiDkAtjnGFDOcKDRmhP9T4PSsB5vYxOLJb
	 f6nHJTY6WbxH6hUnbXFpH32SP8mvMoWBC18au9J7XPsD00v/QKiVeGSugyg9HkyMrx
	 6GciER951lyA1LFnabSPpK5pGzT7yL3u+NHjn5grhHxNKURmT+Z1q6PqAAVwdiUvmR
	 yYibofWAuA5liLoUXKEOl0i0Ldkc3wBJ/qWqB634mWK834xMQbhj9L9j3NJh27vBaG
	 gpHoPGF4E+KqfiLF7O1AlSyI2fDIISl2nT1fxgAQ7rCNxo63CZDyf8ROrQwixuoEjZ
	 ppwiZ6N4NmMMg==
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
Date: Mon, 25 Mar 2024 15:53:03 -0700
Message-Id: <20240325225304.235736-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325120108.2328-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 21:01:04 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On Fri, 22 Mar 2024 09:32:23 -0700 SeongJae Park <sj@kernel.org> wrote:
> > On Fri, 22 Mar 2024 18:02:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > > > Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> > > > this patchset in high level.  Sharing the summary here for open discussion.  As
> > > > also discussed on the first version of this patchset[2], we want to make single
> > > > action for general page migration with minimum changes, but would like to keep
> > > > page level access re-check.  We also agreed the previously proposed DAMOS
> > > > filter-based approach could make sense for the purpose.
> > > 
> > > Thanks very much for the summary.  I have been trying to merge promote
> > > and demote actions into a single migrate action, but I found an issue
> > > regarding damon_pa_scheme_score.  It currently calls damon_cold_score()
> > > for demote action and damon_hot_score() for promote action, but what
> > > should we call when we use a single migrate action?
> > 
> > Good point!  This is what I didn't think about when suggesting that.  Thank you
> > for letting me know this gap!  I think there could be two approach, off the top
> > of my head.
> > 
> > The first one would be extending the interface so that the user can select the
> > score function.  This would let flexible usage, but I'm bit concerned if this
> > could make things unnecessarily complex, and would really useful in many
> > general use case.
> 
> I also think this looks complicated and may not be useful for general
> users.
> 
> > The second approach would be letting DAMON infer the intention.  In this case,
> > I think we could know the intention is the demotion if the scheme has a youg
> > pages exclusion filter.  Then, we could use the cold_score().  And vice versa.
> > To cover a case that there is no filter at all, I think we could have one
> > assumption.  My humble intuition says the new action (migrate) may be used more
> > for promotion use case.  So, in damon_pa_scheme_score(), if the action of the
> > given scheme is the new one (say, MIGRATE), the function will further check if
> > the scheme has a filter for excluding young pages.  If so, the function will
> > use cold_score().  Otherwise, the function will use hot_score().
> 
> Thanks for suggesting many ideas but I'm afraid that I feel this doesn't
> look good.  Thinking it again, I think we can think about keep using
> DAMOS_PROMOTE and DAMOS_DEMOTE,

In other words, keep having dedicated DAMOS action for intuitive prioritization
score function, or, coupling the prioritization with each action, right?  I
think this makes sense, and fit well with the documentation.

    The prioritization mechanism should be different for each action.  For example,
    rarely accessed (colder) memory regions would be prioritized for page-out
    scheme action.  In contrast, the colder regions would be deprioritized for huge
    page collapse scheme action.  Hence, the prioritization mechanisms for each
    action are implemented in each DAMON operations set, together with the actions.

In other words, each DAMOS action should allow users intuitively understand
what types of regions will be prioritized.  We already have such couples of
DAMOS actions such as DAMOS_[NO]HUGEPAGE and DAMOS_LRU_[DE]PRIO.  So adding a
couple of action for this case sounds reasonable to me.  And I think this is
better and simpler than having the inferrence based behavior.

That said, I concern if 'PROMOTE' and 'DEMOTE' still sound bit ambiguous to
people who don't know 'demote_folio_list()' and its friends.  Meanwhile, the
name might sound too detail about what it does to people who know the
functions, so make it bit unflexible.  They might also get confused since we
don't have 'promote_folio_list()'.

To my humble understanding, what you really want to do is migrating pages to
specific address range (or node) prioritizing the pages based on the hotness.
What about, say, MIGRATE_{HOT,COLD}?

> but I can make them directly call
> damon_folio_young() for access check instead of using young filter.
> 
> And we can internally handle the complicated combination such as demote
> action sets "young" filter with "matching" true and promote action sets
> "young" filter with "matching" false.  IMHO, this will make the usage
> simpler.

I think whether to exclude young/non-young (maybe idle is better than
non-young?) pages from the action is better to be decoupled for following
reasons.

Firstly, we want to check the page granularity youngness mainly because we
found DAMON's monitoring result is not accurate enough for this use case.  Or,
we could say that's because you cannot wait until DAMON's monitoring result
becomes accurate enough.  For more detail, you could increase minimum age of
your scheme's target access pattern.  I show you set minimum age of your demote
scheme as 30 seconds, but set promote scheme as 0 sec
(https://github.com/skhynix/hmsdk/blob/main/tools/gen_config.py).  Increasing
the minimum age for promote scheme may reduce amount of wrong promotion.  But I
assume you don't want to do that, maybe because you want to make promotion
fast.  That's 100% valid use case in my opinion.  And for such use case, making
the DAMOS action to do the page granularity access check would be helpful.  But
if the user can set minimum age of two schemes large enough, or somehow DAMON's
monitoring accuracy is much improved, this page granularity access check might
not really required.

Secondly, I think we might want to migrate pages to other nodes in coldest
pages first way, but even if the page is young.  One such case would be when
the top tier cannot accommodate all young pages.  Especially when there are no
small number of tiers, I think this could happen.  That is, we would prefer
migrating coldest page first, but that depend on only relative temperature and
hence young pages could also need to be migrated.  Of course, this would be the
real case only if the user is convinced with DAMON's monitoring accuracy.

> 
> I would like to hear how you think about this.

So, to summarize my humble opinion,

1. I like the idea of having two actions.  But I'd like to use names other than
   'promote' and 'demote'.
2. I still prefer having a filter for the page granularity access re-check.

> 
> > So I'd more prefer the second approach.  I think it would be not too late to
> > consider the first approach after waiting for it turns out more actions have
> > such ambiguity and need more general interface for explicitly set the score
> > function.
> 
> I will join the DAMON Beer/Coffee/Tea Chat tomorrow as scheduled so I
> can talk more about this issue.

Looking forward to chatting with you :)


Thanks,
SJ

> 
> Thanks,
> Honggyu
> 
> > 
> > Thanks,
> > SJ
> > 
> > [...]

