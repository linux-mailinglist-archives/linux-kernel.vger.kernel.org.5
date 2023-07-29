Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D41767A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjG2Axx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjG2AxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80727449C;
        Fri, 28 Jul 2023 17:52:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b2b60731so16004265ad.2;
        Fri, 28 Jul 2023 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591902; x=1691196702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQaf9NpFPpFxvg172bFM+rU/3s6Fkcu6Hx5BLm6nRzI=;
        b=iCO1ciZy/FKKo8yEdQy1pphZ1KJGOB9qLgdH2bZKg2CGbrCXMHwDmTIhM55tt2LvSZ
         UOZwnSdP0kko3ZsPj/j/kisza6Blieyh+HZ+MADBbrP9WfVGiKSG0VsN8TQV4n4ToxKl
         stkMjeeMmjjDCn3mjnzMey4hK0e63+I7UcxKxkCFPt4xxtliLb3ugUpmy7sjTIgXMV/H
         W3wh7IqtUK8F78lxYww9jXMZr8WaipqJr00LWSVKevjwhGInvoxvHiSMYZX++MgF2Ojn
         8DmJcZfGv8XuGSOLlZPE2OmuxwShG7JBLocUbKsmJXhuNa/Xg9tbgUluuVaDyd3pCmmu
         NDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591902; x=1691196702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQaf9NpFPpFxvg172bFM+rU/3s6Fkcu6Hx5BLm6nRzI=;
        b=bGFQwTYji5PFiCI8KSkRvgSyVhj5iPkQqpmAa6t09Uvqf3RKkL2IpsW/y0z7ALzney
         iUyg3tcmUx8ElxchJ9CGWxooSVabDEYBUeP1HPqdV+yhwQPual/SIEeLGDYcQ1UE+aRq
         gauYiUowEx+HZN3FifTaNyJmz98I+kiD+766dzLnQqf7GqP+BOTAu7NEJK97uT0vQgY+
         F/kjb0NsM3eb42XyNy8DY2PVcO9n1SvA3fcrNtPismegS4xTKgjOxEkbFVkxsAqv1ANt
         FN5JWEWHbX2gTyXeYXPRM+u8T2o72JJz8xxRfUgD2F1Sk60S/XtkSkDBc6h/sp1yoFrA
         jO4w==
X-Gm-Message-State: ABy/qLYUNEMCZnYaGl/fkaVTD+MTovp9wpnGChi+cMVLQFcHdsp0zU8b
        Bqr7BRlg+/LItoYebdRQ/MasnmHsVyE=
X-Google-Smtp-Source: APBJJlE9i5igr5fbBkHSYefpwwHnG5PrQPyTV6KHoGdNa7tbXqyUdNUYn37aj2nz8/gWejwJByNDGg==
X-Received: by 2002:a17:903:44e:b0:1bb:bc6d:457 with SMTP id iw14-20020a170903044e00b001bbbc6d0457mr2558551plb.36.1690591902140;
        Fri, 28 Jul 2023 17:51:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:41 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/22] Input: ads7846 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:16 -0700
Message-ID: <20230729005133.1095051-7-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/ads7846.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index bb1058b1e7fd..5601ceb7e26b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -628,15 +628,12 @@ static ssize_t ads7846_disable_store(struct device *dev,
 
 static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
-static struct attribute *ads784x_attributes[] = {
+static struct attribute *ads784x_attrs[] = {
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
 };
-
-static const struct attribute_group ads784x_attr_group = {
-	.attrs = ads784x_attributes,
-};
+ATTRIBUTE_GROUPS(ads784x);
 
 /*--------------------------------------------------------------------------*/
 
@@ -1395,10 +1392,6 @@ static int ads7846_probe(struct spi_device *spi)
 	else
 		(void) ads7846_read12_ser(dev, READ_12BIT_SER(vaux));
 
-	err = devm_device_add_group(dev, &ads784x_attr_group);
-	if (err)
-		return err;
-
 	err = input_register_device(input_dev);
 	if (err)
 		return err;
@@ -1424,9 +1417,10 @@ static void ads7846_remove(struct spi_device *spi)
 
 static struct spi_driver ads7846_driver = {
 	.driver = {
-		.name	= "ads7846",
-		.pm	= pm_sleep_ptr(&ads7846_pm),
-		.of_match_table = of_match_ptr(ads7846_dt_ids),
+		.name		= "ads7846",
+		.dev_groups	= ads784x_groups,
+		.pm		= pm_sleep_ptr(&ads7846_pm),
+		.of_match_table	= of_match_ptr(ads7846_dt_ids),
 	},
 	.probe		= ads7846_probe,
 	.remove		= ads7846_remove,
-- 
2.41.0.487.g6d72f3e995-goog

