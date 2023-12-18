Return-Path: <linux-kernel+bounces-4483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E9B817E14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8573F283FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F72D7AE65;
	Mon, 18 Dec 2023 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="K2+wxeA5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FB5760B0;
	Mon, 18 Dec 2023 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942017; x=1703546817; i=wahrenst@gmx.net;
	bh=oTUeFEtg6tccmFigk3+uGgzU7tYf0ybllVSeTx5SFNo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=K2+wxeA5frExPYSr/1vAhsmczy/GCaREKvT0yKACWnYvP1bEHo99Y0g2qYe7uUki
	 C41ATQwVxkknJ4+JHVVsourWP2Ppa/e43KEiB4TKOQ1ZNo+Le7b28MB4vzk1rd7Gg
	 /OrsS0+mfhFbUToscO5fJ61dcTi2CbmagtoPiha1Pje6UxYHwEDsqnyQBsnU389Zs
	 3tZuTKh5eAdAhZZI98cyEleZIkq7tlWpIrVHpSVSMdaoJA6tXDv3+V8fT0WLeoi+f
	 vcQhmaX8IlGpRxk+X2tA9he65stFBhVAXfiRNIqUxLeFSJ+z7a6GbzCmQBgU4/NFp
	 C9UuRpwmAZtR8acTpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1qnB8d2L1O-00gZXl; Tue, 19
 Dec 2023 00:26:57 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 01/12 net-next] qca_spi: Improve SPI thread creation
Date: Tue, 19 Dec 2023 00:26:28 +0100
Message-Id: <20231218232639.33327-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQU9sNnFv4pZC4soSAJcOfGeWOmGKJKVUWzlgzNeoF+1Ehucbhj
 z/Rd8K5lH7Yqyc3Jkv4Z0T7xVC36V7U7w5WLWqZC4JhWAL9eewEQvEtS42Ywl7CnYETCR3L
 us0h23ZxSQ4gcsN9p8I+JN0Dx5ad6luGIUNW4oBVa+1qCG+JAMV+KIXYvVCG3Wp0m/olTjX
 6cBNWTKbdONtpE4rvRlUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9IwFr49EgQU=;nXzduPdY/FAM9z/k/RHybYRYGQX
 VOTUsyS5AwB/+Nsb9ls1Lj3udJhwxXTdaG0AVPrrEdvue5ds8t5AqVI3LgpykF59gZ/eG5IMc
 ZGIHHwsg50YmmMpaqrvyAgWZwV9jktIbOHUhciCDiOow2CjFswvs1iyMK0Ztpaux7Z0nXNRSH
 c/X0njAmRn9fYVhzawYqq9vMkPuor1IQ56oILd3XEujacgg+Wf50WrmTGIjx8xni2ssDWzWcy
 vDedRZ6zcsYh+s6lKts169KHdYmbua4kfL/I3Ljt905TEhh8IZM1kFham1QxcHNpGFSbHDPlp
 /iiHFHvWOv0BV4DIPhvLKtl4l30vOpN19DCSuafz0/exHC/fNguVYOG7Zgo9P85KdMVRDV8TJ
 oacbDalWsP2lNqsQa4ROZoMPZGGV44BjU/XQ/l+vEofz2VYF4jEGIe46Seg4EP5+DqPz1Yusx
 Xt0gOTJQvZexGQdoYjRv4B1mDe8L3SYQ+2OeL+v2pqJxDyRB6BQJK9dndMMbamn3JYS2elXPB
 yNMFoPH8nJixi7xCv8dTezPr+KqfPP4bftWbyCJ4axdr312s5cKMTV/TCAB5LOJvKSyEIN1Wu
 UBMdmrzXlyWimYOmBt8A8XczWmnC3hBw4fGel7Zl812ZoKAtBa7cDtZQoqOzbKB8J537cyWGM
 eQQpDUAV0GLKzTAdjhv+PrDGnwJOTWyWYWEBbSXxKlPI1gHCSG7vG2+FohAM8WrXDjFIjjE3t
 5SgozO6yacEMiONomeTXSGxJuuykX4k/9PvT6Irjd8omRWJ58VDS3rtt+9rIy/W8wmq/8TgoD
 Vwfb8dWzimKgSptiiE3gs7BzPp9kKpgO3lZRFW7TJwxbeK7bezc9oiIFI/4jKlbjtYJRlOMdM
 4ijxjO2YocrtfMOLH7Dd44omijbzyj/xU2WcTQh+yKj5ZdGyjGxQb+evP+qEi7T6fTAc+oAsa
 XscI7KewXUsOS2mmHStqD0o7+RM=

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


