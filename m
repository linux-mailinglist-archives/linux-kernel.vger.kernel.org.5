Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111B80AEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjLHVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHVOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F137A9;
        Fri,  8 Dec 2023 13:14:42 -0800 (PST)
Date:   Fri, 08 Dec 2023 21:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702070080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCi/Mb4RGKt7MjRjPCxk9N/2FIWc3BGybyWz2LsXcdc=;
        b=xFtvVsVCRNbwgkpmnfPj9xBWb7Tc6VYv30MG29Wjt1gJRw8GNYxNor2rMbcVMg8P4xIPRn
        FHGAD+N39SgXOnVBYYU/ZQWRrilm8PEgs21ryKETkjwHQgOFS2fY6vjD2Mzfo/7F2aWP4t
        0nPFmXRKUaqogks3g0NbFaE8xnhf28nXyaH7aPX21Dl2kdhyQ8zMVCZPmXd09LaTyRisal
        7ioq/I6sGRZXfEnifeO3bKkbHNQO2Obr05DcecxWE9N1U5MWYOvXEQMcMTUSOoyIvLz8JO
        0x3DbVGwehErosgf4T2zp3BVI3ZJ9ru0F6NAp+Twb+3k8rY4IIM3YEAjGWH+oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702070080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCi/Mb4RGKt7MjRjPCxk9N/2FIWc3BGybyWz2LsXcdc=;
        b=2l7lHMKFe/cN8vHoK4tYCzgrva/uA4VQTish9EvaHNI+3zD2vrd9D4CKOHYNZH5tkpW/jO
        vZA7NHws3KvSr1Cw==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Add support for suspend to RAM
Cc:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-8-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-8-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <170207008017.398.9006634586293096788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e1f581386680631316611d554e71523a087d8f58
Gitweb:        https://git.kernel.org/tip/e1f581386680631316611d554e71523a087=
d8f58
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00

irqchip/renesas-rzg2l: Add support for suspend to RAM

The irqchip-renesas-rzg2l driver is used on RZ/G3S SoC. RZ/G3S can go into
deep sleep states where power to different SoC's parts is cut off and RAM
is switched to self-refresh. The resume from these states is done with the
help of the bootloader.

The IA55 IRQ controller needs to be reconfigured when resuming from deep
sleep state. For this the IA55 registers are cached in suspend and restored
in resume.

The IA55 IRQ controller is connected to GPIO controller and GIC as follows:

                                      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90        =
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
                                      =E2=94=82          =E2=94=82 SPIX     =
=E2=94=82          =E2=94=82
                                      =E2=94=82          =E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=96=BA=E2=94=82          =E2=94=82
                                      =E2=94=82          =E2=94=82          =
=E2=94=82          =E2=94=82
                                      =E2=94=82          =E2=94=82          =
=E2=94=82          =E2=94=82
              =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90IRQ0-7        =E2=94=82  IA55    =E2=94=82        =
  =E2=94=82  GIC     =E2=94=82
 Pin0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=82
              =E2=94=82        =E2=94=82              =E2=94=82          =E2=
=94=82 PPIY     =E2=94=82          =E2=94=82
 ...          =E2=94=82  GPIO  =E2=94=82              =E2=94=82          =E2=
=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=96=BA=E2=94=82          =E2=94=82
              =E2=94=82        =E2=94=82GPIOINT0-127  =E2=94=82          =E2=
=94=82          =E2=94=82          =E2=94=82
 PinN =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=82
              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98     =
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98

where:
  - Pin0 is the first GPIO controller pin
  - PinN is the last GPIO controller pin

  - SPIX is the SPI interrupt with identifier X
  - PPIY is the PPI interrupt with identifier Y

Implement suspend/resume functionality with syscore_ops to be able to
cache/restore the registers after/before the GPIO controller suspend/resume
functions are invoked.

As the syscore_ops suspend/resume functions do not take any argument make
the driver private data static so it can be accessed from the
suspend/resume functions.

The IA55 interrupt controller is resumed before the GPIO controller. As
GPIO pins could be in an a state which causes spurious interrupts, the
reconfiguration of the interrupt controller is restricted to restore the
interrupt type and leave them disabled.

An eventually required interrupt enable operation will be done as part of
the GPIO controller resume function after restoring the GPIO state.

[ tglx: Massaged changelog ]

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231120111820.87398-8-claudiu.beznea.uj@bp.r=
enesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 68 +++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 34add75..9494fc2 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
=20
 #define IRQC_IRQ_START			1
 #define IRQC_IRQ_COUNT			8
@@ -56,16 +57,28 @@
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
=20
 /**
+ * struct rzg2l_irqc_reg_cache - registers cache (necessary for suspend/resu=
me)
+ * @iitsr: IITSR register
+ * @titsr: TITSR registers
+ */
+struct rzg2l_irqc_reg_cache {
+	u32	iitsr;
+	u32	titsr[2];
+};
+
+/**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @cache:	Registers cache for suspend/resume
  */
-struct rzg2l_irqc_priv {
+static struct rzg2l_irqc_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
-};
+	struct rzg2l_irqc_reg_cache	cache;
+} *rzg2l_irqc_data;
=20
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 {
@@ -246,6 +259,38 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsig=
ned int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
+static int rzg2l_irqc_irq_suspend(void)
+{
+	struct rzg2l_irqc_reg_cache *cache =3D &rzg2l_irqc_data->cache;
+	void __iomem *base =3D rzg2l_irqc_data->base;
+
+	cache->iitsr =3D readl_relaxed(base + IITSR);
+	for (u8 i =3D 0; i < 2; i++)
+		cache->titsr[i] =3D readl_relaxed(base + TITSR(i));
+
+	return 0;
+}
+
+static void rzg2l_irqc_irq_resume(void)
+{
+	struct rzg2l_irqc_reg_cache *cache =3D &rzg2l_irqc_data->cache;
+	void __iomem *base =3D rzg2l_irqc_data->base;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (u8 i =3D 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + TITSR(i));
+	writel_relaxed(cache->iitsr, base + IITSR);
+}
+
+static struct syscore_ops rzg2l_irqc_syscore_ops =3D {
+	.suspend	=3D rzg2l_irqc_irq_suspend,
+	.resume		=3D rzg2l_irqc_irq_resume,
+};
+
 static const struct irq_chip irqc_chip =3D {
 	.name			=3D "rzg2l-irqc",
 	.irq_eoi		=3D rzg2l_irqc_eoi,
@@ -331,7 +376,6 @@ static int rzg2l_irqc_init(struct device_node *node, stru=
ct device_node *parent)
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
-	struct rzg2l_irqc_priv *priv;
 	int ret;
=20
 	pdev =3D of_find_device_by_node(node);
@@ -344,15 +388,15 @@ static int rzg2l_irqc_init(struct device_node *node, st=
ruct device_node *parent)
 		return -ENODEV;
 	}
=20
-	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	rzg2l_irqc_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_=
KERNEL);
+	if (!rzg2l_irqc_data)
 		return -ENOMEM;
=20
-	priv->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, N=
ULL);
+	if (IS_ERR(rzg2l_irqc_data->base))
+		return PTR_ERR(rzg2l_irqc_data->base);
=20
-	ret =3D rzg2l_irqc_parse_interrupts(priv, node);
+	ret =3D rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
@@ -375,17 +419,19 @@ static int rzg2l_irqc_init(struct device_node *node, st=
ruct device_node *parent)
 		goto pm_disable;
 	}
=20
-	raw_spin_lock_init(&priv->lock);
+	raw_spin_lock_init(&rzg2l_irqc_data->lock);
=20
 	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
 					      node, &rzg2l_irqc_domain_ops,
-					      priv);
+					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
 		ret =3D -ENOMEM;
 		goto pm_put;
 	}
=20
+	register_syscore_ops(&rzg2l_irqc_syscore_ops);
+
 	return 0;
=20
 pm_put:
