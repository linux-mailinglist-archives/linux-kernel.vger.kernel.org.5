Return-Path: <linux-kernel+bounces-137307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A189E03B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FDFB2AD55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8B13D8BA;
	Tue,  9 Apr 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbH0ZbOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2624F883;
	Tue,  9 Apr 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679531; cv=none; b=LhMo76AITzhTtAxZGvveoen8sZGOYpVq35UN0bAW2o00zMyjY1aDFAlbdJVrHv63I2RF2qZ4OCWKHbfI80D9irqqFdCFFOMzBvjItKzYxgFJ9LV0BUKllQQlDHo1SaV++BlZtZUET7mBWPZcCQz6W80BktMdeM85yG5mGpRWglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679531; c=relaxed/simple;
	bh=a7Fm72paZyRNRsqpCjczySMYH6WBySfKD6PeLYfDdc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIo74OUWufr+LG+sTSFNL6KWCjpJcM5KpBp5u9Nfud64jWD+ELvmjDhr+lIveXNdmpcIOC7j6BPY33XTRt/TsmupO86SkXX9LQXilxRP8rEbUS7m78gzHDYZ0rnkNfmT6qLh9P2uySs7ajA63CChqMRGTd2IN+VJQ0rEKm01Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbH0ZbOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6D6C433F1;
	Tue,  9 Apr 2024 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679531;
	bh=a7Fm72paZyRNRsqpCjczySMYH6WBySfKD6PeLYfDdc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbH0ZbOoWsMrhL0l3zU/ykCadFbwmA849ytybkTc3goAXFXVXT1+T3MHAVioTeAMa
	 HLIOD408RCHYNsYlbVsRzhoQlWayG0IRriXNowb2NudweVWcZQRFS3Qw8o4znU5iSR
	 cl6cjLy5/9VgJEEGo8mmrg4WSMBsaBMS2xHnXICnvD7wZZfjJNsDYhH9un7v5/EUPH
	 qRbOp61cjpMyA5+8D3+iJzXgbfzS5uk98bDmjxA6YjW5HEdb4v2/Qu57TuluRK+oSz
	 qxqSgs/m+yQ1txjhzKkr/SvOQ597RyxCoqGzG8+DYbUiF/ylbrvKq9Ini5ochsFJJg
	 6ajcY56aBrZhA==
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
Date: Tue,  9 Apr 2024 09:18:47 -0700
Message-Id: <20240409161847.65803-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409095418.3051-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Tue,  9 Apr 2024 18:54:14 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> On Mon,  8 Apr 2024 10:52:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> > On Mon,  8 Apr 2024 21:06:44 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > > On Fri,  5 Apr 2024 12:24:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > > I can remove it, but I would like to have more discussion about this
> > > issue.  The current implementation allows only a single migration
> > > target with "target_nid", but users might want to provide fall back
> > > migration target nids.
> > > 
> > > For example, if more than two CXL nodes exist in the system, users might
> > > want to migrate cold pages to any CXL nodes.  In such cases, we might
> > > have to make "target_nid" accept comma separated node IDs.  nodemask can
> > > be better but we should provide a way to change the scanning order.
> > > 
> > > I would like to hear how you think about this.
> > 
> > Good point.  I think we could later extend the sysfs file to receive the
> > comma-separated numbers, or even mask.  For simplicity, adding sysfs files
> > dedicated for the different format of inputs could also be an option (e.g.,
> > target_nids_list, target_nids_mask).  But starting from this single node as is
> > now looks ok to me.
> 
> If you think we can start from a single node, then I will keep it as is.
> But are you okay if I change the same 'target_nid' to accept
> comma-separated numbers later?  Or do you want to introduce another knob
> such as 'target_nids_list'?  What about rename 'target_nid' to
> 'target_nids' at the first place?

I have no strong concern or opinion about this at the moment.  Please feel free
to renaming it to 'taget_nids' if you think that's better.

[...]
> Please note that I will be out of office this week so won't be able to
> answer quickly.

No problem, I hope you to take and enjoy your time :)


Thanks,
SJ

[...]

