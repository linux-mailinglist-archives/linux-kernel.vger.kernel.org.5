Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C6804ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjLEJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjLEJz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:26 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FDC1A7;
        Tue,  5 Dec 2023 01:55:32 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 153D61C050D;
        Tue,  5 Dec 2023 18:46:15 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Bin Meng <bmeng@tinylab.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Tom Rix <trix@redhat.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v5 07/37] sh: Fix COMMON_CLK support in CONFIG_OF=y.
Date:   Tue,  5 Dec 2023 18:45:26 +0900
Message-Id: <2bf3ae9e8b48d86acc771656ed7eb6a0ee9613ea.1701768028.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the clock and timer using the COMMON_CLK procedure.
sh's earlytimer mechanism doesn't work properly in OF,
so timer initialization is delayed.
If CONFIG_OF=y, perform the general timer initialization procedure.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c | 28 ++++------------------------
 arch/sh/kernel/time.c       | 12 ++++++++++++
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b..f1ca5a914c11 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <asm/machvec.h>
@@ -98,16 +99,7 @@ static void sh_of_smp_probe(void)
 
 #endif
 
-static void noop(void)
-{
-}
-
-static int noopi(void)
-{
-	return 0;
-}
-
-static void __init sh_of_mem_reserve(void)
+static void __init sh_of_mem_init(void)
 {
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -140,25 +132,13 @@ static void __init sh_of_init_irq(void)
 	irqchip_init();
 }
 
-static int __init sh_of_clk_init(void)
-{
-#ifdef CONFIG_COMMON_CLK
-	/* Disabled pending move to COMMON_CLK framework. */
-	pr_info("SH generic board support: scanning for clk providers\n");
-	of_clk_init(NULL);
-#endif
-	return 0;
-}
-
 static struct sh_machine_vector __initmv sh_of_generic_mv = {
 	.mv_setup	= sh_of_setup,
 	.mv_name	= "devicetree", /* replaced by DT root's model */
 	.mv_irq_demux	= sh_of_irq_demux,
 	.mv_init_irq	= sh_of_init_irq,
-	.mv_clk_init	= sh_of_clk_init,
-	.mv_mode_pins	= noopi,
-	.mv_mem_init	= noop,
-	.mv_mem_reserve	= sh_of_mem_reserve,
+	.mv_mode_pins	= generic_mode_pins,
+	.mv_mem_init	= sh_of_mem_init,
 };
 
 struct sh_clk_ops;
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 821a09cbd605..ce5b7c2f8628 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -19,7 +19,9 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 #include <asm/platform_early.h>
+#include <linux/of_clk.h>
 
+#ifndef CONFIG_SH_DEVICE_TREE
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -43,3 +45,13 @@ void __init time_init(void)
 
 	late_time_init = sh_late_time_init;
 }
+#else
+/* CONFIG_SH_DEVICE_TREE */
+void __init time_init(void)
+{
+	pr_info("SH generic board support: scanning for clk providers\n");
+
+	of_clk_init(NULL);
+	timer_probe();
+}
+#endif
-- 
2.39.2

