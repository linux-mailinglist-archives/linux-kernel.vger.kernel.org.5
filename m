Return-Path: <linux-kernel+bounces-152348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1CD8ABCBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B56281611
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB6262A3;
	Sat, 20 Apr 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="IWaDOOHC"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F6205E21;
	Sat, 20 Apr 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637815; cv=none; b=lSEf0V02BKPqEYG34SjZpBgQoWIkuc0Np+2otSocUk5hUegPdRB26NvAR2j4hgdtpW+oK8qOuy2IE62YAy6+IOUWfsqrxd1Qo1VWln/jjUB0s6iBHabsF8JLzqWflj6bBObc6TxupuQI4Xxp0xOq/gRu/XBlWqiZobspTJtyWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637815; c=relaxed/simple;
	bh=2UXI3UXWMSWsL179RrU0ZdHh+vbCoIwL2H48tpPpyl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIh8pVaq9yAizVrWDfLttAqLt+TrcOZQpm+fF3yeLzrEzpmGyx/Xb7aaMDib+VFEAixS7ivR/vRIWdAhfhfc+UcostYNo5U+v1Rkj08J1brZZ9wBsVS4qhThekaOyt1rg5Or9Ade+G6GG3a6e/9PKLR1nqmkyTSDI08C2v/biMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=IWaDOOHC; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:60f:0:640:4965:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id B9BE960E3A;
	Sat, 20 Apr 2024 21:22:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WMMqk3Bj1a60-d1S7r0UY;
	Sat, 20 Apr 2024 21:22:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713637358; bh=4x8tZZTNgOQZNbj0h41gdyn8MEMRqZ5heVzJElKdGdg=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=IWaDOOHCUj+Xcx09SlxmdtNzwLuObjR0k//8+cd7X3vwQk7UI/s5tQxk907heU8Ip
	 66Pm+TMuNN4w6pBg7YZ9GJATcXJoeJoZpOyUNvVgW4CBA6R6UVg0TxbOgvtaFd1n86
	 IDUyL1GAiBF8kd3rXL6NwfUF67cxty5jZ/TnG4sQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
Subject: [PATCH v5 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Sat, 20 Apr 2024 21:22:04 +0300
Message-ID: <20240420182223.1153195-2-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420182223.1153195-1-rilian.la.te@ya.ru>
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
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
2.44.0


