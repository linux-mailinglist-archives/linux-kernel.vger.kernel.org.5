Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7A8071F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378752AbjLFONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbjLFONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:13:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC4D64;
        Wed,  6 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701871977; x=1702476777; i=wahrenst@gmx.net;
        bh=t+f1UAgVS82IAxHkQg45rYdv3HCZesbwHcYQR49U1yA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=fhpsqh//DmRe51w/WhxGzgfDAwtWvu6SHZpm3I+aFBQuTbDVIONOPIAWmpZEdTbh
         gHS1oCDMmwhjR+Fp60IzIA+drhzBKasL5gF5zbBCYQyu6EocBbmLtOnrJqA/mL0K2
         2NOTyDSUGG7YTQfLgeEDhwzgD9GmIth2tXbw4sfWDAPzdYLUc1Ln+bhrXurSeR7Pb
         ZzS8KtOO3UDJx/nyrjNbl+RPRZdJJ/EZRLuhlB3gQWlK8Wv8apQzQ9Y/OrtryE/cN
         iXrKgoO2xsm9oysCske6IgLzXMMomNDflIOLVYLk0XKnu/ALFAf6WHlKURNahZbiL
         Yfea6aPt6AmzvKeORg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfJd-1rWY7z3UQZ-00v6lK; Wed, 06
 Dec 2023 15:12:56 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 2/3] qca_debug: Fix ethtool -G iface tx behavior
Date:   Wed,  6 Dec 2023 15:12:21 +0100
Message-Id: <20231206141222.52029-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141222.52029-1-wahrenst@gmx.net>
References: <20231206141222.52029-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:36FELgj58zhnj9meTzWv5UNr4ht+VcW2xPTn1NS6lRPF5yKk3M/
 r+NuO+ANLp744TAqiAYURQXc5Y2UO/gcQ5l4vYvcV74WUkE5ZvEoV/QycDSTPWYTJHRzVSn
 A3Emy114Ey7I7Dz/H7UjWymfuBiK3gE5LB/IKnE8VJ+RVo4XsBwByOCXpk8MXrrXilAnG/Y
 oJlNrRW64py1cqP8ZmXqg==
UI-OutboundReport: notjunk:1;M01:P0:deRqzXBwFwo=;NxG2xNoVGLrOFMC2+iMbaJOMFZf
 vfKnZyrighxPEze1v9oFpvFyplcmMjtKe/DJHVY19h5chkH2Btl+Mi618VE+Fwdtk/1kOpfsS
 oqVdB8Z4X2MNgmBu/KUZlNpBi2T41UBjER6pmGpB3I3Hl3wSlLK0iHIK9x1JgybpvzIAfO7gj
 AWkpEf5cRrbuW6e29GKNT2+dTxao2pFs1ldbXwKPZFT6yQGPYNLdlMIta+40wjtupbiEt/TZ4
 HpJ5i7tU2sTcZEbKKSDEsMEVh5gDmJe53sb1XNXrq6lggQuJKr0LRZNH1dFVfz0DHeap481mE
 L8HkQpuSYfSzeAN+oXXTyV/f0toq+WkGsb+9WAccJYvI5ohLwNQpA/u6JSrnSPdUrftcKwg22
 j65NbE3867LaZRK5BldLAKyvTyROISOhLmT0/hAiVv2kouFBIqXQ5QUem230t+CEkh6to0fmc
 KPZOkTs9tksn5weqflWsiYqDklGyGPBNgws3L1bxXtyKUlhE7BnJeMZ1O87F11xJjlGV5WUdC
 DEwwX5pmlHHQghrxya+azQYafWsIAtQcQ/Xe/NlqhJNNAYJ8G388dWF0ePmfuI4Jy9mNPOjpT
 H1rf9gIZ3AqmgWR+VuASVm0fnL+pVy/UltwetL6DU/Bj6ixjPOiFZXZPD1nJTNxsCji7aL0NW
 uNL6CudETiftfnNq8UiUnDzOaCXzPD1Y1RpjXp82QUx9JwAk/FYdhyoxeqWjzndqWMZNuP8Ed
 lgGDZXqtim3o2o2iKyULMYeg9TJl+SfH/oTw/IkPfbE9W2qMA0qoW9V0HMA4yG01JEwQltO+k
 y331nYJ4f2oPrlgAHJsLpako/HnQkKI8Te/a7YiK4KGfUcERVGyNqMVJtlAxeGuj74Y5wnUOQ
 t8K6nEMy7XZIJfdPAQhWxawdZ99gaX3BTugBUxNc4pqSDsnfBr8QkbeLAkJF63AQk0EENamEs
 +qqtjJgAjTr5bKue043HAG06QNI=
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

After calling ethtool -g it was not possible to adjust the TX ring
size again:

  # ethtool -g eth1
  Ring parameters for eth1:
  Pre-set maximums:
  RX:		4
  RX Mini:	n/a
  RX Jumbo:	n/a
  TX:		10
  Current hardware settings:
  RX:		4
  RX Mini:	n/a
  RX Jumbo:	n/a
  TX:		10
  # ethtool -G eth1 tx 8
  netlink error: Invalid argument

The reason for this is that the readonly setting rx_pending get
initialized and after that the range check in qcaspi_set_ringparam()
fails regardless of the provided parameter. So fix this by accepting
the exposed RX defaults. Instead of adding another magic number
better use a new define here.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index a5445252b0c4..1822f2ad8f0d 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -30,6 +30,8 @@

 #define QCASPI_MAX_REGS 0x20

+#define QCASPI_RX_MAX_FRAMES 4
+
 static const u16 qcaspi_spi_regs[] =3D {
 	SPI_REG_BFR_SIZE,
 	SPI_REG_WRBUF_SPC_AVA,
@@ -252,9 +254,9 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

-	ring->rx_max_pending =3D 4;
+	ring->rx_max_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_max_pending =3D TX_RING_MAX_LEN;
-	ring->rx_pending =3D 4;
+	ring->rx_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending =3D qca->txr.count;
 }

@@ -265,7 +267,7 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

-	if ((ring->rx_pending) ||
+	if (ring->rx_pending !=3D QCASPI_RX_MAX_FRAMES ||
 	    (ring->rx_mini_pending) ||
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;
=2D-
2.34.1

