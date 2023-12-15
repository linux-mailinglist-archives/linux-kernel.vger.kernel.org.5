Return-Path: <linux-kernel+bounces-1674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA58151F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C50F1F24F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA85482C8;
	Fri, 15 Dec 2023 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pg46Y/S4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C282ED1;
	Fri, 15 Dec 2023 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B86DB1C0002;
	Fri, 15 Dec 2023 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702676103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G8zzYhmC6DYHseYf8Ri/+OsA2IXrTdinCtMzNuRSXhg=;
	b=Pg46Y/S4B8GHTRHJwe9qQ5AMOVmYXb+JxlbIbLjpx6ngNdHk15mz8K4XWyH8jd2urdtX7I
	gDZVOvsAscHeMgM0uShjn6GFSpTKzqU0so5dDxl9Z7lHudrvRMi2EgUEgEwqdcAdTnllsV
	ouV7C7CdzZe/2VhGHxkewK7LN5IQvP5br5qAvAnkLgWBOesAEpove9h6/KgD+SyuF6GEtg
	KA9dZsXYd7HZ7blhcPQ4SzjzzPID8byHjAB2OsvNTiGDIZrDq0juPUU9v+SRQl3jbs6VKt
	ODJAWHLygUvhl6h/2VyOSNmNzlE0LeUXKVs+71AXHzP9NVMQzRCzs9h3Nf9Yug==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Fri, 15 Dec 2023 22:34:24 +0100
Subject: [PATCH] pinctrl: at91-pio4: use dedicated lock class for IRQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAF/GfGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NT3Zz85OyU1IL48sSivMy8dF1LYzMTyyRjEzMLSyMloK6CotS0zAq
 widGxtbUA2W73QWEAAAA=
To: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

Trying to suspend to RAM on SAMA5D27 EVK leads to the following lockdep
warning:

 ============================================
 WARNING: possible recursive locking detected
 6.7.0-rc5-wt+ #532 Not tainted
 --------------------------------------------
 sh/92 is trying to acquire lock:
 c3cf306c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 but task is already holding lock:
 c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&irq_desc_lock_class);
   lock(&irq_desc_lock_class);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 6 locks held by sh/92:
  #0: c3aa0258 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0xd8/0x178
  #1: c4c2df44 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x138/0x284
  #2: c32684a0 (kn->active){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x148/0x284
  #3: c232b6d4 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0x13c/0x4e8
  #4: c387b088 (&dev->mutex){....}-{3:3}, at: __device_suspend+0x1e8/0x91c
  #5: c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 stack backtrace:
 CPU: 0 PID: 92 Comm: sh Not tainted 6.7.0-rc5-wt+ #532
 Hardware name: Atmel SAMA5
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x34/0x48
  dump_stack_lvl from __lock_acquire+0x19ec/0x3a0c
  __lock_acquire from lock_acquire.part.0+0x124/0x2d0
  lock_acquire.part.0 from _raw_spin_lock_irqsave+0x5c/0x78
  _raw_spin_lock_irqsave from __irq_get_desc_lock+0xe8/0x100
  __irq_get_desc_lock from irq_set_irq_wake+0xa8/0x204
  irq_set_irq_wake from atmel_gpio_irq_set_wake+0x58/0xb4
  atmel_gpio_irq_set_wake from irq_set_irq_wake+0x100/0x204
  irq_set_irq_wake from gpio_keys_suspend+0xec/0x2b8
  gpio_keys_suspend from dpm_run_callback+0xe4/0x248
  dpm_run_callback from __device_suspend+0x234/0x91c
  __device_suspend from dpm_suspend+0x224/0x43c
  dpm_suspend from dpm_suspend_start+0x9c/0xa8
  dpm_suspend_start from suspend_devices_and_enter+0x1e0/0xa84
  suspend_devices_and_enter from pm_suspend+0x460/0x4e8
  pm_suspend from state_store+0x78/0xe4
  state_store from kernfs_fop_write_iter+0x1a0/0x284
  kernfs_fop_write_iter from vfs_write+0x38c/0x6f4
  vfs_write from ksys_write+0xd8/0x178
  ksys_write from ret_fast_syscall+0x0/0x1c
 Exception stack(0xc52b3fa8 to 0xc52b3ff0)
 3fa0:                   00000004 005a0ae8 00000001 005a0ae8 00000004 00000001
 3fc0: 00000004 005a0ae8 00000001 00000004 00000004 b6c616c0 00000020 0059d190
 3fe0: 00000004 b6c61678 aec5a041 aebf1a26

This warning is raised because pinctrl-at91-pio4 uses chained IRQ. Whenever
a wake up source configures an IRQ through irq_set_irq_wake, it will
lock the corresponding IRQ desc, and then call irq_set_irq_wake on "parent"
IRQ which will do the same on its own IRQ desc, but since those two locks
share the same class, lockdep reports this as an issue.

Fix lockdep false positive by setting a different class for parent and
children IRQ

Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 383309e533c3..a27c01fcbb47 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1068,6 +1068,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
 	}
 };
 
+/*
+ * This lock class allows to tell lockdep that parent IRQ and children IRQ do
+ * not share the same class so it does not raise false positive
+ */
+static struct lock_class_key atmel_lock_key;
+static struct lock_class_key atmel_request_key;
+
 static int atmel_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1214,6 +1221,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);

---
base-commit: 1a756b6d03605c5a6acf68f6b74e6d56af52737f
change-id: 20231215-lockdep_warning-93649b346892

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


