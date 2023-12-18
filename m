Return-Path: <linux-kernel+bounces-3057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54D8166B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10851C2229C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAA79EB;
	Mon, 18 Dec 2023 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZRgB2TD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E17464
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <642a3472-9570-409a-94e0-64f30966b86f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702881981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxhuB4/a6nADycq01sY6OaY4WiAXhkXwIrDoEHhteEk=;
	b=uZRgB2TDdJy9GaOq3MspG9bqRtWCpDRHoQGSvbufNDItYSbxWJ5ZEeipQI+cvyIYDauDpT
	Z8KojixWALzaejI6WCbUcTiGBBs3OvrmgpaWQb7FxXOpFO+JCKDcYqQA3cEKO5QO3Eod9P
	yPTxXIqJ5Cf2dY2dW8CM3Ipxx5nM63k=
Date: Mon, 18 Dec 2023 14:46:15 +0800
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
 Muchun Song <muchun.song@linux.dev>, Gang Li <gang.li@linux.dev>,
 Mike Kravetz <mike.kravetz@oracle.com>, David Rientjes
 <rientjes@google.com>, David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231208025240.4744-1-gang.li@linux.dev>
 <20231208025240.4744-4-gang.li@linux.dev>
 <b2e7daff1e314d927cc4b4713afa31ac25787825.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <b2e7daff1e314d927cc4b4713afa31ac25787825.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/13 07:40, Tim Chen wrote:
> 
>>   
>>   	list_for_each_entry(pw, &works, pw_list)
>> -		queue_work(system_unbound_wq, &pw->pw_work);
>> +		if (job->numa_aware)
>> +			queue_work_node((++nid % num_node_state(N_MEMORY)),
> 
> The nid may fall on a NUMA node with only memory but no CPU.  In that case you
> may still put the work on the unbound queue. You could end up on one CPU node for work
> from all memory nodes without CPU. Is this what you want?  Or you would
> like to spread them between CPU nodes?
> 
> Tim

Hi, thank you for your reminder. My intention was to fully utilize all
memory bandwidth.

For memory nodes without CPUs, I also hope to be able to spread them on
different CPUs.

