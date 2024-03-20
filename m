Return-Path: <linux-kernel+bounces-108564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC6880C37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE41C227D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7DE364C4;
	Wed, 20 Mar 2024 07:40:22 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBE224D7;
	Wed, 20 Mar 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920421; cv=none; b=gPnePPvFbrpk2fw8ETIJlDGIR2ho5+A9dODmIsh5kI7u/TwyDclrxSR1vr3cLbmUdge8P1saaotVXXVQFqVJz1GavHFV6FR8kjdG+QUrl6XNZSt38FC4Nsd8dvME3YYBvitMmY/Qtw2XLvUfq/4/wMojXM1H4+xoPWfrbZS573E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920421; c=relaxed/simple;
	bh=wdumJfdBUiAeynPQ+4UsuFQrroX9g3XBCSeJGri3dZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+Tu3Z2nA8n4QtJwI8LTv/VdGRLau04L+R0txW0rD4IiTpyC6TwqOu7a6aH51snhcZ+Y7Kx9iXFZtX/u1oiF5qhbUPCmpJXM2lGizOGSZbc8N+RzP4B9GBbdKch3f/9lVLoJqsIQ4K9sxmk5yKiZyRpuj1TBZPAB12NW5yCN+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 4F2C214092E; Wed, 20 Mar 2024 08:40:15 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH 4/5] usb: typec: ucsi_acpi: Refactor and fix DELL quirk
Date: Wed, 20 Mar 2024 08:39:25 +0100
Message-Id: <20240320073927.1641788-5-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320073927.1641788-1-lk@c--e.de>
References: <20240320073927.1641788-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DELL systems don't like UCSI_ACK_CC_CI commands with the
UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
bit set. The current quirk still leaves room for races because
it requires two consecutive ACK commands to be sent.

Refactor and significantly simplify the quirk to fix this:
Send a dummy command and bundle the connector change ack with the
command completion ack in a single UCSI_ACK_CC_CI command.
This removes the need to probe for the quirk.

While there define flag bits for struct ucsi_acpi->flags in ucsi_acpi.c
and don't re-use definitions from ucsi.h for struct ucsi->flags.

Fixes: f3be347ea42d ("usb: ucsi_acpi: Quirk to ack a connector change ack cmd")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 75 +++++++++++++-----------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 928eacbeb21a..7b3ac133ef86 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -23,10 +23,11 @@ struct ucsi_acpi {
 	void *base;
 	struct completion complete;
 	unsigned long flags;
+#define UCSI_ACPI_SUPPRESS_EVENT	0
+#define UCSI_ACPI_COMMAND_PENDING	1
+#define UCSI_ACPI_ACK_PENDING		2
 	guid_t guid;
 	u64 cmd;
-	bool dell_quirk_probed;
-	bool dell_quirk_active;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -79,9 +80,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 	int ret;
 
 	if (ack)
-		set_bit(ACK_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		set_bit(COMMAND_PENDING, &ua->flags);
+		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -92,9 +93,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 out_clear_bit:
 	if (ack)
-		clear_bit(ACK_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
 	else
-		clear_bit(COMMAND_PENDING, &ua->flags);
+		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -129,51 +130,40 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 };
 
 /*
- * Some Dell laptops expect that an ACK command with the
- * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
- * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
- * If this is not done events are not delivered to OSPM and
- * subsequent commands will timeout.
+ * Some Dell laptops don't like ACK commands with the
+ * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
+ * bit set. To work around this send a dummy command and bundle the
+ * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
+ * for the dummy command.
  */
 static int
 ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 		     const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	u64 cmd = *(u64 *)val, ack = 0;
+	u64 cmd = *(u64 *)val;
+	u64 dummycmd = UCSI_GET_CAPABILITY;
 	int ret;
 
-	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
-	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
-		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
-
-	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
-	if (ret != 0)
-		return ret;
-	if (ack == 0)
-		return ret;
-
-	if (!ua->dell_quirk_probed) {
-		ua->dell_quirk_probed = true;
-
-		cmd = UCSI_GET_CAPABILITY;
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
-					   sizeof(cmd));
-		if (ret == 0)
-			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
-						    &ack, sizeof(ack));
-		if (ret != -ETIMEDOUT)
+	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
+		cmd |= UCSI_ACK_COMMAND_COMPLETE;
+
+		/*
+		 * The UCSI core thinks it is sending a connector change ack
+		 * and will accept new connector change events. We don't want
+		 * this to happen for the dummy command as its response will
+		 * still report the very event that the core is trying to clear.
+		 */
+		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
+		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
+					   sizeof(dummycmd));
+		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
+
+		if (ret < 0)
 			return ret;
-
-		ua->dell_quirk_active = true;
-		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
-		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
 	}
 
-	if (!ua->dell_quirk_active)
-		return ret;
-
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
+	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
@@ -209,13 +199,14 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
+	if (UCSI_CCI_CONNECTOR(cci) &&
+	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
 		complete(&ua->complete);
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ua->flags))
+	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 
-- 
2.40.1


