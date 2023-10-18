Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA37CD8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjJRKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjJRKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:10:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1BFF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697623843; x=1729159843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6jc3C8TgBPZmi0jXAgsee/x9WJDcUSILTyWe9qsitHw=;
  b=IQTXUuxGEd+ozCz8HQd3fro5SiM82r+6lGkUPO9HKh9UANgtQxS2J75B
   qdgqfJKXbza90SsFPVD7QKpAT9Ndcq/TlH1lOA8VPdd+H+6DoUWjpVrRX
   mpHI3u3oEgzNrRvjfLMOic5khbrt7ZkqGDTE2jEf6cYubeuseJCMyhR3j
   hY0hw6XQlqHHtfiKy6YX+MOhJ85y04oFD6r1ftjgdx5czzYfm21p0vFf3
   a7qyjPWC45IsqB2WzBS/KAjTdPezRb0LoiqGMSW9SBiC77nHQd+D5D+yP
   hejWiyupQFFduf1HbFI3La8VY7BH2EfpH+zzlhybDoC9K6CLbV5ytI5co
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="4578728"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4578728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="847206375"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="847206375"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:10:38 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: add check for offline bit in every register access
Date:   Wed, 18 Oct 2023 13:10:23 +0300
Message-ID: <20231018101024.271437-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Added check for offline in every register access function.
When offline bit is set the driver should not access any mei hw.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 154 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index d11a0740b47c96c33591e69a..565da19bb980c845bc2cf3ed 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -58,6 +58,9 @@ static inline void mei_me_reg_write(const struct mei_me_hw *hw,
  */
 static inline u32 mei_me_mecbrw_read(const struct mei_device *dev)
 {
+	if (dev->dev->offline)
+		return 0;
+
 	return mei_me_reg_read(to_me_hw(dev), ME_CB_RW);
 }
 
@@ -69,6 +72,9 @@ static inline u32 mei_me_mecbrw_read(const struct mei_device *dev)
  */
 static inline void mei_me_hcbww_write(struct mei_device *dev, u32 data)
 {
+	if (dev->dev->offline)
+		return;
+
 	mei_me_reg_write(to_me_hw(dev), H_CB_WW, data);
 }
 
@@ -83,6 +89,9 @@ static inline u32 mei_me_mecsr_read(const struct mei_device *dev)
 {
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	reg = mei_me_reg_read(to_me_hw(dev), ME_CSR_HA);
 	trace_mei_reg_read(dev->dev, "ME_CSR_HA", ME_CSR_HA, reg);
 
@@ -100,6 +109,9 @@ static inline u32 mei_hcsr_read(const struct mei_device *dev)
 {
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	reg = mei_me_reg_read(to_me_hw(dev), H_CSR);
 	trace_mei_reg_read(dev->dev, "H_CSR", H_CSR, reg);
 
@@ -114,6 +126,9 @@ static inline u32 mei_hcsr_read(const struct mei_device *dev)
  */
 static inline void mei_hcsr_write(struct mei_device *dev, u32 reg)
 {
+	if (dev->dev->offline)
+		return;
+
 	trace_mei_reg_write(dev->dev, "H_CSR", H_CSR, reg);
 	mei_me_reg_write(to_me_hw(dev), H_CSR, reg);
 }
@@ -127,6 +142,9 @@ static inline void mei_hcsr_write(struct mei_device *dev, u32 reg)
  */
 static inline void mei_hcsr_set(struct mei_device *dev, u32 reg)
 {
+	if (dev->dev->offline)
+		return;
+
 	reg &= ~H_CSR_IS_MASK;
 	mei_hcsr_write(dev, reg);
 }
@@ -140,6 +158,9 @@ static inline void mei_hcsr_set_hig(struct mei_device *dev)
 {
 	u32 hcsr;
 
+	if (dev->dev->offline)
+		return;
+
 	hcsr = mei_hcsr_read(dev) | H_IG;
 	mei_hcsr_set(dev, hcsr);
 }
@@ -155,6 +176,9 @@ static inline u32 mei_me_d0i3c_read(const struct mei_device *dev)
 {
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	reg = mei_me_reg_read(to_me_hw(dev), H_D0I3C);
 	trace_mei_reg_read(dev->dev, "H_D0I3C", H_D0I3C, reg);
 
@@ -169,6 +193,9 @@ static inline u32 mei_me_d0i3c_read(const struct mei_device *dev)
  */
 static inline void mei_me_d0i3c_write(struct mei_device *dev, u32 reg)
 {
+	if (dev->dev->offline)
+		return;
+
 	trace_mei_reg_write(dev->dev, "H_D0I3C", H_D0I3C, reg);
 	mei_me_reg_write(to_me_hw(dev), H_D0I3C, reg);
 }
@@ -185,6 +212,9 @@ static int mei_me_trc_status(struct mei_device *dev, u32 *trc)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return -EOPNOTSUPP;
+
 	if (!hw->cfg->hw_trc_supported)
 		return -EOPNOTSUPP;
 
@@ -210,6 +240,9 @@ static int mei_me_fw_status(struct mei_device *dev,
 	int ret;
 	int i;
 
+	if (dev->dev->offline)
+		return -EINVAL;
+
 	if (!fw_status || !hw->read_fws)
 		return -EINVAL;
 
@@ -242,6 +275,9 @@ static int mei_me_hw_config(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 hcsr, reg;
 
+	if (dev->dev->offline)
+		return -EINVAL;
+
 	if (WARN_ON(!hw->read_fws))
 		return -EINVAL;
 
@@ -294,6 +330,9 @@ static inline u32 me_intr_src(u32 hcsr)
  */
 static inline void me_intr_disable(struct mei_device *dev, u32 hcsr)
 {
+	if (dev->dev->offline)
+		return;
+
 	hcsr &= ~H_CSR_IE_MASK;
 	mei_hcsr_set(dev, hcsr);
 }
@@ -306,6 +345,9 @@ static inline void me_intr_disable(struct mei_device *dev, u32 hcsr)
  */
 static inline void me_intr_clear(struct mei_device *dev, u32 hcsr)
 {
+	if (dev->dev->offline)
+		return;
+
 	if (me_intr_src(hcsr))
 		mei_hcsr_write(dev, hcsr);
 }
@@ -317,7 +359,12 @@ static inline void me_intr_clear(struct mei_device *dev, u32 hcsr)
  */
 static void mei_me_intr_clear(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
+
+	if (dev->dev->offline)
+		return;
+
+	hcsr = mei_hcsr_read(dev);
 
 	me_intr_clear(dev, hcsr);
 }
@@ -330,6 +377,9 @@ static void mei_me_intr_enable(struct mei_device *dev)
 {
 	u32 hcsr;
 
+	if (dev->dev->offline)
+		return;
+
 	if (mei_me_hw_use_polling(to_me_hw(dev)))
 		return;
 
@@ -344,8 +394,12 @@ static void mei_me_intr_enable(struct mei_device *dev)
  */
 static void mei_me_intr_disable(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
 
+	if (dev->dev->offline)
+		return;
+
+	hcsr = mei_hcsr_read(dev);
 	me_intr_disable(dev, hcsr);
 }
 
@@ -358,6 +412,9 @@ static void mei_me_synchronize_irq(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return;
+
 	if (mei_me_hw_use_polling(hw))
 		return;
 
@@ -371,7 +428,12 @@ static void mei_me_synchronize_irq(struct mei_device *dev)
  */
 static void mei_me_hw_reset_release(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
+
+	if (dev->dev->offline)
+		return;
+
+	hcsr = mei_hcsr_read(dev);
 
 	hcsr |= H_IG;
 	hcsr &= ~H_RST;
@@ -385,7 +447,12 @@ static void mei_me_hw_reset_release(struct mei_device *dev)
  */
 static void mei_me_host_set_ready(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
+
+	if (dev->dev->offline)
+		return;
+
+	hcsr = mei_hcsr_read(dev);
 
 	if (!mei_me_hw_use_polling(to_me_hw(dev)))
 		hcsr |= H_CSR_IE_MASK;
@@ -402,7 +469,12 @@ static void mei_me_host_set_ready(struct mei_device *dev)
  */
 static bool mei_me_host_is_ready(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
+
+	if (dev->dev->offline)
+		return true;
+
+	hcsr = mei_hcsr_read(dev);
 
 	return (hcsr & H_RDY) == H_RDY;
 }
@@ -415,7 +487,12 @@ static bool mei_me_host_is_ready(struct mei_device *dev)
  */
 static bool mei_me_hw_is_ready(struct mei_device *dev)
 {
-	u32 mecsr = mei_me_mecsr_read(dev);
+	u32 mecsr;
+
+	if (dev->dev->offline)
+		return true;
+
+	mecsr = mei_me_mecsr_read(dev);
 
 	return (mecsr & ME_RDY_HRA) == ME_RDY_HRA;
 }
@@ -428,7 +505,12 @@ static bool mei_me_hw_is_ready(struct mei_device *dev)
  */
 static bool mei_me_hw_is_resetting(struct mei_device *dev)
 {
-	u32 mecsr = mei_me_mecsr_read(dev);
+	u32 mecsr;
+
+	if (dev->dev->offline)
+		return false;
+
+	mecsr = mei_me_mecsr_read(dev);
 
 	return (mecsr & ME_RST_HRA) == ME_RST_HRA;
 }
@@ -443,6 +525,9 @@ static void mei_gsc_pxp_check(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 fwsts5 = 0;
 
+	if (dev->dev->offline)
+		return;
+
 	if (!kind_is_gsc(dev) && !kind_is_gscfi(dev))
 		return;
 
@@ -538,8 +623,12 @@ static void mei_me_check_fw_reset(struct mei_device *dev)
  */
 static int mei_me_hw_start(struct mei_device *dev)
 {
-	int ret = mei_me_hw_ready_wait(dev);
+	int ret;
+
+	if (dev->dev->offline)
+		return 0;
 
+	ret = mei_me_hw_ready_wait(dev);
 	if (kind_is_gsc(dev) || kind_is_gscfi(dev))
 		mei_me_check_fw_reset(dev);
 	if (ret)
@@ -640,6 +729,9 @@ static int mei_me_hbuf_write(struct mei_device *dev,
 	u32 dw_cnt;
 	int empty_slots;
 
+	if (dev->dev->offline)
+		return -EINVAL;
+
 	if (WARN_ON(!hdr || hdr_len & 0x3))
 		return -EINVAL;
 
@@ -724,6 +816,9 @@ static int mei_me_read_slots(struct mei_device *dev, unsigned char *buffer,
 {
 	u32 *reg_buf = (u32 *)buffer;
 
+	if (dev->dev->offline)
+		return 0;
+
 	for (; buffer_length >= MEI_SLOT_SIZE; buffer_length -= MEI_SLOT_SIZE)
 		*reg_buf++ = mei_me_mecbrw_read(dev);
 
@@ -747,6 +842,9 @@ static void mei_me_pg_set(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 reg;
 
+	if (dev->dev->offline)
+		return;
+
 	reg = mei_me_reg_read(hw, H_HPG_CSR);
 	trace_mei_reg_read(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 
@@ -766,6 +864,9 @@ static void mei_me_pg_unset(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 reg;
 
+	if (dev->dev->offline)
+		return;
+
 	reg = mei_me_reg_read(hw, H_HPG_CSR);
 	trace_mei_reg_read(dev->dev, "H_HPG_CSR", H_HPG_CSR, reg);
 
@@ -789,6 +890,9 @@ static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	int ret;
 
+	if (dev->dev->offline)
+		return 0;
+
 	dev->pg_event = MEI_PG_EVENT_WAIT;
 
 	ret = mei_hbm_pg(dev, MEI_PG_ISOLATION_ENTRY_REQ_CMD);
@@ -826,6 +930,9 @@ static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	int ret;
 
+	if (dev->dev->offline)
+		return 0;
+
 	if (dev->pg_event == MEI_PG_EVENT_RECEIVED)
 		goto reply;
 
@@ -971,6 +1078,9 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
 	int ret;
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	reg = mei_me_d0i3c_read(dev);
 	if (reg & H_D0I3C_I3) {
 		/* we are in d0i3, nothing to do */
@@ -1046,6 +1156,9 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
 	struct mei_me_hw *hw = to_me_hw(dev);
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	reg = mei_me_d0i3c_read(dev);
 	if (reg & H_D0I3C_I3) {
 		/* we are in d0i3, nothing to do */
@@ -1074,6 +1187,9 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
 	int ret;
 	u32 reg;
 
+	if (dev->dev->offline)
+		return 0;
+
 	dev->pg_event = MEI_PG_EVENT_INTR_WAIT;
 
 	reg = mei_me_d0i3c_read(dev);
@@ -1125,6 +1241,9 @@ static void mei_me_pg_legacy_intr(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return;
+
 	if (dev->pg_event != MEI_PG_EVENT_INTR_WAIT)
 		return;
 
@@ -1144,6 +1263,9 @@ static void mei_me_d0i3_intr(struct mei_device *dev, u32 intr_source)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return;
+
 	if (dev->pg_event == MEI_PG_EVENT_INTR_WAIT &&
 	    (intr_source & H_D0I3C_IS)) {
 		dev->pg_event = MEI_PG_EVENT_INTR_RECEIVED;
@@ -1185,6 +1307,9 @@ static void mei_me_pg_intr(struct mei_device *dev, u32 intr_source)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return;
+
 	if (hw->d0i3_supported)
 		mei_me_d0i3_intr(dev, intr_source);
 	else
@@ -1202,6 +1327,9 @@ int mei_me_pg_enter_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return 0;
+
 	if (hw->d0i3_supported)
 		return mei_me_d0i3_enter_sync(dev);
 	else
@@ -1219,6 +1347,9 @@ int mei_me_pg_exit_sync(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (dev->dev->offline)
+		return 0;
+
 	if (hw->d0i3_supported)
 		return mei_me_d0i3_exit_sync(dev);
 	else
@@ -1309,6 +1440,9 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
 	struct mei_device *dev = (struct mei_device *)dev_id;
 	u32 hcsr;
 
+	if (dev->dev->offline)
+		return IRQ_HANDLED;
+
 	hcsr = mei_hcsr_read(dev);
 	if (!me_intr_src(hcsr))
 		return IRQ_NONE;
@@ -1340,6 +1474,10 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	int rets = 0;
 
 	dev_dbg(dev->dev, "function called after ISR to handle the interrupt processing.\n");
+
+	if (dev->dev->offline)
+		return IRQ_HANDLED;
+
 	/* initialize our complete list */
 	mutex_lock(&dev->device_lock);
 
-- 
2.41.0

