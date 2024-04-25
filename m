Return-Path: <linux-kernel+bounces-159020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE538B2837
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510B31F21451
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB211509A0;
	Thu, 25 Apr 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="hjKMngfb"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171A2135A;
	Thu, 25 Apr 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070053; cv=none; b=N9KYVLPJIJR3m6Ba0klMuL/sPo6G+h0joxAaUjuV0JqpjnMRRrfHyC/btHqSMmIj6Un4zHxpK4ZrPD09zdX8GgD2UMmGqqCcByczqq49ez7UVcwQ3HcWOUHOIgVfLUAcIsxcJOI+wGzRgR9pV3ap7p6F6sfFHXnqYy908K/mczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070053; c=relaxed/simple;
	bh=CHH7TL/5RLahwBG0WvRUPQJrqDTWKGexNu7vMZIs6UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNDO61iZ4pz4TSp5kbBf4Oyhx1VSuhqJutVhDX7qvdlh/bLI8xsAoDLaGKiHSrUU7+PSYT8qZBJgiQE7PQffxEiRm8Ki/3GDenv+QDu065052GyVZeMkBLPReRBobNHqHpvnsj6uAyOayAeFfgRJ7DhNGE7EWQIaDjKiN5gC954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=hjKMngfb; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5408:0:640:72fa:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 9D934617B6;
	Thu, 25 Apr 2024 21:34:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sXRDEK0m5mI0-1Wsnuhd6;
	Thu, 25 Apr 2024 21:34:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1714070041; bh=f8EnQH1L/dXaphsBpNH1E4suYCwQaxstBt1xwrlcsu4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hjKMngfbl3H7Jy2/J9dhoCzfO0KjS0xBQJI9hLytiDw2aGFGXzWSJeeBseTYSIM6a
	 t5zL3rxo+zMzQLD7fvd03n88zfgwoZ+LCFD8RRKlaby/C5iIY9vMVF+jrn46Re1/v6
	 jx31L6krcwuQ+hMd1Oi++ERGqHhI2l7Ofnj2IeiA=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
Subject: [PATCH v9 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Thu, 25 Apr 2024 21:32:33 +0300
Message-ID: <20240425183251.174412-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425183251.174412-1-rilian.la.te@ya.ru>
References: <20240425183251.174412-1-rilian.la.te@ya.ru>
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


