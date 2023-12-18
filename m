Return-Path: <linux-kernel+bounces-3031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C03816653
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C941F225E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C06FB5;
	Mon, 18 Dec 2023 06:13:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122A6D18;
	Mon, 18 Dec 2023 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1CE86806C;
	Mon, 18 Dec 2023 14:12:59 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 14:12:58 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Dec
 2023 14:12:55 +0800
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: <joshua.yeong@starfivetech.com>, <jeeheng.sia@starfivetech.com>,
	<leyfoon.tan@starfivetech.com>, <jassisinghbrar@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] mailbox: starfive: Add StarFive Meu Mailbox Driver
Date: Mon, 18 Dec 2023 14:11:59 +0800
Message-ID: <20231218061201.98136-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

This patch adds support for the StarFive Meu Mailbox driver. This enables
communication using mailbox doorbell between AP and SCP cores.

Co-developed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/mailbox/Kconfig        |  11 ++
 drivers/mailbox/Makefile       |   2 +
 drivers/mailbox/starfive-meu.c | 334 +++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 drivers/mailbox/starfive-meu.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index bc2e265cb02d..b5e38a50b3d5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -295,4 +295,15 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients=
.
 	  Say Y here if you want to build this driver.
=20
+config STARFIVE_MEU_MBOX
+	tristate "Starfive MEU Mailbox"
+	depends on OF
+	depends on SOC_STARFIVE || COMPILE_TEST
+	help
+	  Say Y here if you want to build the Starfive MEU mailbox controller
+	  driver.
+
+	  The StarFive mailbox controller has 2 channels. Each channel has a
+	  pair of Tx/Rx link and each link has 31 slots/doorbells.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..122cc691c256 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_SPRD_MBOX)		+=3D sprd-mailbox.o
 obj-$(CONFIG_QCOM_IPCC)		+=3D qcom-ipcc.o
=20
 obj-$(CONFIG_APPLE_MAILBOX)	+=3D apple-mailbox.o
+
+obj-$(CONFIG_STARFIVE_MEU_MBOX)	+=3D starfive-meu.o
diff --git a/drivers/mailbox/starfive-meu.c b/drivers/mailbox/starfive-me=
u.c
new file mode 100644
index 000000000000..cd439f8c474b
--- /dev/null
+++ b/drivers/mailbox/starfive-meu.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define CHAN_SET_OFFSET		0x0
+#define CHAN_TX_STAT_OFFSET	0x4
+#define CHAN_RX_STAT_OFFSET	0x8
+#define CHAN_CLR_OFFSET		0xc
+#define CHAN_RX_REG_OFFSET	0x40
+
+#define CHAN_RX_DOORBELL	GENMASK(30, 0)
+
+#define MEU0_OFFSET		0x4000
+#define MEU1_OFFSET		0x0
+
+#define MEU_CHANS_GROUP		2
+#define MEU_NUM_DOORBELLS	31
+#define MEU_TOTAL_CHANS		(MEU_CHANS_GROUP * MEU_NUM_DOORBELLS)
+
+struct meu_db_link {
+	unsigned int irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct starfive_meu {
+	void __iomem *base;
+	struct meu_db_link mlink[MEU_CHANS_GROUP];
+	struct mbox_controller mbox;
+	struct device *dev;
+};
+
+/**
+ * StarFive MEU Mailbox allocated channel information
+ *
+ * @meu: Pointer to parent mailbox device
+ * @pchan: Physical channel within which this doorbell resides in
+ * @doorbell: doorbell number pertaining to this channel
+ */
+struct meu_db_channel {
+	struct starfive_meu *meu;
+	unsigned int pchan;
+	unsigned int doorbell;
+};
+
+static inline struct mbox_chan *
+meu_db_mbox_to_channel(struct mbox_controller *mbox, unsigned int pchan,
+		       unsigned int doorbell)
+{
+	struct meu_db_channel *chan_info;
+	int i;
+
+	for (i =3D 0; i < mbox->num_chans; i++) {
+		chan_info =3D mbox->chans[i].con_priv;
+		if (chan_info && chan_info->pchan =3D=3D pchan &&
+		    chan_info->doorbell =3D=3D doorbell)
+			return &mbox->chans[i];
+	}
+
+	return NULL;
+}
+
+static void meu_db_mbox_clear_irq(struct mbox_chan *chan)
+{
+	struct meu_db_channel *chan_info =3D chan->con_priv;
+	void __iomem *base =3D chan_info->meu->mlink[chan_info->pchan].rx_reg;
+
+	writel_relaxed(BIT(chan_info->doorbell), base + CHAN_CLR_OFFSET);
+}
+
+static unsigned int meu_db_mbox_irq_to_pchan_num(struct starfive_meu *me=
u, int irq)
+{
+	unsigned int pchan;
+
+	for (pchan =3D 0; pchan < MEU_CHANS_GROUP; pchan++)
+		if (meu->mlink[pchan].irq =3D=3D irq)
+			break;
+	return pchan;
+}
+
+static struct mbox_chan *
+meu_db_mbox_irq_to_channel(struct starfive_meu *meu, unsigned int pchan)
+{
+	void __iomem *base =3D meu->mlink[pchan].rx_reg;
+	struct mbox_controller *mbox =3D &meu->mbox;
+	struct mbox_chan *chan =3D NULL;
+	unsigned int doorbell;
+	unsigned long bits;
+
+	bits =3D FIELD_GET(CHAN_RX_DOORBELL, readl_relaxed(base + CHAN_RX_STAT_=
OFFSET));
+	if (!bits)
+		/* No IRQs fired in specified physical channel */
+		return NULL;
+
+	/* An IRQ has fired, find the associated channel */
+	for (doorbell =3D 0; bits; doorbell++) {
+		if (!test_and_clear_bit(doorbell, &bits))
+			continue;
+
+		chan =3D meu_db_mbox_to_channel(mbox, pchan, doorbell);
+		if (chan)
+			break;
+
+		/* Clear IRQ for unregistered doorbell */
+		writel_relaxed(BIT(doorbell), base + CHAN_CLR_OFFSET);
+		dev_err(mbox->dev,
+			"Channel not registered: pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+	}
+
+	return chan;
+}
+
+static irqreturn_t meu_db_mbox_rx_handler(int irq, void *data)
+{
+	struct starfive_meu *meu =3D data;
+	unsigned int pchan =3D meu_db_mbox_irq_to_pchan_num(meu, irq);
+	struct mbox_chan *chan;
+
+	while (NULL !=3D (chan =3D meu_db_mbox_irq_to_channel(meu, pchan))) {
+		mbox_chan_received_data(chan, NULL);
+		meu_db_mbox_clear_irq(chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static bool meu_db_last_tx_done(struct mbox_chan *chan)
+{
+	struct meu_db_channel *chan_info =3D chan->con_priv;
+	void __iomem *base =3D chan_info->meu->mlink[chan_info->pchan].tx_reg;
+
+	if (readl_relaxed(base + CHAN_TX_STAT_OFFSET) & BIT(chan_info->doorbell=
))
+		return false;
+
+	return true;
+}
+
+static int meu_db_send_data(struct mbox_chan *chan, void *data)
+{
+	struct meu_db_channel *chan_info =3D chan->con_priv;
+	void __iomem *base =3D chan_info->meu->mlink[chan_info->pchan].tx_reg;
+
+	/* Send event to co-processor */
+	writel_relaxed(BIT(chan_info->doorbell), base + CHAN_SET_OFFSET);
+
+	return 0;
+}
+
+static int meu_db_startup(struct mbox_chan *chan)
+{
+	meu_db_mbox_clear_irq(chan);
+	return 0;
+}
+
+static void meu_db_shutdown(struct mbox_chan *chan)
+{
+	struct meu_db_channel *chan_info =3D chan->con_priv;
+	struct mbox_controller *mbox =3D &chan_info->meu->mbox;
+	int i;
+
+	for (i =3D 0; i < mbox->num_chans; i++)
+		if (chan =3D=3D &mbox->chans[i])
+			break;
+
+	if (mbox->num_chans =3D=3D i) {
+		dev_warn(mbox->dev, "Request to free non-existent channel\n");
+		return;
+	}
+
+	/* Reset channel */
+	meu_db_mbox_clear_irq(chan);
+	devm_kfree(mbox->dev, chan->con_priv);
+	chan->con_priv =3D NULL;
+}
+
+static struct mbox_chan *meu_db_mbox_xlate(struct mbox_controller *mbox,
+					   const struct of_phandle_args *spec)
+{
+	struct starfive_meu *meu =3D dev_get_drvdata(mbox->dev);
+	unsigned int doorbell =3D spec->args[0] % MEU_NUM_DOORBELLS;
+	unsigned int pchan =3D spec->args[0] / MEU_NUM_DOORBELLS;
+	struct meu_db_channel *chan_info;
+	struct mbox_chan *chan;
+	int i;
+
+	/* Bounds checking */
+	if (pchan >=3D MEU_CHANS_GROUP || doorbell >=3D MEU_NUM_DOORBELLS) {
+		dev_err(mbox->dev,
+			"Invalid channel requested pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Is requested channel free? */
+	chan =3D meu_db_mbox_to_channel(mbox, pchan, doorbell);
+	if (chan) {
+		dev_err(mbox->dev, "Channel in use: pchan: %d doorbell: %d\n",
+			pchan, doorbell);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* Find the first free slot */
+	for (i =3D 0; i < mbox->num_chans; i++)
+		if (!mbox->chans[i].con_priv)
+			break;
+
+	if (mbox->num_chans =3D=3D i) {
+		dev_err(mbox->dev, "No free channels left\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	chan =3D &mbox->chans[i];
+
+	chan_info =3D devm_kzalloc(mbox->dev, sizeof(*chan_info), GFP_KERNEL);
+	if (!chan_info)
+		return ERR_PTR(-ENOMEM);
+
+	chan_info->meu =3D meu;
+	chan_info->pchan =3D pchan;
+	chan_info->doorbell =3D doorbell;
+
+	chan->con_priv =3D chan_info;
+
+	dev_dbg(mbox->dev, "mbox: created channel phys: %d doorbell: %d\n",
+		pchan, doorbell);
+
+	return chan;
+}
+
+static const struct mbox_chan_ops meu_db_ops =3D {
+	.send_data =3D meu_db_send_data,
+	.startup =3D meu_db_startup,
+	.shutdown =3D meu_db_shutdown,
+	.last_tx_done =3D meu_db_last_tx_done,
+};
+
+static int starfive_mbox_probe(struct platform_device *pdev)
+{
+	int meu_reg[MEU_CHANS_GROUP] =3D {MEU0_OFFSET, MEU1_OFFSET};
+	struct starfive_meu *meu;
+	struct mbox_chan *chans;
+	int i, err;
+
+	meu =3D devm_kzalloc(&pdev->dev, sizeof(*meu), GFP_KERNEL);
+	if (!meu)
+		return -ENOMEM;
+
+	meu->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(meu->base))
+		return PTR_ERR(meu->base);
+
+	chans =3D devm_kcalloc(&pdev->dev, MEU_TOTAL_CHANS, sizeof(*chans), GFP=
_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	meu->dev =3D &pdev->dev;
+	meu->mbox.dev =3D &pdev->dev;
+	meu->mbox.chans =3D chans;
+	meu->mbox.num_chans =3D MEU_TOTAL_CHANS;
+	meu->mbox.txdone_irq =3D false;
+	meu->mbox.txdone_poll =3D true;
+	meu->mbox.txpoll_period =3D 1;
+	meu->mbox.of_xlate =3D meu_db_mbox_xlate;
+	meu->mbox.ops =3D &meu_db_ops;
+
+	platform_set_drvdata(pdev, meu);
+
+	for (i =3D 0; i < MEU_CHANS_GROUP; i++) {
+		int irq =3D meu->mlink[i].irq =3D platform_get_irq(pdev, i);
+
+		if (irq <=3D 0) {
+			dev_dbg(&pdev->dev, "No IRQ found for Channel %d\n", i);
+			return irq;
+		}
+
+		meu->mlink[i].tx_reg =3D meu->base + meu_reg[i];
+		meu->mlink[i].rx_reg =3D meu->mlink[i].tx_reg + CHAN_RX_REG_OFFSET;
+
+		err =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						meu_db_mbox_rx_handler,
+						IRQF_ONESHOT, "meu_db_link", meu);
+		if (err) {
+			dev_err(&pdev->dev, "Can't claim IRQ %d\n", irq);
+			return err;
+		}
+	}
+
+	err =3D devm_mbox_controller_register(&pdev->dev, &meu->mbox);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register mailboxes %d\n", err);
+		return err;
+	}
+
+	dev_info(&pdev->dev, "StarFive MEU Doorbell mailbox registered\n");
+	return 0;
+}
+
+static const struct of_device_id starfive_mbox_of_match[] =3D {
+	{ .compatible =3D "starfive,jh8100-meu",},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, starfive_mbox_of_match);
+
+static struct platform_driver starfive_mbox_driver =3D {
+	.probe	=3D starfive_mbox_probe,
+	.driver =3D {
+		.name =3D "starfive-meu-mailbox",
+		.of_match_table =3D starfive_mbox_of_match,
+	},
+};
+
+module_platform_driver(starfive_mbox_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("StarFive MEU: communicate between CPU cores and SCP"=
);
+MODULE_AUTHOR("Jee Heng Sia <jeeheng.sia@starfivetech.com>");
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
--=20
2.25.1


