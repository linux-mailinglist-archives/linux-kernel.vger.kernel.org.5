Return-Path: <linux-kernel+bounces-4488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA28817E23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4970DB2434B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6B7EFAB;
	Mon, 18 Dec 2023 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WjPInH1l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A91768FE;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942020; x=1703546820; i=wahrenst@gmx.net;
	bh=kVgOK4uDq2cMVF22bM1C1q4emK/CUOe/qBAvKkgt52E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=WjPInH1lX3e8ZyY+tFYOssTdkd3aX5qOOkCGzgiHGHg/eolx90JzXSlBj0AaAmII
	 3cS2CCrt2uq7GfgiY2oaSykKHFnMz2NtDokV+j2X45kdhp8+eOKaed3bxwS7Y+DCd
	 neSEOv9G1B/d+ZYTZtwQtzP5BwXfkqJ9T4N/9Ba08Yzu2GR605EV1ShRlMz1TH8A7
	 1f5GSQDiB1jzzFmbTM+X2szYsj0atjCQG0Ol9GTquLI4AOmjwgK1oNij5aRFBuyq8
	 fraf2Ndg6NhLGtL1JYKpPHatSqxDDkBMpNojOe5GqhabgiC2211pcnXaRtfc/0AR7
	 cck1TnCtQ5vCr39kxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1rnh7u3ve1-00YQgA; Tue, 19
 Dec 2023 00:27:00 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 08/12 net-next] qca_spi: Improve calculation of RX buffer size
Date: Tue, 19 Dec 2023 00:26:35 +0100
Message-Id: <20231218232639.33327-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:1NUjojGG/T/8z6MjnDewqJEZgLj6mU1LKH7BkB4IXtu6N4HgOlD
 Kx6g9/QDQ9FZbCB5930t5D+1vLMxCfX64J+Kks2QzSMM7UszBxOCb47ohjP4FHhTTiHEOYJ
 6jNn5jBz4u5qWbuvGtL1CJEymEGuz91Q6d+OAKtdp5HIvkcUA9Jnghy0kgqGy4B0ff1u/IK
 d4yDsh1NMUKtISnxyjbow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zaFDU2drG4s=;z22aI0GjLMAtYAPsUqCy6xqcRSP
 M61WcB+IMZos/C71UkiDxpM/40jLqM823flvrvyhcj6qyanoViLu5ADJjWlZZtau+0p1Az2fQ
 vbcv74rmjEz46YdK1rWWWh4H6fG+RXObABsG5DCFzT1NcsqAqhb6fATKdUWkPdZXusYdt+cP0
 cIPr6WQ+5EOcXDrDpzvOWoTx4R1uD9gd+L/3hIBiE6E4g2fcXcoYYAbdF4gtsF4Uia6mn91Gy
 soxUapxBMcGWNP0BRaqtLmok/Z9yCfr9XwZcjvuLKTfx6kbBUK7pLJloXVVdpQWQt6sMwONOB
 rBrxcGh9aOLlsnL5VpLLVMmOMuS8J44l2UIlp7cjG39DvuLxB0ZG/0Ir+A8v0zaPHcDVO/BJm
 c94IINXb+nG7eUpT6JeT9FuG/9r2z8IDSWcpBq54oKgFIeLacUdtcgw74755aan3o0O3cL39x
 aAjoV0xvN4DgDVyUQ34XYXSfoC780W4OclKRsCyn1s2qgvJ3GtSnRVk0S6OQQqbPMPIKyTYLh
 fX40xnh39H0pS4pu+QWw+iz48TuHlRMXgFCuK5OZH40i93mQ/i8cUHLK47dssmIrIQAmdie+G
 c0w1eu0/H0FKcjOJvn+pfQrF5eQoJ9M3TrN8h07J+DmPcl+ob2QA5woaIHtGDXDXBRqu3eUOy
 xKerGsvnzM/yTCn0H6uba0v77gXQWsydsJTBAekTlbZhBBtMOHPgdU6aM11YdnQS9palyvAJq
 OKxxIMNgRtnYEY0L+xlJz/ZcFVnlDeYn+DGfdJTVSb/aGHJcTyrcbjs5C6XBLFXeIgLHDHtsW
 GrXVFQRwgcbFTiMa4ulGESbciI25CnQiigzbVeF+ADfxAArjlkbOtUTzkNHhsAr3mzfwA94Ou
 LSjlubLJQKyrdlQ+KTnipn/CAfyuaghZGo2C3o1EPTx/Uu7ckZ4LKiGBNWU2U92h1HGnHD5Y9
 tfjwSQ==

There are two points with the calculation of RX buffer size which are
not optimal:
1. mtu is a mutual parameter, but actually we need the maximum possible
   MTU. So better use the define directly.
2. This magic number 4 represent the hardware generated frame length
   which is specific to SPI. We better replace this with the suitable
   define.

There is no functional change.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


