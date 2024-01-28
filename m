Return-Path: <linux-kernel+bounces-41934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD283F9C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E0E1F21CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4B4C60E;
	Sun, 28 Jan 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="p9N4VS6T"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4B41C73;
	Sun, 28 Jan 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472698; cv=none; b=ZsQ42ECIfQSJ9JB6Y0kXM6iOyBZFTgeeD8f987SGpIdsxTN0/V8lEOZVupXaBk7tFCX657bs1JnCKyne/CJkNVwnRPxHNs4a1YHitFbrKkj+iSCWvZyMM0ba7rSqo66PJ/S8YJuZX9TdV/Ru+xEVixe6ZpYE5bUoSxWyCFvolCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472698; c=relaxed/simple;
	bh=brs+KzeuIYeo/VPn51BkrIoo6mMzcYsP95CaSI8Cyqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evbzMxYPzXgnlnDANEEC4rGHPWem5V8zQCDtn0NtpHZmw3wVZdrHOeampCwGXjRhC8y+IlcaUgonKmx51ssvnKNQqQ+40QPw/VOTNDGF+TtMp8BH10X5JC9+6OD7sGCkFwmoqs+pn3YSECqL9CMfxNlIptp92OIjBme8iu4hoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=p9N4VS6T; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472682; x=1707077482; i=wahrenst@gmx.net;
	bh=brs+KzeuIYeo/VPn51BkrIoo6mMzcYsP95CaSI8Cyqs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=p9N4VS6T8VrwoDIQhyxjJFS1gIQDqmoWbKFzaXJ7FSpjkgbfKTGM3/ewnE1xxlOO
	 52CGUGrGckxainniGgIjWI9pIC9TOsr6VbNikZBQkqTAdBAt44Kf85k7lGAXPpCiw
	 BPt9xO8hfEJ00y6J7+c/C5cRYMXKeT6FdNqFN+V183yTE85yC/jFNWEZZTQoBIutL
	 iVjvxPGTyhyfrfUGJZDhBM9mLLLuAWsTai5EPfxyCirZqukHabXaBlgK3BL9eTtb4
	 064dchEUQEtCX8YULq5Dj4C7ZQTaBzxMJlVtdejq/NS36HsxTaTI7gDHAHM7Cb3NP
	 GNliornm0xFaz8e/KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1r8vp72Eyl-00zWGb; Sun, 28
 Jan 2024 21:11:22 +0100
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
Subject: [PATCH V4 08/15 net-next] qca_spi: Introduce QCASPI_RX_MAX_FRAMES
Date: Sun, 28 Jan 2024 21:10:52 +0100
Message-Id: <20240128201059.6259-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:1aI6hyxVWayTcrdbOb7yY/nFyOSxa78d9MrfQ4Geyxrmfm4OOl0
 jo+mGZ4R51wU/lbC3R5LiCTVMia9PuXtdvG9EFCIauNbVwYh6q5UfMRKw9y6mLd/DzpGVQ4
 LbRXGfNU63njrIvI/c+cIDtizFtSflCgdRgE1B8WMN46vpQktF5C97h2MQ/NkzXV2WXfvIE
 TI4F3K6SGL0p8fshRmIsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xbs6vihAokg=;TwnCR9Wkj9Yf9wWnXU7JTQFfjuN
 j4lLumrIOJdvJ+UDLcQFSjoUwAULG0VuUfqo1qCiqlJxN223c/U4nATZUJEpvSsvDAowQI/IE
 tMux6eDwbIlnmt65anhHRuuXW+bbSKH4DxYZaf1c8nccAtFug6e3916Hogt7Q9C6+5uaJ7BOV
 +Lr4WEoDe4C9vSrCvk3n6mJxLlnXayaiOQc5HAEn2Y+iF0fsuN5UcsBNIs0rTxWfSFNZF4NPv
 QzFsllIFZpzmyG6/7LeDuCjuyQ8ZuxL8qzykHJzBnWVmGCnbzsruvApOJ8bkEyDqv8ukvuiVJ
 gxJut0S2i2QKp0Mk+KKHe7Nllj/eWMLM3CgMf8c5v0Am+I9hCinLGDUpvyAuwrYrG7/18KB56
 kc+LmjkBHWWhpVUPRFns3M6993kGPDAwFbNxYMwuQ6QOWcg2Sh3TflrXrGZ6/mwjZCNRcmB2V
 dcWxUkgG9tdfH1ucQMQ0e9kYXTrzxc7PkMcbet1ZmmehfRXzvU/7i5i1O6VUxAG2NmSF3Ko/u
 yyQwdvfIrOaN6J7kVbvk5gglnmXojj/wjMALLob9m0H2SqAA6vlmf8COchMFvk4DwbotLyM1w
 ED5OpaGW3csS3rx3JoW/VFv82Mv3Txb8IWs0Tl34X/0wnG3SrYnXe3Qf4ZfsooEluxYXGUXF6
 hydq5scQkB+ntcYq6HLZFqXC3iIiiNI4hKGVEAbqdPjFciphhraRn77xEG1S+LKEcQAolhicu
 +yw1eh94o05v70zGA8VkUiDZdVNMI/Ek6tqkxYssb4u+08bTdoqkw7E1Teup1vE56042JYESw
 Dxvv8uEPxk+GfB3D12iep02XDvZcER3wCWR/7vkCW9S9/LuvFx3MCVCarrEvRJ+VBAH/fHd5B
 vnKRiV2f6nvsRcmrbeg/29spD0cCzpF/qh0JjhY1up2XAr6igWOtwNPczbHBt4msdatq5ovLx
 0Vi20A==

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
index f53438c4aea2..c0f6bd3d331a 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -829,7 +829,7 @@ qcaspi_netdev_init(struct net_device *dev)
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


