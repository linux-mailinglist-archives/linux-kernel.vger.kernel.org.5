Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821A7540AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjGNRll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjGNRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:41:20 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03835A8;
        Fri, 14 Jul 2023 10:41:03 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-346392da0d6so9591515ab.3;
        Fri, 14 Jul 2023 10:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356462; x=1691948462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8B9VdIZYHl/5f2hD4bWd1FxmyEJhurzf9pPuxBMOhI=;
        b=Hs7n6GRpGAU0fDNvRi2WJQsaN4EWAcbiZl/6N1HH/98HKeq982sWX7yRUQcs5MhypY
         KMah6b9nOHpCzSmFG0iB8caCWRn7IK0ZS6jE0cBhk8jCCaDGMVxzlhcVJ84M9r9daaGG
         R384hQu5IsRa5pvWLY4Z5DQUBlvW5YON7gU4d9sd4fTLr2q/A4H/0JIwRFhVbd9Utofx
         iFI+r//q5yfruT30rZFZh6Y7Cn2FCnrC2/qs4vQg3jLKWPI2cmzJtoomaoC0UtKyFpAT
         NMRO6vn8CW9v7eSRNN23liU1bwsMkBhdB2ZC6Z8vpfENAysOIvN9GYRSrTb4A+hlyB8s
         wyxw==
X-Gm-Message-State: ABy/qLZDaDpWZSjfo952sWpKO1VOzFyBFq2vfsLJv3oo8KfWSWiimV/D
        pZep5DODDklVqYWmVFfu3g==
X-Google-Smtp-Source: APBJJlEwpCn38iv9tGhrnrnRZNdeny56jS4GeSg/y1spExD6DCQAepba72GgW14TRDqilD0Y6vUlXA==
X-Received: by 2002:a92:d44b:0:b0:346:3193:224d with SMTP id r11-20020a92d44b000000b003463193224dmr5476204ilm.5.1689356462577;
        Fri, 14 Jul 2023 10:41:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k18-20020a02ccd2000000b0042b4e2fc546sm2673897jaq.140.2023.07.14.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:41:01 -0700 (PDT)
Received: (nullmailer pid 4041135 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] bluetooth: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:57 -0600
Message-Id: <20230714174057.4041063-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bluetooth/btmtkuart.c | 1 -
 drivers/bluetooth/hci_h5.c    | 2 +-
 drivers/bluetooth/hci_qca.c   | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 7680c67cdb35..935feab815d9 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fefc37b98b4a..71e748a9477e 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,7 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e30c979535b1..dcab942fa5a2 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,7 +25,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-- 
2.40.1

