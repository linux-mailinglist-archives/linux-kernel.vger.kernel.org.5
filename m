Return-Path: <linux-kernel+bounces-41937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95A83F9C7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6DA28178F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23924E1C8;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="r6ae9JeS"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2D446C6;
	Sun, 28 Jan 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472699; cv=none; b=lT+Aj7KSSk6igmFbB9SVh5v6tXPUH48+GP9wY95AFNPH3FfGM9EnV21rRggzwNesHtRIXZIKXiuiOansdYk8Md6QZVaYEmhOWiJXbN1r5zBTU9sWKkZU9+0BurERdNHnBr/llM/UhJWVnzPOtNux3vVUivxBhbxZgfgRtoFYZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472699; c=relaxed/simple;
	bh=h1bRRRY/FCZQLy4wDwHzxX7GldpDd9TCNFjh9pcU9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3j5uCcCu/cx0TfuDZZn4eXKRmigTlIeyVy0KdKX2xKyDK9XR+Hu5SyIj2wTc7Py21SuFxkmmE5PWlnqJWTXpjMXRxFaJ4L1vgRzfNTi5igQqm+5RAQ3uJrKz1PZxakKmFqyTD0ca/wk5dIdFj77pBfQKvt1WGv1rZv0l3CnYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=r6ae9JeS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472683; x=1707077483; i=wahrenst@gmx.net;
	bh=h1bRRRY/FCZQLy4wDwHzxX7GldpDd9TCNFjh9pcU9A4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=r6ae9JeSEnQIjEUur+y45c+7j56bya2DGrIgYoGIcsD1eCBR60CLdMki6D6GABvQ
	 b7wQaNmr0Yctt9izc8YEt1qzL8MF2AAsBgbUS/GBRiAXoe54BmCx7uTkHklgO6LrP
	 I60YQ09dxszUK9g2HA4WXLXVb/QILMo70TqVJWeIadgW/XQtBgVehnvewHNlWjvnX
	 dO1LWy4uZR4IP+1gl3RtYqc7LZ1PDO5GZ3LmgRrvuNaf/5HT365nHpjeUZA+quUZR
	 EoRt6efjQMVK42s+bePog9q4Glaq9mwm6xceTD52w1JsONF+IhB7UvjA4LCsnhFw+
	 N7kUBHQvaP+wevb2LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1qglmp49Vl-00nzy3; Sun, 28
 Jan 2024 21:11:23 +0100
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
Subject: [PATCH V4 09/15 net-next] qca_spi: Improve calculation of RX buffer size
Date: Sun, 28 Jan 2024 21:10:53 +0100
Message-Id: <20240128201059.6259-10-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:GpuL5zWeB90TuO9uSQDgdEb89KM9M+6A0tu0E6ZGeFrbn2VEh54
 OylkLOomk9qabeX59uMDRiNsskuydqlOKHx0gCP7tQM4MzM3YPbcbfNZ577ZFr4Bu91cMF1
 36YAe+tbJQ+j5zSHW0ameSlYhhqe+liK4AFpKLpEEfokNrvX9NnMhaM2uhteuss9uHPs/+5
 MIn38seGJbNJutZUieqSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CbkIpR0cq8k=;X2z0o+pYvxeEgaoaRyY+zRdtQyT
 apwhvG98UPrU9OylE7Vl9lVbBrAPx33/cNI38hNA87ZrJ9+BqNVn3WYGi8EFMgQ1VR+WHZ3Qa
 WRiB4p9iMbVsgIlWwMQuVwPVEBD/MMC9iUGgV9tqp/7xTUOYqMWgJ66Od6u9v2774hu2Ny8+N
 aAGl05kyOF04OiTU3JcR5qgeCJ4ErLRsEsKtHX+9aIZO4VhTO0b/vGKDrdWpPmD8yUkLfsYJk
 v6tRvU8YX2oeMtq9X7d8XzCbheIUzZliJFjT9Facty8u+GRBNNKRpBihW3ZO2BMUmgN9nOCje
 gZsa6L+qT5GsGhd4rgR5GQxbZlCFoScuqqAUIbYJ3EqmQuwFg/nqCl+mGkfVHf/6lCsUNnoVl
 BvLMppVYZVq0NovnvT4NKMMeWT8Gq2SbfcHrrATWfmzhM1WWzWrDL6XbUt+PjRWIzYkxwtVbz
 w4jA0yJ8DIqPrI+gT7Za2jaX4x+15act1PosMFc8VmICiH9Oun3hT6AKg+d0hXIduFH4/VjFF
 NQ4l9YwfZWxKi5G6XNeV2EihsAHZq4uBa1rBzY2eFCAKY4OgHA6RtMUrGwUcBLemdmS9Jvzak
 Qs6pmtoc8Hcsm1FNiB2XB//ZLvjQVvPLCargZNMq71xBm81D4qpqaVTzt/GAe84yJL7RQmPnL
 BDOq2wvzvxOHdpocy7eGPOSSAvvATGeb8v5zSieExbQExAkPKyCOKWklKTma5EeyELCzNd56n
 fBiZvPhE6Tm3s6LMSpvzRT0zvmtQtEegP8Fa76y2VIDeDzl2xq2qiURbVkNQzdvIS+uJrlaiv
 o7Wd5e4zz4iNnui2F1WF+ON2iuo2dg39OTuOVVaDihwAGwBo4H35WdN91q0iJJ38WDYyBpmBp
 VQOjYcwtuHgLekBUpOa35YFMjBS1itrCeVmDSzK4S2iVHXz9cXSRt/IcBrhXf3UuhkK6UU7Lq
 q4Hnsw==

There are two points with the calculation of RX buffer size which are
not optimal:
1. dev->mtu is a mutual parameter and it's currently initialized with
   QCAFRM_MAX_MTU. But for RX buffer size calculation we always need the
   maximum possible MTU. So better use the define directly.
2. This magic number 4 represent the hardware generated frame length
   which is specific to SPI. We better replace this with the suitable
   define.

There is no functional change.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index c0f6bd3d331a..b35fabcd488b 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -828,8 +828,8 @@ qcaspi_netdev_init(struct net_device *dev)
 	qca->clkspeed =3D qcaspi_clkspeed;
 	qca->burst_len =3D qcaspi_burst_len;
 	qca->spi_thread =3D NULL;
-	qca->buffer_size =3D (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
-		QCAFRM_FOOTER_LEN + 4) * QCASPI_RX_MAX_FRAMES;
+	qca->buffer_size =3D (QCAFRM_MAX_MTU + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN=
 +
+		QCAFRM_FOOTER_LEN + QCASPI_HW_PKT_LEN) * QCASPI_RX_MAX_FRAMES;

 	memset(&qca->stats, 0, sizeof(struct qcaspi_stats));

=2D-
2.34.1


