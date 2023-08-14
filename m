Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E747077B087
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHNEgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjHNEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F2E6F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686b9920362so2495886b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987784; x=1692592584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn05RavKUDwCo7Nk//6BvwshJgQPYJchPE2n3kFnelU=;
        b=C+TalMts8a2m6aL+ebXUXjcz744b6n1+AI3kTmdTfz43y+y8CBXkzjV9Q+3HBCTd5C
         NlVKUAF+jMShWAX+WBEFtEqxIh4/zYRFR4vpCjYxme6YPbst5Og+DuBnka/Ts01mImYB
         v5gXUrj3PDgNrzf007Wyfv+uUtdHAF9vIds6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987784; x=1692592584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn05RavKUDwCo7Nk//6BvwshJgQPYJchPE2n3kFnelU=;
        b=amsPsmeTPyLLX3++rqDLPzTFzifVNoOWoxJQ8xaQl736lNR3mo0PT3JYuhBFzO2w5f
         LY4RjSP0WT8fSfTADW1RfL+i/KxCgPxwOBy8gh8XW9giIQ9VvwCJ2fG1xR9C4im2cuc6
         WVFlmZs3VAw+BNISVy2KbstrfmszoTUI3jqI80egcZkxiGgAwmjVe0eDm4jVF/LvqacV
         ejgLnqm6Q+eRCmsa3sAc5O/5+1nb5sjCjGsdEo8uD5WfDV0sGlSW02ODFQIf8ElTWAfL
         o9TzA3Bk9Nr/1ZlfbynHCLSLc0D/9A3+5843uhMBMINX6wiTiDU5TnaPekIWx4uk8BWd
         7YoA==
X-Gm-Message-State: AOJu0YxWmMjdstuIhQuiYe0l13pRvH/w2/tIUa4q278gisXP+jDNF/Gn
        KpV0VcyGiG1pi7AgRJl/R8fpGA==
X-Google-Smtp-Source: AGHT+IGDOPOOphv5d99IwFBBIHrixspMihenoQdQr3YzcyDYtSWNtXJ4VqvDNzBT0FjnY/j8yV7xrA==
X-Received: by 2002:a05:6a20:9191:b0:13e:da98:966a with SMTP id v17-20020a056a20919100b0013eda98966amr8970273pzd.5.1691987784310;
        Sun, 13 Aug 2023 21:36:24 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:36:24 -0700 (PDT)
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
Subject: [PATCH 8/9] media: cros-ec-cec: Get number of CEC ports from EC
Date:   Mon, 14 Aug 2023 14:29:17 +1000
Message-ID: <20230814043140.1108917-9-rekanorman@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814043140.1108917-1-rekanorman@chromium.org>
References: <20230814043140.1108917-1-rekanorman@chromium.org>
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

Add a new CEC port count host command and use it to query the number of
CEC ports from the EC. If the host command is not supported then it must
be old EC firmware which only supports one port, so fall back to
assuming one port.

This patch completes support for multiple ports in cros-ec-cec.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 40 ++++++++++++++++---
 .../linux/platform_data/cros_ec_commands.h    | 11 +++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index f2f397d9a6d8..cfc0a204d591 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -21,10 +21,6 @@
 
 #define DRV_NAME	"cros-ec-cec"
 
-/* Only one port is supported for now */
-#define CEC_NUM_PORTS	1
-#define CEC_PORT	0
-
 /**
  * struct cros_ec_cec_port - Driver data for a single EC CEC port
  *
@@ -356,6 +352,38 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 
 #endif
 
+static int cros_ec_cec_get_num_ports(struct cros_ec_cec *cros_ec_cec)
+{
+	struct ec_response_cec_port_count response;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec_cec->cros_ec, 0, EC_CMD_CEC_PORT_COUNT, NULL,
+			  0, &response, sizeof(response));
+	if (ret < 0) {
+		/*
+		 * Old EC firmware only supports one port and does not support
+		 * the port count command, so fall back to assuming one port.
+		 */
+		cros_ec_cec->num_ports = 1;
+		return 0;
+	}
+
+	if (response.port_count == 0) {
+		dev_err(cros_ec_cec->cros_ec->dev,
+			"EC reports 0 CEC ports\n");
+		return -ENODEV;
+	}
+
+	if (response.port_count > EC_CEC_MAX_PORTS) {
+		dev_err(cros_ec_cec->cros_ec->dev,
+			"EC reports too many ports: %d\n", response.port_count);
+		return -EINVAL;
+	}
+
+	cros_ec_cec->num_ports = response.port_count;
+	return 0;
+}
+
 static int cros_ec_cec_get_write_cmd_version(struct cros_ec_cec *cros_ec_cec)
 {
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
@@ -461,7 +489,9 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	cros_ec_cec->num_ports = CEC_NUM_PORTS;
+	ret = cros_ec_cec_get_num_ports(cros_ec_cec);
+	if (ret)
+		return ret;
 
 	ret = cros_ec_cec_get_write_cmd_version(cros_ec_cec);
 	if (ret)
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ad61c7ff0b28..7dae17b62a4d 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4536,6 +4536,17 @@ struct ec_response_cec_get {
 	uint8_t val;
 } __ec_align1;
 
+/* Get the number of CEC ports */
+#define EC_CMD_CEC_PORT_COUNT 0x00C1
+
+/**
+ * struct ec_response_cec_port_count - CEC port count response
+ * @port_count: number of CEC ports
+ */
+struct ec_response_cec_port_count {
+	uint8_t port_count;
+} __ec_align1;
+
 /* CEC parameters command */
 enum cec_command {
 	/* CEC reading, writing and events enable */
-- 
2.41.0.640.ga95def55d0-goog

