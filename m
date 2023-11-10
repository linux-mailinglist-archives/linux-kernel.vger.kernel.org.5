Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91747E808B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbjKJSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbjKJSLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD739CE6;
        Fri, 10 Nov 2023 07:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 22994218F3;
        Fri, 10 Nov 2023 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699628499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVcVH4uupq8MkT+6PRAw7m7nWApTvjOSuFUUPW2F4WU=;
        b=3HsedxMzbsJdY0ptneLBpSIDhblPGmPXwgvfGRlil0sv27XQ21IeruSyjPs9R4iEUgXfId
        ggXdsY8Sd/qHwCpVMJ02l/k9GWSqffcyOI+Gp6LOZM7C++90Bvf4Dec423E3oXeupK0NpA
        7X0RzlaLlPnHqA8Vth4pZ/9qzx9agE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699628499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVcVH4uupq8MkT+6PRAw7m7nWApTvjOSuFUUPW2F4WU=;
        b=/3+0NwTRTtjxg+jmsISt1Ul3wan9hKLY432PG9iyaWo0leKjHjbuCGXI8r6Qzh4113UypX
        aSp2R2BCQCBfaNAA==
Received: from localhost.cz (unknown [10.100.229.110])
        by relay2.suse.de (Postfix) with ESMTP id C6A762CC36;
        Fri, 10 Nov 2023 15:01:38 +0000 (UTC)
From:   Lukas Hruska <lhruska@suse.cz>
To:     linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Koutny <mkoutny@suse.com>,
        YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
Subject: [RFC PATCH 3/4 v1] livedump: Add memory dumping functionality
Date:   Fri, 10 Nov 2023 16:00:56 +0100
Message-ID: <20231110150057.15717-4-lhruska@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110150057.15717-1-lhruska@suse.cz>
References: <20231110150057.15717-1-lhruska@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>

This patch implements memory dumping of kernel space. Faulting pages are
temporarily pushed into kfifo and they are poped and dumped by kthread
dedicated to livedump. At the moment, supported target is only block
device like /dev/sdb.

Memory dumping is executed as follows:
(1) The handler function is invoked and:
  - It pops a buffer page from the kfifo "pool".
  - It copies a faulting page into the buffer page.
  - It pushes the buffer page into the kfifo "pend".
(2) The kthread pops the buffer page from the kfifo "pend" and submits
   bio to dump it.
(3) The endio returns the buffer page back to the kfifo "pool".

At the step (1), if the kfifo "pool" is empty, processing varies depending
on whether tha handler function is called in the sweep phase or not.
If it's in the sweep phase, the handler function waits until the kfifo
"pool" becomes available.
If not, the livedump simply fails.

For ELF format there are vmcore's function used which were already exported.
Those are written to the block device during finish phase where PFN 0 is used
to write the ELF's header and PFN 1 for VMCOREINFO string. These first 8KB of
the physical memory won't be ever saved because the first 1MB of memory is
reserved anyway.

Signed-off-by: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
Signed-off-by: Lukas Hruska <lhruska@suse.cz>
---
 arch/x86/Kconfig                |  15 +
 kernel/Makefile                 |   1 +
 kernel/livedump/Makefile        |   2 +
 kernel/livedump/core.c          | 268 +++++++++++++++++
 kernel/livedump/memdump.c       | 516 ++++++++++++++++++++++++++++++++
 kernel/livedump/memdump.h       |  34 +++
 kernel/livedump/memdump_trace.h |  30 ++
 7 files changed, 866 insertions(+)
 create mode 100644 kernel/livedump/Makefile
 create mode 100644 kernel/livedump/core.c
 create mode 100644 kernel/livedump/memdump.c
 create mode 100644 kernel/livedump/memdump.h
 create mode 100644 kernel/livedump/memdump_trace.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef3550697be1..8f0a660a6bbf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2462,6 +2462,21 @@ config WRPROTECT
 
 	  If in doubt, say N.
 
+config LIVEDUMP
+   bool "Live Dump support"
+   depends on WRPROTECT
+   help
+     Set this option to 'Y' to allow the kernel support to acquire
+     a consistent snapshot of kernel space without stopping system.
+
+     This feature regularly causes small overhead on kernel.
+
+     Once this feature is initialized by its special ioctl, it
+     allocates huge memory for itself and causes much more overhead
+     on kernel.
+
+     If in doubt, say N.
+
 config MODIFY_LDT_SYSCALL
 	bool "Enable the LDT (local descriptor table)" if EXPERT
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..9368085e3817 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -47,6 +47,7 @@ obj-y += power/
 obj-y += printk/
 obj-y += irq/
 obj-y += rcu/
+obj-y += livedump/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
diff --git a/kernel/livedump/Makefile b/kernel/livedump/Makefile
new file mode 100644
index 000000000000..e23f6f28e624
--- /dev/null
+++ b/kernel/livedump/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_LIVEDUMP) += core.o memdump.o
diff --git a/kernel/livedump/core.c b/kernel/livedump/core.c
new file mode 100644
index 000000000000..fb90901fc1a1
--- /dev/null
+++ b/kernel/livedump/core.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* core.c - Live Dump's main
+ * Copyright (C) 2012 Hitachi, Ltd.
+ * Copyright (C) 2023 SUSE
+ * Author: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
+ * Author: Lukas Hruska <lhruska@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "memdump.h"
+#include <asm/wrprotect.h>
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+#include <linux/printk.h>
+#include <linux/reboot.h>
+#include <linux/sysfs.h>
+#include <linux/memblock.h>
+
+#define DEVICE_NAME	"livedump"
+
+enum state {
+	LIVEDUMP_STATE_UNDEFINED,
+	LIVEDUMP_STATE_INIT,
+	LIVEDUMP_STATE_START,
+	LIVEDUMP_STATE_SWEEP,
+	LIVEDUMP_STATE_FINISH,
+	LIVEDUMP_STATE_UNINIT,
+};
+
+struct livedump_conf {
+	char bdevpath[PATH_MAX];
+} livedump_conf;
+
+enum state livedump_state;
+
+static void do_uninit(void)
+{
+	wrprotect_uninit();
+	livedump_memdump_uninit();
+}
+
+static int do_init(void)
+{
+	int ret;
+
+	if (strlen(livedump_conf.bdevpath) == 0) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = wrprotect_init(livedump_memdump_handle_page, livedump_memdump_sm_init);
+	if (ret) {
+		pr_warn("livedump: Failed to initialize Protection manager.\n");
+		goto err;
+	}
+
+	ret = livedump_memdump_init(livedump_conf.bdevpath);
+	if (ret) {
+		pr_warn("livedump: Failed to initialize Dump manager.\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	do_uninit();
+	return ret;
+}
+
+static long livedump_change_state(unsigned int cmd)
+{
+	long ret = 0;
+
+	if (cmd == LIVEDUMP_STATE_UNDEFINED) {
+		pr_warn("livedump: you cannot change the livedump state into LIVEDUMP_STATE_UNDEFINED.\n");
+		return -EINVAL;
+	}
+
+	/* All states except LIVEDUMP_STATE_UNINIT must have an output set. */
+	switch (cmd) {
+	case LIVEDUMP_STATE_UNINIT:
+		break;
+	default:
+		if (!strlen(livedump_conf.bdevpath)) {
+			pr_warn("livedump: The output must be set first before changing the state.\n");
+			return -EINVAL;
+		}
+	}
+
+	switch (cmd) {
+	case LIVEDUMP_STATE_INIT:
+		if (livedump_state != LIVEDUMP_STATE_UNDEFINED &&
+		    livedump_state != LIVEDUMP_STATE_UNINIT) {
+			pr_warn("livedump: To initialize a livedump the current state must be "
+			    "LIVEDUMP_STATE_UNDEFINED or LIVEDUMP_STATE_UNINIT.\n");
+			return -EINVAL;
+		}
+		ret = do_init();
+		break;
+	case LIVEDUMP_STATE_START:
+		if (livedump_state != LIVEDUMP_STATE_INIT) {
+			pr_warn("livedump: To start a livedump the current state must be "
+			    "LIVEDUMP_STATE_INIT.\n");
+			return -EINVAL;
+		}
+		ret = wrprotect_start();
+		break;
+	case LIVEDUMP_STATE_SWEEP:
+		if (livedump_state != LIVEDUMP_STATE_START) {
+			pr_warn("livedump: To start sweep functionality of livedump the current state must "
+			    "be LIVEDUMP_STATE_START.\n");
+			return -EINVAL;
+		}
+		ret = wrprotect_sweep();
+		break;
+	case LIVEDUMP_STATE_FINISH:
+		if (livedump_state != LIVEDUMP_STATE_SWEEP) {
+			pr_warn("livedump: To finish a livedump the current state must be "
+			    "LIVEDUMP_STATE_SWEEP.\n");
+			return -EINVAL;
+		}
+		livedump_memdump_write_elf_hdr();
+		break;
+	case LIVEDUMP_STATE_UNINIT:
+		if (livedump_state < LIVEDUMP_STATE_INIT) {
+			pr_warn("livedump: To uninitialize livedump the current state must be at least "
+			    "LIVEDUMP_STATE_INIT.\n");
+			return -EINVAL;
+		}
+		do_uninit();
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	if (ret == 0)
+		livedump_state = cmd;
+
+	return ret;
+}
+
+/* sysfs */
+
+static struct kobject *livedump_root_kobj;
+
+static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int new_state, ret;
+
+	ret = kstrtoint(buf, 10, &new_state);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (new_state < LIVEDUMP_STATE_UNDEFINED || new_state > LIVEDUMP_STATE_UNINIT)
+		return -ENOIOCTLCMD;
+
+	ret = livedump_change_state(new_state);
+	if (ret < 0)
+		return ret;
+
+	livedump_state = new_state;
+	return count;
+}
+
+static ssize_t state_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+
+	count += sprintf(buf, "%u\n\n", livedump_state);
+	count += sprintf(buf+count, "LIVEDUMP_STATE_UNDEFINED = 0\n");
+	count += sprintf(buf+count, "LIVEDUMP_STATE_INIT = 1\n");
+	count += sprintf(buf+count, "LIVEDUMP_STATE_START = 2\n");
+	count += sprintf(buf+count, "LIVEDUMP_STATE_SWEEP = 3\n");
+	count += sprintf(buf+count, "LIVEDUMP_STATE_FINISH = 4\n");
+	count += sprintf(buf+count, "LIVEDUMP_STATE_UNINIT = 5\n");
+	buf[count] = '\0';
+	return count;
+}
+
+static ssize_t output_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int len;
+
+	switch (livedump_state) {
+	case LIVEDUMP_STATE_UNDEFINED:
+	case LIVEDUMP_STATE_UNINIT:
+		break;
+	default:
+		pr_warn("livedump: you cannot change the output in current state of livedump.\n");
+		return -EINVAL;
+	}
+
+	len = strlcpy(livedump_conf.bdevpath, buf, sizeof(livedump_conf.bdevpath));
+	if (len == 0 || len >= sizeof(livedump_conf.bdevpath))
+		return -EINVAL;
+	/* remove the newline character */
+	livedump_conf.bdevpath[len-1] = '\0';	
+
+	return count;
+}
+
+static ssize_t output_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", livedump_conf.bdevpath);
+}
+
+static struct kobj_attribute state_kobj_attr = __ATTR_RW(state);
+static struct kobj_attribute output_kobj_attr = __ATTR_RW(output);
+static struct attribute *livedump_attrs[] = {
+	&state_kobj_attr.attr,
+	&output_kobj_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(livedump);
+
+static int livedump_exit(struct notifier_block *_, unsigned long __, void *___)
+{
+	if (livedump_root_kobj)
+		kobject_put(livedump_root_kobj);
+	do_uninit();
+	return NOTIFY_DONE;
+}
+static struct notifier_block livedump_nb = {
+	.notifier_call = livedump_exit
+};
+
+static int __init livedump_init(void)
+{
+	int ret;
+
+	livedump_root_kobj = kobject_create_and_add("livedump", kernel_kobj);
+	if (!livedump_root_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(livedump_root_kobj, *livedump_groups);
+	if (ret) {
+		livedump_exit(NULL, 0, NULL);
+		return ret;
+	}
+
+	ret = register_reboot_notifier(&livedump_nb);
+	if (WARN_ON(ret)) {
+		livedump_exit(NULL, 0, NULL);
+		return ret;
+	}
+
+	livedump_conf.bdevpath[0] = '\0';
+	livedump_state = 0;
+
+	return 0;
+}
+
+module_init(livedump_init);
diff --git a/kernel/livedump/memdump.c b/kernel/livedump/memdump.c
new file mode 100644
index 000000000000..1df413ba8e12
--- /dev/null
+++ b/kernel/livedump/memdump.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* memdump.c - Live Dump's memory dumping management
+ * Copyright (C) 2012 Hitachi, Ltd.
+ * Copyright (C) 2023 SUSE
+ * Author: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
+ * Author: Lukas Hruska <lhruska@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "memdump.h"
+
+#define CREATE_TRACE_POINTS
+#include "memdump_trace.h"
+
+#include <asm/wrprotect.h>
+
+#include <linux/crash_core.h>
+#include <linux/crash_dump.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/kfifo.h>
+#include <linux/delay.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/sizes.h>
+#include <linux/printk.h>
+#include <linux/tracepoint.h>
+
+#define MEMDUMP_KFIFO_SIZE	131072 /* in pages */
+#define SECTOR_SHIFT		9
+#define PFN_ELF_0			0
+#define PFN_ELF_1			1
+
+static const char THREAD_NAME[] = "livedump";
+static struct block_device *memdump_bdev;
+
+/* ELF metadata */
+static unsigned char *vmcoreinfo;
+static void *elf_data;
+static unsigned long elf_size;
+static struct crash_mem *cmem;
+
+/* ELF modification */
+static char *elfnotes_buf;
+static size_t elfnotes_sz;
+
+/***** State machine *****/
+enum MEMDUMP_STATE {
+	_MEMDUMP_INIT,
+	MEMDUMP_INACTIVE = _MEMDUMP_INIT,
+	MEMDUMP_ACTIVATING,
+	MEMDUMP_ACTIVE,
+	MEMDUMP_INACTIVATING,
+	_MEMDUMP_OVERFLOW,
+};
+
+static struct memdump_state {
+	atomic_t val;
+	atomic_t count;
+	spinlock_t lock;
+} __aligned(PAGE_SIZE) memdump_state = {
+	ATOMIC_INIT(_MEMDUMP_INIT),
+	ATOMIC_INIT(0),
+	__SPIN_LOCK_INITIALIZER(memdump_state.lock),
+};
+
+/* memdump_state_inc
+ *
+ * Increments ACTIVE state refcount.
+ * The refcount must be zero to transit to next state (INACTIVATING).
+ */
+static bool memdump_state_inc(void)
+{
+	bool ret;
+
+	spin_lock(&memdump_state.lock);
+	ret = (atomic_read(&memdump_state.val) == MEMDUMP_ACTIVE);
+	if (ret)
+		atomic_inc(&memdump_state.count);
+	spin_unlock(&memdump_state.lock);
+	return ret;
+}
+
+/* memdump_state_dec
+ *
+ * Decrements ACTIVE state refcount
+ */
+static void memdump_state_dec(void)
+{
+	atomic_dec(&memdump_state.count);
+}
+
+/* memdump_state_transit
+ *
+ * Transit to next state.
+ * If current state isn't assumed state, transition fails.
+ */
+static bool memdump_state_transit(enum MEMDUMP_STATE assumed)
+{
+	bool ret;
+
+	spin_lock(&memdump_state.lock);
+	ret = (atomic_read(&memdump_state.val) == assumed &&
+		atomic_read(&memdump_state.count) == 0);
+	if (ret) {
+		atomic_inc(&memdump_state.val);
+		if (atomic_read(&memdump_state.val) == _MEMDUMP_OVERFLOW)
+			atomic_set(&memdump_state.val, _MEMDUMP_INIT);
+	}
+	spin_unlock(&memdump_state.lock);
+	return ret;
+}
+
+static void memdump_state_transit_back(void)
+{
+	atomic_dec(&memdump_state.val);
+}
+
+/***** Request queue *****/
+
+/*
+ * Request queue consists of 2 kfifos: pend, pool
+ *
+ * Processing between the two kfifos:
+ *  (1)handle_page READs one request from POOL.
+ *  (2)handle_page makes the request and WRITEs it to PEND.
+ *  (3)kthread READs the request from PEND and submits bio.
+ *  (4)endio WRITEs the request to POOL.
+ *
+ * kfifo permits parallel access by 1 reader and 1 writer.
+ * Therefore, (1), (2) and (4) must be serialized.
+ * (3) need not be protected since livedump uses only one kthread.
+ *
+ * (1) is protected by pool_r_lock.
+ * (2) is protected by pend_w_lock.
+ * (4) is protected by pool_w_lock.
+ */
+
+struct memdump_request {
+	void *p; /* pointing to buffer (one page) */
+	unsigned long pfn;
+};
+
+static struct memdump_request_queue {
+	void *pages[MEMDUMP_KFIFO_SIZE];
+
+	STRUCT_KFIFO(struct memdump_request, MEMDUMP_KFIFO_SIZE) pool;
+	STRUCT_KFIFO(struct memdump_request, MEMDUMP_KFIFO_SIZE) pend;
+
+	spinlock_t pool_w_lock;
+	spinlock_t pool_r_lock;
+	spinlock_t pend_w_lock;
+} __aligned(PAGE_SIZE) memdump_req_queue, memdump_req_queue_for_sweep;
+
+static void free_req_queue(void)
+{
+	int i;
+
+	for (i = 0; i < MEMDUMP_KFIFO_SIZE; i++) {
+		if (memdump_req_queue.pages[i]) {
+			free_page((unsigned long)memdump_req_queue.pages[i]);
+			memdump_req_queue.pages[i] = NULL;
+		}
+	}
+	for (i = 0; i < MEMDUMP_KFIFO_SIZE; i++) {
+		if (memdump_req_queue_for_sweep.pages[i]) {
+			free_page((unsigned long)memdump_req_queue_for_sweep.pages[i]);
+			memdump_req_queue_for_sweep.pages[i] = NULL;
+		}
+	}
+}
+
+static long alloc_req_queue(void)
+{
+	long ret;
+	int i;
+	struct memdump_request req;
+
+	/* initialize spinlocks */
+	spin_lock_init(&memdump_req_queue.pool_w_lock);
+	spin_lock_init(&memdump_req_queue.pool_r_lock);
+	spin_lock_init(&memdump_req_queue.pend_w_lock);
+	spin_lock_init(&memdump_req_queue_for_sweep.pool_w_lock);
+	spin_lock_init(&memdump_req_queue_for_sweep.pool_r_lock);
+	spin_lock_init(&memdump_req_queue_for_sweep.pend_w_lock);
+
+	/* initialize kfifos */
+	INIT_KFIFO(memdump_req_queue.pend);
+	INIT_KFIFO(memdump_req_queue.pool);
+	INIT_KFIFO(memdump_req_queue_for_sweep.pend);
+	INIT_KFIFO(memdump_req_queue_for_sweep.pool);
+
+	/* allocate pages and push pages into pool */
+	for (i = 0; i < MEMDUMP_KFIFO_SIZE; i++) {
+		/* for normal queue */
+		memdump_req_queue.pages[i]
+			= (void *)__get_free_page(GFP_KERNEL);
+		if (!memdump_req_queue.pages[i]) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		req.p = memdump_req_queue.pages[i];
+		ret = kfifo_put(&memdump_req_queue.pool, req);
+		BUG_ON(!ret);
+
+		/* for sweep queue */
+		memdump_req_queue_for_sweep.pages[i]
+			= (void *)__get_free_page(GFP_KERNEL);
+		if (!memdump_req_queue_for_sweep.pages[i]) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		req.p = memdump_req_queue_for_sweep.pages[i];
+		ret = kfifo_put(&memdump_req_queue_for_sweep.pool, req);
+		BUG_ON(!ret);
+	}
+
+	return 0;
+
+err:
+	free_req_queue();
+	return ret;
+}
+
+/***** Kernel thread *****/
+static struct memdump_thread {
+	struct task_struct *tsk;
+	bool is_active;
+	struct completion completion;
+	wait_queue_head_t waiters;
+} __aligned(PAGE_SIZE) memdump_thread;
+
+static int memdump_thread_func(void *);
+
+static long start_memdump_thread(void)
+{
+	memdump_thread.is_active = true;
+	init_completion(&memdump_thread.completion);
+	init_waitqueue_head(&memdump_thread.waiters);
+	memdump_thread.tsk = kthread_run(
+			memdump_thread_func, NULL, THREAD_NAME);
+	if (IS_ERR(memdump_thread.tsk))
+		return PTR_ERR(memdump_thread.tsk);
+	return 0;
+}
+
+static void stop_memdump_thread(void)
+{
+	memdump_thread.is_active = false;
+	wait_for_completion(&memdump_thread.completion);
+}
+
+static void memdump_endio(struct bio *bio)
+{
+	struct memdump_request req = { .p = page_address(bio_page(bio)) };
+	struct memdump_request_queue *queue = (bio->bi_private ?
+			&memdump_req_queue_for_sweep : &memdump_req_queue);
+
+	spin_lock(&queue->pool_w_lock);
+	kfifo_put(&queue->pool, req);
+	spin_unlock(&queue->pool_w_lock);
+
+	wake_up(&memdump_thread.waiters);
+}
+
+static int memdump_thread_func(void *_)
+{
+	struct bio *bio;
+	struct memdump_request req;
+
+	do {
+		/* Process request */
+		while (kfifo_get(&memdump_req_queue.pend, &req)) {
+			bio = bio_alloc(memdump_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
+
+			if (WARN_ON(!bio)) {
+				spin_lock(&memdump_req_queue.pool_w_lock);
+				kfifo_put(&memdump_req_queue.pool, req);
+				spin_unlock(&memdump_req_queue.pool_w_lock);
+				continue;
+			}
+
+			bio->bi_bdev = memdump_bdev;
+			bio->bi_end_io = memdump_endio;
+			bio->bi_iter.bi_sector = req.pfn << (PAGE_SHIFT - SECTOR_SHIFT);
+			bio_add_page(bio, virt_to_page(req.p), PAGE_SIZE, 0);
+
+			trace_memdump_bio_submit(memdump_bdev, req.pfn);
+
+			submit_bio(bio);
+		}
+
+		/* Process request for sweep*/
+		while (kfifo_get(&memdump_req_queue_for_sweep.pend, &req)) {
+			bio = bio_alloc(memdump_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
+
+			if (WARN_ON(!bio)) {
+				spin_lock(&memdump_req_queue_for_sweep.pool_w_lock);
+				kfifo_put(&memdump_req_queue_for_sweep.pool, req);
+				spin_unlock(&memdump_req_queue_for_sweep.pool_w_lock);
+				continue;
+			}
+
+			bio->bi_bdev = memdump_bdev;
+			bio->bi_end_io = memdump_endio;
+			bio->bi_iter.bi_sector = req.pfn << (PAGE_SHIFT - SECTOR_SHIFT);
+			bio->bi_private = (void *)1; /* for sweep */
+			bio_add_page(bio, virt_to_page(req.p), PAGE_SIZE, 0);
+
+			trace_memdump_bio_submit(memdump_bdev, req.pfn);
+
+			submit_bio(bio);
+		}
+
+		msleep(20);
+	} while (memdump_thread.is_active);
+
+	complete(&memdump_thread.completion);
+	return 0;
+}
+
+static int select_pages(void);
+
+int livedump_memdump_init(const char *bdevpath)
+{
+	long ret;
+
+	if (WARN(!memdump_state_transit(MEMDUMP_INACTIVE),
+				"livedump: memdump is already initialized.\n"))
+		return -EBUSY;
+
+	/* Get bdev */
+	ret = -ENOENT;
+	memdump_bdev = blkdev_get_by_path(bdevpath, FMODE_EXCL, &memdump_bdev);
+	if (memdump_bdev < 0)
+		goto err;
+
+	/* Allocate request queue */
+	ret = alloc_req_queue();
+	if (ret)
+		goto err_bdev;
+
+	/* Start thread */
+	ret = start_memdump_thread();
+	if (ret)
+		goto err_freeq;
+
+	/* Select target pages */
+	select_pages();
+
+	/* Allocate space for vmcore info */
+	vmcoreinfo = vmalloc(PAGE_SIZE);
+	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	if (WARN_ON(!vmcoreinfo || !cmem))
+		return -ENOMEM;
+
+	memdump_state_transit(MEMDUMP_ACTIVATING); /* always succeeds */
+	return 0;
+
+err_freeq:
+	free_req_queue();
+err_bdev:
+	blkdev_put(memdump_bdev, FMODE_EXCL);
+err:
+	memdump_state_transit_back();
+	return ret;
+}
+
+void livedump_memdump_uninit(void)
+{
+	if (!memdump_state_transit(MEMDUMP_ACTIVE))
+		return;
+
+	/* Stop thread */
+	stop_memdump_thread();
+
+	/* Free request queue */
+	free_req_queue();
+
+	/* Free vmcoreinfo */
+	if (vmcoreinfo)
+		vunmap(vmcoreinfo);
+	if (cmem)
+		vfree(cmem);
+
+	/* merged notes */
+	if (elfnotes_buf)
+		vfree(elfnotes_buf);
+
+	/* Put bdev */
+	blkdev_put(memdump_bdev, FMODE_EXCL);
+
+	memdump_state_transit(MEMDUMP_INACTIVATING); /* always succeeds */
+}
+
+void livedump_memdump_handle_page(unsigned long pfn, unsigned long addr, int for_sweep)
+{
+	int ret;
+	unsigned long flags;
+	struct memdump_request req;
+	struct memdump_request_queue *queue =
+		(for_sweep ? &memdump_req_queue_for_sweep : &memdump_req_queue);
+	DEFINE_WAIT(wait);
+
+	BUG_ON(addr & ~PAGE_MASK);
+
+	if (!memdump_state_inc())
+		return;
+
+	/* Get buffer */
+retry_after_wait:
+	spin_lock_irqsave(&queue->pool_r_lock, flags);
+	ret = kfifo_get(&queue->pool, &req);
+	spin_unlock_irqrestore(&queue->pool_r_lock, flags);
+
+	if (!ret) {
+		if (WARN_ON_ONCE(!for_sweep))
+			goto err;
+		else {
+			prepare_to_wait(&memdump_thread.waiters, &wait,
+					TASK_UNINTERRUPTIBLE);
+			schedule();
+			finish_wait(&memdump_thread.waiters, &wait);
+			goto retry_after_wait;
+		}
+	}
+
+	/* Make request */
+	req.pfn = pfn;
+	if (pfn == PFN_ELF_0) {
+		memcpy(req.p, elf_data, elf_size);
+		memset(req.p + elf_size, 0, PAGE_SIZE - elf_size);
+	} else if (pfn == PFN_ELF_1)
+		memcpy(req.p, elfnotes_buf, PAGE_SIZE);
+	else
+		memcpy(req.p, (void *)addr, PAGE_SIZE);
+
+	/* Queue request */
+	spin_lock_irqsave(&queue->pend_w_lock, flags);
+	kfifo_put(&queue->pend, req);
+	spin_unlock_irqrestore(&queue->pend_w_lock, flags);
+
+err:
+	memdump_state_dec();
+}
+
+/* select_pages
+ *
+ * Eliminate pages that contain memdump's stuffs from bitmap.
+ */
+static int select_pages(void)
+{
+	unsigned long i;
+
+	/* Unselect memdump stuffs */
+	wrprotect_unselect_pages(
+			(unsigned long)&memdump_state, sizeof(memdump_state));
+	wrprotect_unselect_pages(
+			(unsigned long)&memdump_req_queue,
+			sizeof(memdump_req_queue));
+	wrprotect_unselect_pages(
+			(unsigned long)&memdump_req_queue_for_sweep,
+			sizeof(memdump_req_queue_for_sweep));
+	wrprotect_unselect_pages(
+			(unsigned long)&memdump_thread, sizeof(memdump_thread));
+	for (i = 0; i < MEMDUMP_KFIFO_SIZE; i++) {
+		wrprotect_unselect_pages((unsigned long)memdump_req_queue.pages[i],
+		    PAGE_ALIGN(sizeof(struct memdump_request)));
+		wrprotect_unselect_pages((unsigned long)memdump_req_queue_for_sweep.pages[i],
+		    PAGE_ALIGN(sizeof(struct memdump_request)));
+		cond_resched();
+	}
+
+	return 0;
+}
+
+void livedump_memdump_sm_init(void)
+{
+	unsigned int cpu;
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(struct pt_regs));
+	regs.ip = (unsigned long)memdump_thread_func;
+
+	for_each_present_cpu(cpu) {
+		crash_save_cpu(&regs, cpu);
+	}
+
+	cmem->max_nr_ranges = 1;
+	cmem->nr_ranges = 1;
+	cmem->ranges[0].start = SZ_1M;
+	cmem->ranges[0].end = ((max_pfn + 1) << PAGE_SHIFT) - 1;
+	crash_update_vmcoreinfo_safecopy(vmcoreinfo);
+	crash_save_vmcoreinfo();
+	crash_prepare_elf64_headers(cmem, 1, &elf_data, &elf_size);
+	crash_update_vmcoreinfo_safecopy(NULL);
+	merge_note_headers_elf64((char *)elf_data, &elf_size, &elfnotes_buf, &elfnotes_sz);
+}
+
+void livedump_memdump_write_elf_hdr(void)
+{
+	livedump_memdump_handle_page(PFN_ELF_0, 0, 1);
+	livedump_memdump_handle_page(PFN_ELF_1, 0, 1);
+}
diff --git a/kernel/livedump/memdump.h b/kernel/livedump/memdump.h
new file mode 100644
index 000000000000..9df9b2fe9ae9
--- /dev/null
+++ b/kernel/livedump/memdump.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* memdump.h - Live Dump's memory dumping management
+ * Copyright (C) 2012 Hitachi, Ltd.
+ * Copyright (C) 2023 SUSE
+ * Author: YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
+ * Author: Lukas Hruska <lhruska@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LIVEDUMP_MEMDUMP_H
+#define _LIVEDUMP_MEMDUMP_H
+
+#include <linux/fs.h>
+
+extern int livedump_memdump_init(const char *bdevpath);
+
+extern void livedump_memdump_uninit(void);
+
+extern void livedump_memdump_handle_page(unsigned long pfn, unsigned long addr, int for_sweep);
+
+extern void livedump_memdump_sm_init(void);
+
+extern void livedump_memdump_write_elf_hdr(void);
+
+#endif /* _LIVEDUMP_MEMDUMP_H */
diff --git a/kernel/livedump/memdump_trace.h b/kernel/livedump/memdump_trace.h
new file mode 100644
index 000000000000..cd9fe08b034f
--- /dev/null
+++ b/kernel/livedump/memdump_trace.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM livedump
+
+#if !defined(_TRACE_LIVEDUMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LIVEDUMP_H
+
+#include <linux/blk_types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(memdump_bio_submit,
+	TP_PROTO(struct block_device *bdev, unsigned long pfn),
+	TP_ARGS(bdev, pfn),
+	TP_STRUCT__entry(
+		__field(struct block_device *, bdev)
+		__field(unsigned long, pfn)
+	),
+	TP_fast_assign(
+		if (bdev != NULL)
+			__entry->bdev = bdev;
+		__entry->pfn = pfn;
+	),
+	TP_printk("bdev=%u, pfn=%lu", __entry->bdev->bd_dev, __entry->pfn)
+);
+#endif /* _TRACE_LIVEDUMP_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../kernel/livedump/
+#define TRACE_INCLUDE_FILE memdump_trace
+#include <trace/define_trace.h>
-- 
2.39.2

