Return-Path: <linux-kernel+bounces-38138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B14283BB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4ED1C21A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F8C171C9;
	Thu, 25 Jan 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="uVZvbgkF"
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF907171A2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170305; cv=none; b=ODEI0TxOCDXLbxKUZlWWPGmbDX1p72fWYWHL5hMuoA30jolh+ENZJ4esaMKsuFIUeTtR/OHnxnvonWkjnb/E7bBQeKrpLY1oVBp5WpDMQ86IIxzJGwqjrEHH0+dC6sgcQUQnIoJHftcjtcy6CLeCmeh+6JP6RaelKB6SaNd3/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170305; c=relaxed/simple;
	bh=Wwr/9VY0CuvcH7ywePcK0l0TShBy0NXgTb8eojUbKq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llXqT0+dBN5TXUxYonAsmSbcvGCgY9bm+wOx3e3Y/a30k5eHA9i6rCs/WtnTF4rRRr7vwX85E/PTZAqyOLsiJl8CLwE5tCMAo4UoXlMSNvWsXs2zC5eYMX65+iXRQkZ6zdgsyZ8iDdSXpcrFLnwzjkvFtjBmsH4aD01+MK6SaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=uVZvbgkF; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TLD0R2qpqzVH7;
	Thu, 25 Jan 2024 09:05:43 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TLD0P73LMzny1;
	Thu, 25 Jan 2024 09:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706169943;
	bh=Wwr/9VY0CuvcH7ywePcK0l0TShBy0NXgTb8eojUbKq0=;
	h=From:To:Cc:Subject:Date:From;
	b=uVZvbgkFPM2U+jrm09GDGJPALEzxJtSZhEup77eEx1CuQCjnL/ixkXrZyU+8t1SPU
	 WMfh3qyG5ZUBsRRj86M/x63r/atchTEeOhMyuylJdeUhK1mYqStoq9Uk3t/pXIWFwN
	 cut8XDiSo8CIE97PLUgXD8XH/ZSpgJD4mw5w+ilI=
From: Philippe Schenker <dev@pschenker.ch>
To: netdev@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	stefan.portmann@impulsing.ch,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: Add KSZ8567 switch support
Date: Thu, 25 Jan 2024 09:05:03 +0100
Message-Id: <20240125080504.62061-1-dev@pschenker.ch>
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

Changes in v2:
- Describe in commit message why this is necessary

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


