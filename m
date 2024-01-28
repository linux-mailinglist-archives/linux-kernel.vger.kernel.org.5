Return-Path: <linux-kernel+bounces-41935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2883F9C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ECC1C21241
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA54CB2E;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UrR3EttZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340E4205B;
	Sun, 28 Jan 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472699; cv=none; b=ofVjrUgRPGfrUm3xTG8s8UapWH0XoBip0bM1/BbOayQdvZSvQD44aIPZIgrH6hN/DDhdVYmChUCQdOnZojYG6VF57pZjSG9bcojbtWcyPZBHQMiIUXcns4AVvFfD7QlLFSOFkY1U/BAceUqFGkjEqsWZX2s1kgyJM/TNBX7uz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472699; c=relaxed/simple;
	bh=EvWVaRec1ycNuQtUFFeYTjYmPaMgYbG3dLiPYQu5/tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZJo+vtBm+q73UXHIjQTQEjwcUY4IKUnWVtPW+WPSSEczGThFzqiPuYAsXXS3kpVe+1ARVdqUmcE60pFqHTgu9PgxEqdJqScDdvWTi+W9vr+2pBPgFcajQc1pRQpO4BteQBmshr7mzaZpPA3GOrS9VqRuovWcBy7DIMc4r/W5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UrR3EttZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472680; x=1707077480; i=wahrenst@gmx.net;
	bh=EvWVaRec1ycNuQtUFFeYTjYmPaMgYbG3dLiPYQu5/tA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=UrR3EttZj3Z2wsFOp415PThIDGs8xyaaV6WbV8tkqbW2cQFlQ3e/G9q+wh2+BdR5
	 EPadAbx0epd5fRN1+eEiqzQsP6vl1ds8nMLi4P2AFbFkIIWmFtfM2S1radAwJWbTW
	 4TkxiYtEz70dRLJscpQoTcXbI4YWMpk/KFZT3uw94ou0jgZhPB4dLwhqZKDPlRCNX
	 Gr2BgNK3R9QbvAqvklTN4DUGZKscmRX6y1KAk4HrsXpe3d9B/0ZjTLvA0pBl/BBJ0
	 ownLgLWSxiBCMAls2UW6X+n/O3+RUW2RcrOE7Y+UfafJ4cl1jyEUMcSiQPbV9Yx0p
	 OZGqXpgQlfx92A2Qew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1rWwtq0tlu-00WSqi; Sun, 28
 Jan 2024 21:11:20 +0100
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
Subject: [PATCH V4 03/15 net-next] qca_spi: Improve SPI IRQ handling
Date: Sun, 28 Jan 2024 21:10:47 +0100
Message-Id: <20240128201059.6259-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:0qDF2kdiWLKjmfUwJYeiHshUoj2sGIuQE7pBTDcXDxqU8T0VUo2
 rBGqTThab3fjaL7hWHqHZLV/QY9Une6vElWDWBASFZpJz5UAlWZh2KWBZW2hlQOwxAWaj1T
 Z7vWX3PJ0mLOyB96nqx9GjwdnJh8cyyzjhKtO5i357PhCkGKZO/y8+0q3IxNn5g/CJGzlJU
 vA3EKRXebpUMtqdHi00Xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qugKrmXZGRc=;I7ZoPvnut6nxSVLeyeeLCLFwlL9
 uuE/hgVWJs5Q0jTUTqmz+lowGz5ZORbsgPX1QWgAeRhm+/7CPjdfACuIz46Iq6KKvmw3LZlD4
 bMfHfHj/oAeQNfHIlcqlDgFgJnm5QhMDTOPH7twMfJfMvGaaGEJXBPeNpauu3Nhwg5jYZaPJn
 Vrj5pz53vuguG11PoKBEupBwqZkklkeUGss+IOQ1yvsbwyp5n40RpT68fN9qnu2Y8mBy/1NbF
 Bu5K8GqzCKpiIsGvlm+cwV+SJyFT43Yc857VmHKWHOKLuDM6oii57TiI2N4qmnXVpzsvn12EP
 jof2Xv4zkfv2d8Rn4/2rOEQRsfLCaohQY5L9WxEHPfbT67pcRwQVpatcmLrOhXGnIS1Wt/3uM
 RZ/XGX+9Qis7Wv+ieJPr/FUJ5IfRDWrstB4tpxKB/mVlyZeDxzklKDNTPq+8P+Ec2xNfic2sK
 4ZTjp+eMW/eLoXvDM8ajJYmCttZQadm8EoaRnrqVGU63gQzc7f1dwefRoJ+1rqAUvJb4BU6Pf
 ONRZjLYn1TNmFNCeG20XqcueVl2L1x/RfLGIJofX46h9FFOS3Ut5QnY0j4tUuAZrDRABheaZJ
 sEW7MA28IgoPUkp8lAEI5xWaBKak/V+Qty3cXGckBLWu3eqZs/b5Hoy4hlRu1FhxYf/TJFpHu
 R5o7mYKHeZIoDuTtcBvpCwYKh1opFMG6jhm6PyZvo6GRLxZTPcBscbiwIVAD+JVPssFvcP90g
 ftxWfivIXKIOon9FfzezQKQ/4J109zs91SdvmPYvt9F5MOSj1/7moFaAAMDO6PnwEpWJbNTCw
 n6tyrpiRsOBk8AnwwexOeRcErvVcevCN8Hs5tYQeIMC8wb+xBMOM+vRG3hWc5iBL6gEV0i9mA
 bZrJ1IzzkpDbiuKv8RHse7bs7YtmjX3mPWsZCtHSXOFrmSi1qJzMS2Ix82VGVJtQ3SkT6Qlic
 0WmxXWmNCKSK9OHhwjfduOz5wpE=

The functions qcaspi_netdev_open/close are responsible of request &
free of the SPI interrupt, which wasn't the best choice because
allocation problems are discovered not during probe. So let us split
IRQ allocation & enabling, so we can take advantage of a device
managed IRQ.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index fe50c2dd7cc8..3f7e38a11ba0 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -688,7 +688,6 @@ qcaspi_netdev_open(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
 	struct task_struct *thread;
-	int ret =3D 0;

 	if (!qca)
 		return -EINVAL;
@@ -709,14 +708,7 @@ qcaspi_netdev_open(struct net_device *dev)

 	qca->spi_thread =3D thread;

-	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
-			  dev->name, qca);
-	if (ret) {
-		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
-			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
-		kthread_stop(qca->spi_thread);
-		return ret;
-	}
+	enable_irq(qca->spi_dev->irq);

 	/* SPI thread takes care of TX queue */

@@ -731,7 +723,7 @@ qcaspi_netdev_close(struct net_device *dev)
 	netif_stop_queue(dev);

 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
-	free_irq(qca->spi_dev->irq, qca);
+	disable_irq(qca->spi_dev->irq);

 	if (qca->spi_thread) {
 		kthread_stop(qca->spi_thread);
@@ -989,6 +981,15 @@ qca_spi_probe(struct spi_device *spi)

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


