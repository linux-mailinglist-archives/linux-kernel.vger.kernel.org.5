Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA357798EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjHKUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjHKUwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:52:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690030EE;
        Fri, 11 Aug 2023 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691787151; x=1723323151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tv/cNuarCVMN8q2TzmDIRA/D/urKZ6Jjo5PwLp0JXZo=;
  b=AfEKLC/im2mta2HDSxnSjyzX+V8zN/4kpgzpvpRqnjDZ6BkXcI/ghfCv
   ooiJ0OGqdr3Bht8c31EX9Pen8KkPgqyKRO07A+LEO63MUni25x/zsrIn3
   BipJGZ2U3zbLBgC8KtBj6532WHhkHnBaVkpmDmBJd0aPBAcFwfp/PDaTA
   cmgLcgWcqOYJb3p80tPTziFlIYGb/92sLZOZGb7owvdhozanYEtzNLeAf
   Jf/rpkQU5gpU60XEUo5uJRUivZZFLQbXNU/N3by+5myWOveP2ydGAD1A7
   IKbGqh5lv6/E1B1iBqE/HP+64+Uk8OIXXxuyRKpFolwI6KRbpL/lwyeZD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375473045"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="375473045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 13:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="762322061"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="762322061"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2023 13:52:11 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        pmalani@chromium.org, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1 Support
Date:   Fri, 11 Aug 2023 14:07:34 -0700
Message-Id: <20230811210735.159529-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displayport Alternatemode 2.1 requires cable capabilities such as cable
signalling, cable type, DPAM version which then will be used by mux
driver for displayport configuration.

These capabilities can be derived from the Cable VDO data as well as from
the existing EC PD host command interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 30 +++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d0b4d3fc40ed..eb4a1cb584a2 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -485,6 +485,32 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 	return typec_mux_set(port->mux, &port->state);
 }
 
+static int cros_typec_dp21_support(struct cros_typec_port *port,
+				   struct typec_displayport_data dp21_data,
+				   struct ec_response_usb_pd_control_v2 *pd_ctrl)
+{
+	u32 cable_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_DP_SID);
+
+	if (cable_vdo & DP_CAP_DPAM_VERSION) {
+		dp21_data.conf |= cable_vdo;
+	} else {
+		/* Cable Speed */
+		dp21_data.conf |= pd_ctrl->cable_speed << DP_CONF_SIGNALLING_SHIFT;
+
+		/* Cable Type */
+		if (pd_ctrl->cable_gen & USB_PD_CTRL_OPTICAL_CABLE)
+			dp21_data.conf |= DP_CONF_CABLE_TYPE_OPTICAL << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) & TBT_CABLE_RETIMER)
+			dp21_data.conf |= DP_CONF_CABLE_TYPE_RE_TIMER << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (pd_ctrl->cable_gen & USB_PD_CTRL_ACTIVE_CABLE)
+			dp21_data.conf |= DP_CONF_CABLE_TYPE_RE_DRIVER << DP_CONF_CABLE_TYPE_SHIFT;
+	}
+
+	port->state.data = &dp21_data;
+
+	return typec_mux_set(port->mux, &port->state);
+}
+
 /* Spoof the VDOs that were likely communicated by the partner. */
 static int cros_typec_enable_dp(struct cros_typec_data *typec,
 				int port_num,
@@ -524,6 +550,9 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	port->state.data = &dp_data;
 	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
 
+	if (typec->typec_dp21_supported)
+		return cros_typec_dp21_support(port, dp_data, pd_ctrl);
+
 	ret = cros_typec_retimer_set(port->retimer, port->state);
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
@@ -1196,6 +1225,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
 	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	typec->typec_dp21_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_DP2_1);
 
 	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 			  &resp, sizeof(resp));
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
index deda180a646f..a588b2780823 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -37,6 +37,7 @@ struct cros_typec_data {
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
 	struct work_struct port_work;
+	bool typec_dp21_supported;
 	bool typec_cmd_supported;
 	bool needs_mux_ack;
 };
-- 
2.25.1

