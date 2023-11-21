Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706A7F33BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKUQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKUQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:30:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B74197;
        Tue, 21 Nov 2023 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700584228; x=1701189028; i=wahrenst@gmx.net;
        bh=CBjZ1PW1pxUGSomTdCbNWsOlGvLT/OTWJhsIn7TxVJk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=fXQPRrdUbLmWd5SEN+Zf4z46r+L/gfzJE/8OWv+/dDdV6/5akSHNgnSBDEj5rpLn
         6Sa9bT7fj/Rswrdm16vv2er+XZBuU0UEOE0OnzWOoLLSkm/WsEIomIbsB+8/KcRwE
         nT1SUoSGvyThL3PvwaM9JXw+za8g15e8SoXu+BI4fjt+rw7agSpW9PzE95ZDSjYM2
         HkkV2I//gZSEYd881wI0n9D2fnP5SOB4L2ee6RJqoC81Ij2mKL1TQ+oYrFuny06mR
         jganErdUBWYeXzWODcaiHXwiz6PU1KeAgqqAC/Koi9aPk9YGL7WKM62WHbCwipqfp
         pKUqDqC1iuI5fUisVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1rPtuB2t91-017H0w; Tue, 21
 Nov 2023 17:30:28 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
Date:   Tue, 21 Nov 2023 17:30:02 +0100
Message-Id: <20231121163004.21232-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121163004.21232-1-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZCuJB5l+X54LokCRJHC44uNv59nEGilnW3usHMn3aChh1RMSVM
 QHDgmDkrPlfZ+1W9RPZX/Q8UL+bszMxxJueFHwsRfhPl208O+mLI5Q2iY1K1OjOn3HbPpDq
 RTXsPnkgDCdm0TNjR7Ve36+py4rNZ2W9aSq+D0btWgHGVke79g3x1EjAh0yPRgj5dlfkSUW
 YV+8mHaXooLdR8qZtdZJw==
UI-OutboundReport: notjunk:1;M01:P0:xOcNZraKNLs=;hEXnTMiH8otvELbjWcdEa9PrCLa
 lpnU1yGJm5JmQiIFHjj2ARITPc2PgRomfUI1VDM4mQzGpRWdjV64kfb6f1IINPGYJV5WZ34ne
 BH9s3ernlljvHZXO7AC+OBGABsId6ZtrZ4SbrazBFNBjHB6VTfte6gy6DeiTBE8YLUc37bC3E
 yv0eMLIj17dHbNIZbbsaTw9fc+m/KOjrvXVXnw7RKAYdgt0r1Du9qSFStQ+MY+dZML4vuGMWg
 1ftxYmE7bWBKOdeGE9MJCxuPb+XjCuOCq1meV+XLUCXtpzFtrRDXYbSLsanemp57ooDid3N1f
 cvViL3CG/aJ7uGGiDcR7d7fmUeOK9xj/VJxNxWEjXvS37I3h7fvvvKERTwdc7i2Ajy/J2WBjJ
 QadAGmHPdCk/qpQqOJ6v8bpN7RX7dtzY7PvkUmiTS2aNlMoOkrwZ+nvwiVWwPoN2HpFoZhm5b
 PIONMkGSSPh6psqaVWh1T9PhKoVSeAD9QtPU1PBC/5FPoFG1BABnFApTdYVNlwn3SA1l6OFEj
 2IfvUcKFMS9IiIySIaFjUZPZ2JiRhSp6HIgVe8UFuvomMoVfW+oQbyPbCVTM5tbPLKzHxFIfE
 UtngETX4+okO0cTVHT6u9uDqafthFvBh9pcy7pqlM6RbjpgwqmlfNVhamct8IH0XyI0NxiKxY
 EJlurbuQuWtNWjAKp9u9QYt8JPWk3Rm0Le1mniWJ6JADh94Q5RIR+jMJGvad0FTYP+NdiwNOW
 uu3qapw6C9p49fafeBhQb3M3PhkKWf4oLf/wCX9/lEanFNSKxDV7WY6HKE0fHofocizRtSEzw
 dfwSrrWdhkWe/jYpafom2iEiUTzro0gfTyWfNbgREZfns57YmYLW8nh5JcVPXosHoCZHhC77D
 aqrZkgTeyi36BRhQc362xvJVTNEakjJPhl9gFXcHfg6F+KTBuXU5k2FAx44dvjgY7wXed9AEL
 6BjLGxC2kwVjsxMlQOzhu3DNqfc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions qcaspi_netdev_open/close are responsible of request &
free of the SPI interrupt, which wasn't the best choice. Currently
it's possible to trigger a double free of the interrupt by calling
qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
So let us split IRQ allocation & enabling, so we can take advantage
of a device managed IRQ and also fix the issue.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index b11a998b2456..b2573eea8a7a 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -674,7 +674,6 @@ static int
 qcaspi_netdev_open(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
-	int ret =3D 0;

 	if (!qca)
 		return -EINVAL;
@@ -684,13 +683,7 @@ qcaspi_netdev_open(struct net_device *dev)
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

-	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
-			  dev->name, qca);
-	if (ret) {
-		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
-			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
-		return ret;
-	}
+	enable_irq(qca->spi_dev->irq);

 	/* SPI thread takes care of TX queue */
 	kthread_unpark(qca->spi_thread);
@@ -707,7 +700,7 @@ qcaspi_netdev_close(struct net_device *dev)
 	netif_stop_queue(dev);

 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
-	free_irq(qca->spi_dev->irq, qca);
+	disable_irq(qca->spi_dev->irq);

 	kthread_park(qca->spi_thread);
 	qcaspi_flush_tx_ring(qca);
@@ -977,6 +970,15 @@ qca_spi_probe(struct spi_device *spi)

 	spi_set_drvdata(spi, qcaspi_devs);

+	ret =3D devm_request_irq(&spi->dev, spi->irq, qcaspi_intr_handler,
+			       IRQF_NO_AUTOEN, qca->net_dev->name, qca);
+	if (ret) {
+		dev_err(&spi->dev, "Unable to get IRQ %d (irqval=3D%d).\n",
+			spi->irq, ret);
+		free_netdev(qcaspi_devs);
+		return ret;
+	}
+
 	ret =3D of_get_ethdev_address(spi->dev.of_node, qca->net_dev);
 	if (ret) {
 		eth_hw_addr_random(qca->net_dev);
=2D-
2.34.1

