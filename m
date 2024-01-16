Return-Path: <linux-kernel+bounces-28361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270782FD46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C821F2B98A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDB1E880;
	Tue, 16 Jan 2024 22:41:16 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB51D546;
	Tue, 16 Jan 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444876; cv=none; b=jzeq8wJvjicJGNbzlra4AljFBhL6w/U1QZkJaIipkN8yMU9MV4RiNAd7N8bBPbEwZvqDMo8HSsRMnPgqrH4KF8UMtQnS/F7KVjEym57bEhgrIvTwQVMa7pWxmxjI3gjhajg3qfRxfxljQpnOrg8gBGkxPeO9Jja0LmirJBwanpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444876; c=relaxed/simple;
	bh=Us1B128cnUSRTVsPfStgm8OL/356CO5Ra0cSmwYpTsg=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=Qc5AImkPAcvyGjrJo3tKmai4J6oPaB1Gxexsb1BQ1hVhj7wCkzNK4L9ck0yf1kRnoZEdLB302xAfKi2a7nYvd9JKqqSf2tsXv7hDxR3NnAcJsYLDbqRYuLClUnbOFYcssSaKFrleSVT/PWKhWZBotJPFl9uMOxevNEuYOy0IVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id E216214042E; Tue, 16 Jan 2024 23:41:11 +0100 (CET)
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
Subject: [PATCH 3/3] usb: ucsi_acpi: Quirk to ack a connector change ack cmd
Date: Tue, 16 Jan 2024 23:40:41 +0100
Message-Id: <20240116224041.220740-4-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240116224041.220740-1-lk@c--e.de>
References: <20240116224041.220740-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PPM on some Dell laptops seems to expect that the ACK_CC_CI
command to clear the connector change notification is in turn
followed by another ACK_CC_CI to acknowledge the ACK_CC_CI command
itself. This is in violation of the UCSI spec that states:

    "The only notification that is not acknowledged by the OPM is
     the command completion notification for the ACK_CC_CI or the
     PPM_RESET command."

Add a quirk to send this ack anyway.
Apply the quirk to all Dell systems.

On the first command that acks a connector change send a dummy
command to determine if it runs into a timeout. Only activate
the quirk if it does. This ensure that we do not break Dell
systems that do not need the quirk.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 69 ++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 33dac67154d2..a0b08b10c4a9 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -25,6 +25,8 @@ struct ucsi_acpi {
 	unsigned long flags;
 	guid_t guid;
 	u64 cmd;
+	bool dell_quirk_probed;
+	bool dell_quirk_active;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -126,12 +128,71 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
-static const struct dmi_system_id zenbook_dmi_id[] = {
+/**
+ * Some Dell laptops expect that an ACK command with the
+ * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
+ * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
+ * If this is not done events are not delivered to OSPM and
+ * subsequent commands will timeout.
+ */
+static int
+ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
+		     const void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	u64 cmd = *(u64*)val, ack = 0;
+	int ret;
+
+	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
+	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
+		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
+
+	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
+	if (ret != 0)
+		return ret;
+	if (ack == 0)
+		return ret;
+
+	if (!ua->dell_quirk_probed) {
+		ua->dell_quirk_probed = true;
+
+		cmd = UCSI_GET_CAPABILITY;
+		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
+					   sizeof(cmd));
+		if (ret == 0)
+			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
+						    &ack, sizeof(ack));
+		if (ret != -ETIMEDOUT)
+			return ret;
+
+		ua->dell_quirk_active = true;
+	}
+
+	if (!ua->dell_quirk_active)
+		return ret;
+
+	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
+}
+
+static const struct ucsi_operations ucsi_dell_ops = {
+	.read = ucsi_acpi_read,
+	.sync_write = ucsi_dell_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
+static const struct dmi_system_id ucsi_acpi_quirks[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
 		},
+		.driver_data = (void *)&ucsi_zenbook_ops,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+		.driver_data = (void *)&ucsi_dell_ops,
 	},
 	{ }
 };
@@ -160,6 +221,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	const struct ucsi_operations *ops = &ucsi_acpi_ops;
+	const struct dmi_system_id *id;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -189,8 +251,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
-	if (dmi_check_system(zenbook_dmi_id))
-		ops = &ucsi_zenbook_ops;
+	id = dmi_first_match(ucsi_acpi_quirks);
+	if (id)
+		ops = id->driver_data;
 
 	ua->ucsi = ucsi_create(&pdev->dev, ops);
 	if (IS_ERR(ua->ucsi))
-- 
2.40.1


