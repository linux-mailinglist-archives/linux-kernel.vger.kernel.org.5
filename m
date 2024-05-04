Return-Path: <linux-kernel+bounces-168509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F498BB966
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7731F232F2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792B10A1C;
	Sat,  4 May 2024 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vifOKZQ1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A57AD2D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714795454; cv=none; b=B2tPg5rejChdowg6O79wroBWuwfLiTVtRWv+kx53Rk5YQZleh4+0+RuDTNbWC850gLnuOzDHKSefGkUxEN5ULeXfk6bZbC1MQqvZxQoDclQAgFF+nrabW7Ow2xCWDsHvpL47u3dCl5syvQSflFnUd3IjYM8Dew/07smdvGX8Nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714795454; c=relaxed/simple;
	bh=SYAmbYA39mRMtra9kKxfupAmrezK4kfaxBes562k5XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPM8zCqnm0ogHqSNeAcL+u2n+USi7g1jissNJIeCwAKPXuCwYKhjupGtoaf3KMJ9XCZCV3rLja5MCUUj9gr5F+Hqvs9+IJ4K5NBxp1MzOFWcvZLCdJaZHLaXMWEllqNIDMHTBbGXa79vCvOC+XVbagCqgPErkCtfiwimfh6Ug1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vifOKZQ1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SYAmbYA39mRMtra9kKxfupAmrezK4kfaxBes562k5XE=; b=vifOKZQ1gHFHOk602G+1pZl5YM
	QcI0pkFD5j13gQ4Hbq0In5APxg6Ze6lXKH6fstUB5zJ96BBSXTU5W7hCuwr3bjA+ZXJcULUnRZOAp
	waiKuifg5Ko709O92WBpsnWHjoPkkAHbz6Hu5gL9eVbXCoB3LHTdlPLyBlodH8YQTpT+vIYIesGh7
	ZI5HMNyymjWWU/eH1I7OMiflt3HVlAQH7oK7zCWwS87WaO43o3PP6y7xS+iyaVeVGjuheu8a74E/w
	tpnANR1IPSLTMVeVuowRpemeaktWOn/Z2rVgjgB8hjRIERm6hR3bdq8PhvhLSWDKU2jEl60ir59Ma
	gAJ4uBWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s36ci-00000001CKX-1MlN;
	Sat, 04 May 2024 04:03:44 +0000
Date: Fri, 3 May 2024 21:03:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, david@redhat.com,
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
	ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use
 swap_free_nr()
Message-ID: <ZjWzoGg3MRs0yiBR@infradead.org>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
 <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 03, 2024 at 01:37:06PM -0700, Chris Li wrote:
> Either way works. It will produce the same machine code. I have a
> slight inclination to just drop swap_free(entry) API so that it
> discourages the caller to do a for loop over swap_free().

Then just ad the number of entries parameter to swap_free and do away
with the separate swap_free_nr.


