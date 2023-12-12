Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C160B80EF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376942AbjLLOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376904AbjLLOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C890EA;
        Tue, 12 Dec 2023 06:44:24 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uw1i6E31Oq9foJm9vRTffEuxJYls4MdVg/tjhnHDdQA=;
        b=c3H7k2d7F6hek9v1ldMpiUXDPX/ViQj9jz2RMYbTVWbdlbmdMMmzawUMUDOwYWM1aILQHk
        h3SKLsk9WaGspCe6gGRrCu4NzVgTjJ0b9t9CLOvtA1j84VwwC46p+QqkXhYf2QfiDZoXYZ
        Hv3DOqtlEWwtwoRQAU5PM2XGnrKQdnPrnUCovCSzpwj7ThSCZxqK03s1PR/oup0WReBv4W
        DyAddTLMwy9J7Ssty3VXnt1MBK9d8PCWYCd31CaQwDhmhWt0iG7EaHYBlOjOZy/69a5jE4
        nLIZf8hIxUXr047aGH2Y2S54+zcgGzYMBtdGcBLvPh6SESYATtiJP3qREHGWVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uw1i6E31Oq9foJm9vRTffEuxJYls4MdVg/tjhnHDdQA=;
        b=gd+G3bx3PVf/adOv0pq/FiSdn4rmS+09xloyxh8NMUyAP+D6TL2ODdyGR+3TyewyW26Ej9
        yG53V+Wi2RPGz/Dg==
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
Message-ID: <170239226209.398.11711507811402945428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     74d2ef5f6f4b2437e6292ab2502400e8048db4aa
Gitweb:        https://git.kernel.org/tip/74d2ef5f6f4b2437e6292ab2502400e8048=
db4aa
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

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
