Return-Path: <linux-kernel+bounces-95717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41728751AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ED4B28DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8792112DD9F;
	Thu,  7 Mar 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ys1ocksK"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C712D760
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821132; cv=none; b=FSRQN9YSTXnj5rkurgT9hevzwtia7l6F7THlfUWDv4VjRF1DnuK+q+scNhiUwhk3dqoX0iw19QtDHmdd8jPOh/qZ1IKk1L3IuxYU3KQ7N+s99avH7YmqKdMu/QoEcwBYlCdPsbmdTYx7beTMVp+a4eTxrhk+urjFyT8OzZcKj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821132; c=relaxed/simple;
	bh=4s9GucHXufG/nCQ8eR0wFkr2F1XCrbV+EKzCFQTECf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huuzXOHZfMigfvhOS/Bp3e1mpgcb/d/hGVyFjOPJCKZap/ML43vOHJm0Igs1f4a2plVn4SW+RXJqvuGpS01wfDFdkp2CV7RLWmayLnJMq2TghInEkipucnAHiQ+lONPx4RFgjNZ0MTJ4/FsX3jzIuFVCk3fnsdU0r++IGcPwGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ys1ocksK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709821121; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=npQu2INO/FdrwYje2DMJLJdc7DyZiThgqLfsw/glcu8=;
	b=Ys1ocksK5MEvzTX0Q5KeCp3cHbA0DdNEtxbp9aVZVfw2fnS3zfgRIY48dK+TdsNZLP5vQsB4ZapjwyFDhjPJJ253+bCJrJRz1Pc5HgrgdZRGw7DkGtvJDbnraFH4gAMcjrp9StG276h4xlQMW7QoimnykiEbB4sQC6cLQEmxolY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W2-lSin_1709821117;
Received: from 30.25.211.60(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2-lSin_1709821117)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 22:18:40 +0800
Message-ID: <60c18887-db8a-42a8-8a04-ef9d17263b15@linux.alibaba.com>
Date: Thu, 7 Mar 2024 22:18:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, chengzhihao1@huawei.com
References: <20240307101018.2021925-1-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240307101018.2021925-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/7 18:10, Baokun Li wrote:
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
> Therefore add a nodev file_system_type called erofs_anon_fs_type in
> fscache.c to silence this complaint. Because kern_mount() takes a
> pointer to struct file_system_type, not its (string) name. So we don't
> need to call register_filesystem(). In addition, call init_pseudo() in
> erofs_anon_init_fs_context() as suggested by Al Viro, so that we can
> remove erofs_fc_fill_pseudo_super(), erofs_fc_anon_get_tree(), and
> erofs_anon_context_ops.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I will add

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>

when applying..

Also since it's a false positive and too close to the
final so let's keep this patch in -next for a while and
then aim for v6.9-rc1 instead.

Thanks,
Gao Xiang

