Return-Path: <linux-kernel+bounces-133524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6989A4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5496B1C21651
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCA172BDB;
	Fri,  5 Apr 2024 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWxVF0iU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E8172BC6;
	Fri,  5 Apr 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345100; cv=none; b=YlWP3R1iCnTNe5ubTVJbWgvcr6jOilNDdYpaIpWGUr1A6euQgl7B87pr1wQTWubFgdogzrZN0OLEH8p3hhh3zkJAvm/96jKgqu0IJ3E/fPebeedV5dZmOraHfEXhBOR1orNjCh5xOoRwyuJdL47fcpZxy5lQXF1/bf7uWqDTULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345100; c=relaxed/simple;
	bh=FK4h/8Qb4PhaAp88iGaA8h7WqLJqCcrh+xeBVhK+WQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5lH1wkleTLSSiaJNhMf3YTlQNGib9/uAjUJynzpLEHbY5gCD4vgBRt0u3WB1fdLcEUDmQlSfdsIe9i2XB/SnS6xxc9iTUNyFaMZyA0xh6sNShePugRh97MQ5uMz/wx4UOvDJPpi2g1wMTNV2M4+dDpttviLFj17vOYXaxVWLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWxVF0iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFD7C433F1;
	Fri,  5 Apr 2024 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712345100;
	bh=FK4h/8Qb4PhaAp88iGaA8h7WqLJqCcrh+xeBVhK+WQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWxVF0iU2MJc3v/1OhKOge0FpPHa2dL63n59rDezFWDFeGtaDh54MK657/FdoTlbC
	 9knaxWY/DxXueBIocShzxs3X1qWupXPFogn0MZWVqrfhjffwavFJcJh4smCslyA80r
	 rFbJOuQl+Q2MCyiEDVU3ybK2CeAbbj/Dxq58AN87pWH9cjxOI8sg9GgRfPYfmzUK00
	 hCWrqbeFP78f5Yxa2JgruhOCcif4oTpwnEO01GlTZf0rtrJfdYelVLBEMfGFQcAgMH
	 x3Tff5WbH2MGH+pY9zXork0Oh/eT5bl25k21Vg5MS5EjU+rUycjl/Yx7QXEsuohhya
	 i3Md/yLT80zWA==
From: SeongJae Park <sj@kernel.org>
To: Hyeongtak Ji <hyeongtak.ji@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
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
Date: Fri,  5 Apr 2024 12:24:57 -0700
Message-Id: <20240405192457.67068-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405075557.464190-1-hyeongtak.ji@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 16:55:57 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:

> On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> ...snip...
> 
> > +static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
> > +					    enum migration_mode mm,
> > +					    int target_nid)
> > +{
> > +	int nid;
> > +	unsigned int nr_migrated = 0;
> > +	LIST_HEAD(node_folio_list);
> > +	unsigned int noreclaim_flag;
> > +
> > +	if (list_empty(folio_list))
> > +		return nr_migrated;
> 
> How about checking if `target_nid` is `NUMA_NO_NODE` or not earlier,
> 
> > +
> > +	noreclaim_flag = memalloc_noreclaim_save();
> > +
> > +	nid = folio_nid(lru_to_folio(folio_list));
> > +	do {
> > +		struct folio *folio = lru_to_folio(folio_list);
> > +
> > +		if (nid == folio_nid(folio)) {
> > +			folio_clear_active(folio);
> > +			list_move(&folio->lru, &node_folio_list);
> > +			continue;
> > +		}
> > +
> > +		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> > +							   NODE_DATA(nid), mm,
> > +							   target_nid);
> > +		nid = folio_nid(lru_to_folio(folio_list));
> > +	} while (!list_empty(folio_list));
> > +
> > +	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> > +						   NODE_DATA(nid), mm,
> > +						   target_nid);
> > +
> > +	memalloc_noreclaim_restore(noreclaim_flag);
> > +
> > +	return nr_migrated;
> > +}
> > +
> 
> ...snip...
> 
> > +static unsigned int migrate_folio_list(struct list_head *migrate_folios,
> > +				       struct pglist_data *pgdat,
> > +				       int target_nid)
> > +{
> > +	unsigned int nr_succeeded;
> > +	nodemask_t allowed_mask = NODE_MASK_NONE;
> > +
> > +	struct migration_target_control mtc = {
> > +		/*
> > +		 * Allocate from 'node', or fail quickly and quietly.
> > +		 * When this happens, 'page' will likely just be discarded
> > +		 * instead of migrated.
> > +		 */
> > +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> > +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> > +		.nid = target_nid,
> > +		.nmask = &allowed_mask
> > +	};
> > +
> > +	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
> > +		return 0;
> 
> instead of here.

Agree.  As I replied on the previous reply, I think this check can be done from
the caller (or the caller of the caller) of this function.

> 
> > +
> > +	if (list_empty(migrate_folios))
> > +		return 0;

Same for this.

> > +
> > +	/* Migration ignores all cpuset and mempolicy settings */
> > +	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
> > +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
> > +		      &nr_succeeded);
> > +
> > +	return nr_succeeded;
> > +}
> > +
> 
> ...snip...
> 
> Kind regards,
> Hyeongtak
> 

Thanks,
SJ

