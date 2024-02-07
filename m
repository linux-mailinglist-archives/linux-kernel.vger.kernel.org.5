Return-Path: <linux-kernel+bounces-55747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563884C120
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8BFB234AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE165A94D;
	Wed,  7 Feb 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vY7Kp/TQ"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851D9441;
	Wed,  7 Feb 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264131; cv=none; b=D3an0ZpbFgPjHvKi9DHxYFs7NPe0r7qVtSmd3IoXixEOavW66eRNVThdFSUPwmB7fk9C/4UXSCZKhws5jrmgCdIXL3kLw+LNHUrecbWoLdcaJF9IKHORC5Htb8xRqNnj992raXcNAqAOd0KPRG+p9j5JiAQrFsYsNOeKdCU5eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264131; c=relaxed/simple;
	bh=Eoz4bnLhBsJqtAzSuuDGPpIjD9K8OcY/81Kg6Ud6VYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCLKh34uqvbGItAN6pD+yIR9SVjW0gcH+LwYEIzDgF8ovAEJRsr2eoYh488yGkkxlnlpkoxXcGIyO9fUjW2o2roRyLIwBScvUkQ4VANPZ8X41K4WmyS/Kpiumar3q7YdA2Q7Trs9/PPVDMqtR3XfXFR9toSnjVflhumxqtW6dfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vY7Kp/TQ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707264113; x=1707868913; i=spasswolf@web.de;
	bh=Eoz4bnLhBsJqtAzSuuDGPpIjD9K8OcY/81Kg6Ud6VYU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=vY7Kp/TQTfI3NSahNziD9FxxR6gAIBV3MbkAs+I9WdHu6RnFqaZF0eFI1aWjjDKE
	 U39BCoqgN0BiH7vEtsH7+3OlI/zpcZH7DfVi7a3GiSO4HNno9lvn8sAU11FN8Hydj
	 fPLZNqUGR1BMJCkNphUAOeVYzOhqDwYpLecMg+MKJ+UNwDJia+rWadxQAWsuZlV67
	 pK+YmKbKccm7VyHh97VWkMFdx6dH323gYpvH/Q3xaDbjpg0fDxOUbzH4POPrTf5sk
	 UPqqtB4prCas4maVt4AF/As6AfOtPj+6xgXD6ZajpfH9RPmQbXCGzgdP1185zvUo3
	 kOuXzdmrGL9oDzPU1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa.home ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1rSF6S13ID-00ToG3; Wed, 07
 Feb 2024 01:01:53 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mt76: inititalize sband.band to correct value
Date: Wed,  7 Feb 2024 01:01:30 +0100
Message-Id: <20240207000130.4040-1-spasswolf@web.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:53YJFb+JQxJ/gyqokVAlhpaiqPGLT50QFyVGIjFzYX/XLQjqOIa
 R3hx2O3ZlDIJOG0Qy7DGrAWMKvJvGOXXH/g0/PbpxlukPM7/YBO29B/4042l2DbITSAx3fw
 etwcoBKOAU9wVpcBOFO1+3XHZBihC2X298d97HmbiUmohpsUUQ43ZQURvCSSIdjIYdGfBDY
 SSqqae6CgZeYy8OanW/OQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6ElYAlAAUuk=;FFpjRFTVxztmRZWw1r6KcCyzFK+
 D6mHheJZKM71NSYWqH03ba/XiKPWISfLNpFPCizFDQboYgMbRQm9xJHFdnI3+39fI3meHFGhG
 llQVYCUbml3GdpJqo+kGMx9tTfHiw2pi7OzowS7ShSEthc18loT1KD8/Cf0ZI0zErl1q/dcjf
 OAZPx7ag+fIq/wFkRaRjrbwmmACbqw2+/rpHS/EcqJTfYjuOaqJ/hXaa7BkT/5cb0DT2Egqic
 S/C3TZ+Um5XSWLj1C9DAvvDak3VRJbe75wz/o6PXcKtrP3ZKUp13W856s8Z43dhhsV/97Q4p7
 6sd5tqcHoUs9+dU8xeZKZSsfCuz3KxtD1FgFrAgdLCMs8PaFJ4s93Z6c8MJwrHBsZMqCM5fwc
 zMxPQeXnACVtipBW57wZqHSEWSGRGpNsGnMTUU4V6A0ohyYMOUb68moT5Xkc6r4PZ+RwBwsDB
 I61KcFpC7qsDZCo9qDSPRg53mODMpY7XoqKRdLDrZd+WRx6ZiCwRWVYNvcl0hHG/GAq8XEpM/
 Mt0dPc7uELJ8k5SgKuJD7ph0Cuhi+l+d+ixfU14jKtfQ7cfdhshsmUvjCE2SHccclH0S0yNVo
 a9nnorsJlRCZG2QCqV8NEEeItst06a84buHGdpa3apCHL6QXr1k55Cfs/d8Zhd8FJOrOFnom9
 Sx/8Ociryuzjka+9Yzd6TUF9v/Y7IaLL3mUk/Sb3XEDvrMiJWoRtDbi2WAyC63va7vXL97Uwg
 hVaKC7a/x/RGBsoR61dWcTiPGpNgwXDVZ/8N2Hv4OY8PorQJhioa2fp9rAVXR17l4O0GMHtNw
 A64R0HM0crBISWaZROuWI3POjqbdDdPaFimVkIeHsNFhk=

Set phy->sband_{2,5,6}g.sband.band to the correct enum value, otherwise
the ieee80211_register_hw() will fail to register the device.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218466

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

When using linux-next-20240205 my mediatek wifi device failed to start.
A bisection led to commit f04d2c247e0407 as the problem:
https://bugzilla.kernel.org/show_bug.cgi?id=3D218466
After closer examination of the mt76 code it the problem was to to be
the incomplete initialization of phy->sband_{2,5,6}g. The band field has
to be set to not confuse the new mac80211 code. (the sband_2g structure
was correctly initialized accidendly as NL80211_BAND_2GHZ is 0).

Bert Karwatzki

