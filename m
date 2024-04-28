Return-Path: <linux-kernel+bounces-161459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6878B4C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CD7B215E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A56EB7A;
	Sun, 28 Apr 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="ER6fEmJl"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2334CDE;
	Sun, 28 Apr 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315577; cv=none; b=t7/a0XdYh2oQ2sy2bo4hHKPd5yBNN7cfWR14PNuur2VGNhasXvsCTrhrs+c/Ll/XC7trlvmiCU7MmR7+6Z1KzNYa8jo/Pnf/edFHH6JiOxSrWakFRPP4cUS4fLTHTiO42wB0f/QpNFo7G4UTFhsEhG3oEHxLVTwn4UgBJbTVp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315577; c=relaxed/simple;
	bh=O9lYynF7TbwV25WJ4FbULB8m/hH0HLsZXryml5NonVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzy139plk0W8vg5Rz6OezrX4cRTzsiILkUNsGp53i0qEGm/Cfa0YVrwgVr+IP6i1iTiTqbAw3QGqy4e96ot7G63recBJIeTQ6PwWg+6kJQZomxot8wKLc6X5ppeza936CeKUdrIrnp/pURjAWrkmgvvyZD4Z30qEhbPLiqni4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=ER6fEmJl; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:41f:0:640:22c7:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 687D260D74;
	Sun, 28 Apr 2024 17:46:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tjQeFr9Sga60-st7Y47if;
	Sun, 28 Apr 2024 17:46:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1714315563; bh=67waao3F0EHQeKvBPxYU8iF726Np7zyvUcDDCjQruTU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ER6fEmJl9riDd/aCADkQC/2hHjyJZrwSoFGW6fLBb6P58c2G7ksYlQCrelZegDA5+
	 8nOTUH3eh88RHmxA5Lud8egBcNwvoWplczaRRJAJ2qGFxAldA8cVVxp/0SPYgMEOhI
	 UVFL2Ew0oVhxyTomS3flRk9Exn/DA9OgB8x09rYI=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	linux-stable@vger.kernel.org,
	Konstantin Pugin <ria.freelander@gmail.com>,
	stable@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/1] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Sun, 28 Apr 2024 17:45:33 +0300
Message-ID: <20240428144541.80812-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428144541.80812-1-rilian.la.te@ya.ru>
References: <20240428144541.80812-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
we get the following warning after commit 4afeced55baa ("serial: core:
fix sanitizing check for RTS settings"):

    invalid RTS setting, using RTS_AFTER_SEND instead

This results in SER_RS485_RTS_AFTER_SEND being set and the
driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT,
which breaks some hardware using these chips.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
this by announcing support for RTS_ON_SEND.

Cc: stable@vger.kernel.org
Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 03cf30e20b75..dfcc804f558f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1449,7 +1449,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 }
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
-- 
2.44.0


