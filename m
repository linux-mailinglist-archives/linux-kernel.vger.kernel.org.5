Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957775416D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbjGNRyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbjGNRxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:52 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCB44211;
        Fri, 14 Jul 2023 10:53:24 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-783546553ddso86078739f.0;
        Fri, 14 Jul 2023 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357140; x=1691949140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QClPpmwO/HygdGxUVkymGnsqhcX8BPsEQP+ZwgNTHR4=;
        b=GD/EOlhc5OOieCNzgQHAOadosFH3KoAzLDsTCMVE0aS5qhH5LLiIVb6Q3uYXGnRJIO
         VA4zwj6ytl/ND+fheywmjLuihJxXEUINalTDESuM2dNI+J4zqrT8rfc0q71khcnGFubK
         vx7vdkh7FRXXZeIZKfVSjTH9YbW1+MAe0uf2nRKJdITfyTEBWgkbpdgAZUfTCywykKtI
         vrVgt7bJattukuCNBot8WMlmNjww9KzQr04zcsJ9BroR0bGyeDQKQ4OJBjD3XZmI0gMC
         YMD9k3dwdx7ZK5hZ9oWQIEvkwtITGe54u5lQxACDnhZDtVwAt9+0Cg33i95tDadzlmod
         kXHw==
X-Gm-Message-State: ABy/qLYk1JXgptwL6tDsqY35AG04iXDcWE4v66G3K1id0F1AOedGxes9
        eo6rnbvUpUkb01xhYrxYbA==
X-Google-Smtp-Source: APBJJlEvmL5NlRfRa0C6Y6D6PT9e8Y80cl3usL+VRWP5Up+KiFH8kjMIsYgswwlSCtRa44TIyZTbIQ==
X-Received: by 2002:a05:6e02:80c:b0:340:79ff:c1b6 with SMTP id u12-20020a056e02080c00b0034079ffc1b6mr5166464ilm.4.1689357140597;
        Fri, 14 Jul 2023 10:52:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m22-20020a02c896000000b0042b56b57a50sm2614585jao.171.2023.07.14.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:19 -0700 (PDT)
Received: (nullmailer pid 4068370 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: sunxi: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:51 -0600
Message-Id: <20230714175152.4068286-1-robh@kernel.org>
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
 drivers/soc/sunxi/sun20i-ppu.c | 2 +-
 drivers/soc/sunxi/sunxi_sram.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/soc/sunxi/sun20i-ppu.c
index 98cb41d36560..8700f9dd5f75 100644
--- a/drivers/soc/sunxi/sun20i-ppu.c
+++ b/drivers/soc/sunxi/sun20i-ppu.c
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reset.h>
diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4c4864cd2342..4458b2e0562b 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-- 
2.40.1

