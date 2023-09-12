Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828FD79C326
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjILClv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjILCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:41:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14259872BF;
        Mon, 11 Sep 2023 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694484410; x=1726020410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kc+GlouzUtiYUbsus6Ql1LfEI6Wx8KqhqqeipmXgx6E=;
  b=ANUGydRBMjuRwar8c1Ge0FMdV6gxBGWnsWWcfUr4uosXMpRHXGY8EAkn
   xU+XTyZHZSPbCYqJt0QuOTVyUfdmxfsccfNctXO8WV2gljBxkT9EP4uNZ
   TduHDoP5nFY6XucsTdxZsK2yM2kqipN6Y3/bZ8E+9YMCo2MEcUcdFGBaj
   ZnNNr4bVXBRvp66+D8QhfE11SFPwkf8Wpmf+LfuZlJPDV+XuGGLZUVwjL
   +juejTgHgc/UgkSaMuTfCXPUespGrOeyKGZXt7vIBfXkJvzIEU907RRKO
   zqmJm/HKF5+RFwFL4lE8nB7gjVYnWNSTlzXfrgc9zlwlc9iE4e8Yl18ht
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382057903"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="382057903"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858570614"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858570614"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 17:58:10 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1 Support
Date:   Mon, 11 Sep 2023 17:57:51 -0700
Message-Id: <20230912005752.1532888-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
References: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displayport Alternatemode 2.1 requires cable capabilities such as cable
signalling, cable type, DPAM version which then will be used by mux
driver for displayport configuration. These capabilities can be derived
from the Cable VDO.
Added a helper macro to get the Type C cable speed when provided the
cable VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v3:
- Removed use of variable cable_seepd.
- Added helper macro of pd_vdo.h in this patch as cros_ec_typec is the user.

Changes in v2:
- Remvoed feature flag specifice to DP2.1.
- Remvoed seperate function for DP2.1.
- Removed use of EC host coammnd to get cable details.
- TBT cable VDO is used to get cable details.
- Using VDO_CABLE_SPEED macro to get passive cable speed. 

 drivers/platform/chrome/cros_ec_typec.c | 28 +++++++++++++++++++++++++
 include/linux/usb/pd_vdo.h              |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d0b4d3fc40ed..cca913400b39 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -492,6 +492,8 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct typec_displayport_data dp_data;
+	u32 cable_tbt_vdo;
+	u32 cable_dp_vdo;
 	int ret;
 
 	if (typec->pd_ctrl_ver < 2) {
@@ -524,6 +526,32 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	port->state.data = &dp_data;
 	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
 
+	/* Get cable VDO for cables with DPSID to check DPAM2.1 is supported */
+	cable_dp_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_DP_SID);
+
+	/**
+	 * Get cable VDO for thunderbolt cables and cables with DPSID but does not
+	 * support DPAM2.1.
+	 */
+	cable_tbt_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID);
+
+	if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
+		dp_data.conf |= cable_dp_vdo;
+	} else if (cable_tbt_vdo) {
+		dp_data.conf |=  TBT_CABLE_SPEED(cable_tbt_vdo) << DP_CONF_SIGNALLING_SHIFT;
+
+		/* Cable Type */
+		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_OPTICAL << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_TIMER << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_DRIVER << DP_CONF_CABLE_TYPE_SHIFT;
+	} else if (PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_PCABLE) {
+		dp_data.conf |= VDO_TYPEC_CABLE_SPEED(port->c_identity.vdo[0]) <<
+				DP_CONF_SIGNALLING_SHIFT;
+	}
+
 	ret = cros_typec_retimer_set(port->retimer, port->state);
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index b057250704e8..3a747938cdab 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -376,6 +376,7 @@
 	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5	\
 	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
 
+#define VDO_TYPEC_CABLE_SPEED(vdo)	((vdo) & 0x7)
 #define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
 
 /*
-- 
2.25.1

