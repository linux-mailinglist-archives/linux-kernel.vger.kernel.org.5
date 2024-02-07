Return-Path: <linux-kernel+bounces-56682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FB84CD84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472452923AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3337F7EB;
	Wed,  7 Feb 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bz//pEE0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D227FBBE;
	Wed,  7 Feb 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317963; cv=none; b=MXtKbVpXTvfdRK5JG6D0P1A/y/+4Ksy+gNsuW6eaOr0J2I0IRShr+ZlIoUX8hiunS4CNEcLq4/zoPd0YnAh7GxpO5L8IEaD3iFp6vgR98qwC3YXitumOGQWvArJIL2wC/Dl0TBPJryBWq3ZC9eRbdt49Vo+Du5bFxrzaZfzk7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317963; c=relaxed/simple;
	bh=wJ5erar78HhMhQzSx2+rDQ9WduuYUwpvlY26tbDxq6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkJYzoKbk8duz38gZ8dpfnmV9JeFhsAVQt59IV9+wOR7W8Q860MJmp0BBMZYMbUn/J/LMkCeCeZ0HQ/mhF7v6g3GS2CEqzJdLxYDiPdQhvPD6tupUnDLbTA0pL/F71ALoFdQzHcPVAjXUo/iuDs9mNPDge4clGUU4OWGsxNAss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bz//pEE0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317962; x=1738853962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJ5erar78HhMhQzSx2+rDQ9WduuYUwpvlY26tbDxq6g=;
  b=Bz//pEE0nLE17QsgMYDeMR9rasJSCe4mNDgi8NttTfImga5p1tK6LmoH
   mbNjTsIJJmIZLStnlmLM3CYPBBkxZKafw7lzx84scLB1MO2REp29/hTaH
   kslrY5FE3da6JixXpP/fryzXqdkutboSTID7rJtIHU/JBQMgsesFkdr/L
   SvOqvlwjSkUBoaQ5M7ET+Marb2uNTLvZzl3lUFTZeO9flZH0BVKa1u4pz
   fFIug7yW+Y+Vv6gz3uJ0ykkeMzwrER+zhVc8YVPQafPOtGbC1UeBuML8m
   7qRhew1puG0ButRuV09TsJ6qloFnOfdAYkVu1lfKOWj8NsPgkkNoXeF6f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1155047"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1155047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="933799566"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="933799566"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 06:59:00 -0800
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
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uday Bhat <uday.m.bhat@intel.com>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD
Date: Wed,  7 Feb 2024 16:58:51 +0200
Message-ID: <20240207145851.1603237-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
References: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
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
 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b2f14a1b711..5c14e8db08b5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -28,6 +28,7 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 				       struct fwnode_handle *fwnode,
 				       struct device *dev)
 {
+	struct fwnode_handle *sw_fwnode;
 	const char *buf;
 	int ret;
 
@@ -66,6 +67,16 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 		cap->prefer_role = ret;
 	}
 
+	/* Assing the USB role switch the correct pld_crc if it's missing. */
+	sw_fwnode = fwnode_find_reference(fwnode, "usb-role-switch", 0);
+	if (!IS_ERR_OR_NULL(sw_fwnode)) {
+		struct acpi_device *adev = to_acpi_device_node(sw_fwnode);
+
+		if (adev && !adev->pld_crc)
+			adev->pld_crc = to_acpi_device_node(fwnode)->pld_crc;
+		fwnode_handle_put(sw_fwnode);
+	}
+
 	cap->fwnode = fwnode;
 
 	return 0;
-- 
2.43.0


