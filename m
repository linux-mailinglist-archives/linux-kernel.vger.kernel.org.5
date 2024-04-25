Return-Path: <linux-kernel+bounces-158516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7438B2195
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777BBB23171
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D412C468;
	Thu, 25 Apr 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcXZjaHA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116112BF32
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047896; cv=none; b=GXQsXiwlbQDsRIPSZgA0O6f4k6GTdEZoO4CHjbRDoGhhNmDC1j8AcNgLvNrzrV5fjtZ7PljSg6l4rbHzwHCdJOrAaJ994elbtwx+q6YWfj5gnMUr8Ws3e1pH7iP5Eyg/j5sKHfu/FP/SH7vZRKcfC6fBZU0n8b5j7b7q+XszVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047896; c=relaxed/simple;
	bh=M71qeK8Sdn8NVW2kZBFrMrpoDYzrjWTiYmyUYOxRzpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWAN7H4fzyqF3shjnlbhN/8xnbFsz99Mpl3G6u163WkNWyiw6VE4e2Dh6QgXVYZmOZKUhDKPLek1WPoBKU1jE0m7fkYeAndK5k5Yrp0s1+l3sQ3jcpN57N2ZjTd95vMZJq6H+Mnx8myAtTO5t0VxyanZEkNeYp1qrpWO/LUSj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcXZjaHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714047894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRbwdG+1XunRLInxSf/AH761bg3jaFbuEZ5fAcJb3TY=;
	b=XcXZjaHA/IXooJMa+Y7QNb67CbKkm/og3i2878IYY4+58FP7qDJgFBhLDC60vck6g4KQ7p
	bV65aUUz9G0QPA8RZxIzXNenYvmomFVRSlnRLU+X25yjlK3YuAC1eaverc4jEf0F+Rkx2O
	DGcdxByhTWlSQmym8/rHJpETqkn+RC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fbcaXE1cMpCWsRlt9eVr4g-1; Thu, 25 Apr 2024 08:24:48 -0400
X-MC-Unique: fbcaXE1cMpCWsRlt9eVr4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3252800CA2;
	Thu, 25 Apr 2024 12:24:47 +0000 (UTC)
Received: from [10.22.17.9] (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81A7040F01A;
	Thu, 25 Apr 2024 12:24:47 +0000 (UTC)
Message-ID: <a834a59d-9f31-4374-923f-ddd89780b62a@redhat.com>
Date: Thu, 25 Apr 2024 08:24:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Remove outdated comment in
 sched_partition_write()
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240425093016.1068567-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240425093016.1068567-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 4/25/24 05:30, Xiu Jianfeng wrote:
> The comment here is outdated and can cause confusion, from the code
> perspective, there’s also no need for new comment, so just remove it.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f5443c039619..a10e4bd0c0c1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3774,9 +3774,6 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
>   
>   	buf = strstrip(buf);
>   
> -	/*
> -	 * Convert "root" to ENABLED, and convert "member" to DISABLED.
> -	 */
>   	if (!strcmp(buf, "root"))
>   		val = PRS_ROOT;
>   	else if (!strcmp(buf, "member"))

Yes, that comment is now no longer relevant.

Acked-by: Waiman Long <longman@redhat.com>


