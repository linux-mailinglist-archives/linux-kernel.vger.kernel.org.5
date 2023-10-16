Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC17CA1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJPIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjJPIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:38:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD8DC;
        Mon, 16 Oct 2023 01:38:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40651a72807so40696495e9.1;
        Mon, 16 Oct 2023 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697445496; x=1698050296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLWwUsKeJ2H5tqYiWTlrMLno6gfKUXxQsmHCjrzmZcs=;
        b=Bb9oERYk9qVUBsFJrz7IiRKMATCNzokIXXJr/gtVkOsoLl00sLmva8QQYXY79EWkTK
         Fe2akupNvDf3taw6zjpweUx0rsxZ0qEBYB3ywosoWy3YZ4PHuTEkSmxagmBdGITTMn0s
         ++h8PDTh5mQc/U6Owu/TlQvYdAd27AFznef0BLP9HcbBZjGWs9XoIRwPs6EwvXs0v8bV
         zoQ03ajGESiw8TmaRGkQWM0uoysJhBG82A4DraPvaCifsHTtBRQcUDXBNjhJf8QFPpve
         JmW8s/+zs+/wmedBfmeuMkVSJTKcQbtNC69FGziJGycHHVVXIdCwzGFCTSyu8HXcGa+y
         F9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445496; x=1698050296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLWwUsKeJ2H5tqYiWTlrMLno6gfKUXxQsmHCjrzmZcs=;
        b=KyFqdM6KQsOV0ar5f5loXuDHFxoG2/tmqvtyDHjlexTy5qAJZElm0KEu0pvEkYMGF0
         qTxGkQ0Kulyb2KgiyjbCqq0CkAwGj0pQyUnidgTfvPWi/MnSnvSGwI/NtqSKxKYU7tsC
         zOvhndjVIbmIazef0DGkCTJsxnbMckvjpUyn3ZRGWzIUJQSBWypKRjvHC7XEBiNfcEKq
         dIEyh9JiqHEU1let78JtRKPpdtPIkE776FK+eo8xEbqjKXm8sKIVu4d6K8/2Ry4nE7js
         iYvbD1SSvmCucG++LYFHfqXBiNHGkW83sWgshHO5VF8w18MQYEcfh4AV9E1P4uayH2lr
         GExQ==
X-Gm-Message-State: AOJu0YztjPxtLrOGqlm+7DFgOmE+gEWVbUzevieqM134NNIZ/n59e4wR
        3RIDEzAXF0WKPF/YHXR/vDmdUfmNPYy8yA==
X-Google-Smtp-Source: AGHT+IE/WiqIxpOwJ77uyliiXdGOE9fATiCQlgW6DJozlbUQl9I6nD5xAeCefau9cIIS2Y+WMpDGnA==
X-Received: by 2002:a7b:c387:0:b0:3f9:b430:199b with SMTP id s7-20020a7bc387000000b003f9b430199bmr28779907wmj.15.1697445496139;
        Mon, 16 Oct 2023 01:38:16 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b004067e905f44sm6633554wmo.9.2023.10.16.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:38:15 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (aquacomputer_d5next) Check if temp sensors of legacy devices are connected
Date:   Mon, 16 Oct 2023 10:35:57 +0200
Message-ID: <20231016083559.139341-2-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016083559.139341-1-savicaleksa83@gmail.com>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENODATA if a temp sensor of a legacy device
does not contain a reading.

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 023807859be7..46ff4fd4f87d 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -926,7 +926,10 @@ static int aqc_legacy_read(struct aqc_data *priv)
 	for (i = 0; i < priv->num_temp_sensors; i++) {
 		sensor_value = get_unaligned_le16(priv->buffer + priv->temp_sensor_start_offset +
 						  i * AQC_SENSOR_SIZE);
-		priv->temp_input[i] = sensor_value * 10;
+		if (sensor_value == AQC_SENSOR_NA)
+			priv->temp_input[i] = -ENODATA;
+		else
+			priv->temp_input[i] = sensor_value * 10;
 	}
 
 	/* Special-case sensor readings */
-- 
2.41.0

