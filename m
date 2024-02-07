Return-Path: <linux-kernel+bounces-56065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF384C593
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A227B1F252F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21147200C1;
	Wed,  7 Feb 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HUcNMVtC"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9A200A4;
	Wed,  7 Feb 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290599; cv=none; b=gEtts5N/BdfhD5+J9QhHxDOSeF4Kqiw4hGuuucnFQhYFAvurbh/ZXUVKxuTE68Qxa5IuOK/lK11AwGtpumXbk+qm4N7fHBwg4w7cfsZudxLtrdYQp7Dox+pmOxFVDHN/UT55+s06pO4v2r8qsOnHv+xI2cWircLsBz8vaMcQRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290599; c=relaxed/simple;
	bh=J2jt/2fYwNXM5ff+lqyZZsvvteRbinJC2NNlRHVyYQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/eR4X2g64zDBPBlyYJpLmZgiDdgKuOIKec2r0KFVvLBlcOUvkILGw/kBAp2a50pTchWN+L5OXMopVvD9AnO6DTQ/aO6kewmoZEj+Jy+hTNKI7eEpjDUKZfzYKjCDDS2Xbf58A8ipTns7TSvZTNadDoHbooLGoaFBE9R+jMQ3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HUcNMVtC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707290579; x=1707895379; i=spasswolf@web.de;
	bh=J2jt/2fYwNXM5ff+lqyZZsvvteRbinJC2NNlRHVyYQA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=HUcNMVtCq6E/VHV70rgJHAm6KPwV+bn/NU5+I1IsCMN5rwgaVjS5cdRR0XVf5bmt
	 3SkhqdVJexLANCejiEvvnWESLH+7oOuQAsSnwsW72SwafuC2+lZnAV+BkcXb4lZg3
	 CAwd7E3LIV2xwj+xes3eHZvT2gwiuGIN0+gJduBiKCGboYM2QGi0fk02omTTzboZH
	 rQruBUDRdZ8brCqsY2ulAsAaPGdCb8o1JopKSg/iK5OjZd8lDbiAzARM3HAgEFpcQ
	 xMFsAdy1QjhrFkKGD4pT0cgKe07So/jhdrNyUV7TgJF6gWlb7gvBU11Lv3XAEH6rC
	 VCTbQ7CEiRWRqVZaZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa.home ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1r28zw19tb-00eSPJ; Wed, 07
 Feb 2024 08:22:59 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mt76: inititalize sband.band to correct value
Date: Wed,  7 Feb 2024 08:22:53 +0100
Message-Id: <20240207072253.4189-1-spasswolf@web.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: 87zfwchlmt.fsf@kernel.org
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ihWuM1oFPsd5oUO7Ugdyc3gHJ/MRJcaj3yk1SSNfEPysgsQprxV
 fYh/9tX+tysSXDf9fIfrHa4zFSyjOS+Heh2Cy0upbDHPaVAU+Hg7+BM6YsLSJErta3fU7Qy
 AoMT3iDr4P9YtwaWogne5u7SHTyJnsPO7TNDnGijIW+UwM8hcxDjDiYdSRbRJZpqWMGQB4i
 U9Yq4rmez7JZIVdlC0k7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ip9NZo/uNy8=;Rr8/t2RtVQbDMiM9lplEP+nfbcK
 hHNqbivl6jERX3ZYkFswDw2fp5Xo16fb9hOf6X87ETsFG//p7Dq8fQ2VLNBAx9H7gTdp0ICjN
 hDH2O3nxSzCUE1DMXiyDvPBrC4lsmBx7/XiYaLJ8/EBPQPvp9TIUzP0TYPDDu1UglRFDONRtD
 3qPG6iQhSG7g9MLd6cEVPHfh7635h0/guBDh/P01Afdjn/V+qSqIGJvrz163ZWQ2UhGIZNDLd
 RA7k16ulyPYlwnYpxemnr+MaqxtFj25SRtcsVRpZFykVM8y+WLfJDwc5EcoiZwK/udFXX8gcS
 CdA8H+Rp5jTSO+sg3zGu10AKDUzGiL04aT/964hK8GeWlJluAqG4N1uUDT9CjseUyJk75Ewt1
 L2xn2wB2wmGOzAtsi1F3g/CtWA+OshVlrr0b7pzYDjk50HNF48Yc8t1ptxh9unKEO8T89NG9G
 gixlC36Zv06eJXbMSLbX0xuoD/ZwLT1wpvJBzwAp/igCu3LEIWmDjY7ZJu20XljzMi0GIRJtB
 GXTnZn5P6QEntlB0fGZTc6H5FW5zQRQ+YKfRWIY3Eh96Ex9Ou3FCgGiaJXbEfZDhHkzqtuuB+
 MA3sVWpNVQQNZNqNW24WzQJSUZ0Xa+ctU7/y7KQgDiQArwuzMRnMiNG0vViSfnuKEByMRTFJO
 7GAM7on9487jZ36UVhdQnq/s8moGUkvph+1tsmiwonPPC6TMOu5skTirHynQcAGKDitnyXRmE
 JA85oMSAlDe6vPXwWx7JYkamQoiQcV0I/Wo3eaiEDiDDZyn1fGhVHtO9Obv+B6Ick8sx+/+9I
 NTX++/782cZuMhAktKOisXXzXw0+JLEeVezW6rXcZCBv4=

Set phy->sband_{2,5,6}g.sband.band to the correct enum value, otherwise
the ieee80211_register_hw() will fail to register the device.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218466

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/net/wireless/mediatek/mt76/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/w=
ireless/mediatek/mt76/mac80211.c
index 8a3a90d1bfac..6cf08446f445 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -363,6 +363,7 @@ mt76_init_sband_2g(struct mt76_phy *phy, struct ieee80=
211_rate *rates,
 		   int n_rates)
 {
 	phy->hw->wiphy->bands[NL80211_BAND_2GHZ] =3D &phy->sband_2g.sband;
+	phy->sband_2g.sband.band =3D NL80211_BAND_2GHZ;

 	return mt76_init_sband(phy, &phy->sband_2g, mt76_channels_2ghz,
 			       ARRAY_SIZE(mt76_channels_2ghz), rates,
@@ -374,6 +375,7 @@ mt76_init_sband_5g(struct mt76_phy *phy, struct ieee80=
211_rate *rates,
 		   int n_rates, bool vht)
 {
 	phy->hw->wiphy->bands[NL80211_BAND_5GHZ] =3D &phy->sband_5g.sband;
+	phy->sband_5g.sband.band =3D NL80211_BAND_5GHZ;

 	return mt76_init_sband(phy, &phy->sband_5g, mt76_channels_5ghz,
 			       ARRAY_SIZE(mt76_channels_5ghz), rates,
@@ -385,6 +387,7 @@ mt76_init_sband_6g(struct mt76_phy *phy, struct ieee80=
211_rate *rates,
 		   int n_rates)
 {
 	phy->hw->wiphy->bands[NL80211_BAND_6GHZ] =3D &phy->sband_6g.sband;
+	phy->sband_6g.sband.band =3D NL80211_BAND_6GHZ;

 	return mt76_init_sband(phy, &phy->sband_6g, mt76_channels_6ghz,
 			       ARRAY_SIZE(mt76_channels_6ghz), rates,
=2D-
2.39.2

It's "Fixes" for commits and "Closes" for bugs, ain't it?

Bert Karwatzki

