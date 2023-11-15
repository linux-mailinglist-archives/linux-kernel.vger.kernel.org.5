Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7388B7EC8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKOQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKOQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135838E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78672C433C7;
        Wed, 15 Nov 2023 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066358;
        bh=CeqcgqbPmKuc6ujFnqT9hCYTQXV2xrXzIPAKrvqD3A8=;
        h=From:To:Cc:Subject:Date:From;
        b=FKGTa0ne/R38V0DiQupeeWYJNf6oPa+bN6URqC6pwh2/K2mCGtfVLQTNrxNXaRUrp
         729EnLgDLA1DOhh5+/+hyqUotvOgn/Fih3rk5ZeO2znvbrSKV1qtZ/m8AZ7pIVRgoI
         62byx0R6AbopsK13tD4OaaJAgIn/taFmabWLklii9mxM7tOuiEmTuVp/4mWzf+NH7w
         dBKyUZveGnvUudEcmaAstcAgHtDb/FxaQaKpwkfTXeFPXaCyFiz2fgtMHDamu7pF+K
         OkbGe9MpySfbk+uVKrpnn/N1pXqK8Ad/gWTMOH4C29VrMipWhSP3LEtgQytYZR4PZl
         NX4OC9+9HgxjQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 01/10] accel/habanalabs/gaudi2: assume hard-reset by FW upon PCIe AXI drain
Date:   Wed, 15 Nov 2023 18:39:03 +0200
Message-Id: <20231115163912.1243175-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

When a PCIe AXI drain event happens, it is possible that the driver
cannot access the device through PCIe, and therefore cannot send a
hard-reset request to FW.
Starting from FW version 1.13, FW will initiate a hard-reset in such
a case without waiting for a reset request from the driver.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 8 ++++++++
 drivers/accel/habanalabs/gaudi2/gaudi2.c     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 1655c101c705..5c69a482b8de 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -3594,6 +3594,14 @@ static inline bool hl_is_fw_sw_ver_below(struct hl_device *hdev, u32 fw_sw_major
 	return false;
 }
 
+static inline bool hl_is_fw_sw_ver_equal_or_greater(struct hl_device *hdev, u32 fw_sw_major,
+							u32 fw_sw_minor)
+{
+	return (hdev->fw_sw_major_ver > fw_sw_major ||
+			(hdev->fw_sw_major_ver == fw_sw_major &&
+					hdev->fw_sw_minor_ver >= fw_sw_minor));
+}
+
 /*
  * Kernel module functions that can be accessed by entire module
  */
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 819660c684cf..b739078c2d87 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10007,6 +10007,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		error_count = gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		if (hl_is_fw_sw_ver_equal_or_greater(hdev, 1, 13))
+			is_critical = true;
 		break;
 
 	case GAUDI2_EVENT_PSOC59_RPM_ERROR_OR_DRAIN:
-- 
2.34.1

