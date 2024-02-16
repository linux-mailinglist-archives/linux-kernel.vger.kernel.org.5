Return-Path: <linux-kernel+bounces-69436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7998588F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC231F213B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AB914F9C2;
	Fri, 16 Feb 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF2kCAK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0214AD3D;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123023; cv=none; b=qZCNAml0eEAGZhDSh7h39aDYfQCfp9jQSs81WrlaQ4XcYv5Ta+AxAqArceb6OdtawjjQ9xKquzPm93fn7vofQi0myst+TvJRoDMLv17ggI+K2iv8hihUSC4vRTWdJFV/Rd+Hu1lPDIuNX/nZGHLt5jUCmoTSEYlwiKuKJP3Hpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123023; c=relaxed/simple;
	bh=4k5fPYp42gH3QLf+/maLO3ezxAAlAX85NAtYohge+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1i/VkutX1VCoNltT/7Ys0OIq6PaHrPMAQjX7YHq/OcN/f2O2D2TjBZM1ma5enH5BLdmqJG9tCh7kEZIAryfwgwcFSuJaGPO20a+ovYw5dbczfRcpNhSHuyOw6iWMYxboadlqoncYCxpgc/ro+/OzdcdMGOa/KCYg8yPwdLBH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF2kCAK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2687EC433F1;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=4k5fPYp42gH3QLf+/maLO3ezxAAlAX85NAtYohge+G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF2kCAK17YIkOIEVFXfuDmOTgCSQKQrdgE4gPj223DNcL9szLv1faH1svOXe5YpRm
	 BJBHV+XgQJx4qN5jvPv4ka25XJ1P/LohGAsnC7QirAu7rmij8bGiiPXw9Wc9sqJGbh
	 d+z0O0fKUcHvKSmazyWfzo4pv4aPrMPK0WK/rT2zSR3cYGk+jq16906w9H0IfaB9aq
	 xKbm38TwbcmzhNvDWA1HyZkqNmlDzTEddukUdUA4xohYSJUdpqgo80jRsa0dM2Cx+T
	 anaQSpFRzyLGaE1qhl6vx6SxN9Uod6WzqtUzYxbRxmcbRCxWgkvdO3TWkvU6Y6OXKk
	 iRobOSD8IaUpQ==
Received: by mercury (Postfix, from userid 1000)
	id D7E3610633F3; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 14/16] dt-bindings: vendor-prefixes: add UNI-T
Date: Fri, 16 Feb 2024 23:34:33 +0100
Message-ID: <20240216223654.1312880-15-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uni-Trend Technology is a manufacturer of measurement
and testing tools.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


