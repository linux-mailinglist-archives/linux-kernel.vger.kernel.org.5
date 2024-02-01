Return-Path: <linux-kernel+bounces-48464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C7845C69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A242B1C2BE9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2115DBC2;
	Thu,  1 Feb 2024 15:58:51 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652177A1A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803130; cv=none; b=SPhbGkIOKo2taFVxlwz2BiRanlYRz+eBAHJTJxXkqf+9eStMZROQlIhc/gIo0CQPT9Rjd6AJC3KtdGyFNkkAgtX2etNQYrWzGkYMM6mbXndIeLMypfRNOhzkn/AMe09FqGhI0T6Afbh8v9m40ms79n2s5KtdZVQYkHaS7upYnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803130; c=relaxed/simple;
	bh=psIvWV3hDRalSJpwlz2aPwOIlCQIQPngKO3nwLwfQhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbkXgcuxrM+kF5HaSxWNJsaPe3JRjTdB837E8weaeH4TX+/Tv9TuLKNz9AmHnH3lh0omLchpqKjWzzWKcgnt9JkGrVfhAjcx5po/UMRGXIpAJvbHKagYH2iwiezEBOmWygEX7iCHtDprlY86d162GMqXyshgpXREv/K2qv1StFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:4392:e888:3d14:1bdc])
	by xavier.telenet-ops.be with bizsmtp
	id hryk2B0042BHJxj01ryk6F; Thu, 01 Feb 2024 16:58:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZRn-00GvjW-2p;
	Thu, 01 Feb 2024 16:58:44 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZSe-00Abua-2h;
	Thu, 01 Feb 2024 16:58:44 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix {gpios-,}states limits
Date: Thu,  1 Feb 2024 16:58:41 +0100
Message-Id: <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706802756.git.geert+renesas@glider.be>
References: <cover.1706802756.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make dtbs_check:

    arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states' were unexpected)
	    from schema $id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#

The number of items in "gpios-states" must match the number of items in
"gpios", so their limits should be identical.

The number of items in "states" must lie within the range from zero up
to 2^{number of gpios}.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The second issue did not cause any dtbs_check errors?
---
 .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
index f4c1f36e52e9c3d8..1cecf8faee5dc374 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
@@ -47,6 +47,7 @@ properties:
         1: HIGH
       Default is LOW if nothing else is specified.
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
     maxItems: 8
     items:
       enum: [0, 1]
@@ -57,7 +58,8 @@ properties:
       regulator and matching GPIO configurations to achieve them. If there are
       no states in the "states" array, use a fixed regulator instead.
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-    maxItems: 8
+    minItems: 0
+    maxItems: 256
     items:
       items:
         - description: Voltage in microvolts
-- 
2.34.1


