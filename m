Return-Path: <linux-kernel+bounces-86844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53D86CB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6651C21961
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74371361A1;
	Thu, 29 Feb 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZjMd6Nj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F2130AC1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216983; cv=none; b=LCqlidPCTtsDwsfhOdCSSpaXUOPNJ/I4lWCiMxSHpB9WYijFeRsTS9oFMjHJ1YmtjvaOw0F+Bw0tvdZu/VHMlRIHW+fc+fLXJ6PL5/0DpBysiU9mFFG3fqSWNTf5p86eVWlepIEh0mqg8G/5cbjidFtyR1BCTwSGrF6LWqQSGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216983; c=relaxed/simple;
	bh=K4+fbJQvKKYfXr6QSBPwM7KmLB+wWWg+oWBZ19i7qns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5FkM2IMgkpQie0zCXaMDm801GuAP4cAi6+ScWyD/XBUwPHcmjhcx6dy5ksziLIRj02dF9CQVOsx0vMcpm7lu7aTgwm63I3ik1xCarZUzscBPEVM9HG7GOWSAAjTrMNPuKpf83+zhGznYuTpZQ4qmV4fMgzKTHBnjsUFWZNoDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZjMd6Nj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709216980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiT3XNyZUH95vAKW5douxdlTZiY7Es2dmDaVN90xKxw=;
	b=bZjMd6NjoqN22IXp0Hw1kGP8kyw7zWBqsZaiyLuXU9sQuhL7/nTKKnpoyrbgb4xafCfyLi
	QItzu+vuKxVyUhRBTERP/YYglMLG7tBeghbGUMgItXxd5M4B35k9pNHStXJf7hYahjgJ6S
	XumN6ckoeF6Q6YY0fTKKHWO3BfJ6ymg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-MR_t1szwNcy432pLgrTpJA-1; Thu, 29 Feb 2024 09:29:35 -0500
X-MC-Unique: MR_t1szwNcy432pLgrTpJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6338F85A599;
	Thu, 29 Feb 2024 14:29:31 +0000 (UTC)
Received: from [10.22.8.117] (unknown [10.22.8.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36B2D492BE2;
	Thu, 29 Feb 2024 14:29:30 +0000 (UTC)
Message-ID: <90394965-e2a4-4915-a717-eef75f660dfb@redhat.com>
Date: Thu, 29 Feb 2024 09:29:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Remove cpuset_do_slab_mem_spread()
Content-Language: en-US
To: Xiongwei Song <xiongwei.song@windriver.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net
Cc: vbabka@suse.cz, yosryahmed@google.com, rostedt@goodmis.org, cl@linux.com,
 chengming.zhou@linux.dev, zhengyejian1@huawei.com, cgroups@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229142007.1278610-1-xiongwei.song@windriver.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240229142007.1278610-1-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 2/29/24 09:20, Xiongwei Song wrote:
> The SLAB allocator has been removed sine 6.8-rc1 [1], so there is no user
> with SLAB_MEM_SPREAD and cpuset_do_slab_mem_spread(). Then SLAB_MEM_SPREAD
> is marked as unused by [2]. Here we can remove
> cpuset_do_slab_mem_spread(). For more details, please check [3].
>
> [1] https://lore.kernel.org/linux-mm/20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz/
> [2] https://lore.kernel.org/linux-kernel/20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz/T/
> [3] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#mf14b838c5e0e77f4756d436bac3d8c0447ea4350
>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>   include/linux/cpuset.h | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 875d12598bd2..0ce6ff0d9c9a 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -121,11 +121,6 @@ static inline int cpuset_do_page_mem_spread(void)
>   	return task_spread_page(current);
>   }
>   
> -static inline int cpuset_do_slab_mem_spread(void)
> -{
> -	return task_spread_slab(current);
> -}
> -
>   extern bool current_cpuset_is_being_rebound(void);
>   
>   extern void rebuild_sched_domains(void);
> @@ -264,11 +259,6 @@ static inline int cpuset_do_page_mem_spread(void)
>   	return 0;
>   }
>   
> -static inline int cpuset_do_slab_mem_spread(void)
> -{
> -	return 0;
> -}
> -
>   static inline bool current_cpuset_is_being_rebound(void)
>   {
>   	return false;
Reviewed-by: Waiman Long <longman@redhat.com>


