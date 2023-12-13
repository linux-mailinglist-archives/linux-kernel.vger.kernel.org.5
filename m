Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1693D80FBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377633AbjLMAFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377750AbjLMAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:05:46 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002C12B;
        Tue, 12 Dec 2023 16:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425944; x=1733961944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvtk3HQrKsl8B+ppqatJMPW6FdHejxoz+znJi2t9qtA=;
  b=a//RTaD/sBFScXhoV2eQWtTUWHkueFJa3zGfCfSDKmAkc6hMsS38X4Q2
   ochk8SP5Q3qFAilPbaY8k3xE1nFFj60HpU8azhs+ES7OY4iTTh4W6Uvbw
   tOzjNIjoBzUjImPUBOkXojvtcoG7XtGo+FNnCeu+Yquf+UnXzf2uEaqgz
   g=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="375754434"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:05:39 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id CDB7D40D47;
        Wed, 13 Dec 2023 00:05:32 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:49387]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id 1de1abc8-aa8e-477e-a407-6ac5ab261a33; Wed, 13 Dec 2023 00:05:32 +0000 (UTC)
X-Farcaster-Flow-ID: 1de1abc8-aa8e-477e-a407-6ac5ab261a33
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:31 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:05:27 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/15] kexec: Add Kexec HandOver (KHO) generation helpers
Date:   Wed, 13 Dec 2023 00:04:40 +0000
Message-ID: <20231213000452.88295-4-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core infrastructure to generate Kexec HandOver
metadata. Kexec HandOver is a mechanism that allows Linux to preserve
state - arbitrary properties as well as memory locations - across kexec.

It does so using 3 concepts:

  1) Device Tree - Every KHO kexec carries a KHO specific flattened
     device tree blob that describes the state of the system. Device
     drivers can register to KHO to serialize their state before kexec.

  2) Mem cache - A memblocks like structure that contains full page
     ranges of reservations. These can not be part of the architectural
     reservations, because they differ on every kexec.

  3) Scratch Region - A CMA region that we allocate in the first kernel.
     CMA gives us the guarantee that no handover pages land in that
     region, because handover pages must be at a static physical memory
     location. We use this region as the place to load future kexec
     images into which then won't collide with any handover data.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/ABI/testing/sysfs-kernel-kho    |  53 +++
 .../admin-guide/kernel-parameters.txt         |  10 +
 MAINTAINERS                                   |   1 +
 include/linux/kexec.h                         |  24 ++
 include/uapi/linux/kexec.h                    |   6 +
 kernel/Makefile                               |   1 +
 kernel/kexec_kho_out.c                        | 316 ++++++++++++++++++
 7 files changed, 411 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
 create mode 100644 kernel/kexec_kho_out.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-kho b/Documentation/ABI/testing/sysfs-kernel-kho
new file mode 100644
index 000000000000..f69e7b81a337
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-kho
@@ -0,0 +1,53 @@
+What:		/sys/kernel/kho/active
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		Kexec HandOver (KHO) allows Linux to transition the state of
+		compatible drivers into the next kexec'ed kernel. To do so,
+		device drivers will serialize their current state into a DT.
+		While the state is serialized, they are unable to perform
+		any modifications to state that was serialized, such as
+		handed over memory allocations.
+
+		When this file contains "1", the system is in the transition
+		state. When contains "0", it is not. To switch between the
+		two states, echo the respective number into this file.
+
+What:		/sys/kernel/kho/dt_max
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		KHO needs to allocate a buffer for the DT that gets
+		generated before it knows the final size. By default, it
+		will allocate 10 MiB for it. You can write to this file
+		to modify the size of that allocation.
+
+What:		/sys/kernel/kho/scratch_len
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		To support continuous KHO kexecs, we need to reserve a
+		physically contiguous memory region that will always stay
+		available for future kexec allocations. This file describes
+		the length of that memory region. Kexec user space tooling
+		can use this to determine where it should place its payload
+		images.
+
+What:		/sys/kernel/kho/scratch_phys
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		To support continuous KHO kexecs, we need to reserve a
+		physically contiguous memory region that will always stay
+		available for future kexec allocations. This file describes
+		the physical location of that memory region. Kexec user space
+		tooling can use this to determine where it should place its
+		payload images.
+
+What:		/sys/kernel/kho/dt
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		When KHO is active, the kernel exposes the generated DT that
+		carries its current KHO state in this file. Kexec user space
+		tooling can use this as input file for the KHO payload image.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 51575cd31741..efeef075617e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2504,6 +2504,16 @@
 	kgdbwait	[KGDB] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
+	kho_scratch=n[KMG]	[KEXEC] Sets the size of the KHO scratch
+			region. The KHO scratch region is a physically
+			memory range that can only be used for non-kernel
+			allocations. That way, even when memory is heavily
+			fragmented with handed over memory, kexec will always
+			be able to find contiguous memory to place the next
+			kernel for kexec into.
+
+			The default is 0.
+
 	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..4ebf7c5fd424 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11769,6 +11769,7 @@ M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+F:	Documentation/ABI/testing/sysfs-kernel-kho
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..db2597e5550d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -21,6 +21,8 @@
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
+#include <linux/libfdt.h>
+#include <linux/notifier.h>
 
 extern note_buf_t __percpu *crash_notes;
 
@@ -516,6 +518,28 @@ void set_kexec_sig_enforced(void);
 static inline void set_kexec_sig_enforced(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_KHO
+/* Notifier index */
+enum kho_event {
+	KEXEC_KHO_DUMP = 0,
+	KEXEC_KHO_ABORT = 1,
+};
+
+extern phys_addr_t kho_scratch_phys;
+extern phys_addr_t kho_scratch_len;
+
+/* egest handover metadata */
+void kho_reserve(void);
+int register_kho_notifier(struct notifier_block *nb);
+int unregister_kho_notifier(struct notifier_block *nb);
+bool kho_is_active(void);
+#else
+static inline void kho_reserve(void) { }
+static inline int register_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
+static inline int unregister_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
+static inline bool kho_is_active(void) { return false; }
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 01766dd839b0..d02ffd5960d6 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -49,6 +49,12 @@
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
 
+/* KHO passes an array of kho_mem as "mem cache" to the new kernel */
+struct kho_mem {
+	__u64 addr;
+	__u64 len;
+};
+
 #ifndef __KERNEL__
 /*
  * This structure is used to hold the arguments that are used when
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..a6bd31e22c09 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_KHO) += kexec_kho_out.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_kho_out.c b/kernel/kexec_kho_out.c
new file mode 100644
index 000000000000..e6184bde5c10
--- /dev/null
+++ b/kernel/kexec_kho_out.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_kho_out.c - kexec handover code to egest metadata.
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cma.h>
+#include <linux/kexec.h>
+#include <linux/device.h>
+#include <linux/compiler.h>
+#include <linux/kmsg_dump.h>
+
+struct kho_out {
+	struct kobject *kobj;
+	bool active;
+	struct cma *cma;
+	struct blocking_notifier_head chain_head;
+	void *dt;
+	u64 dt_len;
+	u64 dt_max;
+	struct mutex lock;
+};
+
+static struct kho_out kho = {
+	.dt_max = (1024 * 1024 * 10),
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho.lock),
+};
+
+/*
+ * Size for scratch (non-KHO) memory. With KHO enabled, memory can become
+ * fragmented because KHO regions may be anywhere in physical address
+ * space. The scratch region gives us a safe zone that we will never see
+ * KHO allocations from. This is where we can later safely load our new kexec
+ * images into.
+ */
+static phys_addr_t kho_scratch_size __initdata;
+
+int register_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kho.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_kho_notifier);
+
+int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kho.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_kho_notifier);
+
+bool kho_is_active(void)
+{
+	return kho.active;
+}
+EXPORT_SYMBOL_GPL(kho_is_active);
+
+static ssize_t raw_read(struct file *file, struct kobject *kobj,
+			struct bin_attribute *attr, char *buf,
+			loff_t pos, size_t count)
+{
+	mutex_lock(&kho.lock);
+	memcpy(buf, attr->private + pos, count);
+	mutex_unlock(&kho.lock);
+
+	return count;
+}
+
+static BIN_ATTR(dt, 0400, raw_read, NULL, 0);
+
+static int kho_expose_dt(void *fdt)
+{
+	long fdt_len = fdt_totalsize(fdt);
+	int err;
+
+	kho.dt = fdt;
+	kho.dt_len = fdt_len;
+
+	bin_attr_dt.size = fdt_totalsize(fdt);
+	bin_attr_dt.private = fdt;
+	err = sysfs_create_bin_file(kho.kobj, &bin_attr_dt);
+
+	return err;
+}
+
+static void kho_abort(void)
+{
+	if (!kho.active)
+		return;
+
+	sysfs_remove_bin_file(kho.kobj, &bin_attr_dt);
+
+	kvfree(kho.dt);
+	kho.dt = NULL;
+	kho.dt_len = 0;
+
+	blocking_notifier_call_chain(&kho.chain_head, KEXEC_KHO_ABORT, NULL);
+
+	kho.active = false;
+}
+
+static int kho_serialize(void)
+{
+	void *fdt = NULL;
+	int err;
+
+	kho.active = true;
+	err = -ENOMEM;
+
+	fdt = kvmalloc(kho.dt_max, GFP_KERNEL);
+	if (!fdt)
+		goto out;
+
+	if (fdt_create(fdt, kho.dt_max)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = fdt_finish_reservemap(fdt);
+	if (err)
+		goto out;
+
+	err = fdt_begin_node(fdt, "");
+	if (err)
+		goto out;
+
+	err = fdt_property_string(fdt, "compatible", "kho-v1");
+	if (err)
+		goto out;
+
+	/* Loop through all kho dump functions */
+	err = blocking_notifier_call_chain(&kho.chain_head, KEXEC_KHO_DUMP, fdt);
+	err = notifier_to_errno(err);
+	if (err)
+		goto out;
+
+	/* Close / */
+	err =  fdt_end_node(fdt);
+	if (err)
+		goto out;
+
+	err = fdt_finish(fdt);
+	if (err)
+		goto out;
+
+	if (WARN_ON(fdt_check_header(fdt))) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = kho_expose_dt(fdt);
+
+out:
+	if (err) {
+		pr_err("kho failed to serialize state: %d", err);
+		kho_abort();
+	}
+	return err;
+}
+
+/* Handling for /sys/kernel/kho */
+
+#define KHO_ATTR_RO(_name) static struct kobj_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
+#define KHO_ATTR_RW(_name) static struct kobj_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)
+
+static ssize_t active_store(struct kobject *dev, struct kobj_attribute *attr,
+			    const char *buf, size_t size)
+{
+	ssize_t retsize = size;
+	bool val = false;
+	int ret;
+
+	if (kstrtobool(buf, &val) < 0)
+		return -EINVAL;
+
+	if (!kho_scratch_len)
+		return -ENOMEM;
+
+	mutex_lock(&kho.lock);
+	if (val != kho.active) {
+		if (val) {
+			ret = kho_serialize();
+			if (ret) {
+				retsize = -EINVAL;
+				goto out;
+			}
+		} else {
+			kho_abort();
+		}
+	}
+
+out:
+	mutex_unlock(&kho.lock);
+	return retsize;
+}
+
+static ssize_t active_show(struct kobject *dev, struct kobj_attribute *attr,
+			   char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&kho.lock);
+	ret = sysfs_emit(buf, "%d\n", kho.active);
+	mutex_unlock(&kho.lock);
+
+	return ret;
+}
+KHO_ATTR_RW(active);
+
+static ssize_t dt_max_store(struct kobject *dev, struct kobj_attribute *attr,
+			    const char *buf, size_t size)
+{
+	u64 val;
+
+	if (kstrtoull(buf, 0, &val))
+		return -EINVAL;
+
+	kho.dt_max = val;
+
+	return size;
+}
+
+static ssize_t dt_max_show(struct kobject *dev, struct kobj_attribute *attr,
+			   char *buf)
+{
+	return sysfs_emit(buf, "0x%llx\n", kho.dt_max);
+}
+KHO_ATTR_RW(dt_max);
+
+static ssize_t scratch_len_show(struct kobject *dev, struct kobj_attribute *attr,
+				char *buf)
+{
+	return sysfs_emit(buf, "0x%llx\n", kho_scratch_len);
+}
+KHO_ATTR_RO(scratch_len);
+
+static ssize_t scratch_phys_show(struct kobject *dev, struct kobj_attribute *attr,
+				 char *buf)
+{
+	return sysfs_emit(buf, "0x%llx\n", kho_scratch_phys);
+}
+KHO_ATTR_RO(scratch_phys);
+
+static __init int kho_out_init(void)
+{
+	int ret = 0;
+
+	kho.kobj = kobject_create_and_add("kho", kernel_kobj);
+	if (!kho.kobj) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = sysfs_create_file(kho.kobj, &active_attr.attr);
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_file(kho.kobj, &dt_max_attr.attr);
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_file(kho.kobj, &scratch_phys_attr.attr);
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_file(kho.kobj, &scratch_len_attr.attr);
+	if (ret)
+		goto err;
+
+err:
+	return ret;
+}
+late_initcall(kho_out_init);
+
+static int __init early_kho_scratch(char *p)
+{
+	kho_scratch_size = memparse(p, &p);
+	return 0;
+}
+early_param("kho_scratch", early_kho_scratch);
+
+/**
+ * kho_reserve - Reserve a contiguous chunk of memory for kexec
+ *
+ * With KHO we can preserve arbitrary pages in the system. To ensure we still
+ * have a large contiguous region of memory when we search the physical address
+ * space for target memory, let's make sure we always have a large CMA region
+ * active. This CMA region will only be used for movable pages which are not a
+ * problem for us during KHO because we can just move them somewhere else.
+ */
+__init void kho_reserve(void)
+{
+	int r;
+
+	if (kho_get_fdt()) {
+		/*
+		 * We came from a previous KHO handover, so we already have
+		 * a known good scratch region that we preserve. No need to
+		 * allocate another.
+		 */
+		return;
+	}
+
+	/* Only allocate KHO scratch memory when we're asked to */
+	if (!kho_scratch_size)
+		return;
+
+	r = cma_declare_contiguous_nid(0, kho_scratch_size, 0, PAGE_SIZE, 0,
+				       false, "kho", &kho.cma, NUMA_NO_NODE);
+	if (WARN_ON(r))
+		return;
+
+	kho_scratch_phys = cma_get_base(kho.cma);
+	kho_scratch_len = cma_get_size(kho.cma);
+}
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



