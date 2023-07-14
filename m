Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AFF7541BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjGNRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbjGNRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:07 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BBF3A95;
        Fri, 14 Jul 2023 10:52:44 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3461053677eso4994085ab.0;
        Fri, 14 Jul 2023 10:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357088; x=1691949088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wIArphUUcrQTlGd9RIfHKu8moYjSLk6R16YZHfHviw=;
        b=NTCRsad49bLrXdyuikSeGykEXMxrLMIPpqWu3VNTBblocDWb/SHipvdbvlpjzM12oa
         MkYvfrP7M5qdOQdUibJCzl+pawec2x5j2EwWBYETa3ldccqu7s/miH2n6brq4uF97EJy
         S8NR4TKi1EseLi5p/kmR/bWqq4O7tuGxLDFCryrgFYbBr4EOhM0UamQjGh/tcDPyAflz
         6yoR6agL3B+e/jQVv32BLdhmMinXQ+h7EtR7ZthUTVt3/1P/bMsCjGARKv4FCKc36Um0
         7v63xL23XnXyRsLupNjkGSYRMrhiwXjJl8MzyhrvdUKExOFTow6QQ73ElMQRMqtpZ2cR
         5NLA==
X-Gm-Message-State: ABy/qLY6Gbc8g+0hsK49SG+0dIIUcQVNwxoA8rR4zpoThiIvp8fJN+QW
        xhB135bfbekVXZ9fDSNqYMH9pM3DSO3F
X-Google-Smtp-Source: APBJJlEHfIxZJ0bPAvnN517DQfltLqPlRzXi9YGaDUls0sT+OG8W9oV02M0oDWythG0eSZqH+72VBw==
X-Received: by 2002:a05:6e02:782:b0:346:3b4:8b77 with SMTP id q2-20020a056e02078200b0034603b48b77mr2452111ils.12.1689357088535;
        Fri, 14 Jul 2023 10:51:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 18-20020a92c652000000b00345ffd35a29sm2913154ill.68.2023.07.14.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:27 -0700 (PDT)
Received: (nullmailer pid 4066254 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:52 -0600
Message-Id: <20230714175052.4066150-1-robh@kernel.org>
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
 drivers/scsi/qlogicpti.c | 2 +-
 drivers/scsi/sun_esp.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 1e8fbd457248..f88a5421c483 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -28,7 +28,7 @@
 #include <linux/jiffies.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/firmware.h>
 #include <linux/pgtable.h>
 
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index d06e933191a2..afa9d02a33ec 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -12,7 +12,8 @@
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/gfp.h>
 
 #include <asm/irq.h>
-- 
2.40.1

