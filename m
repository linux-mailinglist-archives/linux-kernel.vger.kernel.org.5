Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A97EC8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjKOQjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjKOQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F921A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7886C433C9;
        Wed, 15 Nov 2023 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066369;
        bh=WZZpUNtc2DPKkk+uXGa4GT4m3SV97GOyHrjsNd9er2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRzEctaIriss8XyXc5pNIHTyjlT/C7pWhsoqkZfJ/Lk4BNxVWSAh/cqkcdRmmDv/N
         viCBbDwH3eJi593IonCjeJ6I9Oquec3a3mmgrUe838VhxepGO9JLNatoJydrwuhoXf
         s0sKdOCx41ZVekUXqMWKLtM7yAs6WmgfSVqvgUD5r+7i9zlLatYoUfhY7FucSZbRxe
         plMlrl8x6mEnIZZ7/WT6UeFlBCh6lgZczEI870ARaBfcGCLuf+jQRYW1NKwylmU3xA
         3gqKvIBP7rO/If0H2/za29YTnKxopAgQ74US6ONe9+D7ycf9qOc+frk8znQpKoiUDz
         ayEvZJEcFjmvw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/10] accel/habanalabs/gaudi2: get the correct QM CQ info upon an error
Date:   Wed, 15 Nov 2023 18:39:10 +0200
Message-Id: <20231115163912.1243175-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
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

Upon a QM error, the address/size from both the CQ and the ARC_CQ are
printed, although the instruction that led to the error was received
from only one of them.

Moreover, in case of a QM undefined opcode, only one of these
address/size sets will be captured based on the value of ARC_CQ_PTR.
However, this value can be non-zero even if currently the CQ is used, in
case the CQ/ARC_CQ are alternately used.

Under the assumption of having a stop-on-error configuration, modify to
use CP_STS.CUR_CQ field to get the relevant CQ for the QM error.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c      | 44 +++++++++----------
 .../include/gaudi2/asic_reg/gaudi2_regs.h     |  1 +
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 5075f92d15cc..77c480725a84 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7860,36 +7860,36 @@ static bool gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 
 static void handle_lower_qman_data_on_err(struct hl_device *hdev, u64 qman_base, u64 event_mask)
 {
-	u32 lo, hi, cq_ptr_size, arc_cq_ptr_size;
-	u64 cq_ptr, arc_cq_ptr, cp_current_inst;
-
-	lo = RREG32(qman_base + QM_CQ_PTR_LO_4_OFFSET);
-	hi = RREG32(qman_base + QM_CQ_PTR_HI_4_OFFSET);
-	cq_ptr = ((u64) hi) << 32 | lo;
-	cq_ptr_size = RREG32(qman_base + QM_CQ_TSIZE_4_OFFSET);
-
-	lo = RREG32(qman_base + QM_ARC_CQ_PTR_LO_OFFSET);
-	hi = RREG32(qman_base + QM_ARC_CQ_PTR_HI_OFFSET);
-	arc_cq_ptr = ((u64) hi) << 32 | lo;
-	arc_cq_ptr_size = RREG32(qman_base + QM_ARC_CQ_TSIZE_OFFSET);
+	u32 lo, hi, cq_ptr_size, cp_sts;
+	u64 cq_ptr, cp_current_inst;
+	bool is_arc_cq;
+
+	cp_sts = RREG32(qman_base + QM_CP_STS_4_OFFSET);
+	is_arc_cq = FIELD_GET(PDMA0_QM_CP_STS_CUR_CQ_MASK, cp_sts); /* 0 - legacy CQ, 1 - ARC_CQ */
+
+	if (is_arc_cq) {
+		lo = RREG32(qman_base + QM_ARC_CQ_PTR_LO_OFFSET);
+		hi = RREG32(qman_base + QM_ARC_CQ_PTR_HI_OFFSET);
+		cq_ptr = ((u64) hi) << 32 | lo;
+		cq_ptr_size = RREG32(qman_base + QM_ARC_CQ_TSIZE_OFFSET);
+	} else {
+		lo = RREG32(qman_base + QM_CQ_PTR_LO_4_OFFSET);
+		hi = RREG32(qman_base + QM_CQ_PTR_HI_4_OFFSET);
+		cq_ptr = ((u64) hi) << 32 | lo;
+		cq_ptr_size = RREG32(qman_base + QM_CQ_TSIZE_4_OFFSET);
+	}
 
 	lo = RREG32(qman_base + QM_CP_CURRENT_INST_LO_4_OFFSET);
 	hi = RREG32(qman_base + QM_CP_CURRENT_INST_HI_4_OFFSET);
 	cp_current_inst = ((u64) hi) << 32 | lo;
 
 	dev_info(hdev->dev,
-		"LowerQM. CQ: {ptr %#llx, size %u}, ARC_CQ: {ptr %#llx, size %u}, CP: {instruction %#llx}\n",
-		cq_ptr, cq_ptr_size, arc_cq_ptr, arc_cq_ptr_size, cp_current_inst);
+		"LowerQM. %sCQ: {ptr %#llx, size %u}, CP: {instruction %#llx}\n",
+		is_arc_cq ? "ARC_" : "", cq_ptr, cq_ptr_size, cp_current_inst);
 
 	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
-		if (arc_cq_ptr) {
-			hdev->captured_err_info.undef_opcode.cq_addr = arc_cq_ptr;
-			hdev->captured_err_info.undef_opcode.cq_size = arc_cq_ptr_size;
-		} else {
-			hdev->captured_err_info.undef_opcode.cq_addr = cq_ptr;
-			hdev->captured_err_info.undef_opcode.cq_size = cq_ptr_size;
-		}
-
+		hdev->captured_err_info.undef_opcode.cq_addr = cq_ptr;
+		hdev->captured_err_info.undef_opcode.cq_size = cq_ptr_size;
 		hdev->captured_err_info.undef_opcode.stream_id = QMAN_STREAMS;
 	}
 }
diff --git a/drivers/accel/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h b/drivers/accel/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
index a08378d0802b..8018214a7b59 100644
--- a/drivers/accel/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
+++ b/drivers/accel/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
@@ -250,6 +250,7 @@
 #define QM_ARC_CQ_PTR_HI_OFFSET		(mmPDMA0_QM_ARC_CQ_PTR_HI - mmPDMA0_QM_BASE)
 #define QM_ARC_CQ_TSIZE_OFFSET		(mmPDMA0_QM_ARC_CQ_TSIZE - mmPDMA0_QM_BASE)
 
+#define QM_CP_STS_4_OFFSET		(mmPDMA0_QM_CP_STS_4 - mmPDMA0_QM_BASE)
 #define QM_CP_CURRENT_INST_LO_4_OFFSET	(mmPDMA0_QM_CP_CURRENT_INST_LO_4 - mmPDMA0_QM_BASE)
 #define QM_CP_CURRENT_INST_HI_4_OFFSET	(mmPDMA0_QM_CP_CURRENT_INST_HI_4 - mmPDMA0_QM_BASE)
 
-- 
2.34.1

