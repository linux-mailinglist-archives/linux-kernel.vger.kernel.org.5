Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB07D68A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjJYKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjJYKeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E2DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698230004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDDPhLjS2qjyz2nQKfaq0QCWJpoL7NQX+WbUg4S1eIc=;
        b=TKk0KjJ6z+r4RPF3zWwwNbthkBM1ANwkR6EXyAZRIqshPGu8KugHFjN9Gt2EiSGKOY11MM
        hDK1HcfGtvY40sSSveWUqgGPVvmlpcHq9RU7SoF39zgr076ph+9eQiyC2MMPKwhV9bb70i
        krpE5AUHci5VoCL8hT3q3HnE6YJvkxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-n_Cdgp-6NaaVB16wf-rkEg-1; Wed, 25 Oct 2023 06:33:21 -0400
X-MC-Unique: n_Cdgp-6NaaVB16wf-rkEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C958F811E8E;
        Wed, 25 Oct 2023 10:33:20 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 381391121319;
        Wed, 25 Oct 2023 10:33:19 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next 2/2] i40e: Move inline helpers to i40e_prototype.h
Date:   Wed, 25 Oct 2023 12:33:15 +0200
Message-ID: <20231025103315.1149589-3-ivecera@redhat.com>
In-Reply-To: <20231025103315.1149589-1-ivecera@redhat.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move version check helper functions from i40e_type.h to
i40e_prototype.h as per discussion [1].

[1] https://lore.kernel.org/all/cdcd6b97-1138-4cd7-854f-b3faa1f475f8@intel.com/#t

Cc: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ------------------
 2 files changed, 70 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 001162042050..af4269330581 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -501,4 +501,74 @@ i40e_add_pinfo_to_list(struct i40e_hw *hw,
 /* i40e_ddp */
 int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
 
+/* Firmware and AdminQ version check helpers */
+
+/**
+ * i40e_is_aq_api_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is greater/equal than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.api_maj_ver > maj ||
+		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
+}
+
+/**
+ * i40e_is_aq_api_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is less than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_aq_api_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is greater/equal than provided.
+ **/
+static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
+}
+
+/**
+ * i40e_is_fw_ver_lt
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is less than provided.
+ **/
+static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return !i40e_is_fw_ver_ge(hw, maj, min);
+}
+
+/**
+ * i40e_is_fw_ver_eq
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current firmware version is equal to provided.
+ **/
+static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
+{
+	return (hw->aq.fw_maj_ver > maj ||
+		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+}
+
 #endif /* _I40E_PROTOTYPE_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 7eaf8b013125..e3d40630f689 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -586,74 +586,6 @@ struct i40e_hw {
 	char err_str[16];
 };
 
-/**
- * i40e_is_aq_api_ver_ge
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current HW API version is greater/equal than provided.
- **/
-static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.api_maj_ver > maj ||
-		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
-}
-
-/**
- * i40e_is_aq_api_ver_lt
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current HW API version is less than provided.
- **/
-static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return !i40e_is_aq_api_ver_ge(hw, maj, min);
-}
-
-/**
- * i40e_is_fw_ver_ge
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is greater/equal than provided.
- **/
-static inline bool i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
-}
-
-/**
- * i40e_is_fw_ver_lt
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is less than provided.
- **/
-static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return !i40e_is_fw_ver_ge(hw, maj, min);
-}
-
-/**
- * i40e_is_fw_ver_eq
- * @hw: pointer to i40e_hw structure
- * @maj: API major value to compare
- * @min: API minor value to compare
- *
- * Assert whether current firmware version is equal to provided.
- **/
-static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
-{
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
-}
-
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0

