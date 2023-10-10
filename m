Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11867C4242
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjJJVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJJVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:19:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2C91;
        Tue, 10 Oct 2023 14:19:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4C8C433C8;
        Tue, 10 Oct 2023 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696972786;
        bh=tv+SdkjqpYQgC1sYY9ll+xrYyN/dRUYD6fdO3FdTVo8=;
        h=From:To:Cc:Subject:Date:From;
        b=HGTf4XPP2tqFuTMmW4HxGXswGbpGvdXEKcAUwkZpuHCIhwN8/LH+5+e0zcjwINXt5
         VgF0YGWLc+SEuQpXvx4aLd4MLUCmv0YW95sdKnw0tUuO1KS2SBMylyYjAA5ke8BYpA
         +zxwwxnr9BnNShiRfGG4Kq2A7RkHTxMYGxhOdqWambM6stDzVgTZDNsRVUpz9Q0H0t
         BVj7TFScb/x+N9rH7Mu7chvsGtmReTk2E5VTXabeoFlI08O7DgRw5RhQYAuPVxwR9g
         Zr0iBd/P6D+DhV7CJGA31FL/090XM3bE9r4pchPWfksE3lrpBH0nGt8JPHWZvVkCws
         oDApV+vhY3eXg==
Received: (nullmailer pid 1630047 invoked by uid 1000);
        Tue, 10 Oct 2023 21:19:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
Date:   Tue, 10 Oct 2023 16:19:25 -0500
Message-ID: <20231010211925.1629653-1-robh@kernel.org>
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

DT overlays in tree need to be applied to a base DTB to validate they
apply, to run schema checks on them, and to catch any errors at compile
time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Only test applying overlays when building all DTBs
---
 arch/arm/boot/dts/ti/omap/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index d2b590004fed..d6ee4a247100 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -129,6 +129,16 @@ dtb-$(CONFIG_SOC_AM43XX) += \
 am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
 am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
 
+am571x-idk-overlays-dtbs := am571x-idk.dtb \
+	am571x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2587.dtbo
+am572x-idk-overlays-dtbs := am572x-idk.dtb \
+	am572x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2045.dtbo
+
+# Build time test only, enabled by CONFIG_OF_ALL_DTBS
+dtb- += \
+	am571x-idk-overlays.dtb \
+	am572x-idk-overlays.dtb
+
 dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-beagle-x15-revb1.dtb \
-- 
2.42.0

