Return-Path: <linux-kernel+bounces-41938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376D83F9CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D2C1C21879
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A464EB4D;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BgjNj8CE"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06D446CB;
	Sun, 28 Jan 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472700; cv=none; b=Crfwxhe3nglZEog8Z+z5sd+Xy9HDyaBMSbWDxY3BAiE4epGcrRSHUx6M+U8g2u8qOYL2YJpTfz9MxP/XV5x12P/PFTv59S4UXIkIjC2L39nECFltqAQq448Sln1x7tjFQCRlS7oGEQWn5shCEHxnJarG6lVUnMPREfPTrSCFVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472700; c=relaxed/simple;
	bh=9nG5ZfkBuUN5ZV4k7LbMvMOomZnYYGTfrpZMBZK0cUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4TfDZvFIi6zp2Xe/gId26ORILG1mwFkKmjQq5AKR6gJ9yIeKEjroCIl9QzGRrlU4IsCAeJFWvdijEyYDgf0BS/nAynE9iWk7eGjyz5ncdtR6cPlNdseAGlVGqA4Jkd4yr4K0KhAfncYlM7xAvz6TZHZ5pDNJaT6mzuuNJ3fXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BgjNj8CE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472682; x=1707077482; i=wahrenst@gmx.net;
	bh=9nG5ZfkBuUN5ZV4k7LbMvMOomZnYYGTfrpZMBZK0cUg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=BgjNj8CE2rG6QdmCmyGQ2Zt2YlBOgh0katb68v9mfl8MViOUQsdmWGnSrnoJVaxQ
	 +eK8U4VVZZxkBLRNa0U2SJEKB/3dgA0Y+sOTkku3ycyaUlU3xBgIxtfL9WXxZcMAI
	 nGzqNPbYsneUHWmppNdYqCfrQBilKNTyaSq3n6sUHPzeplSEF+AyjA9C1cmgZY1/s
	 l24rCYatZPbAwv+XhOgxG4CfQazsgqhuCaAkhTG/LIwSMcnwuZaOay3v7cbqAlvR0
	 HrG8tpM4NC4KK2GpORyKwxAuW2JwpTVtmX9hvPC96ITkiEUTGiAbnwR8flLHhMPHI
	 6Wd/Uf9m1MYtRGnYRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1rCnAh0Rt3-00rFat; Sun, 28
 Jan 2024 21:11:22 +0100
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
Subject: [PATCH V4 07/15 net-next] qca_spi: Add QCASPI prefix to ring defines
Date: Sun, 28 Jan 2024 21:10:51 +0100
Message-Id: <20240128201059.6259-8-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xd6H6boX0x0vPmc3Nn20WYgdShANCNE5HSgTLr+F8IBZklTlvE3
 QgxQz7CO7ZdmxLXYk9eWw3MD2m+7gt66Ss9ck7Yy4DU7tc0YqygSrDrWsQ4LnhzTpP0vrz/
 yd5InRL+oJg1xGdDHwEdl9Lo+DJLw0YzuXSo8To0jdB42vQKrMuMpaDU2jBbTIaun6fE1Hs
 jpeA6zADxWGdbGA/MHeQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ByA3BbDXA2c=;G+aFXPNrSEH7qcBlachS1bg8OtT
 A0U+V7xeROpa0pihRtTiMkxi0G82RmrEElDDTqPSrCtyGfd+jayFXdHUnXf7gEmN1HO7JWrrC
 uat4XpEj7zrNP5BD7Y4WeRuxbdxcNePvZXBBLgTpCwJl+0aezz1QV8Ys0nDelumzKBX4Ck0zC
 g99W29B45731m+k+dOogK/5X28zkM74cK4+zJY5dF1/hvwmgWWm5gCSAa4qJALxylo18S+zjv
 dYkq1DRXPtlgHVlokpOcGagb/mXOlZAbXXCGh7ylHuGacz61uklHCgFBEEVtFe7Ku0uTbPiOJ
 xGpTg7DpwQ+OzcfIAhQzXohrGxVUtXRh5vF/LRKIYPURLIy/3JHDuYfn3I3V4Rd3kPtzpuipK
 EFCsk5f+ml5Z/YEGcJYvo6NfNKYDHCBQhCLO6B/l/bH97jmADVb5gAxOpX9x2d4e9SjKrFFak
 iNfb1hO+ajKbbWUoq7Sm1aYZcXhmRXljIiK7HxJL3I1h1QzBMshcYEjVr5Q6gFGr18TXx+/au
 RUfw66FpLkEbfA1insTL0Pm9l4a7JdEHca5huXncTc+du2cUAbtlCRvCxQ5X2IwPyG7/lX/1i
 oiZOnbrNANtizIEQlO8qm/TaNd9w80JJnJfR3gVAknTMSv/Ig3QK+jK0sBQSq7oLeis+YmlUs
 bqV2er09eYPXZ6i1PE1H1Mi5Ck9TDbwjLSZ4wThfnmbXH7edT8uOOkm8EKFKTLwWqTfpeKTMq
 Ax4RZlEGVsO4Qpe4sWW9x1vP4NEfVpTPoeEciyCB4ZpCz1tk89nPFg3WfUsm54DLRar7jKCoU
 1o2E8ZOWYRuAhezWPQViUkCJVElZ44Dd6tYo8c4MZB8f2lWUkeBmqTbY3GdKZbnk2xbJpEMRK
 ui65kyIpHVRvjphJAEBF1dG5fwQpkYNt4fSxMHt/9YF5KN2U04gd4UG1HgnIbxADjUjrOCvAM
 CC/zJKMj7Rr6D9VWjOw43Xh/PMU=

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
index 5fabb40cca05..f53438c4aea2 100644
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
@@ -890,7 +890,7 @@ qcaspi_netdev_setup(struct net_device *dev)
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


