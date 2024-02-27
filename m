Return-Path: <linux-kernel+bounces-82829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7D868A33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D471F22275
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C355E5E;
	Tue, 27 Feb 2024 07:51:52 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907A52F92;
	Tue, 27 Feb 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020312; cv=none; b=BXmDxCV9bdlEaCfh+WRSw5AW0slddfXdVtchcQ2L3y9M1xJKO+lnfoNIpmSI8ElGtwk/ZBJuUNLw3acQg71DOGMWZ57EZ/ZYhpnyuaPJcNKPtGWiCqVcmj+bJhKV9Yw4FUcjGTAuS/Rie5EsKe3FJx5HhL8iv3MDBVzCF+SDt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020312; c=relaxed/simple;
	bh=TFqOwc2aOQP4CIgMGbjw84ou/9XfyykH27j7p3Ed0r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aLHfmgjQ7H+T98xk+6DLYRSuq89iARjQzo6zea5gRmeWERubGK6yeR50hzFy0qMuR8PV3M+emYhCKifh0R42j5NMH0EhUQNkhb+DlQG4SD5WBaSG2/hl5ujXu1nxo5k3CX/rIrbXecyMMbZkEX2ZmNY8WENd37QjAF/+dkGI70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkV4W6FSlz1h0B8;
	Tue, 27 Feb 2024 15:49:31 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id B24E71400F4;
	Tue, 27 Feb 2024 15:51:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:51:45 +0800
Message-ID: <d957454e-6516-f7e5-57fb-63f4687325ed@huawei.com>
Date: Tue, 27 Feb 2024 15:51:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix uninitialized ratelimit_state->lock access in
 __ext4_fill_super()
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <20240102133730.1098120-1-libaokun1@huawei.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240102133730.1098120-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

A gentle ping.

On 2024/1/2 21:37, Baokun Li wrote:
> In the following concurrency we will access the uninitialized rs->lock:
>
> ext4_fill_super
>    ext4_register_sysfs
>     // sysfs registered msg_ratelimit_interval_ms
>                               // Other processes modify rs->interval to
>                               // non-zero via msg_ratelimit_interval_ms
>    ext4_orphan_cleanup
>      ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
>        __ext4_msg
>          ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
>            if (!rs->interval)  // do nothing if interval is 0
>              return 1;
>            raw_spin_trylock_irqsave(&rs->lock, flags)
>              raw_spin_trylock(lock)
>                _raw_spin_trylock
>                  __raw_spin_trylock
>                    spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
>                      lock_acquire
>                        __lock_acquire
>                          register_lock_class
>                            assign_lock_key
>                              dump_stack();
>    ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
>      raw_spin_lock_init(&rs->lock);
>      // init rs->lock here
>
> and get the following dump_stack:
>
> =========================================================
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
> [...]
> Call Trace:
>   dump_stack_lvl+0xc5/0x170
>   dump_stack+0x18/0x30
>   register_lock_class+0x740/0x7c0
>   __lock_acquire+0x69/0x13a0
>   lock_acquire+0x120/0x450
>   _raw_spin_trylock+0x98/0xd0
>   ___ratelimit+0xf6/0x220
>   __ext4_msg+0x7f/0x160 [ext4]
>   ext4_orphan_cleanup+0x665/0x740 [ext4]
>   __ext4_fill_super+0x21ea/0x2b10 [ext4]
>   ext4_fill_super+0x14d/0x360 [ext4]
> [...]
> =========================================================
>
> Normally interval is 0 until s_msg_ratelimit_state is initialized, so
> ___ratelimit() does nothing. But registering sysfs precedes initializing
> rs->lock, so it is possible to change rs->interval to a non-zero value
> via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
> uninitialized, and then a call to ext4_msg triggers the problem by
> accessing an uninitialized rs->lock. Therefore register sysfs after all
> initializations are complete to avoid such problems.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/super.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0980845c8b8f..1db23b0e8a4f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5564,19 +5564,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   	if (err)
>   		goto failed_mount6;
>   
> -	err = ext4_register_sysfs(sb);
> -	if (err)
> -		goto failed_mount7;
> -
>   	err = ext4_init_orphan_info(sb);
>   	if (err)
> -		goto failed_mount8;
> +		goto failed_mount7;
>   #ifdef CONFIG_QUOTA
>   	/* Enable quota usage during mount. */
>   	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
>   		err = ext4_enable_quotas(sb);
>   		if (err)
> -			goto failed_mount9;
> +			goto failed_mount8;
>   	}
>   #endif  /* CONFIG_QUOTA */
>   
> @@ -5602,7 +5598,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   		ext4_msg(sb, KERN_INFO, "recovery complete");
>   		err = ext4_mark_recovery_complete(sb, es);
>   		if (err)
> -			goto failed_mount10;
> +			goto failed_mount9;
>   	}
>   
>   	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> @@ -5619,15 +5615,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   	atomic_set(&sbi->s_warning_count, 0);
>   	atomic_set(&sbi->s_msg_count, 0);
>   
> +	/* Register sysfs after all initializations are complete. */
> +	err = ext4_register_sysfs(sb);
> +	if (err)
> +		goto failed_mount9;
> +
>   	return 0;
>   
> -failed_mount10:
> +failed_mount9:
>   	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
> -failed_mount9: __maybe_unused
> +failed_mount8: __maybe_unused
>   	ext4_release_orphan_info(sb);
> -failed_mount8:
> -	ext4_unregister_sysfs(sb);
> -	kobject_put(&sbi->s_kobj);
>   failed_mount7:
>   	ext4_unregister_li_request(sb);
>   failed_mount6:



