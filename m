Return-Path: <linux-kernel+bounces-153845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D88AD418
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E71F21B45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC8154BF9;
	Mon, 22 Apr 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFknq1a0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58450153837
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811132; cv=none; b=rNe9adfZoioF+21mg+WT4zBO/7rIYFyaUAGiOV07j0RzVjIczDYZVBt1nUwOvZ+WWketaWPLxao07Wgk9d8uH139bR1l0kK/SiTNUUz3jf+YyAZIIdBB2aNuk0e2HoQde8NEe5vdsWOD+gUs2GPJ9bk4m8MVTAsvWWiIWpOX858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811132; c=relaxed/simple;
	bh=twuLgGtiggTWXRs+LZFj1YP8jXpFbLjDXPzT7EG9VOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAuxk9Tqsz/d84XRqVljQd1jHiK57R1MS2IOCjC61IIZGL7odtbIZvUi3LXKCyjuPuacEr9O/v96NYlWOPfSI406pzbz0XGvRb7z8RuWSP53wxfAHlBNey7ZTy4hAoXMTfy5b+oVjzFA//0pBVGHMBYKcjiSDeJVeORMEImYTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFknq1a0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713811130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOsdhDWuSUFMXxTqd4Lt3sQHh6IbAPnGtwXA6iPfEJ8=;
	b=KFknq1a0rxtFoh0cVfYGWOts777nD5hdiUB8OeDdNDKTlmC1Yfes1jeuG4/rMBgLwJT/qM
	qK54YNMg5gucTMIwHiXLqHdVB/P6EO8JL4IIHf/Cgbz9ei1cFwTYBL1dm7MBk1wJK49vXS
	Mic36PY8kAAfEN1yYN8QgP/Lo2LFJho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ptsEVJUbNAKkKg-J4OfEiQ-1; Mon, 22 Apr 2024 14:38:45 -0400
X-MC-Unique: ptsEVJUbNAKkKg-J4OfEiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 390A980591B;
	Mon, 22 Apr 2024 18:38:45 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1232200AE7F;
	Mon, 22 Apr 2024 18:38:44 +0000 (UTC)
Message-ID: <f2fc2eb8-44e0-4805-86c0-f9062380b3e8@redhat.com>
Date: Mon, 22 Apr 2024 14:38:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE
 twice
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094713.1028579-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240420094713.1028579-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 4/20/24 05:47, Xiu Jianfeng wrote:
> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE has been cleared in the
> is_in_v2_mode() case under the same condition, don't do it twice.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e70008a1d86a..159525cdaeb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4059,13 +4059,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	}
>   
> -	/*
> -	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
> -	 */
> -	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
> -	    !is_sched_load_balance(parent))
> -		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
> -
>   	spin_unlock_irq(&callback_lock);
>   
>   	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))

Thanks for catching this duplication.

Could you remove the check inside is_in_v2_mode() instead? 
is_in_v2_mode() can be true for cgroup v1 if the"cpuset_v2_mode" mount 
option is specified. That balance flag change isn't appropriate for this 
particular case.

Thanks,
Longman


