Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D13767A67
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjG2AzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjG2Ay5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:54:57 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C054498;
        Fri, 28 Jul 2023 17:53:52 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so5449445ad.2;
        Fri, 28 Jul 2023 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591897; x=1691196697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jtitKPmPv1QZ35jWw/TxRZ9JZX7OXyPiqS7eZQkRX0=;
        b=ZLrGn05MUkHmy9umqhyalvo6jULTXifsXM898LgnZypiokj4DbhjGA2DKicQPylNZT
         bsHjkWRTsweAmrnW45in3M5LlfLJlb/BdWnvDJ6/iSj99oJo58PBy8L1wWtX9ojkLAIg
         ZA7J1phe7ohuI6F1saudthk0P3MEGpTLuXOO7Wydxqc2SmBo6g4iZJ+z/3wQEuRp39zI
         aW83IzmOs9balI94wHr4x83W9RbgCVokkkGgv+Kk+V7FSk2//UI3IDchr2sahlJaNhZd
         Zs6ynTqSZzEgqNkv3AkqEexfYs4Qx7JTtF1sJIBa/A9ONGMb96/x171Phf1CjcLQoMJ/
         6NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591897; x=1691196697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jtitKPmPv1QZ35jWw/TxRZ9JZX7OXyPiqS7eZQkRX0=;
        b=Y64rcDy2G8SDuAwaxzamYebPeY0V6NXAxboHAtrGkwjJiRK/K9GCL/TSpgaDhLws7A
         88G4J0CHz6Ym51Qsfcq67sBk3RVqwmcJGbVzKNDjSt9D0UgAbALfgMLD80gQN2yxEM+G
         Ph1FZUhARfXPoQT65eSQWXafG3Aq5IczmqKtvxEBYSjfHIvbw2MThMxnfgaJg2Bf1aih
         EetBYDohN5zDpVmOVo6RFlu2s787yB/mozNqHOlQFLjqPOewqTv54lfe48eUZ4jfqBhx
         BuisESG/vYEUaxm1COhy3t4AFa/J8mWaNNyqQ4a6OMK879fI0i/cm9V8rJOREDsh78hy
         aZdQ==
X-Gm-Message-State: ABy/qLYLigbwvRNIcreGs3s37H6fljSUwRvJhlhD3sYgpv47QBf876WI
        rfffJGZvFb+IdAzDXFO+BCbRMrOAHNk=
X-Google-Smtp-Source: APBJJlE1c+ch5XpoWIAq/65XLons7xmMFKcehpJoYCmLqy5YYddBugUThZZxJGZXqs+SYttzVNxZVg==
X-Received: by 2002:a17:902:b7c5:b0:1b8:9b5e:a218 with SMTP id v5-20020a170902b7c500b001b89b5ea218mr2523742plz.42.1690591897281;
        Fri, 28 Jul 2023 17:51:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 01/22] Input: cros_ec_keyb - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:10 -0700
Message-ID: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
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
 drivers/input/keyboard/cros_ec_keyb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index e7ecfca838df..313b7a69dd69 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -686,10 +686,11 @@ static umode_t cros_ec_keyb_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static const struct attribute_group cros_ec_keyb_attr_group = {
+static const struct attribute_group cros_ec_keyb_group = {
 	.is_visible = cros_ec_keyb_attr_is_visible,
 	.attrs = cros_ec_keyb_attrs,
 };
+__ATTRIBUTE_GROUPS(cros_ec_keyb);
 
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
@@ -730,12 +731,6 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_device_add_group(dev, &cros_ec_keyb_attr_group);
-	if (err) {
-		dev_err(dev, "failed to create attributes: %d\n", err);
-		return err;
-	}
-
 	ckdev->notifier.notifier_call = cros_ec_keyb_work;
 	err = blocking_notifier_chain_register(&ckdev->ec->event_notifier,
 					       &ckdev->notifier);
@@ -782,6 +777,7 @@ static struct platform_driver cros_ec_keyb_driver = {
 	.remove = cros_ec_keyb_remove,
 	.driver = {
 		.name = "cros-ec-keyb",
+		.dev_groups = cros_ec_keyb_groups,
 		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
 		.acpi_match_table = ACPI_PTR(cros_ec_keyb_acpi_match),
 		.pm = pm_sleep_ptr(&cros_ec_keyb_pm_ops),
-- 
2.41.0.487.g6d72f3e995-goog

