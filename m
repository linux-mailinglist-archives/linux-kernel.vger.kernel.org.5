Return-Path: <linux-kernel+bounces-144195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CA8A42F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973BC281937
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0F5B202;
	Sun, 14 Apr 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cd1q8wWh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DF55C2E;
	Sun, 14 Apr 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104587; cv=none; b=U/oJBMfGlN5mQLf+xnhWRF09lrsK8cAyJZtTojFAh+ntO2vIqH3ePogSBi1dCQy+cCA1cas3NKhVOnFlLrJ2L8CQ2XglpZ3yXLxSRIoFSHrH70Elt/q0Pgb1JGa91P0kU6ht77/mrqvblPe1llDHxqgcEiQLoClkiwXeaeNHsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104587; c=relaxed/simple;
	bh=oEpim1JB+dWo1XzMI2u+sBrMULBhBFHqOa8jv7tCAlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0LXcc3bGJO8x6t7oce2PI2xQER+ZGJaOZoRmSc3w3vOR3AewiqIZh+51wsahfvrYj7QciFI/JuCcf7ighm8330kr1LyEEFT82bAWDQ/wkOC5qFUBVm2aWttW5jICUapDO/C11IbRQ0COpJPuiQfS524oYc+pDbhAqy7TQRh7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cd1q8wWh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6EB7C0005;
	Sun, 14 Apr 2024 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph48FvlfhsoGiHnDdwqZqREsFn1u/ine6nAdFMJfYsQ=;
	b=cd1q8wWhkAssO7Ylo1J02rELtvXmV/exM/JwQU+oFC5DQZnM6TIGZJxoMdW7vKBpUK6VzA
	Q9u1nzesbC4uPVmhcOpyouseJ5AGDj86yGYMbIndkExEiGTvKh7S4GZah/UoX048zmql26
	PMQJoxAr+xk+jNSY+5JYmJdAFxVzFvL2GxuNoR8FzPnreYiel4K2SR76ca4AFhChmUKRmS
	OaZHLQJuIYIicRyPCI6ONoivi8bJAaJOtTI7kZ+i2Jx5BzfLxDfqtX+EzvtifzgBFEa8gt
	yoZnrap/VpMP4crUOh1K2svczJMTnjwm8WJK2eeK5n9sShVCrOyczBXmCVBoxQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:53 +0200
Subject: [PATCH net-next v8 04/17] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-feature_poe-v8-4-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

In the current PSE interface for Ethernet Power Equipment, support is
limited to PoDL. This patch extends the interface to accommodate the
objects specified in IEEE 802.3-2022 145.2 for Power sourcing
Equipment (PSE).

The following objects are now supported and considered mandatory:
- IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus
- IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
- IEEE 802.3-2022 30.9.1.2.1 aPSEAdminControl

To avoid confusion between "PoDL PSE" and "PoE PSE", which have similar
names but distinct values, we have followed the suggestion of Oleksij
Rempel and Andrew Lunn to maintain separate naming schemes for each,
using c33 (clause 33) prefix for "PoE PSE".
You can find more details in the discussion threads here:
https://lore.kernel.org/netdev/20230912110637.GI780075@pengutronix.de/
https://lore.kernel.org/netdev/2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch/

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Rename all the PoE variables and enum with a c33 prefix.
- Add documentation, thanks to Oleksij for having written one.

Changes in v3:
- Fix documentation build warning.
---
 Documentation/networking/index.rst               |  1 +
 Documentation/networking/pse-pd/index.rst        |  9 +++
 Documentation/networking/pse-pd/introduction.rst | 73 ++++++++++++++++++++++++
 include/linux/pse-pd/pse.h                       |  9 +++
 include/uapi/linux/ethtool.h                     | 43 ++++++++++++++
 include/uapi/linux/ethtool_netlink.h             |  3 +
 6 files changed, 138 insertions(+)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 473d72c36d61..7664c0bfe461 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -93,6 +93,7 @@ Contents:
    plip
    ppp_generic
    proc_net_tcp
+   pse-pd/index
    radiotap-headers
    rds
    regulatory
diff --git a/Documentation/networking/pse-pd/index.rst b/Documentation/networking/pse-pd/index.rst
new file mode 100644
index 000000000000..18197bc7303d
--- /dev/null
+++ b/Documentation/networking/pse-pd/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Power Sourcing Equipment (PSE) Documentation
+============================================
+
+.. toctree::
+   :maxdepth: 2
+
+   introduction
diff --git a/Documentation/networking/pse-pd/introduction.rst b/Documentation/networking/pse-pd/introduction.rst
new file mode 100644
index 000000000000..e3d3faaef717
--- /dev/null
+++ b/Documentation/networking/pse-pd/introduction.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Power Sourcing Equipment (PSE) in IEEE 802.3 Standard
+=====================================================
+
+Overview
+--------
+
+Power Sourcing Equipment (PSE) is essential in networks for delivering power
+along with data over Ethernet cables. It usually refers to devices like
+switches and hubs that supply power to Powered Devices (PDs) such as IP
+cameras, VoIP phones, and wireless access points.
+
+PSE vs. PoDL PSE
+----------------
+
+PSE in the IEEE 802.3 standard generally refers to equipment that provides
+power alongside data over Ethernet cables, typically associated with Power over
+Ethernet (PoE).
+
+PoDL PSE, or Power over Data Lines PSE, specifically denotes PSEs operating
+with single balanced twisted-pair PHYs, as per Clause 104 of IEEE 802.3. PoDL
+is significant in contexts like automotive and industrial controls where power
+and data delivery over a single pair is advantageous.
+
+IEEE 802.3-2018 Addendums and Related Clauses
+---------------------------------------------
+
+Key addenda to the IEEE 802.3-2018 standard relevant to power delivery over
+Ethernet are as follows:
+
+- **802.3af (Approved in 2003-06-12)**: Known as PoE in the market, detailed in
+  Clause 33, delivering up to 15.4W of power.
+- **802.3at (Approved in 2009-09-11)**: Marketed as PoE+, enhancing PoE as
+  covered in Clause 33, increasing power delivery to up to 30W.
+- **802.3bt (Approved in 2018-09-27)**: Known as 4PPoE in the market, outlined
+  in Clause 33. Type 3 delivers up to 60W, and Type 4 up to 100W.
+- **802.3bu (Approved in 2016-12-07)**: Formerly referred to as PoDL, detailed
+  in Clause 104. Introduces Classes 0 - 9. Class 9 PoDL PSE delivers up to ~65W
+
+Kernel Naming Convention Recommendations
+----------------------------------------
+
+For clarity and consistency within the Linux kernel's networking subsystem, the
+following naming conventions are recommended:
+
+- For general PSE (PoE) code, use "c33_pse" key words. For example:
+  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
+  This aligns with Clause 33, encompassing various PoE forms.
+
+- For PoDL PSE - specific code, use "podl_pse". For example:
+  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to differentiate
+  PoDL PSE settings according to Clause 104.
+
+Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Dependent Interface (MDI)
+---------------------------------------------------------------------------------------------
+
+Clause 33 of the IEEE 802.3 standard defines the functional and electrical
+characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE).
+These entities enable power delivery using the same generic cabling as for data
+transmission, integrating power with data communication for devices such as
+10BASE-T, 100BASE-TX, or 1000BASE-T.
+
+Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twisted-Pair Ethernet
+--------------------------------------------------------------------------------------------
+
+Clause 104 of the IEEE 802.3 standard delineates the functional and electrical
+characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Equipment
+(PSEs). These are designed for use with single balanced twisted-pair Ethernet
+Physical Layers. In this clause, 'PSE' refers specifically to PoDL PSE, and
+'PD' to PoDL PD. The key intent is to provide devices with a unified interface
+for both data and the power required to process this data over a single
+balanced twisted-pair Ethernet connection.
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 199cf4ae3cf2..be4e5754eb24 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -17,9 +17,12 @@ struct pse_controller_dev;
  *
  * @podl_admin_control: set PoDL PSE admin control as described in
  *	IEEE 802.3-2018 30.15.1.2.1 acPoDLPSEAdminControl
+ * @c33_admin_control: set PSE admin control as described in
+ *	IEEE 802.3-2022 30.9.1.2.1 acPSEAdminControl
  */
 struct pse_control_config {
 	enum ethtool_podl_pse_admin_state podl_admin_control;
+	enum ethtool_c33_pse_admin_state c33_admin_control;
 };
 
 /**
@@ -29,10 +32,16 @@ struct pse_control_config {
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
  * @podl_pw_status: power detection status of the PoDL PSE.
  *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @c33_admin_state: operational state of the PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @c33_pw_status: power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
+	enum ethtool_c33_pse_admin_state c33_admin_state;
+	enum ethtool_c33_pse_pw_d_status c33_pw_status;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 95c2f09f0d0a..29ac06d66228 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -752,6 +752,49 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_c33_pse_admin_state - operational state of the PoDL PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN: state of PSE functions is unknown
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED: PSE functions are disabled
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED: PSE functions are enabled
+ */
+enum ethtool_c33_pse_admin_state {
+	ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN = 1,
+	ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
+	ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED,
+};
+
+/**
+ * enum ethtool_c33_pse_pw_d_status - power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN: PSE status is unknown
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED: "The enumeration \u201cdisabled\u201d
+ *	indicates that the PSE State diagram is in the state DISABLED."
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING: "The enumeration \u201csearching\u201d
+ *	indicates the PSE State diagram is in a state other than those
+ *	listed."
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING: "The enumeration
+ *	\u201cdeliveringPower\u201d indicates that the PSE State diagram is in the
+ *	state POWER_ON."
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_TEST: "The enumeration \u201ctest\u201d indicates that
+ *	the PSE State diagram is in the state TEST_MODE."
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_FAULT: "The enumeration \u201cfault\u201d indicates that
+ *	the PSE State diagram is in the state TEST_ERROR."
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT: "The enumeration \u201cotherFault\u201d
+ *	indicates that the PSE State diagram is in the state IDLE due to
+ *	the variable error_condition = true."
+ */
+enum ethtool_c33_pse_pw_d_status {
+	ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN = 1,
+	ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED,
+	ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING,
+	ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING,
+	ETHTOOL_C33_PSE_PW_D_STATUS_TEST,
+	ETHTOOL_C33_PSE_PW_D_STATUS_FAULT,
+	ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT,
+};
+
 /**
  * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b4f0d233d048..f17dbe54bf5e 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -913,6 +913,9 @@ enum {
 	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,

-- 
2.34.1


