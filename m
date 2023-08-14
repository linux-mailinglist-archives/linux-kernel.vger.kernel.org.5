Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5747377B2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjHNHnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjHNHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D494
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691999002; x=1723535002;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zY66xLrmMWMjDhtbcf1ZxgbaaYJikE/LWLqE99EjbEk=;
  b=SnflGIwT/oBiKJSH/GyFeJHeDxqg0+8Fhvrikn7Hu01CLC2VCKF/hCnv
   B7eFN38V/syqjdm1oL3vl8eRqeXFdbFTqP7VLAHXRsObBpGHxJc5BLloo
   GVjbxyHnaxbUXVT8GoEnVxt35wNGf5blQuLo0TM3gN0OkxK/AIJDzn7CQ
   vwBOa1OyRUUK/y3WavQz8hzCZoA/wLeoNjGW4ByGvZmAaUTG8ysegWBVn
   IRjrGDyZqH4GU/dglB6FTx6BvBdZkMhYVuSMObcMMji7Za+paCWWx8QbR
   atXuLghJTdt0iv3E+iYO3XVcmPXkZcKoo592a+TzIfMJaDCebAN0MSkD9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438314715"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438314715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="907142086"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="907142086"
Received: from navanban-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.127.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:21 -0700
Subject: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation reports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 00:43:21 -0700
Message-ID: <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the common operations of a TSM (Trusted Security Module) is to
provide a way for a TVM (confidential computing guest execution
environment) to take a measurement of its launch state, sign it and
submit it to a verifying party. Upon successful attestation that
verifies the integrity of the TVM additional secrets may be deployed.
The concept is common across TSMs, but the implementations are
unfortunately vendor specific. While the industry grapples with a common
definition of this attestation format [1], Linux need not make this
problem worse by defining a new ABI per TSM that wants to perform a
similar operation. The current momentum has been to invent new ioctl-ABI
per TSM per function which at best is an abdication of the kernel's
responsibility to make common infrastructure concepts share common ABI.

The proposal, targeted to conceptually work with TDX, SEV, COVE if not
more, is to define a sysfs interface to retrieve the TSM-specific blob.

    echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
    hexdump /sys/class/tsm/tsm0/outblob

This approach later allows for the standardization of the attestation
blob format without needing to change the Linux ABI. Until then, the
format of 'outblob' is determined by the parent device for 'tsm0'.

The expectation is that this is a boot time exchange that need not be
regenerated, making it amenable to a sysfs interface. In case userspace
does try to generate multiple attestation reports it includes conflict
detection so userspace can be sure no other thread changed the
parameters from its last configuration step to the blob retrieval.

TSM specific options are encoded as 'extra' attributes on the TSM device
with the expectation that vendors reuse the same options for similar
concepts. The current options are defined by SEV-SNP's need for a
'privilege level' concept (VMPL), and the option to retrieve a
certificate chain in addition to the attestation report ("extended"
format).

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
 MAINTAINERS                               |    8 +
 drivers/virt/coco/Kconfig                 |    4 
 drivers/virt/coco/Makefile                |    1 
 drivers/virt/coco/tdx-guest/Kconfig       |    1 
 drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
 include/linux/tsm.h                       |   45 +++++
 7 files changed, 396 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..37017bde626d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,47 @@
+What:		/sys/class/tsm/tsm0/inhex
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Hex encoded userdata to be included in the attestation
+		report. For replay protection this should include a nonce, but
+		the kernel does not place any restrictions on the content.
+
+What:		/sys/class/tsm/tsm0/outblob
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Binary attestation report generated from @inhex translated
+		to binary and any options. The format of the report is vendor
+		specific and determined by the parent device of 'tsm0'.
+
+What:		/sys/class/tsm/tsm0/generation
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The value in this attribute increments each time @inhex or
+		any option is written. Userspace can detect conflicts by
+		checking generation before writing to any attribute and making
+		sure the number of writes matches expectations after reading
+		@outblob.
+
+What:		/sys/class/tsm/tsm0/privlevel
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) If a TSM implementation supports the concept of attestation
+		reports for TVMs running at different privilege levels, like
+		SEV-SNP "VMPL", specify the privilege level via this attribute.
+
+What:		/sys/class/tsm/tsm0/format
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) If a TSM implementation supports the concept of attestation
+		reports with "extended" contents, like SEV-SNP extended reports
+		with certificate chains, specify "extended" vs "default" via
+		this attribute.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..97f74d344c8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21625,6 +21625,14 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-coco@lists.linux.dev
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-tsm
+F:	drivers/virt/coco/tsm.c
+F:	include/linux/tsm.h
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index fc5c64f04c4a..d92f07019f38 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -2,6 +2,10 @@
 #
 # Confidential computing related collateral
 #
+
+config TSM_REPORTS
+	tristate
+
 source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 55302ef719ad..18c1aba5edb7 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,6 +2,7 @@
 #
 # Confidential computing related collateral
 #
+obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
index 14246fc2fb02..22dd59e19431 100644
--- a/drivers/virt/coco/tdx-guest/Kconfig
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -1,6 +1,7 @@
 config TDX_GUEST_DRIVER
 	tristate "TDX Guest driver"
 	depends on INTEL_TDX_GUEST
+	select TSM_REPORTS
 	help
 	  The driver provides userspace interface to communicate with
 	  the TDX module to request the TDX guest details like attestation
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
new file mode 100644
index 000000000000..1bf2ee82eb94
--- /dev/null
+++ b/drivers/virt/coco/tsm.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+struct class *tsm_class;
+static struct tsm_provider {
+	const struct tsm_ops *ops;
+	struct device *dev;
+} provider;
+static DECLARE_RWSEM(tsm_rwsem);
+
+/**
+ * DOC: Trusted Security Module (TSM) Attestation Report Interface
+ *
+ * The TSM report interface is a common provider of blobs that facilitate
+ * attestation of a TVM (confidential computing guest) by an attestation
+ * service. A TSM report combines a user-defined blob (likely a public-key with
+ * a nonce for a key-exchange protocol) with a signed attestation report. That
+ * combined blob is then used to obtain secrets provided by an agent that can
+ * validate the attestation report. The expectation is that this interface is
+ * invoked infrequently, likely only once at TVM boot time.
+ *
+ * The attestation report format is TSM provider specific, when / if a standard
+ * materializes that can be published instead of the vendor layout.
+ */
+
+/**
+ * struct tsm_report - track state of report generation relative to options
+ * @desc: report generation options / cached report state
+ * @outblob: generated evidence to provider to the attestation agent
+ * @outblob_len: sizeof(outblob)
+ * @write_generation: conflict detection, and report regeneration tracking
+ * @read_generation: cached report invalidation tracking
+ */
+struct tsm_report {
+	struct tsm_desc desc;
+	size_t outblob_len;
+	u8 *outblob;
+	unsigned long write_generation;
+	unsigned long read_generation;
+} tsm_report;
+
+static ssize_t privlevel_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
+{
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	if (tsm_report.desc.privlevel == val)
+		return len;
+	tsm_report.desc.privlevel = val;
+	tsm_report.write_generation++;
+
+	return len;
+}
+
+static ssize_t privlevel_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%u\n", tsm_report.desc.privlevel);
+}
+
+static DEVICE_ATTR_RW(privlevel);
+
+static ssize_t format_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	enum tsm_format format;
+
+	if (sysfs_streq(buf, "default"))
+		format = TSM_FORMAT_DEFAULT;
+	else if (sysfs_streq(buf, "extended"))
+		format = TSM_FORMAT_EXTENDED;
+	else
+		return -EINVAL;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	if (tsm_report.desc.outblob_format == format)
+		return len;
+	tsm_report.desc.outblob_format = format;
+	tsm_report.write_generation++;
+
+	return len;
+}
+
+static ssize_t format_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	if (tsm_report.desc.outblob_format == TSM_FORMAT_DEFAULT)
+		return sysfs_emit(buf, "default\n");
+	return sysfs_emit(buf, "extended\n");
+}
+
+static DEVICE_ATTR_RW(format);
+
+static struct attribute *tsm_extra_attributes[] = {
+	&dev_attr_format.attr,
+	&dev_attr_privlevel.attr,
+	NULL,
+};
+
+struct attribute_group tsm_extra_attribute_group = {
+	.attrs = tsm_extra_attributes,
+};
+EXPORT_SYMBOL_GPL(tsm_extra_attribute_group);
+
+/*
+ * Input is a small hex blob, rather than a writable binary attribute, so that
+ * it is conveyed atomically.
+ */
+static ssize_t inhex_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	u8 inblob[TSM_INBLOB_MAX];
+	size_t inblob_len;
+	int rc;
+
+	inblob_len = len;
+	if (buf[len - 1] == '\n')
+		inblob_len--;
+	if (inblob_len & 1)
+		return -EINVAL;
+	inblob_len /= 2;
+	if (inblob_len > TSM_INBLOB_MAX)
+		return -EINVAL;
+
+	rc = hex2bin(inblob, buf, inblob_len);
+	if (rc < 0)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	if (memcmp(tsm_report.desc.inblob, inblob, inblob_len) == 0)
+		return len;
+	memcpy(tsm_report.desc.inblob, inblob, inblob_len);
+	tsm_report.desc.inblob_len = inblob_len;
+	tsm_report.write_generation++;
+
+	return len;
+}
+
+static ssize_t inhex_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	char *end;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!tsm_report.desc.inblob_len)
+		return 0;
+	end = bin2hex(buf, tsm_report.desc.inblob, tsm_report.desc.inblob_len);
+	*end++ = '\n';
+	return end - buf;
+}
+static DEVICE_ATTR_RW(inhex);
+
+static ssize_t generation_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	return sysfs_emit(buf, "%lu\n", tsm_report.write_generation);
+}
+static DEVICE_ATTR_RO(generation);
+
+static struct attribute *tsm_attributes[] = {
+	&dev_attr_inhex.attr,
+	&dev_attr_generation.attr,
+	NULL,
+};
+
+static ssize_t outblob_read(struct file *f, struct kobject *kobj,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t offset, size_t count)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!tsm_report.desc.inblob_len)
+		return -EINVAL;
+
+	if (!tsm_report.outblob ||
+	    tsm_report.read_generation != tsm_report.write_generation) {
+		const struct tsm_ops *ops = provider.ops;
+		size_t outblob_len;
+		u8 *outblob;
+
+		kvfree(tsm_report.outblob);
+		outblob = ops->report_new(provider.dev->parent,
+					  &tsm_report.desc, &outblob_len);
+		if (IS_ERR(outblob))
+			return PTR_ERR(outblob);
+		tsm_report.outblob_len = outblob_len;
+		tsm_report.outblob = outblob;
+		tsm_report.read_generation = tsm_report.write_generation;
+	}
+
+	return memory_read_from_buffer(buf, count, &offset,
+				       tsm_report.outblob,
+				       tsm_report.outblob_len);
+}
+static BIN_ATTR_RO(outblob, 0);
+
+static struct bin_attribute *tsm_bin_attributes[] = {
+	&bin_attr_outblob,
+	NULL,
+};
+
+struct attribute_group tsm_default_attribute_group = {
+	.bin_attrs = tsm_bin_attributes,
+	.attrs = tsm_attributes,
+};
+EXPORT_SYMBOL_GPL(tsm_default_attribute_group);
+
+static const struct attribute_group *tsm_default_attribute_groups[] = {
+	&tsm_default_attribute_group,
+	NULL,
+};
+
+int register_tsm(const struct tsm_ops *ops, struct device *parent,
+		 const struct attribute_group **groups)
+{
+	const struct tsm_ops *conflict;
+	struct device *dev;
+	int rc;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!groups)
+		groups = tsm_default_attribute_groups;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	conflict = provider.ops;
+	if (conflict) {
+		pr_err("\"%s\" ops already registered\n", conflict->name);
+		return rc;
+	}
+
+	dev = device_create_with_groups(tsm_class, parent, 0, NULL, groups,
+					"tsm0");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	provider.ops = ops;
+	provider.dev = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_tsm);
+
+int unregister_tsm(const struct tsm_ops *ops)
+{
+	guard(rwsem_write)(&tsm_rwsem);
+	if (ops != provider.ops)
+		return -EBUSY;
+	provider.ops = NULL;
+	device_unregister(provider.dev);
+	provider.dev = NULL;
+	kvfree(tsm_report.outblob);
+	tsm_report.outblob = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unregister_tsm);
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	return PTR_ERR_OR_ZERO(tsm_class);
+}
+module_init(tsm_init);
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via sysfs");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
new file mode 100644
index 000000000000..6dc2f07543b8
--- /dev/null
+++ b/include/linux/tsm.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TSM_H
+#define __TSM_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+#define TSM_INBLOB_MAX 64
+
+enum tsm_format {
+	TSM_FORMAT_DEFAULT,
+	TSM_FORMAT_EXTENDED,
+};
+
+/**
+ * struct tsm_desc - option descriptor for generating tsm report blobs
+ * @privlevel: optional privilege level to associate with @outblob
+ * @inblob_len: sizeof @inblob
+ * @inblob: arbitrary input data
+ * @outblob_format: for TSMs with an "extended" format
+ */
+struct tsm_desc {
+	unsigned int privlevel;
+	size_t inblob_len;
+	u8 inblob[TSM_INBLOB_MAX];
+	enum tsm_format outblob_format;
+};
+
+/*
+ * arch specific ops, only one is expected to be registered at a time
+ * i.e. only one of SEV, TDX, COVE, etc.
+ */
+struct tsm_ops {
+	const char *name;
+	u8 *(*report_new)(struct device *dev, const struct tsm_desc *desc,
+			  size_t *outblob_len);
+};
+
+extern struct attribute_group tsm_default_attribute_group;
+extern struct attribute_group tsm_extra_attribute_group;
+
+int register_tsm(const struct tsm_ops *ops, struct device *parent,
+		 const struct attribute_group **groups);
+int unregister_tsm(const struct tsm_ops *ops);
+#endif /* __TSM_H */

