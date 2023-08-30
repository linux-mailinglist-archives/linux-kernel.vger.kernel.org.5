Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7EA78E26C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbjH3WkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjH3WkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E057A1;
        Wed, 30 Aug 2023 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435200; x=1724971200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DCt+0ktuTQSKqsD5YFbzltFM4+nXgRqT2bsYuR1mMU=;
  b=G4M/Rp66QrpMKmsU1/bBbPx2kTVh5aOIdwhu0SLGmAUs9GIbJw/0Yl/G
   stBinsyqbhEznNih8yn+FiUF8L6YKi2A36aNe+WUXn0BuBUQJuOVOwZBy
   Wcxu9sjOQAxM6GhQYB4scPzQAiZNLxOjHYltdFuHJk77YIdohNXWWH7Wz
   5kEPZI6Bo8Q+WPfBNAggdMICasUWEI9NNHp4C108e4/gjHeFDcR3Z0KCP
   6BU+TeP5fHcPq3D8WDIHKQbgMMkqXyNZvE6AQ8cetWYrw+mGEULtv3UgK
   TeT8c2aOzR1Ib6Juc+cimOfzz1ppVJcNiGCcXExtanECKrSsJ9r7EwZv/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677341"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677341"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259646"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259646"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 1/5] usb: typec: Add Displayport Alternate Mode 2.1 Support
Date:   Wed, 30 Aug 2023 15:39:46 -0700
Message-Id: <20230830223950.1360865-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displayport Alternate mode 2.1 requires configuration for additional
cable details such as signalling for cable, UHBR13.5 Support, Cable type
and DPAM version.
These details can be used with mux drivers to configure SOP DP
configuration for Displayport Alternate mode 2.1.
This change also includes pertinent cable signalling support in displayport
alternate mode.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in V2:
- No change.

 drivers/usb/typec/altmodes/displayport.c |  5 ++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c        |  4 ++--
 include/linux/usb/typec_dp.h             | 28 ++++++++++++++++++++----
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 426c88a516e5..f503cb4cd721 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -86,8 +86,11 @@ static int dp_altmode_notify(struct dp_altmode *dp)
 
 static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
 {
-	u32 conf = DP_CONF_SIGNALING_DP; /* Only DP signaling supported */
 	u8 pin_assign = 0;
+	u32 conf;
+
+	/* DP Signalling */
+	conf = (dp->data.conf & DP_CONF_SIGNALLING_MASK) >> DP_CONF_SIGNALLING_SHIFT;
 
 	switch (con) {
 	case DP_STATUS_CON_DISABLED:
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 73cd5bf35047..d9d3c91125ca 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -315,7 +315,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
 	struct ucsi_dp *dp;
 
 	/* We can't rely on the firmware with the capabilities. */
-	desc->vdo |= DP_CAP_DP_SIGNALING | DP_CAP_RECEPTACLE;
+	desc->vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
 
 	/* Claiming that we support all pin assignments */
 	desc->vdo |= all_assignments << 8;
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 607061a37eca..449c125f6f87 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -501,8 +501,8 @@ static void ucsi_ccg_nvidia_altmode(struct ucsi_ccg *uc,
 	case NVIDIA_FTB_DP_OFFSET:
 		if (alt[0].mid == USB_TYPEC_NVIDIA_VLINK_DBG_VDO)
 			alt[0].mid = USB_TYPEC_NVIDIA_VLINK_DP_VDO |
-				DP_CAP_DP_SIGNALING | DP_CAP_USB |
-				DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_E));
+				     DP_CAP_DP_SIGNALLING(0) | DP_CAP_USB |
+				     DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_E));
 		break;
 	case NVIDIA_FTB_DBG_OFFSET:
 		if (alt[0].mid == USB_TYPEC_NVIDIA_VLINK_DP_VDO)
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index 8d09c2f0a9b8..1f358098522d 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -67,8 +67,10 @@ enum {
 #define   DP_CAP_UFP_D			1
 #define   DP_CAP_DFP_D			2
 #define   DP_CAP_DFP_D_AND_UFP_D	3
-#define DP_CAP_DP_SIGNALING		BIT(2) /* Always set */
-#define DP_CAP_GEN2			BIT(3) /* Reserved after v1.0b */
+#define DP_CAP_DP_SIGNALLING(_cap_)	(((_cap_) & GENMASK(5, 2)) >> 2)
+#define   DP_CAP_SIGNALLING_HBR3	1
+#define   DP_CAP_SIGNALLING_UHBR10	2
+#define   DP_CAP_SIGNALLING_UHBR20	3
 #define DP_CAP_RECEPTACLE		BIT(6)
 #define DP_CAP_USB			BIT(7)
 #define DP_CAP_DFP_D_PIN_ASSIGN(_cap_)	(((_cap_) & GENMASK(15, 8)) >> 8)
@@ -78,6 +80,13 @@ enum {
 			DP_CAP_UFP_D_PIN_ASSIGN(_cap_) : DP_CAP_DFP_D_PIN_ASSIGN(_cap_))
 #define DP_CAP_PIN_ASSIGN_DFP_D(_cap_) ((_cap_ & DP_CAP_RECEPTACLE) ? \
 			DP_CAP_DFP_D_PIN_ASSIGN(_cap_) : DP_CAP_UFP_D_PIN_ASSIGN(_cap_))
+#define DP_CAP_UHBR_13_5_SUPPORT	BIT(26)
+#define DP_CAP_CABLE_TYPE(_cap_)	(((_cap_) & GENMASK(29, 28)) >> 28)
+#define   DP_CAP_CABLE_TYPE_PASSIVE	0
+#define   DP_CAP_CABLE_TYPE_RE_TIMER	1
+#define   DP_CAP_CABLE_TYPE_RE_DRIVER	2
+#define   DP_CAP_CABLE_TYPE_OPTICAL	3
+#define DP_CAP_DPAM_VERSION		BIT(30)
 
 /* DisplayPort Status Update VDO bits */
 #define DP_STATUS_CONNECTION(_status_)	((_status_) & 3)
@@ -97,13 +106,24 @@ enum {
 #define DP_CONF_CURRENTLY(_conf_)	((_conf_) & 3)
 #define DP_CONF_UFP_U_AS_DFP_D		BIT(0)
 #define DP_CONF_UFP_U_AS_UFP_D		BIT(1)
-#define DP_CONF_SIGNALING_DP		BIT(2)
-#define DP_CONF_SIGNALING_GEN_2		BIT(3) /* Reserved after v1.0b */
+#define DP_CONF_SIGNALLING_MASK		GENMASK(5, 2)
+#define DP_CONF_SIGNALLING_SHIFT	2
+#define   DP_CONF_SIGNALLING_HBR3	1
+#define   DP_CONF_SIGNALLING_UHBR10	2
+#define   DP_CONF_SIGNALLING_UHBR20	3
 #define DP_CONF_PIN_ASSIGNEMENT_SHIFT	8
 #define DP_CONF_PIN_ASSIGNEMENT_MASK	GENMASK(15, 8)
 
 /* Helper for setting/getting the pin assignment value to the configuration */
 #define DP_CONF_SET_PIN_ASSIGN(_a_)	((_a_) << 8)
 #define DP_CONF_GET_PIN_ASSIGN(_conf_)	(((_conf_) & GENMASK(15, 8)) >> 8)
+#define DP_CONF_UHBR13_5_SUPPORT	BIT(26)
+#define DP_CONF_CABLE_TYPE_MASK		GENMASK(29, 28)
+#define DP_CONF_CABLE_TYPE_SHIFT	28
+#define   DP_CONF_CABLE_TYPE_PASSIVE	0
+#define   DP_CONF_CABLE_TYPE_RE_TIMER	1
+#define   DP_CONF_CABLE_TYPE_RE_DRIVER	2
+#define   DP_CONF_CABLE_TYPE_OPTICAL	3
+#define DP_CONF_DPAM_VERSION		BIT(30)
 
 #endif /* __USB_TYPEC_DP_H */
-- 
2.25.1

