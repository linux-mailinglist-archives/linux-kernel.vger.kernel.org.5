Return-Path: <linux-kernel+bounces-148240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40558A7FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF85283F61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5413B794;
	Wed, 17 Apr 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KIaMesHn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96B13A885;
	Wed, 17 Apr 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346464; cv=none; b=lUcsV1WiW8zJjCtw09HPRfuocCkkRB7Lsge7bCpi3dHyZANY+awbB974O9yxS3KODtMwx7o6oqC05G6xpRYtOfPN1mnZinhXxIkcNfp/Y0CMwP+/xBZ77SRmgv/s8/xLbls1qKLoaVpPOMK5jUgjiJzyX5bIvuXYforVkjN6CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346464; c=relaxed/simple;
	bh=0/ADeysUK6zcQEDcTdDJA5QqOa1mNX4iXTZev0jcyPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCOd9bOcCbcQyyJ8k+qG0hAvlijrP6I4QKcNxph7jm/6Rjqxo4GJExAvHQiZMuZdl/reGq2daY89/bpVlJpn6jtu/ayvxqs3R7ZZuQ/xhe0AJodXWqdoPh3AeB3EPylbdwB729IBBW6SmPSPUA+mHmicaUfkK88pF+NlkKNGUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KIaMesHn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75E42FF806;
	Wed, 17 Apr 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UL/FZYt1ZDeYd7vr1TRXKJow8zuiDeZ1OlrlaoQyJrs=;
	b=KIaMesHnGM+QZ4HHU+SLtct92NVgLJLR6l+r128sCBRTosp72UH9pOBFMOO22BJeyGPdnf
	FfOml01VsVpwSjwFRv8Y8BBOhTXD9dPOsTrfIa3/YKWSPj9owJz/CjFa0a4/kR1xdCtAcL
	lsHmj0RXhsvlx2VDKsh8fDuND0RZnLyl48kqj3cDkCkjCuMi76Kt2fkpfZdsXD+urP9aT1
	wGlRbnWGxxBbKJlp7niM2zwjmHICVggzuZcR6Mk6APS/6AuyrlCvnvHISxH0C9TPmzpkmw
	OTFbMV7EmXaABE4CP4gh+5qR8JnNy5CUKUap3jKSANk54vHdRHP4TKXk82TE/A==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:08 +0200
Subject: [PATCH 1/6] wifi: wilc1000: set net device registration as last
 step during interface creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

net device registration is currently done in wilc_netdev_ifc_init but
other initialization operations are still done after this registration.
Since net device is assumed to be usable right after registration, it
should be the very last step of initialization.

Move netdev registration at the very end of wilc_netdev_ifc_init to let
this function completely initialize netdevice before registering it.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 31 ++++++++++++------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 73f56f7b002b..acc9b9a64552 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -965,16 +965,6 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	vif->priv.wdev.iftype = type;
 	vif->priv.dev = ndev;
 
-	if (rtnl_locked)
-		ret = cfg80211_register_netdevice(ndev);
-	else
-		ret = register_netdev(ndev);
-
-	if (ret) {
-		ret = -EFAULT;
-		goto error;
-	}
-
 	ndev->needs_free_netdev = true;
 	vif->iftype = vif_type;
 	vif->idx = wilc_get_available_idx(wl);
@@ -985,13 +975,24 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	mutex_unlock(&wl->vif_mutex);
 	synchronize_rcu();
 
-	return vif;
-
-error:
 	if (rtnl_locked)
-		cfg80211_unregister_netdevice(ndev);
+		ret = cfg80211_register_netdevice(ndev);
 	else
-		unregister_netdev(ndev);
+		ret = register_netdev(ndev);
+
+	if (ret) {
+		ret = -EFAULT;
+		goto error_remove_vif;
+	}
+
+	return vif;
+
+error_remove_vif:
+	mutex_lock(&wl->vif_mutex);
+	list_del_rcu(&vif->list);
+	wl->vif_num -= 1;
+	mutex_unlock(&wl->vif_mutex);
+	synchronize_rcu();
 	free_netdev(ndev);
 	return ERR_PTR(ret);
 }

-- 
2.44.0


