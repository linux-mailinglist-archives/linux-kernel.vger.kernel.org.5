Return-Path: <linux-kernel+bounces-9165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AC81C1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB78289286
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4F7BEE7;
	Thu, 21 Dec 2023 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Z9yr0to8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA777996E;
	Thu, 21 Dec 2023 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=B8RBGDPahS1ur3p/qDWPcwo9Bjx7+cKK6Lcpi1YUSeY=; b=Z9yr0to82hgy4fEwx7xE+MyGoL
	i8W04uc9+R/QyDLpaR8MEjtRFyhgx9EHAYJzmbiv1CH3T1ENHW+BPU4orjoWJKpSWioxAvuEL6TDy
	N8fuIylfXYMeOLaa8oUm2GCCvloikxthW8IQOaWjyrPKq/zsSLh6Dr09eYszDBD8xZlo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJL-00025W-83; Thu, 21 Dec 2023 18:18:40 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 21 Dec 2023 18:18:13 -0500
Message-Id: <20231221231823.2327894-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221231823.2327894-1-hugo@hugovil.com>
References: <20231221231823.2327894-1-hugo@hugovil.com>
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
Subject: [PATCH v2 06/16] serial: sc16is7xx: use DECLARE_BITMAP for sc16is7xx_lines bitfield
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8d257208cbf3..42e1b4c70ed6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -347,7 +347,7 @@ struct sc16is7xx_port {
 	struct sc16is7xx_one		p[];
 };
 
-static unsigned long sc16is7xx_lines;
+static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
@@ -1536,7 +1536,7 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
-		s->p[i].port.line = find_first_zero_bit(&sc16is7xx_lines,
+		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
 							SC16IS7XX_MAX_DEVS);
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
 			ret = -ERANGE;
@@ -1587,7 +1587,7 @@ static int sc16is7xx_probe(struct device *dev,
 		if (ret)
 			goto out_ports;
 
-		set_bit(s->p[i].port.line, &sc16is7xx_lines);
+		set_bit(s->p[i].port.line, sc16is7xx_lines);
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1646,7 +1646,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 out_ports:
 	for (i = 0; i < devtype->nr_uart; i++)
-		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 
 	kthread_stop(s->kworker_task);
@@ -1669,7 +1669,7 @@ static void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
 			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
-- 
2.39.2


