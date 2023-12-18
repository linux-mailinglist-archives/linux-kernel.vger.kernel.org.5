Return-Path: <linux-kernel+bounces-4491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4F817E20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61682810F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BC7EFAD;
	Mon, 18 Dec 2023 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CncXJ02A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D69760B7;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942018; x=1703546818; i=wahrenst@gmx.net;
	bh=JLNqr6ZdMiLbFP5ekzjOP/5KpTq0M5KcUbZp0TT8Gm0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=CncXJ02AqqjTOcbeuX8hcRCVsLgrjr8BHyY36POz0LMVvALOt/CPbceU0DjRTUjJ
	 1XYToLnjKfxDY5ZuH/YYEobjW+W0JwHCS/atyY1JaogfikruLQXAQZaBJNV6EUuHc
	 Jp3okIA2zIpiZLtwQlQQrV0Sp/95tGzhKfNy6ekw/RNBbOFQfBLdRcwz6vliGLfyi
	 dLMn0Fd32JC7vKYxMRNT0PA02qDMJHAN9IVR0MIlkjK5QLu+sAkwXpueSdc5Pi1p5
	 ammkSvNfqDARZ5HHPPY6CLP24pXJqqqL1cY09knq2516YntVZ7/AeGg7fdksi4F/6
	 bpflcvTaqRzgUjs0mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1qjc683n3d-00cz30; Tue, 19
 Dec 2023 00:26:58 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 02/12 net-next] qca_spi: Improve SPI IRQ handling
Date: Tue, 19 Dec 2023 00:26:29 +0100
Message-Id: <20231218232639.33327-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:YNUq4RcgqvtoejMtRqfuTmRA1/REVm8+95WBp85WCvMxajvRE5p
 c4wadQTGa6NT6pIotebXk9S4hCOgW4yQLOfh/w3zU3QssxlyPn2T+5EURnDMraUm+1my1WF
 jUEKS4x3+b/6mPztMfKDfYmoHJvMqHJNvaUr3FWoYRJqE2I8kXERRZZOoVaAsZTn2wS1jbI
 f67jyqzwjVgvDtDNDfkSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GoZU3jbR4jM=;MMz+ggwU67O83DoXEz9YxTGeJv3
 r5kdGl+QOD80LMyw03WflIM4bnZODYRh6SLbRyvS3VSQEtuziw5dwICx0FyoN4DNFkS0rfk89
 SRtuUwZWAN4bIq4HejFfswbqycHkTUUDTZjb7adP9ns+xwlIMIiBppF2hX7aLQuSrKahTqazZ
 MEEZI/X0pVBCDqIGxs6P2z+Gotj2UdG/Nb5Fn7+5FvPZNaoEaZ1tzKIT3lmF/QkNuWY9zUIgy
 QuVmmxb4A6JvgNhMATzhJt8UsAhV88xCgnS38e6US303w4qlsZEU5NJuMG+5RdmyeTls30Bdr
 JjkdR4ZoOPfkvJvUuIbU1imIPCjxopO3eSda/XaWW55Qx+Rpv7mSp3Tgt3CWHQ2P0DA1M1WB4
 2MaDkOC+Sl8AcvNbcyU4z+5hOjirUPdGpNn4HUVShISQ0kMB3ppa40SsfsI0jNqRvgfHovNbp
 MpHAAVbp6Ps2rHdzK09N/tEUxo5YPv4pOFKVkx85vPS98MOsswe1CopYCzv/bwfd9NJOwBp50
 CpN7xJaEZRm1YLbhq4ADBegtR2lEl1IOazryOM+JIcy8hxFcAfBiEYBGxNDHSbAZL2tHXPP5s
 x+2vcqMrqy8Y2a7fkeFKJY69ycPXRScb/HBZGQfbVYaA/hwEG9ult+M0Xzo3LEL/72RTBnnAE
 BD1o89Db403zm6Tnmo9aWqOkLiKc3DxS/Pn1qDZfzd9bVvLqXD/IZ1f+YIYSL/+/erG8PJe4i
 TECOEs6KprVKh6ltB8q8LM1I6fSNwI/Jml2bi+TUYKh3FPgcGhX+jzhsJx3VZngjBSwyFc6oS
 vR2lvZ559p36kPTgGyQpmwui/wZGabQKrxzsPR1IIQh8zo/r7snXjHD5gQgkP6i3Lr+juM7I2
 WpeOwPs9f4LLtn19Vltkm5hb9pjLVqVth8hcXTxouPa6o6jxpHPVP9h4aCW04yzMH7DiwlOjp
 TdCcXyq4w4/VskjSN90QbzEHn3M=

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


