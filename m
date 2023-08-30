Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14BB78E275
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjH3Wkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbjH3WkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D3CFF;
        Wed, 30 Aug 2023 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435208; x=1724971208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=llUl9HwBkxVND4lDmEvVjbUM+OpS0iP7RqKwfjwTBFQ=;
  b=VVObC85PMeOARDEEr7FP/W3BRqHQX3Y42co1uoxmUIy+SnYlY0w2t6Db
   Dc9TMSF2Qed3lTnN6/iVPoN9Z/KZqLaVm223xZi4yDXgTGbgQD94JQByh
   F8wRDSvQHGvPIpiOrGFmoWUtrpbEmhGanG2SywnL+gQzFA4KQqTgt0AkB
   GTUtwUN8ZMK7//PTh+u+NaGkaPEEsXFs59ndVTtln18YPUO7P3wGQV5ps
   xmIjEusg/1NG403+FzaQ5iZyl603Mjy4jRRCeBqhYIvxJ5zpe+TK2XBFH
   7zcCnPzyh/Ecw2+WJ7KlDzYY7j8WCKe8QUfYea/ABdvfNi1ifZTwn1yYk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677351"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677351"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259655"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259655"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1 Support
Date:   Wed, 30 Aug 2023 15:39:49 -0700
Message-Id: <20230830223950.1360865-5-utkarsh.h.patel@intel.com>
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

Displayport Alternatemode 2.1 requires cable capabilities such as cable
signalling, cable type, DPAM version which then will be used by mux
driver for displayport configuration. These capabilities can be derived
from the Cable VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
- Remvoed feature flag specifice to DP2.1.
- Remvoed seperate function for DP2.1.
- Removed use of EC host coammnd to get cable details.
- TBT cable VDO is used to get cable details.
- Using VDO_CABLE_SPEED macro to get passive cable speed. 

 drivers/platform/chrome/cros_ec_typec.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d0b4d3fc40ed..8372f13052a8 100644
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
@@ -524,6 +526,35 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
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
+		u8 cable_speed = TBT_CABLE_SPEED(cable_tbt_vdo);
+
+		dp_data.conf |= cable_speed << DP_CONF_SIGNALLING_SHIFT;
+
+		/* Cable Type */
+		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_OPTICAL << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_TIMER << DP_CONF_CABLE_TYPE_SHIFT;
+		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
+			dp_data.conf |= DP_CONF_CABLE_TYPE_RE_DRIVER << DP_CONF_CABLE_TYPE_SHIFT;
+	} else if (PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_PCABLE) {
+		u8 cable_speed = VDO_CABLE_SPEED(port->c_identity.vdo[0]);
+
+		dp_data.conf |= cable_speed << DP_CONF_SIGNALLING_SHIFT;
+	}
+
 	ret = cros_typec_retimer_set(port->retimer, port->state);
 	if (!ret)
 		ret = typec_mux_set(port->mux, &port->state);
-- 
2.25.1

