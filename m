Return-Path: <linux-kernel+bounces-43915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5C841AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BDC1C23F03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCED376F2;
	Tue, 30 Jan 2024 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B9joya6E"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9412376F6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586645; cv=none; b=Yiu4hRNSfg5Ss7zkH42yFnrHTUkzm6dm/kF+pHFPheEPX4HW92cBzF5CinRox22N473qJL1sREyxK4NM6z2oCWfUaiJXt8lr9tCmxkpD/hvujYKy6fTxpi8n7f+azKLbrdSFe+gkvI5jZsoqC9F4pnDnh44tGPpTdbItjVdPW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586645; c=relaxed/simple;
	bh=LsbCOdr3i3WGimdnP7Kyx3gh1Ae+29/6ZCJr5VU/mlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXar1lRRKmTN4/9uaype2ZGlcifCXngkgCf19Qf/0d13QvkzrFVU9yqO7ryYmHXL4SC9VhGqpX8/nXEaBvdA5hwvIqNiz6/AFA+tE3CERZIj/JKy+MtktHGFWEamEFbaUwxkI+gSdmR8Ahy03KTlaeFIpe0gH4CFefySdkn102c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B9joya6E; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da9c834646so2696954b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706586643; x=1707191443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJ2f0pCFiDt+0//3KGocDBcR7ld42/5luGa3g6y5MNk=;
        b=B9joya6EG1JiRpE9Tfz6i4S4R4Z29RavpTtTC6Akpob09sdSZIC7GuAvxgh65A2Rqn
         3bujMTDGS4dCfeK7oZVLOapQUbhfzRiPhdjX8lrhSRgZ2pPTLNUOCT0dkraUsqJ4F89z
         4jAHrhrIasfme41r9Fl6AYmubJ9bdR+oDQ/EK7CeFWLVy13IcAy2/VRgwi5Mya7AbStg
         OaoK5w/XN0LjyOxsTYfXSB8X1ASaQlUYwavPEz/W0nPKiXmm4J84LLfUx0fQuOof2Duv
         7lgHLPPGK9a4TIHH0woI+MBsAKwd7NMXgBdz5eIPN6oYpL4gb5/1by0yhT0yeYD+mwfu
         Z1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586643; x=1707191443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ2f0pCFiDt+0//3KGocDBcR7ld42/5luGa3g6y5MNk=;
        b=XHY003ATAjVi4r/ruzZynwGvsBlQpx+VppLGUP8QJO6ZkTueknWEFhngo7bie6Z2fS
         nhDJKMkC+/dJQac8PCkLAHKAAKr5spWViryQ4t+FHXno1KaZ2mcSa/bC8P4OULs7uUyN
         GVd0TXFiT0PNSEyclqrh9BqvuQmdHpMxe9yu7r7zpTX7fgrP73cqX8Ur5vXs9EtkB+Kn
         F8j21lbzxY+VoYtEFJ8xlC8CeC9iFN2VK7xCuG53OEk5Q/5TTTLt70YUlSU35qXkahQG
         qxwOORj8DH5naNqtp9rKI9rU5tmK8SKFu7g6sD0V9qoyEr3Lscjlmxc8r5Np8fpMjvBD
         fyGQ==
X-Gm-Message-State: AOJu0YyeNX2iPd+T3qGhyjMUGzCza/Al26SUHs+6QKOeR5i7vki9O2jz
	m8GzvcFl+3Hus30U143frerU4g0rSl396HPGqv1qqH/oN5zJL/ctB/HNcvqa1ERP4bTwbnnSP51
	M
X-Google-Smtp-Source: AGHT+IHjKJHaEGyCRFlWeZ2gO0sRyYBcHtiZlegxw3A2Trji9IdvmGfHUSGZ2nqA97IYlY+RdddqAg==
X-Received: by 2002:a05:6a00:1d92:b0:6de:448b:1196 with SMTP id z18-20020a056a001d9200b006de448b1196mr461150pfw.16.1706586642902;
        Mon, 29 Jan 2024 19:50:42 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id ka7-20020a056a00938700b006d9a38fe569sm6581702pfb.89.2024.01.29.19.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:50:42 -0800 (PST)
Message-ID: <4881a71a-2d40-44b7-ad13-0cf7ab62b463@bytedance.com>
Date: Tue, 30 Jan 2024 11:50:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slub: remove parameter 'flags' in
 create_kmalloc_caches()
Content-Language: en-US
To: Zheng Yejian <zhengyejian1@huawei.com>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014107.1262373-1-zhengyejian1@huawei.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014107.1262373-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:41, Zheng Yejian wrote:
> After commit 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"),
> parameter 'flags' is only passed as 0 in create_kmalloc_caches(), and
> then it is only passed to new_kmalloc_cache().
> 
> So we can change parameter 'flags' to be a local variable with
> initial value 0 in new_kmalloc_cache() and remove parameter 'flags'
> in create_kmalloc_caches(). Also make new_kmalloc_cache() static
> due to it is only used in mm/slab_common.c.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> ---
>  mm/slab.h        |  4 +---
>  mm/slab_common.c | 13 +++++++------
>  mm/slub.c        |  2 +-
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 54deeb0428c6..09c673346ece 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -387,7 +387,7 @@ extern const struct kmalloc_info_struct {
>  
>  /* Kmalloc array related functions */
>  void setup_kmalloc_cache_index_table(void);
> -void create_kmalloc_caches(slab_flags_t);
> +void create_kmalloc_caches(void);
>  
>  extern u8 kmalloc_size_index[24];
>  
> @@ -422,8 +422,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
>  int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
>  
>  void __init kmem_cache_init(void);
> -void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
> -			      slab_flags_t flags);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,
>  			unsigned int size, slab_flags_t flags,
>  			unsigned int useroffset, unsigned int usersize);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..61530df8b35b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -853,9 +853,10 @@ static unsigned int __kmalloc_minalign(void)
>  	return max(minalign, arch_slab_minalign());
>  }
>  
> -void __init
> -new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> +static void __init
> +new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
>  {
> +	slab_flags_t flags = 0;
>  	unsigned int minalign = __kmalloc_minalign();
>  	unsigned int aligned_size = kmalloc_info[idx].size;
>  	int aligned_idx = idx;
> @@ -902,7 +903,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>   * may already have been created because they were needed to
>   * enable allocations for slab creation.
>   */
> -void __init create_kmalloc_caches(slab_flags_t flags)
> +void __init create_kmalloc_caches(void)
>  {
>  	int i;
>  	enum kmalloc_cache_type type;
> @@ -913,7 +914,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	for (type = KMALLOC_NORMAL; type < NR_KMALLOC_TYPES; type++) {
>  		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
>  			if (!kmalloc_caches[type][i])
> -				new_kmalloc_cache(i, type, flags);
> +				new_kmalloc_cache(i, type);
>  
>  			/*
>  			 * Caches that are not of the two-to-the-power-of size.
> @@ -922,10 +923,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  			 */
>  			if (KMALLOC_MIN_SIZE <= 32 && i == 6 &&
>  					!kmalloc_caches[type][1])
> -				new_kmalloc_cache(1, type, flags);
> +				new_kmalloc_cache(1, type);
>  			if (KMALLOC_MIN_SIZE <= 64 && i == 7 &&
>  					!kmalloc_caches[type][2])
> -				new_kmalloc_cache(2, type, flags);
> +				new_kmalloc_cache(2, type);
>  		}
>  	}
>  #ifdef CONFIG_RANDOM_KMALLOC_CACHES
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..4f912f5ec11c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5663,7 +5663,7 @@ void __init kmem_cache_init(void)
>  
>  	/* Now we can use the kmem_cache to allocate kmalloc slabs */
>  	setup_kmalloc_cache_index_table();
> -	create_kmalloc_caches(0);
> +	create_kmalloc_caches();
>  
>  	/* Setup random freelists for each cache */
>  	init_freelist_randomization();


