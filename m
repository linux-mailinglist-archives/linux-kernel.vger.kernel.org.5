Return-Path: <linux-kernel+bounces-150948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5D8AA70F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E79B225B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A76110;
	Fri, 19 Apr 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp7dKfZO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E310E3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713495004; cv=none; b=o3kCDOpjHTGDjEByBMvfEeKntYU27hIsytOnLFZ4cuABVGo7HZfdrOYuleHW7U6DJb7clK3j5EdYgfMxFYxZYMWsjZFXgrPEiKLetmJ4sINTYrGA3k9h5ZDF1m/HXufV4qCXTWRsThxEQP3Jq2F3MqOZwJlUdigBqNHUng5C8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713495004; c=relaxed/simple;
	bh=TW92Di9/k1NMxTp1kvBtWHNPsYWEu5/Uotbx6yUZ8/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9F9EWeXRyxbdQ7t7X/cS93D3wH4XsCBLy+phSxBBdkMlQrXSaqqOS4MwZQoQrEmYUU0LhCbYM/8asHPc5pbFqCfctpEx9Z81Vp7vWWD2D6aPi41TMBflqokIr+1sRoHvEzeyShp1JJR1m87d7Qhbfxv6cR9W9owROIR0RkUZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp7dKfZO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713495000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1Tjr14BdvOl8V5MxjQ4hi2dx9l67KXMdwhIGgoSO6c=;
	b=Tp7dKfZO0cLMsp80l1FWnA2HbcxMoelR3q5AOgzsGa81oUCggk7YuzkE+EFbqn/yLNUfYy
	DQVRCmB/URCUW2BBYJ4wddd5hq6pIjW6wXc1MThvIeHh4wtYjmF6r3alrVeBsl5Jhdt3vG
	65e8v2QljNV/I7aeUPrONloxJm8oweQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-MeIdoHDJMO-47bz9JmLVug-1; Thu, 18 Apr 2024 22:49:58 -0400
X-MC-Unique: MeIdoHDJMO-47bz9JmLVug-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e438f8dd99so21128645ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713494997; x=1714099797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Tjr14BdvOl8V5MxjQ4hi2dx9l67KXMdwhIGgoSO6c=;
        b=LetSUsOe/L1eX9YIjI4GJNXlkkvpRaaWHS2vWDMPl459aKgAArd9DfV2g0gSrpj+2s
         2aATo6KM8ySj8sKLmjuhgZZYqY3gMMutc9fKVLBmBvvnrgWbXXGzLz/M0H5Xfmg7OPVf
         B0rLMKCbnhfnP5UGa9HX2IPgzlp7iXgK4aE3w9rMZLerFuylMYECfOebXUVDX4cjV/po
         pCuCJoEVn31l0Dqb/S7fS6T4bIKa9G+vY32ZU6LnOs+/xPCMglQtJ/zFOK7PpYTq37TP
         uH0Z7/PgOq5Yt9+j2n+gDXTldX7pjm25RnySGr+O9dBSSzdpoEiH2W2LDrMcOMchJjqy
         VqNA==
X-Forwarded-Encrypted: i=1; AJvYcCV+tOIPif5xEZXrHwasIXJEzkbuzaReSS679MKTw1pXRLod94YjD3f7ydjZ68At76ZDwPUHgqjeIsbbebuXwscd9GSgO7O+diYrXA0O
X-Gm-Message-State: AOJu0Yw3BqgqV2JYLH6YBNA7EYX0+tROFz+06TueKxOTc5anXXGmUrdf
	ydCnmledbua34J+Nmo43QjPRHiH+PfK56XU0tbf9Bn6cOK0W7i+Y47GMOGxJBJP1utcUWf3WTi/
	RNW7lYIaqGMFOvmOE29ScObblPHG3AtFVq2Ah585vwLZaetA2DjE9EJdXhB0qsw==
X-Received: by 2002:a17:903:244b:b0:1e5:5041:b18a with SMTP id l11-20020a170903244b00b001e55041b18amr1069297pls.40.1713494997557;
        Thu, 18 Apr 2024 19:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2MpyW3nsb4sdD6Wu3AhWxU/RviU5a4SetHiZbGtRYzusJJGxDUdOk4GAVJ6rp1G+MZ5LL1g==
X-Received: by 2002:a17:903:244b:b0:1e5:5041:b18a with SMTP id l11-20020a170903244b00b001e55041b18amr1069285pls.40.1713494997171;
        Thu, 18 Apr 2024 19:49:57 -0700 (PDT)
Received: from [10.72.116.35] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001e668c1060bsm2239799plh.122.2024.04.18.19.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 19:49:56 -0700 (PDT)
Message-ID: <54b997a0-a04b-44a0-9d40-205267f949c2@redhat.com>
Date: Fri, 19 Apr 2024 10:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stackdepot: respect __GFP_NOLOCKDEP allocation flag
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>,
 kasan-dev@googlegroups.com, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
 <20240418141133.22950-1-ryabinin.a.a@gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240418141133.22950-1-ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Andrey,

I will test it soon.

- Xiubo

On 4/18/24 22:11, Andrey Ryabinin wrote:
> If stack_depot_save_flags() allocates memory it always drops
> __GFP_NOLOCKDEP flag. So when KASAN tries to track __GFP_NOLOCKDEP
> allocation we may end up with lockdep splat like bellow:
>
> ======================================================
>   WARNING: possible circular locking dependency detected
>   6.9.0-rc3+ #49 Not tainted
>   ------------------------------------------------------
>   kswapd0/149 is trying to acquire lock:
>   ffff88811346a920
> (&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_reclaim_inode+0x3ac/0x590
> [xfs]
>
>   but task is already holding lock:
>   ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0x5d9/0xad0
>
>   which lock already depends on the new lock.
>
>   the existing dependency chain (in reverse order) is:
>   -> #1 (fs_reclaim){+.+.}-{0:0}:
>          __lock_acquire+0x7da/0x1030
>          lock_acquire+0x15d/0x400
>          fs_reclaim_acquire+0xb5/0x100
>   prepare_alloc_pages.constprop.0+0xc5/0x230
>          __alloc_pages+0x12a/0x3f0
>          alloc_pages_mpol+0x175/0x340
>          stack_depot_save_flags+0x4c5/0x510
>          kasan_save_stack+0x30/0x40
>          kasan_save_track+0x10/0x30
>          __kasan_slab_alloc+0x83/0x90
>          kmem_cache_alloc+0x15e/0x4a0
>          __alloc_object+0x35/0x370
>          __create_object+0x22/0x90
>   __kmalloc_node_track_caller+0x477/0x5b0
>          krealloc+0x5f/0x110
>          xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
>          xfs_iext_insert+0x2e/0x130 [xfs]
>          xfs_iread_bmbt_block+0x1a9/0x4d0 [xfs]
>          xfs_btree_visit_block+0xfb/0x290 [xfs]
>          xfs_btree_visit_blocks+0x215/0x2c0 [xfs]
>          xfs_iread_extents+0x1a2/0x2e0 [xfs]
>   xfs_buffered_write_iomap_begin+0x376/0x10a0 [xfs]
>          iomap_iter+0x1d1/0x2d0
>   iomap_file_buffered_write+0x120/0x1a0
>          xfs_file_buffered_write+0x128/0x4b0 [xfs]
>          vfs_write+0x675/0x890
>          ksys_write+0xc3/0x160
>          do_syscall_64+0x94/0x170
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>
> Always preserve __GFP_NOLOCKDEP to fix this.
>
> Fixes: cd11016e5f52 ("mm, kasan: stackdepot implementation. Enable stackdepot for SLAB")
> Reported-by: Xiubo Li <xiubli@redhat.com>
> Closes: https://lore.kernel.org/all/a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com/
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Closes: https://lore.kernel.org/all/f9ff999a-e170-b66b-7caf-293f2b147ac2@opensource.wdc.com/
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> ---
>   lib/stackdepot.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 68c97387aa54..cd8f23455285 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -627,10 +627,10 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>   		/*
>   		 * Zero out zone modifiers, as we don't have specific zone
>   		 * requirements. Keep the flags related to allocation in atomic
> -		 * contexts and I/O.
> +		 * contexts, I/O, nolockdep.
>   		 */
>   		alloc_flags &= ~GFP_ZONEMASK;
> -		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
> +		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL | __GFP_NOLOCKDEP);
>   		alloc_flags |= __GFP_NOWARN;
>   		page = alloc_pages(alloc_flags, DEPOT_POOL_ORDER);
>   		if (page)


