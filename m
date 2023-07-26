Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1276361A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGZMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjGZMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D61BC6;
        Wed, 26 Jul 2023 05:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3F261ACF;
        Wed, 26 Jul 2023 12:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6ADC433C8;
        Wed, 26 Jul 2023 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690373871;
        bh=MJ3VIkhQnMh5rNijTgWqzXJXA8gGbxk68w2PW2c6Pkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzJ2nQcMu3Af2DEDqCGLRiELzCmojsPQvlIEvOS0YSr7vv5hCw/Z+BbxlK9Q4Qvrn
         s/QzQ8fudtXr0fNIv0rw6CZcO1jpN6WtHBhbZHfxnh+t+H904/yIEZ2ftOjG9aSarE
         zhc+1u/XbLYoeRVBDoEho9IBZCI53bSVNDUHTuNMAKI1+xRkhpskUNZ4Q3H+MTQTYI
         yXGEHlHI6/uNMJ7037RircF1nF1XV9mmCo2ax/j0QDMHuUlXEtGV7QKBFHIVqmIGLd
         fEPiN55RLGB/gJitKRgdm8VZC3bW1+FqFGv+VOL6HCzQ4mho7G1EhoIgvI/13msSiS
         SwOpcbHXwVhBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH 2/2] genpd: move owl-sps-helper.c from drivers/soc
Date:   Wed, 26 Jul 2023 14:17:15 +0200
Message-Id: <20230726121724.3701240-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726121724.3701240-1-arnd@kernel.org>
References: <20230726121724.3701240-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Moving only one of the two files in drivers/soc/actions to drivers/genpd
caused a link failure in allmodconfig, as drivers/genpd is entered
for compile testing, but drivers/soc/actions accidentally got skipped:

x86_64-linux-gnu-ld: vmlinux.o: in function `owl_sps_set_power':
owl-sps.c:(.text+0x16e259d): undefined reference to `owl_sps_set_pg'

Move the other one as well to allow build testing to work correctly.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/genpd/actions/Makefile                  | 1 +
 drivers/{soc => genpd}/actions/owl-sps-helper.c | 0
 drivers/soc/Makefile                            | 1 -
 drivers/soc/actions/Makefile                    | 3 ---
 4 files changed, 1 insertion(+), 4 deletions(-)
 rename drivers/{soc => genpd}/actions/owl-sps-helper.c (100%)
 delete mode 100644 drivers/soc/actions/Makefile

diff --git a/drivers/genpd/actions/Makefile b/drivers/genpd/actions/Makefile
index e78c420a24540..7e8aa473d12d1 100644
--- a/drivers/genpd/actions/Makefile
+++ b/drivers/genpd/actions/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
+obj-$(CONFIG_OWL_PM_DOMAINS_HELPER)	+= owl-sps-helper.o
 obj-$(CONFIG_OWL_PM_DOMAINS)		+= owl-sps.o
diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/genpd/actions/owl-sps-helper.c
similarity index 100%
rename from drivers/soc/actions/owl-sps-helper.c
rename to drivers/genpd/actions/owl-sps-helper.c
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index efdcd42f68cb3..708eaad8f590d 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
-obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
deleted file mode 100644
index 4ac88fec2050a..0000000000000
--- a/drivers/soc/actions/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
-- 
2.39.2

