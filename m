Return-Path: <linux-kernel+bounces-80709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D89866B87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F7F1F218D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBF1EB23;
	Mon, 26 Feb 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0B09g7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E231DA4C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934201; cv=none; b=jk04uK8Z0QOY+EyS9e/B8XLiGsCxWo0Eee5EyZmvC3UQmDKdODP+DTXBgz5uhO042papM2mfAmQ/58TUbS82tzPbXAmrXSlL9wQRks+5wWrfEdYgHkOyz+BE+Nf2XkmWhAGyKuTY4WFfCZhbH5wO6F8KbInyFpR/IHvKbkf36Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934201; c=relaxed/simple;
	bh=uE82V7ALJEh6YbcZHKPkW1JfSaTNugCii6axmE6/KB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSCkbmeBsGvQXXrqW4leToG4OztClUvnpW2nhUOSuJuaWWv6lRwgQ5rqNooAEph1eqGgjMInZVjA29eH6YPjLKTcppKzqaA4YkPqD9H9HceiRWmHhkQiw7B9fqDaF1o6sk5oPlgeuwCMo2ez9lTssXJ6S7PQEtcoKV5P4Y0kRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0B09g7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF62C433A6;
	Mon, 26 Feb 2024 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934201;
	bh=uE82V7ALJEh6YbcZHKPkW1JfSaTNugCii6axmE6/KB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0B09g7oOEEkok7UDIEEw42RiBTfWG8UuWwYvIcv9A1968j2znBcBjyjRMt+c59B7
	 m5M0U8zI4CM7zNWUnXmiFnA6Tl7Z0yxA83eVEF5okukdBXw6EWLEW+3npWFXvj++T7
	 hk6Sr+5SNnsewKMZ4LCAl/yEHN34OdIbZ22r/fZ7KG3VB1Wa4ERCFMI5ZuDFJmf/oJ
	 9EnjkQLDlK7gmQSAlJAKsg0rU62sZBL42uM0xtlg+Xueven5FvaEUs6HWgWif14mdz
	 70kitcs9Gxh3uhgKmGzMopmJZxvp8OFc8C7YllhPtYXM1/96EzQYL7Ohilaj6k1SrT
	 MNVqQVKlt1Iyw==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Carl Vanderlip <quic_carlv@quicinc.com>
Cc: Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/3] accel/habanalabs/gaudi2: use single function to compare FW versions
Date: Mon, 26 Feb 2024 09:56:26 +0200
Message-Id: <20240226075626.1222534-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226075626.1222534-1-ogabbay@kernel.org>
References: <20240226075626.1222534-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ohad Sharabi <osharabi@habana.ai>

Currently, the code contains 2 types of FW version comparison functions:
- hl_is_fw_sw_ver_[below/equal_or_greater]()
- gaudi2 specific function of the type
  gaudi2_is_fw_ver_[below/above]x_y_z()

Moreover, some functions use the inner FW version which should be only
stage during development but not version dependencies.

This commit aligns all APIs to a single function that just compares the
version and return an integers indicator (similar in some way to
strcmp()).

In addition, this generic function now considers also the sub-minor FW
version.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 25 +++++++++++++++++++
 drivers/accel/habanalabs/common/habanalabs.h  | 20 +--------------
 drivers/accel/habanalabs/gaudi2/gaudi2.c      |  6 ++---
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 4bd02778a970..348418643709 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -40,6 +40,31 @@ static char *comms_sts_str_arr[COMMS_STS_INVLD_LAST] = {
 	[COMMS_STS_TIMEOUT_ERR] = __stringify(COMMS_STS_TIMEOUT_ERR),
 };
 
+/**
+ * hl_fw_version_cmp() - compares the FW version to a specific version
+ *
+ * @hdev: pointer to hl_device structure
+ * @major: major number of a reference version
+ * @minor: minor number of a reference version
+ * @subminor: sub-minor number of a reference version
+ *
+ * Return 1 if FW version greater than the reference version, -1 if it's
+ *         smaller and 0 if versions are identical.
+ */
+int hl_fw_version_cmp(struct hl_device *hdev, u32 major, u32 minor, u32 subminor)
+{
+	if (hdev->fw_sw_major_ver != major)
+		return (hdev->fw_sw_major_ver > major) ? 1 : -1;
+
+	if (hdev->fw_sw_minor_ver != minor)
+		return (hdev->fw_sw_minor_ver > minor) ? 1 : -1;
+
+	if (hdev->fw_sw_sub_minor_ver != subminor)
+		return (hdev->fw_sw_sub_minor_ver > subminor) ? 1 : -1;
+
+	return 0;
+}
+
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 48f0f3eea1ef..55495861f432 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -3596,25 +3596,6 @@ struct hl_ioctl_desc {
 	hl_ioctl_t *func;
 };
 
-static inline bool hl_is_fw_sw_ver_below(struct hl_device *hdev, u32 fw_sw_major, u32 fw_sw_minor)
-{
-	if (hdev->fw_sw_major_ver < fw_sw_major)
-		return true;
-	if (hdev->fw_sw_major_ver > fw_sw_major)
-		return false;
-	if (hdev->fw_sw_minor_ver < fw_sw_minor)
-		return true;
-	return false;
-}
-
-static inline bool hl_is_fw_sw_ver_equal_or_greater(struct hl_device *hdev, u32 fw_sw_major,
-							u32 fw_sw_minor)
-{
-	return (hdev->fw_sw_major_ver > fw_sw_major ||
-			(hdev->fw_sw_major_ver == fw_sw_major &&
-					hdev->fw_sw_minor_ver >= fw_sw_minor));
-}
-
 /*
  * Kernel module functions that can be accessed by entire module
  */
@@ -3919,6 +3900,7 @@ void hl_mmu_dr_flush(struct hl_ctx *ctx);
 int hl_mmu_dr_init(struct hl_device *hdev);
 void hl_mmu_dr_fini(struct hl_device *hdev);
 
+int hl_fw_version_cmp(struct hl_device *hdev, u32 major, u32 minor, u32 subminor);
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode, u64 value);
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index c99edbf9f4ca..ba1518f2bf5c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -3783,7 +3783,7 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 	prop->supports_compute_reset = true;
 
 	/* Event queue sanity check added in FW version 1.11 */
-	if (hl_is_fw_sw_ver_below(hdev, 1, 11))
+	if (hl_fw_version_cmp(hdev, 1, 11, 0) < 0)
 		hdev->event_queue.check_eqe_index = false;
 	else
 		hdev->event_queue.check_eqe_index = true;
@@ -7879,7 +7879,7 @@ static bool gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 	bool has_block_id = false;
 	u16 block_id;
 
-	if (!hl_is_fw_sw_ver_below(hdev, 1, 12))
+	if (hl_fw_version_cmp(hdev, 1, 12, 0) >= 0)
 		has_block_id = true;
 
 	ecc_address = le64_to_cpu(ecc_data->ecc_address);
@@ -10029,7 +10029,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		error_count = gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
-		if (hl_is_fw_sw_ver_equal_or_greater(hdev, 1, 13))
+		if (hl_fw_version_cmp(hdev, 1, 13, 0) >= 0)
 			is_critical = true;
 		break;
 
-- 
2.34.1


