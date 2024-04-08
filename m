Return-Path: <linux-kernel+bounces-135004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0689B9DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D1282379
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C54CDEB;
	Mon,  8 Apr 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWvhSzR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2E47F7C;
	Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563810; cv=none; b=qQ+iW7H//NeU2KBtpEa0mPb4NeMDrfVPy/7lbpEXDlcUofBBM24wYz8GzSGIbpDotDw9+R4lw51oIGQqQKrenrc0qc8Dy9QymEcxwF6USg7RhRPQfvd1nlAnO8sRY45zSX5J0ahgd28OYtdhRzOkXmAU7csWWFxstdx0UlLIHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563810; c=relaxed/simple;
	bh=Zfdfmw4YgP1HV3+xyjpGmpcpKBb4YOFB7O+xev3b2rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wfg9V89VZ59UqRv+4n9+JkYRLoayyJC3/aHtjzI36si+rV+F0dnU7tIBlwBkMGh2IUZjIhKLDDUrM6Vfg8xYkP8uqRKqnhDYZC3xIay9kMJzTCJThUUxj1zxP/v/6JAO786/yv2OEdxy0CevyV+5Jk2pDbyqdXAvGw3JEH6q79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWvhSzR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA6F1C433B1;
	Mon,  8 Apr 2024 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563809;
	bh=Zfdfmw4YgP1HV3+xyjpGmpcpKBb4YOFB7O+xev3b2rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FWvhSzR1jtLLcHA2TQeU+vFcOpAxmji8gycNQrW7geWAPhehqQ4dbd0E3HXK4m+B/
	 Xm7b2eqt3ers5AsduDB7Qqb0wfBDP2usTMEtO0SdoVp+K+ssQeHCIFiaW60OqBWx2h
	 /bzDvGFa4dnPkUI+1NTgkM+bZwWXx7cX09gn3V12bxkRlYZMCSM/nTHsdBJV2jKsw1
	 VC9NJH3HwiS+dqCXsXHal8MdmUFmNvsBgkznBmkkbVL5gFpe0ZhLAsKu7q6Nz63iqR
	 FovPngUpA8QXjMI3a6YeZULL1Fs6ck3oS3hXNL94k5LYRrJTNmwRE8OKZNPYMLaozw
	 l9SxVNieMHUaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B95CD1292;
	Mon,  8 Apr 2024 08:10:09 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 08 Apr 2024 11:09:53 +0300
Subject: [PATCH 1/4] ARM: ep93xx: add regmap aux_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-ep93xx-clk-v1-1-1d0f4c324647@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
In-Reply-To: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563809; l=1936;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=fGS9fJK3awLSzWpcMoPlPiB8iiGYJR/6Q3XZJdJ0Jqw=;
 b=dCM4n39WhbzN+OZDn/lZ7Zyvi/p3PBOxPXmWeNpKw8BHEqvvTAh2HRAEX7APt8aOiq+7FXds0CUX
 hpCD4Pj+Axm7SdVfWDrsIFGPtkytOrc7+lwXusHWm1IwdRMBY/0Y
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

The following driver's should be instantiated by ep93xx syscon driver:

- reboot
- pinctrl
- clock

They all require access to DEVCFG register with a shared lock held, to
avoid conflict writing to swlocked parts of DEVCFG.

Provide common resources such as base, regmap and spinlock via auxiliary
bus framework.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/soc/cirrus/ep93xx.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..a27447971302 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -3,6 +3,18 @@
 #define _SOC_EP93XX_H
 
 struct platform_device;
+struct regmap;
+struct spinlock_t;
+
+enum ep93xx_soc_model {
+	EP93XX_9301_SOC,
+	EP93XX_9307_SOC,
+	EP93XX_9312_SOC,
+};
+
+#include <linux/auxiliary_bus.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
 
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
@@ -10,6 +22,20 @@ struct platform_device;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
+struct ep93xx_regmap_adev {
+	struct auxiliary_device adev;
+	struct regmap *map;
+	void __iomem *base;
+	spinlock_t *lock;
+	void (*write)(struct regmap *map, spinlock_t *lock, unsigned int reg,
+		      unsigned int val);
+	void (*update_bits)(struct regmap *map, spinlock_t *lock,
+			    unsigned int reg, unsigned int mask, unsigned int val);
+};
+
+#define to_ep93xx_regmap_adev(_adev) \
+	container_of((_adev), struct ep93xx_regmap_adev, adev)
+
 #ifdef CONFIG_ARCH_EP93XX
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);

-- 
2.41.0



