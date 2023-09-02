Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2957907A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352059AbjIBLug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIBLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:50:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259C8E6A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:50:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a56401b9aso2306471b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693655431; x=1694260231; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btdwJhsI6UftkpBbIga5OM0XK3JpNEHNxR05ThjivyA=;
        b=rZ8n1XS15n8EVg3euiE+d35Easc/9sB4VjcDEyuLCx7wxXmQOFItfZumPeOXjjAG4q
         RH/hkkvKaW5ZXFxF6DepWmAF+QrvxPViWFYKQtHTsVBIbFNGksRIpKZdBciPzt11dBKo
         dggDLWJqo3dzDXRaHZKLYR03cO+g3PK7PqVv07PK2PiS+hsnP/w29b6F8q5i+QV+QQGR
         JRpvILWBTo0vNMC3e9OudnF8OM3ojLiOyWJRDkVdpX3ZWNG+XRceXtaxaPUlACLsI0dd
         bNo25JrDmvEZSqHLNhH/3IfnnS9tEQScd8Q/PTGBPRkOgmmuDMTtsutrt/P3v9/h183V
         67AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655431; x=1694260231;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btdwJhsI6UftkpBbIga5OM0XK3JpNEHNxR05ThjivyA=;
        b=lnH2tKy9LBV+jUPeUwXzFqyETW1g6msCytlvSVmDyD/uFT+lw48ciFAtzxfPmKLI/v
         xTyarXaLEdcoy3J1vIIpL2fdTTPV1BT8ntqID0CVzFsoctVQHNEpGN36YKP5yg74B/Uu
         S6Glh8eSMHNrT1SlbVT7yQIPyexqf7SialGdG4jzkuYhPewBKMEOyAQcWRWvUc2FxYJi
         NKbAArGSaTzPPgEW73Igf3VvwuJA102+6vWByGL39pWHu15JbqINZQx0JIMQzSHgh9Dy
         pyHSGrFXpcyrLa72w5zAKc+ZpdIFtgVKTMvpBKFKk4C9mj02VCB50BqzdSdVfeBfQvhS
         A/iA==
X-Gm-Message-State: AOJu0YwdZGtWlALM3lW1mxSUGA2I7++cMe2Y7sORu1wppOv3Kt/vNsFg
        Rqix1rD3NzzLfvvbl8INBWoN4rwW8u8=
X-Google-Smtp-Source: AGHT+IFG/hdtYmU3REWAIQL/gUqu0SAr+lyJ/DmGC/fPVND5sjG/9P3DJCCYJC6f3dKpJkFomiKHqQ==
X-Received: by 2002:a05:6a00:a07:b0:68b:bd56:c783 with SMTP id p7-20020a056a000a0700b0068bbd56c783mr5909433pfh.22.1693655431487;
        Sat, 02 Sep 2023 04:50:31 -0700 (PDT)
Received: from MSCND1355B05.nio.com ([124.126.151.50])
        by smtp.gmail.com with ESMTPSA id d15-20020aa78e4f000000b0068bade042besm4463337pfr.48.2023.09.02.04.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 04:50:31 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
Date:   Sat,  2 Sep 2023 19:50:26 +0800
Message-Id: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for UNBOUND workqueue allocation failure, the
apply_wqattr_cleanup() will be called and use the pwq_release_worker
kthread to release resources asynchronously. however, the kfree(wq)
is invoked directly in failure path of alloc_workqueue(), this leads
to the following scenario:

BUG: KASAN: slab-use-after-free in pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
Read of size 4 at addr ffff888027b831c0 by task pool_workqueue_/3

CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
 kthread_worker_fn+0x2fc/0xa80 kernel/kthread.c:823
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5054:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_workqueue+0x16f/0x1490 kernel/workqueue.c:4684
 kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
 kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
 kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
 kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5054:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 alloc_workqueue+0xe76/0x1490 kernel/workqueue.c:4746
 kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
 kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
 kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
 kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

This commit therefore only direct release resources when the
!UNBOUND workqueue allocation failure.

Reported-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..f3f9c9222070 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4609,6 +4609,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 		free_percpu(wq->cpu_pwq);
 		wq->cpu_pwq = NULL;
 	}
+	wq_unregister_lockdep(wq);
+	wq_free_lockdep(wq);
+	free_workqueue_attrs(wq->unbound_attrs);
+	kfree(wq);
 	return -ENOMEM;
 }
 
@@ -4712,7 +4716,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->list);
 
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_unreg_lockdep;
+		return NULL;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4738,11 +4742,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
-err_unreg_lockdep:
-	wq_unregister_lockdep(wq);
-	wq_free_lockdep(wq);
 err_free_wq:
-	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
 err_destroy:
-- 
2.17.1

