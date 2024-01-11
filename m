Return-Path: <linux-kernel+bounces-23034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520B82A688
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FB9287A37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE2ED2;
	Thu, 11 Jan 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SigsKEqd"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E141EC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f79900b4-f924-48cd-bea5-e65989618f10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704944101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhHrSgkO7aZS8gS4QgDVlSfOXoB9Gg7ntyWbIFGpcNg=;
	b=SigsKEqdmubuTyBpozylpZPLXPD8HcrWElSpfXXYbNRHuzskLowdEcJ/ElaFn35L3+LB79
	91ynDlfmbds/omwHe0ohPC5FxscOWaDoIXDc8LGXUfY26QdnJdtCjpvSaGUfAZ1vLxNtmS
	l1z7T/zA0iklA3Xm/0/P+8EHrRWIYcI=
Date: Thu, 11 Jan 2024 11:34:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/7] hugetlb: code clean for hugetlb_hstate_alloc_pages
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
 David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, ligang.bdlg@bytedance.com,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-2-gang.li@linux.dev>
 <46769d44703b2f8d2e279d6e95db960c8a87e39c.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <46769d44703b2f8d2e279d6e95db960c8a87e39c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/11 05:55, Tim Chen wrote:
> On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
>> The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
>> code, its readability can be improved, facilitating future modifications.
>>
>> This patch extracts two functions to reduce the complexity of
>> `hugetlb_hstate_alloc_pages` and has no functional changes.
>>
>> - hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
>>    each online node and performs allocation if necessary.
>> - hugetlb_hstate_alloc_pages_report() report error during allocation.
>>    And the value of h->max_huge_pages is updated accordingly.
> 
> Minor nit, I think hugetlb_hstate_alloc_pages_errcheck() is more
> descriptive than hugetlb_hstate_alloc_pages_report().

Thanks! This looks more intuitive.

> 
> Otherwise
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> 

