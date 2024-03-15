Return-Path: <linux-kernel+bounces-104326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384687CC33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C481F236B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D01B941;
	Fri, 15 Mar 2024 11:20:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A731B940
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501600; cv=none; b=GeZ1HWKBSt9fiBkQYQXSAbsdnTbM18P3gDklPkIWeF2ESMXBt5Vy9EUmYR5kJadS0VVS6m+kjQvDclPOlQuwTQ3d2H3qwcy4vF+FgAIbZ+ap4UuTQprGhviRP9lEtSbfuw7mKWKyHsMq+W46DITY0X6NJ4N6C1ty76+haZ7aa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501600; c=relaxed/simple;
	bh=aqVxIr070yJOwa6Da2y023BMYz7Eirl61hZYYAZT2Uc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GsqgF8iZarOdMABZr2UISaDeccB0qdqYhv+6YTfnunm3K5XVMK5lUKoyrDz1ts6NkGJvanhGDtb8Ftvp90JldluOUoPUm7N+OdHFKcVxIYpqw2ouNidr8KcXC3/Mt0+wCk8i7WhM52V7MOtuX9UBMVfWLu+evWc/iaJoLq3cd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tx1tT3VjvzwPFL;
	Fri, 15 Mar 2024 19:17:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BE9941400CD;
	Fri, 15 Mar 2024 19:19:33 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 19:19:33 +0800
Subject: Re: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
To: Qingfang Deng <dqfext@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240315075946.587679-1-dqfext@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
Date: Fri, 15 Mar 2024 19:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240315075946.587679-1-dqfext@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/15 15:59, Qingfang Deng Ð´µÀ:
> When testing jffs2 on a memory-constrained system, lockdep detected a
> possible circular locking dependency.
> 
> kswapd0/266 is trying to acquire lock:
> ffffff802865e508 (&f->sem){+.+.}-{3:3}, at: jffs2_do_clear_inode+0x44/0x200
> 
> but task is already holding lock:
> ffffffd010e843c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x40
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>         lock_acquire+0x6c/0x90
>         fs_reclaim_acquire+0x7c/0xa0
>         kmem_cache_alloc+0x5c/0x400
>         jffs2_alloc_inode_cache+0x18/0x20
>         jffs2_do_read_inode+0x1e0/0x310
>         jffs2_iget+0x154/0x540
>         jffs2_do_fill_super+0x214/0x3f0
>         jffs2_fill_super+0x138/0x180
>         mtd_get_sb+0xcc/0x120
>         get_tree_mtd+0x168/0x400
>         jffs2_get_tree+0x14/0x20
>         vfs_get_tree+0x48/0x130
>         path_mount+0xa64/0x12d0
>         __arm64_sys_mount+0x368/0x3e0
>         do_el0_svc+0xa0/0x140
>         el0_svc+0x1c/0x30
>         el0_sync_handler+0x9c/0x120
>         el0_sync+0x148/0x180
> 
> -> #0 (&f->sem){+.+.}-{3:3}:
>         __lock_acquire+0x18cc/0x2bb0
>         lock_acquire.part.0+0x170/0x2e0
>         lock_acquire+0x6c/0x90
>         __mutex_lock+0x10c/0xaa0
>         mutex_lock_nested+0x54/0x80
>         jffs2_do_clear_inode+0x44/0x200
>         jffs2_evict_inode+0x44/0x50
>         evict+0x120/0x290
>         dispose_list+0x88/0xd0
>         prune_icache_sb+0xa8/0xd0
>         super_cache_scan+0x1c4/0x240
>         shrink_slab.constprop.0+0x2a0/0x7f0
>         shrink_node+0x398/0x8e0
>         balance_pgdat+0x268/0x550
>         kswapd+0x154/0x7c0
>         kthread+0x1f0/0x200
>         ret_from_fork+0x10/0x20
> 
I think it's a false positive warning. Jffs2 is trying to get root inode 
in process '#1', which means that the filesystem is not mounted 
yet(Because d_make_root is after jffs2_iget(sb,1), there is no way to 
access other inodes.), so it is impossible that jffs2 inode is being 
evicted in '#0'.
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(fs_reclaim);
>                                 lock(&f->sem);
>                                 lock(fs_reclaim);
>    lock(&f->sem);
> 
>   *** DEADLOCK ***
> 
> 3 locks held by kswapd0/266:
>   #0: ffffffd010e843c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x40
>   #1: ffffffd010e62eb0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab.constprop.0+0x78/0x7f0
>   #2: ffffff80225340e0 (&type->s_umount_key#40){.+.+}-{3:3}, at: super_cache_scan+0x3c/0x240
> 
> It turns out jffs2 uses GFP_KERNEL as the memory allocation flags
> throughout the code, and commonly, inside the critical section of
> jffs2_inode_info::sem. When running low on memory, any allocation within
> the critical section may trigger a direct reclaim, which recurses back
> to jffs2_do_clear_inode().
> 
> Replace GFP_KERNEL with GFP_NOFS to avoid the recursion.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> XXX: Posting this as RFC, as I don't know if all GFP_KERNEL occurrences
> should be replaced, or if this is just a false positive.



