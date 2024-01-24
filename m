Return-Path: <linux-kernel+bounces-37749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E383B4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A01C20C34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E713AA43;
	Wed, 24 Jan 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="msbJGOvh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F7135403;
	Wed, 24 Jan 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=Pzm4vJZBwp7SNM0EjjWNzGRahp/k2x3ueF8K1ltISc+J/XZmPOmvQg8Q6lGykjXAh7R0TS8PkhVCvoVGqD60J85VzTmO0JeXv0iZv66lUfELDAFa8lwA74aKVY/PFcNBhSWZhCTQ9dmwd5E200vewGJE4ZQu8JtE7RfKEPqglpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=a5awrOpTPwikDiOyOVG3aK1l4bf9XY8Ggcl++Tz/DlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rs1WN0Y84SKyiOzKDKK47iQ3viwLP9Mex2mDZEWkZsYbD3SARD3PvxWq7Sjj9vc/e81NouGhxXyNA7ebcSVFUoww+AfqXxzzgqzZpu1BJIyuTO4uIIZvw5KD3kWstm+i7+uzxHkAgURl72KoTk0I2L0pYpKOo0oi+Zotmu5dYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=msbJGOvh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135560; x=1706740360; i=wahrenst@gmx.net;
	bh=a5awrOpTPwikDiOyOVG3aK1l4bf9XY8Ggcl++Tz/DlI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=msbJGOvhIeZnY1lQSzyrRFGyzr3bQQmeY6qUSftUI4bYpmKakXWJpGZI6uhx40Jv
	 GZXVNtoXNVTyDDWWTaxzAClZo7y1xbqmQ8QzsOgnlStHDcXReiFIpdmWdG01gxnbD
	 qJGu7y95ZwBm9+ByNaLGifHEYgJlQennMnGjg8UCtM8f1IcbPpK3PMbXvGBbvPM4D
	 F7X1Wmz9tAkxOhKkCGNV53OKKz8/YGgG9YGY6Jn6DBpYYjambZoSB7Yxn93Mz+Ums
	 ywWIlnaHcw6yiEwlyIsM1/mbTC0vQ3uXRsZ3W27ZcWRfRzhAL5pCaMIgSjPalaTGS
	 VAVdykHR7VSqHf3Qsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1qlm5538dg-00jF7o; Wed, 24
 Jan 2024 23:32:39 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V3 06/14 next] qca_spi: Add QCASPI prefix to ring defines
Date: Wed, 24 Jan 2024 23:32:03 +0100
Message-Id: <20240124223211.4687-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124223211.4687-1-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V0hZf6rafJ9IERZbp0y+4Wh5HTXNAjXNZ4uOSpS7zDkXS/9o0K5
 K1CLQCFsEMpBCU98eSC2Tg7vV0v/BKounoFNmgDTwsiDzblQo/pJrRjklOm83J/XOLkIkoF
 zp9LkKr1gClWQSzbenvZi2kZMKdCq+ZrJ/Qw6bGZi35BSxKh1uKQ1gZTxSzJii8PxK3Tx2d
 +FJapMMyXm+PL21+LbDHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xl/9Ft5BOxw=;WJmBDu5UWoHf8xhT0WtnHW0zLwV
 1NQQgtGjLhqB11H9pM83WbI8UBS6UWwwaHOjtqHZQ0cHnDJcrxw9oYkRTk7erFOzigWgsavjV
 9wUBgi3xDKCM/7keQX7kPDkxt4Jws3dDYf1x+hFaMx4CFsFSapEumzmqCIOvycbN31kGjmjtv
 /t17HH3C2J8eGAFeat5XYSD02TXpP0LBd6YYrRA7Ps4kAssa9xJSV2BFYawId3WwOJrrIHYf/
 73F4CxtftGh0hevyM44B0BPDEPiTuHS3ch8UdiBLPuzwzybjDbrf+Mu49T/1oYOVZIsdloTjD
 jS27zNk2GGFxWcM08nZxw+vbptZX3OQkQtvQ04+gCchXBXEP0NGJfvAp15R5QawdTTHGCtcvm
 OQ6Sg/xMXYFSBFAKXWn9TxOVyfknBik8sLDKTPX7IG6ifWHtRauIczKIAl5EWq1P9hbu5gJKJ
 eGCiNJ1TdqiaGR0eXNGb955tH5Vd0Azi3i4X5ROk2Qnp4nafWyvnaCXFPixy9eW4o5ompHMqv
 NtpLY9BtT1b0gHbNwzZJfW90Pj9izHbSyOvPl+ksj59TstXoE4NPa1V5gugbZa16kAoFE5Hpq
 +5a8Xt8GJCjvyXTwfHvm1yNw99XWSNjh7KccVCfHMjnzuRrveEMC0gSyDa7e+XzvOKKk7XaY2
 HSEstPyG1jNimi4ETCNp5K1aiqbaREnKpiLzxA+gvxoUUQX6it2hFkJ0A4WTPYbnCBMseIOWR
 3selW0VKw17EJ4w+EMLr9L11q1LA2ksxZqCuo41nDz5M33d2zSl5Lr9+fkOvivfp1cG0Lczww
 m/33eawEd+Gcc4Ud+K9a3RQKtU55R5yb4/k1bwtfTKf2hcmTlx8+L6+LJJJM/iaXTVVsD9013
 mSBD4LH5kdUVBF99HG0gFrkpYiBYCxWogfvF76TDz++8w7rWRmHn20diqXeSb74njLXHJHyHy
 ZIHDdQ==

All defines in qca_spi.h except of the two ring limit defines have
a QCASPI prefix. Since the name is quite generic add the QCASPI prefix
to avoid possible name conflicts.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 6 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c   | 4 ++--
 drivers/net/ethernet/qualcomm/qca_spi.h   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 1822f2ad8f0d..857883d0b5ed 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -255,7 +255,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	struct qcaspi *qca =3D netdev_priv(dev);

 	ring->rx_max_pending =3D QCASPI_RX_MAX_FRAMES;
-	ring->tx_max_pending =3D TX_RING_MAX_LEN;
+	ring->tx_max_pending =3D QCASPI_TX_RING_MAX_LEN;
 	ring->rx_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending =3D qca->txr.count;
 }
@@ -275,8 +275,8 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	if (qca->spi_thread)
 		kthread_park(qca->spi_thread);

-	qca->txr.count =3D max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
-	qca->txr.count =3D min_t(u16, qca->txr.count, TX_RING_MAX_LEN);
+	qca->txr.count =3D max_t(u32, ring->tx_pending, QCASPI_TX_RING_MIN_LEN);
+	qca->txr.count =3D min_t(u16, qca->txr.count, QCASPI_TX_RING_MAX_LEN);

 	if (qca->spi_thread)
 		kthread_unpark(qca->spi_thread);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 919a400412cb..2ca25844d91c 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -476,7 +476,7 @@ qcaspi_flush_tx_ring(struct qcaspi *qca)
 	 * has been replaced by netif_tx_lock_bh() and so on.
 	 */
 	netif_tx_lock_bh(qca->net_dev);
-	for (i =3D 0; i < TX_RING_MAX_LEN; i++) {
+	for (i =3D 0; i < QCASPI_TX_RING_MAX_LEN; i++) {
 		if (qca->txr.skb[i]) {
 			dev_kfree_skb(qca->txr.skb[i]);
 			qca->txr.skb[i] =3D NULL;
@@ -889,7 +889,7 @@ qcaspi_netdev_setup(struct net_device *dev)
 	memset(qca, 0, sizeof(struct qcaspi));

 	memset(&qca->txr, 0, sizeof(qca->txr));
-	qca->txr.count =3D TX_RING_MAX_LEN;
+	qca->txr.count =3D QCASPI_TX_RING_MAX_LEN;
 }

 static const struct of_device_id qca_spi_of_match[] =3D {
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index 3067356106f0..dcecb072b8eb 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -39,8 +39,8 @@

 #define QCASPI_GOOD_SIGNATURE 0xAA55

-#define TX_RING_MAX_LEN 10
-#define TX_RING_MIN_LEN 2
+#define QCASPI_TX_RING_MAX_LEN 10
+#define QCASPI_TX_RING_MIN_LEN 2

 /* sync related constants */
 #define QCASPI_SYNC_UNKNOWN 0
@@ -54,7 +54,7 @@
 #define QCASPI_EVENT_CPUON  1

 struct tx_ring {
-	struct sk_buff *skb[TX_RING_MAX_LEN];
+	struct sk_buff *skb[QCASPI_TX_RING_MAX_LEN];
 	u16 head;
 	u16 tail;
 	u16 size;
=2D-
2.34.1


