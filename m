Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E8754124
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjGNRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjGNRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:27 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8953AB5;
        Fri, 14 Jul 2023 10:47:00 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-78666f06691so88274039f.0;
        Fri, 14 Jul 2023 10:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356757; x=1691948757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASjrxMFGfI2mQtSCo+tL5VWD7Mqm7tMyxd3We8wcpHw=;
        b=WoUt32GyMkc/4F9zeZohGtiyFl4tzAJWDPu60bbfx29rqG6b2XTZhqLibHGgGR1lE4
         rDNtP+BDPARI8NfK9O1XivOyAPx1w+WyIwSPa2udKD0iz56v820BlUj0kyhcLqWUrLm/
         iGl9cmBM3lbnDt1TFv8YXH/7GJRgeNAqCkKRHi5XPR+jS2TUL2G6IFUh82NnSxEU5DbV
         iEX4rYpDpREn2FUs03MNOoKPRkIONiaiak7BnFejwHlRshfeCXnyfAQiHBFf6OpVOo1d
         YGNlgBH9Oi6aP5thz+t4OJv1INZqnKd8MBIUMk+jUIg1I3fAmSBHLYiSNyu7BRiFMw0D
         VdqQ==
X-Gm-Message-State: ABy/qLb1pz/xrwp6zdYlquxcBHejGankgJ6CEAhpLu2CD7/Cb+esbbUE
        AV3uVDCvaK4aU2FSkICq00XVlyx6iQ==
X-Google-Smtp-Source: APBJJlHuso8S9Bt7JOE/amuqp1QRpWb0gkLH6g4sDyXSdQBCVP4PpFjXy2a6cRQm/j9Ech1mQSqMHw==
X-Received: by 2002:a6b:760e:0:b0:787:f94:5133 with SMTP id g14-20020a6b760e000000b007870f945133mr4910825iom.2.1689356757494;
        Fri, 14 Jul 2023 10:45:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a056638022800b0042b2959e6dcsm2716939jaq.87.2023.07.14.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:45:56 -0700 (PDT)
Received: (nullmailer pid 4056808 invoked by uid 1000);
        Fri, 14 Jul 2023 17:45:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/host1x: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:45:49 -0600
Message-Id: <20230714174549.4056675-1-robh@kernel.org>
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
 drivers/gpu/host1x/context.c | 2 +-
 drivers/gpu/host1x/dev.c     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 9ad89d22c0ca..c000d4e0c2c6 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -6,7 +6,7 @@
 #include <linux/device.h>
 #include <linux/kref.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/of_device.h>
 #include <linux/pid.h>
 #include <linux/slab.h>
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index aae2efeef503..7c6699aed7d2 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -11,8 +11,9 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-- 
2.40.1

