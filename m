Return-Path: <linux-kernel+bounces-15389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99683822B51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA35B22F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970018EB1;
	Wed,  3 Jan 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/2JdAg8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38518B08;
	Wed,  3 Jan 2024 10:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20162C433C9;
	Wed,  3 Jan 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277595;
	bh=BjFdMMXze1pGXCEQZ4TAZ3lfzx5oNEM9IyQG06g4aNw=;
	h=From:To:Cc:Subject:Date:From;
	b=b/2JdAg8WqBQCQQ1oDn7RhkRMmyVpfhAx2bFcr1Bfeuefz4ZzDCRM8po+DTRwygkp
	 rxd5RXNr0oG3LVFOUR5rG4j5a7qEciNHy/qJPQ3c0sX8iTMeSaEaUYM5wmrFf4OfeJ
	 UdK5NirPoG9Ysf9fp/gfEytjZXQQWK1UfFmQoIfkXJ029i6eJ57LPbS5HqYMhvirK5
	 wCzpRH+c9JSUnZnq4I88LgEmQB+8eYFZtwd+5MWmsTCTjPiEZOzhokghS4uZwHiOtF
	 p4I7oG9vDjbDb2RsualTWHAihakHc2h3Yb2BAM6knyxE9nFCTQXaufS97GgDI/yXsx
	 Pw8EIVYrSEWBA==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] r8169: fix building with CONFIG_LEDS_CLASS=m
Date: Wed,  3 Jan 2024 11:26:25 +0100
Message-Id: <20240103102630.3770242-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When r8169 is built-in but the LED support is a loadable module, the
new code to drive the LED now causes a link failure:

ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'

Add a Kconfig dependency to prevent the broken configuration but still
allow having the network code built-in as long as CONFIG_LEDS_TRIGGER_NETDEV
is disabled, regardless of CONFIG_LEDS_CLASS.

Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/realtek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 93d9df55b361..fd3f18b328de 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -98,6 +98,7 @@ config 8139_OLD_RX_RESET
 config R8169
 	tristate "Realtek 8169/8168/8101/8125 ethernet support"
 	depends on PCI
+	depends on LEDS_CLASS || !LEDS_TRIGGER_NETDEV
 	select FW_LOADER
 	select CRC32
 	select PHYLIB
-- 
2.39.2


