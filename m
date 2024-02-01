Return-Path: <linux-kernel+bounces-48322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A2E845A50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333F9B24074
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5C5D49F;
	Thu,  1 Feb 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgLQYNMS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A485D467
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797699; cv=none; b=uJi0OCVT4RGsP98wMhVsFDS3Qr5eQCyUvDwxVbAEzxx4F6WOQ6Cr1jn4ZXPiV3ot9DN6IxqZVP+o+TiSPZn/M7RC9RanQVGVdVWHobR7DVbGi05mkMuNgv3akF/CtcASrdRqZFmPvsILmdB89xPlIlNavbrEV9axiN/UkseKqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797699; c=relaxed/simple;
	bh=UNgrI5PObBiHAwcVDskybFaQhtDstmiY2paQysIryvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDi2u/UQF/mPgQJT6hHysuUc8x5sLBDVT4nIS2Fo91jjkpxQuQza7iPL84uRhBYLY8A0UeN9BNcBtn5Mi+lLn+DiZyD7pu9ApRcdQHmakFzekvS7D9N9nbduq47u4fp2tXP3O+PDKo0PAgI8f3gHY3/gTktZw2Y/vsTDgKajXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgLQYNMS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706797696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqXEaBeWNcnUclw7MmEN1q3twtm2FKWbGpBO6jRY2xs=;
	b=BgLQYNMSmV6HnotXVnCB5EoYfF967Ho+FeFlQCJKSX90rukglwa2bZ4Kz2dCTF/Iyo4weg
	Q6C5qplKYg9zlebS9e92OQgC2NtkfyMcsbc9VOqq/0CWj33J69mdf3Ip93ReAn7pmgc0Fo
	suf1byL1/rnjtWYNfEQqSNplblyzPN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-gNjaY4m-PKmQd3uh6o9Qgg-1; Thu, 01 Feb 2024 09:28:14 -0500
X-MC-Unique: gNjaY4m-PKmQd3uh6o9Qgg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80387800074;
	Thu,  1 Feb 2024 14:28:14 +0000 (UTC)
Received: from [10.22.16.160] (unknown [10.22.16.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3690A492BE2;
	Thu,  1 Feb 2024 14:28:14 +0000 (UTC)
Message-ID: <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>
Date: Thu, 1 Feb 2024 09:28:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Content-Language: en-US
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
 <Zbtv4v2KCKshnCL2@localhost.localdomain>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zbtv4v2KCKshnCL2@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 2/1/24 05:18, Juri Lelli wrote:
> On 31/01/24 10:31, Waiman Long wrote:
>> On 1/31/24 08:01, Juri Lelli wrote:
>>> Hi Waiman,
>>>
>>> Thanks for working on this!
>>>
>>> On 30/01/24 13:33, Waiman Long wrote:
>>>> Ordered workqueues does not currently follow changes made to the
>>>> global unbound cpumask because per-pool workqueue changes may break
>>>> the ordering guarantee. IOW, a work function in an ordered workqueue
>>>> may run on a cpuset isolated CPU.
>>>>
>>>> This series enables ordered workqueues to follow changes made to the
>>>> global unbound cpumask by temporaily saving the work items in an
>>>> internal queue until the old pwq has been properly flushed and to be
>>>> freed. At that point, those work items, if present, are queued back to
>>>> the new pwq to be executed.
>>> I took it for a quick first spin (on top of wq/for-6.9) and this is what
>>> I'm seeing.
>>>
>>> Let's take edac-poller ordered wq, as the behavior seems to be the same
>>> for the rest.
>>>
>>> Initially we have (using wq_dump.py)
>>>
>>> wq_unbound_cpumask=0xffffffff 000000ff
>>> ...
>>> pool[80] ref= 44 nice=  0 idle/workers=  2/  2 cpus=0xffffffff 000000ff pod_cpus=0xffffffff 000000ff
>>> ...
>>> edac-poller                      ordered    80 80 80 80 80 80 80 80 ...
>>> ...
>>> edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
>>>
>>> after I
>>>
>>> # echo 3 >/sys/devices/virtual/workqueue/cpumask
>>>
>>> I get
>>>
>>> wq_unbound_cpumask=00000003
>>> ...
>>> pool[86] ref= 44 nice=  0 idle/workers=  2/  2 cpus=00000003 pod_cpus=00000003
>>> ...
>>> edac-poller                      ordered    86 86 86 86 86 86 86 86 86 86 ...
>>> ...
>>> edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
>>>
>>> So, IIUC, the pool and wq -> pool settings are updated correctly, but
>>> the wq.unbound_cpus (and its associated rescure affinity) are left
>>> untouched. Is this expected or are we maybe still missing an additional
>>> step?
>> Isn't this what the 4th patch of your RFC workqueue patch series does?
>>
>> https://lore.kernel.org/lkml/20240116161929.232885-5-juri.lelli@redhat.com/
>>
>> The focus of this series is to make sure that we can update the pool cpumask
>> of ordered workqueue to follow changes in global unbound workqueue cpumask.
>> So I haven't touched anything related to rescuer at all.
> My patch only uses the wq->unbound_attrs->cpumask to change the
> associated rescuer cpumask, but I don't think your series modifies the
> former?

I don't think so. The calling sequence of apply_wqattrs_prepare() and 
apply_wqattrs_commit() will copy unbound_cpumask into ctx->attrs which 
is copied into unbound_attrs. So unbound_attrs->cpumask should reflect 
the new global unbound cpumask. This code is there all along. The only 
difference is that ordered workqueues were skipped for unbound cpumask 
update before. This patch series now includes those ordered workqueues 
when the unbound cpumask is updated.

Cheers,
Longman


