Return-Path: <linux-kernel+bounces-76337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3685F5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B4028649E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900A3FB35;
	Thu, 22 Feb 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y4WfRmy9"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A01E53A;
	Thu, 22 Feb 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597889; cv=none; b=jvlomQVbJzZwxpwMwP5/BKNSHWP/0PXFtkVmrg9AoLelEgU4mKkTNroU66iQSIPO07Dr9ZC9q/SgOqTnpFpS/ARFpNoKjT+pK+/u28UKYMLgtwdOZuaBn6yFAR6Y2eX/yz1eEWa6bIUGXQcTZKwuDIpXljyPK6f3XSdGyMHgGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597889; c=relaxed/simple;
	bh=Z8S1pm3sZXOEcha/HzGW8TfXPCgUETag5hRGfbJIfdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaC+YB8r0bOz4BDi6oEnIRErUCh2i9/pbb4kMuDYpTmMrHXDhRCuOB7EQSK3thDZauvjg9AdZdyhEaU7XVpxlIcUhiMWsoXzmGDeHN9MJ7yMShJHihgXenb5RyLnmEMhtwdvkEGwzshvT0n0o+lXBHV4nJXiaKwOHE+QKqx/zVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y4WfRmy9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C12BFF816;
	Thu, 22 Feb 2024 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708597886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ0cUDvYq4R1bU50dHJq2WkbKtaTugSYh0eL5IQfQUI=;
	b=Y4WfRmy9vBrtrQp2BWz0JcEKr4TgGLE8PZOZ9WcbX+h0FH+mND7t6Ab528pxfQx5M9zXfP
	PV+dqhWBuU6VzUo0E5NH4Dea3Itz47NNig+6jnL0a+FONsJmLh7JKjXrr9jZaSfZ/ouLgH
	MDLzfmOJzceQgG/hdXVVReh6pUuSrxK77hVeLtsJFN/2NGLJIMmeeV1oByhcupb3jGifQB
	ZW9MuEmJEBMF/HrbDBM85PN4vVSZWxigX2dLUTgrGkHUbOEea4+mPBYIUqdeZ5e9RGMNo6
	sFCGh1YNNwOZUEwaytp/p/g2TOfgXb8R3hBxz5qIo+vPooqqgB/2Nts/HW24Kw==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH net-next 1/3] dt-bindings: net: dp83822: support configuring RMII master/slave mode
Date: Thu, 22 Feb 2024 11:31:15 +0100
Message-Id: <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Add property ti,rmii-mode to support selecting the RMII operation mode
between:
	- master mode (PHY operates from a 25MHz clock reference)
	- slave mode (PHY operates from a 50MHz clock reference)

If not set, the operation mode is configured by hardware straps.

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 .../devicetree/bindings/net/ti,dp83822.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 8f4350be689c..8f23254c0458 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -80,6 +80,22 @@ properties:
            10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
     default: 10000
 
+  ti,rmii-mode:
+    description: |
+       If present, select the RMII operation mode. Two modes are
+       available:
+         - RMII master, where the PHY operates from a 25MHz clock reference,
+         provided by a crystal or a CMOS-level oscillator
+         - RMII slave, where the PHY operates from a 50MHz clock reference,
+         provided by a CMOS-level oscillator
+       The RMII operation mode can also be configured by its straps.
+       If the strap pin is not set correctly or not set at all, then this can be
+       used to configure it.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - master
+      - slave
+
 required:
   - reg
 
-- 
2.34.1


