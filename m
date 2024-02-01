Return-Path: <linux-kernel+bounces-47978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E0845599
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907681F21AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C5942068;
	Thu,  1 Feb 2024 10:37:54 +0000 (UTC)
Received: from outbound-smtp38.blacknight.com (outbound-smtp38.blacknight.com [46.22.139.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4C7FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.22.139.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783873; cv=none; b=ChI0mdSNxsL7f/1y5GbV5lyRUdoSIJe0cdPNgD8CvwhSqndh5skzurzsG1P6/HzlxqOW0PznqPUyR+d7rF2uI+C3sUw4lbYo+zjDbhmiTsHjnx6OftzPY5yfJLHDrkYQJ5cJY1WHd8BeCFHNdbYX+Tuu8Sbg8D+GoACrEIc3r5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783873; c=relaxed/simple;
	bh=R5jSD8/Z785gfYrTYHGHMJuVPRERQPN9G6HG8mAZauU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTKH/dvEAc04S17BnSIyPheT+wKP1ozLoBonLnu6CQcxfL9cYdoCZylQVcyc4Hmz8I+q+mGB8T0fLLnCk5PqTqzqwyaNu52Zs+Bf3s42PZ+cbr0hUeSpg71c8GopcMy5k4x5SOJllGPFHisqAiPcL+xNgeB2MEzn/4f0jzoKMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; arc=none smtp.client-ip=46.22.139.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
	by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 5C6F02436
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:29:56 +0000 (GMT)
Received: (qmail 434 invoked from network); 1 Feb 2024 10:29:56 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.19])
  by 81.17.254.26 with ESMTPA; 1 Feb 2024 10:29:56 -0000
Date: Thu, 1 Feb 2024 10:29:54 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page order
 to be less than cc->order
Message-ID: <20240201102954.e65g2q3twdtxhjzc@techsingularity.net>
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>

On Mon, Jan 22, 2024 at 09:01:53PM +0800, Baolin Wang wrote:
> It can not improve the fragmentation if we isolate the target free pages
> exceeding cc->order, especially when the cc->order is less than pageblock_order.
> For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and cc->order
> is 2M THP size, we should not isolate other 2M free pages to be the migration
> target, which can not improve the fragmentation.
> 
> Moreover this is also applicable for large folio compaction.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

