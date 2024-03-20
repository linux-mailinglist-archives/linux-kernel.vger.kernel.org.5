Return-Path: <linux-kernel+bounces-108800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0488102D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996E6B247F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D8381D3;
	Wed, 20 Mar 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="STa7OF1W"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CB383A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931414; cv=none; b=o89QhW0APWTmb4B3L8ilV95nGdsDJywu0kx8bM4M0clVH0UQ7MMnY6morW0UksBJkWQC3Dwq4gKHqkY0WZCh1n43N8z3VQmL0UPYma9bV03S2H9d3M7xM+tDpBMmJOqiNFTy2VK7f3U42pvAl6kJWsCweBXsaUBpTtU1WkV4YVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931414; c=relaxed/simple;
	bh=7ZaU0uCh1hevP8SFs04y10m82esCnet9aRhHtaN9oRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsp/8tl0kSj5/qo6uVn3BDSuURKB8isQP35E7wHMKrmkLtFYkqGPqG4ZMun+1QpQWWN8BOMqLi7HRYuC8X2gh1LCsoVmLOOB9l/Di3u8X3zV4LjKW6zNBSKkRa4SIkAZjOt7Gjou6P8RAOi3Pg0N4SwLWU33mI3dzYmoORGvS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=STa7OF1W; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a450bedffdfso800938566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710931410; x=1711536210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOF4vrt0/prIYxG3jaGyuQuStDIiGYYeXFVk6eKYh6c=;
        b=STa7OF1WiPPLvMsU884Q+/YMoEejxvipZZluAUXEljnl/FNxZe+/D22kaAuSzRWVwE
         fmYZPnYyI8EChhuqf5oBWWAfLr2ANA17aLqu/L3fDV/ZNPEMyGzGwrVkdQa7LoTS5kKM
         Cu2At4DmvS4nejNnf61RQU60TpCXNLYd3XvsdcfGvX/+iX9cJ4m/RKetD+oIQZ75+elA
         2vlPXVyljR1f++AhD6vg+mOamM0WOs4QzfNjvraem4v+Nrjkg3Nk4VJhYySa4Bo2sL1t
         Fg2cLXGxGRvTIJX+C6ZPuQ6SjMCZBdXUXEUk4pg7xikx1Lfya+ud+4wkR2rU8LQYaMmi
         z+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931410; x=1711536210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOF4vrt0/prIYxG3jaGyuQuStDIiGYYeXFVk6eKYh6c=;
        b=BrlmuG1HAOCxyBIZDKcKJ3Q9cIaetkLFCU/FNy+ZILhnkSN0sTP8Audw9KIAdjtQxN
         xUL3vHIGr6Dcxa50Epg8PozRCvP4Gt7M+uxgu0IIwgWms7klcF/imGRcSpnhTv5EAEUR
         tAxaG6A4XEo3lHMPLlvRdq7dWnyeeeWxf++GyFyAuXb50HnnxEJrWhvEn5KsoXAhoodN
         /zQBElpfSTFZq7n5ZpgZ+BTJrFpYOxa86kd1z79DTpiB09m2CQo547z4R7wMWbfgj0P9
         JW+fQvGErLOMs+thDgSn8vGVqSIckEFZ5yKxlnIom2xPov8PExVJrOYuxq/nYnp4ooGW
         ANCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMHcBXayZiOuPlSTERb/qkWGPKxA4N3thseBuDzKwS1gyzus5LdHzfreK8fsgQuYwbX8NLN7q5TS8uIcc6x+8bySSHmLoTjvQE92hk
X-Gm-Message-State: AOJu0YzEVc1//e7a8sZPvEiJDKKiwvGuzKdt9fSiJRlKlVDMqqgqZ7qp
	Pc2HrrAAI0jzGplLDKBBKjmOsATSR5Ic7Zt1FNE/WXstVch5b9WTWZRbF74Tioc=
X-Google-Smtp-Source: AGHT+IHNA2arksT5JtyV2Y9LZgj04GJ8RSUiGG9tDMEg5rfwM9WxsKHeQgXvovHartHUSsEdtdMpSg==
X-Received: by 2002:a17:906:c042:b0:a46:cf3e:c68f with SMTP id bm2-20020a170906c04200b00a46cf3ec68fmr4208432ejb.49.1710931410110;
        Wed, 20 Mar 2024 03:43:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906289400b00a45ffe583acsm7092081ejd.187.2024.03.20.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:43:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	tglx@linutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 1/2] pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
Date: Wed, 20 Mar 2024 12:42:29 +0200
Message-Id: <20240320104230.446400-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index eb5a8c654260..93916553bcc7 100644
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
+			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
 			rzg2l_gpio_irq_enable(data);
+			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+		}
 	}
 }
 
-- 
2.39.2


