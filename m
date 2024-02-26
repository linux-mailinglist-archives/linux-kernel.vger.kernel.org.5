Return-Path: <linux-kernel+bounces-80425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E3E866858
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337428214A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D920101D5;
	Mon, 26 Feb 2024 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AAVh+6v9"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E4FBEF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915875; cv=none; b=VBH4kliLt2AvbovVv0Q4b7qtHc8ZHOeZuvDssa1GZir/F+wdCKdQzeO6SZs4cEw9DAnWjbRJChJEreZKhfRYoAQJSGYvgf6pWb2r7xJ4Jib2NqqZFgt8qlrD9FWc7IfcWC5grjCBJ7KjlnlCf+huA0Jn2Jcch/Yzq0iqb26QulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915875; c=relaxed/simple;
	bh=EnOHlUnDap/4ImmT/XsmmXsgwlD7LDaUp8b6N0konyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ3hQjv9X1z6LAo/EkFTg890d9AEZig3m5sCT/z7t2fHo9DmRG2eLmUTH8rczLJefM0G109vG2ntROsoasG174T4zYOjJYBS6G9Jlmn5/fTvun6RQJGx8WqAVg67jk7BI2ULXc8fRUovdIAhhSAdDkeAUi7GQrquYNfW48gjaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AAVh+6v9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2de0d872-0e05-4fbb-8291-0c60487ccd8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708915871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpE4nKekj14CCL2IymlyiWfeetzm5jT90k6NA0P2Cno=;
	b=AAVh+6v9wFk4dmisJwwBRgraOeOiFyGFIwh+4C65jKf/9TZKgQLn5XY4/xwB26xUcqbPN1
	4/ovo7RE0VJgUzevD2xr/iCFfCJ7SsfeXOhXCqU0ppSAxvNjnXBTTvqfXNGmbMy9pE5apV
	CBQ213bJpXBUrmcJdffyoq6eRcJCAzM=
Date: Mon, 26 Feb 2024 10:51:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] 9p: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224134617.829016-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134617.829016-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:46, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/9p/v9fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 61dbe52bb3a3..281a1ed03a04 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -637,7 +637,7 @@ static int v9fs_init_inode_cache(void)
>  	v9fs_inode_cache = kmem_cache_create("v9fs_inode_cache",
>  					  sizeof(struct v9fs_inode),
>  					  0, (SLAB_RECLAIM_ACCOUNT|
> -					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +					      SLAB_ACCOUNT),
>  					  v9fs_inode_init_once);
>  	if (!v9fs_inode_cache)
>  		return -ENOMEM;

