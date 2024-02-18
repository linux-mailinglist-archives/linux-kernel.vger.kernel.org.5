Return-Path: <linux-kernel+bounces-70610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918598599CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F3A2817BA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC16762FB;
	Sun, 18 Feb 2024 22:21:15 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E8745F7;
	Sun, 18 Feb 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294874; cv=none; b=S+HiwLZmMW3YM+yuSGka40XjkAGUzYWdu7b7Xb1hYksNINaUKBO4NiMxjodZGeDpmE49HyNPPieRxnuqgQqhyAcJTRRVSjkggGht45ru/H1Jnrv3p96h+TC2x8IwotvGuPe+nfFU/9mklMcEMrC2JeH9L99fmvj2epwxtFX1Ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294874; c=relaxed/simple;
	bh=oBIAbCrIJVBjDvCpY+ciTU3Tk2iXKsY0b6d7anvoIAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFeMDpJ2M7E3SMiMZsd7QZoYgd7KSIXnPjY6xtDkYNLPYFjrXwBiI5TTc5mDlzRDPzf2mtOVv6/Sh2lBef2/sCxRmmuDeASVXjY2H/+d6l+o2wli4En42hbO5UQzFqQpi75KEM+R3OS1ZCaLp/wPYoEdD887/aUSloXTmioi8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 0456414092E; Sun, 18 Feb 2024 23:21:07 +0100 (CET)
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
Subject: [RFC PATCH 5/6] usb: typec: ucsi: Introdcue ->read_data and ->write_data
Date: Sun, 18 Feb 2024 23:20:38 +0100
Message-Id: <20240218222039.822040-6-lk@c--e.de>
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

With the previous refactoring ->read() is only used to read
from UCSI_MESSAGE_IN. So rename ->read() to ->read_data().

Before this change there is (at least for some backends)
no way to write to UCSI_MESSAGE_OUT without starting a command.
As a result it is not possible to send a command with additional
data on these backends. Currently, the UCSI core does not send
such commands but they are defined in the spec and presumably
will be required.

Introduce ->write_data() to write to UCSI_MESSAGE_OUT without
starting a command. This is symmetrical to ->read_data().

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c         |  6 ++---
 drivers/usb/typec/ucsi/ucsi.h         |  7 ++---
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 21 +++++++++++----
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 18 ++++++++-----
 drivers/usb/typec/ucsi/ucsi_glink.c   | 37 +++++++++++++++++----------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 30 +++++++++++++++++-----
 6 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a4ae3d5966a0..df3fe04cb9cd 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -46,7 +46,7 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 	if (ucsi->version <= UCSI_VERSION_1_2)
 		buf_size = clamp(buf_size, 0, 16);
 
-	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
+	return ucsi->ops->read_data(ucsi, buf, buf_size);
 }
 
 static int ucsi_acknowledge_command(struct ucsi *ucsi)
@@ -1548,8 +1548,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 {
 	struct ucsi *ucsi;
 
-	if (!ops || !ops->poll_cci || !ops->read || !ops->sync_write ||
-	    !ops->async_write)
+	if (!ops || !ops->poll_cci || !ops->read_data || !ops->write_data ||
+	    !ops->sync_write || !ops->async_write)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 55e5c5a09b32..2ad68124511b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -56,7 +56,8 @@ struct dentry;
 /**
  * struct ucsi_operations - UCSI I/O operations
  * @poll_cci: Update the cached CCI value from hardware. Required for reset.
- * @read: Read operation
+ * @read_data: Read MESSAGE_IN data
+ * @write_data: Write MESSAGE_OUT data
  * @sync_write: Blocking write operation
  * @async_write: Non-blocking write operation
  * @update_altmodes: Squashes duplicate DP altmodes
@@ -67,8 +68,8 @@ struct dentry;
  */
 struct ucsi_operations {
 	int (*poll_cci)(struct ucsi *ucsi);
-	int (*read)(struct ucsi *ucsi, unsigned int offset,
-		    void *val, size_t val_len);
+	int (*read_data)(struct ucsi *ucsi, void *val, size_t val_len);
+	int (*write_data)(struct ucsi *ucsi, const void *val, size_t val_len);
 	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
 			  const void *val, size_t val_len);
 	int (*async_write)(struct ucsi *ucsi, unsigned int offset,
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 3aedfe78fb65..79b47b433e35 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -58,12 +58,21 @@ static int ucsi_acpi_poll_cci(struct ucsi *ucsi)
 	return 0;
 }
 
-static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
-			  void *val, size_t val_len)
+static int ucsi_acpi_read_data(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
-	memcpy(val, ua->base + offset, val_len);
+	memcpy(val, ua->base + UCSI_MESSAGE_IN, val_len);
+
+	return 0;
+}
+
+static int ucsi_acpi_write_data(struct ucsi *ucsi, const void *val,
+				size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+
+	memcpy(ua->base + UCSI_MESSAGE_OUT, val, val_len);
 
 	return 0;
 }
@@ -108,7 +117,8 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.poll_cci = ucsi_acpi_poll_cci,
-	.read = ucsi_acpi_read,
+	.read_data = ucsi_acpi_read_data,
+	.write_data = ucsi_acpi_write_data,
 	.sync_write = ucsi_acpi_sync_write,
 	.async_write = ucsi_acpi_async_write
 };
@@ -163,7 +173,8 @@ ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_dell_ops = {
 	.poll_cci = ucsi_acpi_poll_cci,
-	.read = ucsi_acpi_read,
+	.read_data = ucsi_acpi_read_data,
+	.write_data = ucsi_acpi_write_data,
 	.sync_write = ucsi_dell_sync_write,
 	.async_write = ucsi_acpi_async_write
 };
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 55d0fe5324f4..d6026f61a0ed 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -559,16 +559,12 @@ static int ucsi_ccg_poll_cci(struct ucsi *ucsi)
 	return 0;
 }
 
-static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
-			 void *val, size_t val_len)
+static int ucsi_ccg_read_data(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
 
-	if (offset != UCSI_MESSAGE_IN)
-		return -EINVAL;
-
 	spin_lock(&uc->op_lock);
 	memcpy(val, &uc->op_data.message_in, val_len);
 	spin_unlock(&uc->op_lock);
@@ -600,6 +596,15 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	return 0;
 }
 
+static int ucsi_ccg_write_data(struct ucsi *ucsi, const void *val,
+			       size_t val_len)
+{
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_OUT);
+
+	return ccg_write(uc, reg, val, val_len);
+}
+
 static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
@@ -656,7 +661,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.poll_cci = ucsi_ccg_poll_cci,
-	.read = ucsi_ccg_read,
+	.read_data = ucsi_ccg_read_data,
+	.write_data = ucsi_ccg_write_data,
 	.sync_write = ucsi_ccg_sync_write,
 	.async_write = ucsi_ccg_async_write,
 	.update_altmodes = ucsi_ccg_update_altmodes
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index d65ab81b4ed6..9dab1b428ad9 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -75,6 +75,7 @@ struct pmic_glink_ucsi {
 	struct work_struct register_work;
 
 	u8 read_buf[UCSI_BUF_SIZE];
+	u8 write_buf[UCSI_BUF_SIZE];
 };
 
 static int pmic_glink_sync_read_buf(struct pmic_glink_ucsi *ucsi)
@@ -129,18 +130,28 @@ static int pmic_glink_ucsi_poll_cci(struct ucsi *__ucsi)
 	return 0;
 }
 
-static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
-				void *val, size_t val_len)
+static int pmic_glink_ucsi_read_data(struct ucsi *__ucsi,
+				     void *val, size_t val_len)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
 
 	mutex_lock(&ucsi->lock);
-	memcpy(val, &ucsi->read_buf[offset], val_len);
+	memcpy(val, &ucsi->read_buf[UCSI_MESSAGE_IN], val_len);
 	mutex_unlock(&ucsi->lock);
 
 	return 0;
 }
 
+static int pmic_glink_ucsi_write_data(struct ucsi *__ucsi,
+				      const void *val, size_t val_len)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
+
+	memcpy(&ucsi->write_buf[UCSI_MESSAGE_OUT], val, val_len);
+
+	return 0;
+}
+
 static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
 					const void *val, size_t val_len)
 {
@@ -148,10 +159,15 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 	unsigned long left;
 	int ret;
 
+	if (offset != UCSI_CONTROL || val_len != sizeof(u64))
+		return -EINVAL;
+	memcpy(ucsi->write_buf + UCSI_CONTROL, val, val_len);
+
 	req.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_USBC);
 	req.hdr.type = cpu_to_le32(MSG_TYPE_REQ_RESP);
 	req.hdr.opcode = cpu_to_le32(UC_UCSI_WRITE_BUF_REQ);
-	memcpy(&req.buf[offset], val, val_len);
+	memcpy(req.buf, ucsi->write_buf, UCSI_BUF_SIZE);
+	memset(ucsi->write_buf, 0, sizeof(ucsi->write_buf));
 
 	reinit_completion(&ucsi->write_ack);
 
@@ -214,7 +230,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.poll_cci = pmic_glink_ucsi_poll_cci,
-	.read = pmic_glink_ucsi_read,
+	.read_data = pmic_glink_ucsi_read_data,
+	.write_data = pmic_glink_ucsi_write_data,
 	.sync_write = pmic_glink_ucsi_sync_write,
 	.async_write = pmic_glink_ucsi_async_write
 };
@@ -286,7 +303,6 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
-	__le16 version;
 	int ret;
 
 	ret = pmic_glink_sync_read_buf(ucsi);
@@ -294,14 +310,9 @@ static void pmic_glink_ucsi_register(struct work_struct *work)
 		dev_err(ucsi->dev, "cannot sync read buf: %d\n", ret);
 		return;
 	}
-	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_VERSION, &version,
-				   sizeof(version));
-	if (ret < 0) {
-		dev_err(ucsi->dev, "cannot read version: %d\n", ret);
-		return;
-	}
 
-	ucsi_register(ucsi->ucsi, le16_to_cpu(version));
+	ucsi_register(ucsi->ucsi,
+		      le16_to_cpu(*(__le16 *)(ucsi->read_buf + UCSI_VERSION)));
 }
 
 static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index bab2363b73f4..d68aca118e41 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -372,18 +372,17 @@ static int ucsi_stm32g0_poll_cci(struct ucsi *ucsi)
 	return 0;
 }
 
-static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset,
-			     void *val, size_t len)
+static int ucsi_stm32g0_read_data(struct ucsi *ucsi, void *val, size_t len)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 
-	return ucsi_stm32g0_read_from_hw(g0, offset, val, len);
+	return ucsi_stm32g0_read_from_hw(g0, UCSI_MESSAGE_IN, val, len);
 }
 
-static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
-				    size_t len)
+static int ucsi_stm32g0_write_to_hw(struct ucsi_stm32g0 *g0,
+				    unsigned int offset,
+				    const void *val, size_t len)
 {
-	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 	struct i2c_client *client = g0->client;
 	struct i2c_msg msg[] = {
 		{
@@ -414,6 +413,22 @@ static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, cons
 	return 0;
 }
 
+static int ucsi_stm32g0_write_data(struct ucsi *ucsi,
+				   const void *val, size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+
+	return ucsi_stm32g0_write_to_hw(g0, UCSI_MESSAGE_OUT, val, len);
+}
+
+static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset,
+				    const void *val, size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+
+	return ucsi_stm32g0_write_to_hw(g0, offset, val, len);
+}
+
 static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const void *val,
 				   size_t len)
 {
@@ -463,7 +478,8 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.poll_cci = ucsi_stm32g0_poll_cci,
-	.read = ucsi_stm32g0_read,
+	.read_data = ucsi_stm32g0_read_data,
+	.write_data = ucsi_stm32g0_write_data,
 	.sync_write = ucsi_stm32g0_sync_write,
 	.async_write = ucsi_stm32g0_async_write,
 };
-- 
2.40.1


