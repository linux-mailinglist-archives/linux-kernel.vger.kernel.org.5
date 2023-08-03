Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E576F651
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjHCXzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHCXzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:55:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8213A9F;
        Thu,  3 Aug 2023 16:55:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68783004143so1130547b3a.2;
        Thu, 03 Aug 2023 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691106940; x=1691711740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lwbJe4V1wQMBC7uvDgDMNcUkeqFB1Sc7a2l51PczTIY=;
        b=IslMSHUJ8aqaN0qWelUdvLlkJcMs5cNDY+JUhe63vCGkLKCHGucEaXJGWYEN86L7e+
         HxHQSjMenVzQlizjkGpX7D/pTc2Qqpv9eoGW8pn17YxntGMvkCdTxePZ+g9SgpcOrXVR
         UpUXVDFim6GcTEKAIP+e9H8i2lRJfMGUU700Sbni48QXqCRblJ4vVvCr7d9pmrLIEKUy
         /kCKH2ci0jMEiPNVwj6jOJu4aKf28iChSSJ6iUFuUuN8jxD1shvo8SNfsKKhAciJiMa+
         h0p60XwKQHxBmIvs+NbVgx0UztGbvp+lddUZ9XclIeku5c4k1/4d0u9QgTYUbMovr9fV
         TYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691106940; x=1691711740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwbJe4V1wQMBC7uvDgDMNcUkeqFB1Sc7a2l51PczTIY=;
        b=RdHJB3WUF1Cd4orwHEDEtLXJR4FqLfbOG2qpinFApvKuqEaGiWz1/ICioX0LnlRiQj
         7L/BzE9irDBOo5OBsF5+/d/2N4iWDkZu6lbYl0MLLFZ3oNzMTpxizk4nytVSzJI5/9RJ
         5GI3JYQbklCDnI7upJB4ho5LyCzUyCD9dmDYAeH8hZUxcjDeTtZ0SlevXxYQOjvP6mkl
         UL/EmmJ8eYh27zLtkHI6QXMzy1J365WG/lRDZVyBAtU23K6nfb25LaAcRSUyMxxAvZ/W
         jydXN7ci9id2itzDAzfqdP7yVPbyb0QSLUztOVdOtiKK/tNR8BGGVVrXiLYdLjnyWyT4
         FR6w==
X-Gm-Message-State: AOJu0YyG3HN0F/jalOv2+tfgGCgaU5cZ78t8Q/EdH77gqWV2+EsDCIud
        Jn/Uv7HJhAzTsUr/CQYb5Ogmiaz/zwnSqw==
X-Google-Smtp-Source: AGHT+IEpVU+L/7mpadLZYFoKJpGO0tw01CIYFdhPCckLaZETjGd7rzfcK5GdawNy25md78G3EwZaPQ==
X-Received: by 2002:a05:6a20:3204:b0:13b:7533:6839 with SMTP id hl4-20020a056a20320400b0013b75336839mr83044pzc.29.1691106939963;
        Thu, 03 Aug 2023 16:55:39 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4.thefacebook.com ([2620:10d:c090:500::5:7175])
        by smtp.gmail.com with ESMTPSA id x15-20020a62fb0f000000b00682a27905b9sm395413pfm.13.2023.08.03.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:55:39 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
Date:   Thu,  3 Aug 2023 16:55:36 -0700
Message-Id: <20230803235536.798166-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
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

From: Tao Ren <rentao.bupt@gmail.com>

Enable PMBUS_SKIP_STATUS_CHECK flag for both pfe1100 and pfe3000 because
the similar communication error is observed on pfe1100 devices.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/hwmon/pmbus/bel-pfe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
index fa5070ae26bc..8280d274da3f 100644
--- a/drivers/hwmon/pmbus/bel-pfe.c
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -17,12 +17,12 @@
 enum chips {pfe1100, pfe3000};
 
 /*
- * Disable status check for pfe3000 devices, because some devices report
+ * Disable status check for pfexxxx devices, because some devices report
  * communication error (invalid command) for VOUT_MODE command (0x20)
  * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
  * exponent in linear mode.
  */
-static struct pmbus_platform_data pfe3000_plat_data = {
+static struct pmbus_platform_data pfe_plat_data = {
 	.flags = PMBUS_SKIP_STATUS_CHECK,
 };
 
@@ -94,6 +94,7 @@ static int pfe_pmbus_probe(struct i2c_client *client)
 	int model;
 
 	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
+	client->dev.platform_data = &pfe_plat_data;
 
 	/*
 	 * PFE3000-12-069RA devices may not stay in page 0 during device
@@ -101,7 +102,6 @@ static int pfe_pmbus_probe(struct i2c_client *client)
 	 * So let's set the device to page 0 at the beginning.
 	 */
 	if (model == pfe3000) {
-		client->dev.platform_data = &pfe3000_plat_data;
 		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
 	}
 
-- 
2.40.1

