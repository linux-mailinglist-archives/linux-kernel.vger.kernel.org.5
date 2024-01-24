Return-Path: <linux-kernel+bounces-37747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3283B4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3327286599
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0E137C55;
	Wed, 24 Jan 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GVv1oiMn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29879135A52;
	Wed, 24 Jan 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135599; cv=none; b=rfAe7nQCxQZQ87QKzdP+Mp5hwCcj509nVVsJlJHc81Okfwn1xZ/SpB09KDnQgFW9YXPl1patKx1S7CYaE7AXkCI8o9EqPmG2Xmvnzt+47AKwu18ndl5dv0csF9rG+35P+V0bPMLzGLom3zjsbZNT4wSq6IYpedNiqGamEHFtDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135599; c=relaxed/simple;
	bh=DKx8YCk6CvT5TPKgEWvZvqxJNyIHRyULsJ4f2zOAZbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/N/ZlT071I+tyi99ZkUEa3pCK7LkpFVd0KQh3JUcsx7WrFWUki4JdJVOMuGe8JxdWcvZjjKY4jKcw65Kptkk1kQZPwveyFCFb6p2yaNcY374wPX175ejHEdzM7ctwx61SvNjicIotw9WgMYIo/GMglOMDNXAK3iqjeOCJm6JLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GVv1oiMn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135560; x=1706740360; i=wahrenst@gmx.net;
	bh=DKx8YCk6CvT5TPKgEWvZvqxJNyIHRyULsJ4f2zOAZbQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GVv1oiMnWyRdqCtF9xB36UNqK21KrJyA4vtWVReKV+QUAk6jUug5fh5S8gWmvX8h
	 D0GRy/DXzjsk+Egc5EvoLdmrNK9h46HZTId8jfUEp+NuvfBjFxNCbVZes8CUPvxK+
	 5yJYfel52IjhG2sHrvd4jALZEoXR9v5snY2rtNVrgsm2OqlSuFp4M7dyeJddJeXsY
	 /cJpqeLSjvDcF/xzyHsYj8ZCXkX87+D5/p/S3ELgpmDQuRMYIcViqDaeMibyhIfXX
	 zkQLxXBHufvEqG+VoyucMovjcg+1H+SfTxQyZiNWxUxPxy5p8A5pnMVJnAxX1317j
	 jCEXfhokq4bmAJwuRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1ro1qB30QR-00LpTf; Wed, 24
 Jan 2024 23:32:40 +0100
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
Subject: [PATCH V3 08/14 next] qca_spi: Improve calculation of RX buffer size
Date: Wed, 24 Jan 2024 23:32:05 +0100
Message-Id: <20240124223211.4687-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:PBoXn1z7n6aZj88X6gKN7TzTl6JnE/RGUP8sTmqzy6ZP1uoZVvg
 OWv9vZgB8/gRdauVDngHXYqDbrSTMHEu6IBhbPsj04adI/rlHUYZD2lR+3yaFmGLOehyHwy
 5ErWugWu3vJDqB/SEgmmvXFDd0aROcAbeH06G85J7zXe/JzzM3Tl4CAWI372nGjSHRtEkdq
 OjpSd+Ofyf/rGyf1QqObA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8aTzaSACv8Q=;D2gdFLGU8Wv2c5/OSBbKtOaPqpV
 435zqOgGrggpm0CpQpbyAT4rjUNF3jrqG5h9cjSqQNdDl70zgURr8GV6DhoIQc7VLnBVMVxec
 e1VU1ySvY6JN7Fq/p+jglJn3z/mA1c9nWV3grzxFoxtO+mkj3tP1yv9Fw5r7KhgCEXP4GOplO
 u5CYY7ZDAq2glX7gjSnK8Mcj43jnWOEjfvjtbOzUE4AZkTkzSMcljqF5K62KI11Tk4NuSykMU
 UQMfjiqYljTahB1g7kgJfv8QErLXGkIbkllENP5vWShq6nB/CkfFnptjpYRGHyBY1mgYJiIPe
 MYLEkjkEwBuGkg94NDPtjOcXTXyu/i/biHnDhutwlIlrN33TlScymWlLmTicXZDl86FCSfAj1
 CldZWSBTlSGoXnLNLE3OWBJiW+LQgLyEzHz6X0n9BFKICyGu47BP7C9jSABQEYY55N495/c2P
 If98fNfBc7bGmu3bkL8hVqW8nMZY20pWBu/CRRP4n0tIRPnhetyrTihXhqJo1IKFeHmuvjKsP
 zf77pQkoWA5zBB7cdwVAq4iqkWtMPrjubWxPvxDof8ALwnJs3AnNMgalXXkdLvHQbt6Mc21/L
 7SPwhPnFkKTV/xKTk6GrQK6bLPIU6Ev0sgp5cHKjO0R2X+5Xr++t1luIOcj0Lgrer829mQBDc
 Jx4gQGDzISqC4pfUhMAZr3VudKeL8gHjzj4n0tRONWQ1r5aDyKRsltLPDLvbTWMUF6LzRcvD5
 Otc/v9Kh9zT6lDI6L7Ntj0soFzxFcuLpNSsfKc6eT+H5SY3F8y8g75wf/UtM/EzGgJZ0rfA+e
 Kdr7OdGR4K4Z5Cs6C5mTPSZ0r/EuRSO5s/q2REspm4Khu7MsKum7DUpem2ldTdMvFs2BCVOw6
 nyODdfuTWz3Kr6m+/DOrJ+cCPR7Uohh0ZzUKYTDKIn2mJRm+GDNQj+9pd6F/dF2K/y6ZQiyef
 AnThCw==

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
index 80182f8a4a50..6d2859aad921 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -813,8 +813,8 @@ qcaspi_netdev_init(struct net_device *dev)
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


