Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3A7678C8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjG1XAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjG1XAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:00:33 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D3E198A;
        Fri, 28 Jul 2023 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690585228; x=1722121228;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=OGwkzgJQziWMw/+lEEi2YDn3TUr7J59nLJwjAeM5WFA=;
  b=f5tgJM13zj2klxlSX98dyV1xnrnrol8O939HwsR3xsI6vYBOCvaf8lLk
   0Fp3psxIR1JHTmNUGI8ZJ1955wjDesWjmAQMA/xPiZnhqfMTsnHW5DTqc
   SyD1LyZpVn0W1LyCfKtKkO/1GFQgwBMxgFzfQ1wTMK55F35wJv2f3qrvM
   ZuHsG8l31y1uKFt+NB4Moamt+ol3v3R/+GukRAJ5ICDGQh0FFiJ/n4B5+
   jGgN8JGRyHmPanMeicvoBF1QCPcNETzCfbKAOKfIhG9tM5dCalOS36kFy
   642tJcjudR7mZu/NOPwFQRvpMvwH7vSWMDKnLtTV/hdjrrJb7qDPbkJNr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455058663"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="455058663"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="793064994"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="793064994"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.98.123])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:00:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 28 Jul 2023 16:00:12 -0700
Subject: [PATCH] cxl/memdev: Avoid mailbox functionality on device memory
 CXL devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-cxl-fix-devmemdev-v1-1-dbd3269b3295@intel.com>
X-B4-Tracking: v=1; b=H4sIAHtIxGQC/x2N0QqDMBAEf0XuuQdppFX7K6UPMa71wKQlJyKI/
 96zLwvDMsxOiiJQelQ7Fayi8skG10tFcQr5DZbBmLzztWt8y3GbeZSNB6wJyZZvztURnW/Ge0v
 m9UHBfQk5TqeZgi4o5/EtMPMfe76O4wdc34kNfAAAAA==
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690585226; l=7848;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=OGwkzgJQziWMw/+lEEi2YDn3TUr7J59nLJwjAeM5WFA=;
 b=xg85+dOWSgwxdbBDBxuTlZfIZIOR1ZSIDsS7MAoZUkEdEvUUME05nXUkq7idBIK4XhIt/TmAU
 F/YiLI3717UB5q8LZuAzpUYnpCxTuXJgh7YZU4jdMWx+SNoUXtLGh6z
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the proposed type-2 cxl-test device[1] the following
splat was observed:

  BUG: kernel NULL pointer dereference, address: 0000000000000278
  [...]
  RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
  [...]
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x149/0x420
   ? fixup_exception+0x22/0x310
   ? kernelmode_fixup_or_oops+0x84/0x110
   ? exc_page_fault+0x6d/0x150
   ? asm_exc_page_fault+0x22/0x30
   ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
   cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
   platform_probe+0x40/0x90
   really_probe+0x19e/0x3e0
   ? __pfx___driver_attach+0x10/0x10
   __driver_probe_device+0x78/0x160
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x63/0xa0
   bus_add_driver+0x112/0x210
   driver_register+0x55/0x100
   ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
   [...]

Commit f6b8ab32e3ec made the mailbox functionality optional.  However,
some mailbox functionality was merged after that patch.  Therefore some
mailbox functionality can be accessed on a device which did not set up
the mailbox.

While no devices currently exist, commit f6b8ab32e3ec is incomplete.
Complete the checks for memdev state to bring the code to a consistent
state for when type-2 devices are introduced.

[1] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/

Fixes: f6b8ab32e3ec ("cxl/memdev: Make mailbox functionality optional")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c   |  9 +++++++++
 drivers/cxl/core/memdev.c | 26 ++++++++++++++++++++++++++
 drivers/cxl/mem.c         | 18 ++++++++++--------
 drivers/cxl/pci.c         |  5 ++++-
 drivers/cxl/pmem.c        |  3 +++
 5 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..eb1758fb8cdf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -482,6 +482,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 
 	dev_dbg(dev, "Query IOCTL\n");
 
+	if (!mds)
+		return -EIO;
+
 	if (get_user(n_commands, &q->n_commands))
 		return -EFAULT;
 
@@ -586,6 +589,9 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 
 	dev_dbg(dev, "Send IOCTL\n");
 
+	if (!mds)
+		return -EIO;
+
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
@@ -1245,6 +1251,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
+	if (!mds)
+		return -EIO;
+
 	rc = mutex_lock_interruptible(&mds->poison.lock);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..629e479f751b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -201,6 +201,19 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+static umode_t cxl_memdev_security_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (!mds)
+		return 0;
+
+	return a->mode;
+}
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -332,6 +345,9 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	struct cxl_region *cxlr;
 	int rc;
 
+	if (!mds)
+		return -EIO;
+
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
@@ -380,6 +396,9 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	struct cxl_region *cxlr;
 	int rc;
 
+	if (!mds)
+		return -EIO;
+
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
@@ -480,6 +499,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 static struct attribute_group cxl_memdev_security_attribute_group = {
 	.name = "security",
 	.attrs = cxl_memdev_security_attributes,
+	.is_visible = cxl_memdev_security_visible,
 };
 
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
@@ -542,6 +562,9 @@ static void cxl_memdev_security_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return;
+
 	if (mds->security.poll)
 		cancel_delayed_work_sync(&mds->security.poll_dwork);
 }
@@ -997,6 +1020,9 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	struct device *dev = &cxlmd->dev;
 	struct kernfs_node *sec;
 
+	if (!mds)
+		return 0;
+
 	sec = sysfs_get_dirent(dev->kobj.sd, "security");
 	if (!sec) {
 		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..4755a890018d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -132,12 +132,14 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -222,8 +224,8 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 		struct cxl_memdev_state *mds =
 			to_cxl_memdev_state(cxlmd->cxlds);
 
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
+		if (!mds || !test_bit(CXL_POISON_ENABLED_LIST,
+				      mds->poison.enabled_cmds))
 			return 0;
 	}
 	return a->mode;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..93f6140432cd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -122,7 +122,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
-	if (!cxl_mbox_background_complete(cxlds))
+	if (!mds || !cxl_mbox_background_complete(cxlds))
 		return IRQ_NONE;
 
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
@@ -624,6 +624,9 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	u32 status;
 
+	if (!mds)
+		return IRQ_HANDLED;
+
 	do {
 		/*
 		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 7cb8994f8809..f1adfdd1a2b3 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -70,6 +70,9 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
+	if (WARN_ON_ONCE(!mds))
+		return -EIO;
+
 	set_exclusive_cxl_commands(mds, exclusive_cmds);
 	rc = devm_add_action_or_reset(dev, clear_exclusive, mds);
 	if (rc)

---
base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
change-id: 20230728-cxl-fix-devmemdev-5003ce927f68

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

