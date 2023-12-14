Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1856E813432
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573713AbjLNPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573672AbjLNPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88F126;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566602; x=1703171402; i=wahrenst@gmx.net;
        bh=V3wYXbngbRFmmwchd5FBtOyVigPT9ypB8NTZpDN56xI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Byguehe855YtsPlLbH0X0gbIQ58CIz9KwrT3Z11a6HuSQyqnCA9VgDKwVb+s5Pmh
         Gp1H9AAD7kEQ9mxhkxflWVjFiBkbif3qHoVx7YOTVNujWKT61LgiiIKpYLnnLxzhd
         hhPdV02LLag4ObXySq3ADXrSZLqMjjUfklm+gXmzjMyIMWBml2DUfm9pBkA7TBTmH
         WouGtDpeKXSwTjofEyfA+zERqSFexpJBucBNpUu2AtUrNr6Ap2cpy6TpUX6bQ9Xte
         JLxOYi3GXIm1PG6yHktpyztRmOQbMTlLb6Siy+SRbo15mTr6eDooDwwzWyOLMKwt5
         YO//PUxVkrxYp5fKpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1qr1PG3Zel-00MuXr; Thu, 14
 Dec 2023 16:10:01 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 02/12 net-next] qca_spi: Improve SPI IRQ handling
Date:   Thu, 14 Dec 2023 16:09:34 +0100
Message-Id: <20231214150944.55808-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vm0GesJonugTpeWp17ebjJeKxm2FnShj+b/T0LVQaETbb+RmmGl
 CWA9h5diYX4y1N/5DGcJzHZK6i9J67EWi8Rg9pJKDC38MmXIY7FfVYOJOjnGgQ42MY1EgR0
 ogMv1NDMqNlVonzayr/YAjxVeqbdORbV8CGIapdjYXF4SCihOmKtISNabPhVqDaVjf15k+w
 PltSHYvADlYgspmsvz+Iw==
UI-OutboundReport: notjunk:1;M01:P0:LcN40jitl68=;RPSsSXJq+D0d//QKuagK48M/Wws
 Q6/I5nmtKXzPGHIpy0oLqO3kxBr8oUrNER+AM5rboqqRlnSczcqmvkltRrWs4qmlFqabzw3gp
 cSdZ+xaPvdyqmUpQME942G5o+bOrlGEse4NjP6xuArmHIpvsb732q21hxxEG5GipeP8lPr+F/
 EFWGN9NBhBUxWx6sL40jtOTyXZCWybsuf7phtjy84g/pvSYbw/MyhpjQnDkkTH+0mrnHFOBVy
 T8xl62Y/Xhu9O+W9ZRcTQ31hTtJVcj369MdwrgcpXHxlnSaCvAKRUtbT2BsoDWwUXRe07sfx3
 JvVMb1zF1ybG6SgePlG85yJkDNL5Hhc5B3He5VfBtEXOwD4mfpiB7I70JXyq2XVw0nMtuiNqq
 fKXHSbxKN+gdBb8EtO7+ZnXXkDA1zOy12fhGVo9ud1f/mIooqz+DjCZSmJdWz4iBGoLGDtPWe
 2KGznctQIdHiwMbYHohGTRptUrQZ3CJiLMxB0n+ZDsCZ1wIblgIwqUwNhE5gOj1lNAgPG4si7
 XitMbLHHvWHyYMC5ApKjDXIoJsB1yvhAHGzkfb5oRDEi8Moh9d6SnJTIJwQXhbJTcPEEw+4L7
 a7Pyttk5Qlwc9lz+JiNCZLX9D5vs0B8bcYcqavJR/e+HBtbamnodp8wcN8ufDGCGvFfm99IUM
 7VtUdCkhCS8H8MCgZaaw8MpueJgtxr/bdba30EbRw/pwJmijw4byRtnkRw5/PLLZ84WyZ8CB/
 65OHxCp/cj66RzPTEg/uTZbWnGDf4Dn++g+5c3pqEbCxce1ePqW07gTIRMGqJv9yS5xxovFzn
 ruHBrGtrTbFN08YjCK7BpR0bbyajFIBT5GKBv4q3KihHhinoZrUydrukklAQg893Y3+L9CGt9
 vRQP/vKuTGY/TaBEVtw/LKIIsFL6I22Id1eO/ZXeeuxkIslfx/9jjikCdLfdTUF5f6VoKxJxG
 Xl7ufg==
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
free of the SPI interrupt, which wasn't the best choice because
allocation problems are discovered not during probe. So let us split
IRQ allocation & enabling, so we can take advantage of a device
managed IRQ.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index a9f01fb3455a..88f2468ba676 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -669,7 +669,6 @@ static int
 qcaspi_netdev_open(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
-	int ret =3D 0;

 	if (!qca)
 		return -EINVAL;
@@ -679,13 +678,7 @@ qcaspi_netdev_open(struct net_device *dev)
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
@@ -702,7 +695,7 @@ qcaspi_netdev_close(struct net_device *dev)
 	kthread_park(qca->spi_thread);

 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
-	free_irq(qca->spi_dev->irq, qca);
+	disable_irq(qca->spi_dev->irq);

 	return 0;
 }
@@ -969,6 +962,15 @@ qca_spi_probe(struct spi_device *spi)

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

