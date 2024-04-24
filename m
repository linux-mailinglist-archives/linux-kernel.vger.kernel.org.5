Return-Path: <linux-kernel+bounces-157602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5488B1370
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF325284A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5678C93;
	Wed, 24 Apr 2024 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="baWM8vAt"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F6745D9;
	Wed, 24 Apr 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986372; cv=none; b=cPfXgjO74TE+oFrvxSjnTCA4Fl/JW0dWE2xhCXFZIvVKUPSw2nugSdMex848uznA2KmFvoZUg+LdG1P+QneEy5cwBn7Q5oLURLAGWU50gxeg0nuKHzJQ7P1lONF2TCkEkq8lkrpFxG6f4OBKw7/W2dwII+8HT07WLYFbza9V3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986372; c=relaxed/simple;
	bh=CHH7TL/5RLahwBG0WvRUPQJrqDTWKGexNu7vMZIs6UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go1Wk3LA5tnCvsvmL6BAY6ZzgDxCPQ1hSicXqxoz/iHuzJoIWcQMLGGVy7n80NdFZUMZiH8kUG87UGug3PeQNSBWPtLeBCpYQWZ1q0H9jRIsNQ/qpopXaRRx7MYVQ3wdOwB81elNtgtJOaOihcC61WslnFmshQYY4R3q6WPkk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=baWM8vAt; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332e:0:640:784d:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id CD82C60A6A;
	Wed, 24 Apr 2024 22:19:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IJRtcgXMoCg0-w9WlDAHt;
	Wed, 24 Apr 2024 22:19:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713986363; bh=f8EnQH1L/dXaphsBpNH1E4suYCwQaxstBt1xwrlcsu4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=baWM8vAtYLNcQzEm1HzE78kwWCEgch8k+UJjazC/lMgZ991cFtfbW11eIenI7/dHz
	 NDDV82LP4eTm7hnPnbCqPK3WbYQW4mJadb5cdK+t36l6luvSA06Ztg0wGY8DyhTJrD
	 lg0Oexn1BcIJWU+oZJGnag2ctBBsI7nCiEpNAWtk=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
	Konstantin Pugin <ria.freelander@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v8 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Wed, 24 Apr 2024 22:18:52 +0300
Message-ID: <20240424191908.32565-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424191908.32565-1-rilian.la.te@ya.ru>
References: <20240424191908.32565-1-rilian.la.te@ya.ru>
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


