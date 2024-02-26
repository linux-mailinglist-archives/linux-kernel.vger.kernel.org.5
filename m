Return-Path: <linux-kernel+bounces-80992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19922866ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1C7B25B54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F769D24;
	Mon, 26 Feb 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sStrBB5W"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DF200D1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937916; cv=none; b=o7oU/kWI6QhGFZI4Z41GdctXXTpYhfVnCtOiTEhEHQo5q3V5DhLAxr4a73EiBkB4s0Xtg+7k1a79d98/MaSPUC/4cW/DMgSwP/KPxPgIVU7sNl7QMkQecHIKP6MA4bNCncfo2Keq8wDEcjc9Eh66nec+3eFyhbVknoTjZvuUqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937916; c=relaxed/simple;
	bh=ylcPl73swbUWH52dSs7sRtTNDPJUZyugtIFo6/AOXd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLMn0xQgY6x8JGNNqOV3/ZMitKuvBnpDdhJu9uZyk6UZe7ipgTilmDvbGhZHbHUIojIZOkepG9GIPw+C0LvIjBei30LoOSQKtwxoxey5t12QMLERl0W7eo8BEI+FTd7d77gIBddkS21Jttmy1L2wyonXpho6haiFtjEXb9aIvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sStrBB5W; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd4b398a-2eb7-45b2-bee0-8a713fface39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDeT2Jb40WhRUJEPsxXyxStjlm8yn+a63sbry1VMGVg=;
	b=sStrBB5Wod0QcmqsxKziprmj4JGUZULeycmz4DiBVKpuFMhNfXCCRkOW4vF60WVFvT+a9Z
	fPKsxHPlpnAxf6p/IhWdLgvownBXU92gfuf/Or5fDh8fftW/gN1kcSofRr6qHWdkI/b2L6
	4XDleCHekWzThaAfTbQfv6mqHx9/fOw=
Date: Mon, 26 Feb 2024 16:58:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] vfs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 vbabka@suse.cz, Xiongwei.Song@windriver.com
References: <20240224135315.830477-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224135315.830477-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:53, chengming.zhou@linux.dev wrote:
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
>  fs/buffer.c  | 2 +-
>  fs/dcache.c  | 2 +-
>  fs/inode.c   | 2 +-
>  fs/mbcache.c | 3 +--
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b55dea034a5d..9a54077de87d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3122,7 +3122,7 @@ void __init buffer_init(void)
>  	int ret;
>  
>  	bh_cachep = KMEM_CACHE(buffer_head,
> -				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD);
> +				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
>  	/*
>  	 * Limit the bh occupancy to 10% of ZONE_NORMAL
>  	 */
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 6ebccba33336..71a8e943a0fa 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3139,7 +3139,7 @@ static void __init dcache_init(void)
>  	 * of the dcache.
>  	 */
>  	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
> -		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
> +		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
>  		d_iname);
>  
>  	/* Hash may have been set up in dcache_init_early */
> diff --git a/fs/inode.c b/fs/inode.c
> index 6d0d54230363..d2e8e3884b36 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2286,7 +2286,7 @@ void __init inode_init(void)
>  					 sizeof(struct inode),
>  					 0,
>  					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
> -					 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +					 SLAB_ACCOUNT),
>  					 init_once);
>  
>  	/* Hash may have been set up in inode_init_early */
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index fe2624e17253..e60a840999aa 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @@ -426,8 +426,7 @@ EXPORT_SYMBOL(mb_cache_destroy);
>  
>  static int __init mbcache_init(void)
>  {
> -	mb_entry_cache = KMEM_CACHE(mb_cache_entry,
> -					 SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD);
> +	mb_entry_cache = KMEM_CACHE(mb_cache_entry, SLAB_RECLAIM_ACCOUNT);
>  	if (!mb_entry_cache)
>  		return -ENOMEM;
>  	return 0;

