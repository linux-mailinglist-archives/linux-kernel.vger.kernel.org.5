Return-Path: <linux-kernel+bounces-57079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC784D3D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E6A281B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48A1353F1;
	Wed,  7 Feb 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn7FaBlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCA1350ED;
	Wed,  7 Feb 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340930; cv=none; b=h8wUHiPvjp0v4llwMcimanEPHNinycruoRfh8oA9YqpWbMGd/LK0uqHu9oPtF0pgm2KtTL9kv+zV0F7JSMUzl9WfGuHJ/M3yX3ELWHpxpuZc9JsvEswUUtJt/SwRz1oya6333q+wB2PzebeZd2qT13g7ySpg+r9gzBGHPioQulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340930; c=relaxed/simple;
	bh=Hav5XU/ufGWZZTYwIIjUlWY2a99hvIRioXXqPJlqCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7+s9qRoB/y/NGNhUgZlv8FU5zdMnvH1kubvujuty8F4jXHEb08sglibFhkbohInCWVGePkLNqNneqhsUsgftlbkTwDq0qMNfS0kl5FhdGW6wQUqruft8iR8rCOVEyPjDSTFNc1erBZd5einpSfw9MuuMXANtBbQYom9xr8p60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn7FaBlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DA3C433C7;
	Wed,  7 Feb 2024 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340930;
	bh=Hav5XU/ufGWZZTYwIIjUlWY2a99hvIRioXXqPJlqCRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gn7FaBlPRmfyvfWXBjT9Gu6mD6UuxIB2kAs7UHRTwBbSE3DJ+jYofl5zXtIr1rkG7
	 U4TmZ9Tb8T72q3pQOfL0B4BChZmcl25sdypvej8kcaxfnGcBFDzSe5B+oKREgdy9xi
	 2PQTUs7g8TBkSWs+z8oLB/pTJMTCi7eAtuQukQATLlEekbT4P9F11h27GJSYmWxb4x
	 IqEsTVsCC1p0dzaRQKB+zLc3DQzwlr2ZcT5MSfjqs8YH5vTFpq7/Vk/DMRoyTsvOL6
	 QlTWtXA5hdOn2fVTGW5pTjLBIVzXalrFF7j/9dLs6S9UvbDiARXpT9TklRr7hnerwh
	 ThpVkcAPM9Fww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	samuel@cavoj.net,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 14/44] usb: ucsi_acpi: Quirk to ack a connector change ack cmd
Date: Wed,  7 Feb 2024 16:20:41 -0500
Message-ID: <20240207212142.1399-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: "Christian A. Ehrhardt" <lk@c--e.de>

[ Upstream commit f3be347ea42dbb0358cd8b2d8dc543a23b70a976 ]

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

Signed-off-by: "Christian A. Ehrhardt" <lk@c--e.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240121204123.275441-4-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 71 ++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6bbf490ac401..5fbd5a218341 100644
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
@@ -119,12 +121,73 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
-static const struct dmi_system_id zenbook_dmi_id[] = {
+/*
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
+	u64 cmd = *(u64 *)val, ack = 0;
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
+		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
+		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
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
@@ -151,6 +214,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	const struct ucsi_operations *ops = &ucsi_acpi_ops;
+	const struct dmi_system_id *id;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -180,8 +244,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
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
2.43.0


