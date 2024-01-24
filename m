Return-Path: <linux-kernel+bounces-37754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146683B4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5781F211EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D513BEAB;
	Wed, 24 Jan 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GeM0OEty"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62B13666B;
	Wed, 24 Jan 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=o2QNbmjVlLirQ9WVMyak0/W2HoTYDOMwM3Z+WkpJHbXZRzaGFvBmnfP8hg4u9X6Hr7tsZF+ZEXTBklhzJ9BweDcAtiubW4KHBU6HYrwkmrN09ghcGSpCkcYicM538ErEfcFPQEXzVYvRYupZOQI0VUWHLTr8vmungQS+Rd2NXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=oTUeFEtg6tccmFigk3+uGgzU7tYf0ybllVSeTx5SFNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gK5GNtt/WPj7pV/qhzDGg3yaOy5QSFzBFQCcr/8g8gzmWwJMZuiJgxeRSLVmquyjPgJaR+SoibQXgem8YAq5NSMfzTB711w0tIbmnYe/Kg9P8G2BZ4wUyEfRmT2oNCpSySKua9ZWiPBCg4pRimJ9aeT8xHGgrSSr4ezrNNVwpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GeM0OEty; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135557; x=1706740357; i=wahrenst@gmx.net;
	bh=oTUeFEtg6tccmFigk3+uGgzU7tYf0ybllVSeTx5SFNo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GeM0OEty1WprvABKm6oFt6ei1Pa0ywWhkGTXRAnmY1cdp1YHsvrj2RcnSW9ibFSF
	 /FXA9akbsLYe3HVPuGGt3GZMrL4jmNyTuFMnvIe5mddIlDkbYzShXinm1Akb4LO6/
	 GuCqL7aLAgpQVG/InJ33TnJ+G/KiHL0OcSI4Mj7kJbVBfiCeSBp8jdXJQXiA7UDJ4
	 zRzuJBK+cnLi6Qmrj7w6K2PHFE33cZ0g84zj1Up2U5wWceZZcoxApUtvKjjOaknj5
	 hytPfUS9o/9/MomX+wqD/O0621Ru6Mbr/1VnYHJqhC3eJ1NtqTu36mUQUblMT4jsb
	 bBVoUmmk9qRjBvJaZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1rnkam3dNs-00L088; Wed, 24
 Jan 2024 23:32:36 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 01/14 next] qca_spi: Improve SPI thread creation
Date: Wed, 24 Jan 2024 23:31:58 +0100
Message-Id: <20240124223211.4687-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:qXB0zT9UcdmILQH3Ox0z6aqoMNMu6aDxj+AwPV4yoKpEJi8lN3K
 w+AZ541wA92PBNpWcSbGSnfIJmI6kX1j9G3g6AniOlxi4c0cuHBIuplQNLlx4oBa2Tgj+cT
 sb/ScNqvQ0el1HJHJcjxr6HCpWozpUR+5KO7NJBGRs30Jeb3HdZrHzuHo/8BXIXztSrSaMe
 LLt5tLBpL//rfABNHY76w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qDhLsbAxpQM=;qo1pRUbvoR/eFgttBz6l/3EaWWn
 4JDI3wPNsR/ragy2ItG1UTC+Rtv6JYj0tuDr8b8gPD6ar8ittogMU4AQKNJg+7glG3jw0136L
 T4qfd6SbSLwXIqrvHOwN/oDIw4D/oeRtzm7kwBijlkZvL5zwMbs72XORqhppkobflEEhO04Hr
 vQGxi70lPdKaId9zaigP4qEs7OwZC/IKWnvO9m/xMtKbWYggchPgOT4eMIUd0RcotEX4SrD69
 850/itSQQWfUKxtSNfT5myRoKhXHfVOS6aKt8rEN4HVIzowgtkmKxGUWfzBz6wHOpg0Aj5jCP
 vCY4Hacte72Ky+6hx8e+AThf9tcvDl1vMfOQ5UCvCWDP4gFS8O3LRF2JOAsBZdM+EEexZifRy
 H15xrACsmJNy8hT+p2UcJlGZXNipiB/snezsee13Zm5iQk0i499KLslCERwwFU27JW6K01qgd
 7eu/OwyCV+9ROm+5i68/xCU0oGxBkecQ1ffCBaAjoUA6qCAGO6VMZoj0HIlCPTuDpp4nKVUak
 li1xYruWJRQBCWW4bmAnyYiH+2flX1QFn7LOsZQQrfIWNu0SuQU8XMkhn2Yq2TjOCMqXcGHA0
 NzVWJbyZWj+k+3j/DC1fbh1qfZuQmDAewnXEWqwWtbUclo9zu27GCK6cJorvDo2STan8+QmSZ
 2NmkxaRGZ58a3AkmP7zL121gqHbxX8T52PcRR12/3UHWq8+GNEIGDTk/uOrZwz0OPqQDiW1bC
 Zw/dQ1DRa1LBCjz99vnvNobu8v6mlHlWrst2Sk7A8DB4+68FhqKiEqVlpxauGEg+WgUlm32EI
 MLadV0YgC+x/dh1hZXyf/Eb2iBrFIn6KrtPzox53u8BzWUjj+wyfGBQ6b0jGZmDQee/tNtnbE
 9akalUJr2SG7d7EOlwoBmMRQF0NXJYGhJwNpva1yS8jXjEupMgPxIt2zypOZiQ501HUxYNKMC
 +S9jr6ZNEQillpmcO6OlBSpJIvk=

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
index 5f3c11fb3fa2..fc272ca7bdca 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -697,25 +697,17 @@ qcaspi_netdev_open(struct net_device *dev)
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
@@ -725,15 +717,11 @@ qcaspi_netdev_close(struct net_device *dev)
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

@@ -825,6 +813,7 @@ static int
 qcaspi_netdev_init(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
+	struct task_struct *thread;

 	dev->mtu =3D QCAFRM_MAX_MTU;
 	dev->type =3D ARPHRD_ETHER;
@@ -848,6 +837,15 @@ qcaspi_netdev_init(struct net_device *dev)
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

@@ -856,6 +854,11 @@ qcaspi_netdev_uninit(struct net_device *dev)
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


