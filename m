Return-Path: <linux-kernel+bounces-94892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC79874662
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BAB1F24224
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30809F510;
	Thu,  7 Mar 2024 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b/Ls4LEf"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA5E56E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779981; cv=none; b=D6XAWhiaW+pUHjhg81DIh1AqPZw1c8uVwZUR9QD/Q1f9HGAEo6VYMr5EKzhKpX7/AEBzleFMkSuNVmJjHUPb5PhDdwZiPKrrgKwmImqKeOoPhOoE6pgTrD1IKgU0vsQHZjT4X9dExRKvKgyB9N1zp4SWTeSRhwZ5hyYuzceLgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779981; c=relaxed/simple;
	bh=RlGD59Zc30b6rxEWR9NL2AogExUbdV09GqsJs5mI30k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN2aEPqvuWP7SifptGoatqGsRpYMc0wv5nxcwHGsv50/PtprzeA82oO6+yRnaB1lmQVy2gqbIiBY1VzBHkKmo3Dp/ti4dC0x0jk/XXx1wmEeKDVSTNl+2mVDiv9k5ppTeRXs918pyDuBlg8rvFTqpAZMh4RQChvQZmqDSLAMFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b/Ls4LEf; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709779976; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dPMLinAyobi1hl2nRZz6LJSam7sTYWgf4JFdTQaJ6CY=;
	b=b/Ls4LEfSMn+nqTYbaU7skwizcrCsbrRFZ1nBdkwx0RK3RVnQylCuyvWE2kb+G7+LAtjRArnMJMM7JY3us2ga3a1wCc+GINOXPBkEJk6lyplO781ZuCTku4ePxW5K5peAkMBaqU+mqt1FmrT15khB+hhTgiRw1daAr4FoaeDPqs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1zDaJZ_1709779974;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1zDaJZ_1709779974)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 10:52:56 +0800
Message-ID: <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
Date: Thu, 7 Mar 2024 10:52:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 chengzhihao1@huawei.com
References: <20240307024459.883044-1-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240307024459.883044-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baokun,

On 2024/3/7 10:44, Baokun Li wrote:
> Lockdep reported the following issue when mounting erofs with a domain_id:
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-rc7-xfstests #521 Not tainted
> --------------------------------------------
> mount/396 is trying to acquire lock:
> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> but task is already holding lock:
> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 						at: alloc_super+0xe3/0x3d0
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&type->s_umount_key#50/1);
>    lock(&type->s_umount_key#50/1);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 2 locks held by mount/396:
>   #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
> 			at: alloc_super+0xe3/0x3d0
>   #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
> 			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
> 
> stack backtrace:
> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x64/0xb0
>   validate_chain+0x5c4/0xa00
>   __lock_acquire+0x6a9/0xd50
>   lock_acquire+0xcd/0x2b0
>   down_write_nested+0x45/0xd0
>   alloc_super+0xe3/0x3d0
>   sget_fc+0x62/0x2f0
>   vfs_get_super+0x21/0x90
>   vfs_get_tree+0x2c/0xf0
>   fc_mount+0x12/0x40
>   vfs_kern_mount.part.0+0x75/0x90
>   kern_mount+0x24/0x40
>   erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>   erofs_fc_fill_super+0x213/0x380 [erofs]
> 
> This is because the file_system_type of both erofs and the pseudo-mount
> point of domain_id is erofs_fs_type, so two successive calls to
> alloc_super() are considered to be using the same lock and trigger the
> warning above.
> 
> Therefore add a nodev file_system_type named erofs_anon_fs_type to
> silence this complaint. In addition, to reduce code coupling, refactor
> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
> and move the erofs_pseudo_mnt related code to fscache.c.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

IMHO, in the beginning, I'd like to avoid introducing another fs type
for erofs to share (meta)data between filesystems since it will cause
churn, could we use some alternative way to resolve this?

Or Jingbo might have some other ideas?

Thanks,
Gao Xiang

