Return-Path: <linux-kernel+bounces-29731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE948312A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69199B2433C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF18F52;
	Thu, 18 Jan 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cl5mJQEP"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B90B641
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558534; cv=none; b=as6fMfBPOBLPVeCpqrcx5PJ/fta/EyppDA0NuTiHQuf+bt7FyE06zLDoAWGbi2bu+EGMU6AEL74w6Nv7jHsQJ1Enu9cPb3arBAj7RnY3YMwpcipkTJvIjFX4TFJlN0i8zIr/H3Oi9wnc7LY5qurcfS6NlsyFMeRd1APOlrkjNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558534; c=relaxed/simple;
	bh=gV4MiNQjlU4xhBTe+QyOd1xi2+bAtlmQaFvYtYZl7mE=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=S4ibLcbRHWZ16rrSB4cNKB/oT/wV50RiVSFRIkVFNPiMKxls9AVWm2mLw97NRGoQtwc9wKdhRP6/eOl/njqW+einbNhrCbf7vtdUiLFntI6jH92CHPaKhVAh67DRl9JFpHJItmovHc5h/k5YSn3L4islrRzFhqFDHVideSRAn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cl5mJQEP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1cfdf574-90cf-4143-b735-7b8354098e6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705558529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mh84LK5Hn0va2aqVidMrgA/rXrDauaZUcxawgJ4ahFA=;
	b=cl5mJQEPA++vhqUv/LLC7QCgcUrAvzl1ZcM+Sn103AGaw4YFEQEun6O6xNp8sEKn+iH8g9
	/2B3OUr9EBe3onRV/M8tYnAmuzoaQekgIpPOO3Zih2yTAW7VOCGnFTjmoSDm4NxVLDY1mb
	lL5081W5/E+CY1VYrT/BcUV0cGGBFxs=
Date: Thu, 18 Jan 2024 14:15:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/7] padata: dispatch works on different nodes
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, David Rientjes
 <rientjes@google.com>, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com, David Hildenbrand <david@redhat.com>,
 Muchun Song <muchun.song@linux.dev>, Gang Li <gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-4-gang.li@linux.dev>
 <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
 <feaf7851-f924-48f4-b16a-2fa5efdb28cf@linux.dev>
 <1bd6ee64a600daad58866ce684b591d39879c470.camel@linux.intel.com>
 <ea4a5417-1fce-4b36-be4d-215086fd7e96@linux.dev>
 <cc135e4ba87bf64b384a529ccbd4c644bb135266.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <cc135e4ba87bf64b384a529ccbd4c644bb135266.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Tim,

On 2024/1/18 06:14, Tim Chen wrote:
> On Mon, 2024-01-15 at 16:57 +0800, Gang Li wrote:
>> How about:
>> ```
>> nid = global_nid;
>> list_for_each_entry(pw, &works, pw_list)
>> 	if (job->numa_aware) {
>> 		int old_node = nid;
>> 		queue_work_node(nid, system_unbound_wq, &pw->pw_work);
>> 		nid = next_node(nid, node_states[N_CPU]);
>> 		cmpxchg(&global_nid, old_node, nid);



>> 	} else
>> 		queue_work(system_unbound_wq, &pw->pw_work);
>>
>> ```
>>

My original idea was to have all tasks from a single
padata_do_multithreaded distributed continuously across NUMA nodes.

In that case, the task distribution would be predictable for a single
padata_do_multithreaded call.

> 
> I am thinking something like
> 
> static volatile atomic_t last_used_nid;
> 
> list_for_each_entry(pw, &works, pw_list)
>   	if (job->numa_aware) {
> 		int old_node = atomic_read(&last_used_nid);
> 		
> 		do {
> 			nid = next_node_in(old_node, node_states[N_CPU]);
> 		} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));


However, having the tasks from all parallel padata_do_multithreaded
globally distributed across NUMA nodes is also fine by me.

I don't have a strong preference.

>   		queue_work_node(nid, system_unbound_wq, &pw->pw_work);		
>   	} else {
>   		queue_work(system_unbound_wq, &pw->pw_work);
> 	}
> 
> Note that we need to use next_node_in so we'll wrap around the node mask.
> 

