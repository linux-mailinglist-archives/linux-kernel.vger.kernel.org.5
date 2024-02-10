Return-Path: <linux-kernel+bounces-60226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259808501A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FD51F254B5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D383987D;
	Sat, 10 Feb 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr91KvJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6E1EA73;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=rlqkVnLO2E/0vOCIV1MdH6ny6mAJk9KBp0tg8BT6mw7ijVcwvACJV0b7/X1t1rvuan+qTRw3vLYQkUUQyF6ODUXIaf7Sr6deEMGnKBt+F4SzJbvUgMroBVR4+pI1T5UAIMXr6dP0pkaZszXqHB6cE+tturv2NJc5QkMBZiUl7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=BLuAs2YLiC9203SfblvO/JENCsh2TtU04PbRwjG4Xck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw/m8Xy61KTpoaEjU/WriPFKxe9rfOzS/q6xFSC+8vWbf/M4HGABV0O8vcpwSDwgXy/YnF+pztX2qAQdLzQoFW1kQa+a+h5mbZYjyBMbruI1MHeB89Tp82KS7wpa5i9bKgiCUByOLBZhnxAeBxDekKQpKgCMH88aA1Rnu+IuovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr91KvJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5147BC43601;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=BLuAs2YLiC9203SfblvO/JENCsh2TtU04PbRwjG4Xck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mr91KvJcbEDcqSC6EjlrKX+518p7+VUHJxdYIsY60cpwX51kF8d9Kjg9ZwjteMHCO
	 SObJsZxMOzccDCEdVNH80CSGCGYkzGUYIphISfJVEdXnHiPg9yH9dGROkX94aDdS2I
	 GpwroW9Af+KO64nAsCV4s4UTjvLscz1cqai8mWzugV1MPV+HdgI416Z3M05WbfDHr4
	 o0TNZ99/bDiyVubl0W3XuUgSXuPv9eS8a0s9VRwdtZYjJ5yPaK+Q6djuJXfjqvlNvJ
	 tj/+0KeS1tLwZ2J27uXa8qfU/RWik3M6u8BAGOTW3VB/BtwjEtOVOq4atw6gchBj7e
	 fTguS+5xIAykQ==
Received: by mercury (Postfix, from userid 1000)
	id 0066910695F9; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/14] dt-bindings: vendor-prefixes: add UNI-T
Date: Sat, 10 Feb 2024 02:18:16 +0100
Message-ID: <20240210012114.489102-13-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012114.489102-1-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uni-Trend Technology is a manufacturer of measurement
and testing tools.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..e945e76696c2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1484,6 +1484,8 @@ patternProperties:
     description: Ufi Space Co., Ltd.
   "^ugoos,.*":
     description: Ugoos Industrial Co., Ltd.
+  "^uni-t,.*":
+    description: Uni-Trend Technology (China) Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.43.0


