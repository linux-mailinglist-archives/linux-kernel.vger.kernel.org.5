Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64F75702E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGQXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22EEE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEC8612E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8817DC433C8;
        Mon, 17 Jul 2023 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634863;
        bh=suv5VAz59+JZPS+l5l8BcnOeZ3LJcgqq1/II6LQnwsw=;
        h=From:To:Cc:Subject:Date:From;
        b=B2mkXxHJPfmBrM5xpW8xGE5vtbVAK5lwyDPxwKA8Q/D5Ff3bwzU2OYWnOqatp+fS8
         Fd3cWLeAFgHpdULnyCoIUbjU9L5PD4zIT9MwuvQeJ9Nq+64ve5im11ZThSNqJrkzt1
         qlCTur7ZP2+/K/jh6hkbUDI4C7+giyvoUC5aUAdNZ96lecHOraU+L46vL53BPKcU6N
         eYTlQeydpyIZgvG4a2RSeT4wl/tKS+kQnhQM5/UVpJmY2QqDqYgW3qjNSFc1LHHBFN
         3eqlqFWhCZ/nKGt3Jlfd4sz+RmIitbiEXTSOKazgR+NLRdmU+eytQq/AvsIHrY5pDP
         flvVeLeIAxCrw==
Received: (nullmailer pid 3211508 invoked by uid 1000);
        Mon, 17 Jul 2023 22:54:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: at91: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 16:54:29 -0600
Message-Id: <20230717225429.3211307-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

A couple of other includes are unused and can be dropped too.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-at91/pm.c    | 1 +
 arch/arm/mach-at91/samv7.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 437dd0352fd4..1a26af0fabc7 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/parser.h>
 #include <linux/suspend.h>
 
diff --git a/arch/arm/mach-at91/samv7.c b/arch/arm/mach-at91/samv7.c
index 28f998f0fba5..22d00005ec09 100644
--- a/arch/arm/mach-at91/samv7.c
+++ b/arch/arm/mach-at91/samv7.c
@@ -5,14 +5,7 @@
  *  Copyright (C) 2013 Atmel,
  *                2016 Andras Szemzo <szemzo.andras@gmail.com>
  */
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/system_misc.h>
-#include "generic.h"
 
 static const char *const samv7_dt_board_compat[] __initconst = {
 	"atmel,samv7",
-- 
2.40.1

