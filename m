Return-Path: <linux-kernel+bounces-156726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC48B075B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B671F21E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E21598ED;
	Wed, 24 Apr 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh81jwmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B21152DE1;
	Wed, 24 Apr 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954525; cv=none; b=BOdxCsGswtHU6PJj1fYzADO5MkfcCqT7RWQ0IXVtmIhOV2t76esKHNe5wHex5v8j9K4fkKrWh9O4oASbLxgRdVLuqUYSvkz0Kc5uOoVXDqQHsZJruoVVen3Gv7A2JlJVbRSU7mWOrRBOXO4cGy64zjoh09ZPfC7i4PXxOJCi+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954525; c=relaxed/simple;
	bh=GMt3bHr/0bLk2xq/2azl7lpbQ/7wyhQOM8zaZNjnyJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b80Z125T4d2+dDvgkeFNqiuLuNB2/CPvuZsCfT7azDaRjheAIKiIzjDcNxnA17pAI/LViCp8snUgoxyAVDwrDXPCbA2oa/+bFbXUBLM+fU44uHT8zjtBEb19IRlKrR9bgzkpvKOOgLORPhMfUMpj9JVRE+KIAO3DIHjLnCSm8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh81jwmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAB86C113CE;
	Wed, 24 Apr 2024 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713954525;
	bh=GMt3bHr/0bLk2xq/2azl7lpbQ/7wyhQOM8zaZNjnyJ0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Mh81jwmxMovy0OOvzxvZ3w7Y0d/WIPjl2pNSl+nmG4gIG/7DUoex6Sx+quipcrhpc
	 QlQR1lAPchfdDzH9EU/QMarHrJfjw8tt7VHxv00Yt8J1U9WVdVx3Ca7WF3T/D8ShuQ
	 zJ/dmnD8+S5P2m+214u3a0IZOOGxIVJTIQVxBJkOxvk1YM8ADZumsHd+yE1TFqRgwa
	 8YFEYL+YorFgO4FDyCsmfLa8RDVZSpyMI7mz5VPvcBmua0LjwWwXkRu/yHLcN2i2uo
	 ZB62PrwvE+EN7BGS6w1iGdXLhM9R6IhVd+ncWwruXDmdcOO4sp+ns7xpv72xgc26Wa
	 wEZjBgQAf+fpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD730C4345F;
	Wed, 24 Apr 2024 10:28:44 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v4 0/2] Add support for Amlogic S4 PWM
Date: Wed, 24 Apr 2024 18:28:33 +0800
Message-Id: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHeKGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxMDEyMT3WIT3YLyXF2jFHMDS0sLs+TE1FQloOKCotS0zAqwQdGxtbUAPQl
 xMVgAAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713954523; l=576;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=GMt3bHr/0bLk2xq/2azl7lpbQ/7wyhQOM8zaZNjnyJ0=;
 b=TJKESOCW+E486eRlzDgVjMM/9EfdVstKhuRksh8I/7CdeV2Sshl9LaATqxJ4K0X9H8NWr9d1G
 j4Gd58lMfR6D3a73YnsRiP73TFBL96sadimEK3pE0IWTOHeowhjLA4j
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic S4 PWM and related device nodes.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Junyi Zhao (2):
      pwm: meson: Add support for Amlogic S4 PWM
      arm64: dts: amlogic: Add Amlogic S4 PWM

 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
 drivers/pwm/pwm-meson.c                   |  37 ++++++
 2 files changed, 244 insertions(+)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240424-s4-pwm-2d709986caee

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



