Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8CE77B07F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjHNEgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjHNEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D33E6F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68730bafa6bso3292913b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987765; x=1692592565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3Yp2zAtjbeDJ1QhLpOKL+IzkWDr56KaxN6gm4H+hUQ=;
        b=j4hCLshmCxUrUqzEgfl3+kiO58h9WICLyh88yqSwF9BVsk6NFCvfvCcAPJt4v/RMM3
         5UGM32X4uDDDVO59AUIpA2SnIEUpWBXd8owYRt9P1kVsBceOJ9hND7X1LgSm9vSBk4or
         czT5GnFzQ9mZWZDGjrRhk4eDeg8wiKHqAJecQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987765; x=1692592565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3Yp2zAtjbeDJ1QhLpOKL+IzkWDr56KaxN6gm4H+hUQ=;
        b=algn2KYkHaU26L+MVmOQ4hPUCYcMSMR3aIcAzal0EC445rmVANpUo4rgrrvxgSWbXv
         iZ4Q5fMg9rW1ZBfsSWeXCbjsr2p/FG24sHgDokOaM8h8uZQi+mzHx1ReWvw6o57bTbdK
         AAoRAWZlIJVoAIr/fTPXueRx+7/dvb/h892AEkMZKjYO9QWQCKNRfdqKBVG+0TwGdCQE
         01o0kElvbm6H8lsl0nA7z8FhzcPqqBRzRtuHFIU7Xug3PtkIJHLo+b31dVCkGi/hCh/I
         0I7CwYGUcvPSNJ7GA1KXobA+QfClu8zNvNsZNZ0u8ZhQzl5tnWXf0Gm6ByYHWMV0XaOO
         LIxQ==
X-Gm-Message-State: AOJu0YwcyueYV3yWFRmQAD1+MZZYM2fRjQLc6q4kEw/MNHy1uVGdOMJj
        frrJdE9uq73QcupV9BiN0FjmOQ==
X-Google-Smtp-Source: AGHT+IEyHxoQk4dD6G3k26knq3YOynLzMONf++TpVJFDGtUHE/YNEAdF0oDACqKCPHO+wyR64CA8Vw==
X-Received: by 2002:a17:90a:5a85:b0:268:808:8e82 with SMTP id n5-20020a17090a5a8500b0026808088e82mr10740711pji.1.1691987765440;
        Sun, 13 Aug 2023 21:36:05 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:36:05 -0700 (PDT)
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
Subject: [PATCH 5/9] media: cros-ec-cec: Support multiple ports in MKBP cec_events
Date:   Mon, 14 Aug 2023 14:29:14 +1000
Message-ID: <20230814043140.1108917-6-rekanorman@chromium.org>
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

Use the top four bits of the cec_events MKBP event to store the port
number.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 13 +++++++++++--
 include/linux/platform_data/cros_ec_commands.h   | 10 ++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index d674a432dfdd..eb4b778f83e9 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -77,8 +77,17 @@ static void handle_cec_message(struct cros_ec_cec *cros_ec_cec)
 static void handle_cec_event(struct cros_ec_cec *cros_ec_cec)
 {
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	uint32_t events = cros_ec->event_data.data.cec_events;
-	struct cros_ec_cec_port *port = cros_ec_cec->ports[CEC_PORT];
+	uint32_t cec_events = cros_ec->event_data.data.cec_events;
+	int port_num = EC_MKBP_EVENT_CEC_GET_PORT(cec_events);
+	uint32_t events = EC_MKBP_EVENT_CEC_GET_EVENTS(cec_events);
+	struct cros_ec_cec_port *port;
+
+	if (port_num < 0 || port_num >= cros_ec_cec->num_ports) {
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
2.41.0.640.ga95def55d0-goog

