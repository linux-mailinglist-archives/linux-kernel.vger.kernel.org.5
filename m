Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644C767A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjG2Axf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjG2AxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF03C33;
        Fri, 28 Jul 2023 17:52:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so5449945ad.2;
        Fri, 28 Jul 2023 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591911; x=1691196711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRJxLZ3EGDE+HcejVJHN5WgMKPYKV/494+/KjMoBMUQ=;
        b=R00RD94BaZMbiQEo/jBpDeNL2kfq3Al+ce4OmH1DU/fe7C8nGurSFGTxt+QVRAAGs5
         hPiuZut5zGHyNCrANXXNzQ2jG3/hNVYnuXaD7YjcKoONekEI0kWGRV9qtOoJcNOeJZyk
         S2uTeabqRJuwnSJZus7d5mnu04kJWSG3/dxYlG3hQnl4eoaHnhXEbgN0YxwucYpkXkSn
         E69zUIa6cPaDr0kXXnhH+I/7k39L9dhYRdPIjhF6nrlxgySh/M17f8VXGftVkB2YDFx9
         eS0pCQVWA258/7LjZ6WqHVvFhizlaiMyloqxE8MWQps2lWsEU+I2GOdQvJWAvUyimvVU
         vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591911; x=1691196711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRJxLZ3EGDE+HcejVJHN5WgMKPYKV/494+/KjMoBMUQ=;
        b=dQNGZXO8cvog/wigypSWhvJdhFfaLsuq6J3l9pcgmMrEuL2fdCT7bM6NOuCzTIJhc6
         rCbAfz8pdztjUQYGkdlCKSRaAem2YiBHlXbmfa311SF1hnzhMfZ2lDIm0G9FnsmyeNyb
         1MotCm4eERfb6f+PoykclwT/N+8O2dy5bZiIyHXhEr55uYc6bqO3EZSD0khJ3TZiJg5L
         ARl1ZIbfR4oKT9ECB9tE4qA+VUulG2xsX1owVLEtkU1GFDbennHpjmKEngEp4v4CX5NL
         Z3Wpps+zEupsmo2UtqBh5lU58CvUX5xrx7n1kK6By2qVcGtKJrvtHviPsfoQ2ysoZb2n
         d6BQ==
X-Gm-Message-State: ABy/qLZEVmd253U2OjkFyOnAV1Kzvrw0p1kVff+T3A3g8hd0h1upTgff
        dkrAKJzlEBZIHmJfsE+5ptYcPR2m8zM=
X-Google-Smtp-Source: APBJJlHAGWzpakcxwoD37LuGCcOTh86tsClJzvBraXWGt4S8tziEbN+cNgBGot9UuAXDwW7J+gRQYw==
X-Received: by 2002:a17:902:d489:b0:1b8:8069:d432 with SMTP id c9-20020a170902d48900b001b88069d432mr2915832plg.16.1690591910675;
        Fri, 28 Jul 2023 17:51:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 18/22] Input: rohm_bu21023 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:27 -0700
Message-ID: <20230729005133.1095051-18-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating driver-specific device attributes with
devm_device_add_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/rohm_bu21023.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index 240424f06b98..4493ad0c9322 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -854,10 +854,7 @@ static struct attribute *rohm_ts_attrs[] = {
 	&dev_attr_inv_y.attr,
 	NULL,
 };
-
-static const struct attribute_group rohm_ts_attr_group = {
-	.attrs = rohm_ts_attrs,
-};
+ATTRIBUTE_GROUPS(rohm_ts);
 
 static int rohm_ts_device_init(struct i2c_client *client, u8 setup2)
 {
@@ -1164,12 +1161,6 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(dev, &rohm_ts_attr_group);
-	if (error) {
-		dev_err(dev, "failed to create sysfs group: %d\n", error);
-		return error;
-	}
-
 	return error;
 }
 
@@ -1182,6 +1173,7 @@ MODULE_DEVICE_TABLE(i2c, rohm_bu21023_i2c_id);
 static struct i2c_driver rohm_bu21023_i2c_driver = {
 	.driver = {
 		.name = BU21023_NAME,
+		.dev_groups = rohm_ts_groups,
 	},
 	.probe = rohm_bu21023_i2c_probe,
 	.id_table = rohm_bu21023_i2c_id,
-- 
2.41.0.487.g6d72f3e995-goog

