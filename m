Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F177571C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGRCa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGRCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:30:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4AD11C;
        Mon, 17 Jul 2023 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689647457; x=1721183457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INgOD6KHNgdn+51QzZxUT2GrZUL8boDsysCXq/aIC9g=;
  b=YgQv40IaKpnz+DezhVJ/xq6kXmMA/4FeIXuKuiZ7t1PJf52Po1SmqPFY
   wItDUecz3iE9nX0SqVR52qCyIKZRrOQSZbpHNq7mgBgp2FGhaH4bf0VFq
   JzGeNwscweo+GNKCehKUNk/JS3JNaFfqwqSY29OfxEODKsQyv69TGr6RS
   BnsThgbL0240IDDscNEmb4mGN39IIB/k5cJwdQ2xK/6ALCwImf7IFTgt/
   dEsf4KkLnnfRfCq1FRKNgiwac1JAN4xdZtAdRzvv+J2KDLr2uLv7yVTiC
   OMBPGcR2IVC3RGPgB/Li3WE058SHWHb1xBdP4eZjWCZyNYgdfkIGsybOB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452467241"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="452467241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726760897"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726760897"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 19:30:54 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer cable type
Date:   Mon, 17 Jul 2023 19:47:02 -0700
Message-Id: <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connector class driver only configure cable type active or passive.
Configure if the cable type is retimer or redriver with this change.
This detail will be provided as a part of cable discover mode VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v4:
- Removed local variables and used inline assignemtns.
- Added details about return values in cros_typec_get_cable_vdo.

Changes in v3:
- Changed the return method in cros_typec_get_cable_vdo.
- Changed passed parameters in cros_typec_get_cable_vdo.
- Corrected definition for unsigned integers as kerenl standard.
- Assigning cable_vdo values directly in to cable_mode.
- Removed unncessary checks for Retimer cable type.

Changes in v2:
- Implemented use of cable discover mode vdo.
- Removed adittional changes to host command.
---
---
 drivers/platform/chrome/cros_ec_typec.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 25f9767c28e8..d0b4d3fc40ed 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -406,6 +406,27 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 	return ret;
 }
 
+/**
+ * cros_typec_get_cable_vdo() - Get Cable VDO of the connected cable
+ * @port: Type-C port data
+ * @svid: Standard or Vendor ID to match
+ *
+ * Returns the Cable VDO if match is found and returns 0 if match is not found.
+ */
+static int cros_typec_get_cable_vdo(struct cros_typec_port *port, u16 svid)
+{
+	struct list_head *head = &port->plug_mode_list;
+	struct cros_typec_altmode_node *node;
+	u32 ret = 0;
+
+	list_for_each_entry(node, head, list) {
+		if (node->amode->svid == svid)
+			return node->amode->vdo;
+	}
+
+	return ret;
+}
+
 /*
  * Spoof the VDOs that were likely communicated by the partner for TBT alt
  * mode.
@@ -432,6 +453,9 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 
 	/* Cable Discover Mode VDO */
 	data.cable_mode = TBT_MODE;
+
+	data.cable_mode |= cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID);
+
 	data.cable_mode |= TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
 
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
@@ -522,8 +546,10 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 	/* Cable Type */
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
-	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+	else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) & TBT_CABLE_RETIMER)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
 
 	data.active_link_training = !!(pd_ctrl->control_flags &
 				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
-- 
2.25.1

