Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9770879C40A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjILDU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbjILCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:41:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C258267B;
        Mon, 11 Sep 2023 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694484410; x=1726020410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0KRQ31svCbbSmvCwD5cuPxIgP0RgOwqBzNkFj74VG44=;
  b=Z4YB1gsZ9SgAXsuI25k8doF478CFs2n4zXScun/HYnxdEXd5xP2BMZMi
   CCiqYvtEjo+llc5PhxorsdfChV0YtaeWQQggtYLhj/SfAwmEn85YVb51Q
   RqeulvzNFME6+pKxuSmDa2HqfVkNk6+G01VQMEeU9UQjYy8HJwhBB6Brw
   t2n07t5UHYvaXK1luj9CMJFfEz552R1FbUXQZE4UxMHShQPb1wptWbjet
   R++pePIbbcfMsvHyQe3YcWfrkyFq1Td8wPQKqrO9nhdTy9xKcKafu11dz
   C9Wpv7HAKIyGEcF0uGENi6FNRxECkbGbewP8E75o3a8U3Z/cRIWqpAotb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382057908"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="382057908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858570620"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858570620"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 17:58:10 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 4/4] usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1
Date:   Mon, 11 Sep 2023 17:57:52 -0700
Message-Id: <20230912005752.1532888-5-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
References: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mux agent driver can configure cable details such as cable type and
cable speed received as a part of displayport configuration to support
Displayport Alternate mode 2.1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v3:
- No change.

Changes in v2:
- No change.

 drivers/usb/typec/mux/intel_pmc_mux.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 60ed1f809130..233958084b43 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -191,6 +191,12 @@ static int hsl_orientation(struct pmc_usb_port *port)
 	return port->orientation - 1;
 }
 
+static bool is_pmc_mux_tbt(struct acpi_device *adev)
+{
+	return acpi_dev_hid_uid_match(adev, "INTC1072", NULL) ||
+	       acpi_dev_hid_uid_match(adev, "INTC1079", NULL);
+}
+
 static int pmc_usb_send_command(struct intel_scu_ipc_dev *ipc, u8 *msg, u32 len)
 {
 	u8 response[4];
@@ -293,6 +299,24 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
 			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
 
+	if (!is_pmc_mux_tbt(port->pmc->iom_adev)) {
+		u8 cable_speed = (data->conf & DP_CONF_SIGNALLING_MASK) >>
+				  DP_CONF_SIGNALLING_SHIFT;
+
+		u8 cable_type = (data->conf & DP_CONF_CABLE_TYPE_MASK) >>
+				 DP_CONF_CABLE_TYPE_SHIFT;
+
+		req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
+
+		if (cable_type == DP_CONF_CABLE_TYPE_OPTICAL)
+			req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
+		else if (cable_type == DP_CONF_CABLE_TYPE_RE_TIMER)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE |
+					 PMC_USB_ALTMODE_RETIMER_CABLE;
+		else if (cable_type == DP_CONF_CABLE_TYPE_RE_DRIVER)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+	}
+
 	ret = pmc_usb_command(port, (void *)&req, sizeof(req));
 	if (ret)
 		return ret;
-- 
2.25.1

