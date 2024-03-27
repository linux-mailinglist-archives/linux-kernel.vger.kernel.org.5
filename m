Return-Path: <linux-kernel+bounces-122114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BA88F1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160A11F2D946
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6E154436;
	Wed, 27 Mar 2024 22:46:24 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E9153822;
	Wed, 27 Mar 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579584; cv=none; b=GCImtAUU0GmuEhiY7Y4tjIeulJhl+1yY2gVm0fMiXscvkZZZqYnaJ4ytfFZHzGol1ErO2WTbmTdUmNFh4AD4/jTk5ph/okEKX7nqtWqAHF/HodvhwiNVrG3P7sxQClRKJE41Fu51q9i3VR/xAdmesFG19p0WUgmzTuE+0FV5/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579584; c=relaxed/simple;
	bh=NDkRlF2/5vzs3/810luSDUIay1pqXOpyWDfGWEloJxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1Ggk5jlHj8kTeCSQKJovrl2hIZ7zqZTmZGcx4i7jv59uW5awO7qDfOlm+7HkH5OTax7/gOEBgOEVVdP2QwKCaxd8Rl+hQXRIVJFd+BGkHmZ6ja6vTLvZMFdY+Gyd6j15Hb0GG5gXhZfB9Yi8srSJs802+8sGevRfy9AIG+YFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1027914040D; Wed, 27 Mar 2024 23:46:20 +0100 (CET)
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
Subject: [PATCH 2/3] usb: typec: ucsi: Never send a lone connector change ack
Date: Wed, 27 Mar 2024 23:45:53 +0100
Message-Id: <20240327224554.1772525-3-lk@c--e.de>
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

Some PPM implementation do not like UCSI_ACK_CONNECTOR_CHANGE
without UCSI_ACK_COMMAND_COMPLETE. Moreover, doing this is racy
as it requires sending two UCSI_ACK_CC_CI commands in a row and
the second one will be started with UCSI_CCI_ACK_COMPLETE already
set in CCI.

Bundle the UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
for the UCSI_GET_CONNECTOR_STATUS command that is sent while
handling a connector change event.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 48 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 31d8a46ae5e7..48f093a1dc09 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -49,22 +49,16 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
 }
 
-static int ucsi_acknowledge_command(struct ucsi *ucsi)
+static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
 
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_COMMAND_COMPLETE;
-
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
-}
-
-static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
-{
-	u64 ctrl;
-
-	ctrl = UCSI_ACK_CC_CI;
-	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	if (conn_ack) {
+		clear_bit(EVENT_PENDING, &ucsi->flags);
+		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	}
 
 	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
 }
@@ -77,7 +71,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	int ret;
 
 	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -89,7 +83,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	if (ret)
 		return ret;
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -152,7 +146,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		return -EIO;
 
 	if (cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge_command(ucsi) < 0)
+		if (ucsi_acknowledge(ucsi, false) < 0)
 			dev_err(ucsi->dev,
 				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
@@ -165,15 +159,15 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
-		ret = ucsi_acknowledge_command(ucsi);
+		ret = ucsi_acknowledge(ucsi, false);
 		return ret ? ret : -EBUSY;
 	}
 
 	return UCSI_CCI_LENGTH(cci);
 }
 
-int ucsi_send_command(struct ucsi *ucsi, u64 command,
-		      void *data, size_t size)
+static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
+				    void *data, size_t size, bool conn_ack)
 {
 	u8 length;
 	int ret;
@@ -192,7 +186,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 			goto out;
 	}
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, conn_ack);
 	if (ret)
 		goto out;
 
@@ -201,6 +195,12 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }
+
+int ucsi_send_command(struct ucsi *ucsi, u64 command,
+		      void *data, size_t size)
+{
+	return ucsi_send_command_common(ucsi, command, data, size, false);
+}
 EXPORT_SYMBOL_GPL(ucsi_send_command);
 
 /* -------------------------------------------------------------------------- */
@@ -1168,7 +1168,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	mutex_lock(&con->lock);
 
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(ucsi, command, &con->status, sizeof(con->status));
+
+	ret = ucsi_send_command_common(ucsi, command, &con->status,
+				       sizeof(con->status), true);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
@@ -1225,14 +1227,6 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
 
-	mutex_lock(&ucsi->ppm_lock);
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-	ret = ucsi_acknowledge_connector_change(ucsi);
-	mutex_unlock(&ucsi->ppm_lock);
-
-	if (ret)
-		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
-
 out_unlock:
 	mutex_unlock(&con->lock);
 }
-- 
2.40.1


