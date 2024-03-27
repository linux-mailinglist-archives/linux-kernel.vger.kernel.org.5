Return-Path: <linux-kernel+bounces-122113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF788F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53261F2DD26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFDB154437;
	Wed, 27 Mar 2024 22:46:24 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AF153815;
	Wed, 27 Mar 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579584; cv=none; b=pv9hY7dxQzekf62dkBZ2J6nGFNYXDDfbhvDxD+iZJSNd9A9hJeXezumGCvwMeNynBdsr9iFnKh3tdAfE5Qkln/pdTQgAOhUUPlcxb2coYzt2jewyYsmR8GKYRKae1+uyVnejxsW0CTqLRVAavf4gBhuPHifL4yXBW4J8wLNypMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579584; c=relaxed/simple;
	bh=Q8UpzXfwmOA5AJ94KM94Y4xhNxS58mjUQ4t7h4EnZAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjRSU/ZEg9C5CNV0eTdfF8ie/vbTHU48tUtPr8/LS2crwhj0GtlO8abaq6zSfxuoySg1cAeYB7LF2QZM4SBEIFYBPoZdN7JzKPaVcPSj536czbBDUuSwZ4pxC6fF1LZjV9i3arx1me7xaSkogT+DPxwcLdt4hAIjwQe2LP6tiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 48416140406; Wed, 27 Mar 2024 23:46:19 +0100 (CET)
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
Subject: [PATCH 1/3] usb: typec: ucsi: Stop abuse of bit definitions from ucsi.h
Date: Wed, 27 Mar 2024 23:45:52 +0100
Message-Id: <20240327224554.1772525-2-lk@c--e.de>
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

In ucsi.h there are flag definitions for the ->flags field
in struct ucsi. Some implementations abuse these bits for
their private ->flags fields e.g. in struct ucsi_acpi.

Move the definitions into the backend implementations that
still need them. While there fix one instance where the flag
name was not converted in a previous change.

No semantic change intended.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.h         | 2 --
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 3 ++-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 0e7c92eb1b22..591f734d457b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -403,8 +403,6 @@ struct ucsi {
 	/* PPM communication flags */
 	unsigned long flags;
 #define EVENT_PENDING	0
-#define COMMAND_PENDING	1
-#define ACK_PENDING	2
 
 	unsigned long quirks;
 #define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 7b3ac133ef86..cc03a49c589c 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -203,7 +203,8 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(UCSI_ACPI_ACK_PENDING, &ua->flags))
 		complete(&ua->complete);
 	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
 	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 93d7806681cf..ac48b7763114 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -64,6 +64,7 @@ struct ucsi_stm32g0 {
 	struct completion complete;
 	struct device *dev;
 	unsigned long flags;
+#define COMMAND_PENDING	1
 	const char *fw_name;
 	struct ucsi *ucsi;
 	bool suspended;
-- 
2.40.1


