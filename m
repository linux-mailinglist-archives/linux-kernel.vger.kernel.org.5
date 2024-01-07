Return-Path: <linux-kernel+bounces-18744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356D82627A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452F21C20F38
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B4443C;
	Sun,  7 Jan 2024 00:17:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875423B4;
	Sun,  7 Jan 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 2388F140346; Sun,  7 Jan 2024 01:17:50 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] usb: ucsi: Add quirk infrastructure
Date: Sun,  7 Jan 2024 01:16:59 +0100
Message-Id: <20240107001701.130535-3-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240107001701.130535-1-lk@c--e.de>
References: <20240107001701.130535-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bus drivers to specify quirks for the UCSI core on
attach. Allow the user to override the quirks on the command
line.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/usb/typec/ucsi/ucsi.c                   | 12 +++++++++++-
 drivers/usb/typec/ucsi/ucsi.h                   |  6 +++++-
 drivers/usb/typec/ucsi/ucsi_acpi.c              |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c               |  2 +-
 drivers/usb/typec/ucsi/ucsi_glink.c             |  2 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c           |  2 +-
 7 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a6a4b7f7a3b..fd8152dd4450 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6783,6 +6783,11 @@
 			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
 			See also Documentation/input/devices/joystick-parport.rst
 
+	typec_ucsi.quirks=	[USB]
+			A hex value specifying the quirks to enable for
+			the USB Type-C connector system software interface
+			driver. This overrides auto detected quirks.
+
 	udbg-immortal	[PPC] When debugging early kernel crashes that
 			happen after console_init() and before a proper
 			console driver takes over, this boot options might
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 8f9dff993b3d..00b23292f46f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,6 +36,11 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
+/* Override for auto detected quirks. */
+static unsigned int quirk_override = ~0U;
+module_param_named(quirks, quirk_override, uint, S_IRUGO);
+MODULE_PARM_DESC(quirks, "Override quirks for UCSI");
+
 static int ucsi_acknowledge_command(struct ucsi *ucsi)
 {
 	u64 ctrl;
@@ -1507,7 +1512,8 @@ EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
  * @dev: Device interface to the PPM (Platform Policy Manager)
  * @ops: I/O routines
  */
-struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
+struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops,
+			 unsigned int quirks)
 {
 	struct ucsi *ucsi;
 
@@ -1523,6 +1529,10 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	mutex_init(&ucsi->ppm_lock);
 	ucsi->dev = dev;
 	ucsi->ops = ops;
+	if (quirk_override != ~0U)
+		ucsi->quirks = quirk_override;
+	else
+		ucsi->quirks = quirks;
 
 	return ucsi;
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 474315a72c77..5e6d2225c9c8 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -57,7 +57,8 @@ struct ucsi_operations {
 				struct ucsi_altmode *updated);
 };
 
-struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);
+struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops,
+			 unsigned int quirks);
 void ucsi_destroy(struct ucsi *ucsi);
 int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
@@ -317,6 +318,9 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
+
+	/* Enabled quirks. */
+	unsigned int quirks;
 };
 
 #define UCSI_MAX_SVID		5
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 8062d0a4b523..78a0d13584ad 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -185,7 +185,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	if (dmi_check_system(zenbook_dmi_id))
 		ops = &ucsi_zenbook_ops;
 
-	ua->ucsi = ucsi_create(&pdev->dev, ops);
+	ua->ucsi = ucsi_create(&pdev->dev, ops, 0);
 	if (IS_ERR(ua->ucsi))
 		return PTR_ERR(ua->ucsi);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 449c125f6f87..d491b6547fc3 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1387,7 +1387,7 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 	if (uc->info.mode & CCG_DEVINFO_PDPORTS_MASK)
 		uc->port_num++;
 
-	uc->ucsi = ucsi_create(dev, &ucsi_ccg_ops);
+	uc->ucsi = ucsi_create(dev, &ucsi_ccg_ops, 0);
 	if (IS_ERR(uc->ucsi))
 		return PTR_ERR(uc->ucsi);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index db6e248f8208..49587960b6a3 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -318,7 +318,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	init_completion(&ucsi->sync_ack);
 	mutex_init(&ucsi->lock);
 
-	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
+	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops, 0);
 	if (IS_ERR(ucsi->ucsi))
 		return PTR_ERR(ucsi->ucsi);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 93d7806681cf..269caa3b4e84 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -641,7 +641,7 @@ static int ucsi_stm32g0_probe(struct i2c_client *client)
 	init_completion(&g0->complete);
 	i2c_set_clientdata(client, g0);
 
-	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
+	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops, 0);
 	if (IS_ERR(g0->ucsi))
 		return PTR_ERR(g0->ucsi);
 
-- 
2.40.1


