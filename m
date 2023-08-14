Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE377B083
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjHNEgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjHNEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496FE124
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso2595984b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987771; x=1692592571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJNUFmjlGvWKEodbK80fwu4glcCXjowGdTQ1cnbRLBo=;
        b=IOu4sqiYVxsQt0pCO1qUsP2cQyki77rsQ0eCAUHiUwir+ft8aTFxHJFtqFVZvGZNuP
         eUEdAEgNK+uRqzgKLnY81Rz+4o8re6ps8DFwu3zjexSkcsWPwov+hX0A3lTnd8KCcj+u
         lxyrPYFfcxu0d3Fahx83Bfm5x+ifJRCTlgMtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987771; x=1692592571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJNUFmjlGvWKEodbK80fwu4glcCXjowGdTQ1cnbRLBo=;
        b=HaJJASFj4HE6+svS04u8xTkCl7DLaYoiGhON02Yloi1uk2HTV2Syw2XDOw9dYfl01F
         B9TuLEdTxEWFGjAh5SpTOl+Cl+EGGpk73nyhoRMTVQewlb5bw0xOHSjkgPYcY+jo0Nwp
         pdJrWjyrI6eXn8Cd8j6UeT9TNYE2vZYYh1xHenr7i1Ttu3twmdlRayxXAJ5pPTj9QzHa
         XuBXJDALPfYHIUlDKJ7l2SftWZc0A7tcjUf5S9KGvqhB3tCGQ/5v9xAPef3ZThfWAR8a
         CImyim4omeLdGevbqILUWR25OE7NGdIT9ZmcxDyAT+Oxc1vNMKHW1w4P8oB6d0GIkeEk
         A5zA==
X-Gm-Message-State: AOJu0YzFqnR1NHFI/KM8wNySkF0mMTdCH+NoudBXCdJthp9iEnQQ7msC
        iH4t20eCcaT7cm9M4WRxSmggkA==
X-Google-Smtp-Source: AGHT+IHprE2+40gK4Jd/BXsl5lwINEbFxAAFMNfAD/FOMhDGHmpQ/zEEWR4E78QiPKyLXVmgPwNa9Q==
X-Received: by 2002:a05:6a21:798a:b0:13b:a016:465b with SMTP id bh10-20020a056a21798a00b0013ba016465bmr8334038pzc.19.1691987770805;
        Sun, 13 Aug 2023 21:36:10 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:36:10 -0700 (PDT)
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
Subject: [PATCH 6/9] media: cros-ec-cec: Support receiving messages from multiple ports
Date:   Mon, 14 Aug 2023 14:29:15 +1000
Message-ID: <20230814043140.1108917-7-rekanorman@chromium.org>
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

Currently, received messages are sent from the EC in the cec_message
MKBP event. Since the size of ec_response_get_next_data_v1 is 16 bytes,
which is also the maximum size of a CEC message, there is no space to
add a port parameter. Increasing the size of
ec_response_get_next_data_v1 is an option, but this would increase
EC-kernel traffic for all MKBP event types.

Instead, use an event to notify that data is ready, and add a new read
command to read the data.

For backwards compatibility with old EC firmware, continue to handle
cec_message events as well.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 59 +++++++++++++++++--
 .../linux/platform_data/cros_ec_commands.h    | 23 ++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index eb4b778f83e9..c68ed5d4bda0 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -59,19 +59,63 @@ struct cros_ec_cec {
 	struct cros_ec_cec_port *ports[EC_CEC_MAX_PORTS];
 };
 
+static void cros_ec_cec_received_message(struct cros_ec_cec_port *port,
+					 uint8_t *msg, uint8_t len)
+{
+	if (len > CEC_MAX_MSG_SIZE)
+		len = CEC_MAX_MSG_SIZE;
+
+	port->rx_msg.len = len;
+	memcpy(port->rx_msg.msg, msg, len);
+
+	cec_received_msg(port->adap, &port->rx_msg);
+}
+
 static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
 {
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	uint8_t *cec_message = cros_ec->event_data.data.cec_message;
 	unsigned int len = cros_ec->event_size;
-	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
+	struct cros_ec_cec_port *port;
+	/*
+	 * There are two ways of receiving CEC messages:
+	 * 1. Old EC firmware which only supports one port sends the data in a
+	 *    cec_message MKBP event.
+	 * 2. New EC firmware which supports multiple ports uses
+	 *    EC_MKBP_CEC_HAVE_DATA to notify that data is ready and
+	 *    EC_CMD_CEC_READ_MSG to read it.
+	 * Check that the EC only has one CEC port, and then we can assume the
+	 * message is from port 0.
+	 */
+	if (cros_ec_cec->num_ports != 1) {
+		dev_err(cros_ec->dev,
+			"received cec_message on device with %d ports\n",
+			cros_ec_cec->num_ports);
+		return;
+	}
+	port = cros_ec_cec->ports[0];
 
-	if (len > CEC_MAX_MSG_SIZE)
-		len = CEC_MAX_MSG_SIZE;
-	port->rx_msg.len = len;
-	memcpy(port->rx_msg.msg, cec_message, len);
+	cros_ec_cec_received_message(port, cec_message, len);
+}
 
-	cec_received_msg(port->adap, &port->rx_msg);
+static void cros_ec_cec_read_message(struct cros_ec_cec_port *port)
+{
+	struct cros_ec_device *cros_ec = port->cros_ec_cec->cros_ec;
+	struct ec_params_cec_read params = {
+		.port = port->port_num,
+	};
+	struct ec_response_cec_read response;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_READ_MSG, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0) {
+		dev_err(cros_ec->dev,
+			"error reading CEC message on EC: %d\n", ret);
+		return;
+	}
+
+	cros_ec_cec_received_message(port, response.msg, response.msg_len);
 }
 
 static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
@@ -97,6 +141,9 @@ static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
 		cec_transmit_attempt_done(port->adap,
 					  CEC_TX_STATUS_MAX_RETRIES |
 					  CEC_TX_STATUS_NACK);
+
+	if (events & EC_MKBP_CEC_HAVE_DATA)
+		cros_ec_cec_read_message(port);
 }
 
 static int cros_ec_cec_event(struct notifier_block *nb,
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index b7e8573a8a49..ad61c7ff0b28 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4473,6 +4473,27 @@ struct ec_params_cec_write_v1 {
 	uint8_t msg[MAX_CEC_MSG_LEN];
 } __ec_align1;
 
+/* CEC message read from a CEC bus reported back to the AP */
+#define EC_CMD_CEC_READ_MSG 0x00B9
+
+/**
+ * struct ec_params_cec_read - Read a message from the CEC bus
+ * @port: CEC port to read a message on
+ */
+struct ec_params_cec_read {
+	uint8_t port;
+} __ec_align1;
+
+/**
+ * struct ec_response_cec_read - Message read from the CEC bus
+ * @msg_len: length of msg in bytes
+ * @msg: message content read from the CEC bus
+ */
+struct ec_response_cec_read {
+	uint8_t msg_len;
+	uint8_t msg[MAX_CEC_MSG_LEN];
+} __ec_align1;
+
 /* Set various CEC parameters */
 #define EC_CMD_CEC_SET 0x00BA
 
@@ -4529,6 +4550,8 @@ enum mkbp_cec_event {
 	EC_MKBP_CEC_SEND_OK			= BIT(0),
 	/* Outgoing message was not acknowledged */
 	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
+	/* Incoming message can be read out by AP */
+	EC_MKBP_CEC_HAVE_DATA			= BIT(2),
 };
 
 /*****************************************************************************/
-- 
2.41.0.640.ga95def55d0-goog

