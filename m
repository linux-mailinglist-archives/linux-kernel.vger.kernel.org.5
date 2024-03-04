Return-Path: <linux-kernel+bounces-90786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F887050A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6774B1C233BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C95654916;
	Mon,  4 Mar 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fLC8FCYX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D347A74;
	Mon,  4 Mar 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565028; cv=none; b=hPQUMfDx9vR0ufwyJiNLzZF0EI+neLMqQPN43klvY115rgbbNRnZ50+RVssXlYhUbpW4r5D+2wJB+ymzd81xOTJ8FD/dQRLl2+1f9ukFZs9ycJdtY+amSzVIt808Y/WhmyeY9EsW/ZOY0+aaVDPXBjF+uHx/52lhkEBc1YLBBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565028; c=relaxed/simple;
	bh=48uR+uTWUbOCP5/KOB5WdmOWyOrfHiyIP9wF4ebqgzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oki8IDcpa6YO26b7yLcJiN0OXEcgFWpvlBziMyY5UVRvKEaYK/I+Oqz4W3vDE4/+yRpbrptl4vjvrAXvkUehieZw2Froid1C7gK+hT/iPVjTWX5oUX+slPI8GzlCHzCSXx2HYkCaLbQbnYEPznj3wSZPkhW/neB/n0gah2tZPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fLC8FCYX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2015A1BF20B;
	Mon,  4 Mar 2024 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709565025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJjE6LJRVPmqYJ+R0HF1dBW3fSRm9OX3+Qc/AE8R0EU=;
	b=fLC8FCYXkqM084U+hiFedMQCk85UHEdLnEgwWedvaaHkCxO7FXJCckZAwQP8tUhKj/3tRI
	S4nOQK1GCGAcqkm4y0GbNcUX9/2/P8tHFjjEkb8RH8jHhy4MaHXQ5Eu2kNjykQh2nV7LqG
	/8YLWRt2ayFK6fwDPxuHqduzh5rAXTZ4/keOavHnoRYvxFPsab7Mj8Nzu8ePQmvwrDESaa
	+QghcxMu/dN3VDTEq4MF6mC/kopVGbtLe66pJnbsEodQql13ESLz0GO0/yV0k5C5JyoT5u
	NpozeULmXGB50KJQVuoGONVmvy47Jcus8R6SPP+Zehadcfip4FQfHpwWtqR0BA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v10 08/13] netlink: specs: add ethnl PHY_GET command set
Date: Mon,  4 Mar 2024 16:10:04 +0100
Message-ID: <20240304151011.1610175-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The PHY_GET command, supporting both DUMP and GET operations, is used to
retrieve the list of PHYs connected to a netdevice, and get topology
information to know where exactly it sits on the physical link.

Add the netlink specs corresponding to that command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V10: rename upstream-phy-index in the phy-get-op definition
V9: rename upstream-phy-index to upstream-index to align with the
    ethtool_netlink.h definition
V8: No changes
V7: No changes
V6: Updated the spec according to the new attributes
V5: No changes
V4: Remove the ethtool-user generated code
V3: New patch

 Documentation/netlink/specs/ethtool.yaml | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index bb6e1dc6d1c5..58a38a8cace6 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,11 @@ definitions:
     name: stringset
     type: enum
     entries: []
+  -
+    name: phy-upstream-type
+    enum-name:
+    type: enum
+    entries: [ mac, phy ]
 
 attribute-sets:
   -
@@ -945,6 +950,38 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: phy
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: index
+        type: u32
+      -
+        name: drvname
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: upstream-type
+        type: u32
+        enum: phy-upstream-type
+      -
+        name: upstream-index
+        type: u32
+      -
+        name: upstream-sfp-name
+        type: string
+      -
+        name: downstream-sfp-name
+        type: string
+      -
+        name: id
+        type: u32
 
 operations:
   enum-model: directional
@@ -1696,3 +1733,25 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: phy-get
+      doc: Get PHY devices attached to an interface
+
+      attribute-set: phy
+
+      do: &phy-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - index
+            - drvname
+            - name
+            - upstream-type
+            - upstream-index
+            - upstream-sfp-name
+            - downstream-sfp-name
+            - id
+      dump: *phy-get-op
-- 
2.44.0


