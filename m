Return-Path: <linux-kernel+bounces-72419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1A85B304
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09039B22BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6213828363;
	Tue, 20 Feb 2024 06:41:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CE383A1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411277; cv=none; b=GHrQqw/8aLxAZBA6r4gW671kF1WhzRe6JwrgSFmxbnZsm48mTLBzNulhdGzPFsHhtuI/vcAxXabED9hKQ9pgfLYwgMjiv3EVaR02iyhld5gjUHEFsT/LsPPiU8FUhBsOcqib0E2Nz6uw0sT/WIUgqBfLHiB6jgU5v+eZHA9Mff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411277; c=relaxed/simple;
	bh=NtRo2O1ldVbjJcnBavA1aQO7Pzf3iSzVkzqVVJUVVJA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bKN/CCFkpDZfqJO60FxBCsMbNZdx12vmqplMD9I7vUKDkdslqGhjYL85BygWUbSUh9SestRcrn6wI8PUh8sCyjXIvcYz0Xh67noStke2dTqI9RWB92Ycj3fZyVG+t2M3Imxf3vaYqj/29oyS3OzYlbAMcvdZgK+iOQ0btNSM4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c495649efdso505590939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411275; x=1709016075;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c64CAYVASUjHaLy4K4kMEouxEUHxQMTvGQZksi5Chfo=;
        b=tb0/ZrtUdsjHGpe/+CNxizSqgJzKA/uXxKxeCmDR5+AW0AbB3fUlCxFTXwscwcXW93
         dJ+WEzoQy5jP/7RpPOVuZFgQeF/mYeYNqAwafQtCntLnAEHcX/3lw4sl2t9eTK/39sKT
         U28i1QmFQ61nsGqsFRkd67HTf7VKQb0y/xZ7tJOjDvGLsSIkhYYV4aSnU1/4u0QonSMk
         F/xYEF2dirYxzeARagb/h6m3V0gNEA4h9b/kr7u9E7lGs5HZLcmYFkgH7NqnA+28fhkL
         34Vtun9AtDbd7FEhawjn91eiAdVrCsJXdHPAjdjIewpxkvSvfln2b+dwbCJDTL7vlGUM
         eMog==
X-Forwarded-Encrypted: i=1; AJvYcCW6f9N7CnqO9EuPEtX+HFqV5mvdq+jfUPzxQXUacpyScb7WJZGZDoFuQheKRhQ0daoTixYBsdmyixgmrz1GnVnWnBb2/2KcuT2a6eWr
X-Gm-Message-State: AOJu0YxsZ5uJZZiMB9AEFPgfV8CSgPSkU+DJvk7oFyhz5djYfBWdfCy3
	4CH6eo6O3UN17sFXdLh+4xdAqNvmp81vAbFiQq+pqjNH55Mxv8umf/PURzUP7ReijMTnSHbqm2z
	Ukv0ltgy2mrAaYn3EIRLP6gwD5gNfZBgsjc6AeUwvp8kNffL9h+8Mf8Y=
X-Google-Smtp-Source: AGHT+IGr0hHQ6y18QSOaLXHCP7x7QzlwM2AIUsPXH/QO9cXaiZZckSnoCE+HPdNDLKeAwCF+Zqj1Eseyup4s0wRLc1p8RaL7pFpJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d2:b0:474:3939:3920 with SMTP id
 i18-20020a05663813d200b0047439393920mr20427jaj.2.1708411274909; Mon, 19 Feb
 2024 22:41:14 -0800 (PST)
Date: Mon, 19 Feb 2024 22:41:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002be12a0611ca7ff8@google.com>
Subject: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in ima_add_template_entry
From: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ba81c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34924e0466d4/disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29d0b1935c61/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e033c3d8679/bzImage-4f5e5092.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x870 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x870 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x371/0x8d0 security/integrity/ima/ima_api.c:376
 process_measurement+0x2c6e/0x3ef0 security/integrity/ima/ima_main.c:367
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:91 [inline]
 sha256_transform_blocks+0xf33/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:92 [inline]
 sha256_transform_blocks+0xf7d/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:93 [inline]
 sha256_transform_blocks+0xfb5/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 LOAD_OP lib/crypto/sha256.c:56 [inline]
 sha256_transform lib/crypto/sha256.c:82 [inline]
 sha256_transform_blocks+0x2c35/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:85 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:251 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x125a/0x2520 lib/iov_iter.c:186
 copy_page_to_iter+0x419/0x870 lib/iov_iter.c:381
 copy_folio_to_iter include/linux/uio.h:181 [inline]
 filemap_read+0xbf4/0x14d0 mm/filemap.c:2654
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
 __kernel_read+0x724/0xce0 fs/read_write.c:434
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:975
 page_cache_ra_unbounded+0x2cc/0x960 mm/readahead.c:247
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0xe31/0xee0 mm/readahead.c:544
 ondemand_readahead+0x157d/0x1750 mm/readahead.c:666
 page_cache_sync_ra+0x724/0x760 mm/readahead.c:693
 page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
 filemap_get_pages+0x4c4/0x2bd0 mm/filemap.c:2498
 filemap_read+0x59e/0x14d0 mm/filemap.c:2594
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
 __kernel_read+0x724/0xce0 fs/read_write.c:434
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3643 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3798
 do_filp_open+0x20d/0x590 fs/namei.c:3825
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 9243 Comm: syz-executor.3 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

