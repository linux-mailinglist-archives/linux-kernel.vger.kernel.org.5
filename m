Return-Path: <linux-kernel+bounces-30608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391768321AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F821F2379A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9BC1D695;
	Thu, 18 Jan 2024 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4IE1QCV"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866CBA30
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617772; cv=none; b=deKdcKJCIky70p9Kmd25Xq2o3bNg8BukFx/qCiS6I+zGgbrXmsHwDEWxVV+dLSGCerUrfS84miMNPlQPrjaJD4cl2ofzbzkpJi4HKL8wTpQulq9nUShgyLcIbox5c+YT29T+Yy3n/oSoPh2iXjWadGz1XPp6OPUmHe16A2tAwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617772; c=relaxed/simple;
	bh=V93lACEuy9Jh/3kUbqPce0PY+Pu7FyLGV9Ep7HCIgGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2sJnCigWEEdkauomjBSYTE1qbsPwcMnziWCY+bs9fxRDoaniTtQqSAYpTkbbd7Pp23jET5LBIq+9BLgERsgLxFYSkrBas0T75llmlW02USJWsoxanZ/Av4PQWEAZFYw5+W11I+Ei1zlDiRh7dzP82SjhPVLW7qeGYdN0tS23TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4IE1QCV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Jan 2024 14:42:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705617769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NW4TFX7CWHcAM/ELBrbNoRjZoFg4ECdesduuMPSbGg=;
	b=N4IE1QCVP5VIcbuR4Mcg6nA+HVgTdyZjjmPLO5un8b8uPzNausMnYCjqobPCaZI8wxOxAC
	vhTC220fHpAXcjr+SWKeqaGT6V84JiNihZa9Bx0OJUm5q5b6hZwLpaSRseEcXg9CnR4+8H
	GtBpMR3RI2JnOh3/MdavJtceCr2yLcY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: writeback: ratelimit stat flush from
 mem_cgroup_wb_stats
Message-ID: <ZampZPLsXsdybtY9@P9FQF9L96D.corp.robot.car>
References: <20240118184235.618164-1-shakeelb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118184235.618164-1-shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 18, 2024 at 06:42:35PM +0000, Shakeel Butt wrote:
> One of our workloads (Postgres 14) has regressed when migrated from 5.10
> to 6.1 upstream kernel. The regression can be reproduced by sysbench's
> oltp_write_only benchmark. It seems like the always on rstat flush in
> mem_cgroup_wb_stats() is causing the regression. So, rate limit that
> specific rstat flush. One potential consequence would be the dirty
> throttling might be decided on stale memcg stats. However from our
> benchmarks and production traffic we have not observed any change in the
> dirty throttling behavior of the application.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

