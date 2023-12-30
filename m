Return-Path: <linux-kernel+bounces-13329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFA82039B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921E81C2134C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737413C22;
	Sat, 30 Dec 2023 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="HWYX2cNv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7ED17E9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911897; x=1704171097;
	bh=xoCJFTO9+CWfEwOaRvKJoarW9UkFuNSaR1ANZeDoB50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HWYX2cNva/4uVA/Sq3t67Mr+1ucZcbP1jyUFutujNFLmLDrIwJT2Eva2facQaKkO8
	 Zt/wwOIBDBRl2YnGlzxsVw5doNVsiVtze8UMLovD9CmuWpZaOdma+rlOIj1sRsJAew
	 IA3pppPW+KkFKr8KWpRVozgPABgmA3dvFurr0j0k5yo71MRSwyDkMKmxBzyYw/q1MX
	 6CJj7A7GwXKZQRYLOt2m2PcMclY3/2pXtWoSwUe39qvqjakGpzoV59D+NBTAg1EVRY
	 OaoSD0BjGhPEvy/ksAa/blRxfUD/8qkgKmtH7t6sHNy4V8wyDEEo46rG+1XGr7zxkZ
	 UH9QT5TREXPkg==
Date: Sat, 30 Dec 2023 04:51:29 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 1/5] wifi: b43: Correct OpenFW QoS capability warning conditional
Message-ID: <20231230045105.91351-2-sergeantsagara@protonmail.com>
In-Reply-To: <20231230045105.91351-1-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Trigger the warning message should be when the OpenFW capability for QoS
does not advertise QoS support. Previously, the warning would be
incorrectly triggered when OpenFW reported QoS capability is present.

Fixes: 097b0e1bf18a ("b43: fix crash with OpenFWWF")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 drivers/net/wireless/broadcom/b43/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireles=
s/broadcom/b43/main.c
index 92ca0b2ca286..c81117a22ebf 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2713,7 +2713,7 @@ static int b43_upload_microcode(struct b43_wldev *dev=
)
 =09=09=09dev->hwcrypto_enabled =3D false;
 =09=09}
 =09=09/* adding QoS support should use an offline discovery mechanism */
-=09=09WARN(fwcapa & B43_FWCAPA_QOS, "QoS in OpenFW not supported\n");
+=09=09WARN(!(fwcapa & B43_FWCAPA_QOS), "QoS in OpenFW not supported\n");
 =09} else {
 =09=09b43info(dev->wl, "Loading firmware version %u.%u "
 =09=09=09"(20%.2i-%.2i-%.2i %.2i:%.2i:%.2i)\n",
--=20
2.42.0



