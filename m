Return-Path: <linux-kernel+bounces-37757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE883B4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F6288B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC513D4E5;
	Wed, 24 Jan 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QrEmGNw4"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93792137C40;
	Wed, 24 Jan 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135602; cv=none; b=um8BVYkxipYqP7i4x73y7zL66VnNOWp0gFAZt0amh/VtvAfGxzv+5HcFp8WYOX9Meb3VARqS9pQanAq2wZopYLJoDmnGtrHwR7hR7SywQBI123pU78fW/KY9GM6JSHrCSv2T/YoUs24OjNcsvX6jqXcsH50aCqyFh+3/bfZWSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135602; c=relaxed/simple;
	bh=86IbXZg2D8dZ14CMAOHu2fJ9DPKToZGpqc5c/wgcbic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6rheg8hGFXG7I5rNc9WKN8b2tP5cBR0EHTyFikj1ZV1NKTF9mmXrdb1caAH9t9X3TTMfKCHptTDPf4U7jrYYoTx5XQLfrrT2X2rugzBZ2CeXi6OV3ejZthFes6TPl/cq+TUtcWyLTtfEFBQfvnWdZikE3W9ya2SsfvcGhZAGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QrEmGNw4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135563; x=1706740363; i=wahrenst@gmx.net;
	bh=86IbXZg2D8dZ14CMAOHu2fJ9DPKToZGpqc5c/wgcbic=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QrEmGNw49fdFCnb9BqA7tcRfqzGBhuN9iZPjkVmzmBkuFNQLWTUSzBksGe0oQu6I
	 pBmvYP6ZowcfwDE1MCSkxvSu7o7jlrYKaqK1V4MuvLhwUqpr82frU0fDw4b0sJOMd
	 AKHw/t7XAl+rDz+5ml6Bzkj5l89YQfraWj5dFu2tNflIPbD5B2neCsJRqS4HgP220
	 +NUgvRMSgo7KD8RfGdZi01xBnrHKJi0quQ21XUrBMxUWu1mLCgLN6TDdwLIxrIlMV
	 5kEBVvqFeabFNJOGuiEuqOhN6SuOixN2G9pRSoRuO7MyXNuQ8HjOxuVeUHmO9Dilk
	 gp+ZdIN7DqqViyOG8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1r6Ce5293W-013ecc; Wed, 24
 Jan 2024 23:32:43 +0100
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
Subject: [PATCH V3 14/14 next] MAINTAINERS: add entry for qca7k driver(s)
Date: Wed, 24 Jan 2024 23:32:11 +0100
Message-Id: <20240124223211.4687-15-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:An8E5MmPXOy0Qfm6lQu1YYOOU2P8WzbmtkdufPdgrrGHAjI0V7G
 u5Wd1TrEMwb5QVMDWkLoL9WRYGmgy5VkmxYVKLwnK+f6DDAWijKkFED/8T2O7HUTjq+UTKC
 FG9eznhdJdjAxaGaFq6wnd473nFEmymuS+5Log5UJ7nbhRmqx3vLpohFXP157AyR4isI8T8
 y+O4pZERFrEwYsRJmmJCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jhNNaGn7XvM=;fMxvYjVDhqTxkoA8NMapSUXoR+x
 UFJsFxwwh18uQ/8whJreOnD+MkwmqfaI4m2mFm24K2k/mdq941hY7V4ezWkMdry4Zts4q1l+U
 jZafyJYMdFuR9kTfzkk6dofGRLGzam9DQffYVb1T9LBoJ5428ac/NFF+GAGNMLF1aZM33gNwm
 QX9J1crfBsYId0KIOLa1DQlXYekTzD4obok5mtmv8TezRwgAgEbqjr18Vs0xx7rJs1x7pVpi7
 QDYcq6YIZHh5dDWZFU9PEagnw002SKA1agoEA2RSjMeqJMzu0flW7NpRawC42tFmqeSqs3C5Z
 d2BQw/Hmti5AyJXGkN8QEV0u1eH+EYTrVAzaLj93mUn2u3kiH2ql1s4ZbM+icZU76d30DhJxK
 acsttIZhPOSiG7V1VPzdHCQZIq22nKMAPxvcvrLv5rhoW5cxOlos54WtiUzipLr/XrX6ufmVZ
 EeVJUMwXcx8KQqoDabDd9Q6dLKrNZ+tAjZT653PE8S3JASKOiPEWBVHm0O1tMDKFoE8XrvLnk
 i2a7B1S+oQhBY8RyEPBtfwQNACLhfhTtjSxa7UtUSgx955+zx3szdk9lSzVsOtRAJL3cWzo8O
 AW4gkND/F3KsJ0u16qGOvqD9bbgKNyyPD5FBsmBNaeIifVuvSzt4WOo0v9uq9NNrkhWaI2/LK
 OiVy+xHScJJY+vOs3+Os4BCPoPLcrIv4dyFaILKOG7eLFWr3173uYWmI8XZtC1mXqNGCQ5rKD
 FrHRUMzuD/LAXlcrcC9LKz6AFVRoruVyRmRJhPs60qdGvr4fh14JazA/uTG2k9sSZAnNQYkx8
 /lRcu+MpM6D6UYQO1ZksQBBPkA4/4v+fvICyChBgbeB0mhZwouTwD4qEPIeyMo0UCumbAjF0j
 n8iPqM1zuJGYTg3bOI7rQQiAuaYJEL7yBk70z8a5Pqk2OT2DqQnu/PtlJD29AecjkBpwVeCpW
 tE+3Wg==

Since upstreaming i contributed a lot to this driver(s),
so add myself as a maintainer.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..5808f06b4ccf 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18009,6 +18009,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/=
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


