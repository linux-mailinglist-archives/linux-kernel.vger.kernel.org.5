Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8167809F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359189AbjHRKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358942AbjHRKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:24:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3282D65;
        Fri, 18 Aug 2023 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692354276; x=1723890276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vRnjhY4idaLGHahT49Z6weJ5oxQlxlfFyW3kpzSacg=;
  b=HIulrjNu883j0MNFazw0+zxwvAevkeVKFoVv8ksDRtUsMEg+8Vb50Fg6
   Mri2OpdEHkDhyf9acTJV0GMPluFJXpc3t506pwI1Qbnk5wJYhp3kxMRvl
   IPaCOdbarzX37f9ubZl894UOZ/a0tIkKejahz3e+pFTpX2aDkQe5rtsFK
   K/Lr+9p9ZBtVdx3nLOjGwVbvh96BfOuOT8SirD6LvduWOm+TZbM2/TaES
   v219VgmcwQNu+8MqbpsU7Gw82K3lepNGLVs00QCwuNPpMqMxg5p/pHraD
   EdLhngrF5aTSoPOjlMz4MPwZv8l4pyADdy1aT6r16hwk570BcUKvL5ZiY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376829266"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376829266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878636052"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2023 03:24:38 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx@kernel.org,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/2] crypto: qat - add pm_status debugfs file
Date:   Fri, 18 Aug 2023 12:23:09 +0200
Message-ID: <20230818102322.142582-3-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QAT devices implement a mechanism that allows them to go autonomously
to a low power state depending on the load.

Expose power management info by providing the "pm_status" file under
debugfs. This includes PM state, PM event log, PM event counters, PM HW
CSRs, per-resource type constrain counters and per-domain power gating
status specific to the QAT device.

This information is retrieved from (1) the FW by means of
ICP_QAT_FW_PM_INFO command, (2) CSRs and (3) counters collected by the
device driver.

In addition, add logic to keep track and report power management event
interrupts and acks/nacks sent to FW to allow/prevent state transitions.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/debugfs-driver-qat  |   9 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   1 +
 .../intel/qat/qat_common/adf_accel_devices.h  |  13 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  25 ++
 .../intel/qat/qat_common/adf_common_drv.h     |   1 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../crypto/intel/qat/qat_common/adf_gen4_pm.c | 258 ++++++++++++++++++
 .../crypto/intel/qat/qat_common/adf_gen4_pm.h |  34 +++
 .../intel/qat/qat_common/adf_pm_dbgfs.c       |  47 ++++
 .../intel/qat/qat_common/adf_pm_dbgfs.h       |  12 +
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  35 +++
 11 files changed, 438 insertions(+)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h

diff --git a/Documentation/ABI/testing/debugfs-driver-qat b/Documentation/ABI/testing/debugfs-driver-qat
index 6731ffacc5f0..1a21eea414b5 100644
--- a/Documentation/ABI/testing/debugfs-driver-qat
+++ b/Documentation/ABI/testing/debugfs-driver-qat
@@ -59,3 +59,12 @@ Description:	(RO) Read returns the device health status.
 
 		The driver does not monitor for Heartbeat. It is left for a user
 		to poll the status periodically.
+
+What:		/sys/kernel/debug/qat_<device>_<BDF>/pm_status
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	qat-linux@intel.com
+Description:	(RO) Read returns power management information specific to the
+		QAT device.
+
+		This attribute is only available for qat_4xxx devices.
diff --git a/drivers/crypto/intel/qat/qat_common/Makefile b/drivers/crypto/intel/qat/qat_common/Makefile
index 43622c7fca71..3b3a41d2b2a4 100644
--- a/drivers/crypto/intel/qat/qat_common/Makefile
+++ b/drivers/crypto/intel/qat/qat_common/Makefile
@@ -33,6 +33,7 @@ intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o \
 				adf_fw_counters.o \
 				adf_heartbeat.o \
 				adf_heartbeat_dbgfs.o \
+				adf_pm_dbgfs.o \
 				adf_dbgfs.o
 
 intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index e57abde66f4f..fd5107e92853 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -291,6 +291,18 @@ struct adf_dc_data {
 	dma_addr_t ovf_buff_p;
 };
 
+struct adf_pm {
+	struct dentry *debugfs_pm_status;
+	bool present;
+	int idle_irq_counters;
+	int throttle_irq_counters;
+	int fw_irq_counters;
+	int host_ack_counter;
+	int host_nack_counter;
+	ssize_t (*print_pm_status)(struct adf_accel_dev *accel_dev, char __user *buf, size_t count,
+				   loff_t *pos);
+};
+
 struct adf_accel_dev {
 	struct adf_etr_data *transport;
 	struct adf_hw_device_data *hw_device;
@@ -298,6 +310,7 @@ struct adf_accel_dev {
 	struct adf_fw_loader_data *fw_loader;
 	struct adf_admin_comms *admin;
 	struct adf_dc_data *dc_data;
+	struct adf_pm power_management;
 	struct list_head crypto_list;
 	struct list_head compression_list;
 	unsigned long status;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index ff790823b868..a718713d4f1e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -348,6 +348,31 @@ int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay)
 	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
 }
 
+int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr, size_t buff_size)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct icp_qat_fw_init_admin_req req = { };
+	struct icp_qat_fw_init_admin_resp resp;
+	u32 ae_mask = hw_data->admin_ae_mask;
+	int ret;
+
+	/* Query pm info via init/admin cmd */
+	if (!accel_dev->admin) {
+		dev_err(&GET_DEV(accel_dev), "adf_admin is not available\n");
+		return -EFAULT;
+	}
+
+	req.cmd_id = ICP_QAT_FW_PM_INFO;
+	req.init_cfg_sz = buff_size;
+	req.init_cfg_ptr = p_state_addr;
+
+	ret = adf_send_admin(accel_dev, &req, &resp, ae_mask);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "Failed to query power-management info\n");
+
+	return ret;
+}
+
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 {
 	struct adf_admin_comms *admin;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 673b5044c62a..4f991c7a7b26 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -93,6 +93,7 @@ int adf_init_admin_pm(struct adf_accel_dev *accel_dev, u32 idle_delay);
 int adf_send_admin_tim_sync(struct adf_accel_dev *accel_dev, u32 cnt);
 int adf_send_admin_hb_timer(struct adf_accel_dev *accel_dev, uint32_t ticks);
 int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp);
+int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr, size_t buff_size);
 int adf_init_arb(struct adf_accel_dev *accel_dev);
 void adf_exit_arb(struct adf_accel_dev *accel_dev);
 void adf_update_ring_arb(struct adf_etr_ring_data *ring);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
index 04845f8d72be..395bb493f20c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.c
@@ -8,6 +8,7 @@
 #include "adf_dbgfs.h"
 #include "adf_fw_counters.h"
 #include "adf_heartbeat_dbgfs.h"
+#include "adf_pm_dbgfs.h"
 
 /**
  * adf_dbgfs_init() - add persistent debugfs entries
@@ -62,6 +63,7 @@ void adf_dbgfs_add(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->is_vf) {
 		adf_fw_counters_dbgfs_add(accel_dev);
 		adf_heartbeat_dbgfs_add(accel_dev);
+		adf_pm_dbgfs_add(accel_dev);
 	}
 }
 
@@ -75,6 +77,7 @@ void adf_dbgfs_rm(struct adf_accel_dev *accel_dev)
 		return;
 
 	if (!accel_dev->is_vf) {
+		adf_pm_dbgfs_rm(accel_dev);
 		adf_heartbeat_dbgfs_rm(accel_dev);
 		adf_fw_counters_dbgfs_rm(accel_dev);
 	}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
index 3bde8759c2a2..911aca862798 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
@@ -1,8 +1,15 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2022 Intel Corporation */
 #include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
+#include <linux/fs.h>
 #include <linux/iopoll.h>
 #include <linux/kstrtox.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/string_helpers.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 
 #include "adf_accel_devices.h"
@@ -28,6 +35,7 @@ static int send_host_msg(struct adf_accel_dev *accel_dev)
 {
 	char pm_idle_support_cfg[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {};
 	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	struct adf_pm *pm = &accel_dev->power_management;
 	bool pm_idle_support;
 	u32 msg;
 	int ret;
@@ -42,6 +50,11 @@ static int send_host_msg(struct adf_accel_dev *accel_dev)
 	if (ret)
 		pm_idle_support = true;
 
+	if (pm_idle_support)
+		pm->host_ack_counter++;
+	else
+		pm->host_nack_counter++;
+
 	/* Send HOST_MSG */
 	msg = FIELD_PREP(ADF_GEN4_PM_MSG_PAYLOAD_BIT_MASK,
 			 pm_idle_support ? PM_SET_MIN : PM_NO_CHANGE);
@@ -62,17 +75,27 @@ static void pm_bh_handler(struct work_struct *work)
 		container_of(work, struct adf_gen4_pm_data, pm_irq_work);
 	struct adf_accel_dev *accel_dev = pm_data->accel_dev;
 	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	struct adf_pm *pm = &accel_dev->power_management;
 	u32 pm_int_sts = pm_data->pm_int_sts;
 	u32 val;
 
 	/* PM Idle interrupt */
 	if (pm_int_sts & ADF_GEN4_PM_IDLE_STS) {
+		pm->idle_irq_counters++;
 		/* Issue host message to FW */
 		if (send_host_msg(accel_dev))
 			dev_warn_ratelimited(&GET_DEV(accel_dev),
 					     "Failed to send host msg to FW\n");
 	}
 
+	/* PM throttle interrupt */
+	if (pm_int_sts & ADF_GEN4_PM_THR_STS)
+		pm->throttle_irq_counters++;
+
+	/* PM fw interrupt */
+	if (pm_int_sts & ADF_GEN4_PM_FW_INT_STS)
+		pm->fw_irq_counters++;
+
 	/* Clear interrupt status */
 	ADF_CSR_WR(pmisc, ADF_GEN4_PM_INTERRUPT, pm_int_sts);
 
@@ -132,6 +155,9 @@ int adf_gen4_enable_pm(struct adf_accel_dev *accel_dev)
 	if (ret)
 		return ret;
 
+	/* Initialize PM internal data */
+	adf_gen4_init_dev_pm_data(accel_dev);
+
 	/* Enable default PM interrupts: IDLE, THROTTLE */
 	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_INTERRUPT);
 	val |= ADF_GEN4_PM_INT_EN_DEFAULT;
@@ -148,3 +174,235 @@ int adf_gen4_enable_pm(struct adf_accel_dev *accel_dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(adf_gen4_enable_pm);
+
+#ifdef CONFIG_DEBUG_FS
+/*
+ * This is needed because a variable is used to index the mask at pm_scnprint_table(), making it not
+ * compile time constant, so the compile asserts from FIELD_GET() or u32_get_bits() won't be
+ * fulfilled.
+ */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
+#define PM_INFO_MEMBER_OFF(member)	\
+	(offsetof(struct icp_qat_fw_init_admin_pm_info, member) / sizeof(u32))
+
+#define PM_INFO_REGSET_ENTRY_MASK(_reg_, _field_, _mask_)	\
+{								\
+	.reg_offset = PM_INFO_MEMBER_OFF(_reg_),		\
+	.key = __stringify(_field_),				\
+	.field_mask = _mask_,					\
+}
+
+#define PM_INFO_REGSET_ENTRY32(_reg_, _field_)	\
+	PM_INFO_REGSET_ENTRY_MASK(_reg_, _field_, GENMASK(31, 0))
+
+#define PM_INFO_REGSET_ENTRY(_reg_, _field_)	\
+	PM_INFO_REGSET_ENTRY_MASK(_reg_, _field_, ADF_GEN4_PM_##_field_##_MASK)
+
+#define PM_INFO_MAX_KEY_LEN	21
+
+struct pm_status_row {
+	int reg_offset;
+	u32 field_mask;
+	const char *key;
+};
+
+static struct pm_status_row pm_fuse_rows[] = {
+	PM_INFO_REGSET_ENTRY(fusectl0, ENABLE_PM),
+	PM_INFO_REGSET_ENTRY(fusectl0, ENABLE_PM_IDLE),
+	PM_INFO_REGSET_ENTRY(fusectl0, ENABLE_DEEP_PM_IDLE),
+};
+
+static struct pm_status_row pm_info_rows[] = {
+	PM_INFO_REGSET_ENTRY(pm.status, CPM_PM_STATE),
+	PM_INFO_REGSET_ENTRY(pm.status, PENDING_WP),
+	PM_INFO_REGSET_ENTRY(pm.status, CURRENT_WP),
+	PM_INFO_REGSET_ENTRY(pm.fw_init, IDLE_ENABLE),
+	PM_INFO_REGSET_ENTRY(pm.fw_init, IDLE_FILTER),
+	PM_INFO_REGSET_ENTRY(pm.main, MIN_PWR_ACK),
+	PM_INFO_REGSET_ENTRY(pm.thread, MIN_PWR_ACK_PENDING),
+	PM_INFO_REGSET_ENTRY(pm.main, THR_VALUE),
+};
+
+static struct pm_status_row pm_ssm_rows[] = {
+	PM_INFO_REGSET_ENTRY(ssm.pm_enable, SSM_PM_ENABLE),
+	PM_INFO_REGSET_ENTRY32(ssm.active_constraint, ACTIVE_CONSTRAINT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_domain_status, DOMAIN_POWER_GATED),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, ATH_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, CPH_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, PKE_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, CPR_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, DCPR_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, UCS_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, XLT_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, WAT_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_active_status, WCP_ACTIVE_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, ATH_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, CPH_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, PKE_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, CPR_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, DCPR_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, UCS_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, XLT_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, WAT_MANAGED_COUNT),
+	PM_INFO_REGSET_ENTRY(ssm.pm_managed_status, WCP_MANAGED_COUNT),
+};
+
+static struct pm_status_row pm_log_rows[] = {
+	PM_INFO_REGSET_ENTRY32(event_counters.host_msg, HOST_MSG_EVENT_COUNT),
+	PM_INFO_REGSET_ENTRY32(event_counters.sys_pm, SYS_PM_EVENT_COUNT),
+	PM_INFO_REGSET_ENTRY32(event_counters.local_ssm, SSM_EVENT_COUNT),
+	PM_INFO_REGSET_ENTRY32(event_counters.timer, TIMER_EVENT_COUNT),
+	PM_INFO_REGSET_ENTRY32(event_counters.unknown, UNKNOWN_EVENT_COUNT),
+};
+
+static struct pm_status_row pm_event_rows[ICP_QAT_NUMBER_OF_PM_EVENTS] = {
+	PM_INFO_REGSET_ENTRY32(event_log[0], EVENT0),
+	PM_INFO_REGSET_ENTRY32(event_log[1], EVENT1),
+	PM_INFO_REGSET_ENTRY32(event_log[2], EVENT2),
+	PM_INFO_REGSET_ENTRY32(event_log[3], EVENT3),
+	PM_INFO_REGSET_ENTRY32(event_log[4], EVENT4),
+	PM_INFO_REGSET_ENTRY32(event_log[5], EVENT5),
+	PM_INFO_REGSET_ENTRY32(event_log[6], EVENT6),
+	PM_INFO_REGSET_ENTRY32(event_log[7], EVENT7),
+};
+
+static struct pm_status_row pm_csrs_rows[] = {
+	PM_INFO_REGSET_ENTRY32(pm.fw_init, CPM_PM_FW_INIT),
+	PM_INFO_REGSET_ENTRY32(pm.status, CPM_PM_STATUS),
+	PM_INFO_REGSET_ENTRY32(pm.main, CPM_PM_MASTER_FW),
+	PM_INFO_REGSET_ENTRY32(pm.pwrreq, CPM_PM_PWRREQ),
+};
+
+static int pm_scnprint_table(char *buff, struct pm_status_row *table, u32 *pm_info_regs,
+			     size_t buff_size, int table_len, bool lowercase)
+{
+	char key[PM_INFO_MAX_KEY_LEN];
+	int wr = 0;
+	int i;
+
+	for (i = 0; i < table_len; i++) {
+		if (lowercase)
+			string_lower(key, table[i].key);
+		else
+			string_upper(key, table[i].key);
+
+		wr += scnprintf(&buff[wr], buff_size - wr, "%s: %#x\n", key,
+				field_get(table[i].field_mask, pm_info_regs[table[i].reg_offset]));
+	}
+
+	return wr;
+}
+
+static int pm_scnprint_table_upper_keys(char *buff, struct pm_status_row *table, u32 *pm_info_regs,
+					size_t buff_size, int table_len)
+{
+	return pm_scnprint_table(buff, table, pm_info_regs, buff_size, table_len, false);
+}
+
+static int pm_scnprint_table_lower_keys(char *buff, struct pm_status_row *table, u32 *pm_info_regs,
+					size_t buff_size, int table_len)
+{
+	return pm_scnprint_table(buff, table, pm_info_regs, buff_size, table_len, true);
+}
+
+static_assert(sizeof(struct icp_qat_fw_init_admin_pm_info) < PAGE_SIZE);
+
+static ssize_t adf_gen4_print_pm_status(struct adf_accel_dev *accel_dev, char __user *buf,
+					size_t count, loff_t *pos)
+{
+	void __iomem *pmisc = adf_get_pmisc_base(accel_dev);
+	struct adf_pm *pm = &accel_dev->power_management;
+	struct icp_qat_fw_init_admin_pm_info *pm_info;
+	dma_addr_t p_state_addr;
+	u32 *pm_info_regs;
+	char *pm_kv;
+	int len;
+	u32 val;
+	int ret;
+
+	pm_info = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!pm_info)
+		return -ENOMEM;
+
+	pm_kv = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!pm_kv) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	p_state_addr = dma_map_single(&GET_DEV(accel_dev), pm_info, PAGE_SIZE, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(&GET_DEV(accel_dev), p_state_addr);
+	if (ret)
+		goto out_free;
+
+	/* Query PM info from QAT FW */
+	ret = adf_get_pm_info(accel_dev, p_state_addr, PAGE_SIZE);
+	dma_unmap_single(&GET_DEV(accel_dev), p_state_addr, PAGE_SIZE, DMA_FROM_DEVICE);
+	if (ret)
+		goto out_free;
+
+	pm_info_regs = (u32 *)pm_info;
+
+	/* Fusectl related */
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "----------- PM Fuse info ---------\n");
+	len += pm_scnprint_table_lower_keys(&pm_kv[len], pm_fuse_rows, pm_info_regs,
+					    PAGE_SIZE - len, ARRAY_SIZE(pm_fuse_rows));
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "max_pwrreq: %#x\n", pm_info->max_pwrreq);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "min_pwrreq: %#x\n", pm_info->min_pwrreq);
+
+	/* PM related */
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "------------  PM Info ------------\n");
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "power_level: %s\n",
+			 pm_info->pwr_state == PM_SET_MIN ? "min" : "max");
+	len += pm_scnprint_table_lower_keys(&pm_kv[len], pm_info_rows, pm_info_regs,
+					    PAGE_SIZE - len, ARRAY_SIZE(pm_info_rows));
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "pm_mode: STATIC\n");
+
+	/* SSM related */
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "----------- SSM_PM Info ----------\n");
+	len += pm_scnprint_table_lower_keys(&pm_kv[len], pm_ssm_rows, pm_info_regs, PAGE_SIZE - len,
+					    ARRAY_SIZE(pm_ssm_rows));
+
+	/* Log related */
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "------------- PM Log -------------\n");
+	len += pm_scnprint_table_lower_keys(&pm_kv[len], pm_log_rows, pm_info_regs, PAGE_SIZE - len,
+					    ARRAY_SIZE(pm_log_rows));
+
+	len += pm_scnprint_table_lower_keys(&pm_kv[len], pm_event_rows, pm_info_regs,
+					    PAGE_SIZE - len, ARRAY_SIZE(pm_event_rows));
+
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "idle_irq_count: %#x\n",
+			 pm->idle_irq_counters);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "fw_irq_count: %#x\n",
+			 pm->fw_irq_counters);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "throttle_irq_count: %#x\n",
+			 pm->throttle_irq_counters);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "host_ack_count: %#x\n",
+			 pm->host_ack_counter);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "host_nack_count: %#x\n",
+			 pm->host_nack_counter);
+
+	/* CSRs content */
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "----------- HW PM CSRs -----------\n");
+	len += pm_scnprint_table_upper_keys(&pm_kv[len], pm_csrs_rows, pm_info_regs,
+					    PAGE_SIZE - len, ARRAY_SIZE(pm_csrs_rows));
+
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_HOST_MSG);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "CPM_PM_HOST_MSG: %#x\n", val);
+	val = ADF_CSR_RD(pmisc, ADF_GEN4_PM_INTERRUPT);
+	len += scnprintf(&pm_kv[len], PAGE_SIZE - len, "CPM_PM_INTERRUPT: %#x\n", val);
+	ret = simple_read_from_buffer(buf, count, pos, pm_kv, len);
+
+out_free:
+	kfree(pm_info);
+	kfree(pm_kv);
+	return ret;
+}
+#endif
+
+void adf_gen4_init_dev_pm_data(struct adf_accel_dev *accel_dev)
+{
+	accel_dev->power_management.print_pm_status = adf_gen4_print_pm_status;
+	accel_dev->power_management.present = true;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
index 39d37b352b45..0d57b52cc9e6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h
@@ -41,7 +41,41 @@ struct adf_accel_dev;
 #define ADF_GEN4_PM_MAX_IDLE_FILTER		(0x7)
 #define ADF_GEN4_PM_DEFAULT_IDLE_SUPPORT	(0x1)
 
+/* PM CSRs fields masks */
+#define ADF_GEN4_PM_DOMAIN_POWER_GATED_MASK	GENMASK(15, 0)
+#define ADF_GEN4_PM_SSM_PM_ENABLE_MASK		GENMASK(15, 0)
+#define ADF_GEN4_PM_IDLE_FILTER_MASK		GENMASK(5, 3)
+#define ADF_GEN4_PM_IDLE_ENABLE_MASK		BIT(2)
+#define ADF_GEN4_PM_ENABLE_PM_MASK		BIT(21)
+#define ADF_GEN4_PM_ENABLE_PM_IDLE_MASK		BIT(22)
+#define ADF_GEN4_PM_ENABLE_DEEP_PM_IDLE_MASK	BIT(23)
+#define ADF_GEN4_PM_CURRENT_WP_MASK		GENMASK(19, 11)
+#define ADF_GEN4_PM_CPM_PM_STATE_MASK		GENMASK(22, 20)
+#define ADF_GEN4_PM_PENDING_WP_MASK		GENMASK(31, 23)
+#define ADF_GEN4_PM_THR_VALUE_MASK		GENMASK(6, 4)
+#define ADF_GEN4_PM_MIN_PWR_ACK_MASK		BIT(7)
+#define ADF_GEN4_PM_MIN_PWR_ACK_PENDING_MASK	BIT(17)
+#define ADF_GEN4_PM_CPR_ACTIVE_COUNT_MASK	BIT(0)
+#define ADF_GEN4_PM_CPR_MANAGED_COUNT_MASK	BIT(0)
+#define ADF_GEN4_PM_XLT_ACTIVE_COUNT_MASK	BIT(1)
+#define ADF_GEN4_PM_XLT_MANAGED_COUNT_MASK	BIT(1)
+#define ADF_GEN4_PM_DCPR_ACTIVE_COUNT_MASK	GENMASK(3, 2)
+#define ADF_GEN4_PM_DCPR_MANAGED_COUNT_MASK	GENMASK(3, 2)
+#define ADF_GEN4_PM_PKE_ACTIVE_COUNT_MASK	GENMASK(8, 4)
+#define ADF_GEN4_PM_PKE_MANAGED_COUNT_MASK	GENMASK(8, 4)
+#define ADF_GEN4_PM_WAT_ACTIVE_COUNT_MASK	GENMASK(13, 9)
+#define ADF_GEN4_PM_WAT_MANAGED_COUNT_MASK	GENMASK(13, 9)
+#define ADF_GEN4_PM_WCP_ACTIVE_COUNT_MASK	GENMASK(18, 14)
+#define ADF_GEN4_PM_WCP_MANAGED_COUNT_MASK	GENMASK(18, 14)
+#define ADF_GEN4_PM_UCS_ACTIVE_COUNT_MASK	GENMASK(20, 19)
+#define ADF_GEN4_PM_UCS_MANAGED_COUNT_MASK	GENMASK(20, 19)
+#define ADF_GEN4_PM_CPH_ACTIVE_COUNT_MASK	GENMASK(24, 21)
+#define ADF_GEN4_PM_CPH_MANAGED_COUNT_MASK	GENMASK(24, 21)
+#define ADF_GEN4_PM_ATH_ACTIVE_COUNT_MASK	GENMASK(28, 25)
+#define ADF_GEN4_PM_ATH_MANAGED_COUNT_MASK	GENMASK(28, 25)
+
 int adf_gen4_enable_pm(struct adf_accel_dev *accel_dev);
 bool adf_gen4_handle_pm_interrupt(struct adf_accel_dev *accel_dev);
+void adf_gen4_init_dev_pm_data(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
new file mode 100644
index 000000000000..7c1049481fd5
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation */
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+
+#include "adf_accel_devices.h"
+#include "adf_common_drv.h"
+#include "adf_pm_dbgfs.h"
+
+static ssize_t pm_status_read(struct file *f, char __user *buf, size_t count, loff_t *pos)
+{
+	struct adf_accel_dev *accel_dev = file_inode(f)->i_private;
+	struct adf_pm pm = accel_dev->power_management;
+
+	if (pm.print_pm_status)
+		return pm.print_pm_status(accel_dev, buf, count, pos);
+
+	return count;
+}
+
+static const struct file_operations pm_status_fops = {
+	.owner = THIS_MODULE,
+	.read = pm_status_read,
+};
+
+void adf_pm_dbgfs_add(struct adf_accel_dev *accel_dev)
+{
+	struct adf_pm *pm = &accel_dev->power_management;
+
+	if (!pm->present)
+		return;
+
+	pm->debugfs_pm_status = debugfs_create_file("pm_status", 0400, accel_dev->debugfs_dir,
+						    accel_dev, &pm_status_fops);
+}
+
+void adf_pm_dbgfs_rm(struct adf_accel_dev *accel_dev)
+{
+	struct adf_pm *pm = &accel_dev->power_management;
+
+	if (!pm->present)
+		return;
+
+	debugfs_remove(pm->debugfs_pm_status);
+	pm->debugfs_pm_status = NULL;
+}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h
new file mode 100644
index 000000000000..83632e5aa097
--- /dev/null
+++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation */
+
+#ifndef ADF_PM_DBGFS_H_
+#define ADF_PM_DBGFS_H_
+
+struct adf_accel_dev;
+
+void adf_pm_dbgfs_rm(struct adf_accel_dev *accel_dev);
+void adf_pm_dbgfs_add(struct adf_accel_dev *accel_dev);
+
+#endif /* ADF_PM_DBGFS_H_ */
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index 3e968a4bcc9c..791be0203797 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -19,6 +19,7 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_HEARTBEAT_TIMER_SET = 13,
 	ICP_QAT_FW_TIMER_GET = 19,
 	ICP_QAT_FW_PM_STATE_CONFIG = 128,
+	ICP_QAT_FW_PM_INFO = 129,
 };
 
 enum icp_qat_fw_init_admin_resp_status {
@@ -107,4 +108,38 @@ struct icp_qat_fw_init_admin_resp {
 
 #define ICP_QAT_FW_SYNC ICP_QAT_FW_HEARTBEAT_SYNC
 
+#define ICP_QAT_NUMBER_OF_PM_EVENTS 8
+
+struct icp_qat_fw_init_admin_pm_info {
+	__u16 max_pwrreq;
+	__u16 min_pwrreq;
+	__u16 resvrd1;
+	__u8 pwr_state;
+	__u8 resvrd2;
+	__u32 fusectl0;
+	struct_group(event_counters,
+		__u32 sys_pm;
+		__u32 host_msg;
+		__u32 unknown;
+		__u32 local_ssm;
+		__u32 timer;
+	);
+	__u32 event_log[ICP_QAT_NUMBER_OF_PM_EVENTS];
+	struct_group(pm,
+		__u32 fw_init;
+		__u32 pwrreq;
+		__u32 status;
+		__u32 main;
+		__u32 thread;
+	);
+	struct_group(ssm,
+		__u32 pm_enable;
+		__u32 pm_active_status;
+		__u32 pm_managed_status;
+		__u32 pm_domain_status;
+		__u32 active_constraint;
+	);
+	__u32 resvrd3[6];
+};
+
 #endif
-- 
2.41.0

