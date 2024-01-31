Return-Path: <linux-kernel+bounces-46714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D801844311
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EE128451D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97D1292E9;
	Wed, 31 Jan 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2++4u9M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99369D22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715075; cv=none; b=Tuu87cpXfBg7PLMqwVjEny/K5F8HGPwy1CuOO3h6HdLyHEi8LIN5fq3xnXAD7zwbL51A7u1XLDjL7uYmom00/J5upsBmC5+0lzqaRp2bm57FOZ4ojGzAMLMrmvBY6+ZKtHYiec4kE5dU/kRai/ujb6Nm/VigCSxqWfOlw/1I1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715075; c=relaxed/simple;
	bh=rsDIuaEyL9ScSxFrStOinF9JksJgZ+4nfsKs0xH6ChQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmwJ0diEoZZUOIbLDXB5ctaT2/XwCB6AQ9d7yosKybn9IQbgPCimId10wsVaIX7IZDk/XI53et7bdxXeM0dRXxn5ACetsT6zTPQYCH5u8u/Bg9cNe7Zr80CFBPsAXV0aBwJZpcBzgX4BN4oAvyMjgW1YpDulervvKM54uvK7Zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2++4u9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706715072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccG+sbCfrbWj1IcTlWOfUc62TgnGl2MOJkfCzt/+H+Y=;
	b=V2++4u9MeGfRfFrDsuJbTDQp0Gon97ZcDb5k+lodJgHmhrRfwWT25Z0co4k2ULrt23/Vbd
	2to/wIYPvR8JDF1AaNy4K9ARZsEncxKm3VNy/LhTGarBF0MhSbu/jEPGkgSMGTHknrbHtp
	yp8T/ESQ3i0kc7vYb/8phqj2a6IFyhU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-vG6ECsSBPqGO5-Sf-ktjIw-1; Wed,
 31 Jan 2024 10:31:10 -0500
X-MC-Unique: vG6ECsSBPqGO5-Sf-ktjIw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BEA93806071;
	Wed, 31 Jan 2024 15:31:10 +0000 (UTC)
Received: from [10.22.18.157] (unknown [10.22.18.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6844492BE4;
	Wed, 31 Jan 2024 15:31:09 +0000 (UTC)
Message-ID: <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
Date: Wed, 31 Jan 2024 10:31:09 -0500
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZbpElS5sQV_o9NG1@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 1/31/24 08:01, Juri Lelli wrote:
> Hi Waiman,
>
> Thanks for working on this!
>
> On 30/01/24 13:33, Waiman Long wrote:
>> Ordered workqueues does not currently follow changes made to the
>> global unbound cpumask because per-pool workqueue changes may break
>> the ordering guarantee. IOW, a work function in an ordered workqueue
>> may run on a cpuset isolated CPU.
>>
>> This series enables ordered workqueues to follow changes made to the
>> global unbound cpumask by temporaily saving the work items in an
>> internal queue until the old pwq has been properly flushed and to be
>> freed. At that point, those work items, if present, are queued back to
>> the new pwq to be executed.
> I took it for a quick first spin (on top of wq/for-6.9) and this is what
> I'm seeing.
>
> Let's take edac-poller ordered wq, as the behavior seems to be the same
> for the rest.
>
> Initially we have (using wq_dump.py)
>
> wq_unbound_cpumask=0xffffffff 000000ff
> ...
> pool[80] ref= 44 nice=  0 idle/workers=  2/  2 cpus=0xffffffff 000000ff pod_cpus=0xffffffff 000000ff
> ...
> edac-poller                      ordered    80 80 80 80 80 80 80 80 ...
> ...
> edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
>
> after I
>
> # echo 3 >/sys/devices/virtual/workqueue/cpumask
>
> I get
>
> wq_unbound_cpumask=00000003
> ...
> pool[86] ref= 44 nice=  0 idle/workers=  2/  2 cpus=00000003 pod_cpus=00000003
> ...
> edac-poller                      ordered    86 86 86 86 86 86 86 86 86 86 ...
> ...
> edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
>
> So, IIUC, the pool and wq -> pool settings are updated correctly, but
> the wq.unbound_cpus (and its associated rescure affinity) are left
> untouched. Is this expected or are we maybe still missing an additional
> step?

Isn't this what the 4th patch of your RFC workqueue patch series does?

https://lore.kernel.org/lkml/20240116161929.232885-5-juri.lelli@redhat.com/

The focus of this series is to make sure that we can update the pool 
cpumask of ordered workqueue to follow changes in global unbound 
workqueue cpumask. So I haven't touched anything related to rescuer at all.

I will include your 4th patch in the next version of this series.

Cheers,
Longman


