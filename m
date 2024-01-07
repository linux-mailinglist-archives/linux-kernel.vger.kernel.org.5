Return-Path: <linux-kernel+bounces-18745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3A82627C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E11D282D75
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E217C4;
	Sun,  7 Jan 2024 00:17:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588323DD;
	Sun,  7 Jan 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 2D28014042E; Sun,  7 Jan 2024 01:17:51 +0100 (CET)
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
Subject: [PATCH 3/4] usb: ucsi: Quirk to ack a connector change ack cmd
Date: Sun,  7 Jan 2024 01:17:00 +0100
Message-Id: <20240107001701.130535-4-lk@c--e.de>
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

The PPM on some Dell laptops seems to expect that the ACK_CC_CI
command to clear the connector change notification is in turn
followed by another ACK_CC_CI to acknowledge the ACK_CC_CI command
itself. This is in violation of the UCSI spec that states:

    "The only notification that is not acknowledged by the OPM is
     the command completion notification for the ACK_CC_CI or the
     PPM_RESET command."

Add a quirk to send this ack anyway.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 7 ++++++-
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 00b23292f46f..8718836b6aba 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -54,11 +54,16 @@ static int ucsi_acknowledge_command(struct ucsi *ucsi)
 static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
 {
 	u64 ctrl;
+	int ret;
 
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
 
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	ret = ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	if (ret == 0 && ucsi->quirks & UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD)
+		ret = ucsi_acknowledge_command(ucsi);
+
+	return ret;
 }
 
 static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 5e6d2225c9c8..9ea2143776cf 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -321,6 +321,7 @@ struct ucsi {
 
 	/* Enabled quirks. */
 	unsigned int quirks;
+#define UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD BIT(0)
 };
 
 #define UCSI_MAX_SVID		5
-- 
2.40.1


