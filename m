Return-Path: <linux-kernel+bounces-32608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71562835DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A48B28914A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CD3A1D5;
	Mon, 22 Jan 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Isc2BeNg"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B83A1A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914888; cv=none; b=lGA3OlQtAUtwlo8aRZg2DpGbkInmaHNqXJ1HVAhk0Sk2QoBFn88X2H7vOSChhj/qvNtBJf9fwa4oMsiftAc2M4jpoWEAobb97ZFLOadRDVeOzaRZSWwBbPzszDJyAojZ5ILZowSqUNf7meKw0E/+J7nodMn0vLmH2aq5qu3muxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914888; c=relaxed/simple;
	bh=Qy4fsezFSYvwxIkwm1wQOGaj6uzXBPjygbKRVWIIEbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKTnL7FqBDvdGKhMMImbJMI1wxPcc+kvamCZM0F4PcLBuxnLD7Z/jcou/PX88RZL3vnVUkzRASvKrF5ROgMYgjImxTNfN5HX2KjoBndUWFR+vNHjkY70voZ805I+Z1laKfFE9nhERphZM/eCf6q68iG1MZisyQi6sI218bSw2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Isc2BeNg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b71d1750-87b9-4f2d-af4a-3555eeffaafd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705914884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lP5WZIQefovoUpcgS/TdLZH0rQJtQEYYdZtxKrIHJY=;
	b=Isc2BeNgilmq13B5rv9/2uKlx48sNVonOO2SChSOy5jzvXv3O8smUIfQq+XqSvgJxjsCiQ
	ncUbk/eA1IhtF4M9eokgHfbk6sK0R9qQbBL5dDNhr4c+HZ8cnHrjBR8AN7B1TV1p/NNAy1
	Bb4/Db7MBcTqGtbKCdc6e2TojrYL13A=
Date: Mon, 22 Jan 2024 17:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-5-gang.li@linux.dev>
 <f7e072c0-4b41-40d3-bf2e-19d4fdf7bc0d@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <f7e072c0-4b41-40d3-bf2e-19d4fdf7bc0d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/22 14:16, Muchun Song wrote:
> On 2024/1/18 20:39, Gang Li wrote:
>>   static struct folio *alloc_pool_huge_folio(struct hstate *h,
>>                       nodemask_t *nodes_allowed,
>> -                    nodemask_t *node_alloc_noretry)
>> +                    nodemask_t *node_alloc_noretry,
>> +                    int *next_node)
>>   {
>>       gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>>       int nr_nodes, node;
>> -    for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
>> +    for_each_node_mask_to_alloc(next_node, nr_nodes, node, 
>> nodes_allowed) {
> 
> 
> A small question here, why not pass h->next_nid_to_alloc to
> for_each_node_mask_to_alloc()? What's the purpose of the third
> parameter of alloc_pool_huge_folio()?
> 
> Thanks.
> 

In hugetlb_alloc_node->alloc_pool_huge_folio, hugetlb is initialized in
parallel at boot time, then it needs each thread to have its own
next_nid, and can't use the global h->next_nid_to_alloc. so an extra 
parameter is added.

And h->next_nid_to_alloc in set_max_huge_pages->alloc_pool_huge_folio
can not be removed. Because if the user calls set_max_huge_pages
frequently and only adds 1 page at a time, that would result in each
request being made on the same node if local variables are used.

