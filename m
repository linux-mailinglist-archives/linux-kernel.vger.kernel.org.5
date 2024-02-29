Return-Path: <linux-kernel+bounces-86845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDE86CBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D6B1C2136B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46E137747;
	Thu, 29 Feb 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFIUgaPv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D43E489
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217050; cv=none; b=TmgEFQpunOHMTMdMvotx8/RjRsZIMsMOtwzrY+FYc4C21LNDjLmyGYrNAFd8wayklldFoonxPzZddIPlrotkYqJ2ZyPXEl1nDS5uNUpQ09cR+GEXlUbN9cAu4b6Kh3SsfeLhKgpGrNJi0pWoMqQJYQ4neltlRd4WYw9Ihd/II9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217050; c=relaxed/simple;
	bh=Nm70cXVcjS/7SOH+8hlVgINNBfCzrbBJi9RE81WyQeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqhuObMlA65W2deE8wmlznwIjYpGRxR31tmBadtNMVF44oLFkddoplNSap1ndWsKPK8USHN+zrOt3QJTLBZ9BYvr5We0YfrNSTexKem2KyLueSOkMvXm3FE8Gy6fShVPksuYdv94rfKgxOYsYQoIvikkeYv+isjoLOsnbyec+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFIUgaPv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709217047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ddpr4robXIIsOuX1oCrFxRil1JaqONSPHPNvPLZCoIM=;
	b=ZFIUgaPvnagv2gbUGsuh7CYY5Fbf/5vaXDk4eUe65FPee+5tEfGvuKxRtH5eRtl1Jqcyh8
	PXTpEfsF2srnsLaU+3vcGAUm0im2jffxMFncAqlKukt6R20zm4DwqCuTBHV25xpFhisCRL
	eyUDCU3j/7ssmqs8obZF+KMEswFh9Z0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-cnWRXdVSPx2B1dK3VwPbEg-1; Thu, 29 Feb 2024 09:30:41 -0500
X-MC-Unique: cnWRXdVSPx2B1dK3VwPbEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB1B283DDE0;
	Thu, 29 Feb 2024 14:30:40 +0000 (UTC)
Received: from [10.22.8.117] (unknown [10.22.8.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC73492BFA;
	Thu, 29 Feb 2024 14:30:39 +0000 (UTC)
Message-ID: <9d04f0c6-c4f4-407a-af0c-eda8328fd22a@redhat.com>
Date: Thu, 29 Feb 2024 09:30:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup/cpuset: Mark memory_spread_slab as obsolete
Content-Language: en-US
To: Xiongwei Song <xiongwei.song@windriver.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net
Cc: vbabka@suse.cz, yosryahmed@google.com, rostedt@goodmis.org, cl@linux.com,
 chengming.zhou@linux.dev, zhengyejian1@huawei.com, cgroups@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229142007.1278610-1-xiongwei.song@windriver.com>
 <20240229142007.1278610-2-xiongwei.song@windriver.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240229142007.1278610-2-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 2/29/24 09:20, Xiongwei Song wrote:
> We've removed the SLAG allocator, cpuset_do_slab_mem_spread() and

Typo: "SLAG" --> SLAB.

Other than that,

Acked-by: Waiman Long <longman@redhat.com>

> SLAB_MEM_SPREAD, memory_spread_slab is a no-op now. We can mark
> memory_spread_slab as obsolete in case someone still wants to use it
> after cpuset_do_slab_mem_spread() removed. For more details, please
> check [1].
>
> [1] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#m8e292e21b00f95a4bb8086371fa7387fa4ea8f60
>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>   Documentation/admin-guide/cgroup-v1/cpusets.rst | 2 +-
>   kernel/cgroup/cpuset.c                          | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index ae646d621a8a..88d0e7fa2ee0 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -179,7 +179,7 @@ files describing that cpuset:
>    - cpuset.mem_hardwall flag:  is memory allocation hardwalled
>    - cpuset.memory_pressure: measure of how much paging pressure in cpuset
>    - cpuset.memory_spread_page flag: if set, spread page cache evenly on allowed nodes
> - - cpuset.memory_spread_slab flag: if set, spread slab cache evenly on allowed nodes
> + - cpuset.memory_spread_slab flag: IT'S OBSOLETE. Please don't use it anymore
>    - cpuset.sched_load_balance flag: if set, load balance within CPUs on that cpuset
>    - cpuset.sched_relax_domain_level: the searching range when migrating tasks
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..728d06fe9382 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3897,6 +3897,9 @@ static struct cftype legacy_files[] = {
>   	},
>   
>   	{
> +		/* It's obsolete. Please don't use it anymore. We will remove it
> +		 * in the future.
> +		 */
>   		.name = "memory_spread_slab",
>   		.read_u64 = cpuset_read_u64,
>   		.write_u64 = cpuset_write_u64,


