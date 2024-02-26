Return-Path: <linux-kernel+bounces-80419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD3C86684D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63BC1C20E67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1427F9C3;
	Mon, 26 Feb 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUItaLg0"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89CDDDC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915529; cv=none; b=iyt02dSq8WTv9AxciY9DYIOMtkLyeX/4wvPs81mwTjZX1V/2XgZVE2yIzSkZ8c+Qz1u8tV09sSzjp3+d+Q/fnCyvi+RXL0rUkejehkvwM7BUvTLIl6B9X5Ile+S5l7aMYY0UeKiVrnB7ar8x3t4Y91LrgLoXVGbhCEbrvYRSfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915529; c=relaxed/simple;
	bh=PalAJumk0yXOFN5Y7DB8wpkp9aitcOfFF/UpakzgInY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElsbHcFgGW0DU5nqXdbCqmQl9DnukhkiS5/EJArJ0MQzs5RdrmXi8sV2+szUQhmRtw+67jILRw7igOB3CTg8c036sSkO/t8cb1EKHGWLLBv4ZMzKzmZMEZszJyUnETGCwtM5K4u9LecnsFoFW7gYvDEK6EUn79uNt4bsBpYyYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUItaLg0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f143006a-e014-4ad9-b19e-25e1a45a75c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708915525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXnD7RPS7a0IM2G7o5VSGYEyaa6ZbvJGWVpct+px6Vk=;
	b=IUItaLg0MK+ENd5N/W7leikGICW7KA6Vzo4Zf+SyNTa+06xzai3RT6lBLdr+tZiMM8J9Q7
	Vycgeex9KHPChU/o/AKjOd0ucEcKwjsxvfwPw73B+xBGHgB20qYW0FbOVldIhQhnV2rf0A
	su6RF5+18kIkaxumvHUX8w0nhTBLGSg=
Date: Mon, 26 Feb 2024 10:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] jffs2: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: dwmw2@infradead.org, richard@nod.at, jack@suse.cz,
 chuck.lever@oracle.com, dave.kleikamp@oracle.com, amir73il@gmail.com
Cc: zhouchengming@bytedance.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com
References: <20240224134915.829634-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134915.829634-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:49, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag. And the series[1]
went on to mark it obsolete to avoid confusion for users. Here we
can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/jffs2/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index f99591a634b4..aede1be4dc0c 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -387,7 +387,7 @@ static int __init init_jffs2_fs(void)
>  	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
>  					     sizeof(struct jffs2_inode_info),
>  					     0, (SLAB_RECLAIM_ACCOUNT|
> -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +						SLAB_ACCOUNT),
>  					     jffs2_i_init_once);
>  	if (!jffs2_inode_cachep) {
>  		pr_err("error: Failed to initialise inode cache\n");

