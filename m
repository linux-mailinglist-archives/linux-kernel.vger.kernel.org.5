Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784F17A5C65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjISIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjISIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:21:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4AD115
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:21:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf55a81eeaso39621915ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695111670; x=1695716470; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rN1ww9vq1LmR6aSiynf/qj+WFxgaeMiakK6rHCBewo=;
        b=EqFuJ/7xZCH6SrEw4fdUU7217ojnsQYtMgfY52gQdoj/mk1Ja+oMDGoWu4HpAYy0Dc
         Q5Qq92amjctp0hMyXIpTgUm2YC1HrXXzCYVMD58ZdBkWMb6t5pjl37vmzmTZqNM2KQRK
         oRFk+ARjSkY8MAPWx89Lm/njuQ70BpOgl2eQOC9l4SAL0dsyY3YDXZa3Z6V8HyCX5Dk6
         lv/vstVZxQrOFnAPmqybGVOizvUO7iZ0+8v60p+w0OVHOsF64HbVfizNWYjxarmHLf+T
         emFLLBoEMrSwD5yNA46OtHmabswjAz7n+Ib99QXPLwzwJSvQheWR9k1y+az/BClbHuUd
         LQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111670; x=1695716470;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rN1ww9vq1LmR6aSiynf/qj+WFxgaeMiakK6rHCBewo=;
        b=XelwYYcUM3n+mt4G0ctZExiaPH4KsPWKzD7Gw22f4+LT283qSrIeP5PEih4N7z6vm+
         CDNNejkT70gwaVin+xswRA34dcY8xjLlbKHHXrnbsA/yMFrnl2feWh+lc2E6hqVpwujU
         ovCrmgOYCY6l8vJ1Lt+4gmiiLrT/eDybQkeruTH0LxGHipEbDdM3BckrgoyLRi1q4sgD
         334sCj3x2ogMCM+GDkJaKHQVcij5vczDwMl1+483HvOGRG629bhjCpJdMtjGqDHOq2OC
         ksyPRwFaydsUY0vClYPLIJVne5m3H8W8zcqLAEppa4plIIto6Vi8PYlNVZceH5m3u+Ng
         fh6w==
X-Gm-Message-State: AOJu0YypxuzujLoSGFHohFdXbqfgYOksuGdB+4ZLIB6uCUp3y3Uhnuun
        zvNgMGjOGoJDkSPSu1BMU5IVkV1v4qw=
X-Google-Smtp-Source: AGHT+IHhgJHzebDzjxuyJ/EPuzg8UH/caSuDWjBt4ITmN89BpRkmwSMcM9mvr14OPeyuIy3DuVmrxw==
X-Received: by 2002:a17:902:cecb:b0:1b9:f7dc:b4f6 with SMTP id d11-20020a170902cecb00b001b9f7dcb4f6mr10415392plg.44.1695111669669;
        Tue, 19 Sep 2023 01:21:09 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001bdc664ecd3sm6042225plc.307.2023.09.19.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:21:09 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com,
        syzkaller-bugs@googlegroups.com, qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
Date:   Tue, 19 Sep 2023 16:19:58 +0800
Message-Id: <20230919081958.7071-1-qiang.zhang1211@gmail.com>
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

This commit therefore flush pwq_release_worker before invoke
kfree(wq).

Reported-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..70200331a3cf 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4743,6 +4743,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_free_lockdep(wq);
 err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
+	if (wq->flags & WQ_UNBOUND)
+		kthread_flush_worker(pwq_release_worker);
 	kfree(wq);
 	return NULL;
 err_destroy:
-- 
2.17.1

