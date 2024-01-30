Return-Path: <linux-kernel+bounces-44546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8C84240C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5432282C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1A6A00F;
	Tue, 30 Jan 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWzCyAlT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A26773C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615175; cv=none; b=I+paSmgdbhlZGTrsrUoRP1egfkDOy9dCeQ8venPsUxrfU6H74ntGVYSz/dk1kZykkCDExQu8rJt2aVW4WkO7Jgu+9OrfaFtHRtqoNwVvGaGf4iCUNwZG211PWgZl95sZFLRNwP93kUk7I1RV+1WJrrvIwrzMqFjKjZCITcWhqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615175; c=relaxed/simple;
	bh=s6N1gkYvyY3hDBDbP8HT9EefNkFyTfoHZIbsaI0LxsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tKSyRuUVdVQfcts+5On/G/wHdhcOrgQIgXrX3sF/46dZWS+SlVY3NtZJHQxUcpbXDYq0KBa0j/YpF7hHJQArC4sfjxB1kV3ckQnUEqiEQGVdT2bHNSinpqEEEU4T2gcq8AmZefwM5H7Cqv31oT2uZBcYxeOVFf2Itw8D+dDt4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWzCyAlT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706615172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNC4RnR1LP3JLZK3mU2j4+a+R8GFkfNE9wD4WslHeU4=;
	b=iWzCyAlTyj5JgZAdW+17FtvMeEXORatJuRd1yIJgRivdElGaE9IGMup65eBIqCe9GZnJGU
	LT2dh9vioQrzgfEy+gExN187K/zXUieZB+FpBp6py8IW3OTJbzaDmVZvA6KFN/ZiwVkM9/
	2EIaq8mGWbDlXz7kXaumzjFNKhs0+mw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-1fs-sfDbNryD18DHM1ANyA-1; Tue, 30 Jan 2024 06:46:09 -0500
X-MC-Unique: 1fs-sfDbNryD18DHM1ANyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04E9B85A599;
	Tue, 30 Jan 2024 11:46:09 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C01640C95AD;
	Tue, 30 Jan 2024 11:46:08 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 7F56B30C14EB; Tue, 30 Jan 2024 11:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7A9C13FB4E;
	Tue, 30 Jan 2024 12:46:08 +0100 (CET)
Date: Tue, 30 Jan 2024 12:46:08 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
cc: heinzm@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org, 
    dm-devel@lists.linux.dev, song@kernel.org, yukuai3@huawei.com, 
    jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
    linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
    yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v4 13/14] dm: wait for IO completion before removing
 dm device
In-Reply-To: <20240130021843.3608859-14-yukuai1@huaweicloud.com>
Message-ID: <fa4cd2f8-d0e8-5b6d-2ac6-1c5f1710a5ee@redhat.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com> <20240130021843.3608859-14-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2



On Tue, 30 Jan 2024, Yu Kuai wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> __dm_destroy() guarantee that device openers is zero, and then
> only call 'presuspend' and 'postsuspend' for the target. For
> request-based dm, 'md->holders' will be grabbed for each rq and
> __dm_destroy() will wait for 'md->holders' to be zero. However, for
> bio-based device, __dm_destroy() doesn't wait for all bios to be done.
> 
> Fix this problem by calling dm_wait_for_completion() to wail for all
> inflight IO to be done, like what dm_suspend() does.

If the number of openers is zero, it is guaranteed that there are no bios 
in flight. Therefore, we don't have to wait for them.

If there are bios in flight, it is a bug in the code that issues the bios. 
You can put WARN_ON(dm_in_flight_bios(md)) there.

Mikulas

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..2c0eae67d0f1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -58,6 +58,7 @@ static DEFINE_IDR(_minor_idr);
>  static DEFINE_SPINLOCK(_minor_lock);
>  
>  static void do_deferred_remove(struct work_struct *w);
> +static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_state);
>  
>  static DECLARE_WORK(deferred_remove_work, do_deferred_remove);
>  
> @@ -2495,6 +2496,8 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
>  	if (!dm_suspended_md(md)) {
>  		dm_table_presuspend_targets(map);
>  		set_bit(DMF_SUSPENDED, &md->flags);
> +		if (wait)
> +			dm_wait_for_completion(md, TASK_UNINTERRUPTIBLE);
>  		set_bit(DMF_POST_SUSPENDING, &md->flags);
>  		dm_table_postsuspend_targets(map);
>  	}
> -- 
> 2.39.2
> 


