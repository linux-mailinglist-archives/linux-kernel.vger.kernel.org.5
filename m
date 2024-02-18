Return-Path: <linux-kernel+bounces-70522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8C8598D4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA13281FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2671B41;
	Sun, 18 Feb 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXN1XYGI"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E506F09B;
	Sun, 18 Feb 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282848; cv=none; b=c/5rzxXeUpGlwb0hlSW5FVt+XTsTGHMP6H2E7d8gRr+h44LDKHrsgpiYl5wC1OkYQkt7mshvOl+mEQfVNf2aLh8NLQCeu6DUkWEYOwRzVab6w3Q0Cu1e2D/UA2MWRTcLdx1DAriV8jaNBC5bVxUgomcZgYLNfXatuj2QSaMyK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282848; c=relaxed/simple;
	bh=/PV/hiioXn852DS6V+QqGARR5Kr4QVyjX7tUAzXK4v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3SKSamBO7Xdk+Y5pDiv1d60pPrPayCC/WGKYLX9OcWXZYhcSloZsMkZ3GRGz4SkGlV79/ZDWL76om9n/OVb2qZisqvPc22QxORwP0d1RfMYZJsZcDOPN87SRRRRstQKHhBWmkcCWSpawjbVWQQcYfT76yPsQ8VPiByqPCnLikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXN1XYGI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d107900457so51332651fa.1;
        Sun, 18 Feb 2024 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282845; x=1708887645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEYeK8i11QxkJeB25DqEOcldL7O5Xx2ufJLmOFFJoo8=;
        b=EXN1XYGIJ4DugLviidezJrzLiwm8NCSIxFtm6A5f62c6JqXomxvus29LahGXjhoM2u
         AoIIyEvGzf3kiltrfr9EHPvpD20ftVYlejq1MWIjwiAEyO7jacaW6xcnhsxzMTxZ/XZR
         hLHBhRHlWG8Zia6HICPVrfmj/u4ORmOpciq6Zzp6I/go1q3lI2cip5n+lAC/1sGg6eCR
         8SAzpsQEan2fmPTHgKu1Rb1gpvu1Qu2FbTSj1l7Jax7e5xFSraf0+B6ZFZSudzGzLRkB
         MDXf2c4JpWqsMxX3zkL/+6ZbJfO3+0V2KDLdBcBEdFUB7ncSHYUZ+NQs0T+09gZX/kaz
         u2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282845; x=1708887645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEYeK8i11QxkJeB25DqEOcldL7O5Xx2ufJLmOFFJoo8=;
        b=s13j7zBcwSh5zWrE37kHEv35Y3kO9kxv3pZUHM4BjU1SdPPbuHXF/2q5Nig3tqozBU
         szjDZWUlGG4MFI0RvkdIP4BOOwgIby49oOG+0vpRRBkK2V1CUEi6exnlMSb+a/ALZlXJ
         kCpZ3np4fkY1K+e1N4+/giqxXye4uL+rFuMgqAJRU6Kv0yuS+BUsiP5SwSC3y6iTqDkc
         rL37kkED7aryNVVCHXMWCyO/iz6ibuYVoYmSv3LY8fyYkoXCyFY+yi9K8Om/L9XAjmjL
         1zqSXBQYmdT9RPSuuic8x4XdVSh2KyQmjCHZA/jaJYVTvyWlL9cAK5JX33KMs06yGavN
         ftcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF7S7pffDedlWVoeI+kwuTGX/p1EirrTFwZUIryvvVLfeFegRs3OuSjvliNywJ3XPou3U57XLJOoS7r+zDRyvDDTza0fh8y7wsPY8dhpoLtm/eyOJtx0e9t7izWg33AJnAeo3S
X-Gm-Message-State: AOJu0YxL2SwGNBUCHemslSWUXhsq+E0+9INKb1Lc0Hd1vazT0Yc2G2cL
	4mOQ/OuwSYIqjVQzQMOap/wqBN12TA4ovPsusAIvKdTPHqgeSK5y
X-Google-Smtp-Source: AGHT+IFomZUmY/xUptbNgyWNZcYkhKcd+F9Fm2a3eJ/uTvltvHZxO+epovoQ/+bSm+/MVwZL/j0GGQ==
X-Received: by 2002:a2e:b60a:0:b0:2d2:31b0:4f64 with SMTP id r10-20020a2eb60a000000b002d231b04f64mr1761364ljn.34.1708282844348;
        Sun, 18 Feb 2024 11:00:44 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:43 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 1/6] net: phy: add support for defining multiple PHY IDs in PHY driver
Date: Sun, 18 Feb 2024 20:00:27 +0100
Message-ID: <20240218190034.15447-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY driver might implement the same OPs for different PHY ID and
using a mask is not enough to match similar PHYs.

To reduce code duplication, add support for defining multiple PHY IDs in
PHY driver struct.

Introduce a new variable in phy_driver struct, .ids, where a table array of
mdio_device_id can be defined to reference multiple PHY IDs (with their
own masks) supporting the same group of OPs and flags.

Introduce a new variable in phy_device, .dev_id, where the matching
mdio_device_id is stored. PHYs supporting multiple PHYs for one PHY
driver struct, should use this instead of matching for phy_id.

Single PHY ID implementation is still supported and dev_id is filled
with the data from phy_driver in this case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 94 ++++++++++++++++++++++++++++++------
 include/linux/phy.h          |  8 ++-
 2 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d63dca535746..9b96357e4de8 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -522,12 +522,74 @@ static int phy_scan_fixups(struct phy_device *phydev)
 	return 0;
 }
 
+static int phy_driver_match_id(struct phy_driver *phydrv, u32 id,
+			       const struct mdio_device_id **dev_id)
+{
+	const struct mdio_device_id *ids = phydrv->ids;
+
+	/* PHY driver might provide an array of different PHY IDs and
+	 * masks. Walk them if this is the case and compare with ID.
+	 */
+	if (ids) {
+		/* From mdio_device_id struct phy_id_mask MUST
+		 * be used as sentinel.
+		 */
+		while (ids->phy_id_mask) {
+			if (phy_id_compare(id, ids->phy_id, ids->phy_id_mask)) {
+				if (dev_id)
+					*dev_id = ids;
+
+				return 1;
+			}
+
+			ids++;
+		}
+	}
+
+	if (phy_id_compare(id, phydrv->phy_id, phydrv->phy_id_mask))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * phy_driver_match - match a phydriver with a given PHY istance
+ * @phydrv: PHY driver to compare with
+ * @phydev: PHY istance to use for comparison. Either PHY ID will be used or
+ *   with C45 PHY ID is extracted from Package regs.
+ * @dev_id: Pointer where to store pointer to a matchin mdio_device_id.
+ *   mdio_device_id are assumed to be statically allocated for each PHY driver,
+ *   hence the reference to this struct is returned here.
+ *
+ * Returns 1 if matching, 0 otherwise. dev_id can be passed as NULL to skip
+ * referecing a matching mdio_device_id if found.
+ */
+static int phy_driver_match(struct phy_driver *phydrv, struct phy_device *phydev,
+			    const struct mdio_device_id **dev_id)
+{
+	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+	int i;
+
+	if (!phydev->is_c45)
+		return phy_driver_match_id(phydrv, phydev->phy_id,
+					   dev_id);
+
+	for (i = 1; i < num_ids; i++) {
+		if (phydev->c45_ids.device_ids[i] == 0xffffffff)
+			continue;
+
+		if (phy_driver_match_id(phydrv, phydev->c45_ids.device_ids[i],
+					dev_id))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int phy_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct phy_device *phydev = to_phy_device(dev);
 	struct phy_driver *phydrv = to_phy_driver(drv);
-	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
-	int i;
 
 	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
 		return 0;
@@ -535,20 +597,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (phydrv->match_phy_device)
 		return phydrv->match_phy_device(phydev);
 
-	if (phydev->is_c45) {
-		for (i = 1; i < num_ids; i++) {
-			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
-				continue;
-
-			if (phy_id_compare(phydev->c45_ids.device_ids[i],
-					   phydrv->phy_id, phydrv->phy_id_mask))
-				return 1;
-		}
-		return 0;
-	} else {
-		return phy_id_compare(phydev->phy_id, phydrv->phy_id,
-				      phydrv->phy_id_mask);
-	}
+	return phy_driver_match(phydrv, phydev, NULL);
 }
 
 static ssize_t
@@ -3410,9 +3459,22 @@ static int phy_probe(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	struct device_driver *drv = phydev->mdio.dev.driver;
 	struct phy_driver *phydrv = to_phy_driver(drv);
+	const struct mdio_device_id *dev_id = NULL;
+	struct mdio_device_id *phy_dev_id;
 	int err = 0;
 
 	phydev->drv = phydrv;
+	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
+	/* Fill the mdio_device_id for the PHY istance.
+	 * If PHY driver provide an array of PHYs, search the right one,
+	 * in the other case fill it with the phy_driver data.
+	 */
+	if (phy_driver_match(phydrv, phydev, &dev_id) && dev_id) {
+		memcpy(phy_dev_id, dev_id, sizeof(*dev_id));
+	} else {
+		phy_dev_id->phy_id = phydrv->phy_id;
+		phy_dev_id->phy_id_mask = phydrv->phy_id_mask;
+	}
 
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c2dda21b39e1..f0313b9e0173 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -547,6 +547,7 @@ struct macsec_ops;
  * @drv: Pointer to the driver for this PHY instance
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
+ * @dev_id: The matched device ID for this PHY instance
  * @phy_id: UID for this device found during discovery
  * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
  * @is_c45:  Set to true if this PHY uses clause 45 addressing.
@@ -645,6 +646,7 @@ struct phy_device {
 
 	struct device_link *devlink;
 
+	const struct mdio_device_id dev_id;
 	u32 phy_id;
 
 	struct phy_c45_device_ids c45_ids;
@@ -885,6 +887,8 @@ struct phy_led {
  * struct phy_driver - Driver structure for a particular PHY type
  *
  * @mdiodrv: Data common to all MDIO devices
+ * @ids: array of mdio device IDs to match this driver (terminated with
+ *   zero phy_id_mask)
  * @phy_id: The result of reading the UID registers of this PHY
  *   type, and ANDing them with the phy_id_mask.  This driver
  *   only works for PHYs with IDs which match this field
@@ -906,6 +910,7 @@ struct phy_led {
  */
 struct phy_driver {
 	struct mdio_driver_common mdiodrv;
+	const struct mdio_device_id *ids;
 	u32 phy_id;
 	char *name;
 	u32 phy_id_mask;
@@ -1206,7 +1211,8 @@ static inline bool phy_id_compare(u32 id1, u32 id2, u32 mask)
  */
 static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
 {
-	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
+	return phy_id_compare(id, phydev->dev_id.phy_id,
+			      phydev->dev_id.phy_id_mask);
 }
 
 /* A Structure for boards to register fixups with the PHY Lib */
-- 
2.43.0


