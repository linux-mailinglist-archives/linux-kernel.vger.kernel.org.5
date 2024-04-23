Return-Path: <linux-kernel+bounces-154802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7A8AE136
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2584B1F22C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7D5FB95;
	Tue, 23 Apr 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="zju6K1Vf"
Received: from out187-4.us.a.mail.aliyun.com (out187-4.us.a.mail.aliyun.com [47.90.187.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CD59148;
	Tue, 23 Apr 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865374; cv=none; b=N7nRpR7edyudvCbaSlzZhqdttfMh7co644PAS/3Yvm2twY/8Tq0FZonH5YYV5KCnXRN1wmg9HXGHS4H8cd5f4qeTZRovZ9wMuJZXke1SByahZ8sRO1byoVIUZWFGcyg06sOMi4LfmSiJs1XiLri4wxapcbPq8xiwp0ZIv7Mnvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865374; c=relaxed/simple;
	bh=9e3zz2vdIgjObMpzkDW7FZcgOJIxeoqT6M30B1aspn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bL6YN9+RRM7QvKTYWA3G5aRl4rXrm8iEFN7K8gvcrzuXNQv9IvF4+wUxpgmm7nTUbPRtnz3meCBZVHzx64tNixLyR3gHbD1rQtXB8ehMAH7oR5/f2WMM6HFHvcWW9BKF/5RP/ZvfEeLt7TKSj3sH3f6HfwlhyUHSDTcFtVJPgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=zju6K1Vf; arc=none smtp.client-ip=47.90.187.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713865359; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eRmZ9jEKUfe7r0xjaXFGSIKeohTP9cOqduT19L33uX0=;
	b=zju6K1VfUsO56VJPbdPHuXBWD27e5sYhNer8g9cAM9PkwTuvvf88SG9JJSiMks6tocFF4Ym0KC6mg1ihqOG60HwBsILZ75BUoltfXMqiBpbFnChNCc+Vf02NOEgWjNES3s3xZkxNJSSo3UMD76Dvi2xgblLvRdRB6BRXFNLliJE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XJPn8AG_1713864416;
Received: from localhost(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XJPn8AG_1713864416)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 17:27:02 +0800
From: "=?UTF-8?B?5pyx5Lyv5ZCbKOadsOmTrSk=?=" <zhubojun.zbj@antgroup.com>
To: linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com
Cc:  <reinette.chatre@intel.com>,
  "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>,
  "=?UTF-8?B?5pyx5Lyv5ZCbKOadsOmTrSk=?=" <zhubojun.zbj@antgroup.com>
Subject: [RFC PATCH 1/1] x86/sgx: Explicitly give up the CPU in EDMM's ioctl() to avoid softlockup
Date: Tue, 23 Apr 2024 17:25:50 +0800
Message-Id: <20240423092550.59297-2-zhubojun.zbj@antgroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
References: <20240423092550.59297-1-zhubojun.zbj@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EDMM's ioctl()s support batch operations, which may be
time-consuming. Try to explicitly give up the CPU at
the every end of "for loop" in
sgx_enclave_{ modify_types | restrict_permissions | remove_pages}
to give other tasks a chance to run, and avoid softlockup warning.

The following has been observed on Linux v6.9-rc5 with kernel
preemptions disabled(by configuring "PREEMPT_NONE=y"), when kernel
is requested to restrict page permissions of a large number of EPC pages.

    ------------[ cut here ]------------
    watchdog: BUG: soft lockup - CPU#45 stuck for 22s! [occlum-run:3905]
    ...
    CPU: 45 PID: 3905 Comm: occlum-run Not tainted 6.9.0-rc5 #7
    ...
    RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
    Code: 48 c1 e6 05 48 89 d1 48 8d 5c 24 40 b8 0e 00 00 00 48 2b 8e 70 8e f5 93 48 c1 e9 05 48 c1 e1 0c 48 03 8e 68 8e f5 93 0f 01 cf <a9> 00 00 00 40 0f 85 b2 00 00 00 85 c0 0f 85 db 00 00 00 4c 89 ef
    RSP: 0018:ffffb55a6591fa80 EFLAGS: 00000202
    RAX: 0000000000000000 RBX: ffffb55a6591fac0 RCX: ffffb581e7384000
    RDX: ffffb59a9e4e8080 RSI: 0000000000000020 RDI: ffff91d69e8cc000
    RBP: ffffb55a6591fb70 R08: 0000000000000002 R09: ffff91d646e12be0
    R10: 000000000000006e R11: 0000000000000002 R12: 000000072052d000
    R13: ffff91d69e8cc000 R14: ffffb55a6591fbd8 R15: ffff91d69e8cc020
    FS:  00007fe10dbda740(0000) GS:ffff92163e480000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fc041811000 CR3: 00000040d95c8005 CR4: 0000000000770ef0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
    PKRU: 55555554
    Call Trace:
     <IRQ>
     ? show_regs+0x67/0x70
     ? watchdog_timer_fn+0x1f3/0x280
     ? __pfx_watchdog_timer_fn+0x10/0x10
     ? __hrtimer_run_queues+0xc8/0x220
     ? hrtimer_interrupt+0x10c/0x250
     ? __sysvec_apic_timer_interrupt+0x53/0x130
     ? sysvec_apic_timer_interrupt+0x7b/0x90
     </IRQ>
     <TASK>
     ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
     ? sgx_enclave_restrict_permissions+0xba/0x1f0
     ? __pte_offset_map_lock+0x94/0x110
     ? sgx_encl_test_and_clear_young_cb+0x40/0x60
     sgx_ioctl+0x1ab/0x900
     ? do_syscall_64+0x79/0x110
     ? apply_to_page_range+0x14/0x20
     ? sgx_encl_test_and_clear_young+0x6c/0x80
     ? sgx_vma_fault+0x132/0x4f0
     __x64_sys_ioctl+0x95/0xd0
     x64_sys_call+0x1209/0x20c0
     do_syscall_64+0x6d/0x110
     ? do_syscall_64+0x79/0x110
     ? do_pte_missing+0x2e8/0xcc0
     ? __pte_offset_map+0x1c/0x190
     ? __handle_mm_fault+0x7b9/0xe60
     ? __count_memcg_events+0x70/0x100
     ? handle_mm_fault+0x256/0x360
     ? do_user_addr_fault+0x3c1/0x860
     ? irqentry_exit_to_user_mode+0x67/0x190
     ? irqentry_exit+0x3b/0x50
     ? exc_page_fault+0x89/0x180
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7fe10e2ee5cb
    Code: 0f 1e fa 48 8b 05 c5 78 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 78 0d 00 f7 d8 64 89 01 48
    RSP: 002b:00007fffb2c75518 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
    RAX: ffffffffffffffda RBX: 0000000780000000 RCX: 00007fe10e2ee5cb
    RDX: 00007fffb2c75520 RSI: 00000000c028a405 RDI: 0000000000000005
    RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fffb2c75594
    R10: 00007fffb2c755c8 R11: 0000000000000246 R12: 00000000c028a405
    R13: 00007fffb2c75520 R14: 0000000780000000 R15: 00007fe10e1a7980
     </TASK>
     ------------[ end trace ]------------

Signed-off-by: Bojun Zhu <zhubojun.zbj@antgroup.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..2340a82fa796 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -806,6 +806,9 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
 		}
 
 		mutex_unlock(&encl->lock);
+
+		if (need_resched())
+			cond_resched();
 	}
 
 	ret = 0;
@@ -1010,6 +1013,9 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 		entry->type = page_type;
 
 		mutex_unlock(&encl->lock);
+
+		if (need_resched())
+			cond_resched();
 	}
 
 	ret = 0;
@@ -1156,6 +1162,9 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 		kfree(entry);
 
 		mutex_unlock(&encl->lock);
+
+		if (need_resched())
+			cond_resched();
 	}
 
 	ret = 0;
-- 
2.25.1


