Return-Path: <linux-kernel+bounces-82977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955A868C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3488C1C24642
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C23139566;
	Tue, 27 Feb 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Toaf3mwm"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA0137C3E;
	Tue, 27 Feb 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026816; cv=none; b=g8BZ4aetZKarkLRkJBKmP+/5a3LCnNlo8DlVugRRSQcx8kYw4cArcbWZOgryX+DgI3oZuhfVteZ7KU8q9Y5C+WCShHxUprSti/ECAMz83z+HA4A61db3i5ikUQ9r1ZNaQsj6u1uRCL2GezYk96CGqyVZ6SfIORiLb3/m8ZWO+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026816; c=relaxed/simple;
	bh=MrAC+0ugacDW+NQuPpEBMoPhZSOJdpkLAl75R2nIfps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+vXpyqdsXB03XMtqEdkFFkVvij9BdFy69AoXlWBPKccLs60eFvnVD3t1f37VT/G7VAF4JrudAxzhSlva/GYunDXPEz5KmYDv/gdzJaSZy0PnwBZMkB0OALbf7K85tfNtNO9HDCypiIU1ayk93p5uamrlfhSN7LBlp8VlSXFvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Toaf3mwm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2EC051BF219;
	Tue, 27 Feb 2024 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlGBjihIRSEjSd8ST43CRqXi/gW9NM8DXJGmyMeDqgs=;
	b=Toaf3mwmcXc+zhwAdXDEsfX60JOGqIVKuao1hV1NpjdNWwC3ZVN01Me//rXPGJ+eLYHcfL
	kSMWLEnDollecV7xJfbPv2hjY6z+lZCSBr1pjiA4HrSa85czOC+xubyPYGRvx3MvRQBV89
	eA4qj5Nz6XLAck1HzaOauJm2z5O+0HrUyH1x6H5UVsxRjycEbvcRzFBL5abB6HTMHTkqlU
	lnRHLFqfTAaQ/cna+QuUQ5NeO/r/EQoSpUcAMQ6O+w91HwmJki6LT7vWy15hf6pyRt0QXq
	rsqDf+6Po1Bwb5gyuzMfzbb9EUVSIqb/v8/OnU9GA1zMwwXiJk6JrCfj0LuXuA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 2/6] leds: trigger: Create a new LED netdev trigger for collision
Date: Tue, 27 Feb 2024 10:39:41 +0100
Message-ID: <20240227093945.21525-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Collisions on link does not fit into one of the existing netdev triggers.

Add TRIGGER_NETDEV_COLLISION in the enum led_trigger_netdev_modes.
Add its definition in Documentation.
Add its handling in ledtrig-netdev, it can only be supported by hardware
so no software fallback is implemented.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../ABI/testing/sysfs-class-led-trigger-netdev        | 11 +++++++++++
 drivers/leds/trigger/ledtrig-netdev.c                 |  4 ++++
 include/linux/leds.h                                  |  1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
index a6c307c4befa..fbb2bc1d6108 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
@@ -178,3 +178,14 @@ Description:
 		If set to 1, the LED's normal state reflects the link full
 		duplex state of the named network device.
 		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/collision
+Date:		Feb 2024
+KernelVersion:	6.8
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal collision of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects collisions.
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 8e5475819590..5c17b8e27d5c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -318,6 +318,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
+	case TRIGGER_NETDEV_COLLISION:
 		bit = attr;
 		break;
 	default:
@@ -352,6 +353,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
+	case TRIGGER_NETDEV_COLLISION:
 		bit = attr;
 		break;
 	default:
@@ -410,6 +412,7 @@ DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
 DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
+DEFINE_NETDEV_TRIGGER(collision, TRIGGER_NETDEV_COLLISION);
 
 static ssize_t interval_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -473,6 +476,7 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_tx.attr,
 	&dev_attr_interval.attr,
 	&dev_attr_offloaded.attr,
+	&dev_attr_collision.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(netdev_trig);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 4754b02d3a2c..8864d6ce8185 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -578,6 +578,7 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
 	TRIGGER_NETDEV_RX,
+	TRIGGER_NETDEV_COLLISION,
 
 	/* Keep last */
 	__TRIGGER_NETDEV_MAX,
-- 
2.43.0


