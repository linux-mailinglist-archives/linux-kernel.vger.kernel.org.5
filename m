Return-Path: <linux-kernel+bounces-99768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0297878CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87971C212DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3146FB6;
	Tue, 12 Mar 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOWFjIxO"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B10811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210381; cv=none; b=HNWm+KII2huSqCWWfUiS8qEOqLhvni8RBRmzctzuUZaRoOkNWPAZ5qRmq6ODtAKj7IDGw8vBrN8N1HVcWDQ0gtwRMOlPq1NkYXhU9u6gxjr06ovY5VXyRMjvVC2Tv4Z5HXyLosHBIEO7cbAzPvSXWZSobhzEEtw+LgCZf0JMOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210381; c=relaxed/simple;
	bh=BOG56Hxgu8xy+GFwdKiAEcsHH2X1Tu4706t+CFcuHqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0+LKJ5+QKhydZ9ITPvZX3qYSs1M2VICqTudqZDmrC32Ar6P1oCngFauybRhdq8YB6fS04tdcsics1KWmWCycvREJN5V6NGoOJtqutOmIKUCa6jZ5Fx0EtPu1IUIJ8NUF6WArxWG4hiL+Osy/5OxWOSl0DUK26r8O+Q17/7cPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOWFjIxO; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c6f90d0-ef3a-4ea4-8de6-ad93c93ed3da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710210377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8bXqps/luirsJ8RKYPi+CeFj7wz4+E9180FYv/b4Y4=;
	b=VOWFjIxO+KLG+Y2DQgdeXdXmOQt01YCZZIl71j/ooGiYMy1/iZXvWcFbfBJ3i+d1Wb8kHL
	kxV/sKbb2G2BYvI7ZmvdKpeqasTVvfKLrva39nlG3UkkEX6yJ03kot/SC4l40PI7ABnp6t
	6JmikJQvMbZGhNIdUJI7gmlC3ka1voY=
Date: Tue, 12 Mar 2024 10:26:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 8/8] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Muchun Song <muchun.song@linux.dev>, Tim Chen <tim.c.chen@linux.intel.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Jane Chu <jane.chu@oracle.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-9-gang.li@linux.dev>
 <vbj76pzf5mvooydne5fg2ewgjiducgficskq7hcsdxwywsda7l@qisdlq5q2n3o>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <vbj76pzf5mvooydne5fg2ewgjiducgficskq7hcsdxwywsda7l@qisdlq5q2n3o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for your review :)

On 2024/3/9 01:35, Daniel Jordan wrote:
> On Thu, Feb 22, 2024 at 10:04:21PM +0800, Gang Li wrote:
>> Optimizing the initialization speed of 1G huge pages through
>> parallelization.
>>
>> 1G hugetlbs are allocated from bootmem, a process that is already
>> very fast and does not currently require optimization. Therefore,
>> we focus on parallelizing only the initialization phase in
>> `gather_bootmem_prealloc`.
>>
>> Here are some test results:
>>        test case       no patch(ms)   patched(ms)   saved
>>   ------------------- -------------- ------------- --------
>>    256c2T(4 node) 1G           4745          2024   57.34%
>>    128c1T(2 node) 1G           3358          1712   49.02%
>>       12T         1G          77000         18300   76.23%
> 
> Another great improvement.
> 
>> +static void __init gather_bootmem_prealloc_parallel(unsigned long start,
>> +						    unsigned long end, void *arg)
>> +{
>> +	int nid;
>> +
>> +	for (nid = start; nid < end; nid++)
>> +		gather_bootmem_prealloc_node(nid);
>> +}
>> +
>> +static void __init gather_bootmem_prealloc(void)
>> +{
>> +	struct padata_mt_job job = {
>> +		.thread_fn	= gather_bootmem_prealloc_parallel,
>> +		.fn_arg		= NULL,
>> +		.start		= 0,
>> +		.size		= num_node_state(N_MEMORY),
>> +		.align		= 1,
>> +		.min_chunk	= 1,
>> +		.max_threads	= num_node_state(N_MEMORY),
>> +		.numa_aware	= true,
>> +	};
>> +
>> +	padata_do_multithreaded(&job);
>> +}
> 
> Looks fine from the padata side.
> 
> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com> # padata

