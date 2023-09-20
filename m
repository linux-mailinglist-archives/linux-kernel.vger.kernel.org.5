Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2D7A7287
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjITGHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITGHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:07:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC118F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:07:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-570a432468bso400230a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695190032; x=1695794832; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouAZ40qYhyMLl0VsSuL25OrolKhfRz4aLVqyhzGAO+o=;
        b=cDU2QQ2IuW7J9fQw41IHKzad02p7oP7+RfeTBK+kUKirwK6MKXUmxIji8kI5cRDnMR
         EDj1WXKIEhfSXq1ETNY4vt2Q7AOp09Dg8XfNyPUUmmfgOZjda6TCQsrWkx99OB/Fu8It
         +ThpHXPxowf7AcIICOUURyOHC+j7SuYlqlnxNVD2kEBh/rq2Hd4d6DivuuvbFKPYws4M
         r/UrDZa+NF3cd16zuj2JkeA8ECIRTPgGpUThOO9LK7KKdyG8Vf6U2b+MHOtRL5hCaxP7
         y2rIT2yMJWCWT3t2tqoFvychKRd6HtBL/gQ+FC6LT49JLLv8dEDJMy342Luf2aRXFKz9
         PbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695190032; x=1695794832;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouAZ40qYhyMLl0VsSuL25OrolKhfRz4aLVqyhzGAO+o=;
        b=h5SuRT+/jrsm57OYv7YiyvaGcUhdtHZCUIIyrRLvUju9gd5MvQ6YJXPo//KGrJ/nZ9
         OUrCn8VZ8SSYGVGLWXNbZx9bc1VqrkCe61ZVeLNxC3qvf+GrYXuRFI3fmcKp77TrJMc/
         2Q0DSpciatSRTSdirI9ec5o6NIRVROvBL8kR4M+OjG1EBp+sn+ZqrVi1LU61PGfAACp8
         XVdlg78t3VppzZ6yuEAJJdz33bc6etY8IBy0FS2rUj5YmcH+N8S5cwk2Vlc/WkceLCPe
         3Phjdd1nr7jaOcVgVK14Y74/H8NUwAnatliufnx+gl4peXMUjIS3ZxaMhVajEKjSJWZn
         EU+g==
X-Gm-Message-State: AOJu0YxQgShFx7XlmEmwF8e/I7Tlz4HcK2qJkoAyeXxrV8hh4sM2NNcB
        HKxmKG9poWGP+ZGQYByMPBfXjn+Vn+4=
X-Google-Smtp-Source: AGHT+IGCzf1AWZVQ5CeZspFEfknvQDBqLRSMfum/WCw5ibpGLQAauYwTGzz5trDWednUzuFiCMIung==
X-Received: by 2002:a17:90b:3b45:b0:274:ac60:1d57 with SMTP id ot5-20020a17090b3b4500b00274ac601d57mr6017163pjb.16.1695190032471;
        Tue, 19 Sep 2023 23:07:12 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id p30-20020a63951e000000b005740aa41237sm1661869pgd.74.2023.09.19.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:07:12 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        qiang.zhang1211@gmail.com
Subject: [PATCH v3] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
Date:   Wed, 20 Sep 2023 14:07:04 +0800
Message-Id: <20230920060704.24981-1-qiang.zhang1211@gmail.com>
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

Currently, for UNBOUND wq, if the apply_wqattrs_prepare() return error,
the apply_wqattr_cleanup() will be called and use the pwq_release_worker
kthread to release resources asynchronously. however, the kfree(wq) is
invoked directly in failure path of alloc_workqueue(), if the kfree(wq)
has been executed and when the pwq_release_workfn() accesses wq, this
leads to the following scenario:

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

This commit therefore flush pwq_release_worker in the alloc_and_link_pwqs()
before invoke kfree(wq).

Reported-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..2e1a9ad0eab1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4600,6 +4600,12 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	}
 	cpus_read_unlock();
 
+	/* for unbound pwq, flush the pwq_release_worker ensures that the
+	 * pwq_release_workfn() completes before calling kfree(wq).
+	 */
+	if (ret)
+		kthread_flush_worker(pwq_release_worker);
+
 	return ret;
 
 enomem:
-- 
2.17.1

