Return-Path: <linux-kernel+bounces-5669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A19818DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C9D1C21399
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BD358BA;
	Tue, 19 Dec 2023 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="M23ZXpdK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B63714B;
	Tue, 19 Dec 2023 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=dhOqiUDo6hWsxc+Eqa46nTmCA1Ktb3a/vQZ2WSiGGX4=; b=M23ZXpdKMsedpAYQeE1rlM1NqN
	eNC/VKIIK9P391JSVFHBlDFSDlvRY8Iyaw/hiGb2GJT8n6ROJIyv15xlet510U4EKkq/hKvLuIpx7
	0yzhvZ4aLmxNQ5YoprkkXtMfX/j7LNJN8Kf1Bwl9C4+jWRrS/un1Wfen9CbIqyF6MMWk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkJ-0007Ao-AQ; Tue, 19 Dec 2023 12:19:07 -0500
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org
Date: Tue, 19 Dec 2023 12:18:45 -0500
Message-Id: <20231219171903.3530985-2-hugo@hugovil.com>
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
Subject: [PATCH 01/18] serial: sc16is7xx: fix segfault when removing driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If a problem with a device occurs during probing, and we subsequently
try to remove the driver, we get the following error:

$ rmmod sc16is7xx
[   62.783166] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
[   62.994226] Call trace:
[   62.996672]  serial_core_unregister_port+0x58/0x2b0
[   63.001558]  serial_ctrl_unregister_port+0x18/0x30
[   63.006354]  uart_remove_one_port+0x18/0x30
[   63.010542]  sc16is7xx_spi_remove+0xc0/0x190 [sc16is7xx]
Segmentation fault

Tested on a custom board with two SC16IS742 ICs, and by simulating a fault
when probing channel (port) B of the second device.

The reason is that uart_remove_one_port() has already been called during
probe in the out_ports: error path, and is called again in
sc16is7xx_remove().

Fix the problem by clearing the device drvdata in probe error path to
indicate that all resources have been deallocated. And only deallocate
resources in sc16is7xx_remove() if device drvdata is non-null.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e40e4a99277e..b585663c1e6e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1663,6 +1663,8 @@ static int sc16is7xx_probe(struct device *dev,
 out_clk:
 	clk_disable_unprepare(s->clk);
 
+	dev_set_drvdata(dev, NULL);
+
 	return ret;
 }
 
@@ -1671,6 +1673,9 @@ static void sc16is7xx_remove(struct device *dev)
 	struct sc16is7xx_port *s = dev_get_drvdata(dev);
 	int i;
 
+	if (!s)
+		return;
+
 #ifdef CONFIG_GPIOLIB
 	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
-- 
2.39.2


