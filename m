Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D8767A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjG2AxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjG2AxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264F4C20;
        Fri, 28 Jul 2023 17:52:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb81809ca8so20759455ad.3;
        Fri, 28 Jul 2023 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591907; x=1691196707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8EWWPn2TqtaSPPFS1yD2I79GrwiYmktBuYVOfz6KWc=;
        b=ICPLEqL+DzywUKaGGVCjRpAnYdAzXsE74QEIlXe2QcneXLbs8koND9oxoKboucm99T
         8rjrvzPsvk8lfVUPFiQ9VsCA66FXfP3vUp6TLTsjYsc+In6jSfyWshsgqIrBY5uCppNd
         JMHlrc425nS7Fg80a03gdVNtB4qf9l7RWlW2GlJWYkKZIASk4KtHgtdPZkrojbkmYLcN
         FrjsajbbLUJPm3aMUnqsQVazTG6eOvpBwtXZ6Zw6n49XGt1BsUxpBaqtd1D2W9vWdcsb
         02Lu9wfOY7THF8YLZlXA2l+4C2IeYsTKkvYmDobpOY5ZwwkQUPgKQSHXlOYcrUkKN3bA
         zjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591907; x=1691196707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8EWWPn2TqtaSPPFS1yD2I79GrwiYmktBuYVOfz6KWc=;
        b=H+lSzeI0npZBuLT/8r/NcOjBa6tpX72cUaK6GQdvSPScYxr572hFIX3PJWaXuVFn8D
         EpHInAUnkKKz/KxJB0Sm9pPaO3zFIez9MMzLeFeWZrNEK+btnrP/WTUt6o4nUYKMdTUh
         ghH3Wy+LiNqeIN0wZkHuXmLWtm5yEmx8JxjblYjOtnYcMOExQKDfS+fEHynK74ne6Q2P
         R0QXGDnHJf3e3IANKZLNPYGImJSsIkaK8FXeSMZ1eCFgST8Pq6WSgemEDxXIyMOMhbUF
         r2P6XZCn5OkmIB/IySBKlFtArLB+lTHCqKLxINfqjPzE4R95jbTJCbXMQv5B1awqsxq8
         x27A==
X-Gm-Message-State: ABy/qLZA7KS5YJlABX6n5d+FdbIA0kYpx01/pN93qUb71ZSphrWO+IVq
        vnaPnPuZIEsT451OfkVq9i9x42tXyPE=
X-Google-Smtp-Source: APBJJlGXl6SVpo3gw5l6fHNGQq4x4hZy8+IccDOMOwPTwUtxyYtwsL8X2tzbrWV7EonRX4HinIbn5Q==
X-Received: by 2002:a17:902:e542:b0:1b8:90bd:d157 with SMTP id n2-20020a170902e54200b001b890bdd157mr4331342plf.26.1690591907437;
        Fri, 28 Jul 2023 17:51:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Hung <joe_hung@ilitek.com>
Subject: [PATCH 14/22] Input: ilitek_ts_i2c - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:23 -0700
Message-ID: <20230729005133.1095051-14-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/ilitek_ts_i2c.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 2f872e95fbba..90c4934e750a 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -537,10 +537,7 @@ static struct attribute *ilitek_sysfs_attrs[] = {
 	&dev_attr_product_id.attr,
 	NULL
 };
-
-static struct attribute_group ilitek_attrs_group = {
-	.attrs = ilitek_sysfs_attrs,
-};
+ATTRIBUTE_GROUPS(ilitek_sysfs);
 
 static int ilitek_ts_i2c_probe(struct i2c_client *client)
 {
@@ -595,12 +592,6 @@ static int ilitek_ts_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(dev, &ilitek_attrs_group);
-	if (error) {
-		dev_err(dev, "sysfs create group failed: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -675,6 +666,7 @@ MODULE_DEVICE_TABLE(of, ilitek_ts_i2c_match);
 static struct i2c_driver ilitek_ts_i2c_driver = {
 	.driver = {
 		.name = ILITEK_TS_NAME,
+		.dev_groups = ilitek_sysfs_groups,
 		.pm = pm_sleep_ptr(&ilitek_pm_ops),
 		.of_match_table = of_match_ptr(ilitek_ts_i2c_match),
 		.acpi_match_table = ACPI_PTR(ilitekts_acpi_id),
-- 
2.41.0.487.g6d72f3e995-goog

