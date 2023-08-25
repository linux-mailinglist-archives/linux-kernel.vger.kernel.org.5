Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E5787E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbjHYCxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbjHYCwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:52:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506B2108
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:52:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3d94d40fso4502635ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931932; x=1693536732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYcbBdAIrsQLNnjQMklJ793CjZQNy73htJnU1NwxXiU=;
        b=C8kuC1LL98oeM8aIMmk+MXgZ9217C7GVnktd+aRxZm4Gyq7e5QYfJaMR85aC+HeyP/
         ZUPTdw5pPo9qjtoC4cQP7gHsmyrEOenLPTe/0UMe8GUOQp/OSzZawxCUDVdcszWHBPJi
         Id3KSe8uQd6eocAd6J/3wo4U0g4lcO0r+WLSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931932; x=1693536732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYcbBdAIrsQLNnjQMklJ793CjZQNy73htJnU1NwxXiU=;
        b=PDN9bcG3UOwgcK99n8LOm9pxov+WNfRcp4Q3eaKoU5ClEJsFp8qX4JnR5bGGimMxZu
         jMw0PcfoFZQMRWhK4QL8t14Uu9IOh2/CEl0hGYEsjif1KfT78JKNiW2/pLovEg1Dx3Li
         zoM/essSnkFHiWQXHNiXMVYbKohXHnfegjE43slCwLP/Pbc6SLQscijqp6JYmXMM/1JN
         3o5EGQpIQ/WXs97OcbU8PZ02XzV27W/TU4bHFRbVG+2pKklgt/tCLL/gEwybKyyYHrNW
         RMgZPwfKpQlR0WxbEnbakBg45pKLj05v4vr8fuiOKt/dgqCzyrbfBM9xg++j4O9fDdXX
         sB0g==
X-Gm-Message-State: AOJu0YzQVbacsaP/iltaR9U4AHLcRg1SKCy0P4DiCrYaAtfbeGfM/XuL
        4M4dAUg2vEJ3xut4ZeWJdiDVeQ==
X-Google-Smtp-Source: AGHT+IGJOPJ+CKWfPlqb86VYhTSiWBWSDpetoBBpmiTm1a4wgATGmNdDfSTC4SdW10SucR1xUBDCtw==
X-Received: by 2002:a17:902:c612:b0:1bb:7b6c:983a with SMTP id r18-20020a170902c61200b001bb7b6c983amr15263225plr.59.1692931931907;
        Thu, 24 Aug 2023 19:52:11 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:52:10 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 6/9] media: cros-ec-cec: Support receiving messages from multiple ports
Date:   Fri, 25 Aug 2023 12:43:59 +1000
Message-ID: <20230825024735.1443836-7-rekanorman@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
References: <20230825024735.1443836-1-rekanorman@chromium.org>
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

(no changes since v1)

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 59 +++++++++++++++++--
 .../linux/platform_data/cros_ec_commands.h    | 23 ++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 18f78b7e034a..6989e63c05be 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

