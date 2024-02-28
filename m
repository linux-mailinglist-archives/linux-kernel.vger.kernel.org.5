Return-Path: <linux-kernel+bounces-84763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9255186AB30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F5528736F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A332C89;
	Wed, 28 Feb 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxkUMgHo"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7202D606
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112681; cv=none; b=gFR8+1M+L9AQYJk8aetYlI/JGGp5TBfDk71JTidBuOQYEKk09SGm1X2VNGDlRBODQlXLIY9mQINC7OhJHgxaqVuIYQxU0HK3LTbOL1GXE+NKlau98ANV5VHKRzQ3NHAP4TMLFGTIWbyZZrGoCO4Ipxa2Bpb2vWFNckc5SomZUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112681; c=relaxed/simple;
	bh=ggsQyXDpBQNykNIgrvksbxqVHHrQQxhUfF3Xmc//E30=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bk7sFYddANxaMKZ+6wen+JdIaAkRkQHh/1/K4go5siT00adrRwauMg1uCTtXp4sP/MY2SSM88D10z++7pLDyjbKwTt/YabuwReK0qTNG/Kq3E1x88jgpMZRcyR2K7XZY8UFdjsFl3WNksDTVOPtToaJIxSVdVT0pIzJjhfzB9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxkUMgHo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a315427f-fe39-4714-a21c-1c104460d3fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709112676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyL/BrWdx5wm+hWvNvDksX7lVp1tOfJaEY5Dk9iJ0w=;
	b=FxkUMgHoZ8vP94baYaMWYAKTYOvHCcfPNQOLWsscKf6JV6oUu2rmY/Gae2+2Ktpv5sOrxl
	aKR1CyClv8PF3fBMdO9dbk249uKOv8/dOeWCZMXP6LuJTWCyD6nPQwI24LshbKBxrjvRPf
	w9mpzeiZd30A7jC7MU1uyfZboJ8N1OY=
Date: Wed, 28 Feb 2024 17:31:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slab: Fix a kmemleak in kmem_cache_destroy()
Content-Language: en-US
To: Xiaolei Wang <xiaolei.wang@windriver.com>, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/28 11:04, Xiaolei Wang wrote:
> For earlier kmem cache creation, slab_sysfs_init() has not been called.
> Consequently, kmem_cache_destroy() cannot utilize kobj_type::release to
> release the kmem_cache structure. Therefore, tweak kmem_cache_release()
> to use slab_kmem_cache_release() for releasing kmem_cache when slab_state
> isn't FULL. This will fixes the memory leaks like following:
> 
> unreferenced object 0xffff0000c2d87080 (size 128):
>    comm "swapper/0", pid 1, jiffies 4294893428
>    hex dump (first 32 bytes):
>      00 00 00 00 ad 4e ad de ff ff ff ff 6b 6b 6b 6b .....N......kkkk
>      ff ff ff ff ff ff ff ff b8 ab 48 89 00 80 ff ff.....H.....
>    backtrace (crc 8819d0f6):
>      [<ffff80008317a298>] kmemleak_alloc+0xb0/0xc4
>      [<ffff8000807e553c>] kmem_cache_alloc_node+0x288/0x3a8
>      [<ffff8000807e95f0>] __kmem_cache_create+0x1e4/0x64c
>      [<ffff8000807216bc>] kmem_cache_create_usercopy+0x1c4/0x2cc
>      [<ffff8000807217e0>] kmem_cache_create+0x1c/0x28
>      [<ffff8000819f6278>] arm_v7s_alloc_pgtable+0x1c0/0x6d4
>      [<ffff8000819f53a0>] alloc_io_pgtable_ops+0xe8/0x2d0
>      [<ffff800084b2d2c4>] arm_v7s_do_selftests+0xe0/0x73c
>      [<ffff800080016b68>] do_one_initcall+0x11c/0x7ac
>      [<ffff800084a71ddc>] kernel_init_freeable+0x53c/0xbb8
>      [<ffff8000831728d8>] kernel_init+0x24/0x144
>      [<ffff800080018e98>] ret_from_fork+0x10/0x20
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Looks good to me. And I notice the PARTIAL_NODE state of slab_state is
also useless since SLAB removed.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/slab_common.c | 8 ++++++--
>  mm/slub.c        | 6 ++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..b6b35bcdd196 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -404,8 +404,12 @@ EXPORT_SYMBOL(kmem_cache_create);
>   */
>  static void kmem_cache_release(struct kmem_cache *s)
>  {
> -	sysfs_slab_unlink(s);
> -	sysfs_slab_release(s);
> +	if (slab_state >= FULL) {
> +		sysfs_slab_unlink(s);
> +		sysfs_slab_release(s);
> +	} else {
> +		slab_kmem_cache_release(s);
> +	}
>  }
>  #else
>  static void kmem_cache_release(struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..9ba59d064b6d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6792,14 +6792,12 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  void sysfs_slab_unlink(struct kmem_cache *s)
>  {
> -	if (slab_state >= FULL)
> -		kobject_del(&s->kobj);
> +	kobject_del(&s->kobj);
>  }
>  
>  void sysfs_slab_release(struct kmem_cache *s)
>  {
> -	if (slab_state >= FULL)
> -		kobject_put(&s->kobj);
> +	kobject_put(&s->kobj);
>  }
>  
>  /*

