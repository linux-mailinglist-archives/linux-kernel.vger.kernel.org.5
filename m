Return-Path: <linux-kernel+bounces-7763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011281ACC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F911C21E92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC15441E;
	Thu, 21 Dec 2023 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3s704m2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272753D6E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703127339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h690bWax6yOVJQKGadfFFXWsV5kXgvfQum64XdRnI8k=;
	b=Q3s704m2bPeTWEOwmanmPMW48lD2m7QW6OaviD1J+XcWfNk9RPgtfELZLEZ95BwamrPb4b
	uE1y8jI+fa30kE9frMnMQDL9A0htEhvjTKuxaI/31vuNzqz3IfkwiYXjpVhUMCQN8uSWFu
	a/VLEuZF60ZYvmRXnn359JR6u/3i1wE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 02/40] mm/rmap: introduce and use hugetlb_remove_rmap()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231220224504.646757-3-david@redhat.com>
Date: Thu, 21 Dec 2023 10:54:30 +0800
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
Message-Id: <06731287-9E14-4623-9280-B9C43E12E021@linux.dev>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-3-david@redhat.com>
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
> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
> code from page_remove_rmap(). This effectively removes one check on the
> small-folio path as well.
> 
> Add sanity checks that we end up with the right folios in the right
> functions.
> 
> Note: all possible candidates that need care are page_remove_rmap() that
>      pass compound=true.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


