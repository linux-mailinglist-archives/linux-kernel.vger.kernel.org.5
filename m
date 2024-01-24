Return-Path: <linux-kernel+bounces-37564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7E83B1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011481C21394
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF88131E41;
	Wed, 24 Jan 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvuTAwEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68177F3E;
	Wed, 24 Jan 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122880; cv=none; b=c9xuYH0JRfegFXjx/b9v886R6LVbsxvF9DR5E+PTF0NDCilxATwL2bt+v0prHhZqpyPAYGX2kU7f/Q/EahgO+H6o68C97zcdFQSv71kWZIWhh+797cwrIyApMrCTVoaMLM0gV6Dk7eHI4fa4fwY3/GnXdAHJHIc/CGHfWKdsLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122880; c=relaxed/simple;
	bh=tOgsZRXU9rRQFmddKn9J6mSGDO3A5r9Xtx6Ag8uTw0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ll506vSA3H/FJF9xkBInBxZwejPJRO2R4OwaBomksr35+uNS2qy3Hk+EWqRpPz1kBBbPxT3bpEn2iwcayj9yX0I3MnklVT/CTxSamgWrTAbwV2MO3STHbHjUTyF0IcbjlW+jnkkc6b3qxTO21f302RdQHcE+KKdjw5VA4tkyMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvuTAwEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA974C433F1;
	Wed, 24 Jan 2024 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706122880;
	bh=tOgsZRXU9rRQFmddKn9J6mSGDO3A5r9Xtx6Ag8uTw0U=;
	h=From:To:Cc:Subject:Date:From;
	b=GvuTAwEwBlmIaZvxxby4E//caeJa+m9jb6A6jf1IR/4Qrdij11PglW5ZLz94g9aqM
	 rwtcZYQSCvb78UR2KaycjDifkQwqeQBQlCAf1VKvbVCUp0a42xmub369OdjfdAdXkO
	 trn43tCZBE/BYImrD58p+LtIthpbyovHXb5oVF4pzGYPIua+tHZvszUfNnnwAslW2j
	 Ykh26hHQG0hYValJobzSo1U+biPNI6GR9ygDNKf2rlyMpWXQARLd5WhwDf/lIOyAbC
	 tmCIvhQgvQ05qDaypf5VWeZ+rq+b3dy7V2tuHl+haIAje9RW4+6TAtzXJW+bQ7RQH3
	 Ir6J0QvybvE/Q==
From: Rob Herring <robh@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: Unify "input-debounce" schema
Date: Wed, 24 Jan 2024 13:01:04 -0600
Message-ID: <20240124190106.1540585-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nuvoton,npcm845-pinctrl defines the common "input-debounce" property as
an array rather than an scalar. Update the common definition to expand
it to an uint32-array, and update all the users of the property with
array constraints.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml   | 3 ++-
 .../devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml   | 1 -
 .../devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml   | 3 ++-
 Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index bb61a30321a1..482acda88e73 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -93,7 +93,8 @@ properties:
 
           input-schmitt-disable: true
 
-          input-debounce: true
+          input-debounce:
+            maxItems: 1
 
           output-low: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
index 3e8472898800..20cf0102aa63 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -152,7 +152,6 @@ patternProperties:
         description:
           Debouncing periods in microseconds, one period per interrupt
           bank found in the controller
-        $ref: /schemas/types.yaml#/definitions/uint32-array
         minItems: 1
         maxItems: 4
 
diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
index 7b7f840ffc4c..08442c880f07 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
@@ -103,7 +103,8 @@ patternProperties:
         items:
           pattern: "^gpio1?[0-9]{1,2}$"
 
-      input-debounce: true
+      input-debounce:
+        maxItems: 1
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
index be81ed22a036..d0af21a564b4 100644
--- a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
@@ -97,7 +97,7 @@ properties:
     description: disable schmitt-trigger mode
 
   input-debounce:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     description: Takes the debounce time in usec as argument or 0 to disable
       debouncing
 
-- 
2.43.0


