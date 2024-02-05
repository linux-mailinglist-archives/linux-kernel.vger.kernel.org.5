Return-Path: <linux-kernel+bounces-52497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153F849905
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129581F21063
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9818E1A;
	Mon,  5 Feb 2024 11:40:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60DD17541
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133259; cv=none; b=u81+9l98106kD6NjhYu9te2jn5RCkv+H8e//1pQ48vPQR96PINUYHrCBt6PCPO8+ZhaPANhsFlA7ob0wEQEIKhfNwO++kw2x1MzvVCXMfCEeF4FNfYUKLL+8308IZXdXnMnohXfl+mMmLagmV/Vvw70WF15xHwmGQYl8eeZ8mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133259; c=relaxed/simple;
	bh=FTvjvIo8DKZyuUAFvm9WQSLA8CUq73diI3U1Y0Bm6nY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uPShymcyFFwW4B+y4Fu5T11LngtSrH+bPyUDY8NvbbL/6waJ71jnttSHt/IY5FiV812eB8waExtHVy5UpVFQTSGeoT03b0G2Uehmc4jxRJ7Ij9H78//16bKjNBZNmKYmuIZ6LW5sygQvtIaGLN5lehYg+HIwUpJUe9QYj8UtVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TT4CR1MrWz29lHD;
	Mon,  5 Feb 2024 19:38:59 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 120B61A0172;
	Mon,  5 Feb 2024 19:40:54 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 19:40:53 +0800
Subject: Re: [PATCH] jffs2: Simplify the allocation of slab caches
To: Kunwu Chan <chentao@kylinos.cn>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240205075144.431567-1-chentao@kylinos.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fe71e834-3b13-9b9c-db87-ba106e8c78e0@huawei.com>
Date: Mon, 5 Feb 2024 19:40:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240205075144.431567-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/5 15:51, Kunwu Chan Ð´µÀ:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> And change cache name from 'jffs2_tmp_dnode' to 'jffs2_tmp_dnode_info'.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   fs/jffs2/malloc.c | 32 ++++++++------------------------
>   1 file changed, 8 insertions(+), 24 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
> index ce1189793288..411de8b361b2 100644
> --- a/fs/jffs2/malloc.c
> +++ b/fs/jffs2/malloc.c
> @@ -33,27 +33,19 @@ static struct kmem_cache *xattr_ref_cache;
>   
>   int __init jffs2_create_slab_caches(void)
>   {
> -	full_dnode_slab = kmem_cache_create("jffs2_full_dnode",
> -					    sizeof(struct jffs2_full_dnode),
> -					    0, 0, NULL);
> +	full_dnode_slab = KMEM_CACHE(jffs2_full_dnode, 0);
>   	if (!full_dnode_slab)
>   		goto err;
>   
> -	raw_dirent_slab = kmem_cache_create("jffs2_raw_dirent",
> -					    sizeof(struct jffs2_raw_dirent),
> -					    0, SLAB_HWCACHE_ALIGN, NULL);
> +	raw_dirent_slab = KMEM_CACHE(jffs2_raw_dirent, SLAB_HWCACHE_ALIGN);
>   	if (!raw_dirent_slab)
>   		goto err;
>   
> -	raw_inode_slab = kmem_cache_create("jffs2_raw_inode",
> -					   sizeof(struct jffs2_raw_inode),
> -					   0, SLAB_HWCACHE_ALIGN, NULL);
> +	raw_inode_slab = KMEM_CACHE(jffs2_raw_inode, SLAB_HWCACHE_ALIGN);
>   	if (!raw_inode_slab)
>   		goto err;
>   
> -	tmp_dnode_info_slab = kmem_cache_create("jffs2_tmp_dnode",
> -						sizeof(struct jffs2_tmp_dnode_info),
> -						0, 0, NULL);
> +	tmp_dnode_info_slab = KMEM_CACHE(jffs2_tmp_dnode_info, 0);
>   	if (!tmp_dnode_info_slab)
>   		goto err;
>   
> @@ -63,28 +55,20 @@ int __init jffs2_create_slab_caches(void)
>   	if (!raw_node_ref_slab)
>   		goto err;
>   
> -	node_frag_slab = kmem_cache_create("jffs2_node_frag",
> -					   sizeof(struct jffs2_node_frag),
> -					   0, 0, NULL);
> +	node_frag_slab = KMEM_CACHE(jffs2_node_frag, 0);
>   	if (!node_frag_slab)
>   		goto err;
>   
> -	inode_cache_slab = kmem_cache_create("jffs2_inode_cache",
> -					     sizeof(struct jffs2_inode_cache),
> -					     0, 0, NULL);
> +	inode_cache_slab = KMEM_CACHE(jffs2_inode_cache, 0);
>   	if (!inode_cache_slab)
>   		goto err;
>   
>   #ifdef CONFIG_JFFS2_FS_XATTR
> -	xattr_datum_cache = kmem_cache_create("jffs2_xattr_datum",
> -					     sizeof(struct jffs2_xattr_datum),
> -					     0, 0, NULL);
> +	xattr_datum_cache = KMEM_CACHE(jffs2_xattr_datum, 0);
>   	if (!xattr_datum_cache)
>   		goto err;
>   
> -	xattr_ref_cache = kmem_cache_create("jffs2_xattr_ref",
> -					   sizeof(struct jffs2_xattr_ref),
> -					   0, 0, NULL);
> +	xattr_ref_cache = KMEM_CACHE(jffs2_xattr_ref, 0);
>   	if (!xattr_ref_cache)
>   		goto err;
>   #endif
> 


