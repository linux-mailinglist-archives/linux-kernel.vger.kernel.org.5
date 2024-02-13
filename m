Return-Path: <linux-kernel+bounces-62849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE58526CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C75F1F23135
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7177A01;
	Tue, 13 Feb 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxduPwWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EE7318B;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786239; cv=none; b=hyqGbxXflhDmn98iM/j/GGSKdhWuX7WLbSt2jXOjtz9nIqN0ZbfvOK+OVjRnA98H1tRk7tAltpr3tukIUDb4RNQCXwQ72fdk4cLzFymTOmJHlgf+lhYR5wdGMs5dG5uTaEWCU4NwaZDTDWuCEzXaLFNj9qE5aaw+Zj6r8WHdGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786239; c=relaxed/simple;
	bh=+SUYL0W4dHgMw59ZTfos6cqc8yQnbtH+XaraJUPUIeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLW4khp7lVL8CgMtGC4KYcDy2DYQETiNdoLS4wiEjlQMlRcP3vmLIeU1C9lNE5liMhkm6SkVbE/ajCF7puiGj1S+keCW+I0NxunqcWZUTNun7hhpg5hTrTsFgIiPRrEG8pO9S4+WodkAFhPUvbZEnS0vAZv7abRLJW1E/17bWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxduPwWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED8C43390;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786238;
	bh=+SUYL0W4dHgMw59ZTfos6cqc8yQnbtH+XaraJUPUIeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxduPwWCuOcpFCYFZKH9j01/7fW8c7OREAdvbK2BhkxhIFMFRXJFodhiW9l7YO26g
	 nxJTjt2t4sEGbG1MHfASp4LsRRXAvKmICQkjKEG6Bx+GlNX/1QKYysRiYLVV2fWdoM
	 4kxLT7wAZBMmODgZVQrEjOHAnebHKu0ZDPgN+jGJF0tmfEWiG+XtqVHpzVXqtW3C6l
	 X2Hlwm96r1deT9tieLGMs/OnPZKcWnn6uepc7l1syOeCPtbKYXg03+1SXwhHMXxNSX
	 +O0ivZdsaQtoLFPLuzcjZ6/2Bb+pTUWYy7JhfmVJZLHT0Au181or1hqChIyQFEWse/
	 6IBjKE2T1U8aQ==
Received: by mercury (Postfix, from userid 1000)
	id 794B4106D63E; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 16/17] dt-bindings: arm: add UNI-T UTi260b
Date: Tue, 13 Feb 2024 02:01:05 +0100
Message-ID: <20240213010347.1075251-17-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible value for i.MX6ULL based UNI-T
UTi260b thermal camera.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..7b65f9c9c1a5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -708,6 +708,7 @@ properties:
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
               - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
+              - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
           - const: fsl,imx6ull
 
       - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
-- 
2.43.0


