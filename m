Return-Path: <linux-kernel+bounces-148695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2B8A864D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A67D1C21497
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B01448C4;
	Wed, 17 Apr 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MffpTKwm"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A381411CE;
	Wed, 17 Apr 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364877; cv=none; b=ot1uNLzarv/1RQmLSgF1EA7U0TwEWrk6mN/K1yHLdgWfYat+PuYxZ/zjtwwKJfUgO/6f9BcNR3UiY8LZsFRt3SiuPisi1C4CgiR3kdYxkbJciObgUGiupn2gMETJhLLrdBlDOsqzhQyTv9arerSdb2eeN9smdmRmX0fcm+sNQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364877; c=relaxed/simple;
	bh=9tmhkruYVtitsC0StKvNn2JIPjD86X7p6roBacjW89U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsEsNG5P6ZwrpdCHxy4mEkfjzMn0PUmBtB0zIUhEbEw7eDSy0cqwKV9ETzNQbSAuAO6/Hcy+fIPC5OhH0y+VTNlotkyLLpifP6KlQDwy9d5IpckWHNdZHqC3iHY0fTDSAgIYpSZCYWGabRLwXoG5/UO4BjSS2XGxGoH5jxwp3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MffpTKwm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAC851BF21A;
	Wed, 17 Apr 2024 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4y7H+9e3QnwTf3k9K1AAObCDWtbw3bOBO7ImZsSrfg=;
	b=MffpTKwmeP0oqOJsJAPWohGcchB+CggnjfYX1SjfiDLkCJjfmU9mdX9BTq2ccaE2PBCwbd
	IJvA/0fuME9uIz2K4ZQGF8X16GSfZOhWjudbBJJSKr2LYJlTh/LgggqseNO5rwXEl8QJaS
	zS+OEWfY6azt87+503ZkjxJFTcggzOwmRj77PvkJ/66pTGUoVKk2k0kulFiW59qTGOhSH8
	RdqOheLkj8QQmB20787Y9pVuXV6ppBGr9rwo7U5LAhFuQuuo0xNt9fSdndtgQSDA2wocL/
	UfjQzdly2XE9/jaJrpgeF99q9r3tukuMCSKx76OtotbsC8wY+UzeQwbKN56C0Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 17 Apr 2024 16:39:53 +0200
Subject: [PATCH net-next v9 05/14] netlink: specs: Expand the pse netlink
 command with PoE interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-feature_poe-v9-5-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
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


