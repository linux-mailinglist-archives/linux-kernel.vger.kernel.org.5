Return-Path: <linux-kernel+bounces-37751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4983B4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10921F24B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C001386A5;
	Wed, 24 Jan 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="uAFsImG1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62E13665A;
	Wed, 24 Jan 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=UON93yz/yFM/B2itUPXWngMXNFXkqlSfwRA1Nf3KD9PsU7M0WyFMyFSajey/0Z1c38zFA2k0+OzZ3To30poalmIrE64Yua90uOBpm12L7PpMUv2T8B2Mxs/dXSYRqV4wRD8JLfKfqDLLAguDNdztuNrRY14Ts4JIMT5EcKDUBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=2d30L/9cmkRO/WDG+K1BNz5a2b/Cm1vGtAAK89cu4K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9iWfNjx6yyGV3Far0kv7Qz6n49XNrEDuTKe+PJ7ekp7huvMfdr0HTDTZNNhyOHXptWoSrCkSQyWCY03HdfE3z02DFCeKZxlswRahdP8VmzfInU5nBbczMj2URT9F+LFbCEbBnC/cRJUZEtwHLEuuIeKBAe6KrZxKYUIxBj3SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=uAFsImG1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135560; x=1706740360; i=wahrenst@gmx.net;
	bh=2d30L/9cmkRO/WDG+K1BNz5a2b/Cm1vGtAAK89cu4K8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=uAFsImG1Wf/jyi8h5ZXtWNZuZRmEOgIRZb+2vS8yz05LjJtMF2cgskiK5ub2Sjc2
	 5BBZrDVqDymmz5pMiWQ9pCyW0kG7a6NhyJ+rHY8X7D1NYNXB2N7sdSJoSF/EOk6BE
	 NwOpr4WhX/y52BnJz89RzNOiyswRb603O0ViS1JGTg4jnfAn7GGyQp1uYEaHTGWS9
	 hqwMbJs9kFX6XxCXZwazAtj2zyENe6MD7NBCr6B8KbETduSXEWkDeexCPuZWNDk2O
	 khedraDLHHZD7N2Sre+68XEJYR2u6DHAtvhAeN3Ok5agLXZzfTIiJ8rCuKJxhiD/h
	 Z5C2aiz3qLmxYjOZJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1r1mnm13fC-0184Sw; Wed, 24
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
Subject: [PATCH V3 07/14 next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
Date: Wed, 24 Jan 2024 23:32:04 +0100
Message-Id: <20240124223211.4687-8-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:pNkWmArcSJL/MHR69zQw6xo3lRLg87y3skKCJrkSglOuOE2z9qd
 ff/Swto1BMY5T2WHf9azhuRBNMWdPQmKa3grlFoR6d3EiDh1GWJCcHK3Z1S1cgldLehF9FR
 +8SXmoe0mSLmN4LQ1MA3Gk3sE3A4kAlIRxsrST73e4m14OlnbJlYRihGJ+SaZv/XMZy9cGw
 q5U7vtNGkZ8jueplyeUng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qw5q0iuuywM=;6Y+cs0RRIy8Wmjncvhepicx5uS5
 d9HGWomSamtw3OjimSWLB2BafCkf8d9jQoAgq/q6vDfxGPg0vUTd3KWujYyKvLhxhSScH3vJH
 ntmkBDkht5jquApRvwbWGiYt2yPvgEQEFUQxP1wGcgk1svqtJpVPdIeVxKXu/sJq3plD7nE2k
 2F7C9+QZo4dBjoviLYz726hEUMcxLvl08ApZLve+8z4IciPDOrhMnIhR0kbyOUpCtri59yhWW
 +YBWKSLThybtVIonlRxJRdsIunnmTg2PV4brg0VmTRVYdhqIkVAoIvxpBEDYo0AyU6xPn1cFC
 WO5pt/E3fVH+ygTvyV/BWQ0eoKMeOFW79iJUPWdu1QFyUliHVc1HrOn93NfGCJuz4kOTTR8Bn
 XouqY6MEKczsAMetSAcYAMT5nu5crE3eqCf6YMhe4bMnhlaRzLaXYNziuz7VY6eKnmpKfSKkJ
 k3XZKaYbzo67+axt4c3OX9JZAmaEzB8TiHo+/gKYmhnzG2fY3x34FFTtEf+6c9s1MdV/l/NtL
 kXri5cdhut8wS/U9VESjqr1t1/BAZOvL5o3pTAr64EwB7sZRsAxWIy4aty1u90c7iCPwpgqep
 LTn2TFdp2jBu3D5cj1f/jki83hPengnKhGM/i5OZ+FR6Qri8jZsCZt7nbsBAjpRizI4Q3hW+I
 qnTujRoWOjzKyqo3L0VTkX+iZQ6KuAJcnT1DfH8LPqPa1dcSj5B/v0QRur9hJCpoT1fif18UB
 a4j94uk0ZD4eSBEtwDoP9pb1w+uOVO39F67HYDZuqRfCeI+FxWaUB1mlh+BW1w0lxgPw1WK9k
 wwhEPxQqhO2B3DJ8ta5wLKOJCWiAmLSsZyW74xEh/v4FwXfgTagTEPpMzKvJwNjkn2c9MrPG/
 +qQo1xO2f1vqR9L/uuyniY/5YgBxHyWwBVhLsemO50pDxPx6dTDJ1JshESmQvi82CjPBQxJtr
 jVVQDw==

Currently qca_spi reserves enough space for 4 complete Ethernet over SPI
frames in the receive buffer. Unfortunately this is hidden under a magic
number. So replace it with a more self explaining define.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


