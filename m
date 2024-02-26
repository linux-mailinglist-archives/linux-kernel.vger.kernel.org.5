Return-Path: <linux-kernel+bounces-80989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF5866EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF81B1F23F25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678E692E1;
	Mon, 26 Feb 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hmvG7ZZb"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11E200C1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937822; cv=none; b=gXeQl6SKox/BFvuXqo+ILN3qlcjpU6AGVy3haYCvS3fKifdT9+4RTDsNSFqnDZLIS/a7nIrPhOpYsXzTEmw6GJ03PcQS/dkIuhxeSoVKFE211Hn+bJfKbk1FdLwSyBlZIAF3w/2B9Gcuhmp8k4YvUVcXB1ztO1bBJJEr6ICAz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937822; c=relaxed/simple;
	bh=NCs7KXMkR73TyLq3zlhtWcjwVGo6xeuNfCRPfI4YKiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3k6jihx4F2YtWBQCjElF7rVnuDiu3sZmSglAX8ksAbYryP5ekPWWNKC0RV1igchCCZdVQMwSjkhw3YKcaG4rJLO/PHMFnotWpzW7tfgtJkgMPdcSHyB2ZF3VIVfoXAy6N6itv3lu8AEy8GyEq0onDlet5MXBSJGupeptPV6Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hmvG7ZZb; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <622ec9c6-d914-44d9-a89b-6e8dfdfad508@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1rS6GiWYWch2+xT07XfBXCU7RxHpePOv1woC2yZJzk=;
	b=hmvG7ZZbJD8pRqMEePC7yPkYmmMYKeg+3EqSWY/pL2vT3TPXHfeRld4uxWkY2jzfDkBBIc
	WH4vCU5XL4fgqjjoce6I7h0D9vjD1hyIpKnoxJptYXSyHEubled5/NjXyI7hskrqp8iNdt
	tFyp478aONonhPKRY9JRVGXcnNQBlbA=
Date: Mon, 26 Feb 2024 16:56:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] overlayfs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: miklos@szeredi.hu, amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 vbabka@suse.cz, Xiongwei.Song@windriver.com
References: <20240224135036.829942-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224135036.829942-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:50, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/overlayfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 36d4b8b1f784..a40fc7e05525 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1503,7 +1503,7 @@ static int __init ovl_init(void)
>  	ovl_inode_cachep = kmem_cache_create("ovl_inode",
>  					     sizeof(struct ovl_inode), 0,
>  					     (SLAB_RECLAIM_ACCOUNT|
> -					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +					      SLAB_ACCOUNT),
>  					     ovl_inode_init_once);
>  	if (ovl_inode_cachep == NULL)
>  		return -ENOMEM;

