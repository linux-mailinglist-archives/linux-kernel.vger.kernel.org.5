Return-Path: <linux-kernel+bounces-125562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA08928BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0702D1C21133
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42617F7;
	Sat, 30 Mar 2024 01:18:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AED7E8;
	Sat, 30 Mar 2024 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711761512; cv=none; b=LKFD53QKYbmG0aAt16EOuvLyvNzmoBNJLuXhTp9N5pu4+OBJd78A2pSkjjxGsz+X27NhIC85zFrDIeB4IrpAJvsbhy8nrR14HFTdkdOTrkbXnlp5kHaCPta7V2kjSmYz7DGeOLh1dBaM4aE4980Wf6lnsEulkpFEVFlOvhLt89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711761512; c=relaxed/simple;
	bh=ZxhyUR/BsO+88hhZ0WPOqi7RMpOM0Seq4GE1dJ6FiFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+aCxp4xrGT1wv2hKv+hhgdvUp6uyOUL7B921fedksCbNx6PXoblF2MZcO30MiyN/HT8XUQ51SKSIs8wdGp4r/gP3F8fl56e8uYAh5t0xM8FlDWLOl7ZPF4xz1Zu9qf+hUoTu2EEwM1adiVNlNCRXAh/AhoFmq+HD04+G0R+nJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V5zqG6GYhz1h4Hl;
	Sat, 30 Mar 2024 09:15:38 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 89076140134;
	Sat, 30 Mar 2024 09:18:20 +0800 (CST)
Received: from huawei.com (10.67.174.33) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Sat, 30 Mar
 2024 09:18:20 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
CC: <stable@vger.kernel.org>, Jon Ringle <jringle@gridpoint.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wang Weiyang
	<wangweiyang2@huawei.com>
Subject: [PATCH stable 5.10 5.15 v2] serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO
Date: Sat, 30 Mar 2024 09:25:20 +0800
Message-ID: <20240330012520.1904970-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100002.china.huawei.com (7.185.36.164)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit dbf4ab821804df071c8b566d9813083125e6d97b upstream.

The SC16IS7XX IC supports a burst mode to access the FIFOs where the
initial register address is sent ($00), followed by all the FIFO data
without having to resend the register address each time. In this mode, the
IC doesn't increment the register address for each R/W byte.

The regmap_raw_read() and regmap_raw_write() are functions which can
perform IO over multiple registers. They are currently used to read/write
from/to the FIFO, and although they operate correctly in this burst mode on
the SPI bus, they would corrupt the regmap cache if it was not disabled
manually. The reason is that when the R/W size is more than 1 byte, these
functions assume that the register address is incremented and handle the
cache accordingly.

Convert FIFO R/W functions to use the regmap _noinc_ versions in order to
remove the manual cache control which was a workaround when using the
_raw_ versions. FIFO registers are properly declared as volatile so
cache will not be used/updated for FIFO accesses.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc:  <stable@vger.kernel.org> # 5.10 5.15
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

v2: Backport to both 5.15 and 5.10

The mainline commit dbf4ab821804 ("serial: sc16is7xx: convert from _raw_
to _noinc_ regmap functions for FIFO") by Hugo has been assigned to be
CVE-2023-52488, but for stable branches lower than 6.1 there's no
official backport.

I made up this backport patch for 5.10, and its correctness has been
confirmed in previous communication with Hugo. Let's publicize it and
merge it into upstream.

 drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8c09c97f9814..0066a0e23516 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -376,9 +376,7 @@ static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 	const u8 line = sc16is7xx_line(port);
 	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
-	regcache_cache_bypass(s->regmap, false);
+	regmap_noinc_read(s->regmap, addr, s->buf, rxlen);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
@@ -394,9 +392,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regcache_cache_bypass(s->regmap, true);
-	regmap_raw_write(s->regmap, addr, s->buf, to_send);
-	regcache_cache_bypass(s->regmap, false);
+	regmap_noinc_write(s->regmap, addr, s->buf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -489,6 +485,11 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == SC16IS7XX_RHR_REG;
+}
+
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
@@ -1439,6 +1440,8 @@ static struct regmap_config regcfg = {
 	.cache_type = REGCACHE_RBTREE,
 	.volatile_reg = sc16is7xx_regmap_volatile,
 	.precious_reg = sc16is7xx_regmap_precious,
+	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
+	.readable_noinc_reg = sc16is7xx_regmap_noinc,
 };
 
 #ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-- 
2.25.1


