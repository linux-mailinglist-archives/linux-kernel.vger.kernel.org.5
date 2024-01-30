Return-Path: <linux-kernel+bounces-44148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77D841DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168F81C27A29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B258AA5;
	Tue, 30 Jan 2024 08:36:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDD58AB8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603790; cv=none; b=Z/6fUHDXrU5FLIPhieSpq5z6EUE/ZzBbqoYrhN5LEZTdA03tl20mK12PU68wokBiR6QOqO9jQTpd9FTDV1CJGry6dEhCvrGK0l3uU2i9lv5adsrdQzGCNOlisTXwwMqik7wsm4hov3umKwimVZExwJAyBnLWX4t7KGA3wqihxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603790; c=relaxed/simple;
	bh=HgviGZVVgxmdsktsZhklaDsboFIauWv+s0xoP1DLoEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZB4P1iteJioOuVOsORMBUzFB1vzDWV/u+VvSFDyGTnNFfquuHmcnd+Q5L/ktTxffdsvD8BS6AcCiDWRv7RxyVAUTJOItQiISxhe0Uo0oxv6F9tvV6FpVsBaZ61Afqh79Rw6BqKu7mq2pZjM2wrjxthbOOJZa5Klb3ve5JhSmTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3638c09d8d9so3921545ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603788; x=1707208588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GY5/GhotHDC/Hu5ZdpGyDMk4TS5RnB1IXDcc+SJkaCM=;
        b=WvVAqT3gsHXVEkGHiV2U7A4tZXiV6dmbCMsKIxIg1GsSMk7eCkU4zrIoA+9ECO3q1N
         Av8Og8yQYnI2UUO6s7uqf79U7DXtXih/noRrSbSDzrM6v1sJemp+v/ojIY1H50BkVC3q
         mmauBZw+E+z+DZZov2gG4kYtu9wEHM+MccvNfWfUo+hJeejb5ubQktVViCqNG8HF+J04
         1Pn2WjWvO/briOUy0fhjrTvtXvBcYBxvJAbqK45aqMR93KChyXmilG7ISkf1Lggpc0pw
         2gyetKqlKK7jD+3S6jj13mZYfSGRCraqGVeP0Voi6tz8olEUwWryF+fGCNifsFtm0YLN
         j4aw==
X-Gm-Message-State: AOJu0Yy9L8HthlGdmmmRpj8AXMPyH8kxsYtTAQFKzl8BQXm+RhUKK9eJ
	MVO4Z0ovil9cgpRI6MyCTE7iaeBfGJmT/k85lfby2tyjr48k+x3xqItlh3VgIBmUvbGHCQLljnE
	eNn483E55ErF4M1ABiiGgzFw2cG7DN23Ece+piTAEUVhTqH0SAwDO68IQEw==
X-Google-Smtp-Source: AGHT+IEqPZM1NXrVuBWwUC3NOv3xiRG8TXWKFs4VjZdYSmzMhn7rQk9niekgH9ZMfFOiELF4bUUhRVdKp9JgmxORS2rb6/4CjvnY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:361:a33f:36a4 with SMTP id
 s3-20020a056e021a0300b00361a33f36a4mr789002ild.2.1706603787855; Tue, 30 Jan
 2024 00:36:27 -0800 (PST)
Date: Tue, 30 Jan 2024 00:36:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c2dbb061025a8bd@google.com>
Subject: [syzbot] [kernel?] possible deadlock in blocking_notifier_call_chain
From: syzbot <syzbot+829bfaba8614e7a1daf1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1277a20fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ba027dac3a59637
dashboard link: https://syzkaller.appspot.com/bug?extid=829bfaba8614e7a1daf1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-861c0981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48450e0b2e5f/vmlinux-861c0981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8591bd9681ee/bzImage-861c0981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+829bfaba8614e7a1daf1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc2-syzkaller-00031-g861c0981648f #0 Not tainted
------------------------------------------------------
syz-executor.2/32429 is trying to acquire lock:
ffffffff8d319ea0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8d319ea0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3761 [inline]
ffffffff8d319ea0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3842 [inline]
ffffffff8d319ea0 (fs_reclaim){+.+.}-{0:0}, at: kmalloc_trace+0x51/0x340 mm/slub.c:4007

but task is already holding lock:
ffffffff8db384f0 ((crypto_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain kernel/notifier.c:387 [inline]
ffffffff8db384f0 ((crypto_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x53/0x90 kernel/notifier.c:376

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 ((crypto_chain).rwsem){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       blocking_notifier_call_chain kernel/notifier.c:387 [inline]
       blocking_notifier_call_chain+0x53/0x90 kernel/notifier.c:376
       crypto_probing_notify crypto/api.c:305 [inline]
       crypto_alg_mod_lookup+0x2a0/0x4b0 crypto/api.c:335
       crypto_find_alg crypto/api.c:580 [inline]
       crypto_alloc_tfm_node+0xd3/0x260 crypto/api.c:617
       cryptd_alloc_skcipher+0x113/0x200 crypto/cryptd.c:960
       simd_skcipher_init+0x69/0x1a0 crypto/simd.c:122
       crypto_skcipher_init_tfm+0x177/0x2c0 crypto/skcipher.c:790
       crypto_create_tfm_node+0xfd/0x310 crypto/api.c:522
       crypto_alloc_tfm_node+0x102/0x260 crypto/api.c:623
       derive_key_aes+0x144/0x4d0 fs/crypto/keysetup_v1.c:55
       setup_v1_file_key_derived fs/crypto/keysetup_v1.c:282 [inline]
       fscrypt_setup_v1_file_key+0x1ce/0x550 fs/crypto/keysetup_v1.c:299
       fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x159/0x2d0 fs/crypto/keysetup_v1.c:321
       setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
       fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
       fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
       fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
       __fscrypt_prepare_lookup+0x2c/0xf0 fs/crypto/hooks.c:100
       fscrypt_prepare_lookup include/linux/fscrypt.h:979 [inline]
       ext4_fname_prepare_lookup+0x1d8/0x350 fs/ext4/crypto.c:48
       ext4_lookup_entry fs/ext4/namei.c:1764 [inline]
       ext4_lookup+0x147/0x740 fs/ext4/namei.c:1839
       lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3474
       open_last_lookups fs/namei.c:3565 [inline]
       path_openat+0x931/0x2990 fs/namei.c:3795
       do_filp_open+0x1de/0x430 fs/namei.c:3825
       do_sys_openat2+0x176/0x1e0 fs/open.c:1404
       do_sys_open fs/open.c:1419 [inline]
       __do_sys_open fs/open.c:1427 [inline]
       __se_sys_open fs/open.c:1423 [inline]
       __x64_sys_open+0x154/0x1e0 fs/open.c:1423
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #3 (&type->lock_class#3){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112
       fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x115/0x2d0 fs/crypto/keysetup_v1.c:310
       setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
       fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
       fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
       fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
       ext4_fname_setup_filename+0xa3/0x250 fs/ext4/crypto.c:28
       ext4_add_entry+0x2e3/0xdf0 fs/ext4/namei.c:2401
       ext4_rename+0x16a5/0x2890 fs/ext4/namei.c:3937
       ext4_rename2+0x1bc/0x270 fs/ext4/namei.c:4215
       vfs_rename+0xf83/0x20a0 fs/namei.c:4879
       do_renameat2+0xc50/0xdc0 fs/namei.c:5036
       __do_sys_renameat fs/namei.c:5077 [inline]
       __se_sys_renameat fs/namei.c:5074 [inline]
       __x64_sys_renameat+0xc6/0x100 fs/namei.c:5074
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x10ff/0x15e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x391/0x840 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x343/0x5d0 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
       ext4_file_open+0x632/0xc80 fs/ext4/file.c:866
       do_dentry_open+0x8d6/0x18c0 fs/open.c:953
       do_open fs/namei.c:3641 [inline]
       path_openat+0x1df6/0x2990 fs/namei.c:3798
       do_filp_open+0x1de/0x430 fs/namei.c:3825
       do_sys_openat2+0x176/0x1e0 fs/open.c:1404
       do_sys_open fs/open.c:1419 [inline]
       __do_sys_openat fs/open.c:1435 [inline]
       __se_sys_openat fs/open.c:1430 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1430
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1639 [inline]
       sb_start_intwrite include/linux/fs.h:1822 [inline]
       ext4_evict_inode+0xe5b/0x1a40 fs/ext4/inode.c:212
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1739 [inline]
       iput.part.0+0x560/0x7b0 fs/inode.c:1765
       iput+0x5c/0x80 fs/inode.c:1755
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
       __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x327/0x540 fs/super.c:221
       do_shrink_slab+0x428/0x1120 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa83/0x1310 mm/shrinker.c:626
       shrink_one+0x48f/0x7b0 mm/vmscan.c:4767
       shrink_many mm/vmscan.c:4828 [inline]
       lru_gen_shrink_node mm/vmscan.c:4929 [inline]
       shrink_node+0x2149/0x3740 mm/vmscan.c:5888
       kswapd_shrink_node mm/vmscan.c:6693 [inline]
       balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6883
       kswapd+0x5be/0xbf0 mm/vmscan.c:7143
       kthread+0x2c6/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2445/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
       fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3706
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3761 [inline]
       slab_alloc_node mm/slub.c:3842 [inline]
       kmalloc_trace+0x51/0x340 mm/slub.c:4007
       kmalloc include/linux/slab.h:590 [inline]
       kzalloc include/linux/slab.h:711 [inline]
       cryptomgr_schedule_probe crypto/algboss.c:85 [inline]
       cryptomgr_notify+0xa0/0xbb0 crypto/algboss.c:226
       notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
       blocking_notifier_call_chain kernel/notifier.c:388 [inline]
       blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:376
       crypto_probing_notify crypto/api.c:305 [inline]
       crypto_alg_mod_lookup+0x2a0/0x4b0 crypto/api.c:335
       crypto_find_alg crypto/api.c:580 [inline]
       crypto_alloc_tfm_node+0xd3/0x260 crypto/api.c:617
       fscrypt_allocate_skcipher fs/crypto/keysetup.c:106 [inline]
       fscrypt_prepare_key+0x92/0x410 fs/crypto/keysetup.c:158
       fscrypt_set_per_file_enc_key fs/crypto/keysetup.c:185 [inline]
       fscrypt_setup_v2_file_key+0x3f7/0x5e0 fs/crypto/keysetup.c:374
       setup_file_encryption_key fs/crypto/keysetup.c:505 [inline]
       fscrypt_setup_encryption_info+0xded/0x1080 fs/crypto/keysetup.c:590
       fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
       fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
       __fscrypt_prepare_lookup+0x2c/0xf0 fs/crypto/hooks.c:100
       fscrypt_prepare_lookup include/linux/fscrypt.h:979 [inline]
       ext4_fname_prepare_lookup+0x1d8/0x350 fs/ext4/crypto.c:48
       ext4_lookup_entry fs/ext4/namei.c:1764 [inline]
       ext4_lookup+0x147/0x740 fs/ext4/namei.c:1839
       __lookup_slow+0x24d/0x450 fs/namei.c:1693
       lookup_one+0x181/0x1b0 fs/namei.c:2785
       ovl_lookup_upper fs/overlayfs/overlayfs.h:401 [inline]
       ovl_workdir_create+0x1d6/0x820 fs/overlayfs/super.c:300
       ovl_make_workdir fs/overlayfs/super.c:664 [inline]
       ovl_get_workdir fs/overlayfs/super.c:822 [inline]
       ovl_fill_super+0xe68/0x6720 fs/overlayfs/super.c:1390
       vfs_get_super fs/super.c:1273 [inline]
       get_tree_nodev+0xd6/0x180 fs/super.c:1292
       vfs_get_tree+0x8c/0x370 fs/super.c:1784
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:3875
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &type->lock_class#3 --> (crypto_chain).rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock((crypto_chain).rwsem);
                               lock(&type->lock_class#3);
                               lock((crypto_chain).rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

5 locks held by syz-executor.2/32429:
 #0: ffff888048f140e0 (&type->s_umount_key#84/1){+.+.}-{3:3}, at: alloc_super+0x238/0xb50 fs/super.c:345
 #1: ffff888022950420 (sb_writers#5){.+.+}-{0:0}, at: ovl_make_workdir fs/overlayfs/super.c:660 [inline]
 #1: ffff888022950420 (sb_writers#5){.+.+}-{0:0}, at: ovl_get_workdir fs/overlayfs/super.c:822 [inline]
 #1: ffff888022950420 (sb_writers#5){.+.+}-{0:0}, at: ovl_fill_super+0xe39/0x6720 fs/overlayfs/super.c:1390
 #2: ffff88802dd25e00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:837 [inline]
 #2: ffff88802dd25e00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: ovl_workdir_create+0x13e/0x820 fs/overlayfs/super.c:298
 #3: ffff88805c7dd880 (&mk->mk_sem){++++}-{3:3}, at: setup_file_encryption_key fs/crypto/keysetup.c:487 [inline]
 #3: ffff88805c7dd880 (&mk->mk_sem){++++}-{3:3}, at: fscrypt_setup_encryption_info+0x5d6/0x1080 fs/crypto/keysetup.c:590
 #4: ffffffff8db384f0 ((crypto_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain kernel/notifier.c:387 [inline]
 #4: ffffffff8db384f0 ((crypto_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x53/0x90 kernel/notifier.c:376

stack backtrace:
CPU: 0 PID: 32429 Comm: syz-executor.2 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2445/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
 fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3706
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slub.c:3761 [inline]
 slab_alloc_node mm/slub.c:3842 [inline]
 kmalloc_trace+0x51/0x340 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 cryptomgr_schedule_probe crypto/algboss.c:85 [inline]
 cryptomgr_notify+0xa0/0xbb0 crypto/algboss.c:226
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 blocking_notifier_call_chain kernel/notifier.c:388 [inline]
 blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:376
 crypto_probing_notify crypto/api.c:305 [inline]
 crypto_alg_mod_lookup+0x2a0/0x4b0 crypto/api.c:335
 crypto_find_alg crypto/api.c:580 [inline]
 crypto_alloc_tfm_node+0xd3/0x260 crypto/api.c:617
 fscrypt_allocate_skcipher fs/crypto/keysetup.c:106 [inline]
 fscrypt_prepare_key+0x92/0x410 fs/crypto/keysetup.c:158
 fscrypt_set_per_file_enc_key fs/crypto/keysetup.c:185 [inline]
 fscrypt_setup_v2_file_key+0x3f7/0x5e0 fs/crypto/keysetup.c:374
 setup_file_encryption_key fs/crypto/keysetup.c:505 [inline]
 fscrypt_setup_encryption_info+0xded/0x1080 fs/crypto/keysetup.c:590
 fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
 fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
 __fscrypt_prepare_lookup+0x2c/0xf0 fs/crypto/hooks.c:100
 fscrypt_prepare_lookup include/linux/fscrypt.h:979 [inline]
 ext4_fname_prepare_lookup+0x1d8/0x350 fs/ext4/crypto.c:48
 ext4_lookup_entry fs/ext4/namei.c:1764 [inline]
 ext4_lookup+0x147/0x740 fs/ext4/namei.c:1839
 __lookup_slow+0x24d/0x450 fs/namei.c:1693
 lookup_one+0x181/0x1b0 fs/namei.c:2785
 ovl_lookup_upper fs/overlayfs/overlayfs.h:401 [inline]
 ovl_workdir_create+0x1d6/0x820 fs/overlayfs/super.c:300
 ovl_make_workdir fs/overlayfs/super.c:664 [inline]
 ovl_get_workdir fs/overlayfs/super.c:822 [inline]
 ovl_fill_super+0xe68/0x6720 fs/overlayfs/super.c:1390
 vfs_get_super fs/super.c:1273 [inline]
 get_tree_nodev+0xd6/0x180 fs/super.c:1292
 vfs_get_tree+0x8c/0x370 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f97daa7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97db80e0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f97dababf80 RCX: 00007f97daa7cda9
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007f97daac947a R08: 0000000020000140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f97dababf80 R15: 00007fffbf203f18
 </TASK>
fscrypt (sda1, inode 2010): Missing crypto API support for Adiantum (API name: "adiantum(xchacha12,aes)")
fscrypt (sda1, inode 2010): Missing crypto API support for Adiantum (API name: "adiantum(xchacha12,aes)")
overlayfs: failed to create directory ./file0/work (errno: 65); mounting read-only


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

