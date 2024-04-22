Return-Path: <linux-kernel+bounces-152957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17648AC69C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BAB282F17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744F52F9A;
	Mon, 22 Apr 2024 08:18:16 +0000 (UTC)
Received: from mail-m127104.qiye.163.com (mail-m127104.qiye.163.com [115.236.127.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D14F60D;
	Mon, 22 Apr 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773895; cv=none; b=U9vbzU94AjeYKX1U2z/78huBo5DyFrayo099kY0Jnxj079t7Q2TQea7frT/RTGtql2iGr9r1/s/lesqe7HlbstYTYow52e9V7v0I5z9Qsm0AvN9JB469Fr7+pHciYDp9ZGGKbFsb3S1aLVPKNDSwuYvzPFTIa89cjVc8uadWQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773895; c=relaxed/simple;
	bh=+uhCAuMBch6NqAg0S0WaqlwhFKvYJe1RVreC07HCrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltTtoBUU/jtIVbrGW5nDdEcXRABmimXoqFFdO97SDcdSZOmc6umaxDCTbG6n87f3vsO/YVceiQekhzB3fPPx662pAvOXydTrtcRwustKMnQ9I+PhH3wFhxMGTHf9udShMmEbU8Y0pDoLJtmXypoU1g8R4bat7/a2aXF6J43BkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 11E7B86014C;
	Mon, 22 Apr 2024 15:01:32 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl/memdev: Only show sanitize sysfs files when supported
Date: Mon, 22 Apr 2024 07:01:22 +0000
Message-Id: <20240422070125.52519-2-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
References: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRlDVhhCH0hNHhkfHkgfGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f049c224b023ckunm11e7b86014c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06Ojo6EDc*FRwxSRw#GUJM
	TDAwFDdVSlVKTEpITE1CSUJJQkNNVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTEJKTzcG

From: Davidlohr Bueso <dave@stgolabs.net>

If the device does not support Sanitize or Secure Erase commands,
hide the respective sysfs interfaces such that the operation can
never be attempted.

In order to be generic, keep track of the enabled security commands
found in the CEL - the driver does not support Security Passthrough.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230726051940.3570-4-dave@stgolabs.net
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  6 ++--
 drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               | 19 +++++++++++
 drivers/cxl/cxlmem.h                    | 15 +++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c4c4acb1f3b3..087f762ebfd5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -86,7 +86,8 @@ Description:
 		HPA ranges. This permits avoiding explicit global CPU cache
 		management, relying instead for it to be done when a region
 		transitions between software programmed and hardware committed
-		states.
+		states. If this file is not present, then there is no hardware
+		support for the operation.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -101,7 +102,8 @@ Description:
 		HPA ranges. This permits avoiding explicit global CPU cache
 		management, relying instead for it to be done when a region
 		transitions between software programmed and hardware committed
-		states.
+		states. If this file is not present, then there is no hardware
+		support for the operation.
 
 
 What:		/sys/bus/cxl/devices/memX/firmware/
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..ca60bb8114f2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -121,6 +121,45 @@ static bool cxl_is_security_command(u16 opcode)
 	return false;
 }
 
+static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
+					 u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_SANITIZE:
+		set_bit(CXL_SEC_ENABLED_SANITIZE, security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SECURE_ERASE:
+		set_bit(CXL_SEC_ENABLED_SECURE_ERASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_GET_SECURITY_STATE:
+		set_bit(CXL_SEC_ENABLED_GET_SECURITY_STATE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SET_PASSPHRASE:
+		set_bit(CXL_SEC_ENABLED_SET_PASSPHRASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
+		set_bit(CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_UNLOCK:
+		set_bit(CXL_SEC_ENABLED_UNLOCK, security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+		set_bit(CXL_SEC_ENABLED_FREEZE_SECURITY,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
+		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+			security->enabled_cmds);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -677,7 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd && !cxl_is_poison_command(opcode)) {
+		if (!cmd && (!cxl_is_poison_command(opcode) ||
+			     !cxl_is_security_command(opcode))) {
 			dev_dbg(dev,
 				"Opcode 0x%04x unsupported by driver\n", opcode);
 			continue;
@@ -689,6 +729,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cxl_is_poison_command(opcode))
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
 
+		if (cxl_is_security_command(opcode))
+			cxl_set_security_cmd_enabled(&mds->security, opcode);
+
 		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..14b547c07f54 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -477,9 +477,28 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static umode_t cxl_memdev_security_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_security_sanitize.attr &&
+	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+		return 0;
+
+	if (a == &dev_attr_security_erase.attr &&
+	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
+		return 0;
+
+	return a->mode;
+}
+
 static struct attribute_group cxl_memdev_security_attribute_group = {
 	.name = "security",
 	.attrs = cxl_memdev_security_attributes,
+	.is_visible = cxl_memdev_security_visible,
 };
 
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f3aca828fbec..706f8a6d1ef4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -244,6 +244,19 @@ enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_MAX
 };
 
+/* Device enabled security commands */
+enum security_cmd_enabled_bits {
+	CXL_SEC_ENABLED_SANITIZE,
+	CXL_SEC_ENABLED_SECURE_ERASE,
+	CXL_SEC_ENABLED_GET_SECURITY_STATE,
+	CXL_SEC_ENABLED_SET_PASSPHRASE,
+	CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
+	CXL_SEC_ENABLED_UNLOCK,
+	CXL_SEC_ENABLED_FREEZE_SECURITY,
+	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+	CXL_SEC_ENABLED_MAX
+};
+
 /**
  * struct cxl_poison_state - Driver poison state info
  *
@@ -346,6 +359,7 @@ struct cxl_fw_state {
  * struct cxl_security_state - Device security state
  *
  * @state: state of last security operation
+ * @enabled_cmds: All security commands enabled in the CEL
  * @poll: polling for sanitization is enabled, device has no mbox irq support
  * @poll_tmo_secs: polling timeout
  * @poll_dwork: polling work item
@@ -353,6 +367,7 @@ struct cxl_fw_state {
  */
 struct cxl_security_state {
 	unsigned long state;
+	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
 	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
-- 
2.34.1


