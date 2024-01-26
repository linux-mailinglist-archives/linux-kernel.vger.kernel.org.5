Return-Path: <linux-kernel+bounces-40507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1A83E1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A341F24BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2214724A0F;
	Fri, 26 Jan 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T9syU4aV"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73808219EB;
	Fri, 26 Jan 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294348; cv=none; b=lDmShc2M8UhLVSrdvqw0Q4hSDREKWcpPfJDswZ4KxnvsIxqXwDXGhNLJsCDGMdp2JCu97iVWTAyP4vEasB0DLijKWPhilv4qHM3HkBVij7NXqEbv3ciJO8MjHB5gdt95h4CsC/tzESEHGFZCUXASZpG530Mnv1YC9tFHOYrc5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294348; c=relaxed/simple;
	bh=L1/7GgZEZkwu907IIZsGcUhVTFO5X69YjAeJLh8+EaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDsqUwIOaaVRC6rVMaX8YkIEJkgUABuf1TSvoI46Bn3LYbPy4+a7mAImDjYgRvurT7C6ulwly499ewV5TxNAQc1pOUgThcsIlBfIgYyoDfbpcDLsk74DycXx3Lqj6G1xMofvlRi4oHYjb2ayADh8QsVpwN7IwQf2SGnslkba7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T9syU4aV; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B949BFF80D;
	Fri, 26 Jan 2024 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P76UuFX42Mbbf1Xqm1+TRGZvf9JtOi4DULTKekwH38I=;
	b=T9syU4aVvFUeVP1bIJ4bGttlSK/o5f/krNUKlkkHeb2SroxEPM4sKCxJs1C947GGJWlXTf
	xeRt512Z2cCBfH2iHSq2CwJJVWfgyL5n4EKwS3ZfSQYOy10MDhctig7ffV6jOW/qcSdVJo
	7M6OcBG86Y1I1NVkOm3z97zktxL8jzcnHPCGkJtzIVd40JKfxqWnTlgYjVOtFATZpcYJAM
	crJx8S8T+T2NdGRaAEIbG9P54bLQibp+PnqC31KS+waXzZM0inkP92BOvo/3Q3YsZKiiaw
	cbz1U1j/VA5TwaRBwfZ9NmY+0dQ+tvMN3Qrlag9GI/jPSvfLRU/tUmUfddu+yg==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 08/13] netlink: specs: add ethnl PHY_GET command set
Date: Fri, 26 Jan 2024 19:38:45 +0100
Message-ID: <20240126183851.2081418-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
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


