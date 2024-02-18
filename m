Return-Path: <linux-kernel+bounces-70606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E308599C3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2942AB20D53
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0174E1F;
	Sun, 18 Feb 2024 22:21:13 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F3EAD7;
	Sun, 18 Feb 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294872; cv=none; b=EtfzXCeL4Nr/eU3talRc3Rea1KqB63mvzNXgeH14jIN03TfT9Wq22WxUp0W73gC18F6Bxojj7xniYpctrN9X8gmNX1nWFQznlx0Olr6y6qTgIxxfVA+2Qpg1yXBmcHkvW3oD9UerxayIufKW1w9xuGOru4S5WgRTIZ47pFkjPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294872; c=relaxed/simple;
	bh=Wo3mJx+7+d555EOF/dD4YGtyScjPacLMcmEkGZC9OFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiZie+MtSwm47Gvh5SMcCqrzKst0a0fM7T9G1KBpCn5wg7t02iNcpcG6UwBTImpVORSTjD7VRd3UGCDSf5IBOyVhgZ24fTeqbSk/8qxNGwTWeQ4bY9ebMBh5LR5jOuHn1hd7+uASF3W+y/10i6P8DvQI5IhCNy0QhOozXinsOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 4BB4E140929; Sun, 18 Feb 2024 23:21:07 +0100 (CET)
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
Subject: [RFC PATCH 4/6] usb: typec: ucsi: Cache current CCI value in struct ucsi
Date: Sun, 18 Feb 2024 23:20:37 +0100
Message-Id: <20240218222039.822040-5-lk@c--e.de>
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

All notification handlers already read the CCI value.
Reading it again from hardware in ucsi_execute_command()
opens races and it is not clear that this really works.
The zenbook quirk in ucsi_acpi.c is one case where a re-read
causes problems.

In the ACPI case it is not even necessary to sync the
mailbox memory. According to the intel whitepaper the
ACPI handler does this before it notifies the OS.
Thus simply read the CCI value in the notification handler
without any ACPI method calls.

During reset of the PPM, it may be necessary to poll UCSI_CCI
from hardware as the reset completion may not send a notification.
Provide a new ->poll_cci API function that actively updates the
CCI value from hardware for this case.

While there take into account that the raw CCI value read
from hardware is little endian and convert it to host byte
order explicitly.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c         | 11 +++---
 drivers/usb/typec/ucsi/ucsi.h         |  5 +++
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 53 ++++++++-------------------
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 38 +++++++------------
 drivers/usb/typec/ucsi/ucsi_glink.c   | 48 +++++++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 22 ++++++++++-
 6 files changed, 101 insertions(+), 76 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index eb630447ba80..a4ae3d5966a0 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -140,10 +140,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	ret = ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
-
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
-	if (ret)
-		return ret;
+	cci = READ_ONCE(ucsi->cci);
 
 	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
 		return ucsi_exec_command(ucsi, UCSI_CANCEL);
@@ -1037,9 +1034,10 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 			goto out;
 		}
 
-		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+		ret = ucsi->ops->poll_cci(ucsi);
 		if (ret)
 			goto out;
+		cci = READ_ONCE(ucsi->cci);
 
 		/* If the PPM is still doing something else, reset it again. */
 		if (cci & ~UCSI_CCI_RESET_COMPLETE) {
@@ -1550,7 +1548,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 {
 	struct ucsi *ucsi;
 
-	if (!ops || !ops->read || !ops->sync_write || !ops->async_write)
+	if (!ops || !ops->poll_cci || !ops->read || !ops->sync_write ||
+	    !ops->async_write)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 100e16b49814..55e5c5a09b32 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -55,6 +55,7 @@ struct dentry;
 
 /**
  * struct ucsi_operations - UCSI I/O operations
+ * @poll_cci: Update the cached CCI value from hardware. Required for reset.
  * @read: Read operation
  * @sync_write: Blocking write operation
  * @async_write: Non-blocking write operation
@@ -65,6 +66,7 @@ struct dentry;
  * return immediately after sending the data to the PPM.
  */
 struct ucsi_operations {
+	int (*poll_cci)(struct ucsi *ucsi);
 	int (*read)(struct ucsi *ucsi, unsigned int offset,
 		    void *val, size_t val_len);
 	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
@@ -371,6 +373,9 @@ struct ucsi {
 	/* The latest "Notification Enable" bits (SET_NOTIFICATION_ENABLE) */
 	u64 ntfy;
 
+	/* The current value of the CCI field. Synced by notifications. */
+	u32 cci;
+
 	/* PPM communication flags */
 	unsigned long flags;
 #define EVENT_PENDING	0
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 710ddfc03ed0..3aedfe78fb65 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -24,7 +24,6 @@ struct ucsi_acpi {
 	struct completion complete;
 	unsigned long flags;
 	guid_t guid;
-	u64 cmd;
 	bool dell_quirk_probed;
 	bool dell_quirk_active;
 };
@@ -45,8 +44,7 @@ static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 	return 0;
 }
 
-static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
-			  void *val, size_t val_len)
+static int ucsi_acpi_poll_cci(struct ucsi *ucsi)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
@@ -55,6 +53,16 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(ucsi->cci, le32_to_cpu(*(__le32 *)(ua->base + UCSI_CCI)));
+
+	return 0;
+}
+
+static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
+			  void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+
 	memcpy(val, ua->base + offset, val_len);
 
 	return 0;
@@ -66,7 +74,6 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
 	memcpy(ua->base + offset, val, val_len);
-	ua->cmd = *(u64 *)val;
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
@@ -100,34 +107,12 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 }
 
 static const struct ucsi_operations ucsi_acpi_ops = {
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read = ucsi_acpi_read,
 	.sync_write = ucsi_acpi_sync_write,
 	.async_write = ucsi_acpi_async_write
 };
 
-static int
-ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (offset == UCSI_VERSION || UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
-
-	memcpy(val, ua->base + offset, val_len);
-
-	return 0;
-}
-
-static const struct ucsi_operations ucsi_zenbook_ops = {
-	.read = ucsi_zenbook_read,
-	.sync_write = ucsi_acpi_sync_write,
-	.async_write = ucsi_acpi_async_write
-};
-
 /*
  * Some Dell laptops expect that an ACK command with the
  * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
@@ -177,19 +162,13 @@ ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 }
 
 static const struct ucsi_operations ucsi_dell_ops = {
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read = ucsi_acpi_read,
 	.sync_write = ucsi_dell_sync_write,
 	.async_write = ucsi_acpi_async_write
 };
 
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
-		},
-		.driver_data = (void *)&ucsi_zenbook_ops,
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
@@ -203,11 +182,9 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ucsi_acpi *ua = data;
 	u32 cci;
-	int ret;
 
-	ret = ua->ucsi->ops->read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
-	if (ret)
-		return;
+	cci = le32_to_cpu(*(__le32 *)(ua->base + UCSI_CCI));
+	WRITE_ONCE(ua->ucsi->cci, cci);
 
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index d47f5e31c98a..55d0fe5324f4 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -194,7 +194,6 @@ struct ucsi_ccg_altmode {
 
 #define CCGX_MESSAGE_IN_MAX 16
 struct op_region {
-	__le32 cci;
 	u8 message_in[CCGX_MESSAGE_IN_MAX];
 };
 
@@ -338,7 +337,6 @@ static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
 	}
 
 	spin_lock(&uc->op_lock);
-	data->cci = cpu_to_le32(cci);
 	if (UCSI_CCI_LENGTH(cci))
 		memcpy(&data->message_in, buf, size);
 	spin_unlock(&uc->op_lock);
@@ -556,32 +554,24 @@ static void ucsi_ccg_nvidia_altmode(struct ucsi_ccg *uc,
 	}
 }
 
+static int ucsi_ccg_poll_cci(struct ucsi *ucsi)
+{
+	return 0;
+}
+
 static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 			 void *val, size_t val_len)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
-	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
-	int ret = 0;
-
-	if (offset == UCSI_CCI) {
-		spin_lock(&uc->op_lock);
-		memcpy(val, &(uc->op_data).cci, val_len);
-		spin_unlock(&uc->op_lock);
-	} else if (offset == UCSI_MESSAGE_IN) {
-		spin_lock(&uc->op_lock);
-		memcpy(val, &(uc->op_data).message_in, val_len);
-		spin_unlock(&uc->op_lock);
-	} else {
-		ret = ccg_read(uc, reg, val, val_len);
-	}
-
-	if (ret)
-		return ret;
 
 	if (offset != UCSI_MESSAGE_IN)
-		return ret;
+		return -EINVAL;
+
+	spin_lock(&uc->op_lock);
+	memcpy(val, &uc->op_data.message_in, val_len);
+	spin_unlock(&uc->op_lock);
 
 	switch (UCSI_COMMAND(uc->last_cmd_sent)) {
 	case UCSI_GET_CURRENT_CAM:
@@ -607,7 +597,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	}
 	uc->last_cmd_sent = 0;
 
-	return ret;
+	return 0;
 }
 
 static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
@@ -620,9 +610,7 @@ static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 	 * UCSI may read CCI instantly after async_write,
 	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
 	 */
-	spin_lock(&uc->op_lock);
-	uc->op_data.cci = 0;
-	spin_unlock(&uc->op_lock);
+	WRITE_ONCE(ucsi->cci, 0);
 
 	return ccg_write(uc, reg, val, val_len);
 }
@@ -667,6 +655,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 }
 
 static const struct ucsi_operations ucsi_ccg_ops = {
+	.poll_cci = ucsi_ccg_poll_cci,
 	.read = ucsi_ccg_read,
 	.sync_write = ucsi_ccg_sync_write,
 	.async_write = ucsi_ccg_async_write,
@@ -695,6 +684,7 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (ret)
 		goto err_clear_irq;
 	cci = le32_to_cpu(__cci);
+	WRITE_ONCE(uc->ucsi->cci, cci);
 
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 7a0b28536abd..d65ab81b4ed6 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -77,10 +77,8 @@ struct pmic_glink_ucsi {
 	u8 read_buf[UCSI_BUF_SIZE];
 };
 
-static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
-				void *val, size_t val_len)
+static int pmic_glink_sync_read_buf(struct pmic_glink_ucsi *ucsi)
 {
-	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
 	struct ucsi_read_buf_req_msg req = {};
 	unsigned long left;
 	int ret;
@@ -106,7 +104,6 @@ static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
 		goto out_unlock;
 	}
 
-	memcpy(val, &ucsi->read_buf[offset], val_len);
 	ret = 0;
 
 out_unlock:
@@ -115,6 +112,35 @@ static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
 	return ret;
 }
 
+static int pmic_glink_ucsi_poll_cci(struct ucsi *__ucsi)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+	int ret;
+
+	ret = pmic_glink_sync_read_buf(ucsi);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ucsi->lock);
+	WRITE_ONCE(__ucsi->cci,
+		   le32_to_cpu(*(__le32 *)&ucsi->read_buf[UCSI_CCI]));
+	mutex_unlock(&ucsi->lock);
+
+	return 0;
+}
+
+static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
+				void *val, size_t val_len)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+
+	mutex_lock(&ucsi->lock);
+	memcpy(val, &ucsi->read_buf[offset], val_len);
+	mutex_unlock(&ucsi->lock);
+
+	return 0;
+}
+
 static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
 					const void *val, size_t val_len)
 {
@@ -187,6 +213,7 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 }
 
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
+	.poll_cci = pmic_glink_ucsi_poll_cci,
 	.read = pmic_glink_ucsi_read,
 	.sync_write = pmic_glink_ucsi_sync_write,
 	.async_write = pmic_glink_ucsi_async_write
@@ -221,11 +248,15 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 	u32 cci;
 	int ret;
 
-	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = pmic_glink_sync_read_buf(ucsi);
 	if (ret) {
-		dev_err(ucsi->dev, "failed to read CCI on notification\n");
+		dev_err(ucsi->dev, "failed to sync read buf\n");
 		return;
 	}
+	mutex_lock(&ucsi->lock);
+	cci = le32_to_cpu(*(__le32 *)&ucsi->read_buf[UCSI_CCI]);
+	mutex_unlock(&ucsi->lock);
+	WRITE_ONCE(ucsi->ucsi->cci, cci);
 
 	con_num = UCSI_CCI_CONNECTOR(cci);
 	if (con_num) {
@@ -258,6 +289,11 @@ static void pmic_glink_ucsi_register(struct work_struct *work)
 	__le16 version;
 	int ret;
 
+	ret = pmic_glink_sync_read_buf(ucsi);
+	if (ret < 0) {
+		dev_err(ucsi->dev, "cannot sync read buf: %d\n", ret);
+		return;
+	}
 	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_VERSION, &version,
 				   sizeof(version));
 	if (ret < 0) {
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 112692c7a158..bab2363b73f4 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -358,6 +358,20 @@ static int ucsi_stm32g0_read_from_hw(struct ucsi_stm32g0 *g0,
 }
 
 /* UCSI ops */
+static int ucsi_stm32g0_poll_cci(struct ucsi *ucsi)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	__le32 cci;
+	int ret;
+
+	ret = ucsi_stm32g0_read_from_hw(g0, UCSI_CCI, &cci, sizeof(cci));
+	if (ret)
+		return ret;
+	WRITE_ONCE(ucsi->cci, le32_to_cpu(cci));
+
+	return 0;
+}
+
 static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset,
 			     void *val, size_t len)
 {
@@ -424,15 +438,18 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 {
 	struct ucsi_stm32g0 *g0 = data;
+	__le32 __cci;
 	u32 cci;
 	int ret;
 
 	if (g0->suspended)
 		g0->wakeup_event = true;
 
-	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi_stm32g0_read_from_hw(g0, UCSI_CCI, &__cci, sizeof(__cci));
 	if (ret)
 		return IRQ_NONE;
+	cci = le32_to_cpu(__cci);
+	WRITE_ONCE(g0->ucsi->cci, cci);
 
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
@@ -445,6 +462,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 }
 
 static const struct ucsi_operations ucsi_stm32g0_ops = {
+	.poll_cci = ucsi_stm32g0_poll_cci,
 	.read = ucsi_stm32g0_read,
 	.sync_write = ucsi_stm32g0_sync_write,
 	.async_write = ucsi_stm32g0_async_write,
@@ -626,7 +644,7 @@ static int ucsi_stm32g0_probe_bootloader(struct ucsi *ucsi)
 	 * Try to guess if the STM32G0 is running a UCSI firmware. First probe the UCSI FW at its
 	 * i2c address. Fallback to bootloader i2c address only if firmware-name is specified.
 	 */
-	ret = ucsi_stm32g0_read(ucsi, UCSI_VERSION, &ucsi_version, sizeof(ucsi_version));
+	ret = ucsi_stm32g0_read_from_hw(g0, UCSI_VERSION, &ucsi_version, sizeof(ucsi_version));
 	if (!ret || !g0->fw_name)
 		return ret;
 
-- 
2.40.1


