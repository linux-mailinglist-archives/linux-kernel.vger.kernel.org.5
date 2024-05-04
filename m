Return-Path: <linux-kernel+bounces-168513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233518BB978
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D381C2245F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AF111AA;
	Sat,  4 May 2024 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KGULOWHY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E4800
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714796956; cv=none; b=pH+z9ivdTn5Ahr/F+NYsYQkMy+wI6mZrqGk59ydnJb0xxKFfCYz0jWRTyFI81kwdBmsCfm5k9kLlnzGTBJfYqIhOySnHfqxGMsyLe7fjCQ6FacrJrE8NdiyxD8CsBKOWU745K1YuYq+V7z6BKf6xYCp1bgIL8OM+jRHKGk0CO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714796956; c=relaxed/simple;
	bh=Th+3KJTUmMWKeMg/72f0ng7f/tS8emPLqNZuYot4rgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKwxDnPDJEmA/w2UpSyK1BsLHRUedxyo+kHBIJH/dD8ghCsHMW7EVoMyRNJrgyDZcy46Q7ygwx3nVK1KQUwBEQoorMGlwfwgSJjJbkK4YNGXz3fOT7BBih8N88gE2GcNpiihMjJDGSnNikqzbFH9kTAvA5LpkMXzX22dPbMPGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KGULOWHY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Mc/W5wliGZHIgIeiC6uGR6vzkpWeRAuvbWwCco3vFc=; b=KGULOWHYfgJAw064ZVy1RaAwD/
	sHz8Dtq79eTjRHBdmtcGS8NTiUVNQ3aVWWLoOOrlwyr8L2ZgyzswfsPYNCNkCvG0eE7DsV3bTfaSs
	/mHKOlNHTtbdzyaq+cp29PA1yx7JI1ox2qXngUtd9iNX83ZKYzO+jSgj3X4YEpFRAjcXaHUyFE9OO
	VIhPxmzxuUtSFZJpOC+5zOCdewBb42HE2LgTZPk4j885Ek7s+RGtaz9wsY6yJt9ElY4GyW8lmHozn
	/sFkPN6zRRGEol4B+GohX6Tze4trDoeuDzHLI+qDHnxxIVcmqk5q8PPtO0bKjWgSZoKNYNi1ai239
	uhoRh7gQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3715-00000001EvB-49jV;
	Sat, 04 May 2024 04:28:55 +0000
Date: Fri, 3 May 2024 21:28:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Li <chrisl@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com, david@redhat.com,
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
	ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use
 swap_free_nr()
Message-ID: <ZjW5h_Ic3k9IlGtV@infradead.org>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
 <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
 <ZjWzoGg3MRs0yiBR@infradead.org>
 <CAGsJ_4xdgD8grbW98Gfoc7X-fAVYzFtobczNCWApw-oPhj9dwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xdgD8grbW98Gfoc7X-fAVYzFtobczNCWApw-oPhj9dwg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, May 04, 2024 at 12:27:11PM +0800, Barry Song wrote:
> swap_free_nr() isn't separate, after this patch, it is the only one left.
> there won't be swap_free() any more. it seems you want to directly
> "rename" it to swap_free()?

Yes.  Avoid the pointless suffix if it is the only variant.

