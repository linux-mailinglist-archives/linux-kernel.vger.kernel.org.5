Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF4813424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573704AbjLNPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573664AbjLNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA09111;
        Thu, 14 Dec 2023 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566603; x=1703171403; i=wahrenst@gmx.net;
        bh=dtL88b189EQfj8kkwIRgqqLj6oW21NIG/L8Xt1uiUiw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=MhTXXGtgf+zKs+Kl9kzT95qnLDEsaUfx2rq5EgQo3hreaRzhBzt9uWcYHOLPGrfo
         YWoSwD3f3z4aKlN23XHnK9ivajKIDACDfmQY/+es0xtbaeAbRJVznvOA7qkH/NQ8G
         lSLJWYpRweOmsEzsw5RVSv0KUNSN+V3J5RwCA3ATs6V7oxa0SoHkSbERs8I1AZWnO
         7lMgh3TDd1vb+71C9hgSTxGi7U3QkjuV6/DhGDgcsTG7/6exTGJbyuZOkArv4rT53
         6LJLZZ62FH3R89ti6JNssIm2eq/hPASJzjXy4ORQjRlKGacSCTztd7OwJ9BrYmNUW
         88N7e8pCgU9RYQrryg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1rEtoN2HBc-0016Xc; Thu, 14
 Dec 2023 16:10:03 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 07/12 net-next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
Date:   Thu, 14 Dec 2023 16:09:39 +0100
Message-Id: <20231214150944.55808-8-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6/yhf7vZclKY2EkVrwsHMX69cZt80n0/2WhMFI8fNap/UNpkHnu
 vaNtrm+jLxn+OC7snc2AVK+WGiBTq4zAh8hSEfo6QNuTs36AOxaUoJm8m+z1sbvPuUONAIp
 u0L11ZmCorR9Hh8C5LFse1ZJVAB5W0JBIKoJU442OI0BJ10DsMW5Z7nNnU5r1uMhbC7C2Nz
 +5xQ6nd3aFyfyGozv5bpA==
UI-OutboundReport: notjunk:1;M01:P0:lSdcSXuP3DM=;ywW1B1ZxhsMnKLkaFgGueDpaBzW
 XqjtFpUpxGS4C5szE0/g/HUJB3+/2tGQFnEgxtijFR0eS6VESQwoypgCRM5sOsx4yDnh+Zxvl
 qzYDRfz4HJE/Qg9ymS7tUvpaihk+vcBCafhz8dN6h4NSh28J71rj3ICqPqbphFAc0XGU/shLa
 F6J1fI+XSrFCFc/6p2N8eODpN408Wr/0/A5CDLfTMaJIyXiAP6IHQT3gOaGoVMIn951RudLpV
 c/zJRj9Qf5QdSa/HZU4mCBxu+efEATxwtPRN1fV8hGzx1gI3YKnwBTjyr5/t4ngB43ObKMlq9
 hgiiHdVBHvALqAt6azPP84vshNvmawHPfa5FbVvULZKlXeAVzRD/kKpnU85Mqc/asoZqutmg1
 Id4H6s5LHG6rvBQkK4LelmRLm3teLKrbTq3PNMojYYIZgZrPna88Vn1II5eAn/x6JdXh3PbNZ
 Rg63SCwJWOF/gTPxcq5vJjGdUVlglcFnEI6n2nGrWW121Il2FaQD6hncJLsiYvA0nC1kLxnTk
 A5CBR6KFY8zY5et1tZb9aT0urDod0NV0Q/4TpmuQq3NQMkYgElPLyOBpcIQeIG5mODGYA69UG
 YpGIKyva8M280pp3miAX9ucYJDBpba0gK4EcHr3JiohNYXjy+SaCjGhd5nxmbkTTHAT7u6UZx
 u3pKn87ytdJ0Sl71OTL4jWwLAX2xVeUhRG0z/PVS7zpNIACWKw+DHoDd2XX9llrwhTMJiS/Ur
 Yi8vZOeQQQsMVv//eGPIVMxYGECDOhoC1dZBfxEKA4lWKGPkfkTwL5Iu91pcA73Tduj++Bekv
 xkb/SlpVSQ2o3G/QzPjNc7jEe/oYZAQ6+zyVLmq6eKZZzFC19lnax9GnurTpcAh6Rc+G3y4pY
 ObzJ/j5NH/luhac1L/Tpf0elG/zXfzj5HHedjiJMWCXyiIOhS2NTAxpFeNYRK9HhCsDFL4s2a
 m2xXkA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 31ed7a527092..450c3d254075 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -796,7 +796,7 @@ qcaspi_netdev_init(struct net_device *dev)
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

