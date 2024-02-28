Return-Path: <linux-kernel+bounces-84995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8C86AEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8B41F23EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F603612C;
	Wed, 28 Feb 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvKCjvqB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF91F608
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122072; cv=none; b=kYT6AobBH72DMMuSam7eEWEj2dCbx63CwNvAEVlr7C2dvdOEA8TiZ1VcQKYS6qc2XoaypeE5uWPtr1cKa3MA3z71pI5KveI68FeBTZomMJvE7Kd79ghc7mD1bqRj7B531vHfFNjRvwaC4k/D66PsbzuaoKT5oWDnETZukbacpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122072; c=relaxed/simple;
	bh=hHm/I4P+cHnU34VH12YhigWDqOadRt/vfK79+wBcH7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4t/Vp6YZCEU5+vrgdk9enM2JFdj5h9eKGLJqHlKpmSMpnCHxzixzsnR1mnVHpbuaC+tAj6/UqaV1cEqVxXgV0t7CKcocuvChEhQzDL3sxvZH6RT26jyv0CjqcGUh5S0xEAA83S35veBGO5SgT4ffkAJgqbsS2C102Qr/oRQg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvKCjvqB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709122069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfh31fq56Jds7QolJswbvo93Q4xLp5Ucmf6Kos63TTA=;
	b=GvKCjvqB5TmRlhkrEZ2/b3W1O/3LQxuZ1rGrjN292MlcZ41I7JWCL8fAzwtTdvjEBHFMNl
	WGoAN0FY0P8FVKWyOj308P8BR/453zuvlhVn8yogDyX6TCG+rO8BBWA4Y7XEFCe/F+VMuA
	x2yAslnc4gMY7BRq2mE6AolxD4HK/ZM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-bXlkNtgJNhyPcObi-UetbA-1; Wed, 28 Feb 2024 07:07:48 -0500
X-MC-Unique: bXlkNtgJNhyPcObi-UetbA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dbcf647a9dso8556015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122061; x=1709726861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hfh31fq56Jds7QolJswbvo93Q4xLp5Ucmf6Kos63TTA=;
        b=s2VuUNMeSHzUC+06r3ZvAadn9V/TITkzAcV9E/8ULkY7wy58OExOxspVlZOg1KAGEW
         n5fq1uVA6mp5EcC5Z2YaPLtMI0cmNM1vaTS1YL8fbYu0PcOrVfBR7DJYVWh1zOZir7dJ
         yGERP+3mjN4k8kCs7ltWpx/V4d6UWuZ3FmKo98d2OWuXPSoa/P8JG0f0WckEWWRHUusS
         KQDrYTTXa+3KZmf2f5HSFrvmRtAFgns1Qvzemvxb5U07N4r0NTMHVTqP6vlfu2K6ymLR
         PoSnxqboKCIPs5wlNqcCrcW2mqAbNmvVoouzxzuBU8rW9ICRux5xwmA0hJ9m8yirvWgT
         SHwQ==
X-Gm-Message-State: AOJu0Yy4ULzybzgvsNRVJqkuEx+Eq/gTBvLDxibu17iFz+SXpr0M+8jo
	NBjPAJ1AN05gGIkjOpdx+n7uZRbDUZqBEzxgnD1NIU5Xj4LoYNjVxANwaF88fZ9IgLncBcU6jnX
	2dXXlf4kWBY0hU1bKEA3PmlUJXNPtF1NCFA8xAbrfa9DXAirAIS7JmInnsoNl0A==
X-Received: by 2002:a17:902:eccc:b0:1dc:b008:f678 with SMTP id a12-20020a170902eccc00b001dcb008f678mr3106660plh.18.1709122061077;
        Wed, 28 Feb 2024 04:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOb5p6CJ7/VGdWKlNQI/6VTgRkL8MOLpLKfbU5r9Mza3kNigm/oN7pThv8sNGkTHKADWR/pg==
X-Received: by 2002:a17:902:eccc:b0:1dc:b008:f678 with SMTP id a12-20020a170902eccc00b001dcb008f678mr3106618plh.18.1709122060551;
        Wed, 28 Feb 2024 04:07:40 -0800 (PST)
Received: from [10.72.120.8] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ko5-20020a17090307c500b001d9bd8fa492sm3142858plb.211.2024.02.28.04.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 04:07:40 -0800 (PST)
Message-ID: <d233fc29-e3ab-4761-9368-c203efc0466e@redhat.com>
Date: Wed, 28 Feb 2024 20:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/14] md: don't register sync_thread for reshape
 directly
To: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com,
 heinzm@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org,
 yukuai3@huawei.com, neilb@suse.de, shli@fb.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-5-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
In-Reply-To: <20240201092559.910982-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/1 下午5:25, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, if reshape is interrupted, then reassemble the array will
> register sync_thread directly from pers->run(), in this case
> 'MD_RECOVERY_RUNNING' is set directly, however, there is no guarantee
> that md_do_sync() will be executed, hence stop_sync_thread() will hang
> because 'MD_RECOVERY_RUNNING' can't be cleared.


Hi Kuai

I have a question here. Is it the reason sync_thread can't run 
md_do_sync because kthread_should_stop, so it doesn't have the chance to 
set MD_RECOVERY_DONE? Why creating sync thread in md_check_recovery 
doesn't have this problem? Could you explain more about this?

Best Regards

Xiao

>
> Last patch make sure that md_do_sync() will set MD_RECOVERY_DONE,
> however, following hang can still be triggered by dm-raid test
> shell/lvconvert-raid-reshape.sh occasionally:
>
> [root@fedora ~]# cat /proc/1982/stack
> [<0>] stop_sync_thread+0x1ab/0x270 [md_mod]
> [<0>] md_frozen_sync_thread+0x5c/0xa0 [md_mod]
> [<0>] raid_presuspend+0x1e/0x70 [dm_raid]
> [<0>] dm_table_presuspend_targets+0x40/0xb0 [dm_mod]
> [<0>] __dm_destroy+0x2a5/0x310 [dm_mod]
> [<0>] dm_destroy+0x16/0x30 [dm_mod]
> [<0>] dev_remove+0x165/0x290 [dm_mod]
> [<0>] ctl_ioctl+0x4bb/0x7b0 [dm_mod]
> [<0>] dm_ctl_ioctl+0x11/0x20 [dm_mod]
> [<0>] vfs_ioctl+0x21/0x60
> [<0>] __x64_sys_ioctl+0xb9/0xe0
> [<0>] do_syscall_64+0xc6/0x230
> [<0>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
>
> Meanwhile mddev->recovery is:
> MD_RECOVERY_RUNNING |
> MD_RECOVERY_INTR |
> MD_RECOVERY_RESHAPE |
> MD_RECOVERY_FROZEN
>
> Fix this problem by remove the code to register sync_thread directly
> from raid10 and raid5. And let md_check_recovery() to register
> sync_thread.
>
> Fixes: f67055780caa ("[PATCH] md: Checkpoint and allow restart of raid5 reshape")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c     |  5 ++++-
>   drivers/md/raid10.c | 16 ++--------------
>   drivers/md/raid5.c  | 29 ++---------------------------
>   3 files changed, 8 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c65dfd156090..6c5d0a372927 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9372,6 +9372,7 @@ static void md_start_sync(struct work_struct *ws)
>   	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
>   	int spares = 0;
>   	bool suspend = false;
> +	char *name;
>   
>   	if (md_spares_need_change(mddev))
>   		suspend = true;
> @@ -9404,8 +9405,10 @@ static void md_start_sync(struct work_struct *ws)
>   	if (spares)
>   		md_bitmap_write_all(mddev->bitmap);
>   
> +	name = test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) ?
> +			"reshape" : "resync";
>   	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "resync"));
> +			   md_register_thread(md_do_sync, mddev, name));
>   	if (!mddev->sync_thread) {
>   		pr_warn("%s: could not start resync thread...\n",
>   			mdname(mddev));
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 7412066ea22c..a5f8419e2df1 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4175,11 +4175,7 @@ static int raid10_run(struct mddev *mddev)
>   		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>   		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -		rcu_assign_pointer(mddev->sync_thread,
> -			md_register_thread(md_do_sync, mddev, "reshape"));
> -		if (!mddev->sync_thread)
> -			goto out_free_conf;
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   
>   	return 0;
> @@ -4573,16 +4569,8 @@ static int raid10_start_reshape(struct mddev *mddev)
>   	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -
> -	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "reshape"));
> -	if (!mddev->sync_thread) {
> -		ret = -EAGAIN;
> -		goto abort;
> -	}
> +	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_wakeup_thread(mddev->sync_thread);
>   	md_new_event();
>   	return 0;
>   
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..6a7a32f7fb91 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7936,11 +7936,7 @@ static int raid5_run(struct mddev *mddev)
>   		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>   		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -		rcu_assign_pointer(mddev->sync_thread,
> -			md_register_thread(md_do_sync, mddev, "reshape"));
> -		if (!mddev->sync_thread)
> -			goto abort;
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	}
>   
>   	/* Ok, everything is just fine now */
> @@ -8506,29 +8502,8 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>   	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>   	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -	rcu_assign_pointer(mddev->sync_thread,
> -			   md_register_thread(md_do_sync, mddev, "reshape"));
> -	if (!mddev->sync_thread) {
> -		mddev->recovery = 0;
> -		spin_lock_irq(&conf->device_lock);
> -		write_seqcount_begin(&conf->gen_lock);
> -		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
> -		mddev->new_chunk_sectors =
> -			conf->chunk_sectors = conf->prev_chunk_sectors;
> -		mddev->new_layout = conf->algorithm = conf->prev_algo;
> -		rdev_for_each(rdev, mddev)
> -			rdev->new_data_offset = rdev->data_offset;
> -		smp_wmb();
> -		conf->generation --;
> -		conf->reshape_progress = MaxSector;
> -		mddev->reshape_position = MaxSector;
> -		write_seqcount_end(&conf->gen_lock);
> -		spin_unlock_irq(&conf->device_lock);
> -		return -EAGAIN;
> -	}
> +	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>   	conf->reshape_checkpoint = jiffies;
> -	md_wakeup_thread(mddev->sync_thread);
>   	md_new_event();
>   	return 0;
>   }


