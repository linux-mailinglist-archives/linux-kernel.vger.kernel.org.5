Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3B767A50
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjG2AyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjG2AxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB311D;
        Fri, 28 Jul 2023 17:52:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba54f7eefso24730965ad.1;
        Fri, 28 Jul 2023 17:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591913; x=1691196713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMDQFiWpPsdIpStYi6pM086GS/3ZK2YeWXsTW0i4Ccc=;
        b=skE3gTkbTy6Rhk5HatUvLDGlVD22333njgEEBIhZ3Yqk8ZkZMQ8hoVSCjO9nz0szL5
         DwQG8EaFzT393REVtIftHAOC5iViK9Vx6dZTUFZ/W0jHxNmyqRbGaCE4wHmWX9OnEiqC
         PE9vZZNXw3Mplj4pmf/pO4rPNqkrxiUhRHf900rsMe7KH9DAXjA6K/tNAXCOyL2SLdha
         M7pvKB49pB2tzRYTQFSz9cy1iOumFbZHePTZzsR6CwqSGuBOObzFBl8HUUEDqjBU/HVy
         OnyUPwhZDMtxC9rKZ7Wv7tEtxTefJklgaWSSUIPSdowgJbCfKdSzlewhIyYO667zBgal
         jBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591913; x=1691196713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMDQFiWpPsdIpStYi6pM086GS/3ZK2YeWXsTW0i4Ccc=;
        b=E1x4Z1p9D8f0oJpDvIqABmpgFsp9s0MZL9nFWR8LuC4OuV6bvp2cFHzlBhwS+OySAn
         0CVit3/u2uu+DzYtShYSHsiPzU1yo6WQshO62uqGLjOtMtjiT6nGECtWSibg5YTenLNn
         pjbEXgp+RKh1DEG033N3NUEDZhdLHGHyC5BsUmRYOkA5E5bhenGEZ5+ecNZAMNc9eH1D
         zJGn/WN7HgORPXrF/JdqnDsFN6RUGlCA1uOWvmI+KaqutzptTYr7vcczweSkt1wrhePs
         s8E/qkk8K56n7YTc4J1fKwoMkbZCLryJ1na5uKVt5He5AK5sNq1JC1bBcf17Nsdl+Viy
         wGpA==
X-Gm-Message-State: ABy/qLY/e5MfTXSFqBEi7FqqDiIoUjYsgG9hUxZ09CuNSaLBO9ukKSa2
        Kxj4ImSZ9vyIoCFDVeMI9YPrP/iFHR0=
X-Google-Smtp-Source: APBJJlGFhyQuP/lIsVizD0LLzafNgpedIt+1DaV9vp53ufP0wQrFrXJNTL2fDW5tifD3eA332EHMdQ==
X-Received: by 2002:a17:903:186:b0:1bb:9efe:b1be with SMTP id z6-20020a170903018600b001bb9efeb1bemr4149165plg.30.1690591913025;
        Fri, 28 Jul 2023 17:51:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 21/22] Input: tsc2004/5 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:30 -0700
Message-ID: <20230729005133.1095051-21-dmitry.torokhov@gmail.com>
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
sysfs_create_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2004.c      |  7 ++++---
 drivers/input/touchscreen/tsc2005.c      |  7 ++++---
 drivers/input/touchscreen/tsc200x-core.c | 18 +++++++-----------
 drivers/input/touchscreen/tsc200x-core.h |  1 +
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
index b5e904c5b7c4..89c5248f66f6 100644
--- a/drivers/input/touchscreen/tsc2004.c
+++ b/drivers/input/touchscreen/tsc2004.c
@@ -63,9 +63,10 @@ MODULE_DEVICE_TABLE(of, tsc2004_of_match);
 
 static struct i2c_driver tsc2004_driver = {
 	.driver = {
-		.name   = "tsc2004",
-		.of_match_table = of_match_ptr(tsc2004_of_match),
-		.pm     = pm_sleep_ptr(&tsc200x_pm_ops),
+		.name		= "tsc2004",
+		.dev_groups	= tsc200x_groups,
+		.of_match_table	= of_match_ptr(tsc2004_of_match),
+		.pm		= pm_sleep_ptr(&tsc200x_pm_ops),
 	},
 	.id_table       = tsc2004_idtable,
 	.probe          = tsc2004_probe,
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index b6dfbcfc8c19..1b40ce0ca1b9 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -79,9 +79,10 @@ MODULE_DEVICE_TABLE(of, tsc2005_of_match);
 
 static struct spi_driver tsc2005_driver = {
 	.driver	= {
-		.name	= "tsc2005",
-		.of_match_table = of_match_ptr(tsc2005_of_match),
-		.pm	= pm_sleep_ptr(&tsc200x_pm_ops),
+		.name		= "tsc2005",
+		.dev_groups	= tsc200x_groups,
+		.of_match_table	= of_match_ptr(tsc2005_of_match),
+		.pm		= pm_sleep_ptr(&tsc200x_pm_ops),
 	},
 	.probe	= tsc2005_probe,
 	.remove	= tsc2005_remove,
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index b799f26fcf8f..a4c0e9db9bb9 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -356,6 +356,12 @@ static const struct attribute_group tsc200x_attr_group = {
 	.attrs		= tsc200x_attrs,
 };
 
+const struct attribute_group *tsc200x_groups[] = {
+	&tsc200x_attr_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(tsc200x_groups);
+
 static void tsc200x_esd_work(struct work_struct *work)
 {
 	struct tsc200x *ts = container_of(work, struct tsc200x, esd_work.work);
@@ -553,25 +559,17 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 
 	dev_set_drvdata(dev, ts);
-	error = sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
-	if (error) {
-		dev_err(dev,
-			"Failed to create sysfs attributes, err: %d\n", error);
-		goto disable_regulator;
-	}
 
 	error = input_register_device(ts->idev);
 	if (error) {
 		dev_err(dev,
 			"Failed to register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		goto disable_regulator;
 	}
 
 	irq_set_irq_wake(irq, 1);
 	return 0;
 
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 disable_regulator:
 	regulator_disable(ts->vio);
 	return error;
@@ -582,8 +580,6 @@ void tsc200x_remove(struct device *dev)
 {
 	struct tsc200x *ts = dev_get_drvdata(dev);
 
-	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
-
 	regulator_disable(ts->vio);
 }
 EXPORT_SYMBOL_GPL(tsc200x_remove);
diff --git a/drivers/input/touchscreen/tsc200x-core.h b/drivers/input/touchscreen/tsc200x-core.h
index 4ded34425b21..37de91efd78e 100644
--- a/drivers/input/touchscreen/tsc200x-core.h
+++ b/drivers/input/touchscreen/tsc200x-core.h
@@ -70,6 +70,7 @@
 
 extern const struct regmap_config tsc200x_regmap_config;
 extern const struct dev_pm_ops tsc200x_pm_ops;
+extern const struct attribute_group *tsc200x_groups[];
 
 int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		  struct regmap *regmap,
-- 
2.41.0.487.g6d72f3e995-goog

