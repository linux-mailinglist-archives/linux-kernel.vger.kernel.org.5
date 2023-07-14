Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D03754194
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjGNRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjGNRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:54:39 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496133C19;
        Fri, 14 Jul 2023 10:54:05 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7837329a00aso86289339f.2;
        Fri, 14 Jul 2023 10:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357144; x=1691949144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io3SoxIDwBBBtJ6NlQcxe1pml6TSwvuGhow9OBf7DFQ=;
        b=XLW0leMDRxMIY4hmK0ASnA0qjHdm1xXf7PoayaGiWA6hSDPMCtMfshosjoH9Cz1wnr
         ViKVrZzVUMhI3qQGLbFBf0XMfqwk1788rTB2eTbKTQT5JKJJRnWGOTyGKXERn9iFTXxn
         lxsbXUFfHkvTlwNP2+OPOHSBIAuWf1PHcZq7l3iDpXk6AnXj8qFmzW/zmVDcR151QYSH
         cd7QOZNm+IRBn65sWq3V87qmapDadi32kZ9LPb0Wk4qeZ3BN1xX1bSkEtZrTBhf3RrY9
         +wMHjgYrNLMINW+1V/chziOxyhAbh8SqSozuWSPdp6tVmpk63gVocFt2cbMrdVqKb7Az
         Zhaw==
X-Gm-Message-State: ABy/qLazDw0Ffgm7jhEARm0zg6QiME4fYAgtAGCpjf/Ml403LNx6zbYx
        23ceJipqKh1dLmZG1e2KOw==
X-Google-Smtp-Source: APBJJlGmyru1MYM6MSTu5ZE/J/lQCSiiVZ9jYzx1cA3SB0/S5eCE6joc3Rk0ZpW7LKx5fHXF/XdhPA==
X-Received: by 2002:a6b:a04:0:b0:787:8d2:f15 with SMTP id z4-20020a6b0a04000000b0078708d20f15mr5261803ioi.8.1689357144472;
        Fri, 14 Jul 2023 10:52:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x1-20020a6bd001000000b0076c569c7a48sm2683663ioa.39.2023.07.14.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:23 -0700 (PDT)
Received: (nullmailer pid 4068747 invoked by uid 1000);
        Fri, 14 Jul 2023 17:52:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: xilinx: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:52:02 -0600
Message-Id: <20230714175202.4068684-1-robh@kernel.org>
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
 drivers/soc/xilinx/zynqmp_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 641dcc958911..913417506468 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -11,6 +11,7 @@
 
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
-- 
2.40.1

