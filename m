Return-Path: <linux-kernel+bounces-126556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D789396D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A4F2820E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C71119B;
	Mon,  1 Apr 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LXEQ/YTk"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB39FBFD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963845; cv=none; b=tukhra438yOwSaKt9MrRVuj2ZWKK/n+xkMcpMPJ6Pm9m3106p9aKYewuOjf+2CsgfMv+d3fpZLbx3j57OLFOO5/6r9KaNkqb4SxmrSUjmwTpcluVZp2BPs9ImMvfhzxQDqY/PWpKjis7ksKLSd9rYj6fzOhF8fqA9p+I1Jc4HbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963845; c=relaxed/simple;
	bh=SR8T3+He2AZJICAKjsYDSLD9RIrMgUNik84zJm/zi7E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S5uoq9zgJi4Hh4krAuwGXHzVpZOSRtK6gCqxQOGTheAqiqSI03ksgd6enIZN9z71NWS9VeT1YnC3OuiJvHkgU2bhzLEIRXgjXO7fwjUxzd0FXydopcYe+7zOhhjs463m5LfNN8+6ZzZtuLGSwqla/g4huhpWZMymuwra4lIC0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LXEQ/YTk; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=YxqPnDDo14p23OJLtu
	fSJq/s7or8qzqTAqRYLxF+pYo=; b=LXEQ/YTkKXCjhQp9GfEWvXDSeKDU9SLmvF
	XqYVEHOjse0MQPAQCHohaA8G6O5XoUmQcHHmxVLRr6Fhc35iqhIrzKneJfjF6RoC
	TsKvDbMrpkFE1MSowweE8hJJzYZwc7Jym8kIbOuC/gieCk6Mxgx9OnapbQMd8ehQ
	bajZxTsL8=
Received: from localhost.localdomain (unknown [27.38.213.133])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDX_2+hfgpmG2w3Ag--.21976S2;
	Mon, 01 Apr 2024 17:30:10 +0800 (CST)
From: "fengchunguo@126.com" <fengchunguo@126.com>
To: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"chunguo.feng" <chunguo.feng@semidrive.com>
Subject: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
Date: Mon,  1 Apr 2024 17:30:01 +0800
Message-Id: <1711963801-184362-1-git-send-email-fengchunguo@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDX_2+hfgpmG2w3Ag--.21976S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry8AF43KrWfAw18Xry3XFb_yoW5Ar1xpF
	yYqr909FWkXF42ya1Dtr10qF4rXa12yFy7Gr97Gr1UK3W5KryUJF1xtFWSqFy7ArWYyr9r
	JF47t34j9a4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjiihUUUUU=
X-CM-SenderInfo: 5ihqwu5kxqw3br6rjloofrz/xtbBdQOzOmSdL3SMRQAAsU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "chunguo.feng" <chunguo.feng@semidrive.com>

if not disable uart irq before disable clk,  uart irq maybe triggered after
disabled clk immediately, then maybe cause irq storm.

Reproduced the below call trace, see i2c not be connected, but irq storm
was triggered.

i2c_designware 30b70000.i2c: controller timed out
CPU: 2 PID: 2932 Comm: gnss@1.0-servic 
Tainted: G O 5.14.61-00094-geaa0149416cc-dirty #8
Hardware name: Semidrive kunlun x9 REF Board (DT)
Call trace:
[<ffff00000808a3cc>] dump_backtrace+0x0/0x3c0
[<ffff00000808a7a0>] show_stack+0x14/0x1c
[<ffff000008cef43c>] dump_stack+0xc4/0xfc
[<ffff00000814eb80>] __report_bad_irq+0x50/0xe0
[<ffff00000814eaec>] note_interrupt+0x248/0x28c
[<ffff00000814c0e8>] handle_irq_event+0x78/0xa4
[<ffff00000814fcb8>] handle_fasteoi_irq+0xe4/0x1b4
[<ffff00000814b060>] __handle_domain_irq+0x7c/0xbc
[<ffff00000808176c>] gic_handle_irq+0x4c/0xb8
[<ffff000008083230>] el1_irq+0xb0/0x124
[<ffff000008d09f5c>] _raw_spin_unlock_irqrestore+0x10/0x44
[<ffff00000865b784>] dw8250_set_termios+0x48/0xf4
[<ffff0000086545a4>] serial8250_set_termios+0x14/0x28
[<ffff00000864c4f4>] uart_change_speed+0x38/0x10c
[<ffff00000864e458>] uart_set_termios+0xd0/0x17c
[<ffff000008630ad4>] tty_set_termios+0x160/0x1e4
[<ffff00000863165c>] set_termios+0x32c/0x3bc
[<ffff000008631248>] tty_mode_ioctl+0x6f0/0x7d8
[<ffff000008631a6c>] n_tty_ioctl_helper+0x10c/0x1e8
[<ffff00000862d2c4>] n_tty_ioctl+0x120/0x194
[<ffff00000862a724>] tty_ioctl+0x658/0xa34
[<ffff0000082a8f40>] do_vfs_ioctl+0x554/0x810
[<ffff0000082a9368>] SyS_ioctl+0x88/0x94
Exception stack(0xffff00000ccf3ec0 to 0xffff00000ccf4000

Signed-off-by: chunguo.feng <chunguo.feng@semidrive.com>
---
 drivers/tty/serial/8250/8250_dw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c1d43f0..133c24e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -359,6 +359,12 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0 && p->uartclk != rate) {
+		/*Need disable uart irq before disabled clk, because uart irq maybe triggered after
+		 * disabled clk immediately, then cause irq storm.
+		 */
+		if (p->irq)
+			disabled_irq(p->irq);
+
 		clk_disable_unprepare(d->clk);
 		/*
 		 * Note that any clock-notifer worker will block in
@@ -368,6 +374,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		if (!ret)
 			p->uartclk = rate;
 		clk_prepare_enable(d->clk);
+
+		if (p->irq)
+			enable_irq(p->irq);
 	}
 
 	dw8250_do_set_termios(p, termios, old);
-- 
2.7.4


