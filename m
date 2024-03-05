Return-Path: <linux-kernel+bounces-92440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB47872031
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A3E1C222B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086785C7A;
	Tue,  5 Mar 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LvHJImQB"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE285C51;
	Tue,  5 Mar 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645510; cv=none; b=XaXSYMNrdw1pyg9yGugEIBH3AzUFiXuMvkiFcEtOHgjJEIGiu71ofJ/mvExQHHYwATbImUnxFega3Me3czETqS/ruiRQQ1mo07WvYYLp/DtjpyMtl1qs8yCOkkXSpDKEYbfqy5Kbf7iy3lyUqkQ6bfCA2DZISamzC2CdqGuuQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645510; c=relaxed/simple;
	bh=znYBTbuKJHdE510kzvyLEyOv9seUryxMrJpA8/nW37w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HPbC6ZFTMKgfAo9ss0Zhrbwpmf1Q6K5sqlgoSMYf6faBQhe4bMCbY9nVDhoJ61lRmepcpmdiSq8scHl/SA752FyQuSif3yZNvFs3UCFos4V+Ibm6aIy5M5ANOOiYa0dv1Jztft4zkXL7Wb064DO4Zts2gm+P5xyYgutGpkQSCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LvHJImQB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94378C0002;
	Tue,  5 Mar 2024 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709645505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q7U+cWhleujOwN6xyJzC8kzJR7mFMa0ZCOTO3ajZttI=;
	b=LvHJImQBj1dOnQHrVx4gsvwytfe1chPKE00JMa1qWKwH9KU7x+ThgBOKsOVm1q2wPGruEB
	FXDNMLs1nLO8ijiGeXS8cA60aS9lL8VZ+LSz5nhqI2UWLHQivC5F285AakL/bFBN6dyGfs
	IA2KRcmIcsAiX4djfsas/x0QR6BKSKhUqyhNcyQGc66zNZMjXNE1N3i92qj5k6dkF99M1M
	3n0j8KPIx7h1j8zjzZMmUEYauBaclStTDmgQFar+drmWOfkFkQ2qM5W6RXxLOeGlajNLgM
	S2E1hMmzSktB2keSzRTX4/mcMJVixDA/lJIlcWG+qhvWcMr1FoQ3gkLBnudgXQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH 1/1] dt-bindings: net: dp83822: change ti,rmii-mode description
Date: Tue,  5 Mar 2024 14:31:37 +0100
Message-Id: <20240305133137.125020-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Drop reference to the 25MHz clock as it has nothing to do with connecting
the PHY and the MAC.
Add info about the reference clock direction between the PHY and the MAC
as it depends on the selected rmii mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
This patch follows on from my previous patch series [1] which has already been 
merged into the net-next tree and which added the "ti,rmii-mode" property.
As suggested by Andrew Lunn, this patch updates the description of this 
property to make it more consistent with the master/slave relationship it 
conveys.

[1] https://lore.kernel.org/all/20240222103117.526955-1-jeremie.dautheribes@bootlin.com/

 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 8f23254c0458..784866ea392b 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -84,10 +84,10 @@ properties:
     description: |
        If present, select the RMII operation mode. Two modes are
        available:
-         - RMII master, where the PHY operates from a 25MHz clock reference,
-         provided by a crystal or a CMOS-level oscillator
-         - RMII slave, where the PHY operates from a 50MHz clock reference,
-         provided by a CMOS-level oscillator
+         - RMII master, where the PHY outputs a 50MHz reference clock which can
+         be connected to the MAC.
+         - RMII slave, where the PHY expects a 50MHz reference clock input
+         shared with the MAC.
        The RMII operation mode can also be configured by its straps.
        If the strap pin is not set correctly or not set at all, then this can be
        used to configure it.
-- 
2.34.1


