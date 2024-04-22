Return-Path: <linux-kernel+bounces-153362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DF8ACD20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E0FB23793
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFED150991;
	Mon, 22 Apr 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="kp6Bi3mp"
Received: from forward205c.mail.yandex.net (forward205c.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A51146D6C;
	Mon, 22 Apr 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789846; cv=none; b=tLRkf4GQHsCCencvvnQExurWikydRNT7O+74DEf8vrW9HkxN2DZlpm9NXu/11DXKvVjOqdKXJ9z+43dfZrNQp0aR3/3T5cSXy+Nt3A0iR8h5dyHZhrVH0fB5P1bV6ZcBT59ia1teJQt8sndoubrAl4vXpCdveqQY4lCePjj3ARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789846; c=relaxed/simple;
	bh=GLSI6vHuSNFBB34OPzNk3wEjWhkccNqqJfO1tOkQDI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gnh2xCfpMOHdF3QxhsD4Dx4SizLK9wT+cYCkaCCt0VGgL8jJeTqPhTos7oTJ+JhzK5a/Mx7rCEFe2xKR62rICGi4bNSGlbyb4rUe2mhyBCSkznoUXClvOVsaW2SrcroQ2WvpjJCzvN6x60zrvPu0szx7B/dlmVpWfjaDxOPmuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=kp6Bi3mp; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
	by forward205c.mail.yandex.net (Yandex) with ESMTPS id 1860B6565A;
	Mon, 22 Apr 2024 15:38:23 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3729:0:640:85f7:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id 8AE0C60AEF;
	Mon, 22 Apr 2024 15:38:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6cIEH34oJ8c0-LdLQir2p;
	Mon, 22 Apr 2024 15:38:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713789493; bh=f98sLx3wwNNPDW5Jc75hbRxEbuMeLdbQ4VYugBELXm4=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=kp6Bi3mpARAJsT3MxZxPMoCB1e5Mt1uYCGp9evjSWpIOR0CbRzO05yJCBNKHhTrnm
	 iFJm3XdA5p5oWGc57oWv8X/XGeBPlOO3+2ElrPsKz/jMN8qJvlBuIrQMw1800OWtuK
	 fTqzA+Y+KYFTizeT8avE45TJZGi2Jb/56As7Stxs=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Mon, 22 Apr 2024 15:37:55 +0300
Message-Id: <20240422123801.2695129-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422123801.2695129-1-rilian.la.te@ya.ru>
References: <20240422123801.2695129-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
after the commit 4afeced55baa ("serial: core: fix sanitizing check for
RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
breaks some hardware using these chips.

Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
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
2.34.1


