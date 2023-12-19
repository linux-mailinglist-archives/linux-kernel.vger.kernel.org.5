Return-Path: <linux-kernel+bounces-5670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37D818DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF4A1C20D83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C7358B5;
	Tue, 19 Dec 2023 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BRM1bdus"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D136AEA;
	Tue, 19 Dec 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=vtaUMnMT8EggKRdVVV4aSCElIVRE59twHxnKq4mL2OA=; b=BRM1bdusNTuln/ySzvTXmFKOSo
	9z6XZgBwU9Xf0XVHKmHLt720y0NWn6X8yAPxzEmcMw3iA5cXwcZFsUEas5Anu7T0375scNgSSDLxS
	bzn6zxZiv4FSQ0md7r9VsTGrk2NXQasVTPfejHhytnSOi/FEh6MCtjUGnqRxgtIgWTwM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkN-0007Ao-Pj; Tue, 19 Dec 2023 12:19:12 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 19 Dec 2023 12:18:49 -0500
Message-Id: <20231219171903.3530985-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 05/18] serial: sc16is7xx: use DECLARE_BITMAP for sc16is7xx_lines bitfield
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Replace the explicit sc16is7xx_lines bitfield declaration with the generic
macro DECLARE_BITMAP() to reserve just enough memory to contain all
required bits.

This also improves code self-documentation by showing the maximum number
of bits required.

This conversion now makes sc16is7xx_lines an array, so drop the "&" before
sc16is7xx_lines in all bit access functions.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8a038a9be09e..597280a5d0f3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -346,7 +346,7 @@ struct sc16is7xx_port {
 	struct sc16is7xx_one		p[];
 };
 
-static unsigned long sc16is7xx_lines;
+static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
@@ -1534,7 +1534,7 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].port.line = find_first_zero_bit(&sc16is7xx_lines,
+		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
 							SC16IS7XX_MAX_DEVS);
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
 			ret = -ERANGE;
@@ -1585,7 +1585,7 @@ static int sc16is7xx_probe(struct device *dev,
 		if (ret)
 			goto out_ports;
 
-		set_bit(s->p[i].port.line, &sc16is7xx_lines);
+		set_bit(s->p[i].port.line, sc16is7xx_lines);
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1644,7 +1644,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 out_ports:
 	for (i = 0; i < devtype->nr_uart; i++)
-		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 
 	kthread_stop(s->kworker_task);
@@ -1672,7 +1672,7 @@ static void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
-- 
2.39.2


