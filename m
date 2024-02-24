Return-Path: <linux-kernel+bounces-79792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846318626C4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7271F21A54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B7495EC;
	Sat, 24 Feb 2024 18:28:08 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984F4502E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799288; cv=none; b=lM5sYY+TVIARQJvY2w1GzkfhNDDQdpurS2BPY+h5wvx3XHwOl1vUGYvgmRBKKW2eu9gu4MfyTlUxDypVAnuKwFgxJOS2pV6KzctmZt00zxbbOqLARVLx8IqOwWQP+fWPJZvLrjz/2FqwYmnH+bFBy/KSS22lB2zti1ItQXjNSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799288; c=relaxed/simple;
	bh=4jZ/BLa1iPoTrZvcjp+5vmhJc+TXEuPgx41L+2YC7jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxPG5+aeQw8WKj245IkvF7O/WeOVw8tv+lghp07jiVHgxIq8y0G1oxFlwEzTalZr/XKMM1wpCjSLYT6IYCfJKEjJ08DHrVlaDNRR5w1ZtyOgo8yrdaqqmo60LF4T16vSfMSuJsJf9G1QSKZ5U0jSEqZXen9hXQ7vWNwfi3vSxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E70D3233CCB9;
	Sun, 25 Feb 2024 03:27:57 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41OIRsU4094238
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 03:27:55 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41OIRsIi308651
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 03:27:54 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41OIRsIL308642;
	Sun, 25 Feb 2024 03:27:54 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
        Chengming Zhou
 <zhouchengming@bytedance.com>
Subject: Re: [PATCH] fat: remove SLAB_MEM_SPREAD flag usage
In-Reply-To: <20240224134828.829481-1-chengming.zhou@linux.dev> (chengming
	zhou's message of "Sat, 24 Feb 2024 13:48:28 +0000")
References: <20240224134828.829481-1-chengming.zhou@linux.dev>
Date: Sun, 25 Feb 2024 03:27:54 +0900
Message-ID: <87msrpaf9x.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chengming.zhou@linux.dev writes:

> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>  fs/fat/cache.c | 2 +-
>  fs/fat/inode.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/cache.c b/fs/fat/cache.c
> index 738e427e2d21..2af424e200b3 100644
> --- a/fs/fat/cache.c
> +++ b/fs/fat/cache.c
> @@ -47,7 +47,7 @@ int __init fat_cache_init(void)
>  {
>  	fat_cache_cachep = kmem_cache_create("fat_cache",
>  				sizeof(struct fat_cache),
> -				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
> +				0, SLAB_RECLAIM_ACCOUNT,
>  				init_once);
>  	if (fat_cache_cachep == NULL)
>  		return -ENOMEM;
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 5c813696d1ff..d9e6fbb6f246 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -787,7 +787,7 @@ static int __init fat_init_inodecache(void)
>  	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
>  					     sizeof(struct msdos_inode_info),
>  					     0, (SLAB_RECLAIM_ACCOUNT|
> -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +						SLAB_ACCOUNT),
>  					     init_once);
>  	if (fat_inode_cachep == NULL)
>  		return -ENOMEM;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

