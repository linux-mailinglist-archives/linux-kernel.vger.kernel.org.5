Return-Path: <linux-kernel+bounces-154435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA68ADC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAE01F22A42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088818641;
	Tue, 23 Apr 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3Jy6hV7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917517BD2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840818; cv=none; b=GXXFzWmqN0d5BD8mEX4Qyvj8zCvm/BQ8oAQYfpI8lkxfbivuiA3o1XczWgp05DM4TmPiDygDv3lBGgAcwaLW0ol5j+rv7W5igTqpxUjs5jNbaBxVn+pszgmM/rUIKefCb7ZrKqV1BWQxeZteHlxqv2Rlb0q4v02l9cpXbg/8hdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840818; c=relaxed/simple;
	bh=hUy2NwK4SfQ20dn+seKulwjQP7VZkvebQQGsFBI5Nhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBmjI2hHiAiBxjZ1MNtK7mnGYzZqL9OjvF7EVlVEHGNLcnskBPC5UnPf52nPGXXIH+kBe1GKC1jwFCV63dyXq2ZLdot3M/sE4vR1aAedz4jidGFoyoopZKiraMC8V6B3ci4iVujMlKALsbKExV/FKKHxrTYyp99ibjDZeDpqAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3Jy6hV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713840815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHHK5+Fqa6ZKdYDjyl4I1FINs9qOnFj81l/KGssjU38=;
	b=S3Jy6hV7CIhvAau0bZpYusjK7Bxl5uRKqsKWgsIuIXo+5lnunbQUMan4ByilA7xEPaV9Ub
	qywcNX3hXYvpaakZpVi5bV2uSvMHIrkcZqJU2HEJROUpSRy8SKUYQ6gC6We1M1f1/RWuGJ
	Axzv3AFRsW4Xhf6x8WtT+mQbN3eE8tQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-GyatvBUCNXakD_kWV3bhqg-1; Mon,
 22 Apr 2024 22:53:31 -0400
X-MC-Unique: GyatvBUCNXakD_kWV3bhqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DDE3382C469;
	Tue, 23 Apr 2024 02:53:31 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA80E2166B32;
	Tue, 23 Apr 2024 02:53:30 +0000 (UTC)
Message-ID: <fd806ed3-372b-4911-838d-975f3aeef1d7@redhat.com>
Date: Mon, 22 Apr 2024 22:53:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/cpuset: Avoid clearing
 CS_SCHED_LOAD_BALANCE twice
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423024439.1064922-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240423024439.1064922-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 4/22/24 22:44, Xiu Jianfeng wrote:
> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE will be cleared twice,
> the former one in the is_in_v2_mode() case could be removed because
> is_in_v2_mode() can be true for cgroup v1 if the "cpuset_v2_mode"
> mount option is specified, that balance flag change isn't appropriate
> for this particular case.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> ---
> v2: remove the one in is_in_v2_mode() case.
> ---
>   kernel/cgroup/cpuset.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d8d3439eda4e..bb9bf25889c9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4051,11 +4051,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   		cs->effective_mems = parent->effective_mems;
>   		cs->use_parent_ecpus = true;
>   		parent->child_ecpus_count++;
> -		/*
> -		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
> -		 */
> -		if (!is_sched_load_balance(parent))
> -			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	}
>   
>   	/*

Thank for the v2.

Reviewed-by: Waiman Long <longman@redhat.com>


