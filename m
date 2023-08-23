Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB7785E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjHWRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjHWRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492710C1;
        Wed, 23 Aug 2023 10:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFBAA63986;
        Wed, 23 Aug 2023 17:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8682DC433C7;
        Wed, 23 Aug 2023 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692810298;
        bh=GXvD77XTaP2qkGbTvhgKUp5FtOuSXwU1zkqXZiEQM1s=;
        h=From:To:Cc:Subject:Date:From;
        b=WE09yDkO6iIhcAp2WHThhSYB7H8IMd2eQfdEw2iUhuhdQpqr+S/kXh5PPm3ZdY/5Y
         WzCxFD2LInrIallH95GeSk+cFXoMCumMaADMYe1ZhgeKfzNSZvHXm0lT8LkamMC2pF
         HEkIO1R0EzdQeO4zFh6vFPbvILJCqDnY3JtjRcCmwBsorE8ot1RJl8Yn4Cys43DloO
         pManHR3Tz2dpEX/TZq5ArSESreRJkTk6VLXK3q52ytqLWX6UYXrlBwUuZtDzt80Rse
         6Rx4+s1kqLwidpB/kgjrAwTLa7oSSfzKklCIaR2LTmMB7lw8tNPmNGCOLbyuqkMLvD
         ZB1aSsWoYOwGQ==
Received: (nullmailer pid 2491505 invoked by uid 1000);
        Wed, 23 Aug 2023 17:04:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2] genpd: Explicitly include correct DT includes
Date:   Wed, 23 Aug 2023 12:04:37 -0500
Message-Id: <20230823170438.2489746-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: Previously sent for drivers/soc/. Gathered up files which got moved
    to genpd to new patch.
---
 drivers/genpd/mediatek/mtk-pm-domains.c | 2 +-
 drivers/genpd/mediatek/mtk-scpsys.c     | 2 +-
 drivers/genpd/sunxi/sun20i-ppu.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/genpd/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
index 354249cc1b12..ee962804b830 100644
--- a/drivers/genpd/mediatek/mtk-pm-domains.c
+++ b/drivers/genpd/mediatek/mtk-pm-domains.c
@@ -8,8 +8,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/of_clk.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
diff --git a/drivers/genpd/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
index 7a668888111c..b374d01fdac7 100644
--- a/drivers/genpd/mediatek/mtk-scpsys.c
+++ b/drivers/genpd/mediatek/mtk-scpsys.c
@@ -7,7 +7,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/genpd/sunxi/sun20i-ppu.c b/drivers/genpd/sunxi/sun20i-ppu.c
index 98cb41d36560..8700f9dd5f75 100644
--- a/drivers/genpd/sunxi/sun20i-ppu.c
+++ b/drivers/genpd/sunxi/sun20i-ppu.c
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reset.h>
-- 
2.40.1

