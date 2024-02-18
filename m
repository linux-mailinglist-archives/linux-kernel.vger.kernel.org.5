Return-Path: <linux-kernel+bounces-70609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59B8599CA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4111F212B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F2762C1;
	Sun, 18 Feb 2024 22:21:15 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539B745F5;
	Sun, 18 Feb 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294874; cv=none; b=NCqWZPkEcPcXAp6Yefim8zg5fGEoks+/ms0f7lPXM8c1PSgJW29/UMGgaD/phXf20MlfyKS82fZdFTOEOdJ2c99uPe5+HFcQB6Gg1MgioqQTdbv43ZpELcCskDsq/XVnLUspmCfJFYUQKwAQH6SB+pqYlWTpieuZtWBQnb28Y1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294874; c=relaxed/simple;
	bh=90d1Gk641CL4PH6COhYb2mytDzl7/+xBe25WQoQ3r3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTiHBgPNnkX4pLCZAaRlVyX5fsvJ5Vf7JUMXTG0qSyw9zm1nQD3l3sWbDxI5OKYbxKW7CutUZ6nownSo2g8mYfG1bdu1h5Pjlx/C+BabbGCzH2CSgXqjbYmgaKsgNKzhOwtu3VHwxzfk+t/K0k4GAWHMHbe2B+NPvIfkQKiplhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 92A2E140406; Sun, 18 Feb 2024 23:21:06 +0100 (CET)
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
Subject: [RFC PATCH 3/6] usb: typec: ucsi: Make Version a parameter to ucsi_register
Date: Sun, 18 Feb 2024 23:20:36 +0100
Message-Id: <20240218222039.822040-4-lk@c--e.de>
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

Reading UCSI_VERSION is a special case as there is no
notification that syncs the data into host memory.

Read UCSI_VERSION only once during initialization and provide
it as a parameter to ucsi_register().

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c         | 13 ++++---------
 drivers/usb/typec/ucsi/ucsi.h         |  2 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c    |  8 +++++++-
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 12 ++++++++++--
 drivers/usb/typec/ucsi/ucsi_glink.c   | 11 ++++++++++-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 26 ++++++++++++++++++++++----
 6 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index ae105383e69e..eb630447ba80 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1581,18 +1581,13 @@ EXPORT_SYMBOL_GPL(ucsi_destroy);
 /**
  * ucsi_register - Register UCSI interface
  * @ucsi: UCSI instance
+ * @version: The revision of the UCSI spec
  */
-int ucsi_register(struct ucsi *ucsi)
+int ucsi_register(struct ucsi *ucsi, u16 version)
 {
-	int ret;
-
-	ret = ucsi->ops->read(ucsi, UCSI_VERSION, &ucsi->version,
-			      sizeof(ucsi->version));
-	if (ret)
-		return ret;
-
-	if (!ucsi->version)
+	if (!version)
 		return -ENODEV;
+	ucsi->version = version;
 
 	/*
 	 * Version format is JJ.M.N (JJ = Major version, M = Minor version,
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 7e35ffbe0a6f..100e16b49814 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -77,7 +77,7 @@ struct ucsi_operations {
 
 struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);
 void ucsi_destroy(struct ucsi *ucsi);
-int ucsi_register(struct ucsi *ucsi);
+int ucsi_register(struct ucsi *ucsi, u16 version);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 928eacbeb21a..710ddfc03ed0 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -226,6 +226,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	const struct dmi_system_id *id;
 	struct ucsi_acpi *ua;
 	struct resource *res;
+	u16 version;
 	acpi_status status;
 	int ret;
 
@@ -272,7 +273,12 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = ucsi_register(ua->ucsi);
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+	version = le16_to_cpu(*(__le16 *)(ua->base + UCSI_VERSION));
+
+	ret = ucsi_register(ua->ucsi, version);
 	if (ret) {
 		acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
 					   ACPI_DEVICE_NOTIFY,
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 709295948c65..d47f5e31c98a 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1356,7 +1356,7 @@ static int ccg_restart(struct ucsi_ccg *uc)
 		return status;
 	}
 
-	status = ucsi_register(uc->ucsi);
+	status = ucsi_register(uc->ucsi, uc->ucsi->version);
 	if (status) {
 		dev_err(uc->dev, "failed to register the interface\n");
 		return status;
@@ -1422,6 +1422,7 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 	struct ucsi_ccg *uc;
 	const char *fw_name;
 	int status;
+	__le16 version;
 
 	uc = devm_kzalloc(dev, sizeof(*uc), GFP_KERNEL);
 	if (!uc)
@@ -1477,7 +1478,14 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 		goto out_ucsi_destroy;
 	}
 
-	status = ucsi_register(uc->ucsi);
+	status = ccg_read(uc, CCGX_RAB_UCSI_DATA_BLOCK(UCSI_VERSION),
+			  (u8 *)&version, sizeof(version));
+	if (status < 0) {
+		dev_err(uc->dev, "cannot read UCSI version - %d\n", status);
+		return status;
+	}
+
+	status = ucsi_register(uc->ucsi, le16_to_cpu(version));
 	if (status)
 		goto out_free_irq;
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 0a0d08467c56..7a0b28536abd 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -255,8 +255,17 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	__le16 version;
+	int ret;
+
+	ret = pmic_glink_ucsi_read(ucsi->ucsi, UCSI_VERSION, &version,
+				   sizeof(version));
+	if (ret < 0) {
+		dev_err(ucsi->dev, "cannot read version: %d\n", ret);
+		return;
+	}
 
-	ucsi_register(ucsi->ucsi);
+	ucsi_register(ucsi->ucsi, le16_to_cpu(version));
 }
 
 static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 93d7806681cf..112692c7a158 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -325,10 +325,10 @@ static int ucsi_stm32g0_fw_rcv(struct ucsi *ucsi, void *data, size_t len)
 	return ucsi_stm32g0_bl_rcv_woack(ucsi, data, len);
 }
 
-/* UCSI ops */
-static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t len)
+static int ucsi_stm32g0_read_from_hw(struct ucsi_stm32g0 *g0,
+				     unsigned int offset,
+				     void *val, size_t len)
 {
-	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 	struct i2c_client *client = g0->client;
 	u8 reg = offset;
 	struct i2c_msg msg[] = {
@@ -357,6 +357,15 @@ static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val,
 	return 0;
 }
 
+/* UCSI ops */
+static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset,
+			     void *val, size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+
+	return ucsi_stm32g0_read_from_hw(g0, offset, val, len);
+}
+
 static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
 				    size_t len)
 {
@@ -445,6 +454,7 @@ static int ucsi_stm32g0_register(struct ucsi *ucsi)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 	struct i2c_client *client = g0->client;
+	__le16 version;
 	int ret;
 
 	/* Request alert interrupt */
@@ -455,7 +465,15 @@ static int ucsi_stm32g0_register(struct ucsi *ucsi)
 		return ret;
 	}
 
-	ret = ucsi_register(ucsi);
+	ret = ucsi_stm32g0_read_from_hw(g0, UCSI_VERSION, &version,
+					sizeof(version));
+	if (ret) {
+		dev_err(g0->dev, "failed to read version number: %d\n", ret);
+		free_irq(client->irq, g0);
+		return ret;
+	}
+
+	ret = ucsi_register(ucsi, le16_to_cpu(version));
 	if (ret) {
 		dev_err_probe(g0->dev, ret, "ucsi_register failed\n");
 		free_irq(client->irq, g0);
-- 
2.40.1


