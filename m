Return-Path: <linux-kernel+bounces-95413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9007874D57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E591F25A83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EFE84FD0;
	Thu,  7 Mar 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JKD/walc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3B127B62
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810705; cv=none; b=EYxrARTg505/nOIhwSQnR2jaHIejKPO42ODRUngD+mowul54L/3/SMWvIul0UqYaEWeMuQyM4ZK62A/7o76IwQ+RtcDkgLRlwfSqnive29n62eE6z4faqutTF24gFsxXgCMDmU2EwEMXNJiAVW1VlsCAQ+SPLJW2ZIcUe/ocnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810705; c=relaxed/simple;
	bh=BA2bEb7FYXnJNzItE9FqQDauXUrW1+GLrZzotUpuJu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP/fipXf3oadDB/zrU1uPePwf0Sy4vD3QVaLb5lR6LjbbCfsNT+MO+XPPjHiEoCpxW8E8P/+iQE/R11rbXNiDH+BOH7+NfUVnEAWPIRAZggyV5LdWkubbA05fPnLTEOQtaZAJ7nBGNUly9q/kh45UwRwN8anKOWECVu6iRlhbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JKD/walc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a36126ee41eso105241166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709810701; x=1710415501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=840ydxtL4Z7hkmGQ5KnlY8fdo8pgA3pZwtE5eIoBkA4=;
        b=JKD/walcjVmIYiEWtL5mhv8xEGBwa+PYw/rrnu/A81tWm8JxYWOmMIerBFv15ghPH0
         tukxi7rVGvd/XRcXXyw6gkXt4dOLeF7OatDy5wc/Gr8rFSA2mB3R2ra60TccJqnpYM4H
         nbFy067EKymXg1qlIqA2EfIRTNKyAy0nMcGadMDiTbhevGRTAyrNa6F2BD8+YPg18jYV
         vfnkT2sQ9btLzWgU0VZvDr+Rs9g24S1rALJwC1Wxo3MOyLmoDfGxbSJl1mduihvEZcu4
         jefJtmeqDMaWvIyQqejgcooh8eaQYVaHSCBGTq+CyAF4vuvgpkrfT3CcHBGMFYKoB6qO
         9x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810701; x=1710415501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=840ydxtL4Z7hkmGQ5KnlY8fdo8pgA3pZwtE5eIoBkA4=;
        b=RneetpSHPqgc/fz3KjvWsUOR+2bQ8T2/6/RNqeKyF8FmAcAgWZ38E90F1B/vswhRQy
         HNqMasgs99OPXYzBGBuxoXfUUw4/fwFHzvsRlvBm+mmMlWGkJ1ghVjoXLiCA9yBm6V8E
         07An6kVIWxf4XPaqSEo3Hg/vGpAzljUv/JAo3quWLWHozXZo6d3xMtrt1jS4GZGCg7PD
         d+su69XiYGN1Tu0YbOcPmiX5yr/LcFr5rT7PK2DcBJYiac34F3EORHPTFADIm0xrMsqh
         8BJ08BieFQhIMjsu7UyTNj7tJwt2MPxRS/WmOjIXJP7SNjlFTfFwwRZ1EZao8y3dl24o
         Zaiw==
X-Forwarded-Encrypted: i=1; AJvYcCVobO4nH5/hra/7acENkMa2GSm7nYF1NaBO8138O9KboAhj9JAnBQG/bjtgWeOiO+WgwSFwtV+yTI+GYkqwykTjbMHYlh/EjOFVhocm
X-Gm-Message-State: AOJu0Yx9US/5l1ZKCp/rL/OFnuGSGmp3UBPjoJRGJrL/aY3UIwY9x7iv
	YaX2zXH9WxyfxHJluDGFyalm8pxUenCMDoqQnIWUwlaoSY5CLn+4K2J1yw/1wq0=
X-Google-Smtp-Source: AGHT+IFs+uBKrBgFQTw7SH9b6rMuIes8wFiFKwHhXFPk+T5XilLwXY35Q2PzQE9f9z2KnCuF3OBJ3g==
X-Received: by 2002:a17:906:6d14:b0:a45:27bd:e1ff with SMTP id m20-20020a1709066d1400b00a4527bde1ffmr8031301ejr.6.1709810700790;
        Thu, 07 Mar 2024 03:25:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906c41600b00a44e180b9a5sm5910296ejz.1.2024.03.07.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:25:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
Date: Thu,  7 Mar 2024 13:24:52 +0200
Message-Id: <20240307112452.74220-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Lockdep detects a possible deadlock as listed below. This is because it
detects the IA55 interrupt controller .irq_eoi() API is called from
interrupt context while configuration-specific API (e.g., .irq_enable())
could be called from process context on resume path (by calling
rzg2l_gpio_irq_restore()). To avoid this, protect the call of
rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore().
With this the same approach that is available in __setup_irq() is mimicked
to pinctrl IRQ resume function.

Below is the lockdep report:

 WARNING: inconsistent lock state
 6.8.0-rc5-next-20240219-arm64-renesas-00030-gb17a289abf1f #90 Not tainted
 --------------------------------
 inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 str_rwdt_t_001./159 [HC0[0]:SC0[0]:HE1:SE1] takes:
 ffff00000b001d70 (&rzg2l_irqc_data->lock){?...}-{2:2}, at: rzg2l_irqc_irq_enable+0x60/0xa4
 {IN-HARDIRQ-W} state was registered at:
 lock_acquire+0x1e0/0x310
 _raw_spin_lock+0x44/0x58
 rzg2l_irqc_eoi+0x2c/0x130
 irq_chip_eoi_parent+0x18/0x20
 rzg2l_gpio_irqc_eoi+0xc/0x14
 handle_fasteoi_irq+0x134/0x230
 generic_handle_domain_irq+0x28/0x3c
 gic_handle_irq+0x4c/0xbc
 call_on_irq_stack+0x24/0x34
 do_interrupt_handler+0x78/0x7c
 el1_interrupt+0x30/0x5c
 el1h_64_irq_handler+0x14/0x1c
 el1h_64_irq+0x64/0x68
 _raw_spin_unlock_irqrestore+0x34/0x70
 __setup_irq+0x4d4/0x6b8
 request_threaded_irq+0xe8/0x1a0
 request_any_context_irq+0x60/0xb8
 devm_request_any_context_irq+0x74/0x104
 gpio_keys_probe+0x374/0xb08
 platform_probe+0x64/0xcc
 really_probe+0x140/0x2ac
 __driver_probe_device+0x74/0x124
 driver_probe_device+0x3c/0x15c
 __driver_attach+0xec/0x1c4
 bus_for_each_dev+0x70/0xcc
 driver_attach+0x20/0x28
 bus_add_driver+0xdc/0x1d0
 driver_register+0x5c/0x118
 __platform_driver_register+0x24/0x2c
 gpio_keys_init+0x18/0x20
 do_one_initcall+0x70/0x290
 kernel_init_freeable+0x294/0x504
 kernel_init+0x20/0x1cc
 ret_from_fork+0x10/0x20
 irq event stamp: 69071
 hardirqs last enabled at (69071): [<ffff800080e0dafc>] _raw_spin_unlock_irqrestore+0x6c/0x70
 hardirqs last disabled at (69070): [<ffff800080e0cfec>] _raw_spin_lock_irqsave+0x7c/0x80
 softirqs last enabled at (67654): [<ffff800080010614>] __do_softirq+0x494/0x4dc
 softirqs last disabled at (67645): [<ffff800080015238>] ____do_softirq+0xc/0x14

 other info that might help us debug this:
 Possible unsafe locking scenario:

 CPU0
 ----
 lock(&rzg2l_irqc_data->lock);
 <Interrupt>
 lock(&rzg2l_irqc_data->lock);

 *** DEADLOCK ***

 4 locks held by str_rwdt_t_001./159:
 #0: ffff00000b10f3f0 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x1a4/0x35c
 #1: ffff00000e43ba88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xe8/0x1a8
 #2: ffff00000aa21dc8 (kn->active#40){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf0/0x1a8
 #3: ffff80008179d970 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0x9c/0x278

 stack backtrace:
 CPU: 0 PID: 159 Comm: str_rwdt_t_001. Not tainted 6.8.0-rc5-next-20240219-arm64-renesas-00030-gb17a289abf1f #90
 Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
 Call trace:
 dump_backtrace+0x94/0xe8
 show_stack+0x14/0x1c
 dump_stack_lvl+0x88/0xc4
 dump_stack+0x14/0x1c
 print_usage_bug.part.0+0x294/0x348
 mark_lock+0x6b0/0x948
 __lock_acquire+0x750/0x20b0
 lock_acquire+0x1e0/0x310
 _raw_spin_lock+0x44/0x58
 rzg2l_irqc_irq_enable+0x60/0xa4
 irq_chip_enable_parent+0x1c/0x34
 rzg2l_gpio_irq_enable+0xc4/0xd8
 rzg2l_pinctrl_resume_noirq+0x4cc/0x520
 pm_generic_resume_noirq+0x28/0x3c
 genpd_finish_resume+0xc0/0xdc
 genpd_resume_noirq+0x14/0x1c
 dpm_run_callback+0x34/0x90
 device_resume_noirq+0xa8/0x268
 dpm_noirq_resume_devices+0x13c/0x160
 dpm_resume_noirq+0xc/0x1c
 suspend_devices_and_enter+0x2c8/0x570
 pm_suspend+0x1ac/0x278
 state_store+0x88/0x124
 kobj_attr_store+0x14/0x24
 sysfs_kf_write+0x48/0x6c
 kernfs_fop_write_iter+0x118/0x1a8
 vfs_write+0x270/0x35c
 ksys_write+0x64/0xec
 __arm64_sys_write+0x18/0x20
 invoke_syscall+0x44/0x108
 el0_svc_common.constprop.0+0xb4/0xd4
 do_el0_svc+0x18/0x20
 el0_svc+0x3c/0xb8
 el0t_64_sync_handler+0xb8/0xbc
 el0t_64_sync+0x14c/0x150

Fixes: 254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index eb5a8c654260..76124b860c3f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2063,8 +2063,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 			continue;
 		}
 
-		if (!irqd_irq_disabled(data))
+		if (!irqd_irq_disabled(data)) {
+			unsigned long flags;
+
+			/*
+			 * This has to be atomically executed to protect against a concurrent
+			 * interrupt.
+			 */
+			spin_lock_irqsave(&pctrl->lock, flags);
 			rzg2l_gpio_irq_enable(data);
+			spin_unlock_irqrestore(&pctrl->lock, flags);
+		}
 	}
 }
 
-- 
2.39.2


