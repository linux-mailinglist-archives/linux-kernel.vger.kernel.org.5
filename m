Return-Path: <linux-kernel+bounces-92500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BA87213D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61AE283055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048248663E;
	Tue,  5 Mar 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Egj83881"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82F5676A;
	Tue,  5 Mar 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648040; cv=none; b=PeSlQv040EcTOiwb8A6djtEYZiJP8Lbp0LNEVSOtxsUIVXU9ppzB8QnXpUj2qaHQ7nhaEOuzcbZtppIIeMVE/j9cXML8QZ+HR2uhe9cAPRJswFmzBQhUwWwx3I5orAgXg/rDNVL4m8aXyT/w8oR/YQLXPWWZ4jSYoIZUIX6bIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648040; c=relaxed/simple;
	bh=5+gfrIDfeHsmtIuk5iQveNTak8sf8ygvObNXuM3iFjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hrs0pXgtq/MJnaGPFYS3r5+Grik6+bM53V9NSbiieTyC7+YRMoWomVrNnzsFlD+Dfk4KFED0jbSqGJxIk7XDt0z7vDZygbh/lsz3dS3I7ipW0N+EKIOAs9/nStnXamAP0utttdADVgxrRg9DBs6GzDn48+NqJs+/VbVR0paLTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Egj83881; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68C3DE0006;
	Tue,  5 Mar 2024 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709648035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TT5bRRrgclPHRKgI0rGkJaQyK+abn1+BXSmr76+zods=;
	b=Egj83881srjpYjM+dfWciDSH7r1Nti0+wiIyO/dqJyBu7KV+5X/stI4ldk8dYzekWLWMGf
	waKZtjWMVIFc3jzh5hmAGQUE0Pw746XGIxDA0B1+iKcmmKlkBclyEV5Y/gULH+2OOUKU0S
	gt0gexb/4VapHIWJjGWJjNH+vIXKE5Fa/nI7gixbWu+Ao2aGuOM2Qgac9GjK1xaBfSc2g8
	tv/y0aTIERdE9yimv0JY2ZfD9/PwFSaBXyLB6qQslMxl01JnqNJPapsGhpLE8xHUbX7zfS
	Iai0zKrdjR+fJ6gaAgzFgMt44/oIxZLZ/DH+1cBuZWpcOgrCw9qw9fkJsLCPvQ==
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
Subject: [PATCH RESEND net-next] dt-bindings: net: dp83822: change ti,rmii-mode description
Date: Tue,  5 Mar 2024 15:13:09 +0100
Message-Id: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>
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

Resending because I previously forgot to include the "net-next" entry in 
the email subject.

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


