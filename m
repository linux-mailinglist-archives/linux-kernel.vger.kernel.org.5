Return-Path: <linux-kernel+bounces-44141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9F841DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010BE1C2389D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775656B84;
	Tue, 30 Jan 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="P/qiTMd0"
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5D5647A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603676; cv=none; b=mg/sasibiz7VnxfNg433vOhnos6rgr4keRCRIqW4yEmxi1Cn08Pce7SD4Wxj5PJIRgYxhBUicfCoxIvgI9xPnRj6S1i3+LL1ziUvV3+3OPnGuKaFPkSbwS5MTTIx7rTOc9NUvF61Q7W5Cab6Wu85aK52E8CeSuDI1uzZ+ky/Ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603676; c=relaxed/simple;
	bh=b7D0N4YKP47U9+x1vEpEBNEqcBI+X3ofjmaQzmp+nqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pn8WRviGZZ4QCxNzff2vEHgxwIOsih3MyPerNxF5UczfgjjIFAr9T6Biy9/FLXYmgTCe3auWdXdQlYwtX/Vt5qMWqP3kKS1N9gohkMW/gNUqZwAD9ZAUWTVKBdJyQgEd9I0F89MvOhjU44AopuJhbHEmINPfzAGtpdq8TolFEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=P/qiTMd0; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TPJPC2LQwzMqFgL;
	Tue, 30 Jan 2024 09:34:23 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TPJPB2D8TzDMG;
	Tue, 30 Jan 2024 09:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706603663;
	bh=b7D0N4YKP47U9+x1vEpEBNEqcBI+X3ofjmaQzmp+nqU=;
	h=From:To:Cc:Subject:Date:From;
	b=P/qiTMd0OHXoyQwMDg8Npj7xT+/KBznigjnFa3HVjXwlHQfWrVWZY2vzW+hAld8NB
	 uDEkfkhUph4/fGD8Y1msnw6r+8vTqWKts/LdoF7B8Ts7hG8QZe8B0oy/jbmlGerJlb
	 nZPzzJfWABw+rAGwEvvbvQbOFdjUcrKSWzUlb1Tk=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	stefan.portmann@impulsing.ch,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dsa: Add KSZ8567 switch support
Date: Tue, 30 Jan 2024 09:34:18 +0100
Message-Id: <20240130083419.135763-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

This commit adds the dt-binding for KSZ8567, a robust 7-port
Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
each capable of gigabit speeds, complemented by five 10/100 Mbps
MAC/PHYs.

This binding is necessary to set specific capabilities for this switch
chip that are necessary due to the ksz dsa driver only accepting
specific chip ids.
The KSZ8567 is very similar to KSZ9567 however only containing 100 Mbps
phys on its downstream ports.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v2)

Changes in v2:
- Describe in commit message why this is necessary
- Add Conor's Acked-by. Thanks!

 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index c963dc09e8e1..52acc15ebcbf 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -31,6 +31,7 @@ properties:
       - microchip,ksz9893
       - microchip,ksz9563
       - microchip,ksz8563
+      - microchip,ksz8567
 
   reset-gpios:
     description:
-- 
2.34.1


