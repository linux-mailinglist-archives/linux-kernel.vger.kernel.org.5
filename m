Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2251B7C8C11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJMRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjJMRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697216886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2a+7HBBo+582GPdtrQ3K8cFFftObpBTIilV4TBRH2M=;
        b=buAxILYHw3dMxLLBjggL5VTJx0qsOT6IU+h7AqUGWKBngSl2Hs8Ia86xQVfQQ+fGvzBfOk
        xShXS8OhXwUqgwXzuejhTPfcIb68Ib9Ew0oK0uEELOVLKsrQYi7kXvEhoaU11reuXfD8mB
        bpFI1lFt7PRiDywqK7Och+v9gbLfcP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-EUY90PmROs2ihxClZCmmyQ-1; Fri, 13 Oct 2023 13:08:05 -0400
X-MC-Unique: EUY90PmROs2ihxClZCmmyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAEFB10334A1;
        Fri, 13 Oct 2023 17:08:04 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D101C060DF;
        Fri, 13 Oct 2023 17:08:03 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 4/5] i40e: Refactor and rename i40e_read_pba_string()
Date:   Fri, 13 Oct 2023 19:07:54 +0200
Message-ID: <20231013170755.2367410-5-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function i40e_read_pba_string() is currently unused but will be used
by subsequent patch to provide board ID via devlink device info.

The function reads PBA block from NVM so it cannot be called during
adapter reset and as we would like to provide PBA ID via devlink
info it is better to read the PBA ID during i40e_probe() and cache
it in i40e_hw structure to avoid a waiting for potential adapter
reset in devlink info callback.

So...
- Remove pba_num and pba_num_size arguments from the function,
  allocate resource managed buffer to store PBA ID string and
  save resulting pointer to i40e_hw->pba_id field
- Make the function void as the PBA ID can be missing and in this
  case (or in case of NVM reading failure) the i40e_hw->pba_id
  will be NULL
- Rename the function to i40e_get_pba_string() to align with other
  functions like i40e_get_oem_version() i40e_get_port_mac_addr()...
- Call this function on init during i40e_probe()

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 58 +++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 +
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +
 4 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6d1042ca0317..04db9cdc7d94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -821,62 +821,72 @@ void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable)
 }
 
 /**
- *  i40e_read_pba_string - Reads part number string from EEPROM
+ *  i40e_get_pba_string - Reads part number string from EEPROM
  *  @hw: pointer to hardware structure
- *  @pba_num: stores the part number string from the EEPROM
- *  @pba_num_size: part number string buffer length
  *
- *  Reads the part number string from the EEPROM.
+ *  Reads the part number string from the EEPROM and stores it
+ *  into newly allocated buffer and saves resulting pointer
+ *  to i40e_hw->pba_id field.
  **/
-int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
-			 u32 pba_num_size)
+void i40e_get_pba_string(struct i40e_hw *hw)
 {
+#define I40E_NVM_PBA_FLAGS_BLK_PRESENT	0xFAFA
 	u16 pba_word = 0;
 	u16 pba_size = 0;
 	u16 pba_ptr = 0;
-	int status = 0;
-	u16 i = 0;
+	int status;
+	char *ptr;
+	u16 i;
 
 	status = i40e_read_nvm_word(hw, I40E_SR_PBA_FLAGS, &pba_word);
-	if (status || (pba_word != 0xFAFA)) {
-		hw_dbg(hw, "Failed to read PBA flags or flag is invalid.\n");
-		return status;
+	if (status) {
+		hw_dbg(hw, "Failed to read PBA flags.\n");
+		return;
+	}
+	if (pba_word != I40E_NVM_PBA_FLAGS_BLK_PRESENT) {
+		hw_dbg(hw, "PBA block is not present.\n");
+		return;
 	}
 
 	status = i40e_read_nvm_word(hw, I40E_SR_PBA_BLOCK_PTR, &pba_ptr);
 	if (status) {
 		hw_dbg(hw, "Failed to read PBA Block pointer.\n");
-		return status;
+		return;
 	}
 
 	status = i40e_read_nvm_word(hw, pba_ptr, &pba_size);
 	if (status) {
 		hw_dbg(hw, "Failed to read PBA Block size.\n");
-		return status;
+		return;
 	}
 
 	/* Subtract one to get PBA word count (PBA Size word is included in
-	 * total size)
+	 * total size) and advance pointer to first PBA word.
 	 */
 	pba_size--;
-	if (pba_num_size < (((u32)pba_size * 2) + 1)) {
-		hw_dbg(hw, "Buffer too small for PBA data.\n");
-		return -EINVAL;
+	pba_ptr++;
+	if (!pba_size) {
+		hw_dbg(hw, "PBA ID is empty.\n");
+		return;
 	}
 
+	ptr = devm_kzalloc(i40e_hw_to_dev(hw), pba_size * 2 + 1, GFP_KERNEL);
+	if (!ptr)
+		return;
+	hw->pba_id = ptr;
+
 	for (i = 0; i < pba_size; i++) {
-		status = i40e_read_nvm_word(hw, (pba_ptr + 1) + i, &pba_word);
+		status = i40e_read_nvm_word(hw, pba_ptr + i, &pba_word);
 		if (status) {
 			hw_dbg(hw, "Failed to read PBA Block word %d.\n", i);
-			return status;
+			devm_kfree(i40e_hw_to_dev(hw), hw->pba_id);
+			hw->pba_id = NULL;
+			return;
 		}
 
-		pba_num[(i * 2)] = (pba_word >> 8) & 0xFF;
-		pba_num[(i * 2) + 1] = pba_word & 0xFF;
+		*ptr++ = (pba_word >> 8) & 0xFF;
+		*ptr++ = pba_word & 0xFF;
 	}
-	pba_num[(pba_size * 2)] = '\0';
-
-	return status;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ba8fb0556216..3157d14d9b12 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15846,6 +15846,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_pf_reset;
 	}
 	i40e_get_oem_version(hw);
+	i40e_get_pba_string(hw);
 
 	/* provide nvm, fw, api versions, vendor:device id, subsys vendor:device id */
 	i40e_nvm_version_str(hw, nvm_ver, sizeof(nvm_ver));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 46b9a05ceb91..001162042050 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -341,8 +341,7 @@ i40e_aq_configure_partition_bw(struct i40e_hw *hw,
 			       struct i40e_aqc_configure_partition_bw_data *bw_data,
 			       struct i40e_asq_cmd_details *cmd_details);
 int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
-int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
-			 u32 pba_num_size);
+void i40e_get_pba_string(struct i40e_hw *hw);
 void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable);
 /* prototype for functions used for NVM access */
 int i40e_init_nvm(struct i40e_hw *hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index dc7cd16ad8fb..aff6dc6afbe2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -493,6 +493,9 @@ struct i40e_hw {
 	struct i40e_nvm_info nvm;
 	struct i40e_fc_info fc;
 
+	/* PBA ID */
+	const char *pba_id;
+
 	/* pci info */
 	u16 device_id;
 	u16 vendor_id;
-- 
2.41.0

