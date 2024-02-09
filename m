Return-Path: <linux-kernel+bounces-59185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A242984F2CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D532287151
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05B67E72;
	Fri,  9 Feb 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5B/5p2Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2A67E61
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472566; cv=none; b=qiCK0mSrStPWGCI3R4o/Ag48+x/v3HNkve+WKhfqzuJWevet5a+WPmpffrEoOj2LOAyQnPN1Stu2gU5CORUcJ28hhx6Ht4HssK8b+DPy5zB0zrxh7KwADoI4II+2W5ECMjikewH+OULD7ukGhC28iGqgesXA+FUXvGcSQKoMnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472566; c=relaxed/simple;
	bh=KfsHmDe3ZLFgrnm+SKa5mnKBmWNtSbWGSugWsXTB7lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UiQO+w4XuB0poW00TDXekpUXA3AXQjfB3+vYztfyePo8a6hhZlaEBabOmWhlY3gqckWe3bW16+2CBQjcLpSzm1xGMyJMoKiVNLafm27lvIg7DOSYvbPFV8AlElrnRbI/4O6hF/0RIMAcZVLCW/fTgTMtSephmWAH12xf3Ov/cN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5B/5p2Z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707472565; x=1739008565;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KfsHmDe3ZLFgrnm+SKa5mnKBmWNtSbWGSugWsXTB7lw=;
  b=S5B/5p2ZzJS7GxzfuqPbGpwYZpDoxy9RsxT2bYJKZLlg3kcRiU4+INEp
   zBxuv2QfA5+IqTs3WGKsWwKaQRFUcQRDz9SqhxJFFyqFDCJnqIHd4FEXw
   c6AkmvvV86nB1lMzktP9aSEhJ6lBCS3RmWe0UY1rKI1puRSzx1mEmDHXb
   /p0K7L+N/WKS9C6x12HOD0SlK35vWaeY0XGgvUwZJxmX/EBLJ8+eGySKy
   nWCkb4I5jFtH/qs2jPpr8Qsx4Eq55jhpN5cIlCwcvagTYgpRy9QZ1MRLf
   kckYUIzQsLBHitHKqgEmAFKTuzGkQnYi4vxy44P3SdiA4HQxUJtTtd1UZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5194091"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="5194091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 01:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="6535901"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa005.jf.intel.com with ESMTP; 09 Feb 2024 01:56:03 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 9D2E8301B21; Fri,  9 Feb 2024 01:56:03 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: gregkh@linuxfoundation.org,  rafael@kernel.org,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] meminfo: provide estimated per-node's available memory
In-Reply-To: <20240204083414.107799-1-luochunsheng@ustc.edu> (Chunsheng Luo's
	message of "Sun, 4 Feb 2024 03:34:14 -0500")
References: <20240204083414.107799-1-luochunsheng@ustc.edu>
Date: Fri, 09 Feb 2024 01:56:03 -0800
Message-ID: <87fry2t0zw.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chunsheng Luo <luochunsheng@ustc.edu> writes:

> +	available = sum_zone_node_page_state(nid, NR_FREE_PAGES) - pgdat->totalreserve_pages;
> +
> +	/*
> +	 * Not all the page cache can be freed, otherwise the system will
> +	 * start swapping or thrashing. Assume at least half of the page
> +	 * cache, or the low watermark worth of cache, needs to stay.
> +	 */
> +	pagecache = node_page_state(pgdat, NR_ACTIVE_FILE) +
> +		node_page_state(pgdat, NR_INACTIVE_FILE);
> +	pagecache -= min(pagecache / 2, wmark_low);


The magic number 2 should be a define (or maybe even a tunable). Similar
below. It seems quite arbitrary, but I don't have a better solution
either. Maybe could handle dirty differently, but nothing stands out here


> +		node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE);
> +	reclaimable -= min(reclaimable / 2, wmark_low);
> +	available += reclaimable;
> +
> +	if (available < 0)
> +		available = 0;

That would be a bug? Perhaps add a WARN_ON


With those changes:

Reviewed-by: Andi Kleen <ak@linux.intel.com>



-Andi

