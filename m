Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD475413E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjGNRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjGNRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:35 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE863C22;
        Fri, 14 Jul 2023 10:47:12 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-34617b29276so8041585ab.0;
        Fri, 14 Jul 2023 10:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356779; x=1691948779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD0GCzyHwk+fw3TWcRW0UAKm/GOePKzWL5Rq+E6gtqA=;
        b=HQrAw6ViQ2VAF1n8xOzf0Eru8ihbzKVn3176kKoUY+EmowWvwx9kTFcqS8I/CfsfO5
         JJXduJgOvAyn53B2W67rwSciaqq1hvIe16CshqRAK/BENjerudj1OLKwWPpP6HwuBGB1
         rK1VYTdmkL4jYEwPWvOru3LezoIMUW2vMxVjG7lk4wImu4zBTc7+6emaYzAGORsg/eQh
         Vl9ntBKWJznh7Le2yFP9yQQHZQiSychY9BNKw5QLQB0k7Z0eeUyo7v7k09LLr7u+eNMx
         X1GRKDf31eoYSbNEig6TOIu3GL+NlAbwydGul8KIFFah9UlzE8UZa9NXb4seSkXAy+GY
         HcwQ==
X-Gm-Message-State: ABy/qLaIw8+nIn2NdhlaOC/BWIDEVkhwxk+kL+6lmBdkOjlHVa06sezm
        taTbHJu3sVHMNJRhiKa9iQ==
X-Google-Smtp-Source: APBJJlGBxsepro6zr7BfN9FfixRTKcjjtT51R7lFNo9G+WBwzHvg0MWW6tHrd3VzejdbK6RBfp0xFw==
X-Received: by 2002:a05:6e02:e0e:b0:33e:51bf:727d with SMTP id a14-20020a056e020e0e00b0033e51bf727dmr2417113ilk.10.1689356779202;
        Fri, 14 Jul 2023 10:46:19 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j3-20020a02cc63000000b0042bb2448847sm2620708jaq.53.2023.07.14.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:18 -0700 (PDT)
Received: (nullmailer pid 4057142 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hte: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:00 -0600
Message-Id: <20230714174600.4057041-1-robh@kernel.org>
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
 drivers/hte/hte-tegra194.c | 1 -
 drivers/hte/hte.c          | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 06ef349a2265..6fe6897047ac 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -12,7 +12,6 @@
 #include <linux/stat.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/hte.h>
 #include <linux/uaccess.h>
diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 67c15724ee78..598a716b7364 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -10,12 +10,12 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mutex.h>
 #include <linux/uaccess.h>
 #include <linux/hte.h>
 #include <linux/delay.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 
 #define HTE_TS_NAME_LEN		10
 
-- 
2.40.1

