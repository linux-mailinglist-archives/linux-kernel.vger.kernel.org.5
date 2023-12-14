Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FEA813435
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573687AbjLNPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573692AbjLNPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217212A;
        Thu, 14 Dec 2023 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566601; x=1703171401; i=wahrenst@gmx.net;
        bh=HoyxGLzh0cWBm1uVhUQ1q4bWwZuGbc3AMgJQ4i+E1BY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Ixgs6ACxF8LrR0d265JrbotSG7t72LtO4s2uOavyZheBGGOyPHq+uFQCPU7wV+Dp
         7Dz0g/XUERAw7VZ4NM7edGDrcHIPbD2VOKyW8FE/3ls7LvNhT6pptYRuRXfHhsb2c
         1UwdWheSlAKr+dts0gTeXpCLJN45v3XC5tgnqTCymoTkfkYuv9w5aAF/dI1u1FigM
         q3++3R4rNtk/QzqtcqmtZh/Vv763A+tZRnxAM+YgN2ixUp2xf3kE6VrGuPGtg3A0y
         Za+imHIk6o/P15ylkTFhMmgsx77eauhSQqjHj/xzEADPAy9B2UX0MobHaML73aDe2
         xmEf6rr9wTuYa2qAqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1qkjsh25MI-00TGKg; Thu, 14
 Dec 2023 16:10:01 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 01/12 net-next] qca_spi: Improve SPI thread creation
Date:   Thu, 14 Dec 2023 16:09:33 +0100
Message-Id: <20231214150944.55808-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jaa8gBMS39cmQ4HWatPaFvZap0JC8ESz1ahsbUCHepaVFbEMF/N
 XIC+Z4gW8Cywe+HjypmwPgNHgMira3acuAaskPH6r3krNvXVc8W12txw06fIVeQjdbSXHiO
 toJzc33bD75HTZYXMDXHXh6RK+Dif6LxLmt6uGSCoK54kCLKB8st1pW1o0Kss11TaPqlwvo
 klnpDo2tcd6MJEUAwu81Q==
UI-OutboundReport: notjunk:1;M01:P0:gjffSHEE4pw=;IVCDy8VgF0WmdAQ82AN4f7TGEyk
 YGvTSV7Dof0Vre7IV95vjsUTLkeuavaNnA8MZLtxRFtyUvGgD9ywdFjzy7+NVxCOy4zExaRgq
 3XLUOyX2NokJIEp+h3lz62lKJtBosi9SLuG8xRk5PcR4Q263MLyMO91ibf/+h/zpBh/t4ULbh
 rINAJoDFmqkBCKlcbEWYdQi1RED9gWWbzwNMRzebR0lw2guprx8DvUClYxfFcScZdvQ+JeREK
 1LVHtdH356lkJX62mBZRal76c0HKcFN5b+PlFTOgjROdsNoGSWapMlSR6lgTx4jlm2PjPVOQK
 r1SN/WbN/IOfkbjEXc/7aFZsaDbeTO+JSbdukWt6Z0+MWTddJdiiklxBre4nNruCKI0lTOWq3
 Pido2yuXoerAnS/MYYf78hoPPwGuozwin46EuedN8/l1jEPEyJbpg9+8wxyOsP0CNgQlhrp5d
 RtYbav8esbWV71u93vqxpKBT0H3F/2f1EcIr5CwwD5NwMs/UUfQRTl15aI3EizWYqZhNkun7p
 5gx1Bs6wGxkZlo8jE300vkrZRLzJzaMHZhL2el0xS7lsVxpeaKZviAYEPmuf4P5gZquY6iyEO
 lVDPWUiZVkRgmv0v2yXaDazIhw71KbWyWkkrWYa/QGAxcRVerhuxs+08eXKMTb/K6XvDcGd8t
 Hc/Iqbgrg9w0G8Lnoa80NkaICiO3pBDJWq4S8LxSzseVQnwebrLB0GbtzktYsE3OJ5buK2ZHQ
 Sp96bTD8zKQqrPuCJKIMG4Me1WbM8In9sJXnifrX5Sb9GhRBOFn9KgwFziMc6WEZoBWeqbjtq
 TS0TEzGetyGvrECa2Jsjz6F1yf7RRhgc967M/EVXJcl4qQ2t/hApUWhSrScWR4HT8LfWXV2TQ
 0GLBw51cWw7fBGroIbKttAqVUISAK/Cp3Cq6ZCyvw31xLRbAEEFMG3eBSj2WF2tNM0kaKnBmj
 Vj/COw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca_spi driver create/stop the SPI kernel thread in case
of netdev_open/close. This isn't optimal because there is no
need for such an expensive operation.

So improve this by moving create/stop of the SPI kernel into
the init/uninit ops. The open/close ops could just
'park/unpark' the SPI kernel thread.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index bec723028e96..a9f01fb3455a 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -679,25 +679,17 @@ qcaspi_netdev_open(struct net_device *dev)
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

-	qca->spi_thread =3D kthread_run((void *)qcaspi_spi_thread,
-				      qca, "%s", dev->name);
-
-	if (IS_ERR(qca->spi_thread)) {
-		netdev_err(dev, "%s: unable to start kernel thread.\n",
-			   QCASPI_DRV_NAME);
-		return PTR_ERR(qca->spi_thread);
-	}
-
 	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
 			  dev->name, qca);
 	if (ret) {
 		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
 			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
-		kthread_stop(qca->spi_thread);
 		return ret;
 	}

 	/* SPI thread takes care of TX queue */
+	kthread_unpark(qca->spi_thread);
+	wake_up_process(qca->spi_thread);

 	return 0;
 }
@@ -707,15 +699,11 @@ qcaspi_netdev_close(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

-	netif_stop_queue(dev);
+	kthread_park(qca->spi_thread);

 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
 	free_irq(qca->spi_dev->irq, qca);

-	kthread_stop(qca->spi_thread);
-	qca->spi_thread =3D NULL;
-	qcaspi_flush_tx_ring(qca);
-
 	return 0;
 }

@@ -807,6 +795,7 @@ static int
 qcaspi_netdev_init(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
+	struct task_struct *thread;

 	dev->mtu =3D QCAFRM_MAX_MTU;
 	dev->type =3D ARPHRD_ETHER;
@@ -830,6 +819,15 @@ qcaspi_netdev_init(struct net_device *dev)
 		return -ENOBUFS;
 	}

+	thread =3D kthread_create(qcaspi_spi_thread, qca, "%s", dev->name);
+	if (IS_ERR(thread)) {
+		netdev_err(dev, "%s: unable to start kernel thread.\n",
+			   QCASPI_DRV_NAME);
+		return PTR_ERR(thread);
+	}
+
+	qca->spi_thread =3D thread;
+
 	return 0;
 }

@@ -838,6 +836,11 @@ qcaspi_netdev_uninit(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

+	if (qca->spi_thread) {
+		kthread_stop(qca->spi_thread);
+		qca->spi_thread =3D NULL;
+	}
+
 	kfree(qca->rx_buffer);
 	qca->buffer_size =3D 0;
 	dev_kfree_skb(qca->rx_skb);
=2D-
2.34.1

