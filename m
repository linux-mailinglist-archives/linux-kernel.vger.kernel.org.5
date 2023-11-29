Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511C07FE011
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjK2TEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjK2TD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:03:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296AF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:04:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332ed1bd4cbso84379f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701284643; x=1701889443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgvbtukB8PwWlSirb4+jB7fmU1O+TkE4+ao/vcBWmcA=;
        b=Zox6clDdTJWc0IssMju+G9gZdSACcsmPxHxe4mFQQn+B2BEhHE5veLnoQj1vIxgfWW
         UFRWeXnMMOpdd0JjfOPHD6ioQCnmEGol4IXtQtyCavjLW2ejkWQ+b79WjYQSnbmT9Hwa
         F7RXaoVE+mqz7t1rIwYCLqc+D7mHt9WbUOm2DHowwCUwI6N+7N9+lx/ADmJdFjxZ6Te3
         fYi0ONcJwM87HW93963fiYuhqN5lboDHrPD7q/Z6L1hP/0A/l1j4iwAjQMO9G8U7b141
         TkYYm9Cd7l/JgCVE1qWh2cqTH41UyS02Dp0X88fn9gil4rKMBo+CJlTvBcVcLuOYxAHQ
         TTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284643; x=1701889443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgvbtukB8PwWlSirb4+jB7fmU1O+TkE4+ao/vcBWmcA=;
        b=JdZzzOp5QYrV4DeSN0uC2SbiWLrzUt8iSx9s6NbBgKK7MuHBDCqvIbl6f8jehhfm5U
         yG8Kz3EIHcCYYEndl6B74pUAQi05lUYO47ztNwFfYcmBAN3lolK4ZVnU+s38DDf2MUp0
         GFWnF1ct7yfyLhSe4kmrlQ4en/yZqE4OKPrYIEmAwZ8SZiZe5QtvGShKti3ou+ML/RvT
         zkLDSquw3eGi7Rup6JC2jIis+hkfQjUoBhioNgCNx3tp6zAD1+H4wFX1RktZOSDNdDXY
         oXRqPLQ0YHklC0ahWcscPAyDbdrscy2MozgZWhsNdm9b04EzpoY9dRUigTdaas/3XtvZ
         Cpuw==
X-Gm-Message-State: AOJu0YyjJL2jCZSqGEf8jLzoxJPpxxubtX51tfoNgG4FPwZa8t4inkbe
        2RxcuzrMOIPFU9htAy1uBQo=
X-Google-Smtp-Source: AGHT+IHqIouxjc3q8FC7Jdh0+5/iwmlwqPX6FdSSvZcBkVDABfRElhGO4YUZ+vuC2DF6oGYx2q3tQA==
X-Received: by 2002:a05:6000:371:b0:333:880:e29b with SMTP id f17-20020a056000037100b003330880e29bmr5580557wrf.4.1701284643290;
        Wed, 29 Nov 2023 11:04:03 -0800 (PST)
Received: from uk-l1.corp.ad.wrs.com ([2a01:4b00:8855:a800:e253:bfaa:775:87a6])
        by smtp.gmail.com with ESMTPSA id t20-20020a0560001a5400b00332f1900476sm4116946wry.81.2023.11.29.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:04:02 -0800 (PST)
From:   Beniamin Sandu <beniaminsandu@gmail.com>
To:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Cc:     Beniamin Sandu <beniaminsandu@gmail.com>
Subject: [PATCH] firmware: stratix10-rsu: correctly report unsupported DCMF commands
Date:   Wed, 29 Nov 2023 19:03:36 +0000
Message-Id: <20231129190336.247674-1-beniaminsandu@gmail.com>
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
index 4f7a7abada48..291a14db61c2 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -235,7 +235,9 @@ static void rsu_dcmf_version_callback(struct stratix10_svc_client *client,
 		priv->dcmf_version.dcmf1 = FIELD_GET(RSU_DCMF1_MASK, *value1);
 		priv->dcmf_version.dcmf2 = FIELD_GET(RSU_DCMF2_MASK, *value2);
 		priv->dcmf_version.dcmf3 = FIELD_GET(RSU_DCMF3_MASK, *value2);
-	} else
+	} else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support DCMF version.")
+	else
 		dev_err(client->dev, "failed to get DCMF version\n");
 
 	complete(&priv->completion);
@@ -264,7 +266,9 @@ static void rsu_dcmf_status_callback(struct stratix10_svc_client *client,
 						    *value);
 		priv->dcmf_status.dcmf3 = FIELD_GET(RSU_DCMF3_STATUS_MASK,
 						    *value);
-	} else
+	} else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support DCMF status.")
+	else
 		dev_err(client->dev, "failed to get DCMF status\n");
 
 	complete(&priv->completion);
-- 
2.34.1

