Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED770764359
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjG0BUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjG0BUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53E270D;
        Wed, 26 Jul 2023 18:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087AB61CE6;
        Thu, 27 Jul 2023 01:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD960C433C7;
        Thu, 27 Jul 2023 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690420839;
        bh=bhYIh3I6f7DBUF2htKEWd8dZyZSV5Xi6cSevrpqNDk8=;
        h=From:To:Cc:Subject:Date:From;
        b=ViqDEbnzvlMulRQfILhSR/+xaRNYrotnpZeDOO5g9CHRiTYKKerU9DEgP300EN+Yu
         7uyIP+oMRLnVchutmkJ/ceQRuXiBSF3mSkN1vQ93X2RrqwIl2YugyD7J1zGwtYAPr5
         l6cFlbH9sqjbfPcziYzzyMVH+PEuLOxrvNW7iHSlMPu6qwXp3ZZRxlijfKSM+jVJR3
         D142QeZqvFPp6ypoOZjnLqXD/4OZQR8ZBmN6XWH+E7F4qQCzIs3t+1ua8Y9hXBUmVR
         Hm6yWsOnUwvRqN+D1B4gQLwlwBcJ8FNTqBPYzmUWdI86gwdpRa96d+mD/bMiJQvl1B
         LSDx9H6tS2v2Q==
Received: (nullmailer pid 3933985 invoked by uid 1000);
        Thu, 27 Jul 2023 01:20:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fixup explicit DT include clean-up
Date:   Wed, 26 Jul 2023 19:20:28 -0600
Message-Id: <20230727012028.3933785-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 657c45b303f87d77 ("MIPS: Explicitly include correct DT includes")
removed a necessary include by mistake and missed adding an explicit
include of spinlock.h (from of.h -> kobject.h -> spinlock.h).

Fixes: 657c45b303f87d77 ("MIPS: Explicitly include correct DT includes")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/lantiq/xway/gptu.c       | 1 +
 arch/mips/pic32/pic32mzda/config.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index e254b108fb9b..8d52001301de 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -9,6 +9,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
diff --git a/arch/mips/pic32/pic32mzda/config.c b/arch/mips/pic32/pic32mzda/config.c
index 6e94ae66eba8..73be5689e0df 100644
--- a/arch/mips/pic32/pic32mzda/config.c
+++ b/arch/mips/pic32/pic32mzda/config.c
@@ -5,6 +5,7 @@
  */
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 
 #include <asm/mach-pic32/pic32.h>
 
-- 
2.40.1

