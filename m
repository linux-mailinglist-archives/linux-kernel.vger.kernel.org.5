Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0E7D3C92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjJWQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjJWQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA310CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698078582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgtGg0BFW55Rmx0mj1GNekmhAp2ku48a86Jk+1Z+kQs=;
        b=Guawc+69mm52D/Ojziglcy6zRHnQfrZ5gBBfO9NT2fzSu3M4GzW2lOHH4RrwyrpUFDaNrl
        IFSotnrVyNWG/TvBQpYkff3L71YanBW7vFVhH0nzCl+AZMjmbHExXiGj3cnm6d3+I++Bnc
        iBgQl6SpPp2p6cn5IrJw9nYBFkb72R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-Pe_hYhv3OFmsewRPBzi8mw-1; Mon, 23 Oct 2023 12:29:39 -0400
X-MC-Unique: Pe_hYhv3OFmsewRPBzi8mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8964588B7A0;
        Mon, 23 Oct 2023 16:29:38 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD46625C2;
        Mon, 23 Oct 2023 16:29:36 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>, mschmidt@redhat.com,
        dacampbe@redhat.com, poros@redhat.com
Subject: [PATCH iwl-next 3/3] i40e: Use helpers to check running FW and AQ API versions
Date:   Mon, 23 Oct 2023 18:29:28 +0200
Message-ID: <20231023162928.245583-4-ivecera@redhat.com>
In-Reply-To: <20231023162928.245583-1-ivecera@redhat.com>
References: <20231023162928.245583-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new helpers to check versions of running FW and provided
AQ API to make the code more readable.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 69 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_common.c | 25 ++++---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
 4 files changed, 43 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 86591140f748..dacd542f5c07 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -508,42 +508,35 @@ static int i40e_shutdown_arq(struct i40e_hw *hw)
  **/
 static void i40e_set_hw_caps(struct i40e_hw *hw)
 {
-	struct i40e_adminq_info *aq = &hw->aq;
-
 	bitmap_zero(hw->caps, I40E_HW_CAPS_NBITS);
 
 	switch (hw->mac.type) {
 	case I40E_MAC_XL710:
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
 			set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
 			set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
 			/* The ability to RX (not drop) 802.1ad frames */
 			set_bit(I40E_HW_CAP_802_1AD, hw->caps);
 		}
-		if ((aq->api_maj_ver == 1 && aq->api_min_ver > 4) ||
-		    aq->api_maj_ver > 1) {
+		if (i40e_is_aq_api_ver_ge(hw, 1, 5)) {
 			/* Supported in FW API version higher than 1.4 */
 			set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 33) ||
-		    aq->fw_maj_ver < 4) {
+		if (i40e_is_fw_ver_lt(hw, 4, 33)) {
 			set_bit(I40E_HW_CAP_RESTART_AUTONEG, hw->caps);
 			/* No DCB support  for FW < v4.33 */
 			set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 3) ||
-		    aq->fw_maj_ver < 4) {
+		if (i40e_is_fw_ver_lt(hw, 4, 3)) {
 			/* Disable FW LLDP if FW < v4.3 */
 			set_bit(I40E_HW_CAP_STOP_FW_LLDP, hw->caps);
 		}
-		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver >= 40) ||
-		    aq->fw_maj_ver >= 5) {
-			/* Use the FW Set LLDP MIB API if FW > v4.40 */
+		if (i40e_is_fw_ver_ge(hw, 4, 40)) {
+			/* Use the FW Set LLDP MIB API if FW >= v4.40 */
 			set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
 		}
-		if (aq->fw_maj_ver >= 6) {
+		if (i40e_is_fw_ver_ge(hw, 6, 0)) {
 			/* Enable PTP L4 if FW > v6.0 */
 			set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
 		}
@@ -569,47 +562,37 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 			clear_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
 		}
 
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722))
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+				I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722)) {
 			set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
-
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_X722))
+		}
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_GET_LINK_INFO_X722)) {
 			set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
-
-		if (aq->api_maj_ver > 1 ||
-		    (aq->api_maj_ver == 1 &&
-		     aq->api_min_ver >= I40E_MINOR_VER_FW_REQUEST_FEC_X722))
+		}
+		if (i40e_is_aq_api_ver_ge(hw, 1,
+					  I40E_MINOR_VER_FW_REQUEST_FEC_X722)) {
 			set_bit(I40E_HW_CAP_X722_FEC_REQUEST, hw->caps);
-
+		}
 		fallthrough;
 	default:
 		break;
 	}
 
 	/* Newer versions of firmware require lock when reading the NVM */
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5)) {
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
-
+	}
 	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 7))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 7)) {
 		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
-
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 8))
+	}
+	if (i40e_is_aq_api_ver_ge(hw, 1, 8)) {
 		set_bit(I40E_HW_CAP_FW_LLDP_PERSISTENT, hw->caps);
-
-	if (aq->api_maj_ver > 1 ||
-	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 9))
+	}
+	if (i40e_is_aq_api_ver_ge(hw, 1, 9)) {
 		set_bit(I40E_HW_CAP_AQ_PHY_ACCESS_EXTENDED, hw->caps);
+	}
 }
 
 /**
@@ -694,7 +677,7 @@ int i40e_init_adminq(struct i40e_hw *hw)
 			   &oem_lo);
 	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
 
-	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
+	if (i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR + 1, 0)) {
 		ret_code = -EIO;
 		goto init_adminq_free_arq;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index df7ba349030d..e171f4814e21 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1374,8 +1374,8 @@ i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 
 	if (report_init) {
 		if (hw->mac.type ==  I40E_MAC_XL710 &&
-		    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
+		    i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR,
+					  I40E_MINOR_VER_GET_LINK_INFO_XL710)) {
 			status = i40e_aq_get_link_info(hw, true, NULL, NULL);
 		} else {
 			hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
@@ -1645,9 +1645,8 @@ int i40e_aq_get_link_info(struct i40e_hw *hw,
 	else
 		hw_link_info->lse_enable = false;
 
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    (hw->aq.fw_maj_ver < 4 || (hw->aq.fw_maj_ver == 4 &&
-	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_lt(hw, 4, 40) &&
+	    hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
 	if (test_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps) &&
@@ -5223,14 +5222,14 @@ int i40e_aq_rx_ctl_read_register(struct i40e_hw *hw,
  **/
 u32 i40e_read_rx_ctl(struct i40e_hw *hw, u32 reg_addr)
 {
-	bool use_register;
+	bool use_register = false;
 	int status = 0;
 	int retry = 5;
 	u32 val = 0;
 
-	use_register = (((hw->aq.api_maj_ver == 1) &&
-			(hw->aq.api_min_ver < 5)) ||
-			(hw->mac.type == I40E_MAC_X722));
+	if (i40e_is_aq_api_ver_lt(hw, 1, 5) || hw->mac.type == I40E_MAC_X722)
+		use_register = true;
+
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_read_register(hw, reg_addr, &val, NULL);
@@ -5285,13 +5284,13 @@ int i40e_aq_rx_ctl_write_register(struct i40e_hw *hw,
  **/
 void i40e_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 {
-	bool use_register;
+	bool use_register = false;
 	int status = 0;
 	int retry = 5;
 
-	use_register = (((hw->aq.api_maj_ver == 1) &&
-			(hw->aq.api_min_ver < 5)) ||
-			(hw->mac.type == I40E_MAC_X722));
+	if (i40e_is_aq_api_ver_lt(hw, 1, 5) || hw->mac.type == I40E_MAC_X722)
+		use_register = true;
+
 	if (!use_register) {
 do_retry:
 		status = i40e_aq_rx_ctl_write_register(hw, reg_addr,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 39e44a2e0677..498728e16a37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -804,14 +804,11 @@ int i40e_get_dcb_config(struct i40e_hw *hw)
 	int ret = 0;
 
 	/* If Firmware version < v4.33 on X710/XL710, IEEE only */
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    (((hw->aq.fw_maj_ver == 4) && (hw->aq.fw_min_ver < 33)) ||
-	      (hw->aq.fw_maj_ver < 4)))
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_lt(hw, 4, 33))
 		return i40e_get_ieee_dcb_config(hw);
 
 	/* If Firmware version == v4.33 on X710/XL710, use old CEE struct */
-	if ((hw->mac.type == I40E_MAC_XL710) &&
-	    ((hw->aq.fw_maj_ver == 4) && (hw->aq.fw_min_ver == 33))) {
+	if (hw->mac.type == I40E_MAC_XL710 && i40e_is_fw_ver_eq(hw, 4, 33)) {
 		ret = i40e_aq_get_cee_dcb_config(hw, &cee_v1_cfg,
 						 sizeof(cee_v1_cfg), NULL);
 		if (!ret) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7001fe2870c4..df058540d277 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15830,15 +15830,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 hw->vendor_id, hw->device_id, hw->subsystem_vendor_id,
 		 hw->subsystem_device_id);
 
-	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
+	if (i40e_is_aq_api_ver_ge(hw, I40E_FW_API_VERSION_MAJOR,
+				  I40E_FW_MINOR_VERSION(hw) + 1))
 		dev_dbg(&pdev->dev,
 			"The driver for the device detected a newer version of the NVM image v%u.%u than v%u.%u.\n",
 			 hw->aq.api_maj_ver,
 			 hw->aq.api_min_ver,
 			 I40E_FW_API_VERSION_MAJOR,
 			 I40E_FW_MINOR_VERSION(hw));
-	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
+	else if (i40e_is_aq_api_ver_lt(hw, 1, 4))
 		dev_info(&pdev->dev,
 			 "The driver for the device detected an older version of the NVM image v%u.%u than expected v%u.%u. Please update the NVM image.\n",
 			 hw->aq.api_maj_ver,
-- 
2.41.0

