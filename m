Return-Path: <linux-kernel+bounces-7767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5181ACD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E141F2132A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E5442B;
	Thu, 21 Dec 2023 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lxEIn+b8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1C4419
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703127529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=471qcHdzd4wocYNFZ/IDiWbxSCeMWRLKcRroMq5z/OA=;
	b=lxEIn+b8egcKMViXKZTjBRuiLHKMB3u8LZ2jmz11hdgMeD6pfzJI1RKvTl7jXrNWL4DQ7f
	hMuGGahDUJbGCdiWoJZ5B6T1ZDnzysSkyoWd/1e7y0gfrBSbciQKA8qrdeTyKLH+xYMU0W
	vgUUnPuKIYUlVbrrcHATggS4zyS0yyk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 03/40] mm/rmap: introduce and use
 hugetlb_add_file_rmap()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231220224504.646757-4-david@redhat.com>
Date: Thu, 21 Dec 2023 10:58:07 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Peter Xu <peterx@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F867DDC7-CB8A-4E41-8773-8EE5404F1DF9@linux.dev>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-4-david@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 21, 2023, at 06:44, David Hildenbrand <david@redhat.com> wrote:
> 
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Right now we're using page_dup_file_rmap() in some cases where "ordinary"
> rmap code would have used page_add_file_rmap(). So let's introduce and
> use hugetlb_add_file_rmap() instead. We won't be adding a
> "hugetlb_dup_file_rmap()" functon for the fork() case, as it would be
> doing the same: "dup" is just an optimization for "add".
> 
> What remains is a single page_dup_file_rmap() call in fork() code.
> 
> Add sanity checks that we end up with the right folios in the right
> functions.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


