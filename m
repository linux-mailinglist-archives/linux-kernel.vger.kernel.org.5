Return-Path: <linux-kernel+bounces-31292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4B832BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AE61F21C84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A115473F;
	Fri, 19 Jan 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YNzferZw"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2845465D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676131; cv=none; b=B6FozqOrhhxWHAAX93tbnrxKIQRpijpb7POrIdZbe1+tqyAjZ5hor51zVMUjod09IgBcJO5YieAFl6qOI6wtyFBTeoGjnR/9uC7lWui0zkEjvOBgB3hDm8edksRwenbCw9kNqVbxvDja0cAcbRK7dFkbosp2rAKVz1OcZj6a2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676131; c=relaxed/simple;
	bh=2vuvuZhE3Kv0/p2bla2HuOKxDw5tnq7PECF2bh4brnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRP+R/rpqKJ9cgC4hNScOYvjEFRT2ZWCKoBtT0ZTb5sXWWu0BwSTa9qnhmm6YV3NQs7FeARDB/Qn1pCJ9D0lggGWIakvciLM9rn+R3RObEDVIwLUKYiPUJTdkhKeGmXTqNbsKQpiRyUZDqEimvDyo3AuqEftHz1CL9OM+qqEsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YNzferZw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa628406-23db-47be-b9c1-ef8a88ecd062@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705676127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4qbCQgj12O8En/gusu3QK+XK6h8GB3JBzV0B53LnBI=;
	b=YNzferZwWQ6R67NBzwQZe0NUaJQyAKDcurN5py4mjGZsPK/MyRETgjnkF//XD52NxPQuHX
	qBmUyBX6t53kh3Lz/0imTLZHQr9RuadMvDoFEttEagqbv5QgvbI/UY/0fvdo5CbbANGqPW
	hBGTY34pztOlyUYN8g3x4u5IO59/5/M=
Date: Fri, 19 Jan 2024 23:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/7] padata: dispatch works on different nodes
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, ligang.bdlg@bytedance.com
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-4-gang.li@linux.dev>
 <29695e89ae2d838c9b7537941b0231c3ff559e48.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <29695e89ae2d838c9b7537941b0231c3ff559e48.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/19 07:04, Tim Chen wrote:
> On Thu, 2024-01-18 at 20:39 +0800, Gang Li wrote:
>> When a group of tasks that access different nodes are scheduled on the
>> same node, they may encounter bandwidth bottlenecks and access latency.
>>
>> Thus, numa_aware flag is introduced here, allowing tasks to be
>> distributed across different nodes to fully utilize the advantage of
>> multi-node systems.
>>
>> Signed-off-by: Gang Li <gang.li@linux.dev>
>> Tested-by: David Rientjes <rientjes@google.com>
>> ---
>>   include/linux/padata.h |  3 +++
>>   kernel/padata.c        | 14 ++++++++++++--
>>   mm/mm_init.c           |  1 +
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/padata.h b/include/linux/padata.h
>> index 495b16b6b4d7..f79ccd50e7f4 100644
>> --- a/include/linux/padata.h
>> +++ b/include/linux/padata.h
>> @@ -137,6 +137,8 @@ struct padata_shell {
>>    *             appropriate for one worker thread to do at once.
>>    * @max_threads: Max threads to use for the job, actual number may be less
>>    *               depending on task size and minimum chunk size.
>> + * @numa_aware: Dispatch jobs to different nodes. If a node only has memory but
>> + *              no CPU, dispatch its jobs to a random CPU.
> 
> Suggest:
> Distribute jobs to different nodes with CPU in a round robin fashion.
> 

Good idea.
Thanks.

>>    */
>>   struct padata_mt_job {
> 

