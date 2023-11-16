Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD35B7EE0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKPMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:30:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD618B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:30:27 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bdf5a025c1so533316a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700137826; x=1700742626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnxwgdyERbu++62px0Gtodzac4wTdQLjOX0jeYxZvqs=;
        b=o12K6pYpYhZ4KL4D7HmNm4zRg/0LrK8zLIolQRZCFWOGlxHbrV+7xW1nvya4+/NMtI
         0JDBSp8QzNt5+1SnaZ3PSq+szpCvub5tMDurm4uOLmmsrMB8thPzL3BpXIpHhQmZ+UBG
         EJGbRF4IXUUIyLKI4BjMcGl+aEVrbObIJcZ0o22iGtf3ra8LXCzBQNvWRXIoRRjW9Hxu
         FWBv7kWSlA3Zv0l9pIQKCnp+d6TxBafe1eP6XwMfKrGoYtn/WWXLlOH46AA1cILcwf4/
         sbRXmaXzR7h0HcSrGDa1pm6bjSpSQ6/VCiGzoYF+0fwEGRi8VB4ORFznS1p3scIzOVAu
         xkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700137826; x=1700742626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnxwgdyERbu++62px0Gtodzac4wTdQLjOX0jeYxZvqs=;
        b=Kx1qAHgKSdXJRNoZskjaxGy9cNFFBLldcfCumIhwp6v6MG3iCJa5aVAuXFBfbuUKzT
         hhZSHa1EMiwhby5KOlWnOgqQoCD5Cze44hYDLWkymXAf8eavtYh0MyXmrdJCzJHY179D
         5Tod2k6wuRmhxUog4v+Rtz5CBla4FpCkH09+UvG40c2L8vNjt33QNXYv6mRvqRfaD7nw
         KWepGt3Z/cIBQcZvH0xCyQInTqkIN0l6eH9fpgOyMLwC/JVTqZOzkJcvSKqQoBjBkj6r
         jn3uXjwLPStF4JCe9l9ZdEE8+aA47B9o77qHnMOe1xF3RvH4IUgX7sTsKufzD5PgGFq7
         WDDQ==
X-Gm-Message-State: AOJu0YxYSRffzXxh8kXoNoRGv0gofe9XO6DkYzY5g+Ot1hFqUn+SlR2X
        918ADALRmqeHPij6edAe9gLegA==
X-Google-Smtp-Source: AGHT+IHxiRmIbqxivJ5TnqJhPEoGk+hm1V/d0PdwMMlNWq3lbC2L5GlfqO0bYl7di3H2bQ15d+BpqQ==
X-Received: by 2002:a17:90b:390c:b0:280:29e8:4379 with SMTP id ob12-20020a17090b390c00b0028029e84379mr14423388pjb.34.1700137826459;
        Thu, 16 Nov 2023 04:30:26 -0800 (PST)
Received: from localhost.localdomain ([49.206.54.243])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001c5fc291ef9sm9112908plg.209.2023.11.16.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:30:25 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, mark.rutland@arm.com, rostedt@goodmis.org,
        lkft@linaro.org
Subject: selftests: ftrace: WARNING: __list_del_entry_valid_or_report (lib/list_debug.c:62 (discriminator 1))
Date:   Thu, 16 Nov 2023 18:00:16 +0530
Message-Id: <20231116123016.140576-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed while running selftests: ftrace on arm64 Juno-r2
device running stable-rc linux-6.6.y kernel.

This kernel crash is hard to reproduce.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in ftrace
TAP version 13
1..1
# timeout set to 0
# selftests: ftrace: ftracetest-ktap
# unlink: cannot unlink '/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file or directory
# TAP version 13
# 1..130
# ok 1 Basic trace file check
...
# ok 44 ftrace - test for function traceon/off triggers
# ok 45 ftrace - test tracing error log support
[  617.613901] ------------[ cut here ]------------
[  617.618870] list_del corruption. prev->next should be ffff000837184758, but was ffff000837184638. (prev=ffff0008359f82e8)
[  617.629894] WARNING: CPU: 1 PID: 13512 at lib/list_debug.c:62 __list_del_entry_valid_or_report (lib/list_debug.c:62 (discriminator 1)) 
[  617.639496] Modules linked in: onboard_usb_hub hdlcd tda998x crct10dif_ce drm_dma_helper cec drm_kms_helper fuse drm backlight dm_mod ip_tables x_tables [last unloaded: trace_printk]
[  617.655832] CPU: 1 PID: 13512 Comm: ls Not tainted 6.6.2-rc1 #1
[  617.661765] Hardware name: ARM Juno development board (r2) (DT)
[  617.667692] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  617.674668] pc : __list_del_entry_valid_or_report (lib/list_debug.c:62 (discriminator 1)) 
[  617.680339] lr : __list_del_entry_valid_or_report (lib/list_debug.c:62 (discriminator 1)) 
[  617.686009] sp : ffff80008507b910
[  617.689325] x29: ffff80008507b910 x28: 0000000000000003 x27: 0000000000000001
[  617.696482] x26: ffff000834694788 x25: ffff000835a39c88 x24: 0000000000000000
[  617.703637] x23: 0000000000000000 x22: ffff0008359f8248 x21: ffff000837184720
[  617.710792] x20: ffff0008359f8248 x19: ffff000837184758 x18: 0000000000000010
[  617.717948] x17: 20747562202c3835 x16: 3734383137333830 x15: 3030666666662065
[  617.725102] x14: 6220646c756f6873 x13: 2938653238663935 x12: 3338303030666666
[  617.732257] x11: 663d766572702820 x10: 2e38333634383137 x9 : ffff800080145634
[  617.739411] x8 : ffff80008507b638 x7 : 0000000000017fe8 x6 : 0000000000057fa8
[  617.746566] x5 : 0000000000000fff x4 : ffff00097ed27d50 x3 : ffff8008fc5d3000
[  617.753720] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008010722c0
[  617.760874] Call trace:
[  617.763320] __list_del_entry_valid_or_report (lib/list_debug.c:62 (discriminator 1)) 
[  617.768643] __dentry_kill (include/linux/list.h:215 (discriminator 1) fs/dcache.c:550 (discriminator 1) fs/dcache.c:603 (discriminator 1)) 
[  617.772311] dput (fs/dcache.c:896) 
[  617.775281] create_dentry (fs/tracefs/event_inode.c:404) 
[  617.779040] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:536) 
[  617.783580] do_dentry_open (fs/open.c:929) 
[  617.787424] vfs_open (fs/open.c:1064) 
[  617.790572] path_openat (fs/namei.c:3640 fs/namei.c:3797) 
[  617.794153] do_filp_open (fs/namei.c:3824) 
[  617.797733] do_sys_openat2 (fs/open.c:1422) 
[  617.801490] __arm64_sys_openat (fs/open.c:1448) 
[  617.805508] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:56) 
[  617.809267] el0_svc_common.constprop.0 (include/linux/thread_info.h:127 (discriminator 2) arch/arm64/kernel/syscall.c:144 (discriminator 2)) 
[  617.814069] do_el0_svc (arch/arm64/kernel/syscall.c:156) 
[  617.817391] el0_svc (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679) 
[  617.820454] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697) 
[  617.824820] el0t_64_sync (arch/arm64/kernel/entry.S:595) 
[  617.828488] ---[ end trace 0000000000000000 ]---
[  617.833214] ------------[ cut here ]------------
[  617.837840] WARNING: CPU: 2 PID: 13523 at fs/dcache.c:365 dentry_free (fs/dcache.c:365 (discriminator 1)) 
[  617.845173] Modules linked in: onboard_usb_hub hdlcd tda998x crct10dif_ce drm_dma_helper cec drm_kms_helper fuse drm backlight dm_mod ip_tables x_tables [last unloaded: trace_printk]
[  617.861503] CPU: 2 PID: 13523 Comm: rmdir Tainted: G        W          6.6.2-rc1 #1
[  617.869175] Hardware name: ARM Juno development board (r2) (DT)
[  617.875102] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  617.882077] pc : dentry_free (fs/dcache.c:365 (discriminator 1)) 
[  617.885835] lr : __dentry_kill (fs/dcache.c:623) 
[  617.889937] sp : ffff800085123a30
[  617.893252] x29: ffff800085123a30 x28: ffff0008371845a8 x27: ffff0008371845a8
[  617.900409] x26: ffff000837184600 x25: ffff000837184638 x24: ffff0008359f82a0
[  617.907565] x23: ffff000835a39d28 x22: ffff0008359f8248 x21: ffff000837184720
[  617.914719] x20: ffff0008359f8248 x19: ffff0008371846c8 x18: 0000000000000000
[  617.921874] x17: 000000040044ffff x16: 00500074b5503510 x15: 0000000000000000
[  617.929029] x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
[  617.936184] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000c00 x9 : ffff80008042bce0
[  617.943339] x8 : ffff800085123968 x7 : 0000000000000000 x6 : 00000000000001fb
[  617.950493] x5 : 0000000000000001 x4 : ffff80008328f000 x3 : ffff80008328f2e8
[  617.957647] x2 : 0000000000000002 x1 : ffff80008042bcd8 x0 : ffff800080428e90
[  617.964801] Call trace:
[  617.967246] dentry_free (fs/dcache.c:365 (discriminator 1)) 
[  617.970656] __dentry_kill (fs/dcache.c:623) 
[  617.974409] dput (fs/dcache.c:896) 
[  617.977380] simple_recursive_removal (include/linux/fs.h:807 fs/libfs.c:552) 
[  617.982008] eventfs_remove (fs/tracefs/event_inode.c:946) 
[  617.985679] remove_event_file_dir (include/linux/list.h:124 include/linux/list.h:215 include/linux/list.h:229 kernel/trace/trace_events.c:1017) 
[  617.989958] event_trace_del_tracer (kernel/trace/trace_events.c:3620 (discriminator 3) kernel/trace/trace_events.c:3772 (discriminator 3)) 
[  617.994324] __remove_instance (kernel/trace/trace.c:9682 kernel/trace/trace.c:9663) 
[  617.998344] instance_rmdir (kernel/trace/trace.c:9741) 
[  618.002010] tracefs_syscall_rmdir (fs/tracefs/inode.c:134) 
[  618.006289] vfs_rmdir (fs/namei.c:4204 fs/namei.c:4181) 
[  618.009608] do_rmdir (fs/namei.c:4263 (discriminator 1)) 
[  618.012928] __arm64_sys_unlinkat (fs/namei.c:4441 (discriminator 2) fs/namei.c:4435 (discriminator 2) fs/namei.c:4435 (discriminator 2)) 
[  618.017118] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:56) 
[  618.020876] el0_svc_common.constprop.0 (include/linux/thread_info.h:127 (discriminator 2) arch/arm64/kernel/syscall.c:144 (discriminator 2)) 
[  618.025678] do_el0_svc (arch/arm64/kernel/syscall.c:156) 
[  618.029000] el0_svc (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679) 
[  618.032060] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697) 
[  618.036427] el0t_64_sync (arch/arm64/kernel/entry.S:595) 
[  618.040094] ---[ end trace 0000000000000000 ]---
[  618.071010] Unable to handle kernel execute from non-executable memory at virtual address ffff000835b0b758
[  618.080715] Mem abort info:
[  618.083536]   ESR = 0x000000008600000f
[  618.087306]   EC = 0x21: IABT (current EL), IL = 32 bits
[  618.092646]   SET = 0, FnV = 0
[  618.095717]   EA = 0, S1PTW = 0
[  618.098869]   FSC = 0x0f: level 3 permission fault
[  618.103680] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000826a6000
[  618.110405] [ffff000835b0b758] pgd=18000009ffdf8003, p4d=18000009ffdf8003, pud=18000009ffa0e003, pmd=18000009ff860003, pte=00680008b5b0b707
[  618.123000] Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
[  618.129287] Modules linked in: onboard_usb_hub hdlcd tda998x crct10dif_ce drm_dma_helper cec drm_kms_helper fuse drm backlight dm_mod ip_tables x_tables [last unloaded: trace_printk]
[  618.145624] CPU: 2 PID: 13523 Comm: rmdir Tainted: G        W          6.6.2-rc1 #1
[  618.153298] Hardware name: ARM Juno development board (r2) (DT)
[  618.159225] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  618.166203] pc : 0xffff000835b0b758
[  618.169703] lr : rcu_core (arch/arm64/include/asm/preempt.h:13 (discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1) kernel/rcu/tree.c:2403 (discriminator 1)) 
[  618.173377] sp : ffff80008394be60
[  618.176692] x29: ffff80008394be60 x28: ffff0008278e3400 x27: 000000000000000a
[  618.183848] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80008394bf10
[  618.191003] x23: ffff800082752008 x22: ffff80008328ea80 x21: ffff80008332f700
[  618.198157] x20: ffff00097ed59440 x19: 0000000000000001 x18: 0000000000000000
[  618.205311] x17: ffff8008fc5f2000 x16: ffff800083948000 x15: 0000000000000000
[  618.212468] x14: 0000000000000000 x13: 0000000000000030 x12: 00000000000163f1
[  618.219627] x11: 0000000000000001 x10: 000000010001369b x9 : ffff800080174e34
[  618.226782] x8 : ffff80008394bd98 x7 : 0000000000000000 x6 : 0000000000000100
[  618.233939] x5 : 0000000000000100 x4 : ffff80008328f000 x3 : ffff80008328f2e8
[  618.241100] x2 : 0000000000000000 x1 : ffff000835b0b758 x0 : ffff000837184778
[  618.248257] Call trace:
[  618.250707]  0xffff000835b0b758
[  618.253851] rcu_core_si (kernel/rcu/tree.c:2421) 
[  618.257261] __do_softirq (arch/arm64/include/asm/jump_label.h:21 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
[  618.260929] ____do_softirq (arch/arm64/kernel/irq.c:81) 
[  618.264597] call_on_irq_stack (arch/arm64/kernel/entry.S:892) 
[  618.268527] do_softirq_own_stack (arch/arm64/kernel/irq.c:86) 
[  618.272717] irq_exit_rcu (arch/arm64/include/asm/percpu.h:44 kernel/softirq.c:612 kernel/softirq.c:634 kernel/softirq.c:644) 
[  618.276299] el1_interrupt (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/entry-common.c:246 arch/arm64/kernel/entry-common.c:505 arch/arm64/kernel/entry-common.c:517) 
[  618.279883] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523) 
[  618.283989] el1h_64_irq (arch/arm64/kernel/entry.S:591) 
[  618.287394] __srcu_read_unlock (kernel/rcu/srcutree.c:730) 
[  618.291409] srcu_gp_start_if_needed (kernel/rcu/srcutree.c:1298) 
[  618.296034] call_srcu (kernel/rcu/srcutree.c:1362) 
[  618.299266] eventfs_remove_rec (fs/tracefs/event_inode.c:921) 
[  618.303286] eventfs_remove_rec (fs/tracefs/event_inode.c:909 (discriminator 5)) 
[  618.307303] eventfs_remove (fs/tracefs/event_inode.c:939) 
[  618.310973] remove_event_file_dir (include/linux/list.h:124 include/linux/list.h:215 include/linux/list.h:229 kernel/trace/trace_events.c:1017) 
[  618.315252] event_trace_del_tracer (kernel/trace/trace_events.c:3620 (discriminator 3) kernel/trace/trace_events.c:3772 (discriminator 3)) 
[  618.319618] __remove_instance (kernel/trace/trace.c:9682 kernel/trace/trace.c:9663) 
[  618.323637] instance_rmdir (kernel/trace/trace.c:9741) 
[  618.327304] tracefs_syscall_rmdir (fs/tracefs/inode.c:134) 
[  618.331582] vfs_rmdir (fs/namei.c:4204 fs/namei.c:4181) 
[  618.334903] do_rmdir (fs/namei.c:4263 (discriminator 1)) 
[  618.338223] __arm64_sys_unlinkat (fs/namei.c:4441 (discriminator 2) fs/namei.c:4435 (discriminator 2) fs/namei.c:4435 (discriminator 2)) 
[  618.342413] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:56) 
[  618.346171] el0_svc_common.constprop.0 (include/linux/thread_info.h:127 (discriminator 2) arch/arm64/kernel/syscall.c:144 (discriminator 2)) 
[  618.350973] do_el0_svc (arch/arm64/kernel/syscall.c:156) 
[  618.354294] el0_svc (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679) 
[  618.357355] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697) 
[  618.361721] el0t_64_sync (arch/arm64/kernel/entry.S:595) 
[ 618.365391] Code: 35b0b748 ffff0008 35b0b748 ffff0008 (37184778)
All code
========
   0:	35b0b748 	cbnz	w8, 0xfffffffffff616e8
   4:	ffff0008 	.inst	0xffff0008 ; undefined
   8:	35b0b748 	cbnz	w8, 0xfffffffffff616f0
   c:	ffff0008 	.inst	0xffff0008 ; undefined
  10:*	37184778 	tbnz	w24, #3, 0x8fc		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	37184778 	tbnz	w24, #3, 0x8ec
[  618.371494] ---[ end trace 0000000000000000 ]---
[  618.376117] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  618.383001] SMP: stopping secondary CPUs
[  618.387117] Kernel Offset: disabled
[  618.390607] CPU features: 0x1,0000020c,3c020000,0000421b
[  618.395927] Memory Limit: none
[  618.398986] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---


Links:
- https://lkft.validation.linaro.org/scheduler/job/7030448#L4546

metadata:
git_ref: linux-6.6.y
git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
git_sha: df34d612fd4ef266814366c8101094b7f83b6a92
git_describe: v6.6.1-604-gdf34d612fd4e
kernel_version: 6.6.2-rc1
kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2YE2AiHE0lU8S30LM8h9i7wempi/config
artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2YE2AiHE0lU8S30LM8h9i7wempi/
toolchain: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
