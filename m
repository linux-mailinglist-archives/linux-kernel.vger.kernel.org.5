Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51537787E09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjHYCwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbjHYCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:51:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CB2212A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdc243d62bso4298045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931880; x=1693536680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d39TfJDQpMKkFpdB9oQY3MYsthNxEY5fmlt/kOu0zbY=;
        b=hfGZqD9To6qCBphRqf6VDsKXyPLekIyvGVJX89tfvNPW6y8Qr+9U7njbsx6ECh7bK8
         CRR/ICu2LV7K6XYJmQnrl8fnNDf1Es898tOGOScz+/hHenz32dg2iOUJWCyn7nXI5WvR
         Je54fJhAOGUZ3c3I8LcOp3LrUsiLiQebenUms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931880; x=1693536680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d39TfJDQpMKkFpdB9oQY3MYsthNxEY5fmlt/kOu0zbY=;
        b=QIC2dy5gwvdCdXtRe3skVAMhIYQIOA3C7tCvf4kQxyBLtgFvircw0B3CCA7Vc85muA
         hmD+wyzp7gi3E9aOvcE96eLBUoVjDBBSBT1PTYI7Nc6gXC4ybFas2a7Qs1CT7N1nZe3D
         /tHwWgRVXpWdViW/fiqqIKld0WsgnUEGu/pa8IJoS69LSMA46JyPzesmfNFmRVw4Bye9
         tNRTtGK/2FF+UixeJ5FlG8u3mrki0Qrg+2br7dzsz4pXWsjRtA/AYdXymRwT9wcNr6Ge
         PHC3UoanfQXb6t5FL7Rc3jg8SXXN/7SwvVxL2Et1x7f0N9tTE3JqaJN2ZksUowlGy/Bf
         RAWg==
X-Gm-Message-State: AOJu0YwsEB5RMe6pgYUefnOV7jMJKxfTHszGtYp9Fdm2lRGoOa7pdnuL
        gfmh9QhXIKxQ6QiAxRxY7v89Bg==
X-Google-Smtp-Source: AGHT+IGKaEmBN2CUW201gX/b8UH6PvTksEYJ4zA03HaBivXE2dQTcfLHRxnu6Y6z9DlAtwzFSgWFEA==
X-Received: by 2002:a17:903:2792:b0:1bd:d141:f02d with SMTP id jw18-20020a170903279200b001bdd141f02dmr12240585plb.68.1692931879817;
        Thu, 24 Aug 2023 19:51:19 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:51:18 -0700 (PDT)
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
Subject: [PATCH v2 4/9] media: cros-ec-cec: Support multiple ports in write command
Date:   Fri, 25 Aug 2023 12:43:57 +1000
Message-ID: <20230825024735.1443836-5-rekanorman@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
References: <20230825024735.1443836-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

(no changes since v1)

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
2.42.0.rc2.253.gd59a3bf2b4-goog

