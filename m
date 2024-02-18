Return-Path: <linux-kernel+bounces-70611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354F48599CD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46851F20F94
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155B763F3;
	Sun, 18 Feb 2024 22:21:15 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667B745EB;
	Sun, 18 Feb 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294874; cv=none; b=rKrzwyjaJRt1PDm8tTfsjCN5CnDohEgGgS/stmqDKMucD6D6XG3PgoALot2a5YaidIEJ39EqHHRdT72DT2GFo6OwjrptfHtKPl6pbTAIB24wJ/w3YNUZFbaZJSHInPViOXq/7axMi9c7MFWYDfpeXr+RuDcNZPjrev0sJ5IZ7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294874; c=relaxed/simple;
	bh=CKhmIXx5mHmzqsOaPWv1xp25HBv8ABXQGCOtwj7iCO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHAcvsJIHW59Suyc625x7lDWGbhvwr7NQsobZi1h0nuebi564KI99OqC5PTDyehqLDA5j3SYaHhJL7wPVkfRSrXXIsOfLlnrPRifet+mXWavKiFK+1bVex5I3ghRB+A//vjwg92J24CYnyUBCW6ebDlngTh5DTPp2RTabNt+sg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id B2FCA140938; Sun, 18 Feb 2024 23:21:09 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Min-Hua Chen <minhuadotchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [RFC PATCH 6/6] usb: typec: ucsi: Convert a?sync_write to a?sync_cmd
Date: Sun, 18 Feb 2024 23:20:39 +0100
Message-Id: <20240218222039.822040-7-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240218222039.822040-1-lk@c--e.de>
References: <20240218222039.822040-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->sync_write an ->async_write callbacks are only used to write to
the UCSI_CONTROL field and start a command, now.

Rename them accordingly and remove parameters and code that are no
longer used. While there note that the command passed in from the
UCSI core is in host byte order but the command sent to UCSI must
be in little endian byte order.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c         | 29 ++++++-------------
 drivers/usb/typec/ucsi/ucsi.h         | 14 ++++-----
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 41 ++++++++++++---------------
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 35 +++++++++++------------
 drivers/usb/typec/ucsi/ucsi_glink.c   | 18 ++++++------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 16 +++++------
 6 files changed, 67 insertions(+), 86 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index df3fe04cb9cd..5bec98381be6 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -51,22 +51,16 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 
 static int ucsi_acknowledge_command(struct ucsi *ucsi)
 {
-	u64 ctrl;
+	u64 cmd = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
 
-	ctrl = UCSI_ACK_CC_CI;
-	ctrl |= UCSI_ACK_COMMAND_COMPLETE;
-
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	return ucsi->ops->sync_cmd(ucsi, cmd);
 }
 
 static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
 {
-	u64 ctrl;
-
-	ctrl = UCSI_ACK_CC_CI;
-	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	u64 cmd = UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE;
 
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	return ucsi->ops->sync_cmd(ucsi, cmd);
 }
 
 static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
@@ -137,7 +131,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	u32 cci;
 	int ret;
 
-	ret = ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
+	ret = ucsi->ops->sync_cmd(ucsi, cmd);
 	if (ret)
 		return ret;
 	cci = READ_ONCE(ucsi->cci);
@@ -1014,15 +1008,13 @@ static int ucsi_reset_connector(struct ucsi_connector *con, bool hard)
 
 static int ucsi_reset_ppm(struct ucsi *ucsi)
 {
-	u64 command = UCSI_PPM_RESET;
 	unsigned long tmo;
 	u32 cci;
 	int ret;
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
-				     sizeof(command));
+	ret = ucsi->ops->async_cmd(ucsi, UCSI_PPM_RESET);
 	if (ret < 0)
 		goto out;
 
@@ -1041,9 +1033,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		/* If the PPM is still doing something else, reset it again. */
 		if (cci & ~UCSI_CCI_RESET_COMPLETE) {
-			ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL,
-						     &command,
-						     sizeof(command));
+			ret = ucsi->ops->async_cmd(ucsi, UCSI_PPM_RESET);
 			if (ret < 0)
 				goto out;
 		}
@@ -1549,7 +1539,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	struct ucsi *ucsi;
 
 	if (!ops || !ops->poll_cci || !ops->read_data || !ops->write_data ||
-	    !ops->sync_write || !ops->async_write)
+	    !ops->sync_cmd || !ops->async_cmd)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -1612,7 +1602,6 @@ EXPORT_SYMBOL_GPL(ucsi_register);
  */
 void ucsi_unregister(struct ucsi *ucsi)
 {
-	u64 cmd = UCSI_SET_NOTIFICATION_ENABLE;
 	int i;
 
 	/* Make sure that we are not in the middle of driver initialization */
@@ -1620,7 +1609,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 	cancel_work_sync(&ucsi->resume_work);
 
 	/* Disable notifications */
-	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
+	ucsi->ops->async_cmd(ucsi, UCSI_SET_NOTIFICATION_ENABLE);
 
 	if (!ucsi->connector)
 		return;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 2ad68124511b..3cce83d1e70c 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -58,22 +58,20 @@ struct dentry;
  * @poll_cci: Update the cached CCI value from hardware. Required for reset.
  * @read_data: Read MESSAGE_IN data
  * @write_data: Write MESSAGE_OUT data
- * @sync_write: Blocking write operation
- * @async_write: Non-blocking write operation
+ * @sync_cmd: Blocking command execution
+ * @async_cmd: Non-blocking command execution
  * @update_altmodes: Squashes duplicate DP altmodes
  *
- * Read and write routines for UCSI interface. @sync_write must wait for the
- * Command Completion Event from the PPM before returning, and @async_write must
+ * Read and write routines for UCSI interface. @sync_cmd must wait for the
+ * Command Completion Event from the PPM before returning, and @async_cmd must
  * return immediately after sending the data to the PPM.
  */
 struct ucsi_operations {
 	int (*poll_cci)(struct ucsi *ucsi);
 	int (*read_data)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*write_data)(struct ucsi *ucsi, const void *val, size_t val_len);
-	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
-			  const void *val, size_t val_len);
-	int (*async_write)(struct ucsi *ucsi, unsigned int offset,
-			   const void *val, size_t val_len);
+	int (*sync_cmd)(struct ucsi *ucsi, u64 cmd);
+	int (*async_cmd)(struct ucsi *ucsi, u64 cmd);
 	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
 				struct ucsi_altmode *updated);
 };
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 79b47b433e35..e6f67aa102d2 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -77,21 +77,20 @@ static int ucsi_acpi_write_data(struct ucsi *ucsi, const void *val,
 	return 0;
 }
 
-static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
-				 const void *val, size_t val_len)
+static int ucsi_acpi_async_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	__le64 __cmd = cpu_to_le64(cmd);
 
-	memcpy(ua->base + offset, val, val_len);
+	memcpy(ua->base + UCSI_CONTROL, &__cmd, sizeof(__cmd));
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
 
-static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
+static int ucsi_acpi_sync_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	bool ack = UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI;
 	int ret;
 
 	if (ack)
@@ -99,7 +98,7 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 	else
 		set_bit(COMMAND_PENDING, &ua->flags);
 
-	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
+	ret = ucsi_acpi_async_cmd(ucsi, cmd);
 	if (ret)
 		goto out_clear_bit;
 
@@ -119,8 +118,8 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.poll_cci = ucsi_acpi_poll_cci,
 	.read_data = ucsi_acpi_read_data,
 	.write_data = ucsi_acpi_write_data,
-	.sync_write = ucsi_acpi_sync_write,
-	.async_write = ucsi_acpi_async_write
+	.sync_cmd = ucsi_acpi_sync_cmd,
+	.async_cmd = ucsi_acpi_async_cmd
 };
 
 /*
@@ -131,32 +130,28 @@ static const struct ucsi_operations ucsi_acpi_ops = {
  * subsequent commands will timeout.
  */
 static int
-ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
-		     const void *val, size_t val_len)
+ucsi_dell_sync_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	u64 cmd = *(u64 *)val, ack = 0;
+	u64 ack = 0;
 	int ret;
 
 	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
 	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
 		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
 
-	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
+	ret = ucsi_acpi_sync_cmd(ucsi, cmd);
 	if (ret != 0)
 		return ret;
 	if (ack == 0)
-		return ret;
+		return 0;
 
 	if (!ua->dell_quirk_probed) {
 		ua->dell_quirk_probed = true;
 
-		cmd = UCSI_GET_CAPABILITY;
-		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
-					   sizeof(cmd));
+		ret = ucsi_acpi_sync_cmd(ucsi, UCSI_GET_CAPABILITY);
 		if (ret == 0)
-			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
-						    &ack, sizeof(ack));
+			return ucsi_acpi_sync_cmd(ucsi, ack);
 		if (ret != -ETIMEDOUT)
 			return ret;
 
@@ -166,17 +161,17 @@ ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 	}
 
 	if (!ua->dell_quirk_active)
-		return ret;
+		return 0;
 
-	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
+	return ucsi_acpi_sync_cmd(ucsi, ack);
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
 	.poll_cci = ucsi_acpi_poll_cci,
 	.read_data = ucsi_acpi_read_data,
 	.write_data = ucsi_acpi_write_data,
-	.sync_write = ucsi_dell_sync_write,
-	.async_write = ucsi_acpi_async_write
+	.sync_cmd = ucsi_dell_sync_cmd,
+	.async_cmd = ucsi_acpi_async_cmd
 };
 
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index d6026f61a0ed..5c60816e608f 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -605,23 +605,22 @@ static int ucsi_ccg_write_data(struct ucsi *ucsi, const void *val,
 	return ccg_write(uc, reg, val, val_len);
 }
 
-static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
+static int ucsi_ccg_async_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
-	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CONTROL);
+	__le64 __cmd = cpu_to_le64(cmd);
 
 	/*
-	 * UCSI may read CCI instantly after async_write,
+	 * UCSI may read CCI instantly after async_cmd,
 	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
 	 */
 	WRITE_ONCE(ucsi->cci, 0);
 
-	return ccg_write(uc, reg, val, val_len);
+	return ccg_write(uc, reg, (u8 *)&__cmd, sizeof(__cmd));
 }
 
-static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
-			       const void *val, size_t val_len)
+static int ucsi_ccg_sync_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	struct ucsi_connector *con;
@@ -632,19 +631,17 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 	pm_runtime_get_sync(uc->dev);
 	set_bit(DEV_CMD_PENDING, &uc->flags);
 
-	if (offset == UCSI_CONTROL && val_len == sizeof(uc->last_cmd_sent)) {
-		uc->last_cmd_sent = *(u64 *)val;
+	uc->last_cmd_sent = cmd;
 
-		if (UCSI_COMMAND(uc->last_cmd_sent) == UCSI_SET_NEW_CAM &&
-		    uc->has_multiple_dp) {
-			con_index = (uc->last_cmd_sent >> 16) &
-				    UCSI_CMD_CONNECTOR_MASK;
-			con = &uc->ucsi->connector[con_index - 1];
-			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
-		}
+	if (UCSI_COMMAND(uc->last_cmd_sent) == UCSI_SET_NEW_CAM &&
+	    uc->has_multiple_dp) {
+		con_index = (uc->last_cmd_sent >> 16) &
+			    UCSI_CMD_CONNECTOR_MASK;
+		con = &uc->ucsi->connector[con_index - 1];
+		ucsi_ccg_update_set_new_cam_cmd(uc, con, &cmd);
 	}
 
-	ret = ucsi_ccg_async_write(ucsi, offset, val, val_len);
+	ret = ucsi_ccg_async_cmd(ucsi, cmd);
 	if (ret)
 		goto err_clear_bit;
 
@@ -663,8 +660,8 @@ static const struct ucsi_operations ucsi_ccg_ops = {
 	.poll_cci = ucsi_ccg_poll_cci,
 	.read_data = ucsi_ccg_read_data,
 	.write_data = ucsi_ccg_write_data,
-	.sync_write = ucsi_ccg_sync_write,
-	.async_write = ucsi_ccg_async_write,
+	.sync_cmd = ucsi_ccg_sync_cmd,
+	.async_cmd = ucsi_ccg_async_cmd,
 	.update_altmodes = ucsi_ccg_update_altmodes
 };
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 9dab1b428ad9..1535877a9a41 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -186,23 +186,24 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 	return 0;
 }
 
-static int pmic_glink_ucsi_async_write(struct ucsi *__ucsi, unsigned int offset,
-				       const void *val, size_t val_len)
+static int pmic_glink_ucsi_async_cmd(struct ucsi *__ucsi, u64 cmd)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	__le64 __cmd = cpu_to_le64(cmd);
 	int ret;
 
 	mutex_lock(&ucsi->lock);
-	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	ret = pmic_glink_ucsi_locked_write(ucsi, UCSI_CONTROL,
+					   &__cmd, sizeof(__cmd));
 	mutex_unlock(&ucsi->lock);
 
 	return ret;
 }
 
-static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
-				      const void *val, size_t val_len)
+static int pmic_glink_ucsi_sync_cmd(struct ucsi *__ucsi, u64 cmd)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	__le64 __cmd = cpu_to_le64(cmd);
 	unsigned long left;
 	int ret;
 
@@ -212,7 +213,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 	ucsi->sync_val = 0;
 	reinit_completion(&ucsi->sync_ack);
 	ucsi->sync_pending = true;
-	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	ret = pmic_glink_ucsi_locked_write(ucsi, UCSI_CONTROL,
+					   &__cmd, sizeof(__cmd));
 	mutex_unlock(&ucsi->lock);
 
 	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
@@ -232,8 +234,8 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.poll_cci = pmic_glink_ucsi_poll_cci,
 	.read_data = pmic_glink_ucsi_read_data,
 	.write_data = pmic_glink_ucsi_write_data,
-	.sync_write = pmic_glink_ucsi_sync_write,
-	.async_write = pmic_glink_ucsi_async_write
+	.sync_cmd = pmic_glink_ucsi_sync_cmd,
+	.async_cmd = pmic_glink_ucsi_async_cmd
 };
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index d68aca118e41..0847e00163e8 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -421,23 +421,23 @@ static int ucsi_stm32g0_write_data(struct ucsi *ucsi,
 	return ucsi_stm32g0_write_to_hw(g0, UCSI_MESSAGE_OUT, val, len);
 }
 
-static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset,
-				    const void *val, size_t len)
+static int ucsi_stm32g0_async_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	__le64 __cmd = cpu_to_le64(cmd);
 
-	return ucsi_stm32g0_write_to_hw(g0, offset, val, len);
+	return ucsi_stm32g0_write_to_hw(g0, UCSI_CONTROL,
+					&__cmd, sizeof(__cmd));
 }
 
-static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const void *val,
-				   size_t len)
+static int ucsi_stm32g0_sync_cmd(struct ucsi *ucsi, u64 cmd)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 	int ret;
 
 	set_bit(COMMAND_PENDING, &g0->flags);
 
-	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
+	ret = ucsi_stm32g0_async_cmd(ucsi, cmd);
 	if (ret)
 		goto out_clear_bit;
 
@@ -480,8 +480,8 @@ static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.poll_cci = ucsi_stm32g0_poll_cci,
 	.read_data = ucsi_stm32g0_read_data,
 	.write_data = ucsi_stm32g0_write_data,
-	.sync_write = ucsi_stm32g0_sync_write,
-	.async_write = ucsi_stm32g0_async_write,
+	.sync_cmd = ucsi_stm32g0_sync_cmd,
+	.async_cmd = ucsi_stm32g0_async_cmd,
 };
 
 static int ucsi_stm32g0_register(struct ucsi *ucsi)
-- 
2.40.1


