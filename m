Return-Path: <linux-kernel+bounces-68915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F58581DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CF284661
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E567133289;
	Fri, 16 Feb 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VT30hQeK"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89F12FF8D;
	Fri, 16 Feb 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098790; cv=none; b=U+ikOd1sAnpBjIjtlHzlu6CcM2dpt23EoiNJTLMValK6fA+DR5wIA8YWRgo9sn3aTMJBpTw0RP/ku+BS2+UhTUhfEJht79700hTuDUaMXVsAq6YngGBu1rLkWLuJENzZDP51vNU625dGP+Rj7G3nX0SiHKA3Ykhk0AK7gpuHF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098790; c=relaxed/simple;
	bh=zLUUTvjdltLauytWMLXk0P21dQJFhX21nlwthpGvqBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnOqBxAqX4U2exyQwwkGB0DaVrGewJSdFMeFCFeQpO00pHWUZPf5n83FLvo1LFa/Jj8gr3V3gSW4dZA+7QrDvgDb25mcLsGrGFarMV80+V0EUpsNrS8wAeYijDWI858JtCQAg31mC4XiL9enMmVe3hXeVbtCh6drBmtA0n7Jnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VT30hQeK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82E6224000E;
	Fri, 16 Feb 2024 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uet75mnIaE3JwyHsIIMQq6iy2iUMj02Z/O8LfzL/MwQ=;
	b=VT30hQeKUUP8jWKQdwSRadSL4Wl0n3kJ/0/7c6Tob+Zzeaoa9ZOEIS07fdlzzUR4EW64FD
	5SRQT8wuQLMDbffNxQUZYWAW2JvOPnFg+St8sO4mVEkiouPRfK/R51I4Je0R/tjZEkUV8Z
	6KO3KXtSas3PLMmaCBpV4FQ4fvQqYGv7cyt1WVDQovj7c4ybdX3s2epXYHkadPnJmkjZbJ
	tpEmSJ99BwuTN9+6bFeUu1ekbENka1ksozzQ2ocLlSWcOQuojioDoiX/r9jfy3c1SaOWX1
	sZyxojPY0x4eLXGFqwG3pKZ68SuIFO6u+Uau5k5Jg85zwG6hN168LmaRtENVbw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:26 +0100
Subject: [PATCH RFC net-next v8 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-8-510f42f444fb@bootlin.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Prepare for future hardware timestamp selection by adding source and
corresponding pointers to ptp_clock structure. Additionally, introduce
helpers for registering specific phydev or netdev PTP clocks, retrieving
PTP clock information such as hwtstamp source or phydev/netdev pointers,
and obtaining the ptp_clock structure from the phc index.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch.
---
 drivers/ptp/ptp_clock.c          | 71 +++++++++++++++++++++++++++++++++
 drivers/ptp/ptp_private.h        |  5 +++
 include/linux/ptp_clock_kernel.h | 84 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index f374b1e89780..d7cd7e01990e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -504,6 +504,77 @@ void ptp_cancel_worker_sync(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_cancel_worker_sync);
 
+struct ptp_clock *netdev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct net_device *dev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &dev->dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_NETDEV;
+	ptp->netdev = dev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(netdev_ptp_clock_register);
+
+struct ptp_clock *phydev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct phy_device *phydev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &phydev->mdio.dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+	ptp->phydev = phydev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(phydev_ptp_clock_register);
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB;
+}
+EXPORT_SYMBOL(ptp_clock_from_phylib);
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_NETDEV;
+}
+EXPORT_SYMBOL(ptp_clock_from_netdev);
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_NETDEV)
+		return NULL;
+
+	return ptp->netdev;
+}
+EXPORT_SYMBOL(ptp_clock_netdev);
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_PHYLIB)
+		return NULL;
+
+	return ptp->phydev;
+}
+EXPORT_SYMBOL(ptp_clock_phydev);
+
+struct ptp_clock *ptp_clock_get_by_index(int index)
+{
+	if (index < 0)
+		return NULL;
+
+	return xa_load(&ptp_clocks_map, (unsigned long)index);
+}
+EXPORT_SYMBOL(ptp_clock_get_by_index);
+
 /* module operations */
 
 static void __exit ptp_exit(void)
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 45f9002a5dca..3faecc5b9136 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -41,6 +41,11 @@ struct ptp_clock {
 	struct ptp_clock_info *info;
 	dev_t devid;
 	int index; /* index into clocks.map */
+	enum hwtstamp_source phc_source;
+	union { /* Pointer of the phc_source device */
+		struct net_device *netdev;
+		struct phy_device *phydev;
+	};
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..174a0b98632b 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -9,7 +9,9 @@
 #define _PTP_CLOCK_KERNEL_H_
 
 #include <linux/device.h>
+#include <linux/netdevice.h>
 #include <linux/pps_kernel.h>
+#include <linux/phy.h>
 #include <linux/ptp_clock.h>
 #include <linux/timecounter.h>
 #include <linux/skbuff.h>
@@ -340,6 +342,70 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * netdev_ptp_clock_register() - register a PTP hardware clock driver for
+ *				 a net device
+ *
+ * @info: Structure describing the new clock.
+ * @dev:  Pointer of the net device
+ */
+
+extern struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev);
+
+/**
+ * phydev_ptp_clock_register() - register a PTP hardware clock driver for
+ *				 a phy device
+ *
+ * @info:   Structure describing the new clock.
+ * @phydev:  Pointer of the phy device
+ */
+
+extern struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev);
+
+/**
+ * ptp_clock_from_phylib() - return true if the PTP clock comes from phylib
+ *
+ * @ptp:    The clock obtained from net/phy_ptp_clock_register().
+ */
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_from_netdev() - return true if the PTP clock comes from netdev
+ *
+ * @ptp:    The clock obtained from net/phy_ptp_clock_register().
+ */
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_netdev() - obtain the net_device of PTP clock
+ *
+ * @ptp:    The clock obtained from netdev_ptp_clock_register().
+ */
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_phydev() - obtain the phy_device of a PTP clock
+ *
+ * @ptp:    The clock obtained from phydev_ptp_clock_register().
+ */
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_get_by_index() - obtain the PTP clock from a given PHC index
+ *
+ * @index:    The device index of a PTP clock.
+ */
+
+struct ptp_clock *ptp_clock_get_by_index(int index);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -405,6 +471,24 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev)
+{ return NULL; }
+static inline struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev)
+{ return NULL; }
+static inline bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{ return false; }
+static inline bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{ return false; }
+static inline struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{ return NULL; }
+static inline struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
+{ return NULL; }
+static inline struct ptp_clock *ptp_clock_get_by_index(int index);
+{ return NULL; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }

-- 
2.25.1


