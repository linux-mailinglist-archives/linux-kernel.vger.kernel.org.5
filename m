Return-Path: <linux-kernel+bounces-149477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BE8A919B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFED128351A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0FA52F95;
	Thu, 18 Apr 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0QvZMMp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50938DDB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411578; cv=none; b=ZlxGWeO/L2E5QovBtDg/BHBdwQ3esReBHBRbEqLcB7uCVWYj3HC2F2RPWxEjUpOu6yF1hpabPymYh9njbyhtlkOyRIkFJHr76nF9QXwYVskGzoPdPwLdgZBWKY/f+vaGG0VUQplXMgsltpyyMHbv6FqYRgkIAow2TnPCcwRDdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411578; c=relaxed/simple;
	bh=piea0czvwRLMX1SrsTwMAGMc6jxAm4WwePHNzMU+CMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y9gz9O7XutSV8OiS1ZUa/4oONCrcdIYDs4T5VACIUux0B6wsV54PT/7SNcfet2ZvD672v7JALXT6Jz0CNa2Y/QZr3w401f8WSPkCNJGuOxgsOoSb8NW/hF1nLNAHr3ShE+Ck5iMj1p3dJiOuZzDhOsjBr23rt29TAv0Zz8eP4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0QvZMMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713411574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Qxw5tE7yCHsoiEQRtHKEa2tHC9BRJgm/bxApwKIHxI=;
	b=h0QvZMMpLZCS8FGjpbWgZnQsAUy13GnDwWkgO+yubaV4+k0UvEllDQXuSv5Y0+w1nSClT9
	pmjllmJT0Q5Rp72zYCHCI8L+vJkN0tmNs9S1aLIGAIb9vW91CX9VhostjJbl1jLeLnl1To
	8e8+xQsBDD+gBrTFunVlKvDQvOuEHpQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-o2K42LTCPDmKYJ0WcvSfzw-1; Wed, 17 Apr 2024 23:39:33 -0400
X-MC-Unique: o2K42LTCPDmKYJ0WcvSfzw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6efefc57621so387967b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411572; x=1714016372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Qxw5tE7yCHsoiEQRtHKEa2tHC9BRJgm/bxApwKIHxI=;
        b=DM4Kpb5Lou2LV3c1yh0Zr8tkTRG2vdZzJbG5OWQ94sJqIdAivMhcdBfpqZQ7Jno6RP
         XyO8+Epg8lOayZvfgfKkCSryCoCE4HA2cFXAweqehvZGUluBVTbgNqkx1qdM7We6XHVm
         zow7L9BGYhnnGxHakLiofy8KcrzVGmLkId3eR7YBlRZwxP8jZVIDRPz7JBO6Pnv4pNoM
         iRz4eXHUulgFeAOKr8b3+mFWbvvrBsfa9AbDOELTDhioudTITqlY7NrF++o5JmxUU5p8
         vQ4DaKalWBQc7PyyJc1kUoqZkCSjOgQrIJ97aIRUKfjN2zxWtNlXeleLpdcUc6eWQMM3
         pMIA==
X-Gm-Message-State: AOJu0YwopRrUMvs1JX6XodrR2hP9pS82icLQCu7wQLzFvtn1pUlCYXkV
	PCrz2s0sXuWE6oe2lU+S59YwXVOMT6uAlkvC4Jis8kcVTUrjJzC0c6QhjLLNhqwAXYE6Xvb1P2V
	vjpUo4itMpFhguBSp5J9qEj7wf/h1WWzJ1Nr0+JeMssyuE7iJsNsVZBy069M4fA==
X-Received: by 2002:a05:6a00:2303:b0:6eb:6:6b72 with SMTP id h3-20020a056a00230300b006eb00066b72mr1788468pfh.25.1713411571354;
        Wed, 17 Apr 2024 20:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ZVERl6oxso7RM+v4WeKgSmstRFmimwMqPLyRcCYFFUH/9kaBppJ/H+gSLwZAj1bSwods/Q==
X-Received: by 2002:a05:6a00:2303:b0:6eb:6:6b72 with SMTP id h3-20020a056a00230300b006eb00066b72mr1788458pfh.25.1713411570810;
        Wed, 17 Apr 2024 20:39:30 -0700 (PDT)
Received: from [10.72.116.3] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm439307pfh.135.2024.04.17.20.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 20:39:30 -0700 (PDT)
Message-ID: <a0caa289-ca02-48eb-9bf2-d86fd47b71f4@redhat.com>
Date: Thu, 18 Apr 2024 11:39:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-xfs@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org
From: Xiubo Li <xiubli@redhat.com>
Subject: xfs : WARNING: possible circular locking dependency detected
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all

BTW, is this a known issue and has it been fixed already ? I can 
reproduce this always with my VMs:


<4>[ 9009.171195]
<4>[ 9009.171205] ======================================================
<4>[ 9009.171208] WARNING: possible circular locking dependency detected
<4>[ 9009.171211] 6.9.0-rc3+ #49 Not tainted
<4>[ 9009.171214] ------------------------------------------------------
<4>[ 9009.171216] kswapd0/149 is trying to acquire lock:
<4>[ 9009.171219] ffff88811346a920 
(&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_reclaim_inode+0x3ac/0x590 
[xfs]
<4>[ 9009.171580]
<4>[ 9009.171580] but task is already holding lock:
<4>[ 9009.171583] ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at: 
balance_pgdat+0x5d9/0xad0
<4>[ 9009.171593]
<4>[ 9009.171593] which lock already depends on the new lock.
<4>[ 9009.171593]
<4>[ 9009.171595]
<4>[ 9009.171595] the existing dependency chain (in reverse order) is:
<4>[ 9009.171597]
<4>[ 9009.171597] -> #1 (fs_reclaim){+.+.}-{0:0}:
<4>[ 9009.171603]        __lock_acquire+0x7da/0x1030
<4>[ 9009.171610]        lock_acquire+0x15d/0x400
<4>[ 9009.171614]        fs_reclaim_acquire+0xb5/0x100
<4>[ 9009.171618] prepare_alloc_pages.constprop.0+0xc5/0x230
<4>[ 9009.171622]        __alloc_pages+0x12a/0x3f0
<4>[ 9009.171625]        alloc_pages_mpol+0x175/0x340
<4>[ 9009.171630]        stack_depot_save_flags+0x4c5/0x510
<4>[ 9009.171635]        kasan_save_stack+0x30/0x40
<4>[ 9009.171640]        kasan_save_track+0x10/0x30
<4>[ 9009.171643]        __kasan_slab_alloc+0x83/0x90
<4>[ 9009.171646]        kmem_cache_alloc+0x15e/0x4a0
<4>[ 9009.171652]        __alloc_object+0x35/0x370
<4>[ 9009.171659]        __create_object+0x22/0x90
<4>[ 9009.171665] __kmalloc_node_track_caller+0x477/0x5b0
<4>[ 9009.171672]        krealloc+0x5f/0x110
<4>[ 9009.171679]        xfs_iext_insert_raw+0x4b2/0x6e0 [xfs]
<4>[ 9009.172172]        xfs_iext_insert+0x2e/0x130 [xfs]
<4>[ 9009.172468]        xfs_iread_bmbt_block+0x1a9/0x4d0 [xfs]
<4>[ 9009.172852]        xfs_btree_visit_block+0xfb/0x290 [xfs]
<4>[ 9009.173168]        xfs_btree_visit_blocks+0x215/0x2c0 [xfs]
<4>[ 9009.173477]        xfs_iread_extents+0x1a2/0x2e0 [xfs]
<4>[ 9009.173790] xfs_buffered_write_iomap_begin+0x376/0x10a0 [xfs]
<4>[ 9009.174096]        iomap_iter+0x1d1/0x2d0
<4>[ 9009.174102] iomap_file_buffered_write+0x120/0x1a0
<4>[ 9009.174106]        xfs_file_buffered_write+0x128/0x4b0 [xfs]
<4>[ 9009.174415]        vfs_write+0x675/0x890
<4>[ 9009.174420]        ksys_write+0xc3/0x160
<4>[ 9009.174423]        do_syscall_64+0x94/0x170
<4>[ 9009.174428] entry_SYSCALL_64_after_hwframe+0x71/0x79
<4>[ 9009.174433]
<4>[ 9009.174433] -> #0 (&xfs_nondir_ilock_class){++++}-{4:4}:
<4>[ 9009.174441]        check_prev_add+0x1b2/0x1320
<4>[ 9009.174445]        validate_chain+0x8a2/0x9f0
<4>[ 9009.174448]        __lock_acquire+0x7da/0x1030
<4>[ 9009.174452]        lock_acquire+0x15d/0x400
<4>[ 9009.174455]        down_write_nested+0x9b/0x1d0
<4>[ 9009.174459]        xfs_reclaim_inode+0x3ac/0x590 [xfs]
<4>[ 9009.174770]        xfs_icwalk_ag+0x3c1/0x850 [xfs]
<4>[ 9009.175076]        xfs_icwalk+0x38/0xb0 [xfs]
<4>[ 9009.175389]        xfs_reclaim_inodes_nr+0x107/0x170 [xfs]
<4>[ 9009.175699]        super_cache_scan+0x248/0x290
<4>[ 9009.175704]        do_shrink_slab+0x239/0x8d0
<4>[ 9009.175709]        shrink_slab_memcg+0x39f/0x780
<4>[ 9009.175713]        shrink_slab+0x3a7/0x460
<4>[ 9009.175716]        shrink_node_memcgs+0x26c/0x390
<4>[ 9009.175719]        shrink_node+0x128/0x720
<4>[ 9009.175722]        balance_pgdat+0x53c/0xad0
<4>[ 9009.175725]        kswapd+0x235/0x370
<4>[ 9009.175728]        kthread+0x1a4/0x1e0
<4>[ 9009.175732]        ret_from_fork+0x30/0x50
<4>[ 9009.175736]        ret_from_fork_asm+0x1a/0x30
<4>[ 9009.175740]
<4>[ 9009.175740] other info that might help us debug this:
<4>[ 9009.175740]
<4>[ 9009.175742]  Possible unsafe locking scenario:
<4>[ 9009.175742]
<4>[ 9009.175744]        CPU0                    CPU1
<4>[ 9009.175746]        ----                    ----
<4>[ 9009.175748]   lock(fs_reclaim);
<4>[ 9009.175752] lock(&xfs_nondir_ilock_class);
<4>[ 9009.175756] lock(fs_reclaim);
<4>[ 9009.175760]   lock(&xfs_nondir_ilock_class);
<4>[ 9009.175764]
<4>[ 9009.175764]  *** DEADLOCK ***
<4>[ 9009.175764]
<4>[ 9009.175766] 2 locks held by kswapd0/149:
<4>[ 9009.175769]  #0: ffffffff8bb33100 (fs_reclaim){+.+.}-{0:0}, at: 
balance_pgdat+0x5d9/0xad0
<4>[ 9009.175777]  #1: ffff88814c5be0e8 
(&type->s_umount_key#58){++++}-{4:4}, at: super_cache_scan+0x4b/0x290
<4>[ 9009.175788]
<4>[ 9009.175788] stack backtrace:
<4>[ 9009.175791] CPU: 0 PID: 149 Comm: kswapd0 Kdump: loaded Not 
tainted 6.9.0-rc3+ #49
<4>[ 9009.175795] Hardware name: innotek GmbH VirtualBox/VirtualBox, 
BIOS VirtualBox 12/01/2006
<4>[ 9009.175798] Call Trace:
<4>[ 9009.175801]  <TASK>
<4>[ 9009.175805]  dump_stack_lvl+0x7e/0xc0
<4>[ 9009.175811]  check_noncircular+0x267/0x2b0
<4>[ 9009.175816]  ? __pfx_check_noncircular+0x10/0x10
<4>[ 9009.175821]  ? check_path.constprop.0+0x24/0x50
<4>[ 9009.175825]  ? check_noncircular+0x132/0x2b0
<4>[ 9009.175829]  ? add_chain_block+0x1e0/0x290
<4>[ 9009.175835]  check_prev_add+0x1b2/0x1320
<4>[ 9009.175841]  validate_chain+0x8a2/0x9f0
<4>[ 9009.175846]  ? __pfx_validate_chain+0x10/0x10
<4>[ 9009.175850]  ? mark_lock.part.0+0x85/0x510
<4>[ 9009.175855]  __lock_acquire+0x7da/0x1030
<4>[ 9009.175861]  lock_acquire+0x15d/0x400
<4>[ 9009.175865]  ? xfs_reclaim_inode+0x3ac/0x590 [xfs]
<4>[ 9009.176199]  ? __pfx_lock_acquire+0x10/0x10
<4>[ 9009.176204]  ? find_held_lock+0x8c/0xa0
<4>[ 9009.176208]  ? kvm_sched_clock_read+0xd/0x20
<4>[ 9009.176212]  ? local_clock_noinstr+0x9/0xb0
<4>[ 9009.176218]  down_write_nested+0x9b/0x1d0
<4>[ 9009.176222]  ? xfs_reclaim_inode+0x3ac/0x590 [xfs]
<4>[ 9009.176537]  ? __pfx_down_write_nested+0x10/0x10
<4>[ 9009.176542]  ? xfs_reclaim_inode+0x39f/0x590 [xfs]
<4>[ 9009.176869]  ? rcu_is_watching+0x1c/0x50
<4>[ 9009.176874]  xfs_reclaim_inode+0x3ac/0x590 [xfs]
<4>[ 9009.177192]  xfs_icwalk_ag+0x3c1/0x850 [xfs]
<4>[ 9009.177499]  ? xfs_icwalk_ag+0xe4/0x850 [xfs]
<4>[ 9009.177940]  ? __pfx_xfs_icwalk_ag+0x10/0x10 [xfs]
<4>[ 9009.178339]  ? find_held_lock+0x8c/0xa0
<4>[ 9009.178343]  ? kvm_sched_clock_read+0xd/0x20
<4>[ 9009.178347]  ? local_clock_noinstr+0x9/0xb0
<4>[ 9009.178355]  ? xfs_icwalk+0x69/0xb0 [xfs]
<4>[ 9009.178659]  ? xfs_perag_grab_tag+0x154/0x360 [xfs]
<4>[ 9009.178956]  ? __pfx_xfs_perag_grab_tag+0x10/0x10 [xfs]
<4>[ 9009.179256]  ? __pfx_try_to_wake_up+0x10/0x10
<4>[ 9009.179263]  xfs_icwalk+0x38/0xb0 [xfs]
<4>[ 9009.179572]  xfs_reclaim_inodes_nr+0x107/0x170 [xfs]
<4>[ 9009.179891]  ? __pfx_xfs_reclaim_inodes_nr+0x10/0x10 [xfs]
<4>[ 9009.180203]  super_cache_scan+0x248/0x290
<4>[ 9009.180212]  do_shrink_slab+0x239/0x8d0
<4>[ 9009.180219]  shrink_slab_memcg+0x39f/0x780
<4>[ 9009.180223]  ? shrink_slab_memcg+0x20b/0x780
<4>[ 9009.180229]  ? __pfx_shrink_slab_memcg+0x10/0x10
<4>[ 9009.180234]  ? __pfx_shrink_lruvec+0x10/0x10
<4>[ 9009.180238]  ? __lock_release+0x14c/0x530
<4>[ 9009.180243]  shrink_slab+0x3a7/0x460
<4>[ 9009.180247]  ? __pfx_shrink_slab+0x10/0x10
<4>[ 9009.180253]  ? mem_cgroup_calculate_protection+0x15c/0x2a0
<4>[ 9009.180259]  shrink_node_memcgs+0x26c/0x390
<4>[ 9009.180265]  shrink_node+0x128/0x720
<4>[ 9009.180268]  ? __zone_watermark_ok+0xc0/0x2a0
<4>[ 9009.180275]  balance_pgdat+0x53c/0xad0
<4>[ 9009.180280]  ? __pfx_balance_pgdat+0x10/0x10
<4>[ 9009.180283]  ? finish_wait+0x20/0x120
<4>[ 9009.180289]  ? mark_held_locks+0x23/0x90
<4>[ 9009.180294]  ? __pfx_kswapd_try_to_sleep+0x10/0x10
<4>[ 9009.180300]  ? __pfx___lock_acquired+0x10/0x10
<4>[ 9009.180305]  ? __might_resched+0x210/0x2f0
<4>[ 9009.180311]  kswapd+0x235/0x370
<4>[ 9009.180315]  ? __pfx_kswapd+0x10/0x10
<4>[ 9009.180318]  ? lockdep_hardirqs_on_prepare.part.0+0xe9/0x1b0
<4>[ 9009.180323]  ? __kthread_parkme+0xd3/0xf0
<4>[ 9009.180328]  ? __pfx_kswapd+0x10/0x10
<4>[ 9009.180331]  kthread+0x1a4/0x1e0
<4>[ 9009.180335]  ? kthread+0xf7/0x1e0
<4>[ 9009.180338]  ? __pfx_kthread+0x10/0x10
<4>[ 9009.180341]  ret_from_fork+0x30/0x50
<4>[ 9009.180346]  ? __pfx_kthread+0x10/0x10
<4>[ 9009.180349]  ret_from_fork_asm+0x1a/0x30
<4>[ 9009.180356]  </TASK>
<4>[76541.325574] cc1plus invoked oom-killer: 
gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), order=0, 
oom_score_adj=0
<4>[76541.325590] CPU: 0 PID: 33609 Comm: cc1plus Kdump: loaded Not 
tainted 6.9.0-rc3+ #49
<4>[76541.325596] Hardware name: innotek GmbH VirtualBox/VirtualBox, 
BIOS VirtualBox 12/01/2006
<4>[76541.325599] Call Trace:
<4>[76541.325602]  <TASK>
<4>[76541.325605]  dump_stack_lvl+0xac/0xc0
<4>[76541.325613]  dump_header+0x86/0x460
<4>[76541.325621]  oom_kill_process+0x15f/0x370
<4>[76541.325626]  out_of_memory+0x18e/0x590
<4>[76541.325631]  ? __pfx_out_of_memory+0x10/0x10
<4>[76541.325638] __alloc_pages_slowpath.constprop.0+0xadc/0xea0
<4>[76541.325647]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
<4>[76541.325651]  ? __zone_watermark_ok+0xc0/0x2a0
<4>[76541.325657]  ? get_page_from_freelist+0x383/0xa60
<4>[76541.325665]  __alloc_pages+0x3ad/0x3f0
<4>[76541.325669]  ? __pfx___alloc_pages+0x10/0x10
<4>[76541.325674]  ? rcu_is_watching+0x1c/0x50
<4>[76541.325681]  ? lock_acquire+0xc7/0x400
<4>[76541.325686]  ? _find_first_bit+0x28/0x50
<4>[76541.325692]  alloc_pages_mpol+0x175/0x340
<4>[76541.325698]  ? __pfx_alloc_pages_mpol+0x10/0x10
<4>[76541.325703]  ? __pfx_lock_acquire+0x10/0x10
<4>[76541.325706]  ? do_raw_spin_trylock+0xcf/0x120
<4>[76541.325712]  ? rcu_is_watching+0x1c/0x50
<4>[76541.325717]  vma_alloc_folio+0x95/0x100
<4>[76541.325721]  ? __pfx_vma_alloc_folio+0x10/0x10
<4>[76541.325726]  ? __pte_offset_map+0x43/0x290
<4>[76541.325730]  ? __pte_offset_map+0x154/0x290
<4>[76541.325735]  alloc_anon_folio+0x260/0x460
<4>[76541.325742]  do_anonymous_page+0x96/0x780
<4>[76541.325746]  ? lock_release+0x4d/0x1c0
<4>[76541.325751]  ? do_pte_missing+0x2c/0x570
<4>[76541.325757]  ? handle_pte_fault+0x23c/0x2e0
<4>[76541.325762]  __handle_mm_fault+0x4ce/0xa00
<4>[76541.325768]  ? __pfx___handle_mm_fault+0x10/0x10
<4>[76541.325776]  ? __pfx_lock_vma_under_rcu+0x10/0x10
<4>[76541.325782]  handle_mm_fault+0x11b/0x3e0
<4>[76541.325788]  do_user_addr_fault+0x273/0x960
<4>[76541.325795]  exc_page_fault+0x59/0xd0
<4>[76541.325800]  asm_exc_page_fault+0x22/0x30
<4>[76541.325805] RIP: 0033:0x563beed22d16
<4>[76541.325810] Code: 00 00 00 e8 cc 6b ee ff b9 01 00 00 00 31 f6 31 
d2 bf 28 00 00 00 49 89 c6 e8 66 87 ed ff 66 0f ef c0 ba 02 00 00 00 48 
89 ef <0f> 11 00 48 89 c3 66 89 10 4c 89 78 10 48 c7 40 18 00 00 00 00 4c
<4>[76541.325814] RSP: 002b:00007ffddd3aa8a0 EFLAGS: 00010202
<4>[76541.325819] RAX: 00007f7541549000 RBX: 00007f7541546888 RCX: 
0000563c21ca6e50
<4>[76541.325822] RDX: 0000000000000002 RSI: 0000000000000006 RDI: 
00007f7541546930
<4>[76541.325825] RBP: 00007f7541546930 R08: 00007f7541549000 R09: 
0000563c21ca6e50
<4>[76541.325828] R10: 0000000000000001 R11: 0000000000000001 R12: 
00007f7546a2e690
<4>[76541.325831] R13: 00007f75414bf000 R14: 00007f7541524c78 R15: 
00007f7541544fa0
<4>[76541.325838]  </TASK>
<4>[76541.325844] Mem-Info:
<4>[76541.325848] active_anon:504 inactive_anon:4920752 isolated_anon:0
<4>[76541.325848]  active_file:1300 inactive_file:1167 isolated_file:0
<4>[76541.325848]  unevictable:0 dirty:82 writeback:0
<4>[76541.325848]  slab_reclaimable:59582 slab_unreclaimable:373508
<4>[76541.325848]  mapped:4582 shmem:5358 pagetables:13948
<4>[76541.325848]  sec_pagetables:0 bounce:0
<4>[76541.325848]  kernel_misc_reclaimable:0
<4>[76541.325848]  free:68497 free_pcp:152 free_cma:0
<4>[76541.325855] Node 0 active_anon:2016kB inactive_anon:19683008kB 
active_file:5200kB inactive_file:4668kB unevictable:0kB 
isolated(anon):0kB isolated(file):0kB mapped:18328kB dirty:328kB 
writeback:0kB shmem:21432kB shmem_thp:0kB shmem_pmdmapped:0kB 
anon_thp:7714816kB writeback_tmp:0kB kernel_stack:20352kB 
pagetables:55792kB sec_pagetables:0kB all_unreclaimable? no
<4>[76541.325863] Node 0 DMA free:11264kB boost:0kB min:44kB low:56kB 
high:68kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
<4>[76541.325872] lowmem_reserve[]: 0 3113 21217 21217 21217
<4>[76541.325881] Node 0 DMA32 free:82792kB boost:0kB min:9908kB 
low:13096kB high:16284kB reserved_highatomic:0KB active_anon:0kB 
inactive_anon:3182860kB active_file:484kB inactive_file:308kB 
unevictable:0kB writepending:136kB present:3653568kB managed:3325888kB 
mlocked:0kB bounce:0kB free_pcp:512kB local_pcp:0kB free_cma:0kB
<4>[76541.325889] lowmem_reserve[]: 0 0 18103 18103 18103
<4>[76541.325902] Node 0 Normal free:179932kB boost:142044kB 
min:199668kB low:218204kB high:236740kB reserved_highatomic:0KB 
active_anon:2016kB inactive_anon:16499404kB active_file:4952kB 
inactive_file:4408kB unevictable:0kB writepending:272kB 
present:22405120kB managed:18550444kB mlocked:0kB bounce:0kB 
free_pcp:164kB local_pcp:0kB free_cma:0kB
<4>[76541.325910] lowmem_reserve[]: 0 0 0 0 0
<4>[76541.325918] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 
0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB
<4>[76541.325942] Node 0 DMA32: 147*4kB (UM) 866*8kB (UM) 724*16kB (UME) 
547*32kB (UME) 318*64kB (UME) 73*128kB (UE) 4*256kB (UM) 5*512kB (M) 
12*1024kB (M) 0*2048kB 0*4096kB = 82172kB
<4>[76541.325972] Node 0 Normal: 286*4kB (UME) 3098*8kB (UME) 7684*16kB 
(UME) 964*32kB (UME) 5*64kB (M) 0*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 180040kB
<4>[76541.325998] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
<4>[76541.326001] 7807 total pagecache pages
<4>[76541.326004] 0 pages in swap cache
<4>[76541.326006] Free swap  = 0kB
<4>[76541.326008] Total swap = 0kB
<4>[76541.326011] 6518670 pages RAM
<4>[76541.326013] 0 pages HighMem/MovableOnly
<4>[76541.326015] 1045747 pages reserved
<4>[76541.326017] 0 pages cma reserved
<4>[76541.326020] 0 pages hwpoisoned
<6>[76541.326022] Tasks state (memory values in pages):
<6>[76541.326025] [  pid  ]   uid  tgid total_vm      rss rss_anon 
rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
<6>[76541.326043] [    751]     0   751     6809 1042      256      
178       608    90112        0          -250 systemd-journal
<6>[76541.326050] [    765]     0   765     9020 1150      975      
175         0    94208        0         -1000 systemd-udevd
<6>[76541.326058] [    899]     0   899    22958 331      160      
171         0    77824        0         -1000 auditd
<6>[76541.326063] [    901]     0   901     1947 270       64      
206         0    61440        0             0 sedispatch
<6>[76541.326069] [    922]    81   922     2738 339      210      
129         0    73728        0          -900 dbus-broker-lau
<6>[76541.326074] [    923]    81   923     2427 689      565      
124         0    57344        0          -900 dbus-broker
<6>[76541.326079] [    924]     0   924   118878 932      736      
196         0   172032        0             0 NetworkManager
<6>[76541.326084] [    925]    70   925     3984 396      224      
172         0    69632        0             0 avahi-daemon
<6>[76541.326094] [    928]     0   928    19781 241       64      
177         0    65536        0             0 irqbalance
<6>[76541.326099] [    929]   993   929      676 99       32       
67         0    53248        0             0 lsmd
<6>[76541.326105] [    930]     0   930      833 213       32      
181         0    53248        0             0 mcelog
<6>[76541.326109] [    933]   998   933   696894 1606     1426      
180         0   253952        0             0 polkitd
<6>[76541.326115] [    934]     0   934   112996 321      128      
193         0   131072        0             0 power-profiles-
<6>[76541.326120] [    937]   172   937    38527 243       64      
179         0    69632        0             0 rtkit-daemon
<6>[76541.326126] [    939]   982   939    21215 289      140      
149         0    73728        0             0 chronyd
<6>[76541.326131] [    940]     0   940   131390 284      160      
124         0   139264        0             0 accounts-daemon
<6>[76541.326136] [    942]     0   942   112043 287       96      
191         0   122880        0             0 switcheroo-cont
<6>[76541.326141] [    949]     0   949     7297 767      565      
202         0    98304        0             0 systemd-logind
<6>[76541.326146] [    952]     0   952    98804 708      480      
228         0   147456        0             0 udisksd
<6>[76541.326151] [    953]     0   953   112202 393      192      
201         0   126976        0             0 upowerd
<6>[76541.326156] [    957]    70   957     3916 367      205      
162         0    65536        0             0 avahi-daemon
<6>[76541.326162] [    972]     0   972     1181 276       64      
212         0    49152        0             0 alsactl
<6>[76541.326167] [    982]     0   982    97866 535      416      
119         0   151552        0             0 ModemManager
<6>[76541.326172] [   1011]     0  1011    61956 1198      992      
206         0   122880        0             0 cupsd
<6>[76541.326177] [   1015]     0  1015     3950 521      288      
233         0    69632        0         -1000 sshd
<6>[76541.326182] [   1033]     0  1033     1168 234       32      
202         0    45056        0             0 atd
<6>[76541.326188] [   1036]     0  1036    55980 335      192      
143         0    69632        0             0 crond
<6>[76541.326193] [   1040]     0  1040   113278 437      224      
213         0   135168        0             0 gdm
<6>[76541.326198] [   1093]     0  1093    41209 446      160      
121       165   106496        0             0 rsyslogd
<6>[76541.326203] [   1579]     0  1579     3822 370      192      
178         0    69632        0             0 wpa_supplicant
<6>[76541.326208] [   1805]   989  1805   132604 664      512      
152         0   151552        0             0 colord
<6>[76541.326213] [   2010]     0  2010    96963 673      416      
257         0   131072        0             0 gdm-session-wor
<6>[76541.326219] [   2028]  1000  2028     5877 1052      892      
160         0    86016        0           100 systemd
<6>[76541.326227] [   2032]  1000  2032     6799 1674     1536      
138         0    90112        0           100 (sd-pam)
<6>[76541.326233] [   2057]  1000  2057   113231 414      199      
215         0   135168        0             0 gnome-keyring-d
<6>[76541.326242] [   2063]  1000  2063    93539 337       96      
241         0    98304        0             0 gdm-wayland-ses
<6>[76541.326246] [   2067]  1000  2067     2665 262       96      
166         0    73728        0           200 dbus-broker-lau
<6>[76541.326253] [   2069]  1000  2069     1667 462      320      
142         0    49152        0           200 dbus-broker
<6>[76541.326258] [   2072]  1000  2072   128284 649      480      
169         0   196608        0             0 gnome-session-b
<6>[76541.326263] [   2117]  1000  2117    75949 289       96      
193         0   110592        0           200 gnome-session-c
<6>[76541.326267] [   2119]  1000  2119   165282 760      576      
184         0   229376        0           200 gnome-session-b
<6>[76541.326273] [   2135]  1000  2135  1732662    41332 40744      
172       416  1613824        0           200 gnome-shell
<6>[76541.326278] [   2178]  1000  2178   113144 359      160      
199         0   131072        0           200 gvfsd
<6>[76541.326283] [   2185]  1000  2185    94983 357      160      
197         0   110592        0           200 gvfsd-fuse
<6>[76541.326288] [   2196]  1000  2196    77144 339      160      
179         0   118784        0           200 at-spi-bus-laun
<6>[76541.326293] [   2202]  1000  2202     2633 277       64      
213         0    65536        0           200 dbus-broker-lau
<6>[76541.326298] [   2204]  1000  2204     1247 236       64      
172         0    53248        0           200 dbus-broker
<6>[76541.326303] [   2215]  1000  2215   131709 1393     1169      
224         0   147456        0           200 ibus-daemon
<6>[76541.326308] [   2219]  1000  2219   112273 318      160      
158         0   118784        0           200 ibus-dconf
<6>[76541.326314] [   2220]  1000  2220   148953 2758     2505      
157        96   237568        0           200 ibus-extension-
<6>[76541.326319] [   2224]  1000  2224   146388 883      704      
179         0   221184        0           200 gnome-shell-cal
<6>[76541.326324] [   2226]  1000  2226   112025 329       96      
233         0   126976        0           200 xdg-permission-
<6>[76541.326329] [   2230]  1000  2230   112261 323      128      
195         0   122880        0           200 ibus-portal
<6>[76541.326334] [   2235]  1000  2235    81642 1710     1454      
256         0   118784        0           200 pipewire
<6>[76541.326339] [   2240]  1000  2240   136741 1446     1248      
198         0   172032        0           200 wireplumber
<6>[76541.326345] [   2246]  1000  2246    79192 601      448      
153         0   114688        0           200 pipewire-pulse
<6>[76541.326350] [   2252]  1000  2252   321629 1223     1056      
167         0   311296        0           200 evolution-sourc
<6>[76541.326355] [   2267]  1000  2267   204877 864      672      
192         0   266240        0           200 goa-daemon
<6>[76541.326363] [   2272]  1000  2272   262624 1350     1120      
230         0   323584        0           200 evolution-calen
<6>[76541.326368] [   2274]  1000  2274   131890 574      352      
222         0   147456        0           200 gvfs-udisks2-vo
<6>[76541.326374] [   2288]  1000  2288   132884 458      320      
138         0   155648        0           200 goa-identity-se
<6>[76541.326379] [   2291]  1000  2291   112063 270      128      
142         0   118784        0           200 gvfs-mtp-volume
<6>[76541.326384] [   2305]  1000  2305   112520 363      160      
203         0   126976        0           200 gvfs-gphoto2-vo
<6>[76541.326388] [   2310]  1000  2310    39001 216       96      
120         0    73728        0           200 dconf-service
<6>[76541.326393] [   2314]  1000  2314   238450 1084      864      
220         0   299008        0           200 evolution-addre
<6>[76541.326399] [   2318]  1000  2318   112074 317      128      
189         0   122880        0           200 gvfs-goa-volume
<6>[76541.326404] [   2325]     0  2325    60133 486      320      
166         0   114688        0             0 sssd_kcm
<6>[76541.326410] [   2344]  1000  2344   784123 1523     1300      
223         0   294912        0           200 gjs
<6>[76541.326415] [   2345]  1000  2345    40430 358      160      
198         0    90112        0           200 at-spi2-registr
<6>[76541.326420] [   2355]  1000  2355   130534 324      128      
196         0   139264        0           200 gsd-a11y-settin
<6>[76541.326425] [   2369]  1000  2369   184989 1639     1344      
169       126   249856        0           200 gsd-color
<6>[76541.326430] [   2375]  1000  2375   148593 712      576      
136         0   233472        0           200 gsd-datetime
<6>[76541.326435] [   2378]  1000  2378    93814 353      128      
225         0   110592        0           200 ibus-engine-sim
<6>[76541.326440] [   2387]  1000  2387   131126 399      192      
207         0   135168        0           200 gsd-housekeepin
<6>[76541.326446] [   2401]  1000  2401   147567 1611     1280      
237        94   217088        0           200 gsd-keyboard
<6>[76541.326451] [   2418]  1000  2418   237038 1706     1344      
271        91   286720        0           200 gsd-media-keys
<6>[76541.326455] [   2421]  1000  2421   184825 1497     1280      
129        88   245760        0           200 gsd-power
<6>[76541.326460] [   2424]  1000  2424   116824 622      416      
206         0   159744        0           200 gsd-print-notif
<6>[76541.326465] [   2430]  1000  2430   167414 339      128      
211         0   159744        0           200 gsd-rfkill
<6>[76541.326470] [   2431]  1000  2431   112014 320      128      
192         0   118784        0           200 gsd-screensaver
<6>[76541.326485] [   2434]  1000  2434   169561 552      352      
200         0   180224        0           200 gsd-sharing
<6>[76541.326490] [   2441]  1000  2441   150846 572      352      
220         0   147456        0           200 gsd-smartcard
<6>[76541.326495] [   2443]  1000  2443   132668 441      224      
217         0   159744        0           200 gsd-sound
<6>[76541.326499] [   2450]  1000  2450   149435 300      160      
140         0   155648        0           200 gsd-usb-protect
<6>[76541.326504] [   2464]  1000  2464   147723 1639     1312      
230        97   212992        0           200 gsd-wacom
<6>[76541.326509] [   2472]  1000  2472    58012 407      224      
183         0    98304        0           200 gsd-disk-utilit
<6>[76541.326528] [   2479]  1000  2479   259040    11962 11791      
171         0   446464        0           200 gnome-software
<6>[76541.326533] [   2487]  1000  2487   228900 2389     2144      
148        97   335872        0           200 evolution-alarm
<6>[76541.326538] [   2528]  1000  2528   784122 1547     1344      
203         0   294912        0           200 gjs
<6>[76541.326542] [   2536]  1000  2536   172243 615      416      
199         0   176128        0           200 xdg-desktop-por
<6>[76541.326547] [   2549]  1000  2549   149605 870      640      
230         0   233472        0           200 gsd-printer
<6>[76541.326551] [   2568]  1000  2568   167492 262       96      
166         0   172032        0           200 xdg-document-po
<6>[76541.326560] [   2574]  1000  2574      663 172        0      
172         0    49152        0           200 fusermount
<6>[76541.326565] [   2597]  1000  2597   223864 1479     1280      
199         0   290816        0           200 xdg-desktop-por
<6>[76541.326570] [   2690]  1000  2690   147896 1725     1408      
220        97   225280        0           200 xdg-desktop-por
<6>[76541.326575] [   2712]     0  2712   141140 1275     1056      
219         0   212992        0             0 fwupd
<6>[76541.326579] [   2724]  1000  2724    93694 206       64      
142         0   110592        0           200 gvfsd-metadata
<6>[76541.326584] [   2778]  1000  2778   190541 3240     2560      
231       449   294912        0           200 gnome-terminal-
<6>[76541.326592] [   2796]  1000  2796    56028 663      448      
215         0    73728        0           200 bash
<6>[76541.326597] [   2835]     0  2835     4859 600      416      
184         0    81920        0             0 sshd
<6>[76541.326601] [   2840]  1000  2840     4903 612      487      
125         0    81920        0             0 sshd
<6>[76541.326606] [   2843]  1000  2843    56056 618      480      
138         0    77824        0             0 bash
<6>[76541.326611] [   3868]     0  3868     4859 634      448      
186         0    81920        0             0 sshd
<6>[76541.326615] [   3873]  1000  3873     4903 681      461      
220         0    81920        0             0 sshd
<6>[76541.326620] [   3876]  1000  3876    56056 615      480      
135         0    77824        0             0 bash
<6>[76541.326630] [  25652]  1000 25652    57500 287      128      
159         0    90112        0             0 git
<6>[76541.326636] [  26274]  1000 26274    55461 335      192      
143         0    69632        0             0 make
<6>[76541.326640] [  26463]  1000 26463    56106 879      768      
111         0    81920        0             0 make
<6>[76541.326646] [  32166]  1000 32166    67643    12357 12215      
142         0   176128        0             0 make
<6>[76541.326650] [  32585]  1000 32585    61726 6459     6317      
142         0   126976        0             0 make
<6>[76541.326659] [  33364]  1000 33364    55748 240       96      
144         0    73728        0             0 g++
<6>[76541.326663] [  33365]  1000 33365  2781960  2651315 2650090     
1225         0 21700608        0             0 cc1plus
<6>[76541.326668] [  33587]  1000 33587    55748 252       96      
156         0    73728        0             0 g++
<6>[76541.326673] [  33588]  1000 33588   597044   510453 509837      
616         0  4243456        0             0 cc1plus
<6>[76541.326678] [  33592]  1000 33592    55748 252       96      
156         0    69632        0             0 g++
<6>[76541.326682] [  33593]  1000 33593   532253   445795 444214     
1581         0  3723264        0             0 cc1plus
<6>[76541.326687] [  33596]  1000 33596    55748 247       96      
151         0    69632        0             0 g++
<6>[76541.326694] [  33597]  1000 33597   505784   435412 435159      
253         0  3641344        0             0 cc1plus
<6>[76541.326699] [  33600]  1000 33600    55748 273       96      
177         0    65536        0             0 g++
<6>[76541.326704] [  33601]  1000 33601   456709   387653 386025     
1628         0  3252224        0             0 cc1plus
<6>[76541.326708] [  33604]  1000 33604    55748 269       96      
173         0    73728        0             0 g++
<6>[76541.326713] [  33605]  1000 33605   286890   218179 216781     
1398         0  1904640        0             0 cc1plus
<6>[76541.326717] [  33608]  1000 33608    55748 220       96      
124         0    77824        0             0 g++
<6>[76541.326725] [  33609]  1000 33609   217521   141052 139828     
1224         0  1290240        0             0 cc1plus
<6>[76541.326729] 
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-1000.slice/session-4.scope,task=cc1plus,pid=33365,uid=1000
<3>[76541.326764] Out of memory: Killed process 33365 (cc1plus) 
total-vm:11127840kB, anon-rss:10600360kB, file-rss:4900kB, 
shmem-rss:0kB, UID:1000 pgtables:21192kB oom_score_adj:0


Thanks

- Xiubo


