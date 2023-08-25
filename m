Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2167787E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbjHYCwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbjHYCwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:52:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3B2100
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a41035828so422268b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931901; x=1693536701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoorNgyABvybX2N9IoeEyWhrUT8xIewGPwdORVnknF0=;
        b=K8Lf4oK6ktUjrkQ68iwm6vPV8GIRczhwBm429iWOBzINCynZyca6b3meAALHmNhsiT
         3xLO4pWxeMBDLLiMC7ZL5vSuU6Vc8ZIO/0pLW/bgsZLRPutSUL22aw/VMbxJOH5bDy1V
         4hOnKpX5ZVIHfNMu7KTDTPkHuscv4C2QUNsIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931901; x=1693536701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoorNgyABvybX2N9IoeEyWhrUT8xIewGPwdORVnknF0=;
        b=WbWUtmPF4GDWpy0r6BBfwTIoE1G0s/SQxw3pgGdYRvFYiOo/J8vGPmCFeK2MoYWxrP
         z/NlHt/JEFiJ+WrsFTlISvl226kaIMnvt+eIy25UaD7xPoGhP3HkalMsJGIqNJ8WsQXr
         g3ukBD3nn5oXKGyt+UEH58ENCCjKd8L7pmXb4sflbE415rF7o4mmXhpaWUoLpY4W3SdQ
         zk9TIyN+0+QIBisTXcns3dwy9jcp6l7T+yukxVfOixNhx65OX7qzqte5QPApXG+jocdN
         q4/CaNrMSQc7R5nid5+47XSRRFd4LjdKL763ELilVC7ahfeWMtl4KNssY6fWZsr/eAhH
         qkXA==
X-Gm-Message-State: AOJu0YyU3Op9HluFQ0Acti5JEyTvgZQECQKmJPBeoLg6FsK2XC1k08GE
        K/BzeZFN1cJ7o5okD02aqtm1ww==
X-Google-Smtp-Source: AGHT+IHJEWkbTkPNvjUmAuW8N3dHFgd6FLUeujMwWF6UFo7ranfDCfQ0KEffXNcO3qtYPsIntNy+Zg==
X-Received: by 2002:a05:6a20:4910:b0:141:d54e:a90a with SMTP id ft16-20020a056a20491000b00141d54ea90amr13229510pzb.56.1692931901197;
        Thu, 24 Aug 2023 19:51:41 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:51:40 -0700 (PDT)
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
Subject: [PATCH v2 5/9] media: cros-ec-cec: Support multiple ports in MKBP cec_events
Date:   Fri, 25 Aug 2023 12:43:58 +1000
Message-ID: <20230825024735.1443836-6-rekanorman@chromium.org>
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

Use the top four bits of the cec_events MKBP event to store the port
number.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

Changes in v2:
- Make port_num unsigned in handle_cec_event

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 13 +++++++++++--
 include/linux/platform_data/cros_ec_commands.h   | 10 ++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index d674a432dfdd..18f78b7e034a 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -77,8 +77,17 @@ static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
 static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
 {
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	uint32_t events = cros_ec->event_data.data.cec_events;
-	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
+	uint32_t cec_events = cros_ec->event_data.data.cec_events;
+	uint32_t port_num = EC_MKBP_EVENT_CEC_GET_PORT(cec_events);
+	uint32_t events = EC_MKBP_EVENT_CEC_GET_EVENTS(cec_events);
+	struct cros_ec_cec_port *port;
+
+	if (port_num >= cros_ec_cec->num_ports) {
+		dev_err(cros_ec->dev,
+			"received CEC event for invalid port %d\n", port_num);
+		return;
+	}
+	port = cros_ec_cec->ports[port_num];
 
 	if (events & EC_MKBP_CEC_SEND_OK)
 		cec_transmit_attempt_done(port->adap, CEC_TX_STATUS_OK);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 9a0c6e28f370..b7e8573a8a49 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4440,6 +4440,16 @@ struct ec_response_i2c_passthru_protect {
 
 #define MAX_CEC_MSG_LEN 16
 
+/*
+ * Helper macros for packing/unpacking cec_events.
+ * bits[27:0] : bitmask of events from enum mkbp_cec_event
+ * bits[31:28]: port number
+ */
+#define EC_MKBP_EVENT_CEC_PACK(events, port) \
+		(((events) & GENMASK(27, 0)) | (((port) & 0xf) << 28))
+#define EC_MKBP_EVENT_CEC_GET_EVENTS(event) ((event) & GENMASK(27, 0))
+#define EC_MKBP_EVENT_CEC_GET_PORT(event) (((event) >> 28) & 0xf)
+
 /* CEC message from the AP to be written on the CEC bus */
 #define EC_CMD_CEC_WRITE_MSG 0x00B8
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

