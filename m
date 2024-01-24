Return-Path: <linux-kernel+bounces-37753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E583B4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883D41C223D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BE13BEA5;
	Wed, 24 Jan 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iY6VFbsc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD31353F3;
	Wed, 24 Jan 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=Y/uMxi5zgvhw5aU1PTAsfSngjQT2TLv0YANKpIxGJ01/Vbcj2/MIkaNNn+FYqoNDxgxUisT8sjlMUcJU66B93U82toQLJDbFAXHP3vapkNy3ScXBPdikTXi+b0cdH2vfcqxz2IQ2npTvLKvnc9oXnRzuy+x5uaqVP9yU6eIEkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=ZkQWzZ1tqQ+RtdmjwZVBTOtlj+vwXzEAwzG2LCDJfng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQbaCHb5oQS+pjvQDsEn5hj/gpJIrCUJB9cZdbtACqybaSoOgcnKtWdF57Up50sqVj+NwcU0WgIihwwY7jWo2LeonM77UTtgFjrU6fu7+MaQy/PjoQKWsFT21yEgJu2+mY2h7o6FwLmxkeePl61ihNwE9xIibPDZbSKQHiLawt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iY6VFbsc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135558; x=1706740358; i=wahrenst@gmx.net;
	bh=ZkQWzZ1tqQ+RtdmjwZVBTOtlj+vwXzEAwzG2LCDJfng=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=iY6VFbscuKy7fMaZbS4ls4F6iM/doo8A72dKzcm6G3ARJioGHEQ7U8ZFX3HXbxxu
	 M7mPY+odDnD02ll1v3EYKdb4TjXTOlncWCp1LmuyEnsYFuivnK8bObNOtQCpx4Lpb
	 8fjpfG6TTIuuGwMIIMtIBETKJhBJAQOhA2OpYnBteC7ZuDrP1McIggWkRGdlUJ1Ea
	 2/gvUKTw/XLwNr766YjpR+zfuI+ayyV6FFloaPNmowqCNpZy7t9vJjT8s44KJp3oZ
	 bCTf8Ly6B53gJia6Bumy6NFEytKNhgTxxbqNPN2aDtGi0VcGHVXwW5uId8/7UtMAk
	 3TBuCmyYEG1Y22W5CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1r3RUQ0rno-010uXA; Wed, 24
 Jan 2024 23:32:38 +0100
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
Subject: [PATCH V3 03/14 next] qca_spi: Avoid skb_copy_expand in TX path
Date: Wed, 24 Jan 2024 23:32:00 +0100
Message-Id: <20240124223211.4687-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:l6d25/OxlNTDfb9rsSl/KAhlnToWqi0QjdZWqxfWfLo1e6aJTjI
 OtG3wQef5tap9sVXOCxPq7YmyXE8+DIglZw9Bp9hWEnlDc+oTSyARKyhEKyoBEVmLE2E+IZ
 hpl4AfMxF3eo55hEU7pvRiU/v2v6L+GkTR5jnaaLjqGswfI2VhRCf6pvWEdRGbiQTPnQ/f3
 NSidEML+mYhdxGRd6Ta3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xhtu9VDwTRk=;H8oiTroUBKrKH8kvEeuyfZNp7yV
 VRl7jmuLStV4Jz9TALf8/EqpClXB/mGEJwyHMqPLAVNWO5m9zCMsWX8DnjpBKhMOx5uO1vMbr
 TKHA0zVZpze/dq9xQM5aNIjvvAAbz3CYzbklBUqYwQ2QMaetJKcLBGCTm+esYM++UhX1rn6jP
 Cvd4KB3AkBxAPVjnnYqdTKo0gEw+rUmifnilCNFMWSDcVsu9QuV/IJohpEl/pKGNHdH5d69WW
 faFmxtoHvUls2ANGluQ9zm2Zb+LlrTfvVZUy1fqcOTY3h272xvMA4bZdNx0WibXQv+V9lIZn/
 QHDabkIhXC5pt6zjr0siYuN/9cqTDvgVeuLb0xBZZixrIUg6fITwS9H2MzVp77gUq5iLbk/Ey
 +3/GYtDg3A56DhznQ+8uBn1ZQpSv4L9PNdkaexPFTtYIhoChWPOqooB2CkBClrmd5/sLYDFBj
 WX31W2/QWYXZUpokeKVmuq545a0RHjzSYTnAaG0SrhUdZ08QSQPww147Nwr2oVjlpM4QuwbuD
 DE0yvvymodkS+y8b77iqRmyAAsO2fkpkNrh+HlDDMSF00lEPRlpLIxskzHU57174QKrajuSbI
 dqyBnZzQJ7uCg1lZW39d0RmkQsi4i5xCygk5mXInJ8wgmyINJFiIoZFVFoFFRioGE+bCTYQ7R
 re7M6qbAd5k7FrczPgt8jK4g7MUqtH+4UUGVvPyuSAtogHiXVIh4Vo6an8+GDxfkAsRcGCUZG
 BBY0nLryo7mGV0NFY5m7pGGLvuwWcofCDovdl/7FVk9XE56HHtEgDpTS1DBGWfXXpUrlhZqOY
 qxJFtafZ9aZcLO5yDj6r+U4THriKzGBq9F/EgyGDdPZMdMe32/h9XzANMVmkIq2DuVqY9rkZ6
 aYZj+bOmiFi5dBmrpe1p+75HEzLwUScFijlI2zeKiCMffVLDN6AwAOeDfqfEMSVkBwCEuROhz
 Wi4/Ig==

The skb spare room needs to be expanded for SPI header, footer
and possible padding within the TX path. So announce the necessary
space in order to avoid expensive skb_copy_expand calls.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 294d4ee3b38f..919a400412cb 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -877,6 +877,8 @@ qcaspi_netdev_setup(struct net_device *dev)
 	qcaspi_set_ethtool_ops(dev);
 	dev->watchdog_timeo =3D QCASPI_TX_TIMEOUT;
 	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
+	dev->needed_tailroom =3D ALIGN(QCAFRM_FOOTER_LEN + QCAFRM_MIN_LEN, 4);
+	dev->needed_headroom =3D ALIGN(QCAFRM_HEADER_LEN, 4);
 	dev->tx_queue_len =3D 100;

 	/* MTU range: 46 - 1500 */
=2D-
2.34.1


