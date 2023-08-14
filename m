Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4C77B07D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjHNEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjHNEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:35:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4222EE7E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bda9207132so29859035ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987752; x=1692592552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itIjiisrKDd0dEJkr9u7QlSUsM4Bsnb9Jzz0yBh6Gm4=;
        b=Xck3Z5OnJrMbtyD9wFRDW/GmpGf9wAmSvtvm5NQ2xVthLhnRYzQuocKe4GukWXcu0b
         MMoucWrJSb2GhXbqcMLVLtlIBkbvLwycQ16Li2XkSn8YTMF/ecRkjn9rMN/fl4Rj6YqQ
         xi4GlIxY+9jFma3qoicyW/h7wEzrASoM/IFxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987752; x=1692592552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itIjiisrKDd0dEJkr9u7QlSUsM4Bsnb9Jzz0yBh6Gm4=;
        b=K1CsG94T616TlputHHsCtBM9JgguTLXk4X+Afmj6Y0H4FlFTtWyTJGxcbwzcIO+6MO
         /F1ugJ/rq6LDYdSbRvhQmZyScTLNvt7TUqMpzGZsIhgNhFt0N0eteGvo27E3DyXZQqJ/
         LauTQuT1cU7V5UYN3vSa3YD/FsnonbzdL5j3j6hSsWln9v9dFWTNsEWPdlvxD8M1B5qa
         AgD9xc8cclG99g9lX6Mp2KGx5bTSgxI+ozcwP62mWdWfSikCZ3/NW1v+8CiDQppGUCue
         rF39gbPG1xwpFl9Jg3yGup6CssKhCH7V5DtTvG/ITb2WZTqRUl8TbWGbHo5yucYCd3Io
         H0OA==
X-Gm-Message-State: AOJu0YzxX5zAV31idTtO+dMo0rRj9UGEZvvN2pplvPDmAyWyye2YRqQX
        sqBXZXF9aAVYoO2D2b75fhBJzw==
X-Google-Smtp-Source: AGHT+IFna/y7uVLsE6ruMXik7aDZMg/YGKuA/YEcbhic+a5zZFTG734FNkYHqA7w/8MH8875Vy2ukQ==
X-Received: by 2002:a17:902:da85:b0:1bc:5b36:a2e8 with SMTP id j5-20020a170902da8500b001bc5b36a2e8mr11568693plx.34.1691987751762;
        Sun, 13 Aug 2023 21:35:51 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:35:51 -0700 (PDT)
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
Subject: [PATCH 3/9] media: cros-ec-cec: Support multiple ports in set/get host commands
Date:   Mon, 14 Aug 2023 14:29:12 +1000
Message-ID: <20230814043140.1108917-4-rekanorman@chromium.org>
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

Reuse the top four bits of the cmd field to specify the port number.
The reason for doing this as opposed to adding a separate uint8_t field
is it avoids the need to add new versions of these commands. The change
is backwards compatible since these bits were previously always zero, so
the default behaviour is to always operate on port 0.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 include/linux/platform_data/cros_ec_commands.h   | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index d76a25ae0cf1..e969031e1e0e 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -118,6 +118,7 @@ static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_LOGICAL_ADDRESS,
+		.port = port->port_num,
 		.val = logical_addr,
 	};
 	int ret;
@@ -162,6 +163,7 @@ static int cros_ec_cec_adap_enable(struct cec_adapter *adap, bool enable)
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_ENABLE,
+		.port = port->port_num,
 		.val = enable,
 	};
 	int ret;
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index cb2ddd10a613..e8bb05db360f 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4457,13 +4457,15 @@ struct ec_params_cec_write {
 /**
  * struct ec_params_cec_set - CEC parameters set
  * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @port: CEC port to set the parameter on
  * @val: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
  *	or 1 to enable CEC functionality, in case cmd is
  *	CEC_CMD_LOGICAL_ADDRESS, this field encodes the requested logical
  *	address between 0 and 15 or 0xff to unregister
  */
 struct ec_params_cec_set {
-	uint8_t cmd; /* enum cec_command */
+	uint8_t cmd : 4; /* enum cec_command */
+	uint8_t port : 4;
 	uint8_t val;
 } __ec_align1;
 
@@ -4473,9 +4475,11 @@ struct ec_params_cec_set {
 /**
  * struct ec_params_cec_get - CEC parameters get
  * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @port: CEC port to get the parameter on
  */
 struct ec_params_cec_get {
-	uint8_t cmd; /* enum cec_command */
+	uint8_t cmd : 4; /* enum cec_command */
+	uint8_t port : 4;
 } __ec_align1;
 
 /**
-- 
2.41.0.640.ga95def55d0-goog

