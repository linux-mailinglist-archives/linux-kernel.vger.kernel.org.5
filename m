Return-Path: <linux-kernel+bounces-153266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7838ACBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E2E1F242DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19F146D76;
	Mon, 22 Apr 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0gpY5K9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DD145FE9;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784333; cv=none; b=hVIlXZyUbF958g6KWFLM9V6eJiRb/r/E2AowzBfVMeWgzPq6fxR637VDUHhKlM2O4X82aRmjJVC86PjQD2+VjZUYF4koP4Hsot7B5Qpxxf3vC1+JfnNce+vBt5mXobQDQ8eIWb9FZq4Am1xSSWp26nVDwS8BdXl6oj5u94/eBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784333; c=relaxed/simple;
	bh=60Nj6Eui0n3N0tnpm8vqfyc7ou3dQzK95LfY94ljJ2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ubE55FjP/tcHo6XjbJc+5UNe6Cx4VSy61XLjOhq43L98ygBG3RAIIW9dzZyw7JARhyFHGIGUO5U0XktnS/JIoMfljMa1NLuHe45riltGUssWiOTdKxvdw96gxDtrTuKb3A9DHoE7e17AZH3daGQW9oNY8oVQRLdE9Z9daNkUpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0gpY5K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 378ACC113CC;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713784333;
	bh=60Nj6Eui0n3N0tnpm8vqfyc7ou3dQzK95LfY94ljJ2Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=r0gpY5K9/azlRnLLLeyXFSWAylhXDnQWwb5khECKFRQFAJ0aEFEx36KIv302Zt6lk
	 925R7ZgDUiSvfFoThBPGCD134S0n8YbNtvJqr54XrqigpGTlYGn2hWLtbbpTKliG/+
	 op1CljMdeNTSkQDrucsU91bbH8xCuT802DYH0oAJO86ivAB3PdqPwL3fLbKdt1i2eV
	 J1rEmp+DW3SWUW1+TrI/isB4+NQ/d3IbcsfrJvhj3idgzoIskZNvE0FXLFBa9tJMna
	 BcdD5WbYHgXYC37Drhjb7zyRsji4+2ZLYJdU5WkV0oAkBW2XK+3T189aHoxToqbmbW
	 SPULFniiaQVOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E20C4345F;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
Date: Mon, 22 Apr 2024 19:11:42 +0800
Message-Id: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5FJmYC/23MQQ7CIBCF4as0sxZDASl15T1MF0iHdhJbDDRE0
 3B3sWuX/8vLt0PCSJjg2uwQMVOisNYQpwbcbNcJGY21QXChuBQ92zoWMeHGvOnQSKW9HR9Q76+
 Int4HdR9qz5S2ED+HnNvf+gfJLeNMOY0CtZGXHm92eYaJ3NmFBYZSyhdgXGSeogAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713784331; l=1114;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=60Nj6Eui0n3N0tnpm8vqfyc7ou3dQzK95LfY94ljJ2Q=;
 b=/gYjYSk1vpwpkjfjMUbBti+TUQEAmVkAzsRF+ybxSZczfGfjPre9hMD1+0lbyMdq48VlAUv76
 e1nzmYjH+6PBDZqJxUF9CDf4k45OZe3hoGe/2cujuahY92nBy7spKPX
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add a new compatible and device node for Amlogic T7 reset controller.
And modify the driver accordingly.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Changes in v2:
- Drop the compatible comment in dt-binding.
- Move t7-reset.h to arch/arm64/boot/dts/amlogic.
- Link to v1: https://lore.kernel.org/r/20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com

---
Zelong Dong (3):
      dt-bindings: reset: Add Amlogic T7 reset controller
      reset: reset-meson: Add support for Amlogic T7 SoC reset controller
      arm64: dts: amlogic: Add Amlogic T7 reset controller

 .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h     | 197 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   7 +
 drivers/reset/reset-meson.c                        |   6 +
 4 files changed, 211 insertions(+)
---
base-commit: f529a6d274b3b8c75899e949649d231298f30a32
change-id: 20240329-t7-reset-f87e8346fadb

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



