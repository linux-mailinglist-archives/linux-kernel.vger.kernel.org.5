Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A0767A65
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjG2AzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbjG2Ayp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:54:45 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EE559A;
        Fri, 28 Jul 2023 17:53:39 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-26854159c05so1584645a91.2;
        Fri, 28 Jul 2023 17:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591898; x=1691196698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1OytN0ue9ni3jtAUdTpAVvFgRrAknSTdRSvg9LBsxw=;
        b=ZV6kF4ZQaKSSXPRpulLU3lw0CkuKf3x4WNqUSfPx2mZo8SjYvygXxOjd5i32YXgGau
         xdM2fUf9PunPg3VUit6/1r6bfxLsfdIPVya/89C3e2N/duEynrq74T0qjJKQsGUsu1oj
         9fD9sVZLrBNiA48zmx++v78VS7gfKxhmin5fsitdrqHI9+aK9lULKcsPpKXArnrehhdu
         llCng2cjU7EuWsiZmGr7/4PJs7f7SGlhesHXV/OfWfXbwsX/ZIakIAAIK1iH5tGqhXjh
         xIef2J84J6MTkOzP4lelYmME/Vx4q1/RwtB6gdjol3EsHCjJzy65md7VowQXMF/xpAbQ
         hgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591898; x=1691196698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1OytN0ue9ni3jtAUdTpAVvFgRrAknSTdRSvg9LBsxw=;
        b=K39VE5/+YeZetkFxBzcjtfQ8Pq4Q8cr1VEgQE0kHh4uOaRKYR/9ou/zrq/J3PopT3d
         7CSh47VBRj13+DVlefzwgkLIM1tsByim9A/7E19OQYRWdSZqxWfHEpz8IYe3X970UuoS
         Uj6yAioqKjqN8fP8OynLHL3gwvSomZLHfCKDKZsjxKjbTE4xP3ImAQUVCvMlVDJ9Sv/W
         JUNRIgqKp4Deomu8uNTP6fXjyDwmWU1gFYNji0Xf+oLCeu13vozyrvBC/o6gSPLF4zcl
         FSIqvS6usEK87BnHzjg50J0nHsYsQMz8M088VsJpvod9tKCfVZIyZn7mvdSbGoh4mpNI
         SLjQ==
X-Gm-Message-State: ABy/qLbP6ZGj2KvmRhQ7jVsmlNj/LIZbNes37vzfTpUX7Na+HgZsy483
        gafJyZEebhhSvtXWAK76Ggj7kR/UbjI=
X-Google-Smtp-Source: APBJJlFay8COHXJLtUVNgH0E/pRyc9mXF6LuA/OWWh+px5PfExVnxKJLqcbArJCPe1ZALCjj7Mmbpg==
X-Received: by 2002:a17:90b:e07:b0:268:2543:723 with SMTP id ge7-20020a17090b0e0700b0026825430723mr2957906pjb.5.1690591897994;
        Fri, 28 Jul 2023 17:51:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/22] Input: cyapa - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:11 -0700
Message-ID: <20230729005133.1095051-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/input/mouse/cyapa.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 6a876ba617ef..f9b4a7458b4e 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1225,7 +1225,7 @@ static DEVICE_ATTR(baseline, S_IRUGO, cyapa_show_baseline, NULL);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, cyapa_calibrate_store);
 static DEVICE_ATTR(mode, S_IRUGO, cyapa_show_mode, NULL);
 
-static struct attribute *cyapa_sysfs_entries[] = {
+static struct attribute *cyapa_attrs[] = {
 	&dev_attr_firmware_version.attr,
 	&dev_attr_product_id.attr,
 	&dev_attr_update_fw.attr,
@@ -1234,10 +1234,7 @@ static struct attribute *cyapa_sysfs_entries[] = {
 	&dev_attr_mode.attr,
 	NULL,
 };
-
-static const struct attribute_group cyapa_sysfs_group = {
-	.attrs = cyapa_sysfs_entries,
-};
+ATTRIBUTE_GROUPS(cyapa);
 
 static void cyapa_disable_regulator(void *data)
 {
@@ -1304,12 +1301,6 @@ static int cyapa_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(dev, &cyapa_sysfs_group);
-	if (error) {
-		dev_err(dev, "failed to create sysfs entries: %d\n", error);
-		return error;
-	}
-
 	error = cyapa_prepare_wakeup_controls(cyapa);
 	if (error) {
 		dev_err(dev, "failed to prepare wakeup controls: %d\n", error);
@@ -1486,6 +1477,7 @@ MODULE_DEVICE_TABLE(of, cyapa_of_match);
 static struct i2c_driver cyapa_driver = {
 	.driver = {
 		.name = "cyapa",
+		.dev_groups = cyapa_groups,
 		.pm = pm_ptr(&cyapa_pm_ops),
 		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
 		.of_match_table = of_match_ptr(cyapa_of_match),
-- 
2.41.0.487.g6d72f3e995-goog

