Return-Path: <linux-kernel+bounces-37748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA683B4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC541F24BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A2137C5D;
	Wed, 24 Jan 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XwLOTZhY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01C135A56;
	Wed, 24 Jan 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135599; cv=none; b=MJH7xeciJI1vv3kHVA3Q+zTAZYPorIn0/mQ80HDgZ36so1lAO4mJqDhN7thJvolip1FVSxO7RTdPLKjAZczxd/9mTf/RIBQ/1iylPmmuxN5zWP0pVmLwleoVly0ZA/MYBrFxNnNBJkGj58vqIHhUesx1UrFVA5gcn/OqNS2Zwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135599; c=relaxed/simple;
	bh=W+XG7gUVjX2CJXaxEMB61egMLVz4lNEs6++C8B0jnZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+qA5Oqck2w3XvWujeORyxUIB58/ANK8wA4jcAacyY2av/ULI49AXPCVn+Kyq5b93KSFN4iyD7X90lEX9rlnGN4kNc+/oWMxgQmv33bU+pqOiTdTnOGStUDt38NuQDBYX2LAbrSiBm5PqfBeb7UncxWKargeRvmfMeimrKTsgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XwLOTZhY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135557; x=1706740357; i=wahrenst@gmx.net;
	bh=W+XG7gUVjX2CJXaxEMB61egMLVz4lNEs6++C8B0jnZs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=XwLOTZhYKGcOKVwX/KTtIyl2EZYGLncjwnR0fJeWGd0uId7TE1noTkKyOfeXv+nn
	 pFXDdPGCzBFS/O7+OI+e71AmtFOa8j5qkdqQZcg1MGItVefjDSbSz+HNeWJPLTksb
	 1Asrr5UCSD8+7YlWaeATw7VUFALy6Eidc2H3CR7Bv24vc0sXNjd84NguczG02EAcI
	 /oQiZnbalzbg09CpPD3qAiQXtq47URTUpvH/UApH8ynmXA+XPVzFL2t0CvTiQsOZF
	 xy3AjVDvyLb/aDwlvacLBPZReR+ZWTeGy3Cvp7OZeC8XJU/Fs5E0xJABHxt8FPwND
	 70j0mWrtQyCFxUzg5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1qiBie2pOj-00p20r; Wed, 24
 Jan 2024 23:32:37 +0100
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
Subject: [PATCH V3 02/14 next] qca_spi: Improve SPI IRQ handling
Date: Wed, 24 Jan 2024 23:31:59 +0100
Message-Id: <20240124223211.4687-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:aL6VB/gYI/E9S57gwbqxv807a1LZCLoaNBRTrL4zhQqVL3P83zu
 gb+CXzh1WmHLfPfRstfzmjTxREd3Kqww7xpEZz9L5U5kB6aicd5dQp/slzKw0FVhCHeLdw1
 SDL01NjMwn9pE4jFfg4bFAizsVNxLoqYbdK/zObzwkoMvZUnRykI1PryhxmR5QwsmIYsSmH
 /SdWxVmOGsc+PSeNFTlow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PpK0zX9pg1Y=;GZXcBir7R06/D2XQlG2oEyGhOCS
 grTnmSIjwzsyZlg/L1yL9OwCx+WXOYzjPR85KZwn+t0h1G7jOICV9vVRpshcjVmtkp1C/dWES
 fuuEyEn60yE9xuvNOcMnxwZad/h5hThCWLf4VITkMMZRQyZdFzgsyQgL86kW9Mrox2jcesOa6
 HbowcOkhoOO0OpLJGce2lZEscXGLkqm6buCWJZ+N/Gi3OEB272iUUolqM/IyhHkntHybFrhdr
 kqwZAEVB2t5gPj4MFfJXFWcf3m76ccbcR6OZB/cnjylhR74f26gmgj8kP453pqgWTeFDfmjNF
 45uXxFYrbfen2+7bA12Y0ubreazyrkWM9JO0DOL0DNkvLdKauzTlJdBVnEATj3XUndisiJ0lm
 W89MKOK1C+gUnUb7/76M0r/KYOIkh/ClhIbqJlISNcvxqkg7Pk4478RfJ7DH7UZghrzAT8xUL
 60xh8y3rElSUB+pfC+JJ4CebiyUlGeZ7nyV9W9v57nhzKXSTj+Nz2TCPdXFQn/br0Y2T24LXN
 +L46eDYcbG7CUUVAbm5oA/pdIzG/owNcmXbf36W8hJMks0MXYcOKbiS0qP9n/rJL5p6CI1tb4
 BAlyeqEDWBfeL0QtpqCC5fFnYkHkFSdCclmcRLkgnS7ggcmMuKZ+KENmeJcvmQCANw6aCki6N
 F7UT64wyqA4NW7bF8qAsVg+3E8oFHv30BM2indy+yQk3IK2ieuRrm98/vdj//nffrXZEPbgz7
 QIN143ThNSgqf31Zf3LPjaI6Xn/z4DUgixCqkU7fS1WcsvZLSzTuHTXlrCqfPW7OvMuzEWHwi
 PY82GPr0BDSLGbCiQ3T8HZpHmW/p49M57oMc4BBCLQuBxYxNdZsw4Nu/0CI8XPjYYp1O6kKxT
 Xu/pmZnk7LMx3UgOXx+CA5AVcJIJrUxVjvR3E9igyb2M3n7lw2DvCuEZnLjzJVJB8KcvvZjWk
 YHPOng==

The functions qcaspi_netdev_open/close are responsible of request &
free of the SPI interrupt, which wasn't the best choice because
allocation problems are discovered not during probe. So let us split
IRQ allocation & enabling, so we can take advantage of a device
managed IRQ.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index fc272ca7bdca..294d4ee3b38f 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -687,7 +687,6 @@ static int
 qcaspi_netdev_open(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
-	int ret =3D 0;

 	if (!qca)
 		return -EINVAL;
@@ -697,13 +696,7 @@ qcaspi_netdev_open(struct net_device *dev)
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
@@ -720,7 +713,7 @@ qcaspi_netdev_close(struct net_device *dev)
 	kthread_park(qca->spi_thread);

 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
-	free_irq(qca->spi_dev->irq, qca);
+	disable_irq(qca->spi_dev->irq);

 	return 0;
 }
@@ -987,6 +980,15 @@ qca_spi_probe(struct spi_device *spi)

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


