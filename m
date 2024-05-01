Return-Path: <linux-kernel+bounces-165834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11E8B9230
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8911F2226D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D285168AEF;
	Wed,  1 May 2024 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ol2Ov+xb"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883A17C6B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605599; cv=none; b=UXKD1C7RP8AtIydXH45B+FxG2TEzVDzPy/a6GjweAqhQB8N7EGyF/eMSG/Tnh/6rYsoS/o45cnS6rtAzmX8oCdDmZ2qcRZNrYbu3wpNZedHstdMN8mU2LGSt5oFQWTMgw0reHAyFZ925utCFlCN/08JjEYjlHCVMWPZ7+veEQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605599; c=relaxed/simple;
	bh=y5Bi4fdvi84yqwBZVRod77w9n7j2PpqSd818mZkvyfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHS0a8Xf6Xred+cYzUCobp0CO5HFqlKz3TIQY3mU6bj8O6iISvSlFxcQ7cGnFZvmyQnG6MYp6avD596xL+4iDhSG3I0mhAWDPSdmdGX8kVw4ja4uS1wSvgQm7ClFK/5JaEOTyStVc5gKbD6UmYDRPVz21/U6PJg6w7wt/45+Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ol2Ov+xb; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 16:19:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714605596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gB5I0eMNfCBUTfZ23aoOcIFer0EoKZ8W81G5ow3IHF4=;
	b=Ol2Ov+xbmWpzfzWgUU+hzKWkvEWMp6YCG0KgXR+STDs9VNYx+fqFGsfFDOnxaN/6u+odfo
	rDb2GLlHMGYKpABTUOsA6bf4ip8i7w/QAuvGbMjMnyOVlLNC9enGKv6aCrhHql+mG5342j
	prk2xaZS9X8ZeBLld3b86GQrBoAPSQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] memcg: dynamically allocate lruvec_stats
Message-ID: <ZjLOFen06EXSQojD@P9FQF9L96D>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
 <20240501172617.678560-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501172617.678560-3-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 10:26:11AM -0700, Shakeel Butt wrote:
> To decouple the dependency of lruvec_stats on NR_VM_NODE_STAT_ITEMS, we
> need to dynamically allocate lruvec_stats in the mem_cgroup_per_node
> structure. Also move the definition of lruvec_stats_percpu and
> lruvec_stats and related functions to the memcontrol.c to facilitate
> later patches. No functional changes in the patch.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: T.J. Mercier <tjmercier@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

