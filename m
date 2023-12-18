Return-Path: <linux-kernel+bounces-4480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7F817E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AF21F24AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB242768EA;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hXiW6q7l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398F740AB;
	Mon, 18 Dec 2023 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942018; x=1703546818; i=wahrenst@gmx.net;
	bh=KNA5Ey5ARW1f17DhRal4nGxTPTGg+Xp1KyKMJRAqqSs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=hXiW6q7lbfDWKr9QxJAY3ncDDLJzNl1SqLKLiRdnsLUGU953XOCsQsxRNScuCGJ/
	 ds4DpAxWf5bFUTsXxmxGxyWtEpF53DCKXANuRSjRIjfy+Yf+WG6wuhFY5WVLrOOdy
	 I1g3kJKz+V0JxdhAfGgbYeiWbGgTBGz1cGvdqOEnn2gTmL9EPWQqaFlnPIH7ucIrN
	 hP/rkixXZg0ZgBRmIPH4AAg7aBB5ANWKKY5DjlCT4y1nl4I+NCCA/jEI0TjbdSKN3
	 D9TjjPmZzjC37LYXzqjAsjxvNTIqPb44kZZnK6Bm7+KNhFsFhRAvOa0vHLwv4aImt
	 9p2JeHgfRdekTlN2QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1r3JkF0zOH-00wjsk; Tue, 19
 Dec 2023 00:26:58 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 03/12 net-next] qca_spi: Avoid skb_copy_expand in TX path
Date: Tue, 19 Dec 2023 00:26:30 +0100
Message-Id: <20231218232639.33327-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Yzr03lEen1C7q1Gdl24/3jQPKEPo65IOvU8wDQLrXEwlNrWNAcr
 irbiNlqS8NpoRv6O/ziAx6nTXSxg87/OLSGHh7cxtwKBNiB+Gus7ljRB7+PtKNCyPjaRuto
 Ul1kZUaQRCR6ApbrIheuLP8YMIleTfHXAzlm98bzHTTaELWHaC3YXcy0AUcv+oyS4mMsa4W
 CTK5mdkFj7BIf0CC0Q78g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LG9IO3+MHzM=;MX3gm0H+T9MTYmbGA/EWXT4ZuLY
 jVTLMpilaxvg2wcLXYtrSZ2H1Vmmmc4eyRdCzJF27Q2PTVL4O/tOCw7fPOYpxEpkBux5udzGI
 dOt1A80MR2OS/DJ5zl6wsnQpFIUdxApPqPjhdyeeSH9yBosawYlGySx9/b4+gfDNMb3gpS0ne
 v+yU2pgqq0bWgyAZM1Kr+yMxDhJv916fqklGOD20wKwe0P2MBlomvuRgSvm2t1qZq248UqOtW
 3JpD1Zkct3YER7W988DlsxmvMpQJUEEBXPcaBNx/FR3IteyCIPJR3ZBQxsGuqgL6HmuiGJ9S4
 Kgd6zBocqlX3foDo99pjPtARndA3o3TywoPxoJUd9e8x4AG4AVx/JtmzpilL86fKMOw7bVqZ2
 EGCR98A/jLuNzn9VUs9i6PDYhV0MhTD+oJmERJWbOObIM1Dqr/d2sFCX7kACSp0ia0QtHaz9h
 g2MW5iRkfOvHTLSvnd/wRUooAbLsv5Vp6TLxAd+yZ8kWYYJ6UNVF64tt7lLgYp7Xn+hXp0Nne
 8kAPew3+Odhkhc3P5JQrsiQlSgIk1WUNhgpz2MeHEoxJEkQsFRZCLhSdPjygIVuzaSqy5I9Li
 OlLDRU2QMdB7kAVzxjuEJOvJG/IkscGAyEvgJljFIbdr/xw3aU2ibQrNUd0Syxta2bSuelPPV
 uAyCdPV1CEUcJT+krY6CgzcFU2GOIOa0iPFnt0KWdfovZi/IUEo/CUuTDfCCdoyjVmL9UjTzH
 dkKmesWd2mN4fivjNsAkrZ1f5YoPDzw3wDUnKy9NgAzjUcFII6wXryGhHWlycoON9w5beeSV8
 pVmmi2IQWbI0aqvn225YIIBqnoVhwtCt1rUomDi8HtNPQsfe90pqKxs8qBCM1V15QkvweEU7I
 bkD7918oq2AnwQBRULbWeQLMcIToBV11YfpAMMl3NLFRX/W27Ahhl3zOX4YxKPXGBjLw056Wx
 TqkdT86nnbV9bJzZwoVOB3vY9dM=

The skb spare room needs to be expanded for SPI header, footer
and possible padding within the TX path. So announce the necessary
space in order to avoid expensive skb_copy_expand calls.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


