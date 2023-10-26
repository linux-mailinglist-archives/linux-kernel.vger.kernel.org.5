Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3307D85F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbjJZPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJZPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02731D42;
        Thu, 26 Oct 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698333839; x=1698938639; i=estl@gmx.net;
        bh=2ljegJ3y7s6VlC1UqoCKCA1HzgQE8KWII58XSk+iJp0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=txKTt2iXQCRDirSPt3HVRr8fypUYgpvSTOm5O/PTqKrchS1O8r1S0C5neKzLgTUn
         DDzRgScN26oYF9ljR/RtxbK3BrddDCipHDcig1r/DMBNZUGltXG3SUc+m/oDL3/cJ
         oDI7D57Ohe+E7G58htTl/yfaDwXW3i8iYG7CcrGeUYakLrBuNh/Q3IFhwBit52nrx
         cedpnWzlOx4JaFmw86Yssh/d36I5c5ZL/bAUpPnvAcdzQWjetJik2x16VfRWSUNUX
         bd/ObkR4QiVpjilfjygOPOt1PsHiAnCxa6RrnZNkbxelXAZ+UNF8vu4Pn8aWH96Gs
         HdmZR/0H3vP9v1LxCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([77.246.119.226]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MCbEf-1qmzwC3Dvv-009kGF; Thu, 26 Oct 2023 17:23:59 +0200
From:   Eberhard Stoll <estl@gmx.net>
To:     Han Xu <han.xu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 4/4] spi: spi-fsl-qspi: Add support for rx data sample point adjustment
Date:   Thu, 26 Oct 2023 17:23:05 +0200
Message-Id: <20231026152316.2729575-5-estl@gmx.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026152316.2729575-1-estl@gmx.net>
References: <20231026152316.2729575-1-estl@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:owMvC+i5vRKRLGouxvuCJLHydYsjuznM+geq7F0GPloF00XKufi
 SiaKWrCzbYaVf/fF/tVMmUn7NJJDGchyLnlQM0BFAbm/s6D+3gtD+BlutR/1blQEOPIAD26
 k0DiHURvO1eKfZZDR5h+PpNw3FmY6yupkbxpRtm//7DhHjffKW+HQOVfbVxkH1sUlrTJRkq
 ZNDFE/GeoDw6uVYwzvcew==
UI-OutboundReport: notjunk:1;M01:P0:tr92El/r2ik=;spGlmyEPmic3IKUFaUVMZr0zzpZ
 3RqBzGU5l/nBWJuauZ0NnlwhiGbse3MerR0ICtXfhZJFbxdcUA8Ek8tnK3aLHjb3ivphAYD17
 1IM1tERfaV1nm+WHG8ZP8wntcLWukVgGe/f2psa4Q9xWsd59Ax+DI9D0JQCPA0/9g57tvq5df
 uPMuNsyQE5wGP1dzbxycJTCg7e4xaXglNTBxwXGpiP7UDtMTkYXnmZTPBBmAPzPa4HxeJMvyK
 n0nD5JeW4Lxcf/YRBN96TFw84kq9ZkkRZrP6NNbli8jwoEIPptkFA/xiHOgUQy5aW693o3Lci
 WE1ZJAXj1of6rcAH4unlrZ+C3BJJPk32rSqjx9uDHY5xoPJ3ycLmxCDZsCN/1oty+9QayqPm5
 czciM1DGEz13LlQSbZStw1oNsGeJkCetdwYdP2MDTKB4CbfR0ruPBzp9sIOJhvxJsRsGY9SNv
 jfvOkbTB+RTxt8DZZC7+gCcHzARaF5z1ilLvlHSxpzTUHSsPe5siy5dDhdlpZ6SDN2f7gh1PL
 KHSOueFxniYIyo+AAmQLsam3SlhWcaxQ1MuQoyiz0eCZig7xSEDYDOeDEIQOuaXDRCjsAAYUR
 jWMU9taIA2lQVd4rXs2pepHkU6GM3A/axMB8/CG8Q5UdOnt7j8cAaqHVcPLNLvBtVdYTrw93Q
 mhN4fFjBAu5yOIsY2dM+5egapYymF6zOFcTkQj4pCYUAIAZS745l/74rIw2PnXeiz8zGjhAd7
 Zobtx2TaCaZqbY1SU3+GPxAg/l9iGQNfQVYbfOmZq6MxvvAx9EIF9hRzmm2EyhQQ5RfDzDUaS
 tYmXkTN7AVZ1CgzL7GOvAnSMlZrmHI4E3fCfN8L6mW3v17MWASahUnSeTiI6bPm7jM+Kyew5N
 FWxIkBpUqm+CCnzQOYev54uD5bUOywO0XwVd5cTFw2nn3q5KbLczQ/AKAO08H0FwdX2ZR8M/z
 bR9cKQwBvKQ+rfiSLmGaSI1YwT4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eberhard Stoll <eberhard.stoll@kontron.de>

This qspi controller supports shifting the spi rx data sampling point to
compensate line or spi device response delays. It enables fast spi data
transfers even for devices which have a noticeable delay in the rx data
stream.

Add support for the SMPR sampling functionality

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
=2D--
 drivers/spi/spi-fsl-qspi.c | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af..68801e08f997 100644
=2D-- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -274,6 +274,12 @@ struct fsl_qspi {
 	int selected;
 };

+struct fsl_qspi_chip_data {
+	u32 rx_sample_delay_ns;
+	unsigned long rate;
+	u32 smpr_sampling;
+};
+
 static inline int needs_swap_endian(struct fsl_qspi *q)
 {
 	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
@@ -522,14 +528,63 @@ static void fsl_qspi_invalidate(struct fsl_qspi *q)
 	qspi_writel(q, reg, q->iobase + QUADSPI_MCR);
 }

+static void fsl_qspi_update_smpr_sampling(struct fsl_qspi *q, u32 smpr)
+{
+	void __iomem *base =3D q->iobase;
+	u32 reg;
+
+	/* Disable the module */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK | QUADSPI_MCR_RESERVED_MASK,
+		    base + QUADSPI_MCR);
+
+	reg =3D qspi_readl(q, base + QUADSPI_SMPR) &
+	      ~(QUADSPI_SMPR_FSPHS_MASK | QUADSPI_SMPR_FSDLY_MASK);
+	qspi_writel(q, reg | smpr, base + QUADSPI_SMPR);
+
+	/* Enable the module */
+	qspi_writel(q, QUADSPI_MCR_RESERVED_MASK | QUADSPI_MCR_END_CFG_MASK,
+		    base + QUADSPI_MCR);
+}
+
+const char *sampling_mode[] =3D { "N1", "I1", "N2", "I2"};
+
 static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *sp=
i)
 {
 	unsigned long rate =3D spi->max_speed_hz;
 	int ret;
+	struct fsl_qspi_chip_data *chip =3D spi_get_ctldata(spi);
+	const char *sampling_ident =3D sampling_mode[0];
+
+	if (chip->rx_sample_delay_ns !=3D spi->rx_sample_delay_ns |
+	    chip->rate !=3D rate) {
+		chip->rx_sample_delay_ns =3D spi->rx_sample_delay_ns;
+		chip->rate =3D rate;
+
+		chip->smpr_sampling =3D
+			(2 * spi->rx_sample_delay_ns * (rate >> 10)) / (1000000000 >> 10);
+		dev_dbg(q->dev, "smpr_sampling =3D %u (delay %u ns)\n",
+			chip->smpr_sampling, spi->rx_sample_delay_ns);
+
+		if (chip->smpr_sampling > 3) {
+			dev_err(q->dev, "rx sample delay for device %s exceeds hw capabilities=
! Clamp value to maximum setting.\n",
+				dev_name(&spi->dev));
+			chip->smpr_sampling =3D 3;
+			sampling_ident =3D "(I2 clamped to max)";
+		} else {
+			sampling_ident =3D sampling_mode[chip->smpr_sampling];
+		}
+
+		chip->smpr_sampling <<=3D 5;
+		dev_info(q->dev, "sampling point %s at %lu kHz used for device %s\n",
+			 sampling_ident, rate / 1000, dev_name(&spi->dev));
+		fsl_qspi_update_smpr_sampling(q, chip->smpr_sampling);
+	}

 	if (q->selected =3D=3D spi_get_chipselect(spi, 0))
 		return;

+	fsl_qspi_update_smpr_sampling(q, chip->smpr_sampling);
+
 	if (needs_4x_clock(q))
 		rate *=3D 4;

@@ -839,6 +894,28 @@ static const struct spi_controller_mem_ops fsl_qspi_m=
em_ops =3D {
 	.get_name =3D fsl_qspi_get_name,
 };

+static int fsl_qspi_setup(struct spi_device *spi)
+{
+	struct fsl_qspi_chip_data *chip =3D spi_get_ctldata(spi);
+
+	if (!chip) {
+		chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+		spi_set_ctldata(spi, chip);
+	}
+
+	return 0;
+}
+
+static void fsl_qspi_cleanup(struct spi_device *spi)
+{
+	struct fsl_qspi_chip_data *chip =3D spi_get_ctldata(spi);
+
+	kfree(chip);
+	spi_set_ctldata(spi, NULL);
+}
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -865,6 +942,9 @@ static int fsl_qspi_probe(struct platform_device *pdev=
)

 	platform_set_drvdata(pdev, q);

+	ctlr->setup =3D fsl_qspi_setup;
+	ctlr->cleanup =3D fsl_qspi_cleanup;
+
 	/* find the resources */
 	q->iobase =3D devm_platform_ioremap_resource_byname(pdev, "QuadSPI");
 	if (IS_ERR(q->iobase)) {
=2D-
2.25.1

