Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE37571C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGRCbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGRCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:30:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA418B;
        Mon, 17 Jul 2023 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689647457; x=1721183457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7o9A4IFpoFg1NJsHPRHQcQwcm/SqPXe2+JoM52ZICQM=;
  b=i6lQU4zxVaJFcMmmL7ry040SMtVknaUt+Jp7E2n4AaAYckqU44lqxRq5
   gm7WB4tz2mtYibf1kYzgNYTL82d6QXOxEVlqIVQjZZzQJhh82O9Svi89S
   i17cfdbkz/dqpMujcdVcJRW8mXcEVVA+YnUvzvTaXFJPLvg//9CxC4TAh
   jJRMvTmMmqK5GDtCslO0G1TJfu9+JP+WJrbNr4KDOXtr1eVNbcPzscWND
   52ptT24+gNuGIvQneNER4XUmZT9TjV+pdNptHP69yPkpdjfHmYB8ElcZE
   ddWgop3GJzFQ5Z46XBbQsKq7lZxrRGRXI8YITOYACNO2nZa9DZxkaMHwo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452467243"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="452467243"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726760901"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726760901"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 19:30:55 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 2/2] usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type
Date:   Mon, 17 Jul 2023 19:47:03 -0700
Message-Id: <20230718024703.1013367-3-utkarsh.h.patel@intel.com>
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

Cable type such as active and retimer received as a part of Thunderbolt3
or Thunderbolt4 cable discover mode VDO needs to be configured in the
thunderbolt alternate mode.

Configuring the register bits for this cable type is changed with Intel
Meteor Lake platform. BIT2 for Retimer/Redriver cable and BIT22 for
Active/Passive cable.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v4:
 - No changes.

Changes in v3:
 - No changes.

Changes in v2:
 - No changes.
---
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 5e8edf3881c0..888632847a74 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -59,7 +59,7 @@ enum {
 };
 
 /* Common Mode Data bits */
-#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(2)
+#define PMC_USB_ALTMODE_RETIMER_CABLE	BIT(2)
 
 #define PMC_USB_ALTMODE_ORI_SHIFT	1
 #define PMC_USB_ALTMODE_UFP_SHIFT	3
@@ -71,6 +71,7 @@ enum {
 #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
 #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
 #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
+#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(22)
 #define PMC_USB_ALTMODE_FORCE_LSR	BIT(23)
 #define PMC_USB_ALTMODE_CABLE_SPD(_s_)	(((_s_) & GENMASK(2, 0)) << 25)
 #define   PMC_USB_ALTMODE_CABLE_USB31	1
@@ -319,8 +320,18 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 	if (data->cable_mode & TBT_CABLE_LINK_TRAINING)
 		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
 
-	if (data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE)
-		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+	if (acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+	    acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL)) {
+		if ((data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE) ||
+		    (data->cable_mode & TBT_CABLE_RETIMER))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+	} else {
+		if (data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+
+		if (data->cable_mode & TBT_CABLE_RETIMER)
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+	}
 
 	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
 
@@ -359,8 +370,17 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 	case EUDO_CABLE_TYPE_OPTICAL:
 		req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
 		fallthrough;
+	case EUDO_CABLE_TYPE_RE_TIMER:
+		if (!acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+		    !acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+		fallthrough;
 	default:
-		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+		if (acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+		    acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+		else
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
 
 		/* Configure data rate to rounded in the case of Active TBT3
 		 * and USB4 cables.
-- 
2.25.1

