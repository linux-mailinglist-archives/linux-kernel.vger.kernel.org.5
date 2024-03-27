Return-Path: <linux-kernel+bounces-122115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5788F201
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F80296745
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4AD154BF9;
	Wed, 27 Mar 2024 22:46:25 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973B339A0;
	Wed, 27 Mar 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579584; cv=none; b=moVkfxZzbdF6z1Nu/iNWIMwWGV7dGUIKh+/xgJdSviOKY9o0q5SKJP9NTyrlvSdgmkqjVpOSSXXxQYEXXPFeSeqiAkWa8TtxEKOZ7OUKclH+YPKA6L0Xeb1LwWirqSKf1V5x566cBFJ+k4P7WY6P2Yi87dU/nH5wiOMvHu3Slxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579584; c=relaxed/simple;
	bh=b76/hj0hFBqmc79aZ2oc311VH9Kf6y948ZRvzP7LfgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wl1/SMzS9bSYI64XIeU7POi3Mp5LCWsKdNDQlGRYhPghIBoQfwmlccrMCTlXAelc5JpwQbd6dcaEhQe/kXbsLkEM9KORdmJ39uuBEMPnAZ0BWUeauBnomnoRDm8OKcxblQ5f2V04r4l1w3jAizjxUifOBq43DdDU8jXjB3LDqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id B18E81404B4; Wed, 27 Mar 2024 23:46:20 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org
Subject: [PATCH 3/3] usb: typec: ucsi_acpi: Remove Dell quirk
Date: Wed, 27 Mar 2024 23:45:54 +0100
Message-Id: <20240327224554.1772525-4-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327224554.1772525-1-lk@c--e.de>
References: <20240327224554.1772525-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Dell quirk from ucsi_acpi.c. The quirk is no longer
necessary as we no longer send lone connector change acks.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 53 +-----------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index cc03a49c589c..8d112c3edae5 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -23,7 +23,6 @@ struct ucsi_acpi {
 	void *base;
 	struct completion complete;
 	unsigned long flags;
-#define UCSI_ACPI_SUPPRESS_EVENT	0
 #define UCSI_ACPI_COMMAND_PENDING	1
 #define UCSI_ACPI_ACK_PENDING		2
 	guid_t guid;
@@ -129,49 +128,6 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
-/*
- * Some Dell laptops don't like ACK commands with the
- * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
- * bit set. To work around this send a dummy command and bundle the
- * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
- * for the dummy command.
- */
-static int
-ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
-		     const void *val, size_t val_len)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	u64 cmd = *(u64 *)val;
-	u64 dummycmd = UCSI_GET_CAPABILITY;
-	int ret;
-
-	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
-		cmd |= UCSI_ACK_COMMAND_COMPLETE;
-
-		/*
-		 * The UCSI core thinks it is sending a connector change ack
-		 * and will accept new connector change events. We don't want
-		 * this to happen for the dummy command as its response will
-		 * still report the very event that the core is trying to clear.
-		 */
-		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
-					   sizeof(dummycmd));
-		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
-
-		if (ret < 0)
-			return ret;
-	}
-
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
-}
-
-static const struct ucsi_operations ucsi_dell_ops = {
-	.read = ucsi_acpi_read,
-	.sync_write = ucsi_dell_sync_write,
-	.async_write = ucsi_acpi_async_write
-};
-
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
 	{
 		.matches = {
@@ -180,12 +136,6 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_zenbook_ops,
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		},
-		.driver_data = (void *)&ucsi_dell_ops,
-	},
 	{ }
 };
 
@@ -199,8 +149,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci) &&
-	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
+	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
-- 
2.40.1


