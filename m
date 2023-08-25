Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7209A787E13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjHYCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbjHYCxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:53:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A02105
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:53:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0c6d4d650so4788395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931994; x=1693536794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dugPNPrpRp20Yd0O9nctENrWeeR3ORCR/xP4x4RAic=;
        b=kUsFiECEZpTrPQFc8F/uDF4rHYH4vybiNaFnPghtvyBKKmZ9Bje+SEjmmjEerhmzCl
         CYVBghYEA1/TUoIx5EEUOkcuwx53A+/kBvFdIoh711qp6sbLW0dgQqSjk9DiamKGlit+
         6vj+hK0sMuyscmmRkQ01q9gFDoU77NtaBIcYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931994; x=1693536794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dugPNPrpRp20Yd0O9nctENrWeeR3ORCR/xP4x4RAic=;
        b=fKEER5+O0opXOTAI2xgLFXYGZe8KOQ6Zjyt1VK/lNRxFSMtWw3trrz3pQK5B0WG4pf
         ULJwlnN9mUkYXE5cxbTUSti+ZjWeSfooL1Qs1nwTHniSj0dHnBheNCjSFUzrJr8h2Nek
         +yAr+9q0smCpWO/1glyueQUVN4Z9RS32q7APahTKI82wZaMYYtR92n/wHDfMuzEiQ+4c
         u6Rum7Z3pauy2HYWZBKdAQw2dhyQkkSgtbPhSaaNJ+c42VFEi9EqNne2H7KI9+OwuPzW
         /rzpP0qo3zOeekMSKeBWOgRNlpoj+IJygdY7SpKvX8OpAg9vqaxIin0ZzEd9Xb3r86vj
         reSg==
X-Gm-Message-State: AOJu0YxFHstRpKXvfCKwf1DDE/Auuz40jCS3qVcsnMfGK735igNx/ihm
        0UxP6tzmEZ22y9oKdUrvjRVlEA==
X-Google-Smtp-Source: AGHT+IEkc7Xs+45n58w3dsFPGkMtOXljc3EaX3VUWt/vtWRbIjVktIboj9yBRphEmhsRVco1KvBeAg==
X-Received: by 2002:a17:903:187:b0:1bd:b7ad:a584 with SMTP id z7-20020a170903018700b001bdb7ada584mr22007289plg.44.1692931994207;
        Thu, 24 Aug 2023 19:53:14 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:53:13 -0700 (PDT)
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
Subject: [PATCH v2 8/9] media: cros-ec-cec: Get number of CEC ports from EC
Date:   Fri, 25 Aug 2023 12:44:01 +1000
Message-ID: <20230825024735.1443836-9-rekanorman@chromium.org>
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

Add a new CEC port count host command and use it to query the number of
CEC ports from the EC. If the host command is not supported then it must
be old EC firmware which only supports one port, so fall back to
assuming one port.

This patch completes support for multiple ports in cros-ec-cec.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

(no changes since v1)

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 40 ++++++++++++++++---
 .../linux/platform_data/cros_ec_commands.h    | 11 +++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 371699d599de..993deb85d3e2 100644
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
@@ -358,6 +354,38 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 
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
@@ -463,7 +491,9 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
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
2.42.0.rc2.253.gd59a3bf2b4-goog

