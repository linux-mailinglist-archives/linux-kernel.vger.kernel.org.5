Return-Path: <linux-kernel+bounces-67268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3C8568E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082591F2B50D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12C1353E9;
	Thu, 15 Feb 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PBPtuDnk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE555137C44;
	Thu, 15 Feb 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013015; cv=none; b=g5WSSHgLPc88HbylAOypchNTKQqhoHRl4YtPsUeaRm+RouKKYY5sBKw9I349HB2GnevjCOTOHt7RFjGs69KG4TT4Hp8vjSXwQAFvq4SVU+WZrCmYd8q/T/54httnf2lRZBy3dpDIJ6VgDoOsvlYy6uWNfmA1zWmtZPHFj2ylk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013015; c=relaxed/simple;
	bh=3ImFGdW+UJHAE3yXEwtAAHJQUgb60OoI3CLENzmLenY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiGwkXrjAh5CrB2Kaeiwo9XICbmDL90cE+d4UmeCvjC8eAClW1Xzxrm0iGDERVTLFtpv2qIDqe7Cl+MOiwulbmhbguT+XnNuSffaXAxKPqua8mGrSrLcwr14PX4nn8CurUa1WbuKGPehknVRAPdXuncl9swKsx6Njq446L6TPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PBPtuDnk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE4A82000B;
	Thu, 15 Feb 2024 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9sYYm4EjjLiAVA/CapIhXM+uGU8uUtnAPp7gfvvbrE=;
	b=PBPtuDnkJjWzflpaYNxc6C33VuVl7YikqGIsAmVoHak0LhC4BQt8ejqa5iJCK6z/qYeWHz
	3+LLbl5uM//Tw1qlyYCEwhTMAM/oC2sdDg1XCiKkKmAGxKkvL5htY7fBO7+Ib6r9lkUH3N
	BaoHVIm401r3dPJ5u29t7XtQ59XnSQA8hyQ+QRd/Wa2Rpref0xUc3/86us/KOdqzGr7Vbf
	CtCd/T54u8Om0ft3f5spsl+gwLkzj5XaW4bNhNByIFVEbUnyViWKi1HqZqqBpkFVFJzguh
	ksbuUlLqnaFMNc6PAi7ERUmSl/+jPiqsR3JUXEGGpv8X8f3yd2TeyStEuLMudA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:49 +0100
Subject: [PATCH net-next v4 08/17] netlink: specs: Expand the pse netlink
 command with PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-8-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
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


