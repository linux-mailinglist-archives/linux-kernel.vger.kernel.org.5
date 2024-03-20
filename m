Return-Path: <linux-kernel+bounces-109206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CD881629
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D69283F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6A69E16;
	Wed, 20 Mar 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkpveoak"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90153524B7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954576; cv=none; b=deiQz5KDghHP7b4xhCxQuhPjc1FX3Rg9uZEmHR9ZKLkyT7hmXEIJdLQgbk7i7+dJvbeEjwAhJbSl5rCG3QQwZwO1l6QMpR0C/cH0jhD/omD0DQ423+acX1D/YAEgi0TBfjESRbAFuA6ENw6rnPcHF4hLWSkEloXkaidTAFWM6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954576; c=relaxed/simple;
	bh=cwOplKnOlpfnkO+9zyj7wNpyrafIYfQAaUmbyDOrS2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhHdY+YKhvFh30owALqb1yLTapcPuaFfLxi4KYD0PJucLeVLfOaRO2B4o8jbp7dICTNPtcfD22ttPmS79WMzVwMk5ZPG6iOUzBM3kpKKsxGuF5KhPKC88O+SauHZwXlZcz4tvqaytRWky54h7NQzeGushg5sFl7vwyjyCsyH2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mkpveoak; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710954573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEKHjjXptO5fL1AUtCCz3ctgh31ZNxp9gR4ruj5ZuhA=;
	b=MkpveoakljoBMB7sNd+F18h6TUo8NoR6qvHaDXlLS9hjx1AQoxUIMYFN3KNC9ZjM4wuc5J
	lCJOVfDQ0woBqPIcjQRR6Ix9sfSt3iY2UE9d18pe5ysQq1GlErrz19Dtybb9VB3naro7Sq
	cQftSqRphVfTGhF5CdhYBD6F64FQ7Fo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Mnr2tHmdOX6gfMGHJxgtaA-1; Wed, 20 Mar 2024 13:09:29 -0400
X-MC-Unique: Mnr2tHmdOX6gfMGHJxgtaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BFC81CF3C;
	Wed, 20 Mar 2024 17:09:29 +0000 (UTC)
Received: from [10.22.33.243] (unknown [10.22.33.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64C0040C6DB7;
	Wed, 20 Mar 2024 17:09:28 +0000 (UTC)
Message-ID: <be05a470-bb31-47ef-b786-557c347de429@redhat.com>
Date: Wed, 20 Mar 2024 13:09:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Content-Language: en-US
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 3/20/24 06:03, Pavel Tikhomirov wrote:
> In memory_max_write() we first set memcg->memory.max and only then
> try to enforce it in loop. What if while we are in loop someone else
> have changed memcg->memory.max but we are still trying to enforce
> the old value? I believe this can lead to nasty consequence like getting
> an oom on perfectly fine cgroup within it's limits or excess reclaim.

Concurrent write to the same cgroup control file is not possible as the 
underlying kernfs_open_file structure has a mutex that serialize access 
to the file. Concurrent write to different cgroup control files is 
possible, though.

Cheers,
Longman

>
> We also have exactly the same thing in memory_high_write().
>
> So let's stop enforcing old limits if we already have a new ones.
>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>   mm/memcontrol.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 61932c9215e7..81b303728491 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6769,6 +6769,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
>   		unsigned long reclaimed;
>   
> +		if (memcg->memory.high != high)
> +			break;
> +
>   		if (nr_pages <= high)
>   			break;
>   
> @@ -6817,6 +6820,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>   	for (;;) {
>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
>   
> +		if (memcg->memory.max != max)
> +			break;
> +
>   		if (nr_pages <= max)
>   			break;
>   


