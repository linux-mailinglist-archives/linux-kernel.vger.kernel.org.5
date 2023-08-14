Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C577B07E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjHNEgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHNEgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA6FE6F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc3d94d40fso34616585ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987757; x=1692592557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY/s3NWQ7cJzGN8eFznQZ8SqTKIy2WegmbdnvBwyBH8=;
        b=SXacTqbHuT+AjmyNe6Va4MrxTMBJyGMXsvJvygFMoxKz0dWO616KLB3kCWyZUEmEvc
         mwq8cGWywviFmXuyN+F/lPz6lCQHsoSpi8bJgAdGW2K0u128UNciaC0aVWCfuKxnD6eE
         g19zdVHzJ1XKWhdqgvoFW1rvRAaofMBW92gtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987757; x=1692592557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY/s3NWQ7cJzGN8eFznQZ8SqTKIy2WegmbdnvBwyBH8=;
        b=fwTj7BXq0zXTWCNVjrX2WMA63JvusXvayeeKXfRn/fQ9mEJi6ijK9hLPYKzk3i14+k
         0qxt/ElPvYYEx3CKnQT6/8afyjTOarGB6ypWkgfx9SadNoSg0LtAaxhhPxa3W0AtsyE1
         jKoYNwCCxU2EGkoEvT3ivrMwdrizw5Q+LCbeHP5fMwF0rY3d+u4UmlulDgFOzk62icOj
         tr8XuIchoL9mMBQ48VJxxEI1hgMjoRNETNc/UBunRZBj1HX/W19rWRUVsfUeyhP1jOLk
         RyRyTsvuOrRXu20G3VmakwxkilAGpy5NmfM9m7DE3r2qoP8ILXSvQnSITy8FRoHxBA3x
         fpQA==
X-Gm-Message-State: AOJu0YwXTfsLMGwT5bdqJtzSgSsy8PMcPcsYVWHTT7wp+1Dq43bO0NxO
        lXkAkwJtqHYj5O2U6dE6Jzt6Fw==
X-Google-Smtp-Source: AGHT+IGrujxISxygnWJjuw3SivTfzonRA4bepBiLTx5xRLmooiSveQabsuX7REbMesjW6mUXOd8xew==
X-Received: by 2002:a17:903:228b:b0:1bd:ea15:e3a9 with SMTP id b11-20020a170903228b00b001bdea15e3a9mr989447plh.48.1691987757148;
        Sun, 13 Aug 2023 21:35:57 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:35:56 -0700 (PDT)
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
Subject: [PATCH 4/9] media: cros-ec-cec: Support multiple ports in write command
Date:   Mon, 14 Aug 2023 14:29:13 +1000
Message-ID: <20230814043140.1108917-5-rekanorman@chromium.org>
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

Add a v1 of the CEC write command which contains a port parameter. Check
which versions of the write command the EC supports and use the highest
supported version. If it only supports v0, check that there is only one
port. With v0, the EC will assume all write commands are for port 0.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 54 +++++++++++++++++--
 .../linux/platform_data/cros_ec_commands.h    | 12 +++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index e969031e1e0e..d674a432dfdd 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -47,12 +47,14 @@ struct cros_ec_cec_port {
  *
  * @cros_ec: Pointer to EC device
  * @notifier: Notifier info for responding to EC events
+ * @write_cmd_version: Highest supported version of EC_CMD_CEC_WRITE_MSG.
  * @num_ports: Number of CEC ports
  * @ports: Array of ports
  */
 struct cros_ec_cec {
 	struct cros_ec_device *cros_ec;
 	struct notifier_block notifier;
+	int write_cmd_version;
 	int num_ports;
 	struct cros_ec_cec_port *ports[EC_CEC_MAX_PORTS];
 };
@@ -141,12 +143,22 @@ static int cros_ec_cec_transmit(struct cec_adapter *adap, u8 attempts,
 	struct cros_ec_cec *cros_ec_cec = port->cros_ec_cec;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_write params;
+	struct ec_params_cec_write_v1 params_v1;
 	int ret;
 
-	memcpy(params.msg, cec_msg->msg, cec_msg->len);
+	if (cros_ec_cec->write_cmd_version == 0) {
+		memcpy(params.msg, cec_msg->msg, cec_msg->len);
+		ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_WRITE_MSG, &params,
+				  cec_msg->len, NULL, 0);
+	} else {
+		params_v1.port = port->port_num;
+		params_v1.msg_len = cec_msg->len;
+		memcpy(params_v1.msg, cec_msg->msg, cec_msg->len);
+		ret = cros_ec_cmd(cros_ec, cros_ec_cec->write_cmd_version,
+				  EC_CMD_CEC_WRITE_MSG, &params_v1,
+				  sizeof(params_v1), NULL, 0);
+	}
 
-	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_WRITE_MSG, &params,
-			  cec_msg->len, NULL, 0);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error writing CEC msg on EC: %d\n", ret);
@@ -285,6 +297,38 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 
 #endif
 
+static int cros_ec_cec_get_write_cmd_version(struct cros_ec_cec *cros_ec_cec)
+{
+	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
+	struct ec_params_get_cmd_versions_v1 params = {
+		.cmd = EC_CMD_CEC_WRITE_MSG,
+	};
+	struct ec_response_get_cmd_versions response;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_GET_CMD_VERSIONS, &params,
+			  sizeof(params), &response, sizeof(response));
+	if (ret < 0) {
+		dev_err(cros_ec->dev,
+			"error getting CEC write command version: %d\n", ret);
+		return ret;
+	}
+
+	if (response.version_mask & EC_VER_MASK(1)) {
+		cros_ec_cec->write_cmd_version = 1;
+	} else {
+		if (cros_ec_cec->num_ports != 1) {
+			dev_err(cros_ec->dev,
+				"v0 write command only supports 1 port, %d reported\n",
+				cros_ec_cec->num_ports);
+			return -EINVAL;
+		}
+		cros_ec_cec->write_cmd_version = 0;
+	}
+
+	return 0;
+}
+
 static int cros_ec_cec_init_port(struct device *dev,
 				 struct cros_ec_cec *cros_ec_cec,
 				 int port_num, struct device *hdmi_dev,
@@ -354,6 +398,10 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
 	cros_ec_cec->num_ports = CEC_NUM_PORTS;
 
+	ret = cros_ec_cec_get_write_cmd_version(cros_ec_cec);
+	if (ret)
+		return ret;
+
 	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
 		ret = cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
 					    hdmi_dev, conn);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index e8bb05db360f..9a0c6e28f370 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4451,6 +4451,18 @@ struct ec_params_cec_write {
 	uint8_t msg[MAX_CEC_MSG_LEN];
 } __ec_align1;
 
+/**
+ * struct ec_params_cec_write_v1 - Message to write to the CEC bus
+ * @port: CEC port to write the message on
+ * @msg_len: length of msg in bytes
+ * @msg: message content to write to the CEC bus
+ */
+struct ec_params_cec_write_v1 {
+	uint8_t port;
+	uint8_t msg_len;
+	uint8_t msg[MAX_CEC_MSG_LEN];
+} __ec_align1;
+
 /* Set various CEC parameters */
 #define EC_CMD_CEC_SET 0x00BA
 
-- 
2.41.0.640.ga95def55d0-goog

