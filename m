Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7697D1665
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJTTjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjJTTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6443D65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697830696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ml4RORcasGomkLklFLPVGJJgQIs51tajiJ4KZNMKsYM=;
        b=BSuKyfsPOkVuva2YrWfjfI4CgDpAV5SQZGwFFKu6EWWIcqdbygP/zQsiQNajT0m0k+HV5J
        bS4Hw/lUq2dyBLsAbNE11NFBfe/ffWc1Mdxu9rsvLrSAHkjXAMFjb/SwzVmw8eF739cPCU
        Rx5CpEQ30buHjsbWbt5wXloPSu2ZQzo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-1S7bJ7BeNmyYl0EEeXgHpA-1; Fri, 20 Oct 2023 15:38:03 -0400
X-MC-Unique: 1S7bJ7BeNmyYl0EEeXgHpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F224729AA2D1;
        Fri, 20 Oct 2023 19:38:02 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.226.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24611C1596D;
        Fri, 20 Oct 2023 19:38:01 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>, mschmidt@redhat.com,
        dacampbe@redhat.com, poros@redhat.com,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 6/6] i40e: Initialize hardware capabilities at single place
Date:   Fri, 20 Oct 2023 21:37:42 +0200
Message-ID: <20231020193746.2274379-6-ivecera@redhat.com>
In-Reply-To: <20231020193746.2274379-1-ivecera@redhat.com>
References: <20231020193746.2274379-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i40e_hw.caps bits are set in i40e_set_hw_caps(), some of them
in i40e_init_adminq() and the rest of them in i40e_sw_init().
Consolidate the initialization to single proper place i40e_set_hw_caps().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 66 ++++++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_debug.h  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 55 +---------------
 .../net/ethernet/intel/i40e/i40e_register.h   |  1 +
 4 files changed, 51 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 6754f6b3508c..86591140f748 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -522,10 +522,52 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 			/* The ability to RX (not drop) 802.1ad frames */
 			set_bit(I40E_HW_CAP_802_1AD, hw->caps);
 		}
+		if ((aq->api_maj_ver == 1 && aq->api_min_ver > 4) ||
+		    aq->api_maj_ver > 1) {
+			/* Supported in FW API version higher than 1.4 */
+			set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 33) ||
+		    aq->fw_maj_ver < 4) {
+			set_bit(I40E_HW_CAP_RESTART_AUTONEG, hw->caps);
+			/* No DCB support  for FW < v4.33 */
+			set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver < 3) ||
+		    aq->fw_maj_ver < 4) {
+			/* Disable FW LLDP if FW < v4.3 */
+			set_bit(I40E_HW_CAP_STOP_FW_LLDP, hw->caps);
+		}
+		if ((aq->fw_maj_ver == 4 && aq->fw_min_ver >= 40) ||
+		    aq->fw_maj_ver >= 5) {
+			/* Use the FW Set LLDP MIB API if FW > v4.40 */
+			set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
+		}
+		if (aq->fw_maj_ver >= 6) {
+			/* Enable PTP L4 if FW > v6.0 */
+			set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
+		}
 		break;
 	case I40E_MAC_X722:
 		set_bit(I40E_HW_CAP_AQ_SRCTL_ACCESS_ENABLE, hw->caps);
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
+		set_bit(I40E_HW_CAP_RSS_AQ, hw->caps);
+		set_bit(I40E_HW_CAP_128_QP_RSS, hw->caps);
+		set_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
+		set_bit(I40E_HW_CAP_WB_ON_ITR, hw->caps);
+		set_bit(I40E_HW_CAP_MULTI_TCP_UDP_RSS_PCTYPE, hw->caps);
+		set_bit(I40E_HW_CAP_NO_PCI_LINK_CHECK, hw->caps);
+		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, hw->caps);
+		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, hw->caps);
+		set_bit(I40E_HW_CAP_PTP_L4, hw->caps);
+		set_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, hw->caps);
+		set_bit(I40E_HW_CAP_OUTER_UDP_CSUM, hw->caps);
+
+		if (rd32(hw, I40E_GLQF_FDEVICTENA(1)) !=
+		    I40E_FDEVICT_PCTYPE_DEFAULT) {
+			hw_warn(hw, "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
+			clear_bit(I40E_HW_CAP_ATR_EVICT, hw->caps);
+		}
 
 		if (aq->api_maj_ver > 1 ||
 		    (aq->api_maj_ver == 1 &&
@@ -553,6 +595,12 @@ static void i40e_set_hw_caps(struct i40e_hw *hw)
 	     aq->api_min_ver >= 5))
 		set_bit(I40E_HW_CAP_NVM_READ_REQUIRES_LOCK, hw->caps);
 
+	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
+	if (aq->api_maj_ver > 1 ||
+	    (aq->api_maj_ver == 1 &&
+	     aq->api_min_ver >= 7))
+		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
+
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
 	     aq->api_min_ver >= 8))
@@ -646,24 +694,6 @@ int i40e_init_adminq(struct i40e_hw *hw)
 			   &oem_lo);
 	hw->nvm.oem_ver = ((u32)oem_hi << 16) | oem_lo;
 
-	if (hw->mac.type == I40E_MAC_XL710 &&
-	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
-		set_bit(I40E_HW_CAP_AQ_PHY_ACCESS, hw->caps);
-		set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
-	}
-	if (hw->mac.type == I40E_MAC_X722 &&
-	    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver >= I40E_MINOR_VER_FW_LLDP_STOPPABLE_X722) {
-		set_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, hw->caps);
-	}
-
-	/* The ability to RX (not drop) 802.1ad frames was added in API 1.7 */
-	if (hw->aq.api_maj_ver > 1 ||
-	    (hw->aq.api_maj_ver == 1 &&
-	     hw->aq.api_min_ver >= 7))
-		set_bit(I40E_HW_CAP_802_1AD, hw->caps);
-
 	if (hw->aq.api_maj_ver > I40E_FW_API_VERSION_MAJOR) {
 		ret_code = -EIO;
 		goto init_adminq_free_arq;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
index 27ebc72d8bfe..e9871dfb32bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -37,6 +37,7 @@ struct i40e_hw;
 struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 
 #define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
+#define hw_warn(hw, S, A...) dev_warn(i40e_hw_to_dev(hw), S, ##A)
 
 #define i40e_debug(h, m, s, ...)				\
 do {								\
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 998f9a5f4836..7001fe2870c4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12798,62 +12798,10 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				 pf->hw.func_caps.fd_filters_best_effort;
 	}
 
-	if (pf->hw.mac.type == I40E_MAC_X722) {
-		set_bit(I40E_HW_CAP_RSS_AQ, pf->hw.caps);
-		set_bit(I40E_HW_CAP_128_QP_RSS, pf->hw.caps);
-		set_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps);
-		set_bit(I40E_HW_CAP_WB_ON_ITR, pf->hw.caps);
-		set_bit(I40E_HW_CAP_MULTI_TCP_UDP_RSS_PCTYPE, pf->hw.caps);
-		set_bit(I40E_HW_CAP_NO_PCI_LINK_CHECK, pf->hw.caps);
-		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, pf->hw.caps);
-		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, pf->hw.caps);
-		set_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps);
-		set_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps);
-		set_bit(I40E_HW_CAP_OUTER_UDP_CSUM, pf->hw.caps);
-
-#define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
-		if (rd32(&pf->hw, I40E_GLQF_FDEVICTENA(1)) !=
-		    I40E_FDEVICT_PCTYPE_DEFAULT) {
-			dev_warn(&pf->pdev->dev,
-				 "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
-			clear_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps);
-		}
-	} else if ((pf->hw.aq.api_maj_ver > 1) ||
-		   ((pf->hw.aq.api_maj_ver == 1) &&
-		    (pf->hw.aq.api_min_ver > 4))) {
-		/* Supported in FW API version higher than 1.4 */
-		set_bit(I40E_HW_CAP_GENEVE_OFFLOAD, pf->hw.caps);
-	}
-
 	/* Enable HW ATR eviction if possible */
 	if (test_bit(I40E_HW_CAP_ATR_EVICT, pf->hw.caps))
 		set_bit(I40E_FLAG_HW_ATR_EVICT_ENA, pf->flags);
 
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 33)) ||
-	    (pf->hw.aq.fw_maj_ver < 4))) {
-		set_bit(I40E_HW_CAP_RESTART_AUTONEG, pf->hw.caps);
-		/* No DCB support  for FW < v4.33 */
-		set_bit(I40E_HW_CAP_NO_DCB_SUPPORT, pf->hw.caps);
-	}
-
-	/* Disable FW LLDP if FW < v4.3 */
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver < 3)) ||
-	    (pf->hw.aq.fw_maj_ver < 4)))
-		set_bit(I40E_HW_CAP_STOP_FW_LLDP, pf->hw.caps);
-
-	/* Use the FW Set LLDP MIB API if FW > v4.40 */
-	if ((pf->hw.mac.type == I40E_MAC_XL710) &&
-	    (((pf->hw.aq.fw_maj_ver == 4) && (pf->hw.aq.fw_min_ver >= 40)) ||
-	    (pf->hw.aq.fw_maj_ver >= 5)))
-		set_bit(I40E_HW_CAP_USE_SET_LLDP_MIB, pf->hw.caps);
-
-	/* Enable PTP L4 if FW > v6.0 */
-	if (pf->hw.mac.type == I40E_MAC_XL710 &&
-	    pf->hw.aq.fw_maj_ver >= 6)
-		set_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps);
-
 	if (pf->hw.func_caps.vmdq && num_online_cpus() != 1) {
 		pf->num_vmdq_vsis = I40E_DEFAULT_NUM_VMDQ_VSI;
 		set_bit(I40E_FLAG_VMDQ_ENA, pf->flags);
@@ -12871,8 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	 * if NPAR is functioning so unset this hw flag in this case.
 	 */
 	if (pf->hw.mac.type == I40E_MAC_XL710 &&
-	    pf->hw.func_caps.npar_enable &&
-	    test_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, pf->hw.caps))
+	    pf->hw.func_caps.npar_enable)
 		clear_bit(I40E_HW_CAP_FW_LLDP_STOPPABLE, pf->hw.caps);
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index f408fcf23ce8..d561687303ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -899,6 +899,7 @@
 #define I40E_GLQF_ORT_FLX_PAYLOAD_SHIFT 7
 #define I40E_GLQF_ORT_FLX_PAYLOAD_MASK I40E_MASK(0x1, I40E_GLQF_ORT_FLX_PAYLOAD_SHIFT)
 #define I40E_GLQF_FDEVICTENA(_i) (0x00270384 + ((_i) * 4)) /* _i=0...1 */ /* Reset: CORER */
+#define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
 /* Redefined for X722 family */
 #define I40E_GLGEN_STAT_CLEAR 0x00390004 /* Reset: CORER */
 #endif /* _I40E_REGISTER_H_ */
-- 
2.41.0

