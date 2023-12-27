Return-Path: <linux-kernel+bounces-11962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7881EE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C8B2190F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C244369;
	Wed, 27 Dec 2023 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NynB/8pW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF337143
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a236102-0607-4952-8bc3-0cb45030bc6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703673236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HFfje7b6p9aJjTf6TauFhLwkAz1k9f+8nEkuAPySQA=;
	b=NynB/8pWyjazFha5Auojw6RCTc2j+k6PFrIB4IT4qNBj22kLf8d8qkynK8+dlBeZ7T/+gU
	y3sZpgGo6ji/uLU6SRG+4yI8uYs+6b/pc/6s8MEM3Q1HeWsaARMLCGMx1HdrByXhcw26cH
	V4UM35uYGru7kCxASNF2n9M1mSWQhNQ=
Date: Wed, 27 Dec 2023 18:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 3/5] padata: dispatch works on different nodes
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Mike Kravetz <mike.kravetz@oracle.com>,
 David Rientjes <rientjes@google.com>, David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231208025240.4744-1-gang.li@linux.dev>
 <20231208025240.4744-4-gang.li@linux.dev>
 <b2e7daff1e314d927cc4b4713afa31ac25787825.camel@linux.intel.com>
 <642a3472-9570-409a-94e0-64f30966b86f@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <642a3472-9570-409a-94e0-64f30966b86f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Tim,

According to queue_work_node, if there are no CPUs available on the
given node, it will schedule to any available CPU.

On 2023/12/18 14:46, Gang Li wrote:
> On 2023/12/13 07:40, Tim Chen wrote:
>>
>>>       list_for_each_entry(pw, &works, pw_list)
>>> -        queue_work(system_unbound_wq, &pw->pw_work);
>>> +        if (job->numa_aware)
>>> +            queue_work_node((++nid % num_node_state(N_MEMORY)),
>>
>> The nid may fall on a NUMA node with only memory but no CPU.  In that 
>> case you
>> may still put the work on the unbound queue. You could end up on one 
>> CPU node for work
>> from all memory nodes without CPU. Is this what you want?  Or you would
>> like to spread them between CPU nodes?
>>
>> Tim
> 
> Hi, thank you for your reminder. My intention was to fully utilize all
> memory bandwidth.
> 
> For memory nodes without CPUs, I also hope to be able to spread them on
> different CPUs.

