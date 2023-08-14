Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A377B079
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjHNEfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjHNEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:35:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24112E6F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564b326185bso2149341a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987713; x=1692592513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oecyog8PuozL6O2E1VryVxhyj5E7Pm9UrjY6AD7CHgI=;
        b=eisGKLb4oJTRWBSHq0Z6OFyc4t/yn/pXv2SLtHXG+ge/BAhRx4HvMKzUr12LXywHWS
         wOs5BAUYZC0WzL0pCo5egtIcZ5b2VRfPNKQXeXOcTsE/g81CfhHVT8A7tXsdHVcdR8x1
         phk31LivqNP9ghBhUlEuJ3WtDHHxV+6NIWlyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987713; x=1692592513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oecyog8PuozL6O2E1VryVxhyj5E7Pm9UrjY6AD7CHgI=;
        b=RSAk3x413cIxNmOgs7XtwpkMKnLFEqgEDnl9RtRZdBgE1mGEgHbzjUDtoIaCQTs81f
         Qcf1JT2whbWAr0MM8N+tetbKmRUp9Fj7kzGIBt22L+i6soSm5u70WVgHxFhx6QUO9R96
         rUf/kfHxGEbCfokc/+zMkGmkPwQYTVQ374Ghjysj3Shsn8dBYWEbZZCE7hJvo4v3i6DJ
         0PzgFSG3RflssRmNoShfVZUrOo9KIYk+u1P6do28m/MyXH7KCFGqGyTMyDMYdO2IpP/g
         Pe2TsHSFVC3czzCTXPTpDNLk1FRFJJicIOH6JtIAMMNw1IWsqZJ5k0SVpRwOrtCRT4V1
         MEPg==
X-Gm-Message-State: AOJu0Yy/u9iFBHLXPUPOwM8RjJKTh+kPy5ijKyBKg8BOyjxgBD9ynVbP
        jcPdm0ioSTC1Hqyd6NOaFUnVBw==
X-Google-Smtp-Source: AGHT+IH04tptKbSPM6Xijf8b5d4hdIF4dEKtwXk+AN4Sol7CguHseh0vNUoWUPheCk0oaHQ3xgg0hQ==
X-Received: by 2002:a17:902:ab0d:b0:1b8:5b70:2988 with SMTP id ik13-20020a170902ab0d00b001b85b702988mr6283028plb.30.1691987713546;
        Sun, 13 Aug 2023 21:35:13 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:35:13 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 2/9] media: cros-ec-cec: Manage an array of ports
Date:   Mon, 14 Aug 2023 14:29:11 +1000
Message-ID: <20230814043140.1108917-3-rekanorman@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814043140.1108917-1-rekanorman@chromium.org>
References: <20230814043140.1108917-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support multiple CEC ports, change cros_ec_cec to contain an array of
ports, each with their own CEC adapter, etc.

For now, only create a single port and use that port everywhere, so
there is no functional change. Support for multiple ports will be added
in the following patches.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 147 +++++++++++++-----
 .../linux/platform_data/cros_ec_commands.h    |   2 +
 2 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 8dd95fb38546..d76a25ae0cf1 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -21,21 +21,40 @@
 
 #define DRV_NAME	"cros-ec-cec"
 
+/* Only one port is supported for now */
+#define CEC_NUM_PORTS	1
+#define CEC_PORT	0
+
 /**
- * struct cros_ec_cec - Driver data for EC CEC
+ * struct cros_ec_cec_port - Driver data for a single EC CEC port
  *
- * @cros_ec: Pointer to EC device
- * @notifier: Notifier info for responding to EC events
+ * @port_num: port number
  * @adap: CEC adapter
  * @notify: CEC notifier pointer
  * @rx_msg: storage for a received message
+ * @cros_ec_cec: pointer to the parent struct
  */
-struct cros_ec_cec {
-	struct cros_ec_device *cros_ec;
-	struct notifier_block notifier;
+struct cros_ec_cec_port {
+	int port_num;
 	struct cec_adapter *adap;
 	struct cec_notifier *notify;
 	struct cec_msg rx_msg;
+	struct cros_ec_cec *cros_ec_cec;
+};
+
+/**
+ * struct cros_ec_cec - Driver data for EC CEC
+ *
+ * @cros_ec: Pointer to EC device
+ * @notifier: Notifier info for responding to EC events
+ * @num_ports: Number of CEC ports
+ * @ports: Array of ports
+ */
+struct cros_ec_cec {
+	struct cros_ec_device *cros_ec;
+	struct notifier_block notifier;
+	int num_ports;
+	struct cros_ec_cec_port *ports[EC_CEC_MAX_PORTS];
 };
 
 static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
@@ -43,27 +62,28 @@ static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	uint8_t *cec_message = cros_ec->event_data.data.cec_message;
 	unsigned int len = cros_ec->event_size;
+	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
 
 	if (len > CEC_MAX_MSG_SIZE)
 		len = CEC_MAX_MSG_SIZE;
-	cros_ec_cec->rx_msg.len = len;
-	memcpy(cros_ec_cec->rx_msg.msg, cec_message, len);
+	port->rx_msg.len = len;
+	memcpy(port->rx_msg.msg, cec_message, len);
 
-	cec_received_msg(cros_ec_cec->adap, &cros_ec_cec->rx_msg);
+	cec_received_msg(port->adap, &port->rx_msg);
 }
 
 static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
 {
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	uint32_t events = cros_ec->event_data.data.cec_events;
+	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
 
 	if (events & EC_MKBP_CEC_SEND_OK)
-		cec_transmit_attempt_done(cros_ec_cec->adap,
-					  CEC_TX_STATUS_OK);
+		cec_transmit_attempt_done(port->adap, CEC_TX_STATUS_OK);
 
 	/* FW takes care of all retries, tell core to avoid more retries */
 	if (events & EC_MKBP_CEC_SEND_FAILED)
-		cec_transmit_attempt_done(cros_ec_cec->adap,
+		cec_transmit_attempt_done(port->adap,
 					  CEC_TX_STATUS_MAX_RETRIES |
 					  CEC_TX_STATUS_NACK);
 }
@@ -93,7 +113,8 @@ static int cros_ec_cec_event(struct notifier_block *nb,
 
 static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 {
-	struct cros_ec_cec *cros_ec_cec = adap->priv;
+	struct cros_ec_cec_port *port = adap->priv;
+	struct cros_ec_cec *cros_ec_cec = port->cros_ec_cec;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_LOGICAL_ADDRESS,
@@ -115,7 +136,8 @@ static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 static int cros_ec_cec_transmit(struct cec_adapter *adap, u8 attempts,
 				u32 signal_free_time, struct cec_msg *cec_msg)
 {
-	struct cros_ec_cec *cros_ec_cec = adap->priv;
+	struct cros_ec_cec_port *port = adap->priv;
+	struct cros_ec_cec *cros_ec_cec = port->cros_ec_cec;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_write params;
 	int ret;
@@ -135,7 +157,8 @@ static int cros_ec_cec_transmit(struct cec_adapter *adap, u8 attempts,
 
 static int cros_ec_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
-	struct cros_ec_cec *cros_ec_cec = adap->priv;
+	struct cros_ec_cec_port *port = adap->priv;
+	struct cros_ec_cec *cros_ec_cec = port->cros_ec_cec;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_ENABLE,
@@ -260,11 +283,55 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 
 #endif
 
+static int cros_ec_cec_init_port(struct device *dev,
+				 struct cros_ec_cec *cros_ec_cec,
+				 int port_num, struct device *hdmi_dev,
+				 const char *conn)
+{
+	struct cros_ec_cec_port *port;
+	int ret;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->cros_ec_cec = cros_ec_cec;
+	port->port_num = port_num;
+
+	port->adap = cec_allocate_adapter(&cros_ec_cec_ops, port, DRV_NAME,
+					  CEC_CAP_DEFAULTS |
+					  CEC_CAP_CONNECTOR_INFO, 1);
+	if (IS_ERR(port->adap))
+		return PTR_ERR(port->adap);
+
+	port->notify = cec_notifier_cec_adap_register(hdmi_dev, conn,
+						      port->adap);
+	if (!port->notify) {
+		ret = -ENOMEM;
+		goto out_probe_adapter;
+	}
+
+	ret = cec_register_adapter(port->adap, dev);
+	if (ret < 0)
+		goto out_probe_notify;
+
+	cros_ec_cec->ports[port_num] = port;
+
+	return 0;
+
+out_probe_notify:
+	cec_notifier_cec_adap_unregister(port->notify, port->adap);
+out_probe_adapter:
+	cec_delete_adapter(port->adap);
+	return ret;
+}
+
 static int cros_ec_cec_probe(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
 	struct cros_ec_cec *cros_ec_cec;
+	struct cros_ec_cec_port *port;
 	struct device *hdmi_dev;
 	const char *conn = NULL;
 	int ret;
@@ -283,18 +350,13 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
-						 DRV_NAME,
-						 CEC_CAP_DEFAULTS |
-						 CEC_CAP_CONNECTOR_INFO, 1);
-	if (IS_ERR(cros_ec_cec->adap))
-		return PTR_ERR(cros_ec_cec->adap);
+	cros_ec_cec->num_ports = CEC_NUM_PORTS;
 
-	cros_ec_cec->notify = cec_notifier_cec_adap_register(hdmi_dev, conn,
-							     cros_ec_cec->adap);
-	if (!cros_ec_cec->notify) {
-		ret = -ENOMEM;
-		goto out_probe_adapter;
+	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
+		ret = cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
+					    hdmi_dev, conn);
+		if (ret)
+			goto unregister_ports;
 	}
 
 	/* Get CEC events from the EC. */
@@ -303,20 +365,24 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 					       &cros_ec_cec->notifier);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register notifier\n");
-		goto out_probe_notify;
+		goto unregister_ports;
 	}
 
-	ret = cec_register_adapter(cros_ec_cec->adap, &pdev->dev);
-	if (ret < 0)
-		goto out_probe_notify;
-
 	return 0;
 
-out_probe_notify:
-	cec_notifier_cec_adap_unregister(cros_ec_cec->notify,
-					 cros_ec_cec->adap);
-out_probe_adapter:
-	cec_delete_adapter(cros_ec_cec->adap);
+unregister_ports:
+	/*
+	 * Unregister any adapters which have been registered. We don't add the
+	 * port to the array until the adapter has been registered successfully,
+	 * so any non-NULL ports must have been registered.
+	 */
+	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
+		port = cros_ec_cec->ports[i];
+		if (!port)
+			break;
+		cec_notifier_cec_adap_unregister(port->notify, port->adap);
+		cec_unregister_adapter(port->adap);
+	}
 	return ret;
 }
 
@@ -324,6 +390,7 @@ static void cros_ec_cec_remove(struct platform_device *pdev)
 {
 	struct cros_ec_cec *cros_ec_cec = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	struct cros_ec_cec_port *port;
 	int ret;
 
 	/*
@@ -337,9 +404,11 @@ static void cros_ec_cec_remove(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "failed to unregister notifier\n");
 
-	cec_notifier_cec_adap_unregister(cros_ec_cec->notify,
-					 cros_ec_cec->adap);
-	cec_unregister_adapter(cros_ec_cec->adap);
+	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
+		port = cros_ec_cec->ports[i];
+		cec_notifier_cec_adap_unregister(port->notify, port->adap);
+		cec_unregister_adapter(port->adap);
+	}
 }
 
 static struct platform_driver cros_ec_cec_driver = {
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ab721cf13a98..cb2ddd10a613 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4436,6 +4436,8 @@ struct ec_response_i2c_passthru_protect {
  * These commands are for sending and receiving message via HDMI CEC
  */
 
+#define EC_CEC_MAX_PORTS 16
+
 #define MAX_CEC_MSG_LEN 16
 
 /* CEC message from the AP to be written on the CEC bus */
-- 
2.41.0.640.ga95def55d0-goog

