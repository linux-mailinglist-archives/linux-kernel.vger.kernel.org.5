Return-Path: <linux-kernel+bounces-111783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44A8870EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA23282D76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367485B5D9;
	Fri, 22 Mar 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmSZoHQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3375CDC0;
	Fri, 22 Mar 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125147; cv=none; b=BhEo4fG2rPkhL5x7fbWD93UwEycb0xyvtNZ+l+Up0ejW+hkdq5Knd9GIRQBNT9hmJamIlQaIlr/SYtMbbzbfX7uytumEiRXcHbk9r9xFHS7YeFbwmGDZ7/EUEPPm75yq+1mxkK32f3fEqJTUjzIiVtYglxMeUQNh7KcqeLSh0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125147; c=relaxed/simple;
	bh=otOiDrXv7vSEtDQG9vjhed+cuW5roGWlH4xO15itNQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVNd8U23+uMWS/3AsrAKU7Jv0jMUXfvgbgPKXZSNL/xnPeOFQKZgnnK3oMGBREUPqCyKzKOL5CAlAW6kBGZGSNPK/X2SPJQ0yynmYz9bn05YQ9EAos0vdOV+9DDW4bqPuEne+OV/f9QJXWvHd+oUEUBWm40wya7yrPnoarN7OLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmSZoHQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E3C433C7;
	Fri, 22 Mar 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711125145;
	bh=otOiDrXv7vSEtDQG9vjhed+cuW5roGWlH4xO15itNQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmSZoHQN6Ch6UZqCQc7YAx+AjlBUk0zUmyDWkFSAOUr+W/ukv/JcU9rjTJiBvBjb7
	 GXsz3UGT1mXS2A2kC1SCL63D0O7nO0fPEciZIHb5qnrj/l/MV8c8xSV45hVaKRyCHj
	 iXgMDmD2lKxhHoBv3yauwq2+yEpD65CaeqMrAT6L7XmLg58XdtcKR/wru810BF6iN4
	 5i2JGMs06OEg1a9Jg80csxxv4rEJIg23OPCdKweUEIlDlI0wF15rN83mxbtXgzQ5Ri
	 j+6N14r3eH+37fIr0UrDf3fL8S8WNGVz2uuiO0k7OkQ8Q0tjUSp1N3T9ZVxUrA1/8x
	 iPqVIt4IXrbxQ==
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
	lizhijian@cn.fujitsu.com,
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
Date: Fri, 22 Mar 2024 09:32:23 -0700
Message-Id: <20240322163223.68414-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322090227.2253-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 18:02:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On Tue, 27 Feb 2024 15:51:20 -0800 SeongJae Park <sj@kernel.org> wrote:
> > On Mon, 26 Feb 2024 23:05:46 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > > posted at [1].
> > > 
> > > It says there is no implementation of the demote/promote DAMOS action
> > > are made.  This RFC is about its implementation for physical address
> > > space.
> > > 
> > > 
[...]
> > Thank you for running the tests again with the new version of the patches and
> > sharing the results!
> 
> It's a bit late answer, but the result was from the previous evaluation.
> I ran it again with RFC v2, but didn't see much difference so just
> pasted the same result here.

No problem, thank you for clarifying :)

[...]
> > > Honggyu Kim (3):
> > >   mm/damon: refactor DAMOS_PAGEOUT with migration_mode
> > >   mm: make alloc_demote_folio externally invokable for migration
> > >   mm/damon: introduce DAMOS_DEMOTE action for demotion
> > > 
> > > Hyeongtak Ji (4):
> > >   mm/memory-tiers: add next_promotion_node to find promotion target
> > >   mm/damon: introduce DAMOS_PROMOTE action for promotion
> > >   mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
> > >   mm/damon/sysfs-schemes: apply target_nid for promote and demote
> > >     actions
> > 
> > Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> > this patchset in high level.  Sharing the summary here for open discussion.  As
> > also discussed on the first version of this patchset[2], we want to make single
> > action for general page migration with minimum changes, but would like to keep
> > page level access re-check.  We also agreed the previously proposed DAMOS
> > filter-based approach could make sense for the purpose.
> 
> Thanks very much for the summary.  I have been trying to merge promote
> and demote actions into a single migrate action, but I found an issue
> regarding damon_pa_scheme_score.  It currently calls damon_cold_score()
> for demote action and damon_hot_score() for promote action, but what
> should we call when we use a single migrate action?

Good point!  This is what I didn't think about when suggesting that.  Thank you
for letting me know this gap!  I think there could be two approach, off the top
of my head.

The first one would be extending the interface so that the user can select the
score function.  This would let flexible usage, but I'm bit concerned if this
could make things unnecessarily complex, and would really useful in many
general use case.

The second approach would be letting DAMON infer the intention.  In this case,
I think we could know the intention is the demotion if the scheme has a youg
pages exclusion filter.  Then, we could use the cold_score().  And vice versa.
To cover a case that there is no filter at all, I think we could have one
assumption.  My humble intuition says the new action (migrate) may be used more
for promotion use case.  So, in damon_pa_scheme_score(), if the action of the
given scheme is the new one (say, MIGRATE), the function will further check if
the scheme has a filter for excluding young pages.  If so, the function will
use cold_score().  Otherwise, the function will use hot_score().

So I'd more prefer the second approach.  I think it would be not too late to
consider the first approach after waiting for it turns out more actions have
such ambiguity and need more general interface for explicitly set the score
function.


Thanks,
SJ

[...]

