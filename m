Return-Path: <linux-kernel+bounces-150548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC48AA0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872581F21880
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5834172BC4;
	Thu, 18 Apr 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="DgFFqFEB"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F171E77;
	Thu, 18 Apr 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460341; cv=none; b=aEOJ7ka0hRhyXhgKepiYJOow2mtL0dWCT4wwwJBQz/fgHibqGUlRNAMwSamUFy7cRMQO5vPSlFg43COAx0R/cn2zP5uODKJfCKieWH9tj30APdrXGYPR2rqM4gKeAEdUon3GneD0qEf61VLD+WZjVzeuxYAmb3xvcAqsrSgbbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460341; c=relaxed/simple;
	bh=ecGG+6eR6iUO2Pn7NUZfGbmMq6Q/v6kfW7DmsPl6BmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kECqoILtuJQRW4d+ZOloLnKJtDi32xhgV0hzFEZcCy9mgk/ePnKegA3pTGetQZz8VnUQQPkQDg2Tg50ISdUoqrZkQeTPgoge9Hd0v8kfwRmmEfIbYavIw5gHdlDoRxYMcXi6HD5SzbS2FneJfO68gx/DNb9P2v2eMdJOjBu9Adg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=DgFFqFEB; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:2c01:0:640:acf3:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id D4EFD60FF1;
	Thu, 18 Apr 2024 20:06:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M6JHjm3m3Gk0-JMZhCufi;
	Thu, 18 Apr 2024 20:06:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713459989; bh=NFbssjhmyBLMOqhYAakji5yGXBVIHuEqJMJ6/5nfKYg=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DgFFqFEB1JS58Yiyxt1y7YHpq0ctgBE/wk40dFVzJiOsvP+BLJRw8CbsjGGMGkKRC
	 jLPeq2iyEVhHSlA++cqvMPmbxxeOa56Rqr7qGf4nnS7KygzhzLPg7tkk+cSblAzFN3
	 2wOqveSOg92KHOwbG2LG9LPOS2YsvS/sXmYjwdPc=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Thu, 18 Apr 2024 20:06:05 +0300
Message-Id: <20240418170610.759838-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418170610.759838-1-rilian.la.te@ya.ru>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
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
RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND and
always write in the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
breaks some hardware using these chips.

Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e1..a300eebf1401 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1458,7 +1458,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 }
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
-- 
2.34.1


