Return-Path: <linux-kernel+bounces-28248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7F82FC20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12A428E7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94B224D6;
	Tue, 16 Jan 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6FD3C8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99991224CE;
	Tue, 16 Jan 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437127; cv=none; b=WCNmDczi0hmAQIu8agCkEbi5t6dnMQ3bj+NxkUShV8QfTvh8dpBqiR2LsADbvfix0diF5GCxeEM56HwLOaPCKKsqujWBvE41mxOzd/PoFK5UQmHQyTBk9ioloZjn6mK8aoiR3f7D5t5b0vAI1JaeZzxcBqUtWMLmCgc63pYEbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437127; c=relaxed/simple;
	bh=GgXb6VOl3A1OZ619VICvZg0xoOte/ekEVjnC8ojuBzg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=m4M3v/IfAKWqcepE4B9SU8sNRERJG77BjAfOwvrp3ghDE8YrMBkdTA4TG3eI5eCz4S4JPwkk+Sh5XVZ/XTMk9Y50k/dur3+g4A+MxgBad9DSx0F0WarEonWaaZVD7tPKeIo4tANZhGKOnhWN39VPWYRn0w+28TmzUP5A64P5WLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6FD3C8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51C9C433F1;
	Tue, 16 Jan 2024 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705437127;
	bh=GgXb6VOl3A1OZ619VICvZg0xoOte/ekEVjnC8ojuBzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6FD3C8scdF1SWyt88y2bWdzz77TSrQMdj7sauK12ToXjy+bPpeCW5rMBRMg6gKSL
	 7RS0fR08RQv35xJeutOyUUhwvK4/eGTbDwGAeOZJfnlEaq9fiRt5Gr54s5/7c8vw46
	 E2+L7qR+7ry+IuyXpGgULXmDiZuegFwLRkMat0+dH+40O4cWW0NplCEVP0nopDTR42
	 cmgvJZwuNJZeKudQFt4JW0FQvH1oER9GDO/Rn00waYBc8Us3QbYXTqANp/zhWSkcKX
	 6oeHkQXfMkHI1zf5kiimGZGQYvwm7jqVBm0YdwoDIcJjSDFVRpLbyLcSQFbW+ZKJKn
	 0Z2M8zSd11roA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [RFC PATCH 0/4] DAMON based 2-tier memory management for CXL memory
Date: Tue, 16 Jan 2024 12:31:59 -0800
Message-Id: <20240116203159.52826-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115045253.1775-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 15 Jan 2024 13:52:48 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This RFC is about its implementation for physical address
> space.
> 
[...]
> Evaluation Results
> ==================
> 
[...]
> In summary of both results, our evaluation shows that "DAMON 2-tier"
> memory management reduces the performance slowdown compared to the
> "default" memory policy from 15~17% to 4~5% when the system runs with
> high memory pressure on its fast tier DRAM nodes.
> 
> The similar evaluation was done in another machine that has 256GB of
> local DRAM and 96GB of CXL memory.  The performance slowdown is reduced
> from 20~24% for "default" to 5~7% for "DAMON 2-tier".
> 
> Having these DAMOS_DEMOTE and DAMOS_PROMOTE actions can make 2-tier
> memory systems run more efficiently under high memory pressures.


Thank you so much for this great patches and the above nice test results.  I
believe the test setup and results make sense, and merging a revised version of
this patchset would provide real benefits to the users.

In a high level, I think it might better to separate DAMON internal changes
from DAMON external changes.

For DAMON part changes, I have no big concern other than trivial coding style
level comments.

For DAMON-external changes that implementing demote_pages() and
promote_pages(), I'm unsure if the implementation is reusing appropriate
functions, and if those are placee in right source file.  Especially, I'm
unsure if vmscan.c is the right place for promotion code.  Also I don't know if
there is a good agreement on the promotion/demotion target node decision.  That
should be because I'm not that familiar with the areas and the files, but I
feel this might because our discussions on the promotion and the demotion
operations are having rooms for being more matured.  Because I'm not very
faimiliar with the part, I'd like to hear others' comments, too.

To this end, I feel the problem might be able to be simpler, because this
patchset is trying to provide two sophisticated operations, while I think a
simpler approach might be possible.  My humble simpler idea is adding a DAMOS
operation for moving pages to a given node (like sys_move_phy_pages RFC[1]),
instead of the promote/demote.  Because the general pages migration can handle
multiple cases including the promote/demote in my humble assumption.  In more
detail, users could decide which is the appropriate node for promotion or
demotion and use the new DAMOS action to do promotion and demotion.  Users
would requested to decide which node is the proper promotion/demotion target
nodes, but that decision wouldn't be that hard in my opinion.

For this, 'struct damos' would need to be updated for such argument-dependent
actions, like 'struct damos_filter' is haing a union.

In future, we could extend the operation to the promotion and the demotion
after the dicussion around the promotion and demotion is matured, if required.
And assuming DAMON be extended for originating CPU-aware access monitoring, the
new DAMOS action would also cover more use cases such as general NUMA nodes
balancing (extending DAMON for CPU-aware monitoring would required), and some
complex configurations where having both CPU affinity and tiered memory.  I
also think that may well fit with my RFC idea[2] for tiered memory management.

Looking forward to opinions from you and others.  I admig I miss many things,
and more than happy to be enlightened.

[1] https://lwn.net/Articles/944007/
[2] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/


Thanks,
SJ

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> 
> [1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
> [2] https://github.com/skhynix/hmsdk
> [3] https://github.com/redis/redis/tree/7.0.0
> [4] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
> [5] https://dl.acm.org/doi/10.1145/3503222.3507731
> [6] https://dl.acm.org/doi/10.1145/3582016.3582063
> 
> Honggyu Kim (2):
>   mm/vmscan: refactor reclaim_pages with reclaim_or_migrate_folios
>   mm/damon: introduce DAMOS_DEMOTE action for demotion
> 
> Hyeongtak Ji (2):
>   mm/memory-tiers: add next_promotion_node to find promotion target
>   mm/damon: introduce DAMOS_PROMOTE action for promotion
> 
>  include/linux/damon.h          |   4 +
>  include/linux/memory-tiers.h   |  11 ++
>  include/linux/migrate_mode.h   |   1 +
>  include/linux/vm_event_item.h  |   1 +
>  include/trace/events/migrate.h |   3 +-
>  mm/damon/paddr.c               |  46 ++++++-
>  mm/damon/sysfs-schemes.c       |   2 +
>  mm/internal.h                  |   2 +
>  mm/memory-tiers.c              |  43 ++++++
>  mm/vmscan.c                    | 231 +++++++++++++++++++++++++++++++--
>  mm/vmstat.c                    |   1 +
>  11 files changed, 330 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> -- 
> 2.34.1

