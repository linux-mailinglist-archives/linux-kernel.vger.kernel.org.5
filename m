Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB17C41EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjJJU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJJU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3838F;
        Tue, 10 Oct 2023 13:56:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A61C433C7;
        Tue, 10 Oct 2023 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696971408;
        bh=y2fTlo3zezzxE1nBSUjqMG6g4xIuKutp9SXd4X2X+Kc=;
        h=From:To:Cc:Subject:Date:From;
        b=utaB4KpVk23rFwgM5Yy71oSXCTNJZgBsgCHOmI/kMUozWzGChFLGVrgvgXd/pgroz
         Wv8vhfa30/p3Wu1iyvuqIGF1Iy6SjJO1f3SIte3MA1j+YBRt+G/Nte5kGsKUuB1NNv
         rlyzwmDTSkMFoOA8xMd6OIxALCxY0GwTfoU2OI//6MrWhs/lAmf4CwyTn+7QlWawkv
         oDE81a1K1aRJJQ6r+Ur6ON5qCyChjn7Kpt26xNCCL5o7yhmmc0VLxzH5DqRH3jd5nZ
         UGgB+0V7FnC9nbMk7OhafqmeP+OXDUJG0jBxje/5ne8EXrmmPWSera9QsLojLRih8w
         in4WKa/SfYjQA==
Received: (nullmailer pid 1584728 invoked by uid 1000);
        Tue, 10 Oct 2023 20:56:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: marvell_gti: Replace of_platform.h with explicit includes
Date:   Tue, 10 Oct 2023 15:56:36 -0500
Message-ID: <20231010205636.1584480-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

of_platform.h isn't needed, but of.h was implicitly included by it (via
of_device.h).

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note this was added in the merge window and missed the last round.
---
 drivers/watchdog/marvell_gti_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
index d7eb8286e11e..01e9177cbf20 100644
--- a/drivers/watchdog/marvell_gti_wdt.c
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -8,8 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/watchdog.h>
 
 /*
-- 
2.42.0

