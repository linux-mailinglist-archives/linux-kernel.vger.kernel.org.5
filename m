Return-Path: <linux-kernel+bounces-144199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE18A4307
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554811F21306
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E4A5FB92;
	Sun, 14 Apr 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mdi1TAkr"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F225EE76;
	Sun, 14 Apr 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104613; cv=none; b=C0k09axxlj/O6q7+6tTiTqAxiOC3iOA4X4qXBIZunkwN5lvPb9U7umsPq3czqLsRKb0o2N72bnWoiXEYjdIIMLSy+S+ovtTFfS4KBblXWK8L3U272AdjkP180eRU7+uUbgf0ODHYMGKC+Ory9x/nHgtLOa5HKgHIo3nF7yIuhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104613; c=relaxed/simple;
	bh=9tmhkruYVtitsC0StKvNn2JIPjD86X7p6roBacjW89U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+bIImAEp+akHwRTMRfcYOY9cZHsXxZW0P0+MhpmoPmE5S6W3BrwEnYh+n8Y3jOu49lAjidUoZkCCpNNoQfQKoFml4qTg06pFv2nSEatmDZX2Pu5aO67yzx4wMxlgQkQ4h3yqOx/0lv2wfD4kQSXQCbwsajZrlZ00Qe8OF5vcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mdi1TAkr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43177C0002;
	Sun, 14 Apr 2024 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4y7H+9e3QnwTf3k9K1AAObCDWtbw3bOBO7ImZsSrfg=;
	b=Mdi1TAkrS/aF0i8bK+oQOrgcdgtmkdLyU3gSGb0oqEJ0it5A8lrjk8akFevljpCKF8nSXN
	NXGxSNjSA3ANieImu1O6Lchxx44877+Ez4KRMsyDSosG0PuX5MyQU261lvthry8DxgZu4b
	tyKtYUGmj0cip0wXwUfoefUGqTLEqbEM4colCh+Nuz6JfRJHT0ZfSobNkgfNcdeweIEL6d
	99TGgfjS5USQzKiT+W2RrpzStmHaOOHH6GxjB5VCOORqRu73XGxwe7poLWGW5XOGMrKET6
	1YurSm/HYJz/4gflQdiHeZLhiOEvI2YvHSzMLceYVX2GXJOQacgIyxVziRtDVQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:57 +0200
Subject: [PATCH net-next v8 08/17] netlink: specs: Expand the pse netlink
 command with PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-8-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add the PoE pse attributes prefix to be able to use PoE interface.

Example usage:
/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get \
             --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 4, 'dev-name': 'eth0'},
 'c33-pse-admin-state': 3,
 'c33-pse-pw-d-status': 4}

/ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set \
             --json '{"header":{"dev-name":"eth0"},
		     "c33-pse-admin-control":3}'

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Follow the "c33" PoE prefix naming change.
- Add the ethtool auto generated code.

Changes in v3:
- Remove the ethtool auto generated code.
---
 Documentation/netlink/specs/ethtool.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9a454cb924f7..00dc61358be8 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -910,6 +910,18 @@ attribute-sets:
         name: podl-pse-pw-d-status
         type: u32
         name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-state
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-control
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-d-status
+        type: u32
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1596,6 +1608,9 @@ operations:
             - podl-pse-admin-state
             - podl-pse-admin-control
             - podl-pse-pw-d-status
+            - c33-pse-admin-state
+            - c33-pse-admin-control
+            - c33-pse-pw-d-status
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.34.1


