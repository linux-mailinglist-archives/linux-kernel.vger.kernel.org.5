Return-Path: <linux-kernel+bounces-4485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D160D817E18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB241C21E22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57A7AE79;
	Mon, 18 Dec 2023 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="jIg1x+WX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8A760B1;
	Mon, 18 Dec 2023 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942019; x=1703546819; i=wahrenst@gmx.net;
	bh=NLGzEdJ+SI+lSaoV8ppjG5PYxBlLkFmauKl8qe4TW1g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=jIg1x+WX6JYFikmWCcJpKPVpxY3gutn7YrL5TKKftjtG9eQfhzXI0VpFP1SEbbGz
	 dvkw4PEYXmeVqwCWrYe1fWvswue+uzfrvjvldC4m1UjTjAJMa6uNCjlddZWTeEZIU
	 uqFHVi/cFSjOaVUerojQ/CML8J4wrkLAENRpUXf2sehauVHfcWARxvb6h1OTtfR3u
	 6ypLtXdPONsdS2z7xm0lkhJDVHHc7o0w24Hb+DYYbbmz+5rwFPpDNC6hRIhXjC4y5
	 7wdYCMZqPJuTK6LL4agyfByQ5PoI6o64gY21N6BSb1P9Nslk/rkisz+kHfXpQXAj1
	 qrDKXj6sWa7zvrJdlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1qsj3F2VHa-00m5qn; Tue, 19
 Dec 2023 00:26:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 07/12 net-next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
Date: Tue, 19 Dec 2023 00:26:34 +0100
Message-Id: <20231218232639.33327-8-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:KFlCFdUSB45Y2CLJc3t1+mnM1qO5ku62SR01doxFtFzt50W+Uzw
 WEiAUTa43y18qEeB7ipitfxX+FD/qoc51hdvss3QNgWMH5rUpWQlQGJ1lwjhAOUBjnL9Q+D
 0KLO7jgUosxRD6dwPEyC5GEEU4sXENJ2BKEjZqsbNqTQ3iI6Zq1M3CMKv4lcCVmYsZZJF4D
 hyL3YrT7U26ykZejpTI4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jASN/hqZtiE=;buY8J4G3yt8Adxd1cSd+ia3SaMn
 C2rtQQd8El2C17b3WkCBNN0/I88oCPqOWEEkcJNDqkeyVJeD+HLlTCtfbK+5e5Uj52X1V/ll0
 dKHVN9n9OA29hLvMaa9IXKTNjXHQUFU33ZDvVciavpISU+VAF8RONLntbNMu2HdDRDQdVL+zG
 pLFQN+bJcwWwmvqvV3qqOHIlxpVpa7Yw9I8DuyGPOCBuDvKlpDkv47H4M6sgxEZlezV+fkggJ
 IzERLN1vcnGEDHsr/1QIROcO/KdIR7LcyuxFn9OxH5HoHno3GPMHfTh0g/At0+pjKPTjwKQQ4
 aalIGUE8BJo7XptcycXRA0NqTngpDne1fD3iN5Oebjxd2VVDgvQXWX80rMK3SZpULCXaD/z9/
 Ji6NdHodQqKZAIBztGlkAGBis6EM24AS0FWFASVHQxJTA4yHPH13wIYzRAonrfzW4rHeDIYxQ
 98eLQSWOQ2FV/kzisoQemRx4iX6IsQipVUIhRCsITEJFCC7c0Qp6bl9EaLhJP2mfp2Eo8vXBc
 akDKX7aff0ro1wVjP0RsYoAvOw3zjpS1iezr4NqNtNUtLzqJOwJc4e4Nd4PLVx1oETaIV5m/I
 cNxKwxZyqP+Ushs2aezYeofdVn7foojmON96CsHpkcyh+cCYXzEol/wsqrufeb6KdQAFVGNyQ
 vt2V9fcvlMPHKwtNpEBYcGSEuCC0LW1lLgUHoEgEVuSd4Zwje6Jcby1fqnGsZDkZ4kBcV6sTe
 VQc0KL6mt0voVuTvf5Q9s9u+KOZgZPpONMZU5JX090H975BfLTFg+Gp/9VfyCHZyMzajA2BWO
 9m3dzQH8VSGlL3mxxb/5X4WcB7qCwEZW8d9sOpUJHUTxB8cqfedNn8rwCPtYiak/+TdksMtYG
 FhaccogcoFTFw0I/UNRuqf4KL14OqbEAH9Lf/gb49shf94FVFlzd+zzJ+yUGeQuJn8aiCGDsw
 tDyAYWZwJsh734zcymBgLoDYKDA=

Currently qca_spi reserves enough space for 4 complete Ethernet over SPI
frames in the receive buffer. Unfortunately this is hidden under a magic
number. So replace it with a more self explaining define.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 drivers/net/ethernet/qualcomm/qca_spi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 2ca25844d91c..80182f8a4a50 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -814,7 +814,7 @@ qcaspi_netdev_init(struct net_device *dev)
 	qca->burst_len =3D qcaspi_burst_len;
 	qca->spi_thread =3D NULL;
 	qca->buffer_size =3D (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
-		QCAFRM_FOOTER_LEN + 4) * 4;
+		QCAFRM_FOOTER_LEN + 4) * QCASPI_RX_MAX_FRAMES;

 	memset(&qca->stats, 0, sizeof(struct qcaspi_stats));

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index dcecb072b8eb..f735ad77402f 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -41,6 +41,7 @@

 #define QCASPI_TX_RING_MAX_LEN 10
 #define QCASPI_TX_RING_MIN_LEN 2
+#define QCASPI_RX_MAX_FRAMES 4

 /* sync related constants */
 #define QCASPI_SYNC_UNKNOWN 0
=2D-
2.34.1


