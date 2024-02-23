Return-Path: <linux-kernel+bounces-78714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A758617C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C2FB2A410
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566012A153;
	Fri, 23 Feb 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaLfWowF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E90128830;
	Fri, 23 Feb 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705299; cv=none; b=PA+bTBeqd1nW5uwO1kyFjEmYj3y+c2LtX3n7GMMFbOE3uT52sbM8C5+3f8LSu5aGUoMArdG/ecDEIjpphPWgvOjDANMN53Jr76CerCDYaaTAh2799XdF9ai9ldGpMPA4a51w9HHxgz4MtglFN4cyZ/j3ZpEmaAssDmulHpuQB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705299; c=relaxed/simple;
	bh=e35n+V+KJ6GOR5w3FZqinp9ivKeGJSYSJSqC9t8Lvbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBBC0UmFpGpKiIp1jx9WUFL/gKkTx+JGTKRRUXZaNXoDcaS8e5ij6iEoT0IPQgnedCrszicqMJKKEdXBNhZfmQ8/kgbP14ffOFGIpn8ObaEF4l4p//k2kEJdDVDgFDrVUlud/hqoxQjtAM/6XBiISkN/9IhBkPvo1TztNynDTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaLfWowF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D52C433C7;
	Fri, 23 Feb 2024 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705298;
	bh=e35n+V+KJ6GOR5w3FZqinp9ivKeGJSYSJSqC9t8Lvbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaLfWowFUAZvfg7KCh0JXisHPeSYqM338HrkS/XYrcIY13yKcumLHFAfQKBVQsnB2
	 YPFKTRgIgWHlu6eq5OFROubL95AnmGfyu5Hb6B78a66rf+iTP4p2CJl2XuNMvUqSrj
	 Nvd09NUwaRyqKBhHdkIAzevtwLNlpDObHLAAR/zISzGvC4v6gJr+J2plrob+qBgxyj
	 KU7HcZehOV1EaNm0ylEiFRYV6conFlj5EoF0EnOfvj5zrvDLud/lqulqGuv4PYU6tY
	 ZP/sd4PBvK4WjiyKTnOIq/2y8f2wTz8NaMvPnjNHj493GVG7gJN5jLpx0bW5rjuQrG
	 khkUHdC0yHrag==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: hwmon/pmbus: ti,lm25066: document regulators
Date: Fri, 23 Feb 2024 16:21:05 +0000
Message-ID: <20240223-tingling-mutt-dd55dd87ff5e@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=joH1ld+xUmYlj/ECTPEZz+fzAg0PtsSN+LgfoDkIwW0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jn7nWd7eUn3owuY+e62Kdzs6XDeGFlgv7fjd/JRl2 QMBwXvWHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIliYjw+fgLx1Pbl/g+/hp iZ55w3L3GJXmVZH3HH1qvTamVt68fo/hn8l3qZ6exAnP7pzveydiz9z4bqVtqMNqvUo+R0YjvWW 2/AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

All devices documented in the lm25066 binding are intended for use with
a regulator, be that for purely monitoring purposes (lm25056) or, for
the other devices, as the controller of that regulator. The binding does
not currently allow regulator child nodes, so add one.

Each of these devices interacts with only a single regulator and
documentation refers to it as "Vout", hence the choice of child node
name.

Acked-by: Zev Weiss <zev@bewilderbeest.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
index da8292bc32f5..4373e9c86e54 100644
--- a/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
@@ -34,6 +34,18 @@ properties:
       Shunt (sense) resistor value in micro-Ohms
     default: 1000
 
+  regulators:
+    type: object
+
+    properties:
+      vout:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.43.0


