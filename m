Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9F7BEC92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378714AbjJIVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378745AbjJIVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3D182;
        Mon,  9 Oct 2023 14:14:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B08C433CA;
        Mon,  9 Oct 2023 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886069;
        bh=dIK0eztLKLhOrJx/1hv/oFxFtwcERv2fSJBqJLVAAEE=;
        h=From:To:Cc:Subject:Date:From;
        b=DecivvvwvlMRjoXnCEQrTvTknYTc7SczXSJvD0ipc6a6lbAbEtsyPBIAv4cMcUQd4
         sVJxODgiIlIpGNzcpyz7LZ0JIXdMQ+Sx1sTxk18RPwHH9fYyPgtN/+YHMP9MS4YZHE
         w8JftZD+GXJIxiHEfNWFf/xahDskYHvvEJyOwDurwDdP2RZ4KrWSEKlRPP0cfpdoHC
         WPvRMAYcSqvMlm1Ce8BUYH3kp0GIzUKktU3NL8lVFi8GhGsjQV5fb3pjLLhuq7VdEv
         oPkpxgWQXO4OPKeblCdcWgu2Yc/WT+1BYYUgjJ0qav3tFWe2v+So5/vMj5ipQsMg8k
         3ST+eTMeNF6fw==
Received: (nullmailer pid 3246395 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: loongson2: Replace of_device.h with explicit includes
Date:   Mon,  9 Oct 2023 16:13:45 -0500
Message-ID: <20231009211356.3242037-15-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h.

of_device.h isn't needed, but mod_devicetable.h and property.h were
implicitly included.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/loongson2_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 133098dc0854..644596f5e3bb 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -8,9 +8,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
 #include "thermal_hwmon.h"
-- 
2.42.0

