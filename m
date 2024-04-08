Return-Path: <linux-kernel+bounces-135785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF689CB39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B8E1C24B06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D0145B08;
	Mon,  8 Apr 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dETVU4z5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EF1E489;
	Mon,  8 Apr 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598752; cv=none; b=KDOa9hUn0IvIqwGTq1H9s4it83fdKd+BbEZJAKXlXAy9xfWD531tuB7ZQeODhyFO4876MfY0cGZyBcpxFwewJoIjJSiRnV1Ns9ojrKR9nC/uWtGJLkEwDapJwlVpFPH2L6053WwTDblutAM4RkL1UccQ+xCf9uvjt62MvDI7gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598752; c=relaxed/simple;
	bh=lqMYSwhK0qnhw09eJ1+Ailh7I3TSY0ZybkqE6/ufJ1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7uK9PxtrRUT9Wn28eO99LDoBx7SjBMH6h0NyWpORG/OyatYQpiYUxQcH9MWA7xVamNKvUZdiM5YzPv6344HO75GPeldaEnEbDkHdNpmVv/wDelg6psExKGH9wiQdnt2G1+NuYGrptF2IAhEifW1Fe0ZvYRY0O6QxBAZpYIuiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dETVU4z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4BDC433F1;
	Mon,  8 Apr 2024 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598751;
	bh=lqMYSwhK0qnhw09eJ1+Ailh7I3TSY0ZybkqE6/ufJ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dETVU4z5saCmnOtTCAvVfwcmZVyqiTbnvhnbyUHMbHRPFAUROww0oKuWoO6NtGdHS
	 5f2+06+UOqSYXziqPLu06ZUoMs6i8czPHx+n8SKi1degY9Q7ekGgozVIJs3ohkrJ6u
	 eVb082wPFbA236byh5LRflA46GI8PnahThrnYv9U7l2cgsiVcnAy1LJgzLDiuXHsXB
	 /y1q/lwED31nG8qIWpqvtS3jtO4jwWtmHMTk7RdZ3ieR/Pz/vgfiImOrVtvDHFhP6e
	 j2ZLcku9F1MTc7OtG9myVWttU/0DWkGZAQQle8+TV5q+4FHVQnvvFG0XsVG4MRycMn
	 0K8vJS4x5hJxg==
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
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Mon,  8 Apr 2024 10:52:28 -0700
Message-Id: <20240408175228.91414-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408120648.2947-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  8 Apr 2024 21:06:44 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> On Fri,  5 Apr 2024 12:24:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> > On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > > Here is one of the example usage of this 'migrate_cold' action.
> > > 
> > >   $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
> > >   $ cat contexts/<N>/schemes/<N>/action
> > >   migrate_cold
> > >   $ echo 2 > contexts/<N>/schemes/<N>/target_nid
> > >   $ echo commit > state
> > >   $ numactl -p 0 ./hot_cold 500M 600M &
> > >   $ numastat -c -p hot_cold
> > > 
> > >   Per-node process memory usage (in MBs)
> > >   PID             Node 0 Node 1 Node 2 Total
> > >   --------------  ------ ------ ------ -----
> > >   701 (hot_cold)     501      0    601  1101
> > > 
> > > Since there are some common routines with pageout, many functions have
> > > similar logics between pageout and migrate cold.
> > > 
> > > damon_pa_migrate_folio_list() is a minimized version of
> > > shrink_folio_list(), but it's minified only for demotion.
> > 
> > MIGRATE_COLD is not only for demotion, right?  I think the last two words are
> > better to be removed for reducing unnecessary confuses.
> 
> You mean the last two sentences?  I will remove them if you feel it's
> confusing.

Yes.  My real intended suggestion was 's/only for demotion/only for
migration/', but entirely removing the sentences is also ok for me.

> 
> > > 
> > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > > ---
> > >  include/linux/damon.h    |   2 +
> > >  mm/damon/paddr.c         | 146 ++++++++++++++++++++++++++++++++++++++-
> > >  mm/damon/sysfs-schemes.c |   4 ++
> > >  3 files changed, 151 insertions(+), 1 deletion(-)
[...]
> > > --- a/mm/damon/paddr.c
> > > +++ b/mm/damon/paddr.c
[...]
> > > +{
> > > +	unsigned int nr_succeeded;
> > > +	nodemask_t allowed_mask = NODE_MASK_NONE;
> > > +
> > 
> > I personally prefer not having empty lines in the middle of variable
> > declarations/definitions.  Could we remove this empty line?
> 
> I can remove it, but I would like to have more discussion about this
> issue.  The current implementation allows only a single migration
> target with "target_nid", but users might want to provide fall back
> migration target nids.
> 
> For example, if more than two CXL nodes exist in the system, users might
> want to migrate cold pages to any CXL nodes.  In such cases, we might
> have to make "target_nid" accept comma separated node IDs.  nodemask can
> be better but we should provide a way to change the scanning order.
> 
> I would like to hear how you think about this.

Good point.  I think we could later extend the sysfs file to receive the
comma-separated numbers, or even mask.  For simplicity, adding sysfs files
dedicated for the different format of inputs could also be an option (e.g.,
target_nids_list, target_nids_mask).  But starting from this single node as is
now looks ok to me.

[...]
> > > +	/* 'folio_list' is always empty here */
> > > +
> > > +	/* Migrate folios selected for migration */
> > > +	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
> > > +	/* Folios that could not be migrated are still in @migrate_folios */
> > > +	if (!list_empty(&migrate_folios)) {
> > > +		/* Folios which weren't migrated go back on @folio_list */
> > > +		list_splice_init(&migrate_folios, folio_list);
> > > +	}
> > 
> > Let's not use braces for single statement
> > (https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces).
> 
> Hmm.. I know the convention but left it as is because of the comment.
> If I remove the braces, it would have a weird alignment for the two
> lines for comment and statement lines.

I don't really hate such alignment.  But if you don't like it, how about moving
the comment out of the if statement?  Having one comment for one-line if
statement looks not bad to me.

> 
> > > +
> > > +	try_to_unmap_flush();
> > > +
> > > +	list_splice(&ret_folios, folio_list);
> > 
> > Can't we move remaining folios in migrate_folios to ret_folios at once?
> 
> I will see if it's possible.

Thank you.  Not a strict request, though.

[...]
> > > +	nid = folio_nid(lru_to_folio(folio_list));
> > > +	do {
> > > +		struct folio *folio = lru_to_folio(folio_list);
> > > +
> > > +		if (nid == folio_nid(folio)) {
> > > +			folio_clear_active(folio);
> > 
> > I think this was necessary for demotion, but now this should be removed since
> > this function is no more for demotion but for migrating random pages, right?
> 
> Yeah,  it can be removed because we do migration instead of demotion,
> but I need to make sure if it doesn't change the performance evaluation
> results.

Yes, please ensure the test results are valid :)


Thanks,
SJ

[...]

