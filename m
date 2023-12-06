Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835308071F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378737AbjLFONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378678AbjLFONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:13:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794ED66;
        Wed,  6 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701871976; x=1702476776; i=wahrenst@gmx.net;
        bh=KLwqFYpRFPrNX4+hxxfvye3azsZxr+QOjeo8aacDXMw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=ORYVHon7PvB0TORAdKqmSliNClCCeXrd0QoefZyi2yHoxn2lp0inxltQx2n2PGaf
         4vL0/tfuCqMQwHm8YeeR7LrpdUyT+YvW67wiVIpZAm3hq1L5JSkdKzy07NJb8s3+6
         hEfpIn6DJ8z9xfkyLgtVoqMA9u2qaAEujx4x5S/oigxKwqGvz8J7lKr8/f1T10bU9
         vhJREa9AIrqNYoxxFG9eU7PmrMRci5vSOTOfiO6KdrPv8Qyn3XrZoHG9DydGtk4jF
         AeS6zVkGGgJW40JduDpinUQKmQv7uhaZPMewXeyexEp7O8rWBVxFtW1O8hDzt/yZX
         6of84D5J31DLVyPGBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1qlPX12FHP-00RE0A; Wed, 06
 Dec 2023 15:12:56 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 1/3] qca_debug: Prevent crash on TX ring changes
Date:   Wed,  6 Dec 2023 15:12:20 +0100
Message-Id: <20231206141222.52029-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141222.52029-1-wahrenst@gmx.net>
References: <20231206141222.52029-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0dVexsRIOyjNyXmqRuYjuFC3b1Z3BoCBKtglIXiLxK1Z6AJxoxz
 11nWnsMnyIDobaml5nc/1jH82xUqsNaRRPYAxW1Ai2IyLHdCdqtuf7n3j8boJ2XiZRKQen2
 g1uhCClzoGqG0G3WjTJJtZt847H7HUpCuIWdaO601YunGRbqoD+b0xfmJX9enPqqNdycNwX
 vOeeaAprNTLIa27JL+jdw==
UI-OutboundReport: notjunk:1;M01:P0:P0UWt59LhLw=;zavL8m2zI44NfAdtkEjTC9VcMSZ
 rV/1Kig2FVfk1x+0KgsHDa8e3ysbNe9ALNbssWmsIsy2AJ7PEIF9zH+Y5/+fMyKvmpn6xUaV0
 8e/xsjiKCeqks2Tnmvf1vsFhuk+wLF9tSLMjaAPvkGI5vzpZ2IJwhkVVWaj34562+4CK7ljm5
 WDAJpPm8wAiTd7dCO/ON/5GfM8j+jPT81thywci1GgJqxFrgL56FnaYGL8ItdJPCsRz9J1VP6
 mpV78FQcLS9VUpf+HTIYhFwCz1HYdHhQPrp1bc+9qAbkTtwHvF0WBjbbsDao95PKGGnYevWR0
 Xfy5VfsHYQw+RtFdG4BMH8m/7mz7ec11omBZoT5H38wgtZEW1rKnnco49fPmWv5pDCALLDviD
 PBvdsgzgVbXdqMzTtk1sHV7aIwhW+6GJoaDEo6LPvyxPh+lgELCJFyOAvFsJdlJ77BoPHn23a
 MINDeEtfpe4v12YiKKc/cn60jHJMG029F2XaUmxpEHu3aGs/cJwlNJ/9ziZQP8fX21W+hCjOZ
 R4xTwakhmimDRUhu/hpO+awHLPYOdK4pp5/A/uaIdr5x9qvTEWCZZgS/JDiscbrP4x7hxx7Cx
 jWyqLJnxvY/xY7lrtU2Sll1LG0q9TyYdPT7KmVdobqf2Uri5YEF7MwLj9bc02Y1lUG/DAePx0
 PMp+Dp7mLG73u6DUZsDqAz6ginLX58QwAB9GipG35N3z5bDH4Jws9tM7xm3DN935gM+LpQ5du
 nNuW90Xd6FMH7dXDm1GMphLnYmZCVuTO7zjr7svlry6uHOH2m/8BAke9KwFocHGcY4xbX5lBd
 C12oH3xkU+A4ZCyLP9dlhiURJ17oAhbqXPdidM/rM2vPRHFJ771xsC172zSbl8B9QqlNBeqIz
 RnSMxD1HwFEXmM+P6bkDCrdDZJ/0FHQSikQeAZOZZjLD9/JYRIsNNfV/+vrLb5+W3Ct+zwVAO
 lk5GVHtEUD8gksYOvhxvz6FV/KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca_spi driver stop and restart the SPI kernel thread
(via ndo_stop & ndo_open) in case of TX ring changes. This is
a big issue because it allows userspace to prevent restart of
the SPI kernel thread (via signals). A subsequent change of
TX ring wrongly assume a valid spi_thread pointer which result
in a crash.

So prevent this by stopping the network traffic handling and
temporary park the SPI thread.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c |  9 ++++-----
 drivers/net/ethernet/qualcomm/qca_spi.c   | 12 ++++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 6f2fa2a42770..a5445252b0c4 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -263,7 +263,6 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 		     struct kernel_ethtool_ringparam *kernel_ring,
 		     struct netlink_ext_ack *extack)
 {
-	const struct net_device_ops *ops =3D dev->netdev_ops;
 	struct qcaspi *qca =3D netdev_priv(dev);

 	if ((ring->rx_pending) ||
@@ -271,14 +270,14 @@ qcaspi_set_ringparam(struct net_device *dev, struct =
ethtool_ringparam *ring,
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;

-	if (netif_running(dev))
-		ops->ndo_stop(dev);
+	if (qca->spi_thread)
+		kthread_park(qca->spi_thread);

 	qca->txr.count =3D max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
 	qca->txr.count =3D min_t(u16, qca->txr.count, TX_RING_MAX_LEN);

-	if (netif_running(dev))
-		ops->ndo_open(dev);
+	if (qca->spi_thread)
+		kthread_unpark(qca->spi_thread);

 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index bec723028e96..b0fad69bb755 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -580,6 +580,18 @@ qcaspi_spi_thread(void *data)
 	netdev_info(qca->net_dev, "SPI thread created\n");
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_park()) {
+			netif_tx_disable(qca->net_dev);
+			netif_carrier_off(qca->net_dev);
+			qcaspi_flush_tx_ring(qca);
+			kthread_parkme();
+			if (qca->sync =3D=3D QCASPI_SYNC_READY) {
+				netif_carrier_on(qca->net_dev);
+				netif_wake_queue(qca->net_dev);
+			}
+			continue;
+		}
+
 		if ((qca->intr_req =3D=3D qca->intr_svc) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
=2D-
2.34.1

