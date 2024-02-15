Return-Path: <linux-kernel+bounces-67066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FC68565AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05530282F59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69C132466;
	Thu, 15 Feb 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CAkj2+hm"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E02130ADA;
	Thu, 15 Feb 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006466; cv=none; b=FdTUmVZQVifWpkS7+CqlAdj0gFoeR6KbP8P372R78S7aEVzA/lG45BWlo/p5u4mSYw3XMFtAaIKI53maiuNKeHXwztzTkJQGYjr8vVD+qT3RMiMAj6lH09AXaRre0sHnIQf9ejYRHHiivyJ70TB5q5JC6JWQZSdY+w9m7lSRwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006466; c=relaxed/simple;
	bh=EMBLwevEY0zUQ/hVqUx05ubdMW0u9n/ytRqgi5tBFGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d69bi2fDmGP7Nq+vyMgooHSDaYb2L2U8A3GH9q7Z7garhsneDGTCk9fcLJIN8bGMaAPTniYyhI69pYD8UJCHQMb+gkIv1SBQC+WiQUH2asEcU6L4lA1vmT02w5aOIL7DowmqAvtvfnEXxmV1+lQKQlp6P4eK1aXRg/YnJm2rK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CAkj2+hm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A11686000E;
	Thu, 15 Feb 2024 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708006462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXP2gPLBFEVoi3fyWxeX+9N2//T08FGxLjrXEVgziMc=;
	b=CAkj2+hmxuAnKP13edn3CL4etwko857Qu21F7Javyn60cvNa1t3TCpLbL41EPsVYYdBcB4
	Z3DoiZuR8ZwVfRxVy0W/IcH3rwwC322JvsbjtAxgfhgd84QC2l2yDF/O8MiHKLebVDyVRp
	1hMjOei6OK28ugswa9qHn+8rBl0iG1mhUjaZDp4L8zt0SXTh7OqyBJQB1knvgSwiykFzDk
	nK8/m/bzJBaMgs0M5UhuIxMoog7h+yuHERX31qiR/gEGNTqcdyCTIudbBZOAxUBnONNZYE
	PpR+d91fkfMSRcHO6trBdgvLtBwvaFtBYNGrA5mf3dwyj14MmsWQJ5s5p7lP0g==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 15:13:52 +0100
Subject: [PATCH 1/2] wifi: nl80211: force WLAN_AKM_SUITE_SAE in big endian
 in NL80211_CMD_EXTERNAL_AUTH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-nl80211_fix_akm_suites_endianness-v1-1-57e902632f9d@bootlin.com>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
In-Reply-To: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Mitsyanko <imitsyanko@quantenna.com>, 
 Sergey Matyukevich <geomatsi@gmail.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

User-space supplicant (observed at least on wpa_supplicant) historically
parses the NL80211_ATTR_AKM_SUITES from the NL80211_CMD_EXTERNAL_AUTH
message as big endian _only_ when its value is WLAN_AKM_SUITE_SAE, while
processing anything else in host endian. This behavior makes any driver
relying on SAE external auth to switch AKM suite to big endian if it is
WLAN_AKM_SUITE_SAE. A fix bringing compatibility with both endianness
has been brought into wpa_supplicant, however we must keep compatibility
with older versions, while trying to reduce the occurences of this manual
conversion in wireless drivers.

Add the be32 conversion specifically on WLAN_AKM_SUITE_SAE in nl80211 layer
to keep compatibility with older wpa_supplicant versions.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Only a few minor modifications from Johannes' initial suggestion:
- fixed unbalanced parenthesis
- slightly reworded the inlined documentation
---
 net/wireless/nl80211.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5f18cbf7cc3d..046ce0513d31 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20136,9 +20136,26 @@ int cfg80211_external_auth_request(struct net_device *dev,
 	if (!hdr)
 		goto nla_put_failure;
 
+	/* Some historical mistakes in drivers <-> userspace interface (notably
+	 * between drivers and wpa_supplicant) led to a big-endian conversion
+	 * being needed on NL80211_ATTR_AKM_SUITES _only_ when its value is
+	 * WLAN_AKM_SUITE_SAE. This is now fixed on userspace side, but for the
+	 * benefit of older wpa_supplicant versions, send this particular value
+	 * in big-endian. Note that newer wpa_supplicant will also detect this
+	 * particular value in big endian still, so it all continues to work.
+	 */
+	if (params->key_mgmt_suite == WLAN_AKM_SUITE_SAE) {
+		if (nla_put_be32(msg, NL80211_ATTR_AKM_SUITES,
+				 cpu_to_be32(WLAN_AKM_SUITE_SAE)))
+			goto nla_put_failure;
+	} else {
+		if (nla_put_u32(msg, NL80211_ATTR_AKM_SUITES,
+				params->key_mgmt_suite))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put_u32(msg, NL80211_ATTR_AKM_SUITES, params->key_mgmt_suite) ||
 	    nla_put_u32(msg, NL80211_ATTR_EXTERNAL_AUTH_ACTION,
 			params->action) ||
 	    nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, params->bssid) ||

-- 
2.43.0


