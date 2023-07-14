Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4393775419C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjGNRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbjGNRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:54:09 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66274230;
        Fri, 14 Jul 2023 10:53:39 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7835e5fa459so86410339f.2;
        Fri, 14 Jul 2023 10:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357152; x=1691949152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv02JEaSetiMoGcjvutpVPJ1bAGUsaX2wWmNyw9UVsI=;
        b=dXaMKN5sjrXG/xA72JaXiAlcLPpGBI0eyru9Cv0zUhwvp93EeQqKzvA3fv8c5bMGTd
         CI8HbpZPW8fxp79cVjtB6vPzU/HI/C+im1XSephVTh8ndo8GlgserXD3wCO1qXThbX1m
         t8vOgdXkLNlynehct01LS40H1t0OsTQ4qPVIEpi38Mg2HwwxMMHh25BwnxjBNtYCSx7N
         4Fb4t+rcqtWyd6q+mEqtIXkCUMGlSrQmm191lgIgmsqDxnxhynvXIRw245tzUMaeZ6B9
         CssRBMv1ey/YzsD1KWDGFuhk0llfd6O7F8Vh2MRz7RVCDKf4zhkzS34XZwbu+V7sNTN5
         0w8w==
X-Gm-Message-State: ABy/qLb5VGAJBBAwH7jFDSW7Qiz8zgG0PibQultt02Ujmod6xkksdkUU
        Z0oSlt2EFwh1FLELFlDQidsa3isVN2xQ
X-Google-Smtp-Source: APBJJlHlFyLcOcjZDaoM+vIiR2ZLYTj+Zrybwn9zV7IFM8HpFFGTgt9zQntMiozjjQUoBc6LlqpsTw==
X-Received: by 2002:a5d:9b0d:0:b0:785:d4f5:2225 with SMTP id y13-20020a5d9b0d000000b00785d4f52225mr5291005ion.19.1689357152673;
        Fri, 14 Jul 2023 10:52:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v21-20020a5ec115000000b0077e35ffac2fsm2790121iol.32.2023.07.14.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:31 -0700 (PDT)
Received: (nullmailer pid 4068003 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: rockchip: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:43 -0600
Message-Id: <20230714175143.4067918-1-robh@kernel.org>
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
 drivers/soc/rockchip/grf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 15a3970e3509..30203ec447e5 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -7,7 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-- 
2.40.1

