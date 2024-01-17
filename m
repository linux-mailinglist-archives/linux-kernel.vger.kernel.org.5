Return-Path: <linux-kernel+bounces-29462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6BC830E96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6081B1F2672A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A42557D;
	Wed, 17 Jan 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HetAil9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7925572;
	Wed, 17 Jan 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526662; cv=none; b=Z6BjP5bZQto2BWTRZm2qzqAjXd2atc9+T6M9A0wATjmAz/vgk9q1rxiwdSpZX6xwGmRtBV0CZ/NLVbnQtUNQP6ctxSDXA51+PwlmIlj/pco0L3jMUO18GXaGVZ3+30P3hkfNpDRE4s384ljXHcYV7OFkXqiMXBV8JY+aqa9s9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526662; c=relaxed/simple;
	bh=Xi4AvMxwNhhjvnZxB9RNlBZlHJZqwbrZNMt87q40Y5Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=KZwX8hy1IMUI98dOxhdvI9Y1bryqsOtZfWWxon/UJxdFYZsQI3RpMDbn4T+0Wlf5M9W6HcdB0dnErHf2t+uJePCuazQBLqrp/6b68Pc/o2M/Co7YD9Ah1WTcC9irjfsiCJ/65tz63oLZSW/g6zRdOm/ebIVV+7mVo+Wqd0ORO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HetAil9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525B2C433F1;
	Wed, 17 Jan 2024 21:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705526661;
	bh=Xi4AvMxwNhhjvnZxB9RNlBZlHJZqwbrZNMt87q40Y5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HetAil9r8Am1raizRyvhUG/lw4wfYEoQA/9APIZG3YginIabgQH0C8ANZXjw2Y2Z3
	 jBVjrKFMwSrWTLn5+kyKOecmhQiS5HLDw1e7N7aJ6y6K+KXuxtm9rfcb+RUqi5qZYK
	 J+TU5//SgG++UfdgVeSTAcfsZQ7CHLh8fkX5jswzbSmylMVy55rY9f9ocr+c7NSVh0
	 0D+XfW7JgkTo+N15+rIdFFNFFIa3FAivl41puNP0wvNdnAyEIq+k/UKVowd11bihWw
	 LLQTad7/nsLlcwHxghws/cLDX45lAIIpJZaRky5TGeuv/8NZZN2XaK6cSVsLHVNR3A
	 wBilBn7I31hAA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
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
Date: Wed, 17 Jan 2024 13:24:18 -0800
Message-Id: <20240117212419.51845-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117211103.51806-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jan 2024 13:11:03 -0800 SeongJae Park <sj@kernel.org> wrote:

[...]
> Hi Honggyu,
> 
> On Wed, 17 Jan 2024 20:49:25 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > Thanks very much for your comments in details.
> > 
> > On Tue, 16 Jan 2024 12:31:59 -0800 SeongJae Park <sj@kernel.org> wrote:
> > 
[...]
> > > To this end, I feel the problem might be able te be simpler, because this
> > > patchset is trying to provide two sophisticated operations, while I think a
> > > simpler approach might be possible.  My humble simpler idea is adding a DAMOS
> > > operation for moving pages to a given node (like sys_move_phy_pages RFC[1]),
> > > instead of the promote/demote.  Because the general pages migration can handle
> > > multiple cases including the promote/demote in my humble assumption.
[...]
> > > In more detail, users could decide which is the appropriate node for promotion
> > > or demotion and use the new DAMOS action to do promotion and demotion.  Users
> > > would requested to decide which node is the proper promotion/demotion target
> > > nodes, but that decision wouldn't be that hard in my opinion.
> > > 
> > > For this, 'struct damos' would need to be updated for such argument-dependent
> > > actions, like 'struct damos_filter' is haing a union.
> > 
> > That might be a better solution.  I will think about it.
> 
> More specifically, I think receiving an address range as the argument might
> more flexible than just NUMA node.  Maybe we can imagine proactively migrating
> cold movable pages from normal zones to movable zones, to avoid normal zone
> memory pressure.

Yet another crazy idea.  Finding hot regions in the middle of cold region and
move to besides of other hot pages.  As a result, memory is sorted by access
temperature even in same node, and the system gains more spatial locality,
which benefits general locality-based algorithms including DAMON's adaptive
regions adjustment.


Thanks,
SJ

[...]

