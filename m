Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8C810EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378038AbjLMKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378280AbjLMKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:50:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B377137
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:59 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-333501e22caso5367917f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702464597; x=1703069397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvphrLDI5RQ5nFc13YBnIyEMEkpX1p+cTGWawZT8ehM=;
        b=oAHXBTGczdHDae1TPHdxmc+w5e54ZSaRcg8n3GDNkhbN6eaNx/PPjHK521p+InPjV1
         XQNUjpijo7MeFT1DOs2scjo2BaZuwfVgZA+6FrW2SDzuLQ83Tb99kGTs9tyk1SHNgwhV
         /ECB+ACfVFiLrN95o1ymJ2dVVVUxmBoCb3KOUci4TvAxK8xMI5zzBaasBZph9/xsx98U
         Vjv8opPtQyY8hIfqq1iqg6uGfZdVOoBfd1RlhDn5LpXVOh2zQpK5VXkanRctc/aOFAxt
         GJINmqyFkFHLE5hOFoQXUrU+oG/eYeSJxDLXdXX0MpV7t6/Gme/cVnRiNnZXplZqdPc8
         mDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464597; x=1703069397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvphrLDI5RQ5nFc13YBnIyEMEkpX1p+cTGWawZT8ehM=;
        b=LOgEb7BsCJBEXKIL0D+s5euvltKYV/RsglN/kLfmKoCLwPWa3nlPFEFTDF3y7d8x9k
         mDwUBA05Ky3moV9qB7bhE4uiHS9xqP4h7R0mJOg8596DGa12EqYa7UfB8H1L5eGVtuq1
         jW0QEVNhEBZhT2za4h0eFj9fVurP796oC+79kKR1kaSVlYQC4TMjlpe/6Z2SFsetzQGP
         ko4pneazD8jOKye6ScSCOtMk936c/ZoL7krGOF4b93XiNM6BLciqmtAb+V9w6FR1XJ4m
         ZeN9IY3FMvigLkYEGJyjrL8oXv2rCpdmk/BBiC5NStqS4WllAcKWGBwycQAMILO2zqO8
         IPIw==
X-Gm-Message-State: AOJu0YwusSJKYlkHD+P8GtDdn+UW7N1N6O7sB217hZC6oDW4b4dzaQYT
        s/MdeRRXlW3846ckzmCit1WuZ6is3Fk=
X-Google-Smtp-Source: AGHT+IHJNboIza5sOkyW303Eqqiw2ohw17dzYwP9c+jaxkv2SAsbNVKOqUHIq9rjRags8Fcu+gFlpAIxyr0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:55f2:8a28:bfd8:42d1])
 (user=glider job=sendgmr) by 2002:a5d:64a5:0:b0:333:3402:7f72 with SMTP id
 m5-20020a5d64a5000000b0033334027f72mr39047wrp.7.1702464596450; Wed, 13 Dec
 2023 02:49:56 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:49:50 +0100
In-Reply-To: <000000000000f66a3005fa578223@google.com>
Mime-Version: 1.0
References: <000000000000f66a3005fa578223@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213104950.1587730-1-glider@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
From:   Alexander Potapenko <glider@google.com>
To:     syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
        dchinner@redhat.com
Cc:     davem@davemloft.net, glider@google.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Dave,

The repro provided by Xingwei indeed works.

I tried adding kmsan_check_memory(data, write_len) to xlog_write_iovec(), and
it reported an uninitialized hole inside the `data` buffer:

kmalloc-ed xlog buffer of size 512 : ffff88802fc26200
kmalloc-ed xlog buffer of size 368 : ffff88802fc24a00
kmalloc-ed xlog buffer of size 648 : ffff88802b631000
kmalloc-ed xlog buffer of size 648 : ffff88802b632800
kmalloc-ed xlog buffer of size 648 : ffff88802b631c00
xlog_write_iovec: copying 12 bytes from ffff888017ddbbd8 to ffff88802c300400
xlog_write_iovec: copying 28 bytes from ffff888017ddbbe4 to ffff88802c30040c
xlog_write_iovec: copying 68 bytes from ffff88802fc26274 to ffff88802c300428
xlog_write_iovec: copying 188 bytes from ffff88802fc262bc to ffff88802c30046c
=====================================================
BUG: KMSAN: uninit-value in xlog_write_iovec fs/xfs/xfs_log.c:2227
BUG: KMSAN: uninit-value in xlog_write_full fs/xfs/xfs_log.c:2263
BUG: KMSAN: uninit-value in xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_write_iovec fs/xfs/xfs_log.c:2227
 xlog_write_full fs/xfs/xfs_log.c:2263
 xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_cil_write_chain fs/xfs/xfs_log_cil.c:918
 xlog_cil_push_work+0x30f2/0x44e0 fs/xfs/xfs_log_cil.c:1263
 process_one_work kernel/workqueue.c:2630
 process_scheduled_works+0x1188/0x1e30 kernel/workqueue.c:2703
 worker_thread+0xee5/0x14f0 kernel/workqueue.c:2784
 kthread+0x391/0x500 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x101/0xac0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3482
 __kmem_cache_alloc_node+0x612/0xae0 mm/slub.c:3521
 __do_kmalloc_node mm/slab_common.c:1006
 __kmalloc+0x11a/0x410 mm/slab_common.c:1020
 kmalloc ./include/linux/slab.h:604
 xlog_kvmalloc fs/xfs/xfs_log_priv.h:704
 xlog_cil_alloc_shadow_bufs fs/xfs/xfs_log_cil.c:343
 xlog_cil_commit+0x487/0x4dc0 fs/xfs/xfs_log_cil.c:1574
 __xfs_trans_commit+0x8df/0x1930 fs/xfs/xfs_trans.c:1017
 xfs_trans_commit+0x30/0x40 fs/xfs/xfs_trans.c:1061
 xfs_create+0x15af/0x2150 fs/xfs/xfs_inode.c:1076
 xfs_generic_create+0x4cd/0x1550 fs/xfs/xfs_iops.c:199
 xfs_vn_create+0x4a/0x60 fs/xfs/xfs_iops.c:275
 lookup_open fs/namei.c:3477
 open_last_lookups fs/namei.c:3546
 path_openat+0x29ac/0x6180 fs/namei.c:3776
 do_filp_open+0x24d/0x680 fs/namei.c:3809
 do_sys_openat2+0x1bc/0x330 fs/open.c:1440
 do_sys_open fs/open.c:1455
 __do_sys_openat fs/open.c:1471
 __se_sys_openat fs/open.c:1466
 __x64_sys_openat+0x253/0x330 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51
 do_syscall_64+0x4f/0x140 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b arch/x86/entry/entry_64.S:120

Bytes 112-115 of 188 are uninitialized
Memory access of size 188 starts at ffff88802fc262bc

CPU: 1 PID: 1061 Comm: kworker/u9:6 Tainted: G    B              6.7.0-rc3-gcaca734ed6a9-dirty #112
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: xfs-cil/loop0 xlog_cil_push_work
=====================================================

Do you know if this is expected?
