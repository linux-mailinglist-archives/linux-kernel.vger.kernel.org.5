Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62F7BC25E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjJFWq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJFWq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:46:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1FFF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:46:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10857C433C8;
        Fri,  6 Oct 2023 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632410;
        bh=cfavBs2NTtCHh0kAyRc1/xupXHi4WKMdtxsoqtdyOWI=;
        h=From:To:Cc:Subject:Date:From;
        b=ONmsp8YV74IXZjW+Oq8zm3rJ971/oUbVuKAVC8hhouGey/N3ZLxn94lhefwSG0kuP
         ysLgugF4IVeOib9utIst8/7/IKnWJQX/XpIOq3ilVdeQm2g/L51WBQXFsmeY15tAb8
         iv6Cxv/fnqzxWvaOdXXAUjg0rZoiUNEoYdhKVw8mjrF5rRNEfx3i3eIUReyKuT98P7
         Rm2Gkoy+LaQpKfrFkpro5m9V/TP8PhC5+uSRKM0+rtloWBjwrzNATAUTs7fM1Cj4lc
         hnnlQL0h9pgxZKsD2dPxFfAPKNMPnzOJIq7M3jvjQvZ/dMljrB36/tp/5yulP4f4OX
         Rtv1xsQyeCrog==
Received: (nullmailer pid 445379 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: meson: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:44 -0500
Message-Id: <20231006224644.445295-1-robh@kernel.org>
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

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/firmware/meson/meson_sm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 53bf56e18743..ed60f1103053 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -13,9 +13,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/property.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
  #include <linux/slab.h>
@@ -297,7 +298,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 	if (!fw)
 		return -ENOMEM;
 
-	chip = of_match_device(meson_sm_ids, dev)->data;
+	chip = device_get_match_data(dev);
 	if (!chip)
 		return -EINVAL;
 
-- 
2.40.1

