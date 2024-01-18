Return-Path: <linux-kernel+bounces-29849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3183147C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7121C23B30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C711F946;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KupzRSKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF5C126
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=UJOIwaX2G1UpduoS11o2fw/EtXFtA6yKwCjnDmO8GYOz1IW5dpJ2p3FVY7bInqBE2G2RcLJcktIzScXFSLzung4Q4+HRRWEAmfC2ZULJxIPkj/iwaZ768Lb8xQ9D/TOOKRHQSQr973hPkHpC6H7MSAbnZCAkT3EMgXJW+Lz8F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=rdeMJ54UDpLRwou5AAi1qhJ+l2f3fkTzSdFE/M1TJBw=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=sgMRx0QP5gpfkq36qiVxaH0bwlgfehYvX7+TDZV0z+H8n6qFnpjc7z8WBI6GyCijWLwR6e+k814UxyqpyY45jGJXLDU/KUiL6rV5rDE4gZil0VfprSDamGQMHv2WMlMPKGkpv5vbRkIE7xl9yOEBbuw6P7cqM3tkaDqOWvT9CBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KupzRSKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA6DC43394;
	Thu, 18 Jan 2024 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566178;
	bh=rdeMJ54UDpLRwou5AAi1qhJ+l2f3fkTzSdFE/M1TJBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KupzRSKwfCCtWTBu6otka3WpGqV6YM9bqsCsvpqlseCpByGglp1mtCSrH0lgtuUCb
	 xvaeG5WwWxIf1fAnsxXQ8bLwLvzMwVbTJmflrIECe8Ojz0VqbUl8Aw62n5JBJZArye
	 llQ3vQnECkFQrEoZqQgDGf6c6L4RxixyPA2Ewwbqh29kSecv/qgoeUMh2Tl+H/otkN
	 OpqnBsKtfTTwx4O+YHUqgYvhNwXkaSgXWjDFUZNvVGKyuIlhoYifZuRvF5BMLN/gL3
	 QevyO2T6/Z+RRbt4FyN2pSL0HeuRavIOZTlT1xL03BNg5MPbCGhJK3HaXVegZ5Qlpt
	 qsnQ4FoCLl11A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92569C47DA2;
	Thu, 18 Jan 2024 08:22:58 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:44 +0300
Subject: [PATCH v7 01/39] ARM: ep93xx: Add terminator to gpiod_lookup_table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "Wu, Aaron" <Aaron.Wu@analog.com>, 
 Olof Johansson <olof@lixom.net>, Lee Jones <lee@kernel.org>, 
 Ralf Baechle <ralf@linux-mips.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=863;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=V19ji6HRT/LvwSZh25S7DqwrqE2geyei6CamYGzg/Hc=; =?utf-8?q?b=3DYR1wB031b++R?=
 =?utf-8?q?wryG4mHPVamzIXC2oyPM3Zu9KFhD3ooTRX5FUQNHjBLVAwtpkLRZM/E0zEh7uKZE?=
 +8poBxUwCRq+UbGwKikH2jXXdCCQCO/FeFkZ/Bt3+BH9FmY0cNWn
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Without the terminator, if a con_id is passed to gpio_find() that
does not exist in the lookup table the function will not stop looping
correctly, and eventually cause an oops.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 71b113976420..8b1ec60a9a46 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -339,6 +339,7 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 

-- 
2.41.0


