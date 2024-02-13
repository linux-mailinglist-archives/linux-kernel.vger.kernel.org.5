Return-Path: <linux-kernel+bounces-63773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6FD853448
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0276DB2AA34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905B60861;
	Tue, 13 Feb 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xk/WBPlP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1A605C2;
	Tue, 13 Feb 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836690; cv=none; b=rXPi0TwKkWbOf+yV8mPiRIFqhErNp7WyoVhI4z5f6h2k7RkmNgsSib2AgH3SKohW7OfbBhlTww/fjy45ZXRujUlLdqSPTjM9ing1Xw+ZUcRUQxE6B3L/spD4ZhFPfiMP+4TfxGIGEU8W8E3hdPEcVlwfjDLkWXDuuiSv+bB786c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836690; c=relaxed/simple;
	bh=iBBewnB2kKbuDY1N2YWRJf9/pYhFwE10TTpPgZnLp+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBJdI0Kcmzm4d+kSauHObfWwUvPCvVWnf2oC0bHqjwtTGEOkRNEF0/5O2PQ9HBzpOWM/7gKpUcANCtqfKiPPo7A5jrYlGL82zfE6pdrJqJiT7wX7IJnj54374thWValXy1uAh7If2lxfDrsevGiKNJ9nm2+bHWAxHNTCig5tTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xk/WBPlP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 236F51BF20B;
	Tue, 13 Feb 2024 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707836687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4RYso1bdjI1BwO/bVlMqy6V8aSjC8tPTMLgRYJlyIA=;
	b=Xk/WBPlPw8lzAKb5Gh1ddKo7lnRVaTi7CkbfYmO4vxBs7qOFxRHeFbCSj3EFyI/EhtooLE
	mToSi8e3Axa1bFxICTxEIZKSK2An+96HaYl85QH9Su6FoEscWDNPryhC3/cK2aTNfOGbJP
	/3wG1w9edDtCue0NxpaCoMHAOejTLBBkzIm8X8C0ann/76schcfw384b4quJOO7TLbfF0O
	zA8J9pjsmVXe8SCvETmHlone3XCNP1ePMc1wHFpv9fMd++qpAzprVGSjTWA0uSQEqKnxzl
	s+aOoPb0X/ksp3BqdPQwZ6fqQ7uHieNGJxMws2F7HxIHr3N07KPL+RXXLsPvmA==
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
Subject: [PATCH net-next v7 08/13] netlink: specs: add ethnl PHY_GET command set
Date: Tue, 13 Feb 2024 16:04:25 +0100
Message-ID: <20240213150431.1796171-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
References: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
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

V7: No changes
V6: Updated the spec according to the new attributes
V5: No changes
V4: Remove the ethtool-user generated code
V3: New patch

 Documentation/netlink/specs/ethtool.yaml | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index bb6e1dc6d1c5..e98d78fbc2f3 100644
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
+        name: upstream-phy-index
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
+            - upstream-phy-index
+            - upstream-sfp-name
+            - downstream-sfp-name
+            - id
+      dump: *phy-get-op
-- 
2.43.0


