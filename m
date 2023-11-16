Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268E7EE218
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjKPOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjKPOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:02 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF5F12F;
        Thu, 16 Nov 2023 06:01:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FD2B20011;
        Thu, 16 Nov 2023 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700143317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+Kjez/OBWgjbzrVAxSpudxqYu2NdZR8Bv+C+qH5eZ8=;
        b=QJ44GfTeiDc+kuPwExXXQzqDTa/zRCiFpLgCOuWrXuNGPMchFQVuOA41c0QCcivJ/35GfJ
        nzyPubQR0R+MthigSQJSplVXTZJAsflJoxR3fETcNHwFY7GwX+CuCmiKstLDb0FWqZJCBn
        iFYNj9Kg7czmvYALjkkX+ZnC1r0xVdtgMN2+PihfAOWcB1bsqSpFq4mrgJzjSp1DVICy+6
        3ifVVCql7UoN2LwAVGNgCz1gnePDJPzxMqKrjXcIdilUVofufiVmJi2/FvUseLMlzjN6ZQ
        vUuZV5Yp7J6s6ePj6LpU2VkBXj4JVfDoir3E5ReVsJMLspk7/xxOnaGJ5HXTmQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Thu, 16 Nov 2023 15:01:34 +0100
Subject: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment with
 PoE alongside PoDL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current PSE interface for Ethernet Power Equipment, support is
limited to PoDL. This patch extends the interface to accommodate the
objects specified in IEEE 802.3-2022 145.2 for Power sourcing
Equipment (PSE).

The following objects are now supported and considered mandatory:
- IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus
- IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
- IEEE 802.3-2022 30.9.1.2.1 aPSEAdminControl

To avoid confusion between "PoDL PSE" and "PSE", which have similar names
but distinct values, we have followed the suggestion of Oleksij Rempel to
maintain separate naming schemes for each. You can find more details in the
discussion thread here:
https://lore.kernel.org/netdev/20230912110637.GI780075@pengutronix.de/

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h           |  9 ++++++++
 include/uapi/linux/ethtool.h         | 43 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ethtool_netlink.h |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 199cf4ae3cf2..25490d0c682d 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -17,9 +17,12 @@ struct pse_controller_dev;
  *
  * @podl_admin_control: set PoDL PSE admin control as described in
  *	IEEE 802.3-2018 30.15.1.2.1 acPoDLPSEAdminControl
+ * @admin_control: set PSE admin control as described in
+ *	IEEE 802.3-2022 30.9.1.2.1 acPSEAdminControl
  */
 struct pse_control_config {
 	enum ethtool_podl_pse_admin_state podl_admin_control;
+	enum ethtool_pse_admin_state admin_control;
 };
 
 /**
@@ -29,10 +32,16 @@ struct pse_control_config {
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
  *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @admin_state: operational state of the PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @pw_status: power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
+	enum ethtool_pse_admin_state admin_state;
+	enum ethtool_pse_pw_d_status pw_status;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..eaf7f7ff41f1 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -752,6 +752,49 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_pse_admin_state - operational state of the PoDL PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @ETHTOOL_PSE_ADMIN_STATE_UNKNOWN: state of PSE functions is unknown
+ * @ETHTOOL_PSE_ADMIN_STATE_DISABLED: PSE functions are disabled
+ * @ETHTOOL_PSE_ADMIN_STATE_ENABLED: PSE functions are enabled
+ */
+enum ethtool_pse_admin_state {
+	ETHTOOL_PSE_ADMIN_STATE_UNKNOWN = 1,
+	ETHTOOL_PSE_ADMIN_STATE_DISABLED,
+	ETHTOOL_PSE_ADMIN_STATE_ENABLED,
+};
+
+/**
+ * enum ethtool_pse_pw_d_status - power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @ETHTOOL_PSE_PW_D_STATUS_UNKNOWN: PSE status is unknown
+ * @ETHTOOL_PSE_PW_D_STATUS_DISABLED: "The enumeration “disabled”
+ *	indicates that the PSE State diagram is in the state DISABLED."
+ * @ETHTOOL_PSE_PW_D_STATUS_SEARCHING: "The enumeration “searching”
+ *	indicates the PSE State diagram is in a state other than those
+ *	listed."
+ * @ETHTOOL_PSE_PW_D_STATUS_DELIVERING: "The enumeration
+ *	“deliveringPower” indicates that the PSE State diagram is in the
+ *	state POWER_ON."
+ * @ETHTOOL_PSE_PW_D_STATUS_TEST: "The enumeration “test” indicates that
+ *	the PSE State diagram is in the state TEST_MODE."
+ * @ETHTOOL_PSE_PW_D_STATUS_FAULT: "The enumeration “fault” indicates that
+ *	the PSE State diagram is in the state TEST_ERROR."
+ * @ETHTOOL_PSE_PW_D_STATUS_OTHERFAULT: "The enumeration “otherFault”
+ *	indicates that the PSE State diagram is in the state IDLE due to
+ *	the variable error_condition = true."
+ */
+enum ethtool_pse_pw_d_status {
+	ETHTOOL_PSE_PW_D_STATUS_UNKNOWN = 1,
+	ETHTOOL_PSE_PW_D_STATUS_DISABLED,
+	ETHTOOL_PSE_PW_D_STATUS_SEARCHING,
+	ETHTOOL_PSE_PW_D_STATUS_DELIVERING,
+	ETHTOOL_PSE_PW_D_STATUS_TEST,
+	ETHTOOL_PSE_PW_D_STATUS_FAULT,
+	ETHTOOL_PSE_PW_D_STATUS_OTHERFAULT,
+};
+
 /**
  * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..2a27f37c71f7 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -895,6 +895,9 @@ enum {
 	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_PSE_ADMIN_STATE,		/* u32 */
+	ETHTOOL_A_PSE_ADMIN_CONTROL,		/* u32 */
+	ETHTOOL_A_PSE_PW_D_STATUS,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,

-- 
2.25.1

