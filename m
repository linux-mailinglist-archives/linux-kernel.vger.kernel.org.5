Return-Path: <linux-kernel+bounces-29447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A9830E63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868E32850E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0325563;
	Wed, 17 Jan 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRarnbm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD825558;
	Wed, 17 Jan 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525866; cv=none; b=KobP57a4cf66+wOcM8ocbOHdmMxE4aMse8xBBi9L1A3FPxWKj02gs1P5HkEzGBI4/lv4YBSH4OEnJUs4V5WzrJ/eLvTyQ1Z/ISfkofwzoMZpNWTwiaYpN8y0Uiz9yo5nHME53Pwj+ip8y6Qphs8sV5fsNNEr4Un3rRoJGsV4CVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525866; c=relaxed/simple;
	bh=crEbNXwtnLQ/zYOPViojanwrSzcw/HATD8C5YXyuKk8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Qay7awnwDLP7exdwmXJ83OTfrHd/j1TsSsb42uoeegPfu0Ta4OikNZSdCylxGoOASt/cBpRGENJIoZ2P550yHNQiLaysO8luuMN00SAh70RvpyIpj5IBD9KCwc/Xo8yp0v2PiMsajfKUhsxKwdECapxNN3HVo3Na6guOclyT71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRarnbm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94835C433F1;
	Wed, 17 Jan 2024 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705525866;
	bh=crEbNXwtnLQ/zYOPViojanwrSzcw/HATD8C5YXyuKk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRarnbm1O7aKz/AC+ejABEJqmaFm4U1DFVVICOPx6onvfO09XzSkSEMhuE719lFY3
	 NwfAjMOrCSYZgRRR5WTVLX8+tmhM1HWBSphVfiEYdeQ4LsrXFiBeccVVAGKyJFOBK+
	 ZHWeToSJMrDuurR1cxTxmJ8I1q//wntNxgwU7eZgBEGfcZG7iJel8Ic6L6pwGatHZK
	 DCAIaCAhpgg+eDuY3m7LZqR0LOVrkCmsC2X148/61qcpiaKNtlILHVagVOOpu63/Ck
	 +QYDIxcEl7WZMP7EbMaG00200dukyCwTnCdQSFP77TrX8Pnc7bgkIXClY7A6CRGPRk
	 8BPPaESZZt/Wg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 0/4] DAMON based 2-tier memory management for CXL memory
Date: Wed, 17 Jan 2024 13:11:03 -0800
Message-Id: <20240117211103.51806-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117114926.1895-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Wed, 17 Jan 2024 20:49:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> Thanks very much for your comments in details.
> 
> On Tue, 16 Jan 2024 12:31:59 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > Thank you so much for this great patches and the above nice test results.  I
> > believe the test setup and results make sense, and merging a revised version of
> > this patchset would provide real benefits to the users.
> 
> Glad to hear that!
> 
> > In a high level, I think it might better to separate DAMON internal changes
> > from DAMON external changes.
> 
> I agree.  I can't guarantee but I can move all the external changes
> inside mm/damon, but will try that as much as possible.
> 
> > For DAMON part changes, I have no big concern other than trivial coding style
> > level comments.
> 
> Sure.  I will fix those.
> 
> > For DAMON-external changes that implementing demote_pages() and
> > promote_pages(), I'm unsure if the implementation is reusing appropriate
> > functions, and if those are placee in right source file.  Especially, I'm
> > unsure if vmscan.c is the right place for promotion code.  Also I don't know if
> > there is a good agreement on the promotion/demotion target node decision.  That
> > should be because I'm not that familiar with the areas and the files, but I
> > feel this might because our discussions on the promotion and the demotion
> > operations are having rooms for being more matured.  Because I'm not very
> > faimiliar with the part, I'd like to hear others' comments, too.
> 
> I would also like to hear others' comments, but this might not be needed
> if most of external code can be moved to mm/damon.
> 
> > To this end, I feel the problem might be able te be simpler, because this
> > patchset is trying to provide two sophisticated operations, while I think a
> > simpler approach might be possible.  My humble simpler idea is adding a DAMOS
> > operation for moving pages to a given node (like sys_move_phy_pages RFC[1]),
> > instead of the promote/demote.  Because the general pages migration can handle
> > multiple cases including the promote/demote in my humble assumption.
> 
> My initial implementation was similar but I found that it's not accurate
> enough due to the nature of inaccuracy of DAMON regions.  I saw that
> many pages were demoted and promoted back and forth because migration
> target regions include both hot and cold pages together.
> 
> So I have implemented the demotion and promotion logics based on the
> shrink_folio_list, which contains many corner case handling logics for
> reclaim.
> 
> Having the current demotion and promotion logics makes the hot/cold
> migration pretty accurate as expected.  We made a simple program called
> "hot_cold" and it receives 2 arguments for hot size and cold size in MB.
> For example, "hot_cold 200 500" allocates 200MB of hot memory and 500MB
> of cold memory.  It basically allocates 2 large blocks of memory with
> mmap, then repeat memset for the initial 200MB to make it accessed in an
> infinite loop.
> 
> Let's say there are 3 nodes in the system and the first node0 and node1
> are the first tier, and node2 is the second tier.
> 
>   $ cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
>   0-1
> 
>   $ cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
>   2
> 
> Here is the result of partitioning hot/cold memory and I put execution
> command at the right side of numastat result.  I initially ran each
> hot_cold program with preferred setting so that they initially allocate
> memory on one of node0 or node2, but they gradually migrated based on
> their access frequencies.
> 
>   $ numastat -c -p hot_cold
>   Per-node process memory usage (in MBs) 
>   PID              Node 0 Node 1 Node 2 Total 
>   ---------------  ------ ------ ------ ----- 
>   754 (hot_cold)     1800      0   2000  3800    <- hot_cold 1800 2000 
>   1184 (hot_cold)     300      0    500   800    <- hot_cold 300 500 
>   1818 (hot_cold)     801      0   3199  4000    <- hot_cold 800 3200 
>   30289 (hot_cold)      4      0      5    10    <- hot_cold 3 5 
>   30325 (hot_cold)     31      0     51    81    <- hot_cold 30 50 
>   ---------------  ------ ------ ------ ----- 
>   Total              2938      0   5756  8695
> 
> The final node placement result shows that DAMON accurately migrated
> pages by their hotness for multiple processes.

What was the result when the corner cases handling logics were not applied?

And, what are the corner cases handling logic that seemed essential?  I show
the page granularity active/reference check could indeed provide many
improvements, but that's only my humble assumption.

If the corner cases are indeed better to be applied in page granularity, I
agree we need some more efforts since DAMON monitoring results are not page
granularity aware by the design.  Users could increase min_nr_regions to make
it more accurate, and we have plan to support page granularity monitoring,
though.  But maybe the overhead could be unacceptable.

Ideal solution would be making DAMON more accurate while keeping current level
of overhead.  We indeed have TODO items for DAMON accuracy improvement, but
this may take some time that might unacceptable for your case.

If that's the case, I think the additional corner handling (or, page gran
additional access check) could be made as DAMOS filters[1], since DAMOS filters
can be applied in page granularity, and designed for this kind of handling of
information that DAMON monitoring results cannot provide.  More specifically,
we could have filters for promotion-qualifying pages and demotion-qualifying
pages.  In this way, I think we can keep the action more flexible while the
filters can be applied in creative ways.

[1] https://git.kernel.org/sj/c/98def236f63c66629fb6b2d4b69cecffc5b46539

> 
> > In more detail, users could decide which is the appropriate node for promotion
> > or demotion and use the new DAMOS action to do promotion and demotion.  Users
> > would requested to decide which node is the proper promotion/demotion target
> > nodes, but that decision wouldn't be that hard in my opinion.
> > 
> > For this, 'struct damos' would need to be updated for such argument-dependent
> > actions, like 'struct damos_filter' is haing a union.
> 
> That might be a better solution.  I will think about it.

More specifically, I think receiving an address range as the argument might
more flexible than just NUMA node.  Maybe we can imagine proactively migrating
cold movable pages from normal zones to movable zones, to avoid normal zone
memory pressure.

> 
> > In future, we could extend the operation to the promotion and the demotion
> > after the dicussion around the promotion and demotion is matured, if required.
> > And assuming DAMON be extended for originating CPU-aware access monitoring, the
> > new DAMOS action would also cover more use cases such as general NUMA nodes
> > balancing (extending DAMON for CPU-aware monitoring would required), and some
> > complex configurations where having both CPU affinity and tiered memory.  I
> > also think that may well fit with my RFC idea[2] for tiered memory management.
> > 
> > Looking forward to opinions from you and others.  I admig I miss many things,
> > and more than happy to be enlightened.
> > 
> > [1] https://lwn.net/Articles/944007/
> > [2] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/
> 
> Thanks very much for your comments.  I will need a few more days for the
> update but will try to address your concerns as much as possible.

No problem, please take your time.  I'm looking forward to the next version :)


Thanks,
SJ

> 
> Thanks,
> Honggyu

