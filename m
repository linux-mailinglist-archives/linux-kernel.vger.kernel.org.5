Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063A804F25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjLEJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjLEJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:55:27 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502FDAB;
        Tue,  5 Dec 2023 01:55:32 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 1C5C71C04DB;
        Tue,  5 Dec 2023 18:46:11 +0900 (JST)
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
Subject: [DO NOT MERGE v5 05/37] sh: GENERIC_IRQ_CHIP support for CONFIG_OF=y
Date:   Tue,  5 Dec 2023 18:45:24 +0900
Message-Id: <c875bbe153051f385fb02f4ed805b8215a48f09e.1701768028.git.ysato@users.sourceforge.jp>
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

Remove unused function prototype.
Add helper update_sr_imask. use for SH7751 irq driver.
Add stub intc_finalize.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/irq.h      | 10 ++++++++--
 arch/sh/kernel/cpu/Makefile    |  5 +----
 arch/sh/kernel/cpu/irq/imask.c | 17 +++++++++++++++++
 include/linux/sh_intc.h        |  7 ++++++-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 0f384b1f45ca..c3e3db793dba 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -16,8 +16,8 @@
 /*
  * Simple Mask Register Support
  */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
+
+void update_sr_imask(unsigned int irq, unsigned int enable);
 
 /*
  * PINT IRQs
@@ -54,4 +54,10 @@ extern void irq_finish(unsigned int irq);
 
 #include <asm-generic/irq.h>
 
+/* SH3/4 INTC stuff */
+/* IRL level 0 - 15 */
+#define NR_IRL 15
+/* IRL0 -> IRQ16 */
+#define IRL_BASE_IRQ	16
+
 #endif /* __ASM_SH_IRQ_H */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index e00ebf134985..ad12807fae9c 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -20,7 +20,4 @@ ifndef CONFIG_COMMON_CLK
 obj-y += clock.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 endif
-ifndef CONFIG_GENERIC_IRQ_CHIP
-obj-y	+= irq/
-endif
-obj-y	+= init.o fpu.o pfc.o proc.o
+obj-y	+= init.o fpu.o pfc.o proc.o irq/
diff --git a/arch/sh/kernel/cpu/irq/imask.c b/arch/sh/kernel/cpu/irq/imask.c
index 572585c3f2fd..d9a703715228 100644
--- a/arch/sh/kernel/cpu/irq/imask.c
+++ b/arch/sh/kernel/cpu/irq/imask.c
@@ -51,6 +51,7 @@ static inline void set_interrupt_registers(int ip)
 		     : "t");
 }
 
+#ifndef CONFIG_GENERIC_IRQ_CHIP
 static void mask_imask_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -83,3 +84,19 @@ void make_imask_irq(unsigned int irq)
 	irq_set_chip_and_handler_name(irq, &imask_irq_chip, handle_level_irq,
 				      "level");
 }
+#else
+void update_sr_imask(unsigned int irq, unsigned int enable)
+{
+	if (enable) {
+		set_bit(irq, imask_mask);
+		interrupt_priority = IMASK_PRIORITY -
+		  find_first_bit(imask_mask, IMASK_PRIORITY);
+	} else {
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+	}
+	set_interrupt_registers(interrupt_priority);
+}
+EXPORT_SYMBOL(update_sr_imask);
+#endif
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 27ae79191bdc..994b5b05a0d7 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -139,8 +139,13 @@ struct intc_desc symbol __initdata = {					\
 int register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 int intc_irq_lookup(const char *chipname, intc_enum enum_id);
+#ifndef CONFIG_SH_DEVICE_TREE
 void intc_finalize(void);
-
+#else
+static inline void intc_finalize(void)
+{
+}
+#endif
 #ifdef CONFIG_INTC_USERIMASK
 int register_intc_userimask(unsigned long addr);
 #else
-- 
2.39.2

