Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F37AE47B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjIZERZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:17:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3BEC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695701832; x=1727237832;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/q/ee1Hi6Rv/vxDVySTbn/n4UowW9g1FmVfGdNU9g4=;
  b=j/2N/ackmH7e4hcyF3jiA5WS7yBNZkMPTp4aXFauuxBf2Q6iGzn2Oc+d
   tSCppyz70t3nBpPzv1CspOMlMCAflhAY2BUKaFFryFRxdem0hO7Fmb1IS
   x6KIhuRKkgMjSnsKrj4DJx499UEigaPIRApNpt/dcMmKbyZk/YrggcRb8
   CEeH1yX4T2F/MVZ73fAK2wF0ftKW+pfIC8vGdHYBbpi9aB1H4ReJXLfAo
   H6qQH20gx2SPas5QhTuK3x7MZt0EWRnGWJtY3dZf9ZCjXcoDQ1lKWsOMQ
   sD+SJXQ90Jq11zseoxvMQlLO35g8MUtEq9xOfcbvoPPXa22WMtxKb25tQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412395812"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412395812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814314520"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="814314520"
Received: from fvivekku-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.18.72])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:17:10 -0700
Subject: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for attestation
 reports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Date:   Mon, 25 Sep 2023 21:17:09 -0700
Message-ID: <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
not more, is to define a configfs interface to retrieve the TSM-specific
blob.

    report=/sys/kernel/config/tsm/report/report0
    mkdir $report
    dd if=binary_userdata_plus_nonce > $report/inblob
    hexdump $report/outblob

This approach later allows for the standardization of the attestation
blob format without needing to invent a new ABI. Once standardization
happens the standard format can be emitted by $report/outblob and
indicated by $report/provider, or a new attribute like
"$report/tcg_coco_report" can emit the standard format alongside the
vendor format.

Review of previous iterations of this interface identified that there is
a need to scale report generation for multiple container environments
[2]. Configfs enables a model where each container can bind mount one or
more report generation item instances. Still, within a container only a
single thread can be manipulating a given configuration instance at a
time. A 'generation' count is provided to detect conflicts between
multiple threads racing to configure a report instance.

The SEV-SNP concepts of "extended reports" and "privilege levels" are
optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
time. The expectation is that those concepts are generic enough that
they may be adopted by other TSM implementations. In other words,
configfs-tsm aims to address a superset of TSM specific functionality
with a common ABI where attributes may appear, or not appear, based on the set
of concepts the implementation supports.

Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/configfs-tsm |   67 +++++
 MAINTAINERS                            |    8 +
 drivers/virt/coco/Kconfig              |    5 
 drivers/virt/coco/Makefile             |    1 
 drivers/virt/coco/tsm.c                |  411 ++++++++++++++++++++++++++++++++
 include/linux/tsm.h                    |   63 +++++
 6 files changed, 555 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-tsm
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
new file mode 100644
index 000000000000..ba81083046d3
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -0,0 +1,67 @@
+What:		/sys/kernel/config/tsm/report/$name/inblob
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Up to 64 bytes of user specified binary data. For replay
+		protection this should include a nonce, but the kernel does not
+		place any restrictions on the content.
+
+What:		/sys/kernel/config/tsm/report/$name/outblob
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Binary attestation report generated from @inblob and other
+		options The format of the report is implementation specific
+		where the implementation is conveyed via the @provider
+		attribute.
+
+What:		/sys/kernel/config/tsm/report/$name/certs
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Zero or more certificates in concatenated PEM format. Refer
+		to implementation specific documentation on which certificates
+		might be returned.
+
+What:		/sys/kernel/config/tsm/report/$name/provider
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) A name for the format-specification of @outblob like
+		"sev-snp" or "tdx" in the near term, or a common standard format
+		in the future.
+
+What:		/sys/kernel/config/tsm/report/$name/generation
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) The value in this attribute increments each time @inblob or
+		any option is written. Userspace can detect conflicts by
+		checking generation before writing to any attribute and making
+		sure the number of writes matches expectations after reading
+		@outblob, or it can prevent conflicts by creating a report
+		instance per requesting context.
+
+What:		/sys/kernel/config/tsm/report/$name/privlevel
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) If a TSM implementation supports the concept of attestation
+		reports for TVMs running at different privilege levels, like
+		SEV-SNP "VMPL", specify the privilege level via this attribute.
+		The minimum acceptable value is conveyed via @privlevel_floor
+		and the maximum acceptable value is TSM_PRIVLEVEL_MAX (3).
+
+What:		/sys/kernel/config/tsm/report/$name/privlevel_floor
+Date:		September, 2023
+KernelVersion:	v6.7
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Indicates the minimum permissible value that can be written
+		to @privlevel.
diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..8acbeb029ba1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21889,6 +21889,14 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-coco@lists.linux.dev
+S:	Maintained
+F:	Documentation/ABI/testing/configfs-tsm
+F:	drivers/virt/coco/tsm.c
+F:	include/linux/tsm.h
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index fc5c64f04c4a..87d142c1f932 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -2,6 +2,11 @@
 #
 # Confidential computing related collateral
 #
+
+config TSM_REPORTS
+	select CONFIGFS_FS
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
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
new file mode 100644
index 000000000000..343fc77d0509
--- /dev/null
+++ b/drivers/virt/coco/tsm.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+#include <linux/configfs.h>
+
+static struct tsm_provider {
+	const struct tsm_ops *ops;
+	const struct config_item_type *type;
+	void *data;
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
+ * invoked infrequently, however configfs allows for multiple agents to
+ * own their own report generation instances to generate reports as
+ * often as needed.
+ *
+ * The attestation report format is TSM provider specific, when / if a standard
+ * materializes that can be published instead of the vendor layout. Until then
+ * the 'provider' attribute indicates the format of 'outblob'. However,
+ * the common "return a list of certs" capability across multiple TSM
+ * implementations is returned in a unified @certs attribute.
+ */
+
+struct tsm_report_state {
+	struct tsm_report report;
+	unsigned long write_generation;
+	unsigned long read_generation;
+	struct config_item cfg;
+};
+
+enum tsm_data_select {
+	TSM_REPORT,
+	TSM_CERTS,
+};
+
+static struct tsm_report *to_tsm_report(struct config_item *cfg)
+{
+	struct tsm_report_state *state =
+		container_of(cfg, struct tsm_report_state, cfg);
+
+	return &state->report;
+}
+
+static struct tsm_report_state *to_state(struct tsm_report *report)
+{
+	return container_of(report, struct tsm_report_state, report);
+}
+
+static int try_advance_write_generation(struct tsm_report *report)
+{
+	struct tsm_report_state *state = to_state(report);
+
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	/*
+	 * Malicious or broken userspace has written enough times for
+	 * read_generation == write_generation by modular arithmetic without an
+	 * interim read. Stop accepting updates until the current report
+	 * configuration is read.
+	 */
+	if (state->write_generation == state->read_generation - 1)
+		return -EBUSY;
+	state->write_generation++;
+	return 0;
+}
+
+static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
+					  const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	/*
+	 * The valid privilege levels that a TSM might accept, if it accepts a
+	 * privilege level setting at all, are a max of TSM_PRIVLEVEL_MAX (see
+	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
+	 * than 0.
+	 */
+	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
+		return -EINVAL;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+	report->desc.privlevel = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, privlevel);
+
+static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
+					       char *buf)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	return sysfs_emit(buf, "%u\n", provider.ops->privlevel_floor);
+}
+CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
+
+static ssize_t tsm_report_inblob_write(struct config_item *cfg,
+				       const void *buf, size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	report->desc.inblob_len = count;
+	memcpy(report->desc.inblob, buf, count);
+	return count;
+}
+CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
+
+static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	struct tsm_report_state *state = to_state(report);
+
+	guard(rwsem_read)(&tsm_rwsem);
+	return sysfs_emit(buf, "%lu\n", state->write_generation);
+}
+CONFIGFS_ATTR_RO(tsm_report_, generation);
+
+static ssize_t tsm_report_provider_show(struct config_item *cfg, char *buf)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	return sysfs_emit(buf, "%s\n", provider.ops->name);
+}
+CONFIGFS_ATTR_RO(tsm_report_, provider);
+
+static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
+			     enum tsm_data_select select)
+{
+	loff_t offset = 0;
+	u8 *out, len;
+
+	if (select == TSM_REPORT) {
+		out = report->outblob;
+		len = report->outblob_len;
+	} else {
+		out = report->certs;
+		len = report->certs_len;
+	}
+
+	if (!buf)
+		return len;
+	return memory_read_from_buffer(buf, count, &offset, out, len);
+}
+
+static ssize_t read_cached_report(struct tsm_report *report, void *buf,
+				  size_t count, enum tsm_data_select select)
+{
+	struct tsm_report_state *state = to_state(report);
+
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!report->desc.inblob_len)
+		return -EINVAL;
+
+	/*
+	 * A given TSM backend always fills in ->outblob regardless of
+	 * whether the report includes certs or not.
+	 */
+	if (!report->outblob ||
+	    state->read_generation != state->write_generation)
+		return -EWOULDBLOCK;
+
+	return __read_report(report, buf, count, select);
+}
+
+static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
+			       size_t count, enum tsm_data_select select)
+{
+	struct tsm_report_state *state = to_state(report);
+	const struct tsm_ops *ops;
+	ssize_t rc;
+
+	/* try to read from the existing report if present and valid... */
+	rc = read_cached_report(report, buf, count, select);
+	if (rc >= 0 || rc != -EWOULDBLOCK)
+		return rc;
+
+	/* slow path, report may need to be regenerated... */
+	guard(rwsem_write)(&tsm_rwsem);
+	ops = provider.ops;
+	if (!report->desc.inblob_len)
+		return -EINVAL;
+
+	/* did another thread already generate this report? */
+	if (report->outblob &&
+	    state->read_generation == state->write_generation)
+		goto out;
+
+	kvfree(report->outblob);
+	kvfree(report->certs);
+	report->outblob = NULL;
+	report->certs = NULL;
+	rc = ops->report_new(report, provider.data);
+	if (rc < 0)
+		return rc;
+	state->read_generation = state->write_generation;
+out:
+	return __read_report(report, buf, count, select);
+}
+
+static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
+				       size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+
+	return tsm_report_read(report, buf, count, TSM_REPORT);
+}
+CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
+
+static ssize_t tsm_report_certs_read(struct config_item *cfg, void *buf,
+				     size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+
+	return tsm_report_read(report, buf, count, TSM_CERTS);
+}
+CONFIGFS_BIN_ATTR_RO(tsm_report_, certs, NULL, TSM_OUTBLOB_MAX);
+
+#define TSM_DEFAULT_ATTRS() \
+	&tsm_report_attr_generation, \
+	&tsm_report_attr_provider
+
+static struct configfs_attribute *tsm_report_attrs[] = {
+	TSM_DEFAULT_ATTRS(),
+	NULL,
+};
+
+static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
+	&tsm_report_attr_inblob,
+	&tsm_report_attr_outblob,
+	&tsm_report_attr_certs,
+	NULL,
+};
+
+static struct configfs_attribute *tsm_report_extra_attrs[] = {
+	TSM_DEFAULT_ATTRS(),
+	&tsm_report_attr_privlevel,
+	&tsm_report_attr_privlevel_floor,
+	NULL,
+};
+
+static void tsm_report_item_release(struct config_item *cfg)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	struct tsm_report_state *state = to_state(report);
+
+	kvfree(report->certs);
+	kvfree(report->outblob);
+	kfree(state);
+}
+
+static struct configfs_item_operations tsm_report_item_ops = {
+	.release = tsm_report_item_release,
+};
+
+const struct config_item_type tsm_report_default_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = tsm_report_bin_attrs,
+	.ct_attrs = tsm_report_attrs,
+	.ct_item_ops = &tsm_report_item_ops,
+};
+EXPORT_SYMBOL_GPL(tsm_report_default_type);
+
+const struct config_item_type tsm_report_ext_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = tsm_report_bin_attrs,
+	.ct_attrs = tsm_report_extra_attrs,
+	.ct_item_ops = &tsm_report_item_ops,
+};
+EXPORT_SYMBOL_GPL(tsm_report_ext_type);
+
+static struct config_item *tsm_report_make_item(struct config_group *group,
+						const char *name)
+{
+	struct tsm_report_state *state;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return ERR_PTR(-ENXIO);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	config_item_init_type_name(&state->cfg, name, provider.type);
+	return &state->cfg;
+}
+
+static struct configfs_group_operations tsm_report_group_ops = {
+	.make_item = tsm_report_make_item,
+};
+
+static const struct config_item_type tsm_reports_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_group_ops = &tsm_report_group_ops,
+};
+
+static const struct config_item_type tsm_root_group_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct configfs_subsystem tsm_configfs = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "tsm",
+			.ci_type = &tsm_root_group_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
+};
+
+static struct config_group *tsm_report_group;
+
+int tsm_register(const struct tsm_ops *ops, void *priv,
+		 const struct config_item_type *type)
+{
+	const struct tsm_ops *conflict;
+
+	if (!type)
+		type = &tsm_report_default_type;
+	if (!(type == &tsm_report_default_type || type == &tsm_report_ext_type))
+		return -EINVAL;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	conflict = provider.ops;
+	if (conflict) {
+		pr_err("\"%s\" ops already registered\n", conflict->name);
+		return -EBUSY;
+	}
+
+	provider.ops = ops;
+	provider.data = priv;
+	provider.type = type;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+int tsm_unregister(const struct tsm_ops *ops)
+{
+	guard(rwsem_write)(&tsm_rwsem);
+	if (ops != provider.ops)
+		return -EBUSY;
+	provider.ops = NULL;
+	provider.data = NULL;
+	provider.type = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static int __init tsm_init(void)
+{
+	struct config_group *root = &tsm_configfs.su_group;
+	struct config_group *tsm;
+	int rc;
+
+	config_group_init(root);
+	rc = configfs_register_subsystem(&tsm_configfs);
+	if (rc)
+		return rc;
+
+	tsm = configfs_register_default_group(root, "report",
+					      &tsm_reports_type);
+	if (IS_ERR(tsm)) {
+		configfs_unregister_subsystem(&tsm_configfs);
+		return PTR_ERR(tsm);
+	}
+	tsm_report_group = tsm;
+
+	return 0;
+}
+module_init(tsm_init);
+
+static void __exit tsm_exit(void)
+{
+	configfs_unregister_default_group(tsm_report_group);
+	configfs_unregister_subsystem(&tsm_configfs);
+}
+module_exit(tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
new file mode 100644
index 000000000000..1fe1dba3a912
--- /dev/null
+++ b/include/linux/tsm.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TSM_H
+#define __TSM_H
+
+#include <linux/sizes.h>
+#include <linux/types.h>
+#include <linux/device.h>
+
+#define TSM_INBLOB_MAX 64
+#define TSM_OUTBLOB_MAX SZ_32K
+
+/*
+ * Privilege level is a nested permission concept to allow confidential
+ * guests to partition address space, 4-levels are supported.
+ */
+#define TSM_PRIVLEVEL_MAX 3
+
+/**
+ * struct tsm_desc - option descriptor for generating tsm report blobs
+ * @privlevel: optional privilege level to associate with @outblob
+ * @inblob_len: sizeof @inblob
+ * @inblob: arbitrary input data
+ */
+struct tsm_desc {
+	unsigned int privlevel;
+	size_t inblob_len;
+	u8 inblob[TSM_INBLOB_MAX];
+};
+
+/**
+ * struct tsm_report - track state of report generation relative to options
+ * @desc: report generation options / cached report state
+ * @outblob: generated evidence to provider to the attestation agent
+ * @outblob_len: sizeof(outblob)
+ * @write_generation: conflict detection, and report regeneration tracking
+ * @read_generation: cached report invalidation tracking
+ * @cfg: configfs interface
+ */
+struct tsm_report {
+	struct tsm_desc desc;
+	size_t outblob_len;
+	u8 *outblob;
+	size_t certs_len;
+	u8 *certs;
+};
+
+/*
+ * arch specific ops, only one is expected to be registered at a time
+ * i.e. only one of SEV, TDX, COVE, etc.
+ */
+struct tsm_ops {
+	const char *name;
+	const int privlevel_floor;
+	int (*report_new)(struct tsm_report *desc, void *data);
+};
+
+extern const struct config_item_type tsm_report_ext_type;
+extern const struct config_item_type tsm_report_default_type;
+
+int tsm_register(const struct tsm_ops *ops, void *priv,
+		 const struct config_item_type *type);
+int tsm_unregister(const struct tsm_ops *ops);
+#endif /* __TSM_H */

