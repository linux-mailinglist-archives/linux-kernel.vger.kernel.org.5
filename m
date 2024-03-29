Return-Path: <linux-kernel+bounces-124315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61289159B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE3D2861AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91D3FB32;
	Fri, 29 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnZtbnqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87E1EEFD;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703855; cv=none; b=TDqsbHIt0Ru4w6mc55V1EHJrwSMx0lYlCDu7xxJ7L70hNtndTSgNawsnGhZYuj3Rej7G21ikNgkzUwxxCa1PCP6FxqGEwY+DpkB8u/lgcvRmthyomckLoJwYSMUrn3v//tLqPVm30WYdkoq5BTdEG51Aqcg6RqU5zFHbzehg0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703855; c=relaxed/simple;
	bh=KeiWUyViSXp2aUJQ+sKFwu4ZETyUyWnX0kr42ZeyL38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWuFb73jlpM362ivJSQ7lDNvKjI5bu4SD/nsOV9cks6VczNrPv1vYrjqtm7V8VjJAarhQiLHVGfnOOFHiVEDceGue5+/kjusdbDSaMIRSZNk1Y/YlHZRbBPGSK1yJaXQU67ksJOcIab4Dnykl8Vys2cZOB8IWsqDmtKxfmG6Hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnZtbnqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5440AC433C7;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703855;
	bh=KeiWUyViSXp2aUJQ+sKFwu4ZETyUyWnX0kr42ZeyL38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TnZtbnqA09sCiBcIJUyw/8K3gwEa6Wfmr1sSoc+/8PUp+t12OZ8cr4b/mHazgCEzp
	 b9WpfgWpr/yQ7bd6XOLt7U+gorybZlcJtD7HwnX59DApQRBG6U8dwlapu9WFJLmuNS
	 KlgNnQu1qossT5+UqUnuVHjtDhxKaBn3LHo3tAaSNhZSV3brkDasjRYINautAfFPVw
	 r2hqZm+zkLoMoRRM1z54DwapuzDolkoUulyiiUsduJIicY018F7zsA6msUIT7m/xtc
	 6ajRbemg7XeJXZ0DcRedOM+45wjUSEX9eRV6b66D+fwa7sWq8IDbnR5ddSi5hAJus2
	 9QqcTZI3/ngcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42779C6FD1F;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Fri, 29 Mar 2024 17:17:14 +0800
Subject: [PATCH 2/3] reset: reset-meson: add support for Amlogic T7 SoC
 Reset Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-t7-reset-v1-2-4c6e2e68359e@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
In-Reply-To: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711703853; l=1485;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=4b5hJs6BojBwxeqHYbAP2s8Gj7Cc9H0Mgr5d5A9mC30=;
 b=gqs56u0cQ7PfE8Ihc4OxU0xkuogLNMu6dXnKoh4cnJadFPaUm10p+kwp+RuMafudpRJ4EbMKV
 2LSb7zLlIKLCu3X5UMYNahpJ8jZZw0xMPlyVmw94qAc2JiT4+XBlc6H
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

There are 7 sets of Reset Source in Amlogic T7 SoC Reset Controller,
and the offset between base and level registers is 0x40.
Add a new compatible string and struct meson_reset_param to support
the reset controller on T7 SoC.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 drivers/reset/reset-meson.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index f78be97898bc..1e9fca3e30e8 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -102,6 +102,11 @@ static const struct meson_reset_param meson_s4_param = {
 	.level_offset	= 0x40,
 };
 
+static const struct meson_reset_param t7_param = {
+	.reg_count      = 7,
+	.level_offset   = 0x40,
+};
+
 static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
 	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
@@ -109,6 +114,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
 	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
 	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
+	 { .compatible = "amlogic,t7-reset",   .data = &t7_param},
 	 { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);

-- 
2.37.1



