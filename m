Return-Path: <linux-kernel+bounces-52097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E684940F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA951C227A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DB10A28;
	Mon,  5 Feb 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ccQs5ggj"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4E10A01
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116141; cv=none; b=ln0gEKRYr3jX14S5bajmVhjBj/imtkhWLkU3OPVodLKiuzQXwsOj+PsYzcUbe+mEFwTKpnC+72r3fGehlaLEMazMoUJgpDRNH4HBGP+hNq4zJfAGtKX5D5JDzlIVEn0STTl2il0Rtiba3gklQUKz6Ptj7zlc1m6XiF+3goUTbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116141; c=relaxed/simple;
	bh=wrcGQj5rXv/Zu4YYVmOh+SLKlI+YFNLUlZuGw0fEDWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFf3RnNHavH1ZEzevtU0qEVAaUcVkxKhedJnUKwTVV/QH0QZaqsJJ17Flk7CTvE2zvV8qwtjpfTSlEsIdh6d5wX7p53OmqrM81+q9FlKsMlcCp9meXa4+eUkrXvfYX4OYn1HHN6GpZhu/YTpzudu8hMSZaN8Zhme6iotFg8MMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ccQs5ggj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <828f990c-11af-42ad-a030-a66dde97a7f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707116134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRwS2TOIVcwCMhMY7CNIPuZ7+8MNYAG3eC4E1bzeetA=;
	b=ccQs5ggj9mVzRoAPo/b5x7z+VvMRim4Bkw80breXejHIKe+Dy0DQ8eSyI22OqCsPijTsdL
	q28E8hFD1w2N2RsulpLzIoL+/Noi7GzteeKY63BwdDlhBvUB749QG1KS11zgCKZ74Tw3Dc
	UNDueaiectH8yuWEQWKSLTO9abdAJ5w=
Date: Mon, 5 Feb 2024 14:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP
 system
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
References: <20240204072525.1986626-1-gang.li@linux.dev>
 <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
 <a749cb06-9495-40fc-9192-b019b48eca92@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <a749cb06-9495-40fc-9192-b019b48eca92@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/4 15:48, Gang Li wrote:
> On 2024/2/4 15:44, Muchun Song wrote:
>> I don't think it is a clear way to fix this. If someone want to
>> use PADATA in a non-SMP system, he should be carefully to handle
>> the non-SMP case himself. I think the better way is to make PADATA
>> handle the non-SMP case, I think it should be easy for it, which
>> could just call ->thread_fn() many times instead of creating many
>> threads in the non-SMP case.
>>
>> Thanks.
>>
> 
> Sounds good, I'll take a look at padata and send a new patch.

1. delete the dependency on SMP

PADATA only depends on workqueue and completion. It works well with !SMP
currently but has no performance benefits. What we can do is make PADATA
handle the non-SMP case more elegantly.

PADATA has two parts: "Running Multithreaded Jobs" and "Running
Serialized Jobs".

"Running Multithreaded Jobs", which hugetlb parallelization relies on
can be easily deparallelize through this patch:

```
@@ -495,7 +495,7 @@ void __init padata_do_multithreaded(struct 
padata_mt_job *job)
        nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
        nworks = min(nworks, job->max_threads);

-      if (nworks == 1) {
+      if (nworks == 1 || !IS_ENABLED(CONFIG_SMP)) {
                /* Single thread, no coordination needed, cut to the 
chase. */
                job->thread_fn(job->start, job->start + job->size, 
job->fn_arg);
                return;
```

However, "Running Serialized Jobs" is more challenging due to its
various workers queuing each other, making it more complex than "Running
Multithreaded Jobs." I am currently in the process of deciphering the
code.

To eliminate kconfig warnings, other methods could be considered:

2. Split hugetlb parallelization into a separate kconfig.
3. Wrap hugetlb parallelization with SMP or PADATA macros (already ruled 
out).
4. Split PADATA into PADATA_SERIALIZED and PADATA_MULTITHREADED (too heavy).

Anyway, this is only FYI. I will continue exploring how to deparallelize
"Running Serialized Jobs."

