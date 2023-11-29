Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77C67FD34C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjK2JxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2JxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704619AB;
        Wed, 29 Nov 2023 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701251578; x=1701856378; i=wahrenst@gmx.net;
        bh=lOJ3u0uO6yLMNgD1lUKLeIxcnfV1jb5Ow4YD+RbTpq4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=GPWHTggJrPqK6z2LAqgWkssJVXx2eq8hedeNVeeQPMH8v8/Oig7IJXLPraYeEujO
         DZ4uJdhkly2iP1RJaTQOC4PltIjlCUDB5VCuY+3Bbc9Y0zGbj+Oc/RvJdPL2lXbXF
         QlIXX08BBQfaGfhFusqw/zOQX9S2OI8R6uRA0SU/9xWXlvgfm/MsjhEpDuwcfsHIX
         GzTy0PAemSlKlBURwTVswW3p5SgRRFmvKUiouXPJ1UQgRmkWe4zIJr5onx66scA5I
         yu+xBoFOlqj7bVevwJvE8JPVMgpdGp70RtUqT3WEc3aJ3M+NLICTZjVoW5PwOBQOR
         R/ATeF/Y3RVJVh+oOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1rPX9U2zn0-00rXPc; Wed, 29
 Nov 2023 10:52:58 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/3] qca_debug: Prevent crash on TX ring changes
Date:   Wed, 29 Nov 2023 10:52:39 +0100
Message-Id: <20231129095241.31302-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129095241.31302-1-wahrenst@gmx.net>
References: <20231129095241.31302-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQcEDKN8Pru9xYX/nc5RIlq7/xpDxrqzO6bhFi1vBbIP5H8jRaL
 4pyjc9S1feN0qqW0SjBfJyK9Glm8+AGugk4m6RKFaJRYKY6Ydzi6WkYpfAB0EIPW1spQvts
 xAmczwZ5g82VNXY2Q5w+BWVGvNaJmnwW5/P4v/PcoeF/iE9sW2jg722+g8v15mQXHOZmPuI
 Yu5s3ni62SqNCOPUJ26hg==
UI-OutboundReport: notjunk:1;M01:P0:RAHTY6FOATY=;+pZCDRGEKoR3buvj1/Fh9X2TeO2
 aUlbCk7n6XvZsEqPuj/yJs47d4pb032eNDqBVmXPJ/IxoYI1d2LGYfHXqbO6YfA8mpPbl/LxV
 5sVPWFJttTjEUv4cIuTnDGvs5BGPlQYNAtf+OeQDQKmdD6pdx71AZ5pPVbx859uEmh+LZA1jM
 MvT9cLqLPvo88tnc5vjT+/POYy33HXm2o0DFYMKy14WSAMxSfAyngH7FU/6KOqB9nxwusLZuZ
 hn59Cxce1Ck9A0sP3yGpO4mvdC8QCyEl5E/UdpENLL4wEdGgRlrhWMqNQK6EQ9GiU4bj3RYg6
 WthxENua3c4IcU6w7YOY61u+8rhgWWDJDcZ51p6AHdWbMXmfHBwirCDXeif9zKIdrqVGKvcGe
 E2UfcAUiqFp9erKj3DIrqweGQa18RN3d7uaE8A6XAAtO531ON4zPMYYbtkMLJmoumnuOhTIq1
 dlf9hLt2WGToclrwLIDNzhFLl8ObrkSA1VFWeu/6n8rxwfV4qIXHCuTqHTd4/eadz0sE2ucat
 pxJesj+Ny8NffycOYrQD0fCcFhlO8h3eYnW9SS/asA0+Ce8RZjCRpZghVX5Vk5l/MZetveMfh
 HRg1DWE/5vzoi0glIf8gzpEaiq/+a0Gq7r71L94FHtb1c58MgfluH/Piwe4YQFjC7Ws0lYZmG
 s9JFxO7n4VTr5Y+JaBXiI4S9zqccFkqoPCouUZsxLuQl1ky4UNYv/cXHZU6hEpJ9xuSazlv8M
 XKaz6HiThbDtsgYkZSMMvXlwfTT5jfjqWnNKj+c0lG55JkWPvRDet39+E4u55NM7oa7qW1Xg5
 aOwqFgvyU6R6oRfP8R+AilTLdksMjBR9kxdjiCB0sgphk2RVtHyviJVmxFKjtqDqtacHMWwRG
 JEsCNN4vqyKDnvnq8FvOtlaJoOjttSPEMHwASdUsvx+V2+qr8ZHDzg8FFNHZvGLWjaHXBWkTu
 6aN/1w==
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

The qca_spi driver stop and restart the SPI kernel thread
(via ndo_stop & ndo_open) in case of TX ring changes. This is
a big issue because it allows userspace to prevent restart of
the SPI kernel thread (via signals). A subsequent change of
TX ring wrongly assume a valid spi_thread pointer which result
in a crash.

So prevent this by stopping the network queue and temporary park
the SPI thread. Because this could happen during transmission
we also need to call qcaspi_flush_tx_ring().

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 17 ++++++++++++-----
 drivers/net/ethernet/qualcomm/qca_spi.c   |  7 ++++++-
 drivers/net/ethernet/qualcomm/qca_spi.h   |  2 ++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 6f2fa2a42770..9777dbb17ac2 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -263,22 +263,29 @@ qcaspi_set_ringparam(struct net_device *dev, struct =
ethtool_ringparam *ring,
 		     struct kernel_ethtool_ringparam *kernel_ring,
 		     struct netlink_ext_ack *extack)
 {
-	const struct net_device_ops *ops =3D dev->netdev_ops;
 	struct qcaspi *qca =3D netdev_priv(dev);
+	bool queue_active =3D !netif_queue_stopped(dev);

 	if ((ring->rx_pending) ||
 	    (ring->rx_mini_pending) ||
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;

-	if (netif_running(dev))
-		ops->ndo_stop(dev);
+	if (queue_active)
+		netif_stop_queue(dev);

+	if (qca->spi_thread)
+		kthread_park(qca->spi_thread);
+
+	qcaspi_flush_tx_ring(qca);
 	qca->txr.count =3D max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
 	qca->txr.count =3D min_t(u16, qca->txr.count, TX_RING_MAX_LEN);

-	if (netif_running(dev))
-		ops->ndo_open(dev);
+	if (qca->spi_thread)
+		kthread_unpark(qca->spi_thread);
+
+	if (queue_active)
+		netif_wake_queue(dev);

 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index bec723028e96..78317b85ad30 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -467,7 +467,7 @@ qcaspi_tx_ring_has_space(struct tx_ring *txr)
  *   call from the qcaspi_spi_thread.
  */

-static void
+void
 qcaspi_flush_tx_ring(struct qcaspi *qca)
 {
 	int i;
@@ -580,6 +580,11 @@ qcaspi_spi_thread(void *data)
 	netdev_info(qca->net_dev, "SPI thread created\n");
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_park()) {
+			kthread_parkme();
+			continue;
+		}
+
 		if ((qca->intr_req =3D=3D qca->intr_svc) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index 3067356106f0..95d7306e58e9 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -107,4 +107,6 @@ struct qcaspi {
 	u16 burst_len;
 };

+void qcaspi_flush_tx_ring(struct qcaspi *qca);
+
 #endif /* _QCA_SPI_H */
=2D-
2.34.1

