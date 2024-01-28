Return-Path: <linux-kernel+bounces-41941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBC83F9CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310FA28178F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51052F89;
	Sun, 28 Jan 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GTSMhSXG"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A04BABE;
	Sun, 28 Jan 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472701; cv=none; b=T5nFPYYyYBs5q03DNDg2teQGNpNAcT6wj4NBjv2gvo0yoj7T6ewjefhDF81yVpLWTRtVZ1NeU/UTHM7Im8oXMpflqPW5XMt3qIsrtz2Kf5auXyNMjoRtDR/QsvQoME6m8JCD/+eqaxyetDGHFEzELHBBh5dbmZ3G6QoKRZKjkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472701; c=relaxed/simple;
	bh=UprYL7c9BGFFx9RF+baFk/bCnsWzoZ6GnTm2K3A8nZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S01S2TQ1BhFT4IxURWNep/k4jFYy9hFEpy/Me6uIWK4Xcy+GdMDplt6DqI31A0jEuww7ElGIWYmrn7Ky2JRDezsU3jUHtXA02nUw1H9S72H07U4tc1INV23YMtoBGbm3DOeL4Kv9FcQDIdW3V5a2fOuA53bA949HZa0GS1yTwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GTSMhSXG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472685; x=1707077485; i=wahrenst@gmx.net;
	bh=UprYL7c9BGFFx9RF+baFk/bCnsWzoZ6GnTm2K3A8nZc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=GTSMhSXGZq+MRIbZEIrjxVFcQt/b+n1zGreEIXDDZWxdFccLf8OWw7AkE93lLWVD
	 q3j7WWhWTdlETxNrdLRWpGV/+dJoD3ZaiWMG9C68m01P0AVDhVtmRCqPgkoguV7Fi
	 fMXKACXL/ybPgC8X8Mdy8u0v8bw2ujMtVCVH7krf7arYpt8xBmFOrB8WIakECZJ3G
	 LgoO4ffubkpsHjTHPNuU/ZlHbRSbAY2wf7jJDayLkDSplwNnv5eRE7g6f+twchajF
	 PeuJ+k6jfkxRXI6FIMScKdJQhl5Od7AEw6yQQn9C1CTq0NLUb512QutXK0eFjnmhG
	 NcWA3HqaAlfUz9Mu9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1qzXci2x8b-014Qt9; Sun, 28
 Jan 2024 21:11:25 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 15/15 net-next] MAINTAINERS: add entry for qca7k driver(s)
Date: Sun, 28 Jan 2024 21:10:59 +0100
Message-Id: <20240128201059.6259-16-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:AmM69PQmlNUns0mIyx+OWnKo+2WuQh1suaLwUEklxKPCfWNso5d
 LeqiIIEnNO2o23Emtbi1vJ32V+O2LTbmdbC7aWztH/RGWoyBWPWSNi8t7s4mZdE+7GcPkkB
 AyfpzGmFC9VErvUzbhUce7MsqEw4oxy1wZuAv3AZ0jQZH/l7Ny9nVZ+MfIX97gYF375mfws
 WTILl9wx1Cja5ZyY3A9QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kMUhhpJpCN0=;lnDTBNUZTKlAIbznG8+pTxaVIzA
 TopXl8QGZPURvTCVxDmHoaNESq38S0L2AdC4QTREqe1Xvn8cqCOvUvoMlkIofdt1iUmgKDouU
 FuhHUpg9piZqf8XZuXxiTUEv5ssoEPQNJxKi7+8iQGrfdtCueL8uuvXIQBXsbQAFRSRVbRkCS
 0BM6IUX3qI6g5DSX/rz/E1d0r7ypdI0pix0iMIAJPzb1sjTyifhttKtvvQ3uYviNARvgrw0qb
 afTvDpeaCma1z3Rn0K/KIBy39g1Lt/LCQCJWtDkxBMW7PRwzjuEzDGS/B89x4Iwqg35/W0nSJ
 gX704RGref7Ad30gqpdIQHM5EK/SQcDbZz82DOpstmpIfDv4M+r/WgSt9rkvchqbz5Yer/VpG
 JstTuHRFVqH8MBO2IZUnQdUAY6PKXbcoTnTR6U9mLq6hNeFX33+PMA0zasUX3w4OM1TjZvZZv
 mrW68Pxz2T7AkI232aJUIgWj+QiNSpB88ciq5Eu4bmFCLE/gIJ8pE6Wwm7l/r7eUVHITbpDI4
 cGptHqkYKLkUtTeejAwPZQyll5RyEuZlYuJCc5lqrC6qDhD9uyOTrfGe/4C1jlPiRl8lBNb3Q
 ZXTn/te6fF90pLTVJpjkXvj6LjjoxlZ3BwIm5t6Adm9Qti8EqbbeLvU53Ud7PY77nEn/jv0/g
 L+HO9bTrJ2W5t340rqYt4xD0vKuyyMpSe2gwpTnc4Co5BUGpebeEBb4Xkmal5mzlSO+C64D1X
 EhA1dPMuKwIUhU39APE2wWKzmU6SXslHWCsLBNeONWO1jZpV8+VVOSSwlcmijBWJYnXem4p9G
 JhMurjzlmAYtwImbeUwvSquPxTSV+dNMcN/jF4bP5Ldog1TltlsIryWRvE57Yiz804t5/yGWT
 aASbp0dxG/iOeoXmLqBDvNLSlVW++4mpeBGyvUcruagSI/jtfPx/OPa8Su8Rl6nMigBsL+7Kn
 oR4beFuc1YRObnL0q6k9wBpHp3Y=

Since upstreaming i contributed a lot to this driver(s),
so add myself as a maintainer.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8709c7cd3656..9768f1130522 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17990,6 +17990,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
git/kvalo/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/

+QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
+M:	Stefan Wahren <wahrenst@gmx.net>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
+F:	drivers/net/ethernet/qualcomm/qca*
+
 QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
 M:	Stephan Gerhold <stephan@gerhold.net>
 L:	netdev@vger.kernel.org
=2D-
2.34.1


