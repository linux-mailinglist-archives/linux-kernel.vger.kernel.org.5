Return-Path: <linux-kernel+bounces-18746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BF82627E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83AE1F239FD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC6A92F;
	Sun,  7 Jan 2024 00:17:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE346A9;
	Sun,  7 Jan 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 32AEA14056A; Sun,  7 Jan 2024 01:17:53 +0100 (CET)
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
Subject: [PATCH 4/4] usb: ucsi: Apply UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD to Dell systems
Date: Sun,  7 Jan 2024 01:17:01 +0100
Message-Id: <20240107001701.130535-5-lk@c--e.de>
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

Apply the UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD to all Dell systems.

There are various reports that ucsi does not work on Dell systems
with "GET_CONNECTOR_STATUS failed". At least some of these are
most likely due to the need for this quirk.

If the logic is wrong users can still use the new quirk override
for the typec_ucsi module to disable the quirk.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 36 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 78a0d13584ad..690d5e55bdc4 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -27,6 +27,11 @@ struct ucsi_acpi {
 	u64 cmd;
 };
 
+struct ucsi_acpi_attach_data {
+	const struct ucsi_operations *ops;
+	unsigned int quirks;
+};
+
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 {
 	union acpi_object *obj;
@@ -121,12 +126,30 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
-static const struct dmi_system_id zenbook_dmi_id[] = {
+static const struct ucsi_acpi_attach_data ucsi_acpi_default_attach_data = {
+	.ops = &ucsi_acpi_ops,
+	.quirks = 0
+};
+
+static const struct dmi_system_id ucsi_acpi_quirks[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
 		},
+		.driver_data = &(struct ucsi_acpi_attach_data) {
+			.ops = &ucsi_zenbook_ops,
+			.quirks = 0
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+		.driver_data = &(struct ucsi_acpi_attach_data) {
+			.ops = &ucsi_acpi_ops,
+			.quirks = UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD
+		},
 	},
 	{ }
 };
@@ -152,7 +175,8 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
-	const struct ucsi_operations *ops = &ucsi_acpi_ops;
+	const struct dmi_system_id *id;
+	const struct ucsi_acpi_attach_data *attach;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -182,10 +206,12 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
-	if (dmi_check_system(zenbook_dmi_id))
-		ops = &ucsi_zenbook_ops;
+	attach = &ucsi_acpi_default_attach_data;
+	id = dmi_first_match(ucsi_acpi_quirks);
+	if (id)
+		attach = id->driver_data;
 
-	ua->ucsi = ucsi_create(&pdev->dev, ops, 0);
+	ua->ucsi = ucsi_create(&pdev->dev, attach->ops, attach->quirks);
 	if (IS_ERR(ua->ucsi))
 		return PTR_ERR(ua->ucsi);
 
-- 
2.40.1


