Return-Path: <linux-kernel+bounces-151429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD68AAEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058A7282E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55385951;
	Fri, 19 Apr 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="oUV7whNE"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414231A89;
	Fri, 19 Apr 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530721; cv=none; b=oabqgdCclQ5uevPtdH+VZ5XJ8fGQojDJ1xJX1830dO9S9I2mOkhUIGbG26a+1a2mCgWOt1cWxn0FwNzZELHRkECP7pewYDCWNMQZSotZAZTgEFsXZitc/cNJ3696nG1b2a5432VeU/4Iz96eXTTpy9I7hLjlPWPRrRI9OI0Pqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530721; c=relaxed/simple;
	bh=GLSI6vHuSNFBB34OPzNk3wEjWhkccNqqJfO1tOkQDI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzz4w5s+hNqYBStRtSBYF17uD9Dd04kZNKAKkt9ttZLPGUR0BbcmtqWhtHAQkv6ptiqrxo+znnpM41l1TIpuTuBKjxk+qmh+SXjO2A1kMFWSsEoCi2H45XCJjVR+5CK+LWpIirTnOv+ypLSXji2Ay/NkP/6sF4qoWjOJfEs/50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=oUV7whNE; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5003:0:640:89b0:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 550326126A;
	Fri, 19 Apr 2024 15:45:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8jF8ngSo6uQ0-IZwFvvke;
	Fri, 19 Apr 2024 15:45:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713530714; bh=f98sLx3wwNNPDW5Jc75hbRxEbuMeLdbQ4VYugBELXm4=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=oUV7whNEBBe6e8m3ujuX66H4sBQ1TiYG4dUPcBybKpt4vqAV49alZWfrZe44oGfu1
	 dITVJ8/lCmu6S8LtrVtfldRZIZl0woNnBexnBtdZtgsTeVcAj2NlqlRaTm54FdrqJz
	 2oNdIId3GA08Hr6UfQPfa7fduM3T9IEdUSGeGpak=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Fri, 19 Apr 2024 15:45:01 +0300
Message-Id: <20240419124506.1531035-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419124506.1531035-1-rilian.la.te@ya.ru>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
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


