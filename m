Return-Path: <linux-kernel+bounces-91609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D2871435
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022F21F233BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8529D08;
	Tue,  5 Mar 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JCR3sWbx"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E12F44
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609122; cv=none; b=K61xK7l4tjq1aMffVhJeKOeEwDlpZB6iof3LrecHqYvjpeMCp0+eDm1HVyo4sk0rIheBHW5fPPpOIZ44dwNIxnZIhDaOUd2Eo3dyRZG0qo6O1d1wuQ29rFFWRaiEZqIIaQRM6hr4vN6CO294KAMVtbTuyBf36RANpKpkWp+xNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609122; c=relaxed/simple;
	bh=o4YaCqksKqFYoqSktiTk2QSjD3WdyyaqkHgxXL+uZgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNIQ/FF055pqmsmIIM567RpxsGBF10a5FPUnQ17C8swgHHfDGZNFxPFrWdlx5ZwpFhRFyZcBqbamieyACcAWEs7XugGJ5gV/HMXPpGUvh9FJB9ci6mH/aGXrXbrPJY0nIy9OulGbLOAw4Cg1xxruy7Dah8MbkTA63h6ESJ+9Hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JCR3sWbx; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <632e7fa2-1c46-4b78-a407-9e6b9c410ea4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709609117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRrL6EqVu6yE6KYElhVy5I/FMc5x+oybPMPkGTsdsZs=;
	b=JCR3sWbxa4Mfxla52f+nQyNHwsddGamu6M14Ar54Fsqsf4i1XkDu1JahuGuov03wdckqL7
	UJaYi+Fgj1VRT0TBJGBHIkD26Gns1fR20vAOltgOWFRdp2B2p/rFJRtz/8t7bhqQpReOP5
	wZQPWVIusT97e+6+tJq3xdwLNif78Ig=
Date: Tue, 5 Mar 2024 11:24:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 5/8] padata: downgrade padata_do_multithreaded to
 serial execution for non-SMP
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
 <20240222140422.393911-6-gang.li@linux.dev>
 <e44cv3c7lafc2a5p4wkhxjaipq4hgclzuceignzzp37kl4l2pj@t7bgio7s7p4q>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <e44cv3c7lafc2a5p4wkhxjaipq4hgclzuceignzzp37kl4l2pj@t7bgio7s7p4q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 05:26, Daniel Jordan wrote:
> On Thu, Feb 22, 2024 at 10:04:18PM +0800, Gang Li wrote:
>> hugetlb parallelization depends on PADATA, and PADATA depends on SMP.
>>
>> PADATA consists of two distinct functionality: One part is
>> padata_do_multithreaded which disregards order and simply divides
>> tasks into several groups for parallel execution. Hugetlb
>> init parallelization depends on padata_do_multithreaded.
>>
>> The other part is composed of a set of APIs that, while handling data in
>> an out-of-order parallel manner, can eventually return the data with
>> ordered sequence. Currently Only `crypto/pcrypt.c` use them.
>>
>> All users of PADATA of non-SMP case currently only use
>> padata_do_multithreaded. It is easy to implement a serial one in
>> include/linux/padata.h. And it is not necessary to implement another
>> functionality unless the only user of crypto/pcrypt.c does not depend on
>> SMP in the future.
>>
>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>>   include/linux/padata.h | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/padata.h b/include/linux/padata.h
>> index 8f418711351bc..0146daf344306 100644
>> --- a/include/linux/padata.h
>> +++ b/include/linux/padata.h
>> @@ -180,10 +180,6 @@ struct padata_instance {
>>   
>>   #ifdef CONFIG_PADATA
>>   extern void __init padata_init(void);
>> -#else
>> -static inline void __init padata_init(void) {}
>> -#endif
>> -
>>   extern struct padata_instance *padata_alloc(const char *name);
>>   extern void padata_free(struct padata_instance *pinst);
>>   extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
>> @@ -194,4 +190,12 @@ extern void padata_do_serial(struct padata_priv *padata);
>>   extern void __init padata_do_multithreaded(struct padata_mt_job *job);
>>   extern int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
>>   			      cpumask_var_t cpumask);
>> +#else
>> +static inline void __init padata_init(void) {}
>> +static inline void __init padata_do_multithreaded(struct padata_mt_job *job)
>> +{
> 
> An early return here for zero-sized jobs is consistent with the
> CONFIG_PADATA version and avoids hugetlb_pages_alloc_boot taking a lock
> and flushing the tlb when there's no work to do.

That's reasonable, thanks!

Since it's single-threaded, the lock isn't contested, but tlb does need
to be treated with caution.

> 
> With that,
> 
> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 

And thanks again.

>> +	job->thread_fn(job->start, job->start + job->size, job->fn_arg);
>> +}
>> +#endif
>> +
>>   #endif
>> -- 
>> 2.20.1
>>

