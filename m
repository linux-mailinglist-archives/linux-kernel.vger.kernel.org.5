Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6575B59C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGTR2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGTR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0651BB;
        Thu, 20 Jul 2023 10:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA5361B56;
        Thu, 20 Jul 2023 17:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7CC433C8;
        Thu, 20 Jul 2023 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874077;
        bh=/dSw9RRh1DQ4XNaoDYE+OyLjB8iJNQDRrqTYbqT4Yis=;
        h=From:To:Cc:Subject:Date:From;
        b=Jbd660Y2/1ojZDUu2/xNrV+f1Ib5B8hROvrACVTRy1lJskDLmAW/KjPM1MxkMwkJp
         ML7ce3GkNCZDubDtwczc5pEct6L4HZ4fFZx5OMbqLUpi/iRmk6mRXK8euNYSgeifK1
         IBR+bodgfOt1AaLD1i9BWs+Rt1bYxEWPt85wWrQBEt0i++bp0CzlfTIywG6J2d/Ybi
         K1DruJnRE2GZianB+9/2quUSrpF2/teWxzVTqfLlGnSzK0LCatD3HTLQenBLcOMPNr
         2k7E3mVqX8ipQ7mDgjj7gIa/DzdZiypr/zgwS5YREWnGllBmhZNdhJFqRSsLtogz+1
         NzijiEjzDE25g==
Received: (nullmailer pid 2918876 invoked by uid 1000);
        Thu, 20 Jul 2023 17:27:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: s5pv210: Explicitly include correct DT includes
Date:   Thu, 20 Jul 2023 11:27:51 -0600
Message-Id: <20230720172751.2918776-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: Add missing Sob
---
 arch/arm/mach-s5pv210/s5pv210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index a21ed3bb992a..7d4a10184160 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -7,7 +7,7 @@
 // Tomasz Figa <t.figa@samsung.com>
 
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
2.40.1

