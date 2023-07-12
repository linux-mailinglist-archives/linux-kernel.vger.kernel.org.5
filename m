Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF67513DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGLXAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGLW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:59:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F412E;
        Wed, 12 Jul 2023 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202794; x=1720738794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Qv2uMgMLgqfymJOFZE91HzK/mJ3VfgaRQzWfNJ3U+k=;
  b=WWYS5du4o4NExFuSlGuUn5029RSrCWfYeiUe1hELStgcRn5a+I9g1+ll
   TemIoEKFOefF2QNT8PxfFy7uNJmum7xNF0TdR6oeTiWFQRQhkbpHrOg05
   b6ytomsauQL1jl69xywjt3Z/xWrFjgESdpkGJtsc9yeeejmCCvRXArZq4
   FCodOyoE9R1shhL1RyjJJDoh2Mne6H5uBu62VS95QfRbBws3Pf/9+mOXI
   x1OAfP+pR444GXvsDBbMB6YZaEYGMFTfjLp15zKu4e9qbcfZEeU6zGNg2
   uh85Y3xnfC9OBzUpD4lp/1CQVUujwr+/PflJ/TX8b7zpY+SFHUH6dG82t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431172822"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431172822"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 15:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866316695"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866316695"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 15:59:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/3] platform/x86/intel/tpmi: Add debugfs interface
Date:   Wed, 12 Jul 2023 15:59:49 -0700
Message-Id: <20230712225950.171326-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs interface for debugging TPMI configuration and register
contents. This shows PFS (PM Feature structure) for each TPMI device.

For each feature, show full register contents and allow to modify
register at an offset.

This debugfs interface is not present on locked down kernel with no
DEVMEM access and without CAP_SYS_RAWIO permission.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3
Changes suggested by Andy
- Use common macro for size
- optimize tpmi_mem_dump_show
- ignore return value of debugfs_create_dir

v2_update
- I missed one change suggested in last review, sorry about that.
  This is for local variable declarations.

v2
- Check for locked down kernel and permissions
- Move help to documentation folder
- Cosmetic changes
- size check

 drivers/platform/x86/intel/tpmi.c | 219 +++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 01868f3bcaba..0a95736d97e4 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -48,13 +48,16 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/intel_tpmi.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/security.h>
 #include <linux/sizes.h>
+#include <linux/string_helpers.h>
 
 #include "vsec.h"
 
@@ -87,12 +90,14 @@ struct intel_tpmi_pfs_entry {
  * @vsec_offset: Starting MMIO address for this feature in bytes. Essentially
  *		 this offset = "Address" from VSEC header + PFS Capability
  *		 offset for this feature entry.
+ * @vsec_dev:	Pointer to intel_vsec_device structure for this TPMI device
  *
  * Represents TPMI instance information for one TPMI ID.
  */
 struct intel_tpmi_pm_feature {
 	struct intel_tpmi_pfs_entry pfs_header;
 	unsigned int vsec_offset;
+	struct intel_vsec_device *vsec_dev;
 };
 
 /**
@@ -103,6 +108,7 @@ struct intel_tpmi_pm_feature {
  * @pfs_start:		Start of PFS offset for the TPMI instances in this device
  * @plat_info:		Stores platform info which can be used by the client drivers
  * @tpmi_control_mem:	Memory mapped IO for getting control information
+ * @dbgfs_dir:		debugfs entry pointer
  *
  * Stores the information for all TPMI devices enumerated from a single PCI device.
  */
@@ -113,6 +119,7 @@ struct intel_tpmi_info {
 	u64 pfs_start;
 	struct intel_tpmi_plat_info plat_info;
 	void __iomem *tpmi_control_mem;
+	struct dentry *dbgfs_dir;
 };
 
 /**
@@ -333,6 +340,188 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
 
+static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
+{
+	struct intel_tpmi_info *tpmi_info = s->private;
+	struct intel_tpmi_pm_feature *pfs;
+	int locked, disabled, ret, i;
+
+	seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info->pfs_start);
+	seq_puts(s, "tpmi_id\t\tentries\t\tsize\t\tcap_offset\tattribute\tvsec_offset\tlocked\tdisabled\n");
+	for (i = 0; i < tpmi_info->feature_count; ++i) {
+		pfs = &tpmi_info->tpmi_features[i];
+		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked,
+					       &disabled);
+		if (ret) {
+			locked = 'U';
+			disabled = 'U';
+		} else {
+			disabled = disabled ? 'Y' : 'N';
+			locked = locked ? 'Y' : 'N';
+		}
+		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\n",
+			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
+			   pfs->pfs_header.entry_size, pfs->pfs_header.cap_offset,
+			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(tpmi_pfs_dbg);
+
+#define MEM_DUMP_COLUMN_COUNT	8
+
+static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
+{
+	size_t row_size = MEM_DUMP_COLUMN_COUNT * sizeof(u32);
+	struct intel_tpmi_pm_feature *pfs = s->private;
+	int count, ret = 0;
+	void __iomem *mem;
+	u32 off, size;
+	u8 *buffer;
+
+	size = TPMI_GET_SINGLE_ENTRY_SIZE(pfs);
+	if (!size)
+		return -EIO;
+
+	buffer = kmalloc(size, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	off = pfs->vsec_offset;
+
+	mutex_lock(&tpmi_dev_lock);
+
+	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {
+		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
+
+		mem = ioremap(off, size);
+		if (!mem) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy_fromio(buffer, mem, size);
+
+		seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size, sizeof(u32), buffer, size,
+			     false);
+
+		iounmap(mem);
+
+		off += size;
+	}
+
+	mutex_unlock(&tpmi_dev_lock);
+
+	kfree(buffer);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(tpmi_mem_dump);
+
+static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t len, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct intel_tpmi_pm_feature *pfs = m->private;
+	u32 addr, value, punit, size;
+	u32 num_elems, *array;
+	void __iomem *mem;
+	int ret;
+
+	size = TPMI_GET_SINGLE_ENTRY_SIZE(pfs);
+	if (!size)
+		return -EIO;
+
+	ret = parse_int_array_user(userbuf, len, (int **)&array);
+	if (ret < 0)
+		return ret;
+
+	num_elems = *array;
+	if (num_elems != 3) {
+		ret = -EINVAL;
+		goto exit_write;
+	}
+
+	punit = array[1];
+	addr = array[2];
+	value = array[3];
+
+	if (punit >= pfs->pfs_header.num_entries) {
+		ret = -EINVAL;
+		goto exit_write;
+	}
+
+	if (addr >= size) {
+		ret = -EINVAL;
+		goto exit_write;
+	}
+
+	mutex_lock(&tpmi_dev_lock);
+
+	mem = ioremap(pfs->vsec_offset + punit * size, size);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto unlock_mem_write;
+	}
+
+	writel(value, mem + addr);
+
+	iounmap(mem);
+
+	ret = len;
+
+unlock_mem_write:
+	mutex_unlock(&tpmi_dev_lock);
+
+exit_write:
+	kfree(array);
+
+	return ret;
+}
+
+static int mem_write_show(struct seq_file *s, void *unused)
+{
+	return 0;
+}
+
+static int mem_write_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mem_write_show, inode->i_private);
+}
+
+static const struct file_operations mem_write_ops = {
+	.open           = mem_write_open,
+	.read           = seq_read,
+	.write          = mem_write,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+#define tpmi_to_dev(info)	(&info->vsec_dev->pcidev->dev)
+
+static void tpmi_dbgfs_register(struct intel_tpmi_info *tpmi_info)
+{
+	char name[64];
+	int i;
+
+	snprintf(name, sizeof(name), "tpmi-%s", dev_name(tpmi_to_dev(tpmi_info)));
+	tpmi_info->dbgfs_dir = debugfs_create_dir(name, NULL);
+
+	debugfs_create_file("pfs_dump", 0444, tpmi_info->dbgfs_dir, tpmi_info, &tpmi_pfs_dbg_fops);
+
+	for (i = 0; i < tpmi_info->feature_count; ++i) {
+		struct intel_tpmi_pm_feature *pfs;
+		struct dentry *dir;
+
+		pfs = &tpmi_info->tpmi_features[i];
+		snprintf(name, sizeof(name), "tpmi-id-%02x", pfs->pfs_header.tpmi_id);
+		dir = debugfs_create_dir(name, tpmi_info->dbgfs_dir);
+
+		debugfs_create_file("mem_dump", 0444, dir, pfs, &tpmi_mem_dump_fops);
+		debugfs_create_file("mem_write", 0644, dir, pfs, &mem_write_ops);
+	}
+}
+
 static void tpmi_set_control_base(struct auxiliary_device *auxdev,
 				  struct intel_tpmi_info *tpmi_info,
 				  struct intel_tpmi_pm_feature *pfs)
@@ -493,7 +682,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 	struct pci_dev *pci_dev = vsec_dev->pcidev;
 	struct intel_tpmi_info *tpmi_info;
 	u64 pfs_start = 0;
-	int i;
+	int ret, i;
 
 	tpmi_info = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_info), GFP_KERNEL);
 	if (!tpmi_info)
@@ -516,6 +705,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		int size, ret;
 
 		pfs = &tpmi_info->tpmi_features[i];
+		pfs->vsec_dev = vsec_dev;
 
 		res = &vsec_dev->resource[i];
 		if (!res)
@@ -553,7 +743,20 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 
 	auxiliary_set_drvdata(auxdev, tpmi_info);
 
-	return tpmi_create_devices(tpmi_info);
+	ret = tpmi_create_devices(tpmi_info);
+	if (ret)
+		return ret;
+
+	/*
+	 * Allow debugfs when security policy allows. Everything this debugfs
+	 * interface provides, can also be done via /dev/mem access. If
+	 * /dev/mem interface is locked, don't allow debugfs to present any
+	 * information. Also check for CAP_SYS_RAWIO as /dev/mem interface.
+	 */
+	if (!security_locked_down(LOCKDOWN_DEV_MEM) && capable(CAP_SYS_RAWIO))
+		tpmi_dbgfs_register(tpmi_info);
+
+	return 0;
 }
 
 static int tpmi_probe(struct auxiliary_device *auxdev,
@@ -562,11 +765,12 @@ static int tpmi_probe(struct auxiliary_device *auxdev,
 	return intel_vsec_tpmi_init(auxdev);
 }
 
-/*
- * Remove callback is not needed currently as there is no
- * cleanup required. All memory allocs are device managed. All
- * devices created by this modules are also device managed.
- */
+static void tpmi_remove(struct auxiliary_device *auxdev)
+{
+	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(auxdev);
+
+	debugfs_remove_recursive(tpmi_info->dbgfs_dir);
+}
 
 static const struct auxiliary_device_id tpmi_id_table[] = {
 	{ .name = "intel_vsec.tpmi" },
@@ -577,6 +781,7 @@ MODULE_DEVICE_TABLE(auxiliary, tpmi_id_table);
 static struct auxiliary_driver tpmi_aux_driver = {
 	.id_table	= tpmi_id_table,
 	.probe		= tpmi_probe,
+	.remove         = tpmi_remove,
 };
 
 module_auxiliary_driver(tpmi_aux_driver);
-- 
2.40.1

