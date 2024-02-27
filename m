Return-Path: <linux-kernel+bounces-83417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D18698CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596361C2410F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666314A090;
	Tue, 27 Feb 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kt5tQAtL"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70927145B06;
	Tue, 27 Feb 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045000; cv=none; b=a7y2G+a85/QxhhG4/ZvYsc5XU1D4S6fdPJIdV8Rtruj/fhwSdYTONqQahlZBynnUb2nbR20Bi81QPrTp7FGVDFRIde7NWvIVabzq7QBEtjuKDfEZizKYZFfLuNRao7Bjoozd4WCvqgGD38NagirF8MeE/L9dn+rTLv2UdKS7axo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045000; c=relaxed/simple;
	bh=3ImFGdW+UJHAE3yXEwtAAHJQUgb60OoI3CLENzmLenY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teyX/BiZOSD0KwfAKHRjJ6cZuXOE3v3UiZx2LKLe3jbW10aCz/IcVaWIzIdZMqVunWGXkP6tupcPw9T3pfFPz1dzskuScPvczsJB0baFot84A8WhuOFT3WyAa+f8FMiXYiKajTj99i7O2pSiQkD4lg609bZlv71B/xWmdvvBZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kt5tQAtL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7DC720015;
	Tue, 27 Feb 2024 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709044995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9sYYm4EjjLiAVA/CapIhXM+uGU8uUtnAPp7gfvvbrE=;
	b=Kt5tQAtLr6DVyVXqNlzSNiCi5Uz1A37UKwqu/KasxWXPwLi3BjWWgceVNiqqlWOfKKBZjt
	ekATW1x/wwlG3iq5gecooBXW1+50HO7V46MITNxhU/xU5x6/PsrcrVCF2RqcUGwmuWorXw
	ecaf8aq2EmSdXG8XrCLrygfBBGf7EJFYAGgnE8r1KX+nFN0m4XiZ1K88Aiuv6LI/SJE2v1
	PbAtTVDTRT4XCHjw9pQgReAUuXsJJ7SgmLeNVFjtKZdJhcG1qKPTFhJ7dc5BOZ4kTt8ptT
	bSjNuGL6e9nonJ+BHXrqJJvjxDCcPpMY2VsXjAf5EwDOgu5iGCOoUizkwS97yQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:50 +0100
Subject: [PATCH net-next v5 08/17] netlink: specs: Expand the pse netlink
 command with PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-8-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

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

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

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
index 33e81fa189ca..beaab9f0017f 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -889,6 +889,18 @@ attribute-sets:
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
@@ -1574,6 +1586,9 @@ operations:
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
2.25.1


