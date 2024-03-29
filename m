Return-Path: <linux-kernel+bounces-124317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C289159C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBB81C22AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE733FB3C;
	Fri, 29 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ3y7ki+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BE39FD1;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703855; cv=none; b=ftgU+riw/CFSS5uZututxGHmg91zMN3ABdql5OaP8+G4CY9CFybr8WHUXFzJIxXhhwYRBaYlBjJVTWKwre6r3cVZ5UM1qedYuY1OdLjPwjIJTR6Cuhc4gfFFNjyerP13xVDTNJ0sOxgDA+n/KxWotndSctlIObcZMsEyvKu6Xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703855; c=relaxed/simple;
	bh=n/GJizp9nm7qN6fx85RRF4G4vfz5pWZJJrrOuOIEosg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=APn5Oq+c9FIQ6jIzukIwsyYXS6cPOtXniDjOsd6m7C9iAdYNDzRwnTgknm5CWDm8vxC+En9SlVzzcFgoC+nativzITcSO/vinfJMHXtda70gDeoRfo8gKH4tJ4igWY2ddhJd5g68uS9fl1LCjRHPI1bH55R3CEdxCNNTFtOu4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ3y7ki+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35670C433F1;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703855;
	bh=n/GJizp9nm7qN6fx85RRF4G4vfz5pWZJJrrOuOIEosg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eJ3y7ki+MaVUSZJhPrwMD8Je0tVbXfWz0LDEfN2I3oRJm8zZxmV4F47yFPx37jHwy
	 +xYDGX6BVWwtQ1805osK9E4am/m/B+t86/zo2ejv7JLMRujMucFvk7uQnfksys8sa0
	 w67YcoVt96rWkLbOh2HbN8TPYiXiwgjvgOugw0oqwSUf3yPa/bgaDd06qXW943FbgJ
	 ySyz9g3dfu8ViepGEiwFQRrb6AxiEbmDCK+5BEZIx+0utHuY9SIVTwDa/1ZfVTFaC9
	 ea7DvDCTeYZ250tn/k4kLPdWjD9JBuDMnVbgd5PPLQEunHLFochH0xz9CR7OlTxT/K
	 OrJbRqkHJ5XUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF66CD11DD;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Add support for Amlogic T7 Reset
Date: Fri, 29 Mar 2024 17:17:12 +0800
Message-Id: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiHBmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNL3RJz3aLU4tQS3TQL81QLYxOztMSUJCWg8oKi1LTMCrBR0bG1tQB
 080UQWgAAAA==
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711703853; l=866;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=n/GJizp9nm7qN6fx85RRF4G4vfz5pWZJJrrOuOIEosg=;
 b=2HDdcu8bHK28/Vw6Upe0zpsGUXqXEi9POhJTjRSNSmOBU3TqML/IbpwEUaPrQTa6cUJL5+rk5
 +Z9Y3JC24v2CfMsbzDGndOgSjtVeZCAMsQG6uX4CC8Pxmf6XUIMMBaA
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add a new compatible and device node for Amlogic T7 Reset.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Zelong Dong (3):
      dt-bindings: reset: Add Amlogic T7 Reset Controller
      reset: reset-meson: add support for Amlogic T7 SoC Reset Controller
      arm64: dts: amlogic: add reset controller for Amlogic T7 SoC

 .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   7 +
 drivers/reset/reset-meson.c                        |   6 +
 include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
 4 files changed, 211 insertions(+)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240329-t7-reset-f87e8346fadb

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



