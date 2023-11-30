Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBC7FEC43
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjK3JyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3Jx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:53:59 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E384710F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:54:00 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so9586421fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701338039; x=1701942839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4OuntfdknXbhYKcMyJiH+XKOWRIfcuxaKsmM+pxZW4=;
        b=DhNDSDmm2NNPmpPtRtjH9XAZ21nt1MEYQiR6LQ+QmsJEuG4pkvgilnvFnqfktxFzui
         MdprlUsfcNbh9XHh5h7qqXJDJCAxz/CJdEUz7q1N4NNa/7Ehv+FNd27NGYjI+/bznVTb
         SY5GivLrYFI6+qY1j/BpQb5WIb/w0/HEYUaMYEMrwRCn0SKVHsPE9UuoH5FItpcHaA0B
         7ycsC8MlO8wO8vUvFgUKUDvBAelkEfyha+AnmMmKKXPBWAuXVagndKnyCGfYNbOa+L+J
         lpPCR9DkK8SUl07Spv47VeSNxQUCUIPy3fspGqM6BCtJDq8gNb/lr6tgoGeMpSYtlT7s
         f9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338039; x=1701942839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4OuntfdknXbhYKcMyJiH+XKOWRIfcuxaKsmM+pxZW4=;
        b=QEz32bOs+TL9yiMfvKnClXH1T+AzOt3jTwNWkm/q8PRaTonXCmixpQQgJZ6x7AMgYM
         IGy8s793JtbB4Mdst6rAzztAsL0hYjgLWAwoFN8/5Ok+Sg9nk0FsCRGB4TfP58hKtbiI
         iX9Xy4Mw6mBId2NEyK3h86xCE8EUjwE/GS/sIG2sE24vnfvqZ0boHS3KIEGJHV3DuBBF
         +3SBrSu3NbwbncUAI7iu81b2e29FPxncoq5VTG6oU0wCVflfNI8s0wE4i1RAkisPvBAQ
         0ysINd2l/D0NKyvw//wFRfHM4nR62jTtkvIp4fkStozTWvrba0nbYZgp+AfWFawGbf+/
         +bxg==
X-Gm-Message-State: AOJu0Yy4AqCfbeUOeAfeOstkkfQ+mHv+aIKGSASAwskLITir1ib+SyIr
        0bhJj8DvlSnYYMXQHl1NpF7i7t54w/DVTw==
X-Google-Smtp-Source: AGHT+IFVMfPnoUlYRTmb80gh+TDZvgnCBqgKTDpL0BxfxcLmX/PhepqsUiR8l9TpwJ7vUA9J9/9Wmg==
X-Received: by 2002:a2e:860b:0:b0:2c9:b5f5:d647 with SMTP id a11-20020a2e860b000000b002c9b5f5d647mr5140620lji.1.1701338038452;
        Thu, 30 Nov 2023 01:53:58 -0800 (PST)
Received: from localhost.localdomain ([85.255.237.37])
        by smtp.gmail.com with ESMTPSA id p8-20020adfcc88000000b0032f9688ea48sm1057392wrj.10.2023.11.30.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:53:57 -0800 (PST)
From:   Beniamin Sandu <beniaminsandu@gmail.com>
To:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Cc:     Beniamin Sandu <beniaminsandu@gmail.com>
Subject: [PATCH v2] firmware: stratix10-rsu: correctly report unsupported DCMF commands
Date:   Thu, 30 Nov 2023 09:53:15 +0000
Message-Id: <20231130095315.9614-1-beniaminsandu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On older firmware that doesn't support DCMF commands, driver will
otherwise report those as failed to read, instead of unsupported.

Signed-off-by: Beniamin Sandu <beniaminsandu@gmail.com>
---
 drivers/firmware/stratix10-rsu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 4f7a7abada48..b7a472c3db7a 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -235,7 +235,9 @@ static void rsu_dcmf_version_callback(struct stratix10_svc_client *client,
 		priv->dcmf_version.dcmf1 = FIELD_GET(RSU_DCMF1_MASK, *value1);
 		priv->dcmf_version.dcmf2 = FIELD_GET(RSU_DCMF2_MASK, *value2);
 		priv->dcmf_version.dcmf3 = FIELD_GET(RSU_DCMF3_MASK, *value2);
-	} else
+	} else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support DCMF version.");
+	else
 		dev_err(client->dev, "failed to get DCMF version\n");
 
 	complete(&priv->completion);
@@ -264,7 +266,9 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
 						    *value);
 		priv->dcmf_status.dcmf3 = FIELD_GET(RSU_DCMF3_STATUS_MASK,
 						    *value);
-	} else
+	} else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support DCMF status.");
+	else
 		dev_err(client->dev, "failed to get DCMF status\n");
 
 	complete(&priv->completion);
-- 
2.34.1

