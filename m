Return-Path: <linux-kernel+bounces-63551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3E853123
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D4B25E12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEBF51C31;
	Tue, 13 Feb 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loBi76Bu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374D51039;
	Tue, 13 Feb 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829233; cv=none; b=KQiO76iCGJ88gmybRzYfl94r2RDOen6xJgP4FA3xO6sz1bMASvvnKmN4y06BIky9DNxBtena8qVOjyDVmeUWW+ledzxvbwHVhDPSXG1oThBLirc77nvtaz9F34kDZyjt2thVACZ10SfmnJtFmjc38Icoua9M6J+Siroo0Ly0sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829233; c=relaxed/simple;
	bh=FPXgBnSmS+6sKYbXhTyHNlC+korVLPzZkGCgDSeKV5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1vbQa0nz8ePesFnxlrgoWdhQV18PA25FzbbxeDZN24HPWcXD7WUo+p6sWeWQxRW0u9GvRghYzNxv2uOm/ivzQFRiHFISr5dPCxw6BUkvbBt0okvKsI0YiiTWQjWfmd6zxVoO9ShRtAK7rKrfELRSaF1ncMq49ARXIE5PTNgqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loBi76Bu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707829232; x=1739365232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPXgBnSmS+6sKYbXhTyHNlC+korVLPzZkGCgDSeKV5I=;
  b=loBi76BuShhYeDmHFGG/8Iramm+LjE8Vau7YaP2GUObELxoqJcfqgURq
   s9Dn+4Vp61VJEa6zRgxazhMK616QqUE+kuQuxoZSqJwyL60bxTgOXFq9k
   K39fHnzWYFjFqwY+sM2UUNcmhGFNaZR1LrjTVd20dtrkpG8HPyD7eiL+m
   27Emin+V+lIRdh7Xh2RHOE9oxFPEe4HvDIKPZytmUFOscf2OP0moWGK4A
   GbBrlKN9VU6zXiqavOZMdyZZy3xu4LEC0Qd2DkZomtztmdvRMvXdfIzfw
   voWEBvTeWMDUS6jSzWs5JFO3WI87p0fd5RCcEm5qc2E0LQIZDB0paIXPK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1708904"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1708904"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:00:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935348383"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935348383"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 05:00:27 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>,
	Uday Bhat <uday.m.bhat@intel.com>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD
Date: Tue, 13 Feb 2024 15:00:18 +0200
Message-ID: <20240213130018.3029991-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB role switch does not always have the _PLD (Physical
Location of Device) in ACPI tables. If it's missing,
assigning the PLD hash of the port to the switch. That
should guarantee that the USB Type-C port mapping code is
always able to find the connection between the two (the port
and the switch).

Tested-by: Uday Bhat <uday.m.bhat@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b2f14a1b711..4d305876ec08 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -24,6 +24,23 @@
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
 				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
 
+static void cros_typec_role_switch_quirk(struct fwnode_handle *fwnode)
+{
+#ifdef CONFIG_ACPI
+	struct fwnode_handle *switch_fwnode;
+
+	/* Supply the USB role switch with the correct pld_crc if it's missing. */
+	switch_fwnode = fwnode_find_reference(fwnode, "usb-role-switch", 0);
+	if (!IS_ERR_OR_NULL(switch_fwnode)) {
+		struct acpi_device *adev = to_acpi_device_node(switch_fwnode);
+
+		if (adev && !adev->pld_crc)
+			adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
+		fwnode_handle_put(switch_fwnode);
+	}
+#endif
+}
+
 static int cros_typec_parse_port_props(struct typec_capability *cap,
 				       struct fwnode_handle *fwnode,
 				       struct device *dev)
@@ -66,6 +83,8 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 		cap->prefer_role = ret;
 	}
 
+	cros_typec_role_switch_quirk(fwnode);
+
 	cap->fwnode = fwnode;
 
 	return 0;
-- 
2.43.0


